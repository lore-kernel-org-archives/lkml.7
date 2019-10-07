Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FAEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431D820835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f0iot5HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJGUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:10:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34782 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:10:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id 83so12866117oii.1;
        Mon, 07 Oct 2019 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgoI/BpstzExvfapSP/r9rpFlNEylt0wDd7mLlzkxGQ=;
        b=f0iot5HOwYxLeGOm8csmxxtd6SWMKyklIHgREALK6AUANZrtWVO1P+Ig9PU3XicIMY
         yMut937g7KW5neV7E82AY6/GnCdXDgIXELS1pXswRMIH9QYfa+NW8+0KmyXoDb2ChZua
         F7CUPT0mlXK6AOtVjbG8gsYDstqbDyCmfmFp3RURqNEDYTqUE5SGX4VVKKPqUvzHZ4iw
         e9enIXSgwdxOER9HHzPGZIXgjDV+ttJX2teWyKKjLzC3esWbyX79bhJV29RkSru9h7kC
         3AyOWJrBIijj8QKtJ6s4vfoOaQZ+bCP2x3PHjZxUn03Od8kX83RfUR4cpatOTikgGIFX
         7QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgoI/BpstzExvfapSP/r9rpFlNEylt0wDd7mLlzkxGQ=;
        b=Fl0fsXPA+nDyvAaMv4WDPEJgiTnMBwHr7DDMHKfKxKOBbBrgyczVQ3DxDf2d0cBc4G
         kX4GwvWbT0I3o9E4RlE/Eyq2+jcwstVGlwGXD4diOwlPaLVWKnQ4+Wmn9Vcnawrq2Q03
         5X1B0XvVfFQ3qvJENmNd8yVDwY0LE0zJnxSJh3dQxOrPa5Z9k2KPNQTLtFWS0cViuUIk
         wRtYoeXLPCeAT+Px6tN64+7bLGTFraO2tcaYYS3w0qAJMXUACaz50i2tH8L+YuFCuNjq
         4+lxJwxaMURHwMaUizcHou1izH9VHdAEEOPQD+FKLmP62+zDbdVTNyMqntnxlnuoDx3f
         cwqA==
X-Gm-Message-State: APjAAAUJAURkPIXiSSCnjHBrF2s1hHN9iCfLHj9i6jOs5OL/Gs2y5h15
        /gyBBsjWr4PiKfE8nmfuK6Rcc5oMW9hqa+g5pWY=
X-Google-Smtp-Source: APXvYqyMUNIK/2LBX1NHC436+9DUvSuMC9kF8EqXAJrGmDjVk7EEXqFvCvKb9HsYzM4QU2sMjSM12j8ePZeFckHGReQ=
X-Received: by 2002:aca:5a0b:: with SMTP id o11mr889855oib.47.1570479051451;
 Mon, 07 Oct 2019 13:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
In-Reply-To: <20191007131649.1768-6-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 7 Oct 2019 22:10:40 +0200
Message-ID: <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 3:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9a867ac32d4..72f6a7dca0d6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -774,7 +774,7 @@ CONFIG_MPL3115=m
>  CONFIG_PWM=y
>  CONFIG_PWM_BCM2835=m
>  CONFIG_PWM_CROS_EC=m
> -CONFIG_PWM_MESON=m
> +CONFIG_PWM_MESON=y
some time ago I submitted a similar patch for the 32-bit SoCs
it turned that that pwm-meson can be built as module because the
kernel will run without CPU DVFS as long as the clock and regulator
drivers are returning -EPROBE_DEFER (-517)

did you check whether there's some other problem like some unused
clock which is being disabled at that moment?
I've been hunting weird problems in the past where it turned out that
changing kernel config bits changed the boot timing - that masked the
original problem


Martin
