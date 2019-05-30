Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AB823F9B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559253444;
	bh=KPLvi7aKrEe9JKGxQxgytaIYXMiDco5OH8C4sQ4Vb9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLF43as3l4BTVFz7sAtjLB9aayrCDZIb2YIlsSk5sXe2Knv8MVUtlB5Vg+B1NuPTd
	 eNFdUAwU+dVd+xpy+yNIWTkMMa0YDwB69y4MvHopljW274u8bOS54fAasaplbi+D7L
	 G0kwe5l9aPiK9LuTfprfnNkLVe12OkSvMsNdRi/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE3V5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfE3V5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:57:22 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2FA261B4;
        Thu, 30 May 2019 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559251190;
        bh=KPLvi7aKrEe9JKGxQxgytaIYXMiDco5OH8C4sQ4Vb9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R65oNxcK4J9aIWqT2wTj2zbnoMZaRELxeBGWkFrsU0iypHtacW3ti88aMrtNBVxGO
         hy8BYGtkTTvW3DLjhP98FfllwefSPAVHzcuvYfF0P1JAshmqk749cpUWw9vfud2IxL
         hjLCn9gIYRXLk8dFWVZS2Hcx3FbKGj5NDFdoWE3A=
Date:   Thu, 30 May 2019 14:19:50 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: Fix build failure caused by wrong
 include file
Message-ID: <20190530211950.GA17581@kroah.com>
References: <1559216022-644-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559216022-644-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:33:42AM -0700, Guenter Roeck wrote:
> xtensa:allmodconfig fails to build.
> 
> arch/xtensa/include/asm/uaccess.h: In function 'clear_user':
> arch/xtensa/include/asm/uaccess.h:40:22: error:
> 	implicit declaration of function 'uaccess_kernel'
> 
> uaccess_kernel() is declared in linux/uaccess.h, not asm/uaccess.h.
> 
> Fixes: 7df95299b94a ("staging: kpc2000: Add DMA driver")
> Cc: Matt Sickler <Matt.Sickler@daktronics.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 5741d2b49a7d..e741fa753ca1 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -8,7 +8,7 @@
>  #include <linux/errno.h>    /* error codes */
>  #include <linux/types.h>    /* size_t */
>  #include <linux/cdev.h>
> -#include <asm/uaccess.h>    /* copy_*_user */
> +#include <linux/uaccess.h>    /* copy_*_user */
>  #include <linux/aio.h>      /* aio stuff */
>  #include <linux/highmem.h>
>  #include <linux/pagemap.h>

Already fixed by e00839f38823 ("staging: kpc2000: fix build error on
xtensa") in my staging-linus branch.

thanks,

greg k-h
