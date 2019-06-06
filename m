Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC4EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559802127;
	bh=APfyBG2fyrPz68QqYZ1pqp6URdwzAiGlAVa4nP58yZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9ba8ThbRZNTAoB1dKhP0xXaW8/EF4yC0xPlUfEukBepFWQJu5JlQy9PCuiwhTP4A
	 +C612pjVQ70BGQzLx+KNxri8/nzGz68myDRycLaprikz4p93/kjlO3xu7GqoGmzmEA
	 5aK0wy+95HmCfHz8CbK2UrWGPBD+4Z/NGe2m/e+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFFGWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFFGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:22:06 -0400
Received: from localhost (unknown [106.200.230.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACE52083D;
        Thu,  6 Jun 2019 06:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559802125;
        bh=APfyBG2fyrPz68QqYZ1pqp6URdwzAiGlAVa4nP58yZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgIZqJBcKNmUDG+OlyFyWa6p1X88k6vww3vudl+DfBf72LOMikPCA+kmsldhxbB7c
         JAT6lwaI0LqnJf0YpTAmdmX6mL44JNHhGxv76MEu80S9FKKk/7zm+BngWqh2aWYLgk
         nqg8WY9RctYK0zcY6J2zgfvVzgkcYE+jXrFYfZMk=
Date:   Thu, 6 Jun 2019 11:48:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Dragonboard 845c
Message-ID: <20190606061857.GA9160@vkoul-mobl.Dlink>
References: <20190606043851.18050-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606043851.18050-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-19, 21:38, Bjorn Andersson wrote:
> This adds an initial dts for the Dragonboard 845. Supported
> functionality includes Debug UART, UFS, USB-C (peripheral), USB-A
> (host), microSD-card and Bluetooth.
> 
> Initializing the SMMU is clearing the mapping used for the splash screen
> framebuffer, which causes the board to reboot. This can be worked around
> using:
> 
>   fastboot oem select-display-panel none

I was able to boot db845c on v5.2-rc1 with this patch :)
 
I found some nits, nevertheless this looks good, so:
 
Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>

> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -0,0 +1,556 @@
> +// SPDX-License-Identifier: GPL-2.0

No copyright?

> +	pcie0_3p3v_dual: vldo-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VLDO_3V3";
> +
> +		vin-supply = <&vbat>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie0_pwren_state>;
> +	};
> +
> +	gpio_keys {

Rest of this file is sorted but this isn't, so this should be after dc12v

> +		compatible = "gpio-keys";
> +		#address-cells = <1>;

does this require address cell, we don't have range property here?

> +		#size-cells = <0>;
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_pin_a>;
> +
> +		vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {

This one as well..

-- 
~Vinod
