Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFAC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335DE2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557999597;
	bh=XseRSXpDbeN8fAIe7eoYSxHDQql0gFlqyNNJpUwaeOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wml4wCZ3tleiKArefrwtCCUGInqsCfLhCIyqs99udpUWvdcDfi0h1XGl2UYBQfbrR
	 UYCDlSaF6goE0S1X5gq10T+1rD5maRp2DAVdoxvNTX4bFkZbpbiaWqf8E0peZg1ct5
	 s/XmhPaqhR8YHryfqBzAqjtN0GyzeoQkNI0YVQvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEPJj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfEPJjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:39:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7A92082E;
        Thu, 16 May 2019 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557999594;
        bh=XseRSXpDbeN8fAIe7eoYSxHDQql0gFlqyNNJpUwaeOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNZB0M0EKrZSwi17NFMQMlL6OnOZ5ELBxdqD2H00WEgVTEYdY3NI8/z4ILSyr/GdD
         mOVU3LCrUJdLit9ZSp9MUOmsBYDz8nvACjNZOID/NQiD8EIePzPzLqYQOLCTDHeJg9
         xWB9gt4tjz62y6Vl0g+6vlS8xeX2UcSP0rFj6udI=
Date:   Thu, 16 May 2019 11:39:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Forest Bond <forest@alittletooquiet.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: remove unused variable
Message-ID: <20190516093951.GA19798@kroah.com>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:31:05AM +0000, Quentin Deslandes wrote:
> Fixed 'set but not used' warning message on a status variable. The
> called function returning the status code 'vnt_start_interrupt_urb()'
> clean up after itself and the caller function
> 'vnt_int_start_interrupt()' does not returns any value.
> 
> Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> ---
>  drivers/staging/vt6656/int.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.c
> index 504424b19fcf..ac30ce72db5a 100644
> --- a/drivers/staging/vt6656/int.c
> +++ b/drivers/staging/vt6656/int.c
> @@ -42,13 +42,12 @@ static const u8 fallback_rate1[5][5] = {
>  void vnt_int_start_interrupt(struct vnt_private *priv)
>  {
>  	unsigned long flags;
> -	int status;
>  
>  	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	status = vnt_start_interrupt_urb(priv);
> +	vnt_start_interrupt_urb(priv);

Shouldn't you fix this by erroring out if this fails?  Why ignore the
errors?

thanks,

greg k-h
