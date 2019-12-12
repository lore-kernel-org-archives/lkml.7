Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5D4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E1D21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QM0qXmnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfLLP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:26:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45833 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfLLP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:26:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so2711980ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxtfVCy854UiCdW/Pd4nrn0GmF8wmwHJm0o9NwdBja4=;
        b=QM0qXmnLM6JznscH8Nk4M3SeXsM64afUcdaE+aLIFTnj9NVXBfzvucfz76HbVmio48
         v7xTCrDbpjbrr9DtuQppfYV7aL74zRG/SwpEgGw57m7hLXfkDtQu8KWdmqJSRu/nIjqb
         shpYNiZ0TW+IilCNkNeS0jbjl1Ag4M8ghAwcVAD8qmz36BcbGTB3qRsjWT77tg1ZJDXt
         Npa4efyci9fS/koXUMhhaZMYSMRHcd0dO3i/hCFyQTqkz6pO/ip7lCWZGaaHn9BA4bRj
         rNE5okjC8b5YTqMxvZsIGmrAR0Bc4K2ow8LmwAogwYpOwCOTCPlsEzL4URftnfL0mlvK
         pxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxtfVCy854UiCdW/Pd4nrn0GmF8wmwHJm0o9NwdBja4=;
        b=rMf7WKGIERQXsAGQ1riF+tDtNuJ+WIhhSw3I+jQhfQr5WDCbvqgDT4UZIKPRDQ1UD1
         iFTbnEJZBbttXo+0z5vqplMdYAEhcq2fTHfTeXG/FSLwPPRWB2bdrzIAGYQyOaSDnFGt
         5vvao3bwY/o/PVzwyf0duGjkyl8ZEanxSWiaMsGKYNMmE/OGg1NFVb+JjgFFJzvjgktI
         mP2G4vZZXvvZGs4MGyuRU3PbC06Hb+/TCLKAtbpJdlF+3kYzRXB1y9TER6hMcDCKb0qY
         SyTmTuAcWQdUgvpLU4D7JSHc3oXr7YIEPljF7TULiPXdSkggu7yHUCtWkr+vvdCIZYBt
         L4mw==
X-Gm-Message-State: APjAAAXrODAuPdSMpLZP6kf08FecLMrRjtAXoPwv0Ki994C3P3wR6z58
        VyWisQkOoloigrNN6uOxcTfVGU0O8uwWE8RQrHEkZA==
X-Google-Smtp-Source: APXvYqx+KpcrEMoHeICCBXZ45UEn0qf3Fzm8PCoh+PnixT+kWNR3k/NselgLwIuIleUjpqTTKNhQ4a/q/7YRTFP2LIs=
X-Received: by 2002:a2e:8544:: with SMTP id u4mr6132830ljj.191.1576164413346;
 Thu, 12 Dec 2019 07:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191129191023.2209-1-miquel.raynal@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 16:26:41 +0100
Message-ID: <CACRpkdZt25zK3WD9qZdJ=Aeq9YbcavJPVOX=kt8qWLdH1dHckA@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Fri, Nov 29, 2019 at 8:10 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Changes in v4:

I'm fine to merge this v4 if I get Thierry's ACK on it.

Yours,
Linus Walleij
