Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623721736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V045bc5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfK2IdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:33:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40897 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2IdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:33:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id y5so9261156lfy.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il0J5+MwLfAM/oT+CoAH5b4Qb2JalE9gDN/rISPfpwo=;
        b=V045bc5kUlrbbrKjsGWI6fx5oVlc5UB1MLUbE34nb/BwDPQPv2fwavwAPcQUriNqRF
         w4RuqF2NLwBC49XYT3y52UiHVriRWc+kp5DTCAh4vhsksH+AuKBHCOLM/OZdLNiZo7Wv
         UUQ9rQVmfISLcMRuQffuMM1f/Bm7BzSeuITcyCuZs9rxHUbfHcHM6ejok+UALcvyIZV7
         +RiMetzEudkP5N8snZp4xHtz6UZc6oM+TVul52fff+rbQwGlrzHx1D4LHJIcPp2ULeP2
         Hz3icUO+J2VE8yumk7PEFM3+9KZM7SgjnX/0/xZTckBQlj0ueAL7mRAbC8wf+0/NOp83
         T9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il0J5+MwLfAM/oT+CoAH5b4Qb2JalE9gDN/rISPfpwo=;
        b=RC8xYD+QAP6GkA9u1y8AIvJxDBwuIdfFQpzCcxl52R+gGhrJQ15uUWPP3BVtD9QaF+
         6voCnZlBndThfZ6NApQUHVQVVvEN/5nnUpAM2vlkVHjuOCryflbm67D4hnLMMw/sDGEZ
         uOfM/9AKIo0ClCdAHOQKElYHoLX3WSqGpFpDfbbsyTj8i7lQw2xjUjWCYmEzcQYd6h/F
         uxpLFpK2kU4B/DU3G2WQn/lWLy2hpASXyIjNrVINNqpaWgV9/JJaeml67z071i70bMO4
         TPY026GrgobS9QuDGCrgwTSSaNKKSBVgguU/Tsm5ivHVZHGkQhw/nJfvYks9W1kDp9ik
         zxWw==
X-Gm-Message-State: APjAAAUuzXVH5SQnD1rn8Ygvmx7WAduvimeDnptX5vCX11AvHiEUvXEI
        hLwheYlxzeBhhrTiFla5nrC3V2MqQEUppg/M7mKYEA==
X-Google-Smtp-Source: APXvYqyoc0FVxIgsDrfwyYoHK4jgCjVWSH09qmYYUgnLUoTs/XZodUt6ynHnfKK9Zt5B5ycVpnbwZioidRjgVtWf6aM=
X-Received: by 2002:a19:7d02:: with SMTP id y2mr32888849lfc.86.1575016396196;
 Fri, 29 Nov 2019 00:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de> <20191127135932.7223-5-m.felsch@pengutronix.de>
In-Reply-To: <20191127135932.7223-5-m.felsch@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 09:33:04 +0100
Message-ID: <CACRpkdZHmbgaHHbsXuAg4GD_cWWSx33WQ71Sk11HySoeorfUbA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: mfd: da9062: add regulator gpio
 enable/disable documentation
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> At the gpio-based regulator enable/disable documentation. This property
> can be applied to each subnode within the 'regulators' node so each
> regulator can be configured differently.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
(...)
> +  - dlg,ena-sense-gpios : The GPIO reference which should be used by the
> +    regulator to enable/disable the output. If the signal is active the
> +    regulator is on else it is off. Attention: Sharing the same gpio for other
> +    purposes or across multiple regulators is possible but the gpio settings
> +    must be the same. Also the gpio phandle must refer to the mfd root node
> +    other gpios are not allowed and make no sense.

- Point out that this concerns references to the GPI general purpose
input on the DA9062 itself, and not just "any" GPIO. The last sentence
tries to say this but it should be stated more clearly.

- Clarify which "gpio settings" must be the same, e.g. polarity I guess.

Yours,
Linus Walleij
