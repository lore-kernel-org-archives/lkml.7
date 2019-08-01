Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE63C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D782087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaOQFN1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfHAKDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:03:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43302 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAKDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:03:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so25810016qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZULYWPYrE8rlpihwiyMSrwBcvrGlh1a6lKdrHXU+DE=;
        b=yaOQFN1cXAHFGR6HJF5zWpTxEZawdshDVdIzv7UMZws9hF7VpgPqBUkt+OaHTvxXua
         i8w471kVP0keSgCewY3pHO4e9MnnuN5582Ni6sQON3RCW8mwvvYRnK9PCIZ4lyhAIHSY
         ims66j0E3nj2zbLQfW27pPzGXqiU+Q015g3sI+A+fzxWiH9ZefE9396+QNd7qQnVlKgD
         cN4EZUuAMUZwHpA0pMKtq7Fapj3lg/ajYHcOXKVNXlGWTHHtVY9HWVPWXf2uA8kMhJdd
         JkL+iA1FebZH0NTGaP/5erTpubHa8aYSRifDKiJ+/eWfFtSZ5glqdAGM1R3UZ1IlZu//
         z2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZULYWPYrE8rlpihwiyMSrwBcvrGlh1a6lKdrHXU+DE=;
        b=dKEsTgrtjRXpjJr7OvFwET3L6CJ94aev+uTwYME0Vy2HqbXxURU1a0Kwx095SPMGsq
         IWDB9ENRZCtykq3mR4YQU0yWYHbfa+IZYVE4ZQZG8izGom3ooud+wZjYrEgl93Tp7GMP
         D2kT7H03Bny09M+JkcCs5gjA8lLvd57iDx5FzckjyZfdtHIRh3fois6yzA9PSUMQHVw6
         9lilaeIHnvV98ZteOHE2Zh+nazApDQ86qT4e3P4leagBw8vics26Hh1uxVDmQ8E9HQc9
         iz6RgXHNd1LuoIJofPSeEz+Fdx5p1/x2Nv0nh7SJfp9hb82ueFpq9vWq6mQsXiIAEcnL
         VmcQ==
X-Gm-Message-State: APjAAAU671cyPRt/EbNF0bKroDsEP/idj1GQb9Yld/WrRHiIxRm8GUMU
        YZhaytpnfYaCzGsJtg8bvk+DCVBcjGxBGwVlJV0WTg==
X-Google-Smtp-Source: APXvYqyz75Bk81npKkd4YeyxzGOm77tl18qT7r4AADcTXVp+RE9M4XnBkdfTmfTW09SzYaBB6otcJQMnCCmj576+r7c=
X-Received: by 2002:a37:4e8f:: with SMTP id c137mr82670521qkb.127.1564653791552;
 Thu, 01 Aug 2019 03:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190801095049.13855-1-vkoul@kernel.org> <20190801095049.13855-2-vkoul@kernel.org>
In-Reply-To: <20190801095049.13855-2-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 1 Aug 2019 15:33:00 +0530
Message-ID: <CAP245DX5thWe-+mTH-oNeNRa_LRNX=oLvtNhQ=vt7Ukb6wrF9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: pms405: add unit name adc nodes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 3:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> The adc nodes have reg property but were missing the unit name, so add
> that to fix these warnings:
>
> arch/arm64/boot/dts/qcom/pms405.dtsi:91.12-94.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/ref_gnd: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:96.14-99.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/vref_1p25: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:101.19-104.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/vph_pwr: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:106.13-109.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/die_temp: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:111.27-116.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/thermistor1: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:118.27-123.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/thermistor3: node has a reg or ranges property, but no unit name
> arch/arm64/boot/dts/qcom/pms405.dtsi:125.22-130.6: Warning (unit_address_vs_reg): /soc@0/spmi@200f000/pms405@0/adc@3100/xo_temp: node has a reg or ranges property, but no unit name
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 14240fedd916..a28386900a3b 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -88,41 +88,41 @@
>                         #size-cells = <0>;
>                         #io-channel-cells = <1>;
>
> -                       ref_gnd {
> +                       ref_gnd@0 {
>                                 reg = <ADC5_REF_GND>;
>                                 qcom,pre-scaling = <1 1>;
>                         };
>
> -                       vref_1p25 {
> +                       vref_1p25@1 {
>                                 reg = <ADC5_1P25VREF>;
>                                 qcom,pre-scaling = <1 1>;
>                         };
>
> -                       pon_1: vph_pwr {
> +                       pon_1: vph_pwr@131 {
>                                 reg = <ADC5_VPH_PWR>;
>                                 qcom,pre-scaling = <1 3>;
>                         };
>
> -                       die_temp {
> +                       die_temp@6 {
>                                 reg = <ADC5_DIE_TEMP>;
>                                 qcom,pre-scaling = <1 1>;
>                         };
>
> -                       pa_therm1: thermistor1 {
> +                       pa_therm1: thermistor1@77 {
>                                 reg = <ADC5_AMUX_THM1_100K_PU>;
>                                 qcom,ratiometric;
>                                 qcom,hw-settle-time = <200>;
>                                 qcom,pre-scaling = <1 1>;
>                         };
>
> -                       pa_therm3: thermistor3 {
> +                       pa_therm3: thermistor3@79 {
>                                 reg = <ADC5_AMUX_THM3_100K_PU>;
>                                 qcom,ratiometric;
>                                 qcom,hw-settle-time = <200>;
>                                 qcom,pre-scaling = <1 1>;
>                         };
>
> -                       xo_therm: xo_temp {
> +                       xo_therm: xo_temp@76 {
>                                 reg = <ADC5_XO_THERM_100K_PU>;
>                                 qcom,ratiometric;
>                                 qcom,hw-settle-time = <200>;
> --
> 2.20.1
>
