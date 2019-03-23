Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF82C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A599218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZlERwFy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfCWIeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 04:34:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49622 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 04:34:15 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D26905C011D;
        Sat, 23 Mar 2019 09:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553330053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jswNjOKgHYsYeyKIft+oGJOrbPMQUtifCcL4PJzkMw=;
        b=ZlERwFy6zHrWy/e4mFcUEjicL96LOC2ANB2rkfSM3/cTOtpDDUO1BK5kGBj51mcGBVLu6j
        rGAZlpd1ZsxAC+4Hha8GviI3m3CGTXEfpKJ3mSYekBT5uBURb6zARBzrVDmvbunLd8OJ9L
        HtQAsQEXEizRqF8XU2DCbDRCiUpKXQw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Mar 2019 09:34:13 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rn5t618: Constify regulator_desc
In-Reply-To: <20190320121057.31167-1-axel.lin@ingics.com>
References: <20190320121057.31167-1-axel.lin@ingics.com>
Message-ID: <6730c8bd06d5052439adaa2c66f68ea7@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2019 13:10, Axel Lin wrote:
> The regulator_desc never need to be modified, so define them as const as a
> hint to the compiler that they can go into .rodata.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  drivers/regulator/rn5t618-regulator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/rn5t618-regulator.c
> b/drivers/regulator/rn5t618-regulator.c
> index 790a4a73ea2c..a79c0c43b9f8 100644
> --- a/drivers/regulator/rn5t618-regulator.c
> +++ b/drivers/regulator/rn5t618-regulator.c
> @@ -46,7 +46,7 @@ static const struct regulator_ops rn5t618_reg_ops = {
>  		.vsel_mask	= (vmask),				\
>  	}
>  
> -static struct regulator_desc rn5t567_regulators[] = {
> +static const struct regulator_desc rn5t567_regulators[] = {
>  	/* DCDC */
>  	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
>  	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
> @@ -63,7 +63,7 @@ static struct regulator_desc rn5t567_regulators[] = {
>  	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
>  };
>  
> -static struct regulator_desc rn5t618_regulators[] = {
> +static const struct regulator_desc rn5t618_regulators[] = {
>  	/* DCDC */
>  	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
>  	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
> @@ -79,7 +79,7 @@ static struct regulator_desc rn5t618_regulators[] = {
>  	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
>  };
>  
> -static struct regulator_desc rc5t619_regulators[] = {
> +static const struct regulator_desc rc5t619_regulators[] = {
>  	/* DCDC */
>  	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
>  	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
> @@ -107,7 +107,7 @@ static int rn5t618_regulator_probe(struct
> platform_device *pdev)
>  	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
>  	struct regulator_config config = { };
>  	struct regulator_dev *rdev;
> -	struct regulator_desc *regulators;
> +	const struct regulator_desc *regulators;
>  	int i;
>  	int num_regulators = 0;
