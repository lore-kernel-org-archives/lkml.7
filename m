Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C3C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391278AbfIIQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:55:00 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:45554 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727781AbfIIQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:55:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DD120100E86C0;
        Mon,  9 Sep 2019 16:54:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: joke95_e38df7958c09
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 16:54:57 +0000 (UTC)
Message-ID: <ec66e477095bcddb86ffcc7ca10d3e0bbe72f943.camel@perches.com>
Subject: Re: [Patch 09/13] media: am437x-vpfe: fix function trace debug log
From:   Joe Perches <joe@perches.com>
To:     Benoit Parrot <bparrot@ti.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 09:54:56 -0700
In-Reply-To: <20190909162743.30114-10-bparrot@ti.com>
References: <20190909162743.30114-1-bparrot@ti.com>
         <20190909162743.30114-10-bparrot@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 11:27 -0500, Benoit Parrot wrote:
> checkpatch.pl nows reports several:
> WARNING: Prefer using '"%s...", __func__' to using '<function name>',
> this function's name, in a string
> 
> So fix these for the whole driver.

Most of these seem to be function tracing comments
that should probably be removed instead.

The generic kernel facility ftrace works well.

> diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
[]
> @@ -466,7 +466,7 @@ static void vpfe_ccdc_config_ycbcr(struct vpfe_ccdc *ccdc)
>  	struct ccdc_params_ycbcr *params = &ccdc->ccdc_cfg.ycbcr;
>  	u32 syn_mode;
>  
> -	vpfe_dbg(3, vpfe, "vpfe_ccdc_config_ycbcr:\n");
> +	vpfe_dbg(3, vpfe, "%s:\n", __func__);

Remove this instead

>  	/*
>  	 * first restore the CCDC registers to default values
>  	 * This is important since we assume default values to be set in
> @@ -598,7 +598,7 @@ static void vpfe_ccdc_config_raw(struct vpfe_ccdc *ccdc)
>  	unsigned int syn_mode;
>  	unsigned int val;
>  
> -	vpfe_dbg(3, vpfe, "vpfe_ccdc_config_raw:\n");
> +	vpfe_dbg(3, vpfe, "%s:\n", __func__);

here too, etc...


