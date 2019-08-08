Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B984C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF095214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404389AbfHHT4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:56:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390201AbfHHT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:56:22 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvoWJ-00079W-LP; Thu, 08 Aug 2019 21:56:19 +0200
Date:   Thu, 8 Aug 2019 21:56:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ben Luo <luoben@linux.alibaba.com>
cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com
Subject: Re: [PATCH 1/2] genirq: introduce update_irq_devid()
In-Reply-To: <39a5009c77d07c3ce42ef784465c05e36d5f684d.1565263723.git.luoben@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1908082138410.2882@nanos.tec.linutronix.de>
References: <cover.1565263723.git.luoben@linux.alibaba.com> <39a5009c77d07c3ce42ef784465c05e36d5f684d.1565263723.git.luoben@linux.alibaba.com>
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

On Thu, 8 Aug 2019, Ben Luo wrote:
> +int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	struct irqaction *action, **action_ptr;
> +	unsigned long flags;
> +
> +	WARN(in_interrupt(),
> +			"Trying to update IRQ %d from IRQ context!\n", irq);

This is broken. The function needs to return on that condition. Actually it
cannot even be called from non-preemptible code.

What's worse is that if the interrupt in question is handled concurrently,
then it will either see the old or the new dev_id and because the interrupt
handler loop runs with desc->lock dropped even more crap can happen because
dev_id can be subject to load and store tearing.

Staring at that, I see that there is the same issue in setup_irq() and
free_irq(). It's actually worse there. I'll have a look.

> +	/*
> +	 * There can be multiple actions per IRQ descriptor, find the right
> +	 * one based on the dev_id:
> +	 */
> +	action_ptr = &desc->action;
> +	for (;;) {
> +		action = *action_ptr;
> +
> +		if (!action) {
> +			WARN(1, "Trying to update already-free IRQ %d\n", irq);

That's wrong in two aspects:

       1) The warn should be outside of the locked region.

       2) Just having the irq number is not useful for debugging either
       	  when the interrupt is shared.

> +			raw_spin_unlock_irqrestore(&desc->lock, flags);
> +			chip_bus_sync_unlock(desc);
> +			return -ENXIO;
> +		}
> +
> +		if (action->dev_id == dev_id) {
> +			action->dev_id = new_dev_id;
> +			break;
> +		}
> +		action_ptr = &action->next;
> +	}
> +
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +	chip_bus_sync_unlock(desc);
> +
> +	/*
> +	 * Make sure it's not being used on another CPU:
> +	 * There is a risk of UAF for old *dev_id, if it is
> +	 * freed in a short time after this func returns
> +	 */
> +	synchronize_irq(irq);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(update_irq_devid);

EXPORT_SYMBOL_GPL() please.

Thanks,

	tglx
