Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5150BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF102082C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfIIQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:39:43 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:54836 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729421AbfIIQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:39:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 35AB5181D341F;
        Mon,  9 Sep 2019 16:39:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tent99_1a341b076e050
X-Filterd-Recvd-Size: 2865
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 16:39:39 +0000 (UTC)
Message-ID: <7d870b0119afa378dc68c710670b9b550ef5bdd4.camel@perches.com>
Subject: Re: [Patch 10/13] media: am437x-vpfe: Remove print_fourcc helper
From:   Joe Perches <joe@perches.com>
To:     Benoit Parrot <bparrot@ti.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 09:39:37 -0700
In-Reply-To: <20190909162743.30114-11-bparrot@ti.com>
References: <20190909162743.30114-1-bparrot@ti.com>
         <20190909162743.30114-11-bparrot@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 11:27 -0500, Benoit Parrot wrote:
> print_fourcc helper function was used for debug log the
> convert a pixel format code into its readable form for display
> purposes. But since it used a single static buffer to perform
> the conversion this might lead to display format issue when more
> than one instance was invoked simultaneously.
> 
> It turns out that print_fourcc can be safely replace by using
> "%4.4s" instead and casting the pointer to the fourcc code
> into a (char *).
[]
> diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
[]
> @@ -221,20 +221,6 @@ static void pix_to_mbus(struct vpfe_device *vpfe,
[]
> @@ -700,8 +686,8 @@ static int vpfe_ccdc_set_pixel_format(struct vpfe_ccdc *ccdc, u32 pixfmt)
>  {
>  	struct vpfe_device *vpfe = container_of(ccdc, struct vpfe_device, ccdc);
>  
> -	vpfe_dbg(1, vpfe, "%s: if_type: %d, pixfmt:%s\n",
> -		 __func__, ccdc->ccdc_cfg.if_type, print_fourcc(pixfmt));
> +	vpfe_dbg(1, vpfe, "%s: if_type: %d, pixfmt:%4.4s\n",
> +		 __func__, ccdc->ccdc_cfg.if_type, (char *)&pixfmt);


To avoid any possible defect in the content of pixfmt, it's
probably better to use vsprintf extension "%4pE", &pixfmt
see: Documentation/core-api/printk-formats.rst

	vpfe_dbg(1, vpfe, "%s: if_type: %d, pixfmt:%4pE\n",
		 __func__, ccdc->ccdc_cfg.if_type, &pixfmt);

>  
>  	if (ccdc->ccdc_cfg.if_type == VPFE_RAW_BAYER) {
>  		ccdc->ccdc_cfg.bayer.pix_fmt = CCDC_PIXFMT_RAW;
> @@ -989,8 +975,8 @@ static int vpfe_config_ccdc_image_format(struct vpfe_device *vpfe)
>  
>  	vpfe_dbg(2, vpfe, "%s:\n", __func__);
>  
> -	vpfe_dbg(1, vpfe, "pixelformat: %s\n",
> -		print_fourcc(vpfe->v_fmt.fmt.pix.pixelformat));
> +	vpfe_dbg(1, vpfe, "pixelformat: %4.4s\n",
> +		 (char *)&vpfe->v_fmt.fmt.pix.pixelformat);

	vpfe_dbg(1, vpfe, "pixelformat: %4pE\n",
		 &vpfe->v_fmt.fmt.pix.pixelformat);

etc...


