Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD06217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfKTOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:43:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfKTOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:43:19 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iXRCN-0003KF-NB; Wed, 20 Nov 2019 15:43:15 +0100
Message-ID: <f5edcd3d1f8b196a4de584d935636a4b5b247121.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] reset: Do not register resource data for missing
 resets
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 15:43:15 +0100
In-Reply-To: <20191120142614.29180-2-geert+renesas@glider.be>
References: <20191120142614.29180-1-geert+renesas@glider.be>
         <20191120142614.29180-2-geert+renesas@glider.be>
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

Hi Geert,

thank you for the patches!

On Wed, 2019-11-20 at 15:26 +0100, Geert Uytterhoeven wrote:
> When an optional reset is not present, __devm_reset_control_get() and
> devm_reset_control_array_get() still register resource data to release
> the non-existing reset on cleanup, which is futile.
> 
> Fix this by skipping NULL reset control pointers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/reset/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index ca1d49146f611435..55245f485b3819da 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -787,7 +787,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
> -	if (!IS_ERR(rstc)) {
> +	if (rstc && !IS_ERR(rstc)) {

Could you change this to use IS_ERR_OR_NULL, both here and below?

>  		*ptr = rstc;
>  		devres_add(dev, ptr);
>  	} else {
> @@ -930,7 +930,7 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
>  		return ERR_PTR(-ENOMEM);
>  
>  	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
> -	if (IS_ERR(rstc)) {
> +	if (!rstc || IS_ERR(rstc)) {
>  		devres_free(devres);
>  		return rstc;
>  	}

Same for patch 3, which otherwise looks fine.

regards
Philipp

