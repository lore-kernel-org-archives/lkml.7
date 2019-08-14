Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0131CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BE2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfHNLrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:47:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726704AbfHNLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:47:50 -0400
X-UUID: 0aca0be003ce4a548dc1c3e69108f274-20190814
X-UUID: 0aca0be003ce4a548dc1c3e69108f274-20190814
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 184143578; Wed, 14 Aug 2019 19:47:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 19:47:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 19:47:44 +0800
Message-ID: <1565783263.7006.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 10/10] arm: dts: mediatek: add mt7629 pwm support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sam Shih <sam.shih@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 14 Aug 2019 19:47:43 +0800
In-Reply-To: <1565779497-23621-3-git-send-email-sam.shih@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
         <1565779497-23621-3-git-send-email-sam.shih@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 18:43 +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>
> 
> This adds pwm support for MT7629.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7629.dtsi | 14 ++++++++++++++
>  drivers/pwm/pwm-mediatek.c    |  7 +++++++
>  2 files changed, 21 insertions(+)

Split dts and driver into different patches.
 
> diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
> index 9608bc2ccb3f..352df8d61788 100644
> --- a/arch/arm/boot/dts/mt7629.dtsi
> +++ b/arch/arm/boot/dts/mt7629.dtsi
> @@ -241,6 +241,18 @@
>  			status = "disabled";
>  		};
>  
> +		pwm: pwm@11006000 {
> +			compatible = "mediatek,mt7629-pwm";
> +			reg = <0 0x11006000 0 0x1000>;
> +			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_PWM_SEL>,
> +				 <&pericfg CLK_PERI_PWM_PD>,
> +				 <&pericfg CLK_PERI_PWM1_PD>;
> +			clock-names = "top", "main", "pwm1";
> +			num-pwms = <1>;
> +			status = "disabled";
> +		};
> +
>  		i2c: i2c@11007000 {
>  			compatible = "mediatek,mt7629-i2c",
>  				     "mediatek,mt2712-i2c";
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 922a7543a2b1..d2352ca7792e 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -327,11 +327,18 @@ static const struct pwm_mediatek_of_data mt7628_pwm_data = {
>  	.has_clks = false,
>  };
>  
> +static const struct pwm_mediatek_of_data mt7629_pwm_data = {
> +	.fallback_npwms = 1,
> +	.pwm45_fixup = false,
> +	.has_clks = true,
> +};
> +
>  static const struct of_device_id pwm_mediatek_of_match[] = {
>  	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
>  	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
>  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> +	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);

It's odd. You fallback to use mt7622 compatible here: 
[PATCH v2 7/10] dt-bindings: pwm: update bindings for MT7629 SoC.


Ryder

