Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E2024677
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KRnCRFPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLFMZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:25:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36531 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfLFMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:25:35 -0500
Received: by mail-io1-f68.google.com with SMTP id l17so7160890ioj.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQbiMMJE8zlEQh6DwgZn6s76A3bT/QzQpsrN16dIp70=;
        b=KRnCRFPTnjxqLiK5A6xLNqlh/5sC1ibeWR446TjHu4ztvog+DzCxEGvDuSJxXwVx6H
         HYF+nNok8+hHYVd1qh6X6b6KnYPoEggHX9uC4Re4XQmkgD37I/5ZD4n2xlA6hCXbm21K
         6f2UXAlpzsWPPqJ+JPtpcacjJktLBaF5y/wzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQbiMMJE8zlEQh6DwgZn6s76A3bT/QzQpsrN16dIp70=;
        b=OXLhU36v+HZ5imh9iv26bZXQGdWHK5uKkElEKcJPChE661XktgmGzauaXtkOBN+OvQ
         AyKA3UfuKEHBqRL/WuzSkaIWG83rk4TMYGPvk9F1Lnw1CaKUfj6+C9VtVDRpO54F1BQb
         Xwv5mvjv3mvGtc/LyR0wUPSdZfqZIKN404tTXI/+rbhQmEBNoSwvnisHRJxaN2COVcCt
         jBekgzNAB8KsTUrrCHcolGbXEoWeYUu3dUeUeQE3eSYLVMmU6IqJixTw5WGzznLUcX1u
         2j3CLm6JSV0bYkkCgj0njQ/UB9gbp30YaKqC5hPQ3XueYDwMNr4QjDEBzbHH2TzCrnUn
         0R2A==
X-Gm-Message-State: APjAAAUq5jyS7mwnkOVxwSF6+JDmnyol86wFWhqNs6UWIXyFoxwLgiyo
        RBWVHGC/IcGyP+wt7PlFkZdJmEyYlmA=
X-Google-Smtp-Source: APXvYqwTIsuZr6FUMy3YuAZoBZw36OV7U8VWFa/kI4C4yNm50TX8FyqNy83dnO7IcrGYsLjSmonYKA==
X-Received: by 2002:a05:6638:29c:: with SMTP id c28mr13450495jaq.23.1575635134222;
        Fri, 06 Dec 2019 04:25:34 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id r22sm3837471ilb.25.2019.12.06.04.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 04:25:32 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id t17so6040357ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 04:25:32 -0800 (PST)
X-Received: by 2002:a92:46c8:: with SMTP id d69mr14733574ilk.168.1575635132283;
 Fri, 06 Dec 2019 04:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20191108092824.9773-1-rnayak@codeaurora.org> <20191108092824.9773-14-rnayak@codeaurora.org>
In-Reply-To: <20191108092824.9773-14-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Dec 2019 20:25:20 +0800
X-Gmail-Original-Message-ID: <CAD=FV=VUoj1egZqw9koNHDPBCCEh_XZ5nZAPNKcnya2UACG8hw@mail.gmail.com>
Message-ID: <CAD=FV=VUoj1egZqw9koNHDPBCCEh_XZ5nZAPNKcnya2UACG8hw@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] arm64: dts: sc7180: Add qupv3_0 and qupv3_1
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 8, 2019 at 5:29 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>
> Add QUP SE instances configuration for sc7180.
>
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 146 +++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 675 ++++++++++++++++++++++++
>  2 files changed, 821 insertions(+)

Comments below could be done in a follow-up patch if it makes more sense.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index e1d6278d85f7..666e9b92c7ad 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi

At the top of this file, please add aliases for all i2c and spi
devices (like sdm845 did).  Right now trying to use command line i2c
tools is super confusing because busses are super jumbled.


> +                       i2c2: i2c@888000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00888000 0 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c2_default>;
> +                               interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               status = "disabled";
> +                       };

Where is spi2?


> +                       i2c4: i2c@890000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00890000 0 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c4_default>;
> +                               interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               status = "disabled";
> +                       };

Where is spi4?


> +                       i2c7: i2c@a84000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00a84000 0 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c7_default>;
> +                               interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               status = "disabled";
> +                       };

Where is spi7?


> +                       i2c9: i2c@a8c000 {
> +                               compatible = "qcom,geni-i2c";
> +                               reg = <0 0x00a8c000 0 0x4000>;
> +                               clock-names = "se";
> +                               clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&qup_i2c9_default>;
> +                               interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               status = "disabled";
> +                       };

Where is spi9?


> +                       qup_spi1_default: qup-spi1-default {
> +                               pinmux {
> +                                       pins = "gpio0", "gpio1",
> +                                              "gpio2", "gpio3",
> +                                              "gpio12", "gpio94";

Please just mux one of the chip selects by default.  It seems like it
would be _much_ more common to have a single SPI device on the bus and
then every board doesn't have to override this.


> +                       qup_spi6_default: qup-spi6-default {
> +                               pinmux {
> +                                       pins = "gpio59", "gpio60",
> +                                              "gpio61", "gpio62",
> +                                              "gpio68", "gpio72";

Please just mux one of the chip selects by default.  It seems like it
would be _much_ more common to have a single SPI device on the bus and
then every board doesn't have to override this.


> +                       qup_spi10_default: qup-spi10-default {
> +                               pinmux {
> +                                       pins = "gpio86", "gpio87",
> +                                              "gpio88", "gpio89",
> +                                              "gpio90", "gpio91";

Please just mux one of the chip selects by default.  It seems like it
would be _much_ more common to have a single SPI device on the bus and
then every board doesn't have to override this.


-Doug
