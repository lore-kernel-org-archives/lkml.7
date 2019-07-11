Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55BC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8D206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfGKWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:00:35 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:59254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbfGKWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:00:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 87C83909A;
        Thu, 11 Jul 2019 22:00:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean07_3ea908f224563
X-Filterd-Recvd-Size: 2260
Received: from XPS-9350 (unknown [172.58.35.165])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 22:00:30 +0000 (UTC)
Message-ID: <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
Subject: Re: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool
 not needed here"
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 15:00:00 -0700
In-Reply-To: <20190711174906.GA10867@hari-Inspiron-1545>
References: <20190711174906.GA10867@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 23:19 +0530, Hariprasad Kelam wrote:
> Fix below issue reported by coccicheck
> sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
> needed here
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  sound/soc/codecs/wcd9335.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 1bbbe42..85a8d10 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
>  		regmap_read(wcd->if_regmap,
>  				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
>  		if (val) {
> -			if (!tx)
> -				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
> -					(port_id / 8);
> -			else
> -				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
> -					(port_id / 8);
> +			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
>  			regmap_read(
>  				wcd->if_regmap, reg, &int_val);
>  			/*

This change makes no sense and doesn't match the commit message.


