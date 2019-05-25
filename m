Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B60C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927CF217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558760422;
	bh=mIXbDXcQPMJSc4UESXKNywctOSB6Moa7tm6Jt46hGR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0+vkYDs5RIZ08twtrc2lzz2s+EH6K7+ZbbOKaGrv+kI9eU+AqOMi1wNnsobpiC6E
	 RCU9AL6MgtgLKDrOBB3ZaXbtTEysTv6QM2lCzg+9FoZ018eEs5wiZVnvaW32mB0fTo
	 5fntuLvni0UpvIsF+7ibWfBs5jyhjZ92wyZMkLmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEYFAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfEYFAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1488B2177E;
        Sat, 25 May 2019 05:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558760420;
        bh=mIXbDXcQPMJSc4UESXKNywctOSB6Moa7tm6Jt46hGR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00FgJh01/Thls1CggdEZBj8yQBkONkK7KKarlpioeuDiFOyer6WSHGtYbOSnyrJ60
         tHdAcyGob9MFtufyHhv2JzLmHzs4vgpLTUtssIJEZ39/jF1EUOI8wN9wbtFPPR0FaK
         DQE+bvaZ6bUXPRsbh2hnM2kBUCyZPQi+EfUR64ok=
Date:   Sat, 25 May 2019 07:00:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: add missing dependencies for
 kpc2000
Message-ID: <20190525050017.GA18684@kroah.com>
References: <20190524203058.30022-1-simon@nikanor.nu>
 <20190524203058.30022-3-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524203058.30022-3-simon@nikanor.nu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:30:58PM +0200, Simon Sandström wrote:
> Fixes build errors:
> 
> ERROR: "mfd_remove_devices" [kpc2000.ko] undefined!
> ERROR: "uio_unregister_device" [kpc2000.ko] undefined!
> ERROR: "mfd_add_devices" [kpc2000.ko] undefined!
> ERROR: "__uio_register_device" [kpc2000.ko] undefined!
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
> index c463d232f2b4..5188b56123ab 100644
> --- a/drivers/staging/kpc2000/Kconfig
> +++ b/drivers/staging/kpc2000/Kconfig
> @@ -3,6 +3,8 @@
>  config KPC2000
>  	bool "Daktronics KPC Device support"
>  	depends on PCI
> +	select MFD_CORE
> +	select UIO
>  	help
>  	  Select this if you wish to use the Daktronics KPC PCI devices
>  

This is already in linux-next (in a different form), are you sure you
are working against the latest kernel tree?

thanks,

greg k-h
