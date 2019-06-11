Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC2C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E721734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxr+p7sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408262AbfFKXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:40:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44129 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408242AbfFKXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:40:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so3165579plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrcKiJncQCvJeYdovjwcGHLQkpFI9UFvyKLS0tgyyJA=;
        b=fxr+p7sgq0hHqMWtLVWiiVUmwvCK2K9niwmP89I8eDAL9RbspWdO1Z1sQG60RUq0Jh
         T2MZsogyjVAyLqkT3ee99gA8N013logxMHyCVkL7mI3YgQv2TKxq/hfKC0YKDOW0Tejm
         rPOIm4epv87XbkFyGuS0bvymTWIYvDCh+1NrywAgLDi61i8nwyH0pvvPXN+tS0oTBppj
         21RpX2SJBsR0PDumQJSP7tyvgCg+e7HUPC5gc46suhRZBioDhD1l7sO+GOgTaRyKmgCJ
         5DYz2JA/jf2MVMgTV5F8Sm7cG6RQ5CQdljOJ1kjjHo3+2itX5/elS5w8RqMKPWEOBokX
         zYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrcKiJncQCvJeYdovjwcGHLQkpFI9UFvyKLS0tgyyJA=;
        b=JVxkYXq/elM8sIbWNXqvOyjOqBxE8xE/63YHK1SglZul2+0rSRLlXJfrnQNP3BKtv1
         0QaU4H9ZRHaH3nhzpqNQhHY2SS3+ZCfeaBjTOGScbTAKhCtJi1fXTk5sByk/z6b1pZvq
         0mOhbL1CdnmTnXTgc9xfECP/sso6bURFfg4vk7TVy1IAE76FLlKgRsTTasR7PcOV3IOP
         ulSrLeP1jIwFe++LF9aBYhYljDuqGUnMHicWn/ZuOhmkKyC/rlwF7eJBrBaFPZYVQthe
         5Jsp7lVYHZJpmhbn14X9FS0FJYwANSwQyX1D425EvadPBE5vVduGftX0xMX4UaRWaEwB
         9LuQ==
X-Gm-Message-State: APjAAAUZbZTUXcX6siQQRxcsKqGavKS8n/edNsCk9XKAO/ob/xBTbwHF
        JvN7T++Ic3gPalhzAdEC7RCRUg==
X-Google-Smtp-Source: APXvYqwVvSeKZ9+8pgl/U+yQv0XwTRD+oXRVoAp/CkKUZM51Vh73fYHUpTMj6hpKkhxVYtdA9svC7A==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr11863733plz.335.1560296422678;
        Tue, 11 Jun 2019 16:40:22 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h11sm17090333pfn.170.2019.06.11.16.40.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:40:22 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:40:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcs404: Add interconnect provider DT
 nodes
Message-ID: <20190611234020.GX4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-6-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

> Add the DT nodes for the network-on-chip interconnect buses found
> on qcs404-based platforms.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v3:
> - Updated according to the new binding: added reg property and moved under the
>   "soc" node.
> 
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index ffedf9640af7..07ff592233b6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2018, Linaro Limited
>  
> +#include <dt-bindings/interconnect/qcom,qcs404.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> @@ -411,6 +412,33 @@
>  			#interrupt-cells = <4>;
>  		};
>  
> +		bimc: interconnect@400000 {

Please maintain sort order of address, node name, label name. So this
should go between rng@e3000 and remoteproc@b00000.

Other than that:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
> +			reg = <0x00400000 0x80000>;
> +			compatible = "qcom,qcs404-bimc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
> +		pcnoc: interconnect@500000 {
> +			reg = <0x00500000 0x15080>;
> +			compatible = "qcom,qcs404-pcnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@580000 {
> +			reg = <0x00580000 0x23080>;
> +			compatible = "qcom,qcs404-snoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +
>  		sdcc1: sdcc@7804000 {
>  			compatible = "qcom,sdhci-msm-v5";
>  			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
