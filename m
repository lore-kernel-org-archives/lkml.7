Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A17C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51571208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556371855;
	bh=Lh9s0O0+A8sPU7fyQWvhROtRxYQ2VDabkJlyUvL7sek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGfM9Gg1Ju77hVRzCa6ulCq4e1KYqLu/lSGOdMaHZQiz+EnNPMqMVwWBJWkz08azD
	 O9SFoheM+nyQpqTGBgRp5L4Ihz/MXDNywBRZcVaK73q9MK3zSGMFrJeadz1mQamQS6
	 ZFtzdX1PN4TYb5jRyfbO/HT/Wfodv4OyJRNbkL18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfD0Nay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfD0Nax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:30:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4682087F;
        Sat, 27 Apr 2019 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556371852;
        bh=Lh9s0O0+A8sPU7fyQWvhROtRxYQ2VDabkJlyUvL7sek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE/IsNN+OoggOL0lqnbBMENjYjQMHUlg6MzRjzd1wN8UG2ch8tWXwwllPaD6PTYFn
         mCF1UqTTSxvOfCSi55yzLfekiXXAcF44HsZlZXG4txLN8xZgDjNdx2St37NOCVhQjx
         TD6zDEh5JrUi3h2KNNgGkeyXD0aOAtKHV/ga5/ng=
Date:   Sat, 27 Apr 2019 15:30:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 05/41] drivers: tty: serial: dz: use pr_info() instead of
 incomplete printk()
Message-ID: <20190427133050.GB11368@kroah.com>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-6-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556369542-13247-6-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:51:46PM +0200, Enrico Weigelt, metux IT consult wrote:
> Fix the checkpatch warning:
> 
>     WARNING: printk() should include KERN_<LEVEL> facility level
>     #934: FILE: dz.c:934:
>     +	printk("%s%s\n", dz_name, dz_version);
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/tty/serial/dz.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
> index 559d076..e2670c4 100644
> --- a/drivers/tty/serial/dz.c
> +++ b/drivers/tty/serial/dz.c
> @@ -931,7 +931,7 @@ static int __init dz_init(void)
>  	if (IOASIC)
>  		return -ENXIO;
>  
> -	printk("%s%s\n", dz_name, dz_version);
> +	pr_info("%s%s\n", dz_name, dz_version);

Just drop this line, it's not needed and generally just noise.

thanks,

greg k-h
