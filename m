Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B0AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 04:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0421A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 04:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570767973;
	bh=fLiBWE1AVc2vUnCDGC3rnCQZQF7qVTkQq7Q21C84Zlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPzY5xuXj/nK5Ny94h4SHn3qDsfPe48jeNcmeNdHl0g64Eu53FJo63k4HTHMxMQNM
	 sGfPWth2hbaldGkQWHvvoiXZ27QZtM+qo2vAHGEvSqUONaWJEFxLZHiv4syIOwJQr8
	 i9kjVrQGlr5XCWWxPJu7coHW+4xEMxYVKaBfv8LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJKE0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 00:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJKE0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 00:26:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B412089F;
        Fri, 11 Oct 2019 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570767971;
        bh=fLiBWE1AVc2vUnCDGC3rnCQZQF7qVTkQq7Q21C84Zlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQ6aVrxkEqC6BdoJ9p8nXAqQQzWCiL0yOUAQeFLNMMuz4r2WpwTy60CZDaQ3NraAl
         HLMSy4qCboDujx+wdD52j5aHnH1R3oVK+W2kqQ7QIfgKRox0cMPYLpf60CZ4efPkyj
         obpXc5i1c9XrEnDV4HIOjrNn5sH8Ji4ZLBXZX+vE=
Date:   Fri, 11 Oct 2019 06:26:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: fix an undefined reference error when
 CONFIG_MMC=m
Message-ID: <20191011042609.GB938845@kroah.com>
References: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:02:19AM +0800, zhong jiang wrote:
> I hit the following error when compile the kernel.
> 
> drivers/staging/wfx/main.o: In function `wfx_core_init':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/wfx/Kconfig  | 3 ++-
>  drivers/staging/wfx/Makefile | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
> index 9b8a1c7..4d045513 100644
> --- a/drivers/staging/wfx/Kconfig
> +++ b/drivers/staging/wfx/Kconfig
> @@ -1,7 +1,8 @@
>  config WFX
>  	tristate "Silicon Labs wireless chips WF200 and further"
>  	depends on MAC80211
> -	depends on (SPI || MMC)
> +	depends on SPI
> +	select MMC

How about:
	depends on (SPI && MMC)

instead?

thanks,

greg k-h
