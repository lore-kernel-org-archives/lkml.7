Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfCZROK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:14:10 -0400
Received: from ns.iliad.fr ([212.27.33.1]:47002 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:14:10 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1FF9C20B46;
        Tue, 26 Mar 2019 18:14:08 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B1FB320AC5;
        Tue, 26 Mar 2019 18:14:07 +0100 (CET)
Subject: Re: [PATCH] arm64: dts: msm8998: Add UFS phy reset
To:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190326170518.157317-1-evgreen@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <71cde29a-aa10-0889-9581-8e961670bc45@free.fr>
Date:   Tue, 26 Mar 2019 18:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326170518.157317-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 26 18:14:08 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 18:05, Evan Green wrote:

> With the new refactoring at [1], the UFS phy now controls its own
> destiny in toggling the phy reset bit within the UFS host controller.
> Add the DT pieces needed to 1) expose the reset controller from the
> HC, and 2) use it from the PHY. This series is based atop linux-next
> plus Marc's series at [2].
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> [1] https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/
> [2] https://lore.kernel.org/lkml/43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr/
> 
> ---
> I haven't tested this. Marc, I'm hoping you'll test this out and hijack this
> patch if it needs any fixups.
> 
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 3d0aeb3211de..d59a2c5fe83a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -990,6 +990,7 @@
>  			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>  			phys = <&ufsphy_lanes>;
>  			phy-names = "ufsphy";
> +			#reset-cells = <1>;
>  			lanes-per-direction = <2>;
>  			power-domains = <&gcc UFS_GDSC>;
>  
> @@ -1039,6 +1040,7 @@
>  				<&gcc GCC_UFS_CLKREF_CLK>,
>  				<&gcc GCC_UFS_PHY_AUX_CLK>;
>  
> +			resets = <&ufshc 0>;
>  			ufsphy_lanes: lanes@1da7400 {
>  				reg = <0x01da7400 0x128>,
>  				      <0x01da7600 0x1fc>,
> 

If it's OK with you, I plan to test this patch tomorrow, and simply squash it
into my UFS DT submission.

Regards.
