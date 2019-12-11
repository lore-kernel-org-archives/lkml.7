Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22277206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcjuOgLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLKAhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:37:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44322 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfLKAhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:37:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19so21883155lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M5fozyjIYmS/BTIpsdI1ELrEKUgvuQ2Q2YpvirtYHFk=;
        b=BcjuOgLYEULEkvnSEZEFZyVqO9tjz4WwDOrrlR+J6z6ZGNHtyg2EYf/Zs1j3Xql8EZ
         nBts8BTvVIRW0JEB2yfchCF4g46IL2zbex8fpgGN1HKpfRxGu7tTHIHIm6Su65BOB6VG
         DIsl0MaSaiCTgLFWYEQAdQT5EhvXSFx2iSi0d66o5Jxoqin9M9r1Nyo6TH6mjj5wGqUi
         Conxd2xm/VptOo8+TD7PXlAdRXRY4rFZQkYgpYf4HUDI3DX5isXtMKJW/V7AmKQE//VU
         hn7/3vplEf6bJTd3eG96g9u2oxf95RWizhawTQUygu2yEPPW4lfi+hZvShEYserCeRIk
         FxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M5fozyjIYmS/BTIpsdI1ELrEKUgvuQ2Q2YpvirtYHFk=;
        b=BpR/LgkEHflq2083qpuvJQMwf3uUMKZhzqZMgNpsQVXGxW4z+GasUEmevQIiSjTiiJ
         LF8FQ3kXUCZgePa6CWRL8Sh5umDCpGHE+b1CoT6RvpLAdH2eziQU1FkBl7zVacsDO1YC
         6hfEWuUn4yUh0miPQcXGEwDxo7cQDgCiOJxnDx3lJ6qFFUf1OPneSfDXzDsfNlwFRO3f
         YCA4u/t63MhWLsBcs28JcH+85t2Gfc58pxvEGcW+HI2DXUGEC+N5Slr+SIZ4yEo/PN3h
         GjUaN2IDrPQo0WTmlYTUBOQVYAszlqvXL1sKStJrG1burPgsSxbdyv7zYyl080fWPD0k
         02eQ==
X-Gm-Message-State: APjAAAUvrBLg7vWpFJ/repdmTTDaB2VTAVuDaLUCAwAb1JBT31gR/n+7
        xAugHvrhi4f4dcVJz1I1KiAq6oFnJchTKqRHhfd5iA==
X-Google-Smtp-Source: APXvYqzaiOv4PPiUmhxXF4TwhB8RZgaRZzj7pK+Yv2jU0m6s3z6YbcqbvvsvbDjTA/1YqXWlxl8S4u658HmPr70nbjM=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr68223ljm.233.1576024635474;
 Tue, 10 Dec 2019 16:37:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575925023.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1575925023.git.mirq-linux@rere.qmqm.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:37:03 +0100
Message-ID: <CACRpkdbTqxzXnLE7uQ=MrqV-BoP5gpZtX07gsHyCr++ah3s65Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: simplify WP/CD GPIO handling
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 10:09 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:

> This series removes convoluted handling of inverted CD and WP lines in
> SD/MMC host drivers when using GPIOs.
>
> First patch, sent separately earlier, adds gpiod_toggle_active_low() to
> switch line inversion flag in the gpiod structure. Next two patches
> modify WP and CD initialization to apply all the inversions onto gpiod's
> active-low flag. Final patch removes now-unused argument from init functi=
ons.

I like the approach, as much as I liked my own idea to centralize
all DT quirks and hide them in gpiolib-of.c I can see how this
makes it easier to solve the final hurdles in the MMC framework
and contain it better.

If it also works I'm happy for Ulf to merge all of this!

Yours,
Linus Walleij
