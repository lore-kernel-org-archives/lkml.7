Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B81C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FE82070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oNkqm2Rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCDSSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:18:16 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37784 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551723491; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcimyzTYq93+Ws1z9JT7iEZu19RErpFY3H0Q4NoTYU0=;
        b=oNkqm2Rw2GhCIBirxZNnkm1HpGHP2fouvlDlDIW2LD2m9bbPUoSR6yznIJ4KPoboDO7GA9
        0h+SXFc6ElVj7uI53nMAyWDcnzq48pQz/45KimDlI6tk993EHkAlsX4DW7vX34X0bI3PVp
        tk9s42mHMnKU8PDb8keZep1LVDn39iM=
Date:   Mon, 04 Mar 2019 19:18:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v10 13/27] pwm: jz4740: Use clocks from TCU driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-Id: <1551723480.4932.1@crapouillou.net>
In-Reply-To: <20190304123003.GE9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
        <20190302233413.14813-14-paul@crapouillou.net> <20190304123003.GE9040@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 4, 2019 at 1:30 PM, Thierry Reding 
<thierry.reding@gmail.com> wrote:
> On Sat, Mar 02, 2019 at 08:33:59PM -0300, Paul Cercueil wrote:
>>  The ingenic-timer "TCU" driver provides us with clocks, that can be
>>  (un)gated, reparented or reclocked from devicetree, instead of 
>> having
>>  these settings hardcoded in this driver.
>> 
>>  While this driver is devicetree-compatible, it is never (as of now)
>>  probed from devicetree, so this change does not introduce a ABI 
>> problem
>>  with current devicetree files.
>> 
>>  Note that the "select REGMAP" has been dropped because it's
>>  already enabled by the "select INGENIC_TIMER".
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  Tested-by: Mathieu Malaterre <malat@debian.org 
>> <mailto:malat@debian.org>>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu 
>> <mailto:contact@artur-rojek.eu>>
>>  ---
>> 
>>  Notes:
>>           v9: New patch
>> 
>>           v10: Explain in commit message why "select REGMAP" was 
>> dropped
>> 
>>   drivers/pwm/Kconfig      |  3 ++-
>>   drivers/pwm/pwm-jz4740.c | 39 
>> ++++++++++++++++++++++++++-------------
>>   2 files changed, 28 insertions(+), 14 deletions(-)
>> 
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index ace8ea4b6247..4e201e970509 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -204,7 +204,8 @@ config PWM_IMX
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  -	select REGMAP
>>  +	depends on COMMON_CLK
>>  +	select INGENIC_TIMER
> 
> Okay... sounds like this would be okay. I'm assuming you go through 
> that
> extra step of selecting REGMAP in the prior patch and dropping it here
> again so that you keep the series bisectible?

Yes, exactly.

>>   	help
>>   	  Generic PWM framework driver for Ingenic JZ47xx based
>>   	  machines.
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
>>  index 8dfac5ffd71c..c6136bd4434b 100644
>>  --- a/drivers/pwm/pwm-jz4740.c
>>  +++ b/drivers/pwm/pwm-jz4740.c
>>  @@ -28,7 +28,7 @@
>> 
>>   struct jz4740_pwm_chip {
>>   	struct pwm_chip chip;
>>  -	struct clk *clk;
>>  +	struct clk *clks[NUM_PWM];
>>   	struct regmap *map;
>>   };
>> 
>>  @@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip 
>> *to_jz4740(struct pwm_chip *chip)
>>   static int jz4740_pwm_request(struct pwm_chip *chip, struct 
>> pwm_device *pwm)
>>   {
>>   	struct jz4740_pwm_chip *jz = to_jz4740(chip);
>>  +	struct clk *clk;
>>  +	char clk_name[16];
>>  +	int ret;
>> 
>>   	/*
>>   	 * Timers 0 and 1 are used for system tasks, so they are 
>> unavailable
>>  @@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip 
>> *chip, struct pwm_device *pwm)
>>   	if (pwm->hwpwm < 2)
>>   		return -EBUSY;
>> 
>>  -	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
>>  +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
>> 
>>  +	clk = clk_get(chip->dev, clk_name);
>>  +	if (IS_ERR(clk))
>>  +		return PTR_ERR(clk);
>>  +
>>  +	ret = clk_prepare_enable(clk);
>>  +	if (ret) {
>>  +		clk_put(clk);
>>  +		return ret;
>>  +	}
>>  +
>>  +	jz->clks[pwm->hwpwm] = clk;
>>   	return 0;
>>   }
> 
> Since you're already using ->request(), why not add a per-PWM 
> structure
> that tracks the clock? There are a number of other PWMs that already 
> do
> something similar. You can use pwm_{set,get}_chip_data() to associate
> chip-specific extra data with a PWM.
> 
> Thierry

Good idea.

-Paul


