Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF47C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C357204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556548282;
	bh=iLPez6aL8Qyb4FMaCswXFWPVTnFlnE/oSNnuMiusZB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LyMdD1lBG0qfUbg4rq31iTcmLzkBBHvUGDg0nC2iwiLNKsHuZvlpiz1WABqZ7SP86
	 Bk26qkkb4fd7DFISEP76D5u3b7oqUzt878cMIvuPp804lwfxMp1Fx2Ce5PdItnvyB+
	 U/KAtAqb3h28DeWXDDRgtNg6zwj+RlKIhoP/gQbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfD2ObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfD2ObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:31:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870AC204EC;
        Mon, 29 Apr 2019 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556548280;
        bh=iLPez6aL8Qyb4FMaCswXFWPVTnFlnE/oSNnuMiusZB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4bMJc7ag8MpYvn57/m2S5y0Q8O5lsawtizPxZkUSNyCiLkF0MmPFrZp55p3Q301B
         XXqYsCi7QTvlWXkWGC40bJfEnUzT/mXJZF75f4vTMXFwVOV4oXNomKan/9NVFAHEae
         TJZN07cELsPpKYxpHNxPCy1IT+thHuIo15VCdDcU=
Date:   Mon, 29 Apr 2019 16:31:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: 8250: Fix type field in format string
Message-ID: <20190429143117.GA1474@kroah.com>
References: <20190427091943.GA3810@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427091943.GA3810@haolee.io>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 05:19:43PM +0800, Hao Lee wrote:
> The dev_dbg statement should print the value of uart.port.mapbase instead
> of its address. Besides that, uart.port.irq and uart.port.iotype are all
> unsigned types, so using %u is more appropriate.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pnp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
> index 431e69a5a6a0..9dea11baf479 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -462,8 +462,8 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  		return -ENODEV;
>  
>  	dev_dbg(&dev->dev,
> -		 "Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
> -		 uart.port.iobase, &uart.port.mapbase,
> +		 "Setup PNP port: port %#lx, mem %#lx, irq %u, type %u\n",
> +		 uart.port.iobase, uart.port.mapbase,
>  		 uart.port.irq, uart.port.iotype);
>  
>  	if (flags & CIR_PORT) {
> -- 
> 2.14.5

This causes build warnings when applied, I'm having to drop it now.

Please be more careful, when submitting patches, always test-build them
first.

greg k-h
