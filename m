Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F94C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F86121874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCVKa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:30:58 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51911 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:30:57 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5EB5520008;
        Fri, 22 Mar 2019 10:30:54 +0000 (UTC)
Message-ID: <14f34f5ce32ca4943aec42e32878d6dcc7ea5524.camel@bootlin.com>
Subject: Re: [PATCH 1/7] drm: Add a helper function for printing a
 debugfs_regset32.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Fri, 22 Mar 2019 11:30:53 +0100
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 20 février 2019 à 13:03 -0800, Eric Anholt a écrit :
> The debugfs_regset32 is nice to use for reducing boilerplate in
> dumping a bunch of regs in debugfs, but we also want to be able to
> print to dmesg them at runtime for driver debugging.  drm_printer lets
> us format debugfs and the printk the same way.

Looks good to me!

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/drm_print.c | 16 ++++++++++++++++
>  include/drm/drm_print.h     |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 0e7fc3e7dfb4..5ecc0f04cd0c 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -253,3 +253,19 @@ void drm_err(const char *format, ...)
>  	va_end(args);
>  }
>  EXPORT_SYMBOL(drm_err);
> +
> +void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset)
> +{
> +	int namelen = 0;
> +	int i;
> +
> +	for (i = 0; i < regset->nregs; i++)
> +		namelen = max(namelen, (int)strlen(regset->regs[i].name));
> +
> +	for (i = 0; i < regset->nregs; i++) {
> +		drm_printf(p, "%*s = 0x%08x\n",
> +			   namelen, regset->regs[i].name,
> +			   readl(regset->base + regset->regs[i].offset));
> +	}
> +}
> +EXPORT_SYMBOL(drm_print_regset32);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index afbc3beef089..3a4247319e63 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -30,6 +30,7 @@
>  #include <linux/printk.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
> +#include <linux/debugfs.h>
>  
>  /**
>   * DOC: print
> @@ -84,6 +85,7 @@ void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf);
>  __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
> +void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
>  
>  __printf(2, 0)
>  /**
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

