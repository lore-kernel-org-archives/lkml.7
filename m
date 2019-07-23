Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113CC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96DC2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="j2KDdcap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfGWFIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:08:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39191 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbfGWFIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:08:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id u3so27958575vsh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDS4gSwn4vjiBJe81KYYzL7InQAaE1qq2PXrKhXqlTs=;
        b=j2KDdcapzsm80aR134jUbGPOcIEjhGx/YtVlRLot6jVeXKbFVo2V6o2h1GGw8NGfQC
         3A1QdC8IzxVAJqs2Ts+V5VbaKUmNDsxpnBgVGkb6yp792JEqQVZAk+Fiv6MVkaZUjCcd
         MC/MWFWlp/PPKJs+hDTiDJdPKiIoE7/Avv5FZkpIhdH76Crk73OHLTGYm6G98STksvLL
         DI1NuHdqP7pAPYkerHyXPKBDJzx5JxUdCtGyvDjjOuY5kbYc+uvmaP0/B9ea4m3cuD5j
         XrPiAJRhJaLwmcM61oSGQoScFRtCqfLLOGa39hVcbEBed86bhpG1Ds/Lx+Ojewk/MIhm
         C/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDS4gSwn4vjiBJe81KYYzL7InQAaE1qq2PXrKhXqlTs=;
        b=jtASwO/aCjnke6iYLIkAkqZLxLgvBzUNwlLCMzjvvdBGI2p/IOA3b7VjW2sA3Mu+fS
         jbxfzB70f/uaWGKZgeUOh2chZXcsplCQ3FIHeteQ/6pnZro9ESBI273lj+OA2Zpqptj/
         myxy1nbd0sim4gcylGZqlaFgiIlhB4QyrvtLpEbv5BKdXiWnsscGFiUXklu4tmmnJG+3
         zJErgnJamaU3ZpRUTW8+HK907v4Z8q1MODIxHwX8lTItTWZaxYr2tfPRzEA7bdLlzLED
         aygHAnbvm5RRRv8Y3YYB8OUPaDPjduidM19RBo1Y8udduom4I18S3b0JjUqxZ9jqmOiu
         yd3w==
X-Gm-Message-State: APjAAAXJKv4UvMbI+SnWYMt7sOtOpRrwqjmkXmvmcGDymryQcvPRgZJL
        JjX/+ohIsJLTPJQUwIuyrhF0nzWf/f3QJT9i81Q=
X-Google-Smtp-Source: APXvYqxSMp8D+aU6wN4mzW36IwWXd8EVY96kOzI5ofuaEVtfyj5O46xSTrH7ZpBTy4a/02bd6633pdIqQcvPZfcuqxs=
X-Received: by 2002:a67:2e0e:: with SMTP id u14mr46945969vsu.182.1563858500194;
 Mon, 22 Jul 2019 22:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190722123422.4571-1-vkoul@kernel.org> <20190722123422.4571-6-vkoul@kernel.org>
In-Reply-To: <20190722123422.4571-6-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 23 Jul 2019 10:38:09 +0530
Message-ID: <CAHLCerPC0thO9gsaDAxc+XaexinrzG6JGJ8BhB4bFFuQ-P9Jxg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm845-cheza: remove macro from
 unit name
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 6:06 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Unit name is supposed to be a number, using a macro with hex value is

/s/name/address?

> not recommended, so add the value in unit name.
>
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:966.16-969.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4d: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:971.16-974.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4e: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:976.16-979.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x4f: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:981.16-984.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x50: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:986.16-989.4: Warning (unit_address_format): /soc@0/spmi@c440000/pmic@0/adc@3100/adc-chan@0x51: unit name should not have leading "0x"
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
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

I'm a little conflicted about this change. If we're replacing the
address with actual values, perhaps we should do that same for the reg
property to keep them in sync? Admittedly though, it is a bit easier
to read the macro name and figure out its meaning.

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
