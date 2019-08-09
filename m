Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5864DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FA821743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565355414;
	bh=bGD8aEP4a64R/eBVC495DgtcJcfd4ZnnlriZrZK79Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zYkeSKEAmmjtURPdd5AaiZ0cRqrg1FTqz2RzgiC0GofyiT+us214EW2tqzCHvbelu
	 9Wvq/ZRVFzO07fFo6d3p/1WKUu6o7sly1pQzovmZNUGZKZMpD+HTxEwunCyJEh31Oh
	 JDrNapQXcnLhMHaouNt8Sgbxobdg+hHJjwYFg2NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406953AbfHIM4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406563AbfHIM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:56:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4986720B7C;
        Fri,  9 Aug 2019 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565355411;
        bh=bGD8aEP4a64R/eBVC495DgtcJcfd4ZnnlriZrZK79Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux8v/VdR2h69DjRbe8tj7TUsxRePrHFrq+HMokZcYj7W6xxGOkp6olVTYKRP2bl6l
         kgewB1RUyhSfGj30WTAcDlv/PDAuyAj5V81Si2/F9TAXe6CLgJ3+XhZ1OYqbbVgJP/
         lIw+bpHXQH72GcuoxdcPRR189Qwdf7HB1qg+yV3s=
Date:   Fri, 9 Aug 2019 14:56:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ard.biesheuvel@linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wusbcore: Fix build error without CONFIG_USB
Message-ID: <20190809125649.GA2531@kroah.com>
References: <20190809102150.66896-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809102150.66896-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 06:21:50PM +0800, YueHaibing wrote:
> USB_WUSB should depends on CONFIG_USB, otherwise building fails
> 
> drivers/staging/wusbcore/wusbhc.o: In function `wusbhc_giveback_urb':
> wusbhc.c:(.text+0xa28): undefined reference to `usb_hcd_giveback_urb'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 71ed79b0e4be ("USB: Move wusbcore and UWB to staging as it is obsolete")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/wusbcore/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wusbcore/Kconfig b/drivers/staging/wusbcore/Kconfig
> index 056c60b..a559d02 100644
> --- a/drivers/staging/wusbcore/Kconfig
> +++ b/drivers/staging/wusbcore/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config USB_WUSB
>  	tristate "Enable Wireless USB extensions"
> -	depends on UWB
> +	depends on UWB && USB
>  	select CRYPTO
>  	select CRYPTO_AES
>  	select CRYPTO_CCM
> -- 
> 2.7.4

Ah, good catch, sorry about that!

greg k-h
