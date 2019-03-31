Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA38C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB13320882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014601;
	bh=x2aPP3HelVsL53S+XbUfKibqHKKAnjMb4jjLTbbBAaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jF7L1Di8zOyuSbTS+tNNN2RDyagHdCoRwRksiYoh2HrBUroohCLPvg4xw4McNySkK
	 yzbtPNTgVFpZQvrkBA6n8uCkWQawIrYH6FkkK9aSNJ35DTv4uA1jcfDSF8pbxezNlm
	 X4wrPMV2/sficJ0QcgnkfWvbm8yX3+95i7jC4jHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCaGnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:43:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40324 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfCaGmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so2924034plr.7;
        Sat, 30 Mar 2019 23:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cnEUghDqTNmkxRAWuiQB426GoABxWhgFEGm2e4BQFI=;
        b=j24kbxKxk59erqZNhF9F4yKneu0zQp7zkFFCcaq6BEGJUxJXdnpepS6MuHEkhfuEe7
         Vm7M7NIDJkdd/646Tmxzqp/9RfhKxAC5gB7BsJkWXceJ3vdxSpPoW7O+Ro9IC4FjAmhT
         Y7XSFMPxd4vPC9v7SN9OrH5TGmgsDQZG6NOfYqLq4AX0Rnc1qhkRjkAMx4DUhJjxaMDj
         qgAG+/aJfLfwIXQz6F4ek3l42UvdyXmPtUtP6fGAeN2LkjbJAYmh2/KCFHlddAL9KqI3
         q7Ca+sHvugVRQcFmDlBqMGAYhUVYHXEGMFOC5FVF8Q10kBD+0MICjFtxxs/RMMqD9JNa
         0bEA==
X-Gm-Message-State: APjAAAXuBoq9FR75Dg5ED1fhA5J059XHowUsgm4GGZHi6SHPi9z3KBJw
        qjmrEr1q8O5LAcSDs6Mhauij1W0vXA==
X-Google-Smtp-Source: APXvYqxqVMhktYMh7Clm2UY6W2Eh4iOgD+hWR38nNq6Lpxx/4W7Sv72cdgMkKtoQEIyhdbtHMc3uTQ==
X-Received: by 2002:a17:902:396a:: with SMTP id e39mr35973521plg.220.1554014523658;
        Sat, 30 Mar 2019 23:42:03 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id j19sm3277695pfh.41.2019.03.30.23.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:02 -0700 (PDT)
Message-ID: <5ca0613a.1c69fb81.6e7bf.859e@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Takao Orito <orito.takao@socionext.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-fujitsu.txt: add
 miilbeaut driver
References: <1553579617-6139-1-git-send-email-orito.takao@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553579617-6139-1-git-send-email-orito.takao@socionext.com>
X-Mutt-References: <1553579617-6139-1-git-send-email-orito.takao@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:53:37PM +0900, Takao Orito wrote:
> Add new compatible description for Milbeaut SoC. Socionext
> inherits F_SDH30 IP from Fujitsu. Then new Soc series "Milbeaut"
> has F_SDH30 controller specified by "socionext,milbeaut-m10v-sdhci-3.0".

Subject is wrong, you're not adding a driver.

> 
> Signed-off-by: Takao Orito <orito.takao@socionext.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> index 3ee9263..405811f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> @@ -1,10 +1,10 @@
> -* Fujitsu SDHCI controller
> +* Fujitsu/Socionext SDHCI controller
>  
>  This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci_f_sdh30 driver.
> +and the properties used by the sdhci_f_sdh30.
>  
>  Required properties:
> -- compatible: "fujitsu,mb86s70-sdhci-3.0"
> +- compatible: "fujitsu,mb86s70-sdhci-3.0", "socionext,milbeaut-m10v-sdhci-3.0"

One per line please.

>  - clocks: Must contain an entry for each entry in clock-names. It is a
>    list of phandles and clock-specifier pairs.
>    See ../clocks/clock-bindings.txt for details.
> @@ -17,6 +17,8 @@ Optional properties:
>    as the VCCQ/VDD_IO supply in the eMMC/SD specs.
>  - fujitsu,cmd-dat-delay-select: boolean property indicating that this host
>    requires the CMD_DAT_DELAY control to be enabled.
> +- sni,mmc-power-gpio: set property indicating that power on or off needs
> +  control of gpio. This is for only "socionext,milbeaut-m10v-sdhci-3.0".

s/-gpio/-gpios/

>  
>  Example:
>  
> @@ -30,3 +32,17 @@ Example:
>  		clocks = <&clock 2 2 0>, <&clock 2 3 0>;
>  		clock-names = "iface", "core";
>  	};
> +
> +Exsample2:
> +	sdhci3: mmc@1b010000 {
> +		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +		reg = <0x1b010000 0x10000>;
> +		interrupts = <0 265 0x4>;
> +		voltage-ranges = <3300 3300>;
> +		bus-width = <4>;
> +		clocks = <&uhs1clk2>, <&ahb_clk>;
> +		clock-names = "core", "iface";
> +		cap-sdio-irq;
> +		sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
> +			   fujitsu,cmd-dat-delay-select;

Indentation problem.

> +	};
> -- 
> 1.9.1
> 
> 

