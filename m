Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBEC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBB62173E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfFJNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:46:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390481AbfFJNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:45:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A863CADD9;
        Mon, 10 Jun 2019 13:45:37 +0000 (UTC)
Subject: Re: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
Date:   Mon, 10 Jun 2019 15:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> Add devicetree binding for Actions Semi Owl SoC's SD/MMC/SDIO controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/mmc/owl-mmc.txt       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt

Rob, should this be YAML now?

> 
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.txt b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> new file mode 100644
> index 000000000000..a702f8d66cec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> @@ -0,0 +1,37 @@
> +Actions Semi Owl SoCs SD/MMC/SDIO controller
> +
> +Required properties:
> +- compatible: should be "actions,owl-mmc"
> +- reg: offset and length of the register set for the device.
> +- interrupts: single interrupt specifier.
> +- clocks: single clock specifier of the controller clock.
> +- resets: phandle to the reset line.
> +- dma-names: should be "mmc".
> +- dmas: single DMA channel specifier

I recall the main blocker for MMC being regulators, i.e. the I²C
attached multi-function PMIC. Yet I don't see any such required property
here, nor any patch series implementing it. Seems like this relies on
U-Boot having initialized SD/eMMC? Do you intend to make them optional
or did you want to hold off merging this one until the rest is done?

> +
> +Optional properties:
> +- pinctrl-names: pinctrl state names "default" must be defined.
> +- pinctrl-0: phandle referencing pin configuration of the controller.
> +- bus-width: see mmc.txt
> +- cap-sd-highspeed: see mmc.txt
> +- cap-mmc-highspeed: see mmc.txt
> +- sd-uhs-sdr12: see mmc.txt
> +- sd-uhs-sdr25: see mmc.txt
> +- sd-uhs-sdr50: see mmc.txt
> +- non-removable: see mmc.txt

I'm not convinced duplicating common properties is a good idea here, in
particular pinctrl.

Regards,
Andreas

> +
> +Example:
> +
> +		mmc0: mmc@e0330000 {
> +			compatible = "actions,owl-mmc";
> +			reg = <0x0 0xe0330000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD0>;
> +			resets = <&cmu RESET_SD0>;
> +			dmas = <&dma 2>;
> +			dma-names = "mmc";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_default>;
> +			bus-width = <4>;
> +			cap-sd-highspeed;
> +		};
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
