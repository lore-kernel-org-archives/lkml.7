Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2739C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7D220850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dxZ0vYI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDNSvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:51:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDNSvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:51:52 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4129B1EC014A;
        Sun, 14 Apr 2019 20:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555267910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zv3epOjnjM7RClZgcxdZymwoDNXr8LwKnIQ4Vp/3izY=;
        b=dxZ0vYI5u7PIm5fS957xxVmCLEdJtx/Pj0cC/+0B950mwUOGh0LZQeeibR8ZpgcEYmH0ZP
        UNIFtH3Rwsd5ULK2njZPOGZiLoDkxUgdQtw1PETL72qU94l37xOnf74E9JUvLrPgiPCUHk
        m6FBWaKswuNYpi+ajhIB97XMVR89y/o=
Date:   Sun, 14 Apr 2019 20:49:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCHv1] drivers: edac: This patch fix the following
 checkpatch warning.
Message-ID: <20190414184934.GB569@zn.tnic>
References: <1555267310-21510-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555267310-21510-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 09:41:50PM +0300, Mohan Kumar wrote:
> Use pr_warn instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
>         then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Please read this here first on what to put in your patch title and commit
message:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/edac/x38_edac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
> index cc779f3..4c855c0 100644
> --- a/drivers/edac/x38_edac.c
> +++ b/drivers/edac/x38_edac.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
>  #include <linux/edac.h>
> +#include <linux/netdevice.h>
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include "edac_module.h"
> @@ -260,7 +261,7 @@ static void __iomem *x38_map_mchbar(struct pci_dev *pdev)
>  	u.mchbar &= X38_MCHBAR_MASK;
>  
>  	if (u.mchbar != (resource_size_t)u.mchbar) {
> -		printk(KERN_ERR
> +		pr_err(
>  			"x38: mmio space beyond accessible range (0x%llx)\n",

Put those two on a single line so that you don't have an ugly linebreak
like that.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
