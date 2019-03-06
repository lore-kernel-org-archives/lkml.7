Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76F120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfCFSRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:17:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfCFSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:17:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBC21144E3E12;
        Wed,  6 Mar 2019 10:17:41 -0800 (PST)
Date:   Wed, 06 Mar 2019 10:17:39 -0800 (PST)
Message-Id: <20190306.101739.246616987743523058.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] appletalk: Correctly handle return value of
 register_snap_client
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306072740.18760-1-yuehaibing@huawei.com>
References: <20190306072740.18760-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 10:17:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 6 Mar 2019 15:27:40 +0800

> @@ -879,15 +879,17 @@ static struct notifier_block aarp_notifier = {
>  
>  static unsigned char aarp_snap_id[] = { 0x00, 0x00, 0x00, 0x80, 0xF3 };
>  
> -void __init aarp_proto_init(void)
> +int __init aarp_proto_init(void)
>  {
>  	aarp_dl = register_snap_client(aarp_snap_id, aarp_rcv);
> -	if (!aarp_dl)
> -		printk(KERN_CRIT "Unable to register AARP with SNAP.\n");
> +	if (!aarp_dl) {
> +		pr_crit("Unable to register AARP with SNAP.\n");
> +		return -ENOMEM;
> +	}
>  	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
>  	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
>  	add_timer(&aarp_timer);
> -	register_netdevice_notifier(&aarp_notifier);
> +	return register_netdevice_notifier(&aarp_notifier);
>  }
>  

Your error paths in the caller of aarp_proto_init() do not handle the case
where aarp_dl is created by register_netdevice_notifier() fails.  You have
to unregister aarp_dl if it is non-NULL.

So your out_dev label path needs to handle aarp_dl if non-NULL.

Probably best is to jump to out_aarp: instead and make aarp_cleanup_module
able to handle partial cleanups.
