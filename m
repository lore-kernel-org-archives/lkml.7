Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C1C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BC920578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfHOQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:45:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfHOQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:45:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyIsS-0001TI-7S; Thu, 15 Aug 2019 18:45:28 +0200
Date:   Thu, 15 Aug 2019 18:45:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ben Luo <luoben@linux.alibaba.com>
cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 3/3] vfio_pci: make use of update_irq_devid and optimize
 irq ops
In-Reply-To: <f8838cf037055351d677e628f169cb21c6a76f02.1565857737.git.luoben@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1908151833010.1908@nanos.tec.linutronix.de>
References: <cover.1565857737.git.luoben@linux.alibaba.com> <f8838cf037055351d677e628f169cb21c6a76f02.1565857737.git.luoben@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, Ben Luo wrote:
>  	if (vdev->ctx[vector].trigger) {
> -		free_irq(irq, vdev->ctx[vector].trigger);
> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
> -		vdev->ctx[vector].trigger = NULL;
> +		if (vdev->ctx[vector].trigger == trigger) {
> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);

What's the point of unregistering the producer, just to register it again below?

> +		} else if (trigger) {
> +			ret = update_irq_devid(irq,
> +					vdev->ctx[vector].trigger, trigger);
> +			if (unlikely(ret)) {
> +				dev_info(&pdev->dev,
> +					 "update_irq_devid %d (token %p) fails: %d\n",

s/fails/failed/

> +					 irq, vdev->ctx[vector].trigger, ret);
> +				eventfd_ctx_put(trigger);
> +				return ret;
> +			}

This lacks any form of comment why this is correct. dev_id is updated and
the producer with the old token is still registered.

> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);

Now it's unregistered.

> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
> +			vdev->ctx[vector].producer.token = trigger;

The token is updated and then it's newly registered below.

> +			vdev->ctx[vector].trigger = trigger;
> -	vdev->ctx[vector].producer.token = trigger;
> -	vdev->ctx[vector].producer.irq = irq;
> +	/* always update irte for posted mode */
>  	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>  	if (unlikely(ret))
>  		dev_info(&pdev->dev,
>  		"irq bypass producer (token %p) registration fails: %d\n",
>  		vdev->ctx[vector].producer.token, ret);

I know this code already existed, but again this looks inconsistent. If the
registration fails then a subsequent update will try to unregister a not
registered producer. Does not make any sense to me.

Thanks,

	tglx
