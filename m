Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C230C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE820836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRzrM9CH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfLKTdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:33:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36819 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLKTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:33:24 -0500
Received: by mail-io1-f65.google.com with SMTP id a22so52367ios.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0GnCXUP/rt2kD7SVBsnLqKTMBM6DXMgVGMRet+WNr4=;
        b=aRzrM9CHup/vwOWQgB4+u1rnO1ABVJfcbsE8w13cgufyfGcV6028CEkXri0+4Znwxa
         mZcZ3AlduhOY2l13Ol/SkGjN1xyLKL8qx0qqk2yeYbGcN0b4ly2EXf/7GFORCQb2GMJH
         gzHi0u6pL4qxuSBGh6FaOen+F48Cm3jRMRIo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0GnCXUP/rt2kD7SVBsnLqKTMBM6DXMgVGMRet+WNr4=;
        b=tEEmiyMB5nubDjmmgf1wLCpAmVp8D3DCSK3TAzYkUowrGK9HmlKsKJWIHkBMUXInFD
         fLyyjqMcnDElBD8i8Xjo9s90CHkxIhSNLX0Fd8gEhFBIf3NdiYXgKCiDBiA0W5Mlvwj6
         OQYJNH+/iwGakwtPBYQaw4fF7g0NLkWIuGBl/VJautLgan0Uw+tWqh7/4iOduDMKiTPG
         CtQsU0xVBaO7F886fuS9/A2FGv94fpwkLqZcJMAzxENDC1+vcy1VJ4sAitcfR15RdmzD
         HB0MixQ8Jc1Z4wYUooviANbFIEEJDvMQuCiNXhzGZApKzw2R1Sm59UDQD6bMohHtk1a6
         t5Tg==
X-Gm-Message-State: APjAAAXV8kmnIL/hmEQpKP1jweUpzpjl+kvx0JJJAYOVOY98FbQvgEhl
        r8TgW0oEeOdzD/fMr3YTGsk1rxGCKkI=
X-Google-Smtp-Source: APXvYqw2WIWnOVDJY2ySMwb1IAfucxPw970qfv6pasS1RLBJcN8caEYLw7iWXgPlyga7P2CiwfXu5A==
X-Received: by 2002:a6b:ec0f:: with SMTP id c15mr3778980ioh.149.1576092803832;
        Wed, 11 Dec 2019 11:33:23 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id 18sm956589ilx.68.2019.12.11.11.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:33:22 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id w13so20518567ilo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:33:22 -0800 (PST)
X-Received: by 2002:a92:911b:: with SMTP id t27mr4697277ild.142.1576092802436;
 Wed, 11 Dec 2019 11:33:22 -0800 (PST)
MIME-Version: 1.0
References: <1574934847-30372-1-git-send-email-rkambl@codeaurora.org> <1574934847-30372-2-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1574934847-30372-2-git-send-email-rkambl@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 11:33:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UtHebABCpJo1QUc6C2v2iZq2rFL+pTMx=EHBL+7d=jTQ@mail.gmail.com>
Message-ID: <CAD=FV=UtHebABCpJo1QUc6C2v2iZq2rFL+pTMx=EHBL+7d=jTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sc7180: Add device node support
 for TSENS in SC7180
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, sanm@codeaurora.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2019 at 1:55 AM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Add TSENS node and user thermal zone for TSENS sensors in SC7180.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 527 +++++++++++++++++++++++++++++++++++
>  1 file changed, 527 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 666e9b9..6656ffc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -911,6 +911,26 @@
>                         status = "disabled";
>                 };
>
> +               tsens0: thermal-sensor@c263000 {
> +                       compatible = "qcom,sc7180-tsens","qcom,tsens-v2";
> +                       reg = <0 0x0c263000 0 0x1ff>, /* TM */
> +                               <0 0x0c222000 0 0x1ff>; /* SROT */
> +                       #qcom,sensors = <15>;
> +                       interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "uplow";

Can you also send a patch to match Amit's ("arm64: dts: sdm845:
thermal: Add critical interrupt support") [1].  If I'm reading things
correctly it should be 508 for tsens0 and 509 for tsens1 just like on
sdm845.

[1] https://lore.kernel.org/r/c536e9cdb448bbad3441f6580fa57f1f921fb580.1573499020.git.amit.kucheria@linaro.org

-Doug
