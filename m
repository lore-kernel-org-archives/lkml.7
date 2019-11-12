Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D4EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9603721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKLTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:30:01 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:45973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfKLTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:30:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9E42318030167;
        Tue, 12 Nov 2019 19:29:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: women58_9143341421351
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 19:29:58 +0000 (UTC)
Message-ID: <dfb2c158308e0e9cb790ad3c17eb2563ac192f2b.camel@perches.com>
Subject: Re: [PATCH][next] ASoC: tas2770: clean up an indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 11:29:41 -0800
In-Reply-To: <20191112190218.282337-1-colin.king@canonical.com>
References: <20191112190218.282337-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 19:02 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block that is indented too deeply, remove
> the extraneous tabs.
[]
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
[]
> @@ -761,12 +761,12 @@ static int tas2770_i2c_probe(struct i2c_client *client,
>  	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>  							  "reset-gpio",
>  						      GPIOD_OUT_HIGH);
> -		if (IS_ERR(tas2770->reset_gpio)) {
> -			if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> -				tas2770->reset_gpio = NULL;
> -				return -EPROBE_DEFER;
> -			}
> +	if (IS_ERR(tas2770->reset_gpio)) {
> +		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> +			tas2770->reset_gpio = NULL;
> +			return -EPROBE_DEFER;
>  		}
> +	}

This could remove the IS_ERR and and also remove another indentation level

	if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

or if _really_ desired, (but it seems not really necessary)
but this form is used in a few other sound drivers:

	if (IS_ERR(tas2770->reset_gpio) &&
	    PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

