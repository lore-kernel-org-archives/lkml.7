Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4182208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="bfRmn94O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfG3QhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:37:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44915 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbfG3QhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:37:11 -0400
Received: by mail-vs1-f65.google.com with SMTP id v129so43930056vsb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8HCJbR2Mhe0sKe4++gHcvWYSq09tM8u85CdPclvS5w=;
        b=bfRmn94OZPe5caex7FIA8ZOcduJbSIft+MY+RL++KKwg5wm02CZ3Fa4kleLBd6KoGq
         t5nsIpWulQ9G1ogHaUcgY3QzZp1joXjxEb1pjUVM29bthgHAKRTh+lO533PQ881hiyNq
         2P71WQXw548WFivw9BmZGr7fqlZXTk6dyIQrlhMsz7K3mYVJxaHRrSCWEzshCmPBxHoc
         eqqPSUdqtwsTfegFqibm9oLCrSY2KVA379zqDXz4Zvs9cJwQkVx+2WiLZOilIWBZrpqw
         A/Qa16w8VaN+vUyM7/dGkUZfME/7eaaA5Feq1f8VerXTFVi9Q/v6gQkRWXPKXwEqQQB/
         X7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8HCJbR2Mhe0sKe4++gHcvWYSq09tM8u85CdPclvS5w=;
        b=B5+dn6Fntr8qVJqSvtK6ue6JYKN5dI9g2Fze4196S029a8hSJmFv74VR7eDC/E3jMB
         6t4agSHUJRFobW+zNOmmxMVuRjQtK5xtcNBMeVo4sxv5UcvMcwjLnvYWMEhjHQu1aBHT
         pOTcsbkZ5cLtqO+aW316X4GvIogrBce71d5lkX0rvmvibERI8U5KFXJ6mJo3DokfPKXG
         MONpPYO5HF35W6p+VYUJjm1p7qTrW4ZMB0bSvu7/uYF1z2KFF0rYtc8giVpVEWS6EYuM
         L0dJoER+CsG0alBSr2WALP22LWOe+FGW5zbwoUBg7DHUcBzJY+gPxM6alOR8RLDZeJwe
         67jA==
X-Gm-Message-State: APjAAAXOivVb4nXpwhIwKGv2Jcj2UOrNFW1RtDtDz7d3savkGSHfiiZo
        V+FmCLXy9S3TUcafbdB7mdmC1EODwXCFsK8vfEw=
X-Google-Smtp-Source: APXvYqzvihmK8My2j7FHLPOl7FsK0yHAvPIOj9lWSKSiAiSBrMtdm3WULEjW5x4nfsE+m9kK0Py3rCsKZ9uz7kve8Ro=
X-Received: by 2002:a67:d990:: with SMTP id u16mr74149121vsj.95.1564504630056;
 Tue, 30 Jul 2019 09:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190725135150.9972-1-vkoul@kernel.org> <20190725135150.9972-3-vkoul@kernel.org>
In-Reply-To: <20190725135150.9972-3-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 30 Jul 2019 22:06:59 +0530
Message-ID: <CAHLCerNCcLSsV2JKqM1FW86wgQhNimMYdc0_2KPqZzDgwSkt-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pms405: remove reduandant properties
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

On Thu, Jul 25, 2019 at 7:23 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> pms405@1 nodes specified unnecessary #address-cells/#size-cells but the
> subnodes dont have "ranges" or "reg" so remove it
>
> arch/arm64/boot/dts/qcom/pms405.dtsi:141.21-150.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@200f000/pms405@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 3c10cf04d26e..32678f7ce90d 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -141,8 +141,6 @@
>         pms405_1: pms405@1 {
>                 compatible = "qcom,spmi-pmic";
>                 reg = <0x1 SPMI_USID>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
>
>                 pms405_spmi_regulators: regulators {
>                         compatible = "qcom,pms405-regulators";
> --
> 2.20.1
>
