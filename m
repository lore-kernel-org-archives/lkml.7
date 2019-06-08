Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C83AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E82B208C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLKZl8Bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfFHEGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:06:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38551 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfFHEGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:06:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so2242508pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PyDG+UhX2LZRYYvLv1SMUrMAsUP6kJRuwP4hHbbu49Q=;
        b=oLKZl8BdcEWgS/7tCRrkGaQMn1rEE6eyguMA2c78pPAYogjbKRnBM1xcCeAfZACA9I
         NJV4ImdEnOXKA/I3EPaZORfJraLb/NutjShfO67Pqz0H7NtYZkJ2kPeg3tU4fvDfwcoK
         br3Z73zRlWDv2Y7oto2BUFTRcmhS/WJcydY4ZJhpRhAMCtpEqdZ4vsaeH37KCIFlSpH4
         BVF3w9RXQArA/DN7z3f4EP68SjpdeEJ2pgwbIpwoR+106HXUh3/jNFq8VYxDZzQSOaED
         n8qfxLKDWqJRevB7KEyW+qfYyCmFAUoPpouaJ0fXCOI7slFBh31W9jxCLpnFYXdNjXmi
         thGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PyDG+UhX2LZRYYvLv1SMUrMAsUP6kJRuwP4hHbbu49Q=;
        b=j8XWBGi54eGeJQbsfWASwOOvqXpBXb5NLpiTeokofWxX2PMf63Kk4JJ/GrsCosHqCd
         44G8vgi8kNFbv01ntrLQz6RRFbqWHE1zI0s4RyKnMzeRMMj2+0jZIQku6AKWVJ2K2Gxc
         NibLsyjTWDcdEgAPp/ww52kP3+UKmy4R8zfvGDY+EKluHpdeX3LuX/Y4IxxEJVvBBmUH
         ahAI6vrGzjLG2VkeI4rFW+ZLrkZlnGu8xZQR/3kz7pUnd+BRHyUP+7K6td9ko3bDj2hF
         lEQ/PjQP7zyM83+HR/sgFIrHAFlSMP+eNrHdUFdl5mA3SsNp9PJBd/44Ifqle7ZeRNIh
         W2rw==
X-Gm-Message-State: APjAAAWl0vlFyWT17Niva270RLlPWlDy2zbDH6XBsmb/GazD/yG52Gdw
        vgJkCpHewcvVfbTcIt1Hvm8HFQ==
X-Google-Smtp-Source: APXvYqxxX8LNDTro0dbkyH+JE1KcQfRwMQkC/TP2PYlKUX5c3Htw8meTgL4m1176HNvjepcvPVQ9RA==
X-Received: by 2002:a62:e403:: with SMTP id r3mr31613379pfh.37.1559966773330;
        Fri, 07 Jun 2019 21:06:13 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y6sm6668288pfo.38.2019.06.07.21.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 21:06:12 -0700 (PDT)
Date:   Fri, 7 Jun 2019 21:06:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        linus.walleij@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jlhugo@gmail.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
Message-ID: <20190608040610.GJ24059@builder>
References: <20190605114302.22509-1-lee.jones@linaro.org>
 <20190605114302.22509-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605114302.22509-3-lee.jones@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 04:42 PDT 2019, Lee Jones wrote:

> When booting MSM based platforms with Device Tree or some ACPI
> implementations, it is possible to provide a list of reserved pins
> via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> However some ACPI tables are not populated with this information,
> thus it has to come from a knowledgable device driver instead.
> 
> Here we provide the MSM common driver with additional support to
> parse this informtion and correctly populate the widely used
> 'valid_mask'.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 18 ++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index ee8119879c4c..3ac740b36508 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -607,8 +607,23 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *chip)
>  	int ret;
>  	unsigned int len, i;
>  	unsigned int max_gpios = pctrl->soc->ngpios;
> +	const int *reserved = pctrl->soc->reserved_gpios;
>  	u16 *tmp;
>  
> +	/* Driver provided reserved list overrides DT and ACPI */
> +	if (reserved) {
> +		bitmap_fill(chip->valid_mask, max_gpios);
> +		for (i = 0; reserved[i] >= 0; i++) {
> +			if (i >= max_gpios || reserved[i] >= max_gpios) {

reserved is a list of GPIOs to reserve, I don't see a reason to check
if that list is longer than the number of GPIOs (i.e. the first half of
the condition).

It wouldn't make sense to be, but there's no logical issue with it and I
had to read the conditional a few extra times to be sure what was going
on.


Apart from that you have my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> +				return -EINVAL;
> +			}
> +			clear_bit(reserved[i], chip->valid_mask);
> +		}
> +
> +		return 0;
> +	}
> +
>  	/* The number of GPIOs in the ACPI tables */
>  	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL,
>  						   0);
> @@ -964,6 +979,9 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
>  
>  static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>  {
> +	if (pctrl->soc->reserved_gpios)
> +		return true;
> +
>  	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>  }
>  
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index c12048e54a6f..23b93ae92269 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -121,6 +121,7 @@ struct msm_pinctrl_soc_data {
>  	bool pull_no_keeper;
>  	const char *const *tiles;
>  	unsigned int ntiles;
> +	const int *reserved_gpios;
>  };
>  
>  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> -- 
> 2.17.1
> 
