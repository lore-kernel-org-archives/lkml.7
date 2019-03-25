Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F94C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710620651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553546773;
	bh=FKtBPNcIKijzFQjvkDgnG+GGPZrFrBFv9p72QLWYDnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JU66OhPwWUZl2VBeVnIrqI6oirhUGmZeXmZsW1sy4GQ9fx8yc2ODQYzvYsklurb/F
	 wN7oDTwPjQgRlu/oIuv/ud0iPz1xaaFykFmjNm0T2x0X0nVbpp5z1ask+qvscjxY49
	 x2Odeck50tWvVZeQ3hW6O1MIt7Gcod87k6QmXZIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfCYUqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:46:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42582 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:46:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so9386238otd.9;
        Mon, 25 Mar 2019 13:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zdf5EB6CNOqo3DOcKbvb6wdZWjeg6eqEknQqmVyJi1o=;
        b=Qgx4YMdIabHzO3clTKmRfqR9PGsz85YL4q7QJGayU7oDHR6otneCqLPv4Fg2UrzOTR
         oMQui9Cbjb1hLgAxOMga1SeXCRFp/KWVo1nnOjPyu49+gzbKoJpXASFPe8wkSSI/VJ5T
         BE/aBJpsIVuBfzJe7LgSDO+QAX2h/lCfN7wbY7DC8rFVh7k1hpFLQ/cYKZ8FM7DQQdff
         LlXMC0h19EF/YbkGAFClG3lAAFRl9kPE9ntptqZuWlyv88HUb5Q3solpZpRFWJ2tkvKt
         rHSORsO9prjvNJX0RPSFOD0UGfukcQNYMXsATMV9JDwczz6Q1XfuL/0clUGCMV1831YG
         BJhQ==
X-Gm-Message-State: APjAAAU6LxuxSzdjfYxo3rBZfKT+pot/nwK+EGd5cpggyfCzepD5/teC
        XP1ljFQ0aDEpI7OtmqLhEA==
X-Google-Smtp-Source: APXvYqyK2QmqBs8MOCe/9TElPWxzpl6/Dyzz8Ykeb4dCD+6qcyD3oGI8ijSdmubnQsCvCa84ltD4wA==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr19083673otp.169.1553546770791;
        Mon, 25 Mar 2019 13:46:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9sm6461718oth.13.2019.03.25.13.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 13:46:10 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:46:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH v6 02/11] dt-bindings: power: supply: add DT
 bindings for max77650
Message-ID: <20190325204609.GA29935@bogus>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318174228.18194-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:42:19PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the battery charger module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> new file mode 100644
> index 000000000000..d25c95369616
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.
> +- curr-lim-microamp:	CHGIN input current limit (in microamps). Must be one of:
> +			95000, 190000, 285000, 380000, 475000.

These should be common charger properties IMO.

Rob
