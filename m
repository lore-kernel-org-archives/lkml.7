Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BDC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6893F218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="aWLGjXXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGXFVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:21:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35306 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGXFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:21:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id j21so17990488uap.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUsGf36TR4zlfyZSONaQ2nNxLJ4zkif4e/MgEKViAz4=;
        b=aWLGjXXD+oLlguItxfZRUOIn8T8Nje8/gOnWCoXkXgvqeUP4ezau25tSjmqF9z6RA6
         Vf+yyb1u/mCLrIK7FeGMRbbuDdsgE0KvDf/ZfjnST3PBkVQMKyrfZ1SZ+psxll/JRzJY
         A9HT3f4EkKTesOQ42LqkD+n1eDIFP5tUwdYMX1P4IouWLiijs35a7ryGhRK8xU3n+sjC
         DgH+12qgrB5sx0T+pMsXq7hQHa9ztAPutpGqR/jpvBhm92oSTKUcBI951LFbPWTSF7de
         30SrT8OrluAFwjTpfCCyu28hLVoVZV6ctd6tcN+UuoZuGitE9SLXozoJtTvqIp/SIvMO
         c0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUsGf36TR4zlfyZSONaQ2nNxLJ4zkif4e/MgEKViAz4=;
        b=YKLNlMNYbe1xOOFWjgK6a30eg3lmqipD6xl1v++Xwtv6Ykjd8895P03pmO6SFSBbQx
         cLLXdUDr9fsL9E/scxYdROvy9PHvNur5Ts1wwOgGXEtZG4Y0WQPqsdVco4twqgLPD/NS
         +Ow3Gqqk0EJBxEY4A5A0RoHV+DJgTOVC3MM7CBMoKdazD+wp3gxDuOSseu1UkHKtv4QW
         6FsUPyzbHP84xv5kQRdxFwAtL9/os7xLaTvLHmEl2LMO+krnei9QWi8z3ay29GcD76gz
         wqwetSxi7QKrLu23n/PtxoByEP0zW9Rt2RSOWpR5Zb5eX5ErP770cma/txUyh/whHk3x
         vB+w==
X-Gm-Message-State: APjAAAXUWegUJ5sSCyLVqElZ8mphrARwSCPjTAkMa8ICOt8AOKZNB1DD
        d7y1tnLGkhmfkeVNURU5rk9H7K1XN7t5RJ3kVyw=
X-Google-Smtp-Source: APXvYqx5YalSorpO7IZK3t1/IsRJ+b1kzXKZLmI/iwekFfex4mBt6J6nQ4dB9P+ncPdqjbX2ksCgGQxh8j1A5K8CMFY=
X-Received: by 2002:ab0:23ce:: with SMTP id c14mr24279200uan.77.1563945692171;
 Tue, 23 Jul 2019 22:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190724044906.12007-1-vkoul@kernel.org> <20190724044906.12007-5-vkoul@kernel.org>
In-Reply-To: <20190724044906.12007-5-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 24 Jul 2019 10:51:21 +0530
Message-ID: <CAHLCerP-9dNG30enhb779=FGFLUZCR2EdjDQEXjt0jkQPvaJtA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sdm845: remove macro from unit name
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
> Unit name is supposed to be a number, using a macro with hex value is
> not recommended, so add the value in unit name.
>
> arch/arm64/boot/dts/qcom/pm8998.dtsi:81.18-84.6: Warning (unit_address_format): /soc/spmi@c440000/pmic@0/adc@3100/adc-chan@0x06: unit name should not have leading "0x"
> arch/arm64/boot/dts/qcom/pm8998.dtsi:81.18-84.6: Warning (unit_address_format): /soc/spmi@c440000/pmic@0/adc@3100/adc-chan@0x06: unit name should not have leading 0s
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 051a52df80f9..dc2ce23cde05 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -78,7 +78,7 @@
>                         #size-cells = <0>;
>                         #io-channel-cells = <1>;
>
> -                       adc-chan@ADC5_DIE_TEMP {
> +                       adc-chan@6 {
>                                 reg = <ADC5_DIE_TEMP>;
>                                 label = "die_temp";
>                         };
> --
> 2.20.1
>
