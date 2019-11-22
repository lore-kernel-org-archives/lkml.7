Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193AAC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E473320679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOCpH0UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfKVNXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:23:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44847 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:23:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so4456671lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G64bQ8A3yMTqtNBBWlyBmb0qrNhP58uWiyeN1U5KLKw=;
        b=oOCpH0ULI7JqIinV2acu9vs3mEAOQ46GMMMuuiYjz4Q2A0TM3VKB5XZ/sQ6BG/fQsG
         Mo7R9HmO1Hr5pSFYXX9CUQ7Bec3RIsAildBF3DJ9hs9r9e5hCU+THo3i9MqeRiPp1eYn
         uUy3QlRloKM4ueQJrjNnpm2brSNUHHJEewfQsc1CXYOvTcdDYHHrCjWH9TO1NLL1YyRg
         E/1iOC8vb52G/qpBQkYGnCJirqwadUlUIXiFpmGl9e84F8QwImAAIb8LLvTQdDb9JeSO
         kEfI67Ph4F9eEap5SGeKceaBfvA6yM6yKL+qd4Sbrh0PF2aahIU91XTuwhG6gFrFz0N1
         6ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G64bQ8A3yMTqtNBBWlyBmb0qrNhP58uWiyeN1U5KLKw=;
        b=ozaC7HQOCMf+T6hnLWsho8tWS/jFK/XqrgwLoGRJ4fUvUFpKYMOmMsuvuH7mGcUM2B
         T3kU1YTJ9fGPvI7PBeW8P/P7OLlVhDSl6R8Vxv4q/Al3IeUg+0M7lkqDIFC3WateJniV
         JDCNjV1oYvrrKWHL1Aqe5BHHYdYR4rMMN/NaCm77lAQ1NkWq5D5rhURrQeglhQz6LLgK
         itn6c9ghdiwsHHQx9yA6I75ZHv8KnLUA0u0NrtdZt2dUovHOAMh9ZVeenSxYhZDMEylp
         /z1GW/SKpWGBGIGioBBatnneBVmLcGnptlt6lDL9EE3IySRJf9RMuTPlRfggA6TIr154
         vLRA==
X-Gm-Message-State: APjAAAXaEWC/eJfX/BoFLihxahOqLpGB0MieG/q1n66NXRDH14dgbbEq
        Vh5YCL7Kqs8rVTnLZyT8mS4qpV12n6SxmPwsgKQ2kg==
X-Google-Smtp-Source: APXvYqwEF+IMct0sUqko73DZ1FYEj7WuVXA1c8Q04GTvwlG6eN/OQ1Bt+LcQ4w0/EWe1WDQ1kXUaUsPRu4TNl11V9Co=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr12054376lfn.44.1574429021774;
 Fri, 22 Nov 2019 05:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191122113230.16486-1-miquel.raynal@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 14:23:30 +0100
Message-ID: <CACRpkdYMoRXT0vGT2NfQaSq6jU-0m3A4JGrk7YAhtDih3meBQA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:32 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'm happy with this patch, but I would need Thierry's consent
to merge it so waiting for his ACK.

Yours,
Linus Walleij
