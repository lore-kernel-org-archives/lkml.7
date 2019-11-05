Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356CCC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CAE21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572969034;
	bh=0Wqzj5saWGFQPcHScriQ0P5BJ17JeJjwaDDE8C9MBUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqtntFfElKSQn1/1jEbqbtbd0M+kv9i/LWpdq47nupsDhjc8UmqMy19vqzu54tAxF
	 jtYj+5XlrpNd/ENQyHEKt+p5hSHXabklYUIVZ5T6xQbLErwkiO63PqUMfXAZOIBcqO
	 o5bY8yoXo2xYq0svqb2dAjJOcoXjb+DLFJHWAy8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfKEPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389571AbfKEPuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:50:32 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4423E217F5;
        Tue,  5 Nov 2019 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572969032;
        bh=0Wqzj5saWGFQPcHScriQ0P5BJ17JeJjwaDDE8C9MBUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw6RcLyVKDqZHREc1LJoj5D99aRFj5tS/8E3bHXUhXcKbtYJGENJOIzd5iZtYohGz
         Dml2XWiVgjGGBUno9CecWRRK6ZlG4hkdovBT2hIWYEBPS4fY9Lrr3vWzKkY0ltWlVU
         v3/rkQc3kviutnrDR1pINh8O9crNybecRgd7Kng4=
Date:   Tue, 5 Nov 2019 16:50:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        perex@perex.cz, kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, joe@perches.com
Subject: Re: [PATCH v2] hp100: remove set but not used variable val
Message-ID: <20191105155024.GA2677365@kroah.com>
References: <20191105133554.6C01F9A06CB85816F399@huawei.com>
 <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572964619-76671-1-git-send-email-chenwandun@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:36:59PM +0800, Chen Wandun wrote:
> From: Chenwandun <chenwandun@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/hp/hp100.c: In function hp100_start_xmit:
> drivers/staging/hp/hp100.c:1629:10: warning: variable val set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chenwandun <chenwandun@huawei.com>

I need a "full" name here, like the one on your email "From:" line.

> ---
>  drivers/staging/hp/hp100.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/hp/hp100.c b/drivers/staging/hp/hp100.c
> index 6ec78f5..6fc7733 100644
> --- a/drivers/staging/hp/hp100.c
> +++ b/drivers/staging/hp/hp100.c
> @@ -1626,7 +1626,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
>  	unsigned long flags;
>  	int i, ok_flag;
>  	int ioaddr = dev->base_addr;
> +#ifdef HP100_DEBUG_TX
>  	u_short val;
> +#endif

#ifdefs are not ok in .c code, sorry.

>  	struct hp100_private *lp = netdev_priv(dev);
>  
>  #ifdef HP100_DEBUG_B
> @@ -1695,7 +1697,9 @@ static netdev_tx_t hp100_start_xmit(struct sk_buff *skb,
>  
>  	spin_lock_irqsave(&lp->lock, flags);
>  	hp100_ints_off();
> +#ifdef HP100_DEBUG_TX
>  	val = hp100_inw(IRQ_STATUS);

Are you sure that this doesn't actually change the hardware in some way?

thanks,

greg k-h
