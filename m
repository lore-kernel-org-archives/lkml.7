Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9317C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BD920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaxgPyuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfG3Ux0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:53:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44578 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfG3Ux0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:53:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so28761325lfm.11;
        Tue, 30 Jul 2019 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jclYugzhKXhlJk5pUhgZFfSAA+o8PyYYOEPmXaFzQW0=;
        b=qaxgPyuHjV8eQsxdgIXD6wSNKdaV7/pZgBLwWou4xmbqtxd22n3RB6hJz1KSiu5xjE
         8UHPBLHvHKLP7q8bZyn+tmK4I/4UbgvCxL5fxdwaI7Unom7vdlBrqnG4HVHFJse72zYZ
         3/GVsiQCC0s/AjkKO61Yfl4e3sykcWMgze90gIJCDiNDG+q8cWZpXRc6PZMtJzidX0ND
         b4JPeaOPnBxjx9NWxcsIqLEgdEPqeXYhmEM5lnkp+jAs3fq5TNul0KPlGCVgaIm6DLKc
         wA3IM5hNgTn9JQwHv+jGH2Eq7VyN78RUn8myQ3d13Am56YVRvLGcXRMPzzR3eGU+5mjc
         SWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jclYugzhKXhlJk5pUhgZFfSAA+o8PyYYOEPmXaFzQW0=;
        b=GqsDpju4pECa9TBaGvu+6P4EtbIUBoSgo1ojvusXkSVK2YlavHmjN1Jd4zuYC0QANO
         tW/MRt+FL0Uwymyz3xTYV+KAu9rrk6Ii3veKvqvpvjDTaq1CbKRiyRqgSsCF4dQMDuNJ
         6qnUUbL35uJwBSSA2t3/FCfoRal7GOBj8Phz7SlTgWGEkcbZ4OxI0HdBa4rm1BLbHjwW
         1ErZiY/0pZ8nAHj0IJG/O2UBKrjAtybvAsLM39B8gTS4uGG1s+cIwF5Rk0DiI9jxf/NV
         6a/HZ7dLqPF8v2Ahf4UChvSCKJDiyFSjfD3rbOhPs5t5jgOxp3ieuGC5eLU4zYLOniKu
         q3rA==
X-Gm-Message-State: APjAAAXBtwOqcGFo1Gd4KFNNHvEFB5q/hWJR6pR+wI+saL8oE80svnFe
        isq+r7nLwO+bD3tglikxIO6JADwFDxTbXNaZPTA=
X-Google-Smtp-Source: APXvYqxLZbcQkNGLt2aGD4ZsshnY4scI1t46ayvot4F2God2/3h/JlTnUrnkZHuI2ef6+Z6FMDVVioV953qAvR1vzWQ=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr24102009lfp.44.1564520003726;
 Tue, 30 Jul 2019 13:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190730144649.19022-1-dev@pschenker.ch> <20190730144649.19022-15-dev@pschenker.ch>
In-Reply-To: <20190730144649.19022-15-dev@pschenker.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 17:53:28 -0300
Message-ID: <CAOMZO5BtXFR7kDuiHedsDA0AaNZqsO_L2x9d3u9ZuULkovChoQ@mail.gmail.com>
Subject: Re: [PATCH 14/22] ARM: dts: apalis-imx6: Add some example I2C devices
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:57 AM Philippe Schenker <dev@pschenker.ch> wrote:

>  &backlight {
> @@ -204,6 +228,77 @@
>   */
>  &i2c3 {
>         status = "okay";
> +
> +       adv7280: adv7280@21 {
> +               compatible = "adv7280";
> +               reg = <0x21>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ipu1_csi0 &pinctrl_cam_mclk>;
> +               clocks = <&clks 200>;

Please replace this 200 with a proper clock label.

> +               clock-names = "csi_mclk";
> +               DOVDD-supply = <&reg_3p3v>;
> +               AVDD-supply = <&reg_3p3v>;
> +               DVDD-supply = <&reg_3p3v>;
> +               PVDD-supply = <&reg_3p3v>;
> +               csi_id = <0>;

This is not a valid property upstream.

It seems you just ported it from a downstream vendor kernel. Please
make sure you test with the dt-bindings from mainline.

> +               mclk = <24000000>;
> +               mclk_source = <1>;
> +               status = "okay";
> +       };
> +
> +       /* Video ADC on Analog Camera Module */
> +       adv7180: adv7180@21 {
> +               compatible = "adv,adv7180";
> +               reg = <0x21>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ipu1_csi0 &pinctrl_cam_mclk>;
> +               clocks = <&clks 200>;

clock label, please.

> +               clock-names = "csi_mclk";
> +               DOVDD-supply = <&reg_3p3v>; /* 3.3v */
> +               AVDD-supply = <&reg_3p3v>;  /* 1.8v */
> +               DVDD-supply = <&reg_3p3v>;  /* 1.8v */
> +               PVDD-supply = <&reg_3p3v>;  /* 1.8v */
> +               csi_id = <0>;

Same here

> +               mclk = <24000000>;
> +               mclk_source = <1>;
> +               cvbs = <1>;
> +               status = "disabled";
> +       };
> +
> +       max9526: max9526@20 {
> +               compatible = "maxim,max9526";

This is not documented in mainline.
