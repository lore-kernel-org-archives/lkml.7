Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B285FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B2620830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ur/uKyw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCLV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:21:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCLV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:21:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so1488835wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DgP+4ac5L76MTtc85hLN2y0wxly7CQKvhaVIeRYuQ2E=;
        b=Ur/uKyw5hlQWWzZ/CafsVrIfM+vMsxEtBCIXQDcbtLzj3bA4yDZBymV65fr3OF34Uu
         2qyVAfqqtVkbbzFztb7s+EveqWHBRx5wKXxcEXa9tK7lohXmO8uxmoOXdr09GcmwX2/B
         T213jiHWqTY9Vuv9CPZ13xwP/+5PMEfm5d80MBdBDeRlMCZvsJZ7gYCeqUx2r26Xgj08
         R5sLgL5XxHhx5BExIfX07XaZ8dUu4nH6BM8K7YKx6H8LGNNJJUKUmc1TWaxC9iALTbmq
         nKxaBlF4JSKFX0MQOVYM6B8US6zKA1M2nFGczezFlXodh27JmuRL70Kp7UmwqbbsE5+V
         rWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DgP+4ac5L76MTtc85hLN2y0wxly7CQKvhaVIeRYuQ2E=;
        b=ns2KbLZtJoCh86MtFlbQjkRhavfL+3C3KEZbXuG0cOYu5DHlxjdmKtz0fax37UrJdK
         oAMEBadUjhXwnzfOux/nij7esckUB9b9J9kTXcjCaVBNAMkGEJSuXWayjIMVAcqdS2RA
         gcxMp0XWN6A3fM4AJQeHEiwdja1KRPoLMAf+JtrLjl05LPjL7X9B8k/EyzP6sNz/IeAo
         Wjz5OCPY6VlhP1Tdnfgj/vqVmyimyKI8QHhn49a/SykOljBZ3sl945UW39wavI11gDh4
         nQkpLmVUfqMN58rixu9s2sU2NQZPn6rLe/aI7MkmQHDOxqzAa4iYFROzSfMuAYVGIcyJ
         ZIMA==
X-Gm-Message-State: APjAAAWUjFgEFtpz5QNlTUKlOlGlTgWneGXszSHM0VblJY4cHoAuToQ9
        kNjZNrNs025v7/dIoxohMZzZ5A==
X-Google-Smtp-Source: APXvYqyc21PRbX4G6Nb0VgmYfBHL0dS2QIe4R+p2Jl50y2pW0Kf5jNboX6q5c+YAiItOxP/usoiwiA==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr28282399wrn.240.1554290485552;
        Wed, 03 Apr 2019 04:21:25 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g12sm13645420wrw.40.2019.04.03.04.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:21:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] pwm: meson: use the spin-lock only to protect
 register modifications
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
References: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
 <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <5d2b4754-749a-bf93-9b7b-a768b5976ecb@baylibre.com>
Date:   Wed, 3 Apr 2019 13:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 19:57, Martin Blumenstingl wrote:
> Holding the spin-lock for all of the code in meson_pwm_apply() can
> result in a "BUG: scheduling while atomic". This can happen because
> clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
> Only hold the spin-lock when modifying registers to solve this.
> 
> The reason why we need a spin-lock in the driver is because the
> REG_MISC_AB register is shared between the two channels provided by one
> PWM controller. The only functions where REG_MISC_AB is modified are
> meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
> in there need to be protected by the spin-lock.
> 
> The original code also used the spin-lock to protect the values in
> struct meson_pwm_channel. This could be necessary if two consumers can
> use the same PWM channel. However, PWM core doesn't allow this so we
> don't need to protect the values in struct meson_pwm_channel with a
> lock.
> 
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index c1ed641b3e26..f6e738ad7bd9 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -111,6 +111,10 @@ struct meson_pwm {
>  	const struct meson_pwm_data *data;
>  	void __iomem *base;
>  	u8 inverter_mask;
> +	/*
> +	 * Protects register (write) access to the REG_MISC_AB register
> +	 * that is shared between the two PWMs.
> +	 */
>  	spinlock_t lock;
>  };
>  
> @@ -235,6 +239,7 @@ static void meson_pwm_enable(struct meson_pwm *meson,
>  {
>  	u32 value, clk_shift, clk_enable, enable;
>  	unsigned int offset;
> +	unsigned long flags;
>  
>  	switch (id) {
>  	case 0:
> @@ -255,6 +260,8 @@ static void meson_pwm_enable(struct meson_pwm *meson,
>  		return;
>  	}
>  
> +	spin_lock_irqsave(&meson->lock, flags);
> +
>  	value = readl(meson->base + REG_MISC_AB);
>  	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
>  	value |= channel->pre_div << clk_shift;
> @@ -267,11 +274,14 @@ static void meson_pwm_enable(struct meson_pwm *meson,
>  	value = readl(meson->base + REG_MISC_AB);
>  	value |= enable;
>  	writel(value, meson->base + REG_MISC_AB);
> +
> +	spin_unlock_irqrestore(&meson->lock, flags);
>  }
>  
>  static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
>  {
>  	u32 value, enable;
> +	unsigned long flags;
>  
>  	switch (id) {
>  	case 0:
> @@ -286,9 +296,13 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
>  		return;
>  	}
>  
> +	spin_lock_irqsave(&meson->lock, flags);
> +
>  	value = readl(meson->base + REG_MISC_AB);
>  	value &= ~enable;
>  	writel(value, meson->base + REG_MISC_AB);
> +
> +	spin_unlock_irqrestore(&meson->lock, flags);
>  }
>  
>  static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -296,19 +310,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
>  	struct meson_pwm *meson = to_meson_pwm(chip);
> -	unsigned long flags;
>  	int err = 0;
>  
>  	if (!state)
>  		return -EINVAL;
>  
> -	spin_lock_irqsave(&meson->lock, flags);
> -
>  	if (!state->enabled) {
>  		meson_pwm_disable(meson, pwm->hwpwm);
>  		channel->state.enabled = false;
>  
> -		goto unlock;
> +		return 0;
>  	}
>  
>  	if (state->period != channel->state.period ||
> @@ -329,7 +340,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
>  				     state->duty_cycle, state->period);
>  		if (err < 0)
> -			goto unlock;
> +			return err;
>  
>  		channel->state.polarity = state->polarity;
>  		channel->state.period = state->period;
> @@ -341,9 +352,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		channel->state.enabled = true;
>  	}
>  
> -unlock:
> -	spin_unlock_irqrestore(&meson->lock, flags);
> -	return err;
> +	return 0;
>  }
>  
>  static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
