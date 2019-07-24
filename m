Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5321EC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C140218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Ny/ccUms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGXFVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:21:50 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34199 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfGXFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:21:50 -0400
Received: by mail-ua1-f68.google.com with SMTP id c4so17968560uad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oi/OjsgOU/56zWqfJ08vj5GsGuTHtcSjKS7DehgEZ00=;
        b=Ny/ccUmsgikYkzhJxwqhFM0rKqUpt+oemiMOdIlgorofwJaszzajLDUlrd3p94oiAt
         cHMbiaokXpIHwJTdQURza4IV92tvAYWdb7Ul8EPdTh5rDmI1wbeS8dwuzmBHmt72JP1l
         K7giyPr6ybXNVlnfO0+CRAs0g5ZieYtYQKrqQGthdoDQJ1hzRYcax91fYW2JL5I7gluf
         nifWdnqbKT4vX7tcZ3CwOburD9zuBYjubfKgE/Fsxm7bpNaqpTxfzy3JEGFrSvw26cho
         2H3OvtPUDmW+EaH53e7badSsivfa7GCl0hBmVQZFOmKhaGhgJXGrE3OtVYaHveOnF8qD
         t3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi/OjsgOU/56zWqfJ08vj5GsGuTHtcSjKS7DehgEZ00=;
        b=Tg517OEqIBnYCJ2jnXXh36OzkMPVwl2Srvg6zfc3Xzw5ETeBTZfg2Oy8ju9g16CDiO
         IkRmDF3/xs4SE793aJE+5j92RSnP3FmeUhxAsOqpVoYR4YCvrof3pNNJWRXLK7lvhDIe
         rICxQDf2ETUWX6Uk2lpCRoehGWyWj9w5KZNX0PD8Ek16VRcxKnApmJcfp0+7nUQbKtj8
         roIcAVt9oKV8lBzxgfLoqu3HtdVP0+Hdabekh++h5hN2Qy5m9bWv/HD7wSPxltiPCay/
         IWHtxZbL4983r7pXGsTO4lZSkFA9NTfXRqHHEL3RyZ3gUY3PqeFNLHfKc1X/e78ePUmu
         dQOg==
X-Gm-Message-State: APjAAAX5oyOdJydi5u+5A5aI4+IBzuLNxjspq2zsIgT+5tmXrPSqy7pD
        5QPJYnqabMQwgyP2YXfaVtE4u9jV+S6BeDIjpsCY9TzKaww=
X-Google-Smtp-Source: APXvYqx0WauV/PjdF1lUUuZXSYyiqRlLYG/T7Zia0hA1FLzkRtsJ0o5mtJz3PFpQjgZM43vU8do8IXGnuxnc8EduObw=
X-Received: by 2002:ab0:30f5:: with SMTP id d21mr49123116uam.67.1563945709074;
 Tue, 23 Jul 2019 22:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190724044906.12007-1-vkoul@kernel.org> <20190724044906.12007-6-vkoul@kernel.org>
In-Reply-To: <20190724044906.12007-6-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 24 Jul 2019 10:51:38 +0530
Message-ID: <CAHLCerNWnjSYEqDOEdSzULLvTHkMxVMiEL2BaCY9R4eDF_uBrg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sdm845-cheza: remove macro from
 unit name
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:20 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Unit address is supposed to be a number, using a macro with hex value is
> not recommended, so add the value in unit name.
>
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:966.16-969.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4d: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:971.16-974.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4e: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:976.16-979.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4f: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:981.16-984.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x50: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:986.16-989.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x51: unit name should not have leading "0x"
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 1ebbd568dfd7..9b27b8346ba1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -963,27 +963,27 @@ ap_ts_i2c: &i2c14 {
>  };
>
>  &pm8998_adc {
> -       adc-chan@ADC5_AMUX_THM1_100K_PU {
> +       adc-chan@4d {
>                 reg = <ADC5_AMUX_THM1_100K_PU>;
>                 label = "sdm_temp";
>         };
>
> -       adc-chan@ADC5_AMUX_THM2_100K_PU {
> +       adc-chan@4e {
>                 reg = <ADC5_AMUX_THM2_100K_PU>;
>                 label = "quiet_temp";
>         };
>
> -       adc-chan@ADC5_AMUX_THM3_100K_PU {
> +       adc-chan@4f {
>                 reg = <ADC5_AMUX_THM3_100K_PU>;
>                 label = "lte_temp_1";
>         };
>
> -       adc-chan@ADC5_AMUX_THM4_100K_PU {
> +       adc-chan@50 {
>                 reg = <ADC5_AMUX_THM4_100K_PU>;
>                 label = "lte_temp_2";
>         };
>
> -       adc-chan@ADC5_AMUX_THM5_100K_PU {
> +       adc-chan@51 {
>                 reg = <ADC5_AMUX_THM5_100K_PU>;
>                 label = "charger_temp";
>         };
> --
> 2.20.1
>
