Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D367C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827CC20723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKNNXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:23:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36175 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKNNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:23:05 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iVF5M-0005Uk-R9; Thu, 14 Nov 2019 14:22:56 +0100
Message-ID: <ea47e8e7a8663d33acb44dd4473a5a150ea51526.camel@pengutronix.de>
Subject: Re: [PATCH][next] reset: npcm: check for NULL return from
 syscon_regmap_lookup_by_compat
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Colin King <colin.king@canonical.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Nov 2019 14:22:56 +0100
In-Reply-To: <20191108155524.170566-1-colin.king@canonical.com>
References: <20191108155524.170566-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, 2019-11-08 at 15:55 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function syscon_regmap_lookup_by_compat can return a NULL pointer, so

Could you point out where that NULL pointer would come from? As far as I
understand, syscon_regmap_lookup_by_compatible() should either return a
negative error code, or syscon->regmap, which should never be NULL.

> the IS_ERR check on the return is incorrect. Fix this by checking for
> IS_ERR_OR_NULL and return -ENODEV if true.  This avoids a null pointer
> dereference on gcr_regmap later on.
> 
> Addresses-Coverity: ("Dereference null return (stat)")
> Fixes: b3f1d036f26d ("reset: npcm: add NPCM reset controller driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/reset/reset-npcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index 2ea4d3136e15..9febf8bed2f6 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -161,9 +161,9 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
>  	of_match_device(dev->driver->of_match_table, dev)->data;
>  
>  	gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
> -	if (IS_ERR(gcr_regmap)) {
> +	if (IS_ERR_OR_NULL(gcr_regmap)) {
>  		dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
> -		return PTR_ERR(gcr_regmap);
> +		return -ENODEV;
>  	}
>  
>  	/* checking which USB device is enabled */

regards
Philipp

