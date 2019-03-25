Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4022C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E820854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553518019;
	bh=fUdSUbBMpsVvFaKi/bJYNYhcIsVGDtmt4ZCl4ZILm5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HS+98EaJahcygN/9tchgbfZqLoaoX6bx8pB3m7L6xZ1Vivf0VNSmhrhf0YN+ulKsP
	 f21loME+yasjOFdew+nF7qIHzjbenYQ/MfCJJq2ytGJYx61+hjPq44aMX+t8pAW8z8
	 B1C208iZb/3GjIk+2FrXn64kncy6l5WHvBmB/yxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfCYMq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730858AbfCYMq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:46:58 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E1C2087E;
        Mon, 25 Mar 2019 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553518016;
        bh=fUdSUbBMpsVvFaKi/bJYNYhcIsVGDtmt4ZCl4ZILm5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0oAcTLgbFUzW8AOgGiQyMWjSdH2nJQ7S5Ilp/nnXuMfmiZdlrX0fBF71QnxTweE53
         iSCmzE/KpEz9T2p0gz6MMU3TvU4oh9RylM7Vhc0lw64TA9ZdlJlXeaQSElMGXuRPC8
         kBknV+wW46zhTBWPmUr0ZljbkeCNRmiVvqV5b37Y=
Received: by mail-lf1-f51.google.com with SMTP id g7so5890554lfh.10;
        Mon, 25 Mar 2019 05:46:56 -0700 (PDT)
X-Gm-Message-State: APjAAAVHiRsz1d3bpxjEbDcf/CVzAa9g1ne6XfkNWMyZCqmY2I8l930Q
        cKiPyDOjAlZEzBgzRlMmazVL09BlhQr9CfCkge8=
X-Google-Smtp-Source: APXvYqwxvRX+I+PmYvHe6LlOXehKNzZm7fhwcyZRK5jIX30aetNz1q6OtRtm0GgeLmJZVdYfZEciFg1nuF6lWrXykPs=
X-Received: by 2002:a19:7105:: with SMTP id m5mr12496806lfc.154.1553518014318;
 Mon, 25 Mar 2019 05:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190324083256.1047-1-linux.amoon@gmail.com>
In-Reply-To: <20190324083256.1047-1-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 25 Mar 2019 13:46:43 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfLyLRwJKWcMCtDg10em2pfWZJzXr8FkFTf1vtavRdoTw@mail.gmail.com>
Message-ID: <CAJKOXPfLyLRwJKWcMCtDg10em2pfWZJzXr8FkFTf1vtavRdoTw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 at 09:33, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add suspend-to-mem node to regulator core to be enabled or disabled
> during system suspend and also support changing the regulator operating
> mode during runtime and when the system enter sleep mode (stand by mode).
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Current patch:
>
> Note: Both microSD and eMMC suspend resume works this changes at my end.
>
> regulator-off-in-suspend:
> set the regulator node into suspend state i.e. standby mode during suspend
> operation.
>
> Current changes are based on
> [0] https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/max77686.txt
>
>   Regulators which can be turned off during system suspend:
>         -LDOn   :       2, 6-8, 10-12, 14-16,
>         -BUCKn  :       1-4.
>   Use standard regulator bindings for it ('regulator-off-in-suspend').
>
> drop the suspend off binding which are not supported by the driver.
>
> RFC version
> [1] https://patchwork.kernel.org/patch/10810909/
> These changes had some problem with eMMC not entering into suspend mode.
> with some miss configuration in regulator-off-in-suspend mode.
>
> Changes from previos patch.
> [2] https://patchwork.kernel.org/patch/10712549/
>
> Set all the non used regulator in suspend-odd state
> LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
>
> BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
> ---
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 08d3a0a7b4eb..375156ad5454 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -288,6 +288,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;

Please maintain proper versioning of patches.
First patch sent to lists should be either RFC or v1. Second
release/submission is then always v2. Third v3.

This is third or fourth submission but you marked it as v1. This makes
it very difficult to discuss and reference previous versions.

The commit message did not change since beginning (first version). I
asked twice that you need to explain exactly why you put the the
regulator to off or on state in suspend. Why?
Because:
1. This change looks without justification - once you put on, then you
put off, now again on,
2. Anyone reading the code later must know the rationale why this was done,
3. I am not quite sure whether this is good setting so I would be
happy to be convinced.

How to provide such explanation? The best in commit message. Sometimes
in the comment in the code, depends.
How such explanation could look like? For example like this:
f8f3b7fc21b1 ("ARM: dts: exynos: Fix regulators configuration on Peach
Pi/Pit Chromebooks")
Marek clearly explained why he put the regulators "always-on", even
tough we do not know everything about this. More over, he mentions
that this fixes specific issue.

Summarizing, please answer:
1. Why this is made off-in-suspend?
2. Why this can be made off-in-suspend?

> +                               };
>                         };
>
>                         ldo3_reg: LDO3 {
> @@ -317,6 +320,9 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo7_reg: LDO7 {
> @@ -324,18 +330,27 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo8_reg: LDO8 {
>                                 regulator-name = "VDD10_HDMI_1.0V";
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo10_reg: LDO10 {
>                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo11_reg: LDO11 {
> @@ -343,6 +358,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo12_reg: LDO12 {
> @@ -351,6 +369,9 @@
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo13_reg: LDO13 {
> @@ -367,6 +388,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo15_reg: LDO15 {
> @@ -375,6 +399,9 @@
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo16_reg: LDO16 {
> @@ -383,6 +410,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo20_reg: LDO20 {
> @@ -421,6 +451,9 @@
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };

I questioned this change two times. You did not answer to my
question... If you turn memory bus regulator off, how the memory will
work in Suspend-to-Memory mode? I might be missing here something but
it just looks suspicious. Maybe the regulator does not supply the
memory itself (so refresh works even when it is down), just the
interface? I don't know, it just looks suspicious. I need to see
proper explanation.

I am sorry but I will not check other hunks in this patch. Please
provide the answers for all my questions here first.

Best regards,
Krzysztof

>
>                         buck2_reg: BUCK2 {
> @@ -437,6 +470,9 @@
>                                 regulator-max-microvolt = <1050000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };

>
>                         buck4_reg: BUCK4 {
> @@ -444,6 +480,9 @@
>                                 regulator-min-microvolt = <900000>;
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-microvolt-offset = <50000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck5_reg: BUCK5 {
> --
> 2.21.0
>
