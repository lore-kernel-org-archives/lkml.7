Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8805C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01052171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0zU9BKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfHHNEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:04:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36945 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbfHHNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:04:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id v6so63032769vsq.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVPeB+St4GsfV4+rvU+wUWYIPVqFTU7qMjefLsTGDCk=;
        b=B0zU9BKtNhlSEKo6kKYAsY4u7PN+VPvRfvn+58jakXBjrysCX6tUOR7URHJIAMEm4q
         RH3G9v787hEUo9uudsxNZ/U5ymkg8YKbZ9X/sFY0l7Chji4cFFfnvMFaNqBl6IEoKvIu
         ADqhq3f1tsOe6K0RMz6rDuj0VIcE4rjQAalVJeVcjaADUo9YPkBV74qrFtI1gRRuc6RK
         uExR/PtW0Id9fobcvztepC7ZqnrMal9PRifw+s8uNyVZi4nF4O7ninIYFkmg1JKoOAUL
         zuc0HscZLEHCXMIkIxEZcOarnQu7QnnEri6lOX/k6qxN94tmfvREhBnWrnF/pA35X1Xk
         LtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVPeB+St4GsfV4+rvU+wUWYIPVqFTU7qMjefLsTGDCk=;
        b=YFvpAH/mZTkVaajscT3ARsjRAQAWbDAzHSN3GcZf1RUQlf0sAEHd4Z1d5tCKYdSHxt
         c29sR+lgJKV6MXZRq7AMGhcnmD18A16oLlhCfI2QNSbt2hRIwm+84xHusY9PG4aVIz34
         fY0Vd19gogJK45rX9hkJnQRXAXnJn8Q9wBC8sDC8FTP6mI10nRH6NSYkQzuRH3EjFGuq
         Ec0Q5XT4Frcdti0yIhcIKKuu7jdBEmkfPkaYVGinz+aRU+N2fCzxB+J2zXkFUPNS/FMR
         7GiUOT/tzmU/O98wnFLdPn6uIinjHo35LjzAOoDQmRkD0PnzXrVb1qEP2zb67XuRYj4p
         tKAQ==
X-Gm-Message-State: APjAAAXxPoLOyY0s0p9LshTrXP2/TYbDkEN/FCZrKgle4easlq3+Beau
        n6qsZ9S1ieYnwFICSgCt9KsIpZzxlfd9e5O2U/p9/kyiBbs=
X-Google-Smtp-Source: APXvYqwz4sEsZKLGse5oWlgt5eN1TzALbdcsnHo96qnOT8qI6DXH4l2SvV6vxlWxJGY6nX4j8iQr0jJNPuU3PgiNq7U=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr9548609vsr.9.1565269488210;
 Thu, 08 Aug 2019 06:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 8 Aug 2019 18:34:37 +0530
Message-ID: <CAHLCerP4v_Lz5OGswx7+Z5uHVq_D8G5brq-_M6fOc0K6DK2OKg@mail.gmail.com>
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, sivaa@codeaurora.org
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:48 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Add interrupt support to TSENS. The first 6 patches are general fixes and
> cleanups to the driver before interrupt support is introduced.
>
> This series has been developed against qcs404 and sdm845 and then tested on
> msm8916. Testing on msm8998 and msm8974 would be appreciated since I don't
> have hardware handy. Further, I plan to test on msm8996 and also submit to
> kernelci.

Gentle nudge for reviews. This has now been successfully tested on
8974 (along with 8916, qcs404, sdm845). Testing on msm8998 would be
much appreciated.

> I'm sending this out for more review to get help with testing.
>
> Amit Kucheria (15):
>   drivers: thermal: tsens: Get rid of id field in tsens_sensor
>   drivers: thermal: tsens: Simplify code flow in tsens_probe
>   drivers: thermal: tsens: Add __func__ identifier to debug statements
>   drivers: thermal: tsens: Add debugfs support
>   arm: dts: msm8974: thermal: Add thermal zones for each sensor
>   arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
>   dt: thermal: tsens: Document interrupt support in tsens driver
>   arm64: dts: sdm845: thermal: Add interrupt support
>   arm64: dts: msm8996: thermal: Add interrupt support
>   arm64: dts: msm8998: thermal: Add interrupt support
>   arm64: dts: qcs404: thermal: Add interrupt support
>   arm64: dts: msm8974: thermal: Add interrupt support
>   arm64: dts: msm8916: thermal: Add interrupt support
>   drivers: thermal: tsens: Create function to return sign-extended
>     temperature
>   drivers: thermal: tsens: Add interrupt support
>
>  .../bindings/thermal/qcom-tsens.txt           |   5 +
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
>  drivers/thermal/qcom/tsens-8960.c             |   4 +-
>  drivers/thermal/qcom/tsens-common.c           | 610 +++++++++++++++++-
>  drivers/thermal/qcom/tsens-v0_1.c             |  11 +
>  drivers/thermal/qcom/tsens-v1.c               |  29 +
>  drivers/thermal/qcom/tsens-v2.c               |  18 +
>  drivers/thermal/qcom/tsens.c                  |  52 +-
>  drivers/thermal/qcom/tsens.h                  | 285 +++++++-
>  14 files changed, 1214 insertions(+), 206 deletions(-)
>
> --
> 2.17.1
>
