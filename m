Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D79C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA52166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562621195;
	bh=93BPMdg+/3HbS6/dSjd8anVXbZl2hVtnxVUevvrbOtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gaaU4vPifdzM2/Y8++hnYurKmso2+dX9yq1tiD7h+HJ8yR8Vu1uSJT6MHBJiW347
	 h3Y9JHbFNMBMkTOVVrqQBfzxBPVSUMpQlcKOnM1Uw9/m/4CP7sLbI4KBkqx5iWII4z
	 2q6TuWSmHp22qYwClAk+Y9IiIVqMkhD+TN8BHEF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405351AbfGHV0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:26:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35190 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfGHV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:26:33 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so29138575ioo.2;
        Mon, 08 Jul 2019 14:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7fXKeiClICgqG3v+Ut8S7n41qL1cebh6VZTxCjQl7Y=;
        b=jCPPLXTklM+ZdELECEwJyNbJhUosjJe4wO5QqKGWUkcAQeuEWpA8cUXW6SyG6VsfWL
         eSctjPLMGgKfeXQyogsOT0Z7J1neYcLTPsSGbnHDFXxF7aM/sfDS5A6jeF6RbOmNTvUY
         Mya+oHvlVn1aHD+/U7LC0Sg/EMgm0KtmsHR57BAETgB0nDZFyeyZNyEA7Wl8T4Ut50iW
         uCv3ZlS2/6UiNTK973KZzfZYvHVYyJhbwFHvpDQROCc787NIQ4U0dMQg5inRBTR8aqrJ
         f0G+YI58DaQcbm38NunXR/7/ciT3YSi7hz3RmB+Sc2LbPKqr+eZ1gAH3OOyUZmW1BVXW
         xyuw==
X-Gm-Message-State: APjAAAWl0vcYUm3lxIXZC/J2nUO4/JAnR6YtmOWU+sSWu8vK5YUsrlW4
        FJ8+3a7aCYPcSU6wUAfIzw==
X-Google-Smtp-Source: APXvYqwO7wdbjNj3/+ePeQ1nopTTK1woT+fGfk3iVg3hTCU0BP0VW9L3V3IV49FjtMkArHO+RxZQ/Q==
X-Received: by 2002:a5d:87d6:: with SMTP id q22mr1077740ios.2.1562621192556;
        Mon, 08 Jul 2019 14:26:32 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i23sm14233925ioj.24.2019.07.08.14.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:26:31 -0700 (PDT)
Date:   Mon, 8 Jul 2019 15:26:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Takao Orito <orito.takao@socionext.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Message-ID: <20190708212630.GA20487@bogus>
References: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 06:22:11PM +0900, Takao Orito wrote:
> Add the device-tree binding documentation for Milbeaut SDHCI driver.
> 
> Signed-off-by: Takao Orito <orito.takao@socionext.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> new file mode 100644
> index 0000000..6063116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> @@ -0,0 +1,32 @@
> +* SOCIONEXT Milbeaut SDHCI controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci_milbeaut driver.
> +
> +Required properties:
> +- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
> +- clocks: Must contain an entry for each entry in clock-names. It is a
> +  list of phandles and clock-specifier pairs.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain the following two entries:
> +	"iface" - clock used for sdhci interface
> +	"core"  - core clock for sdhci controller
> +- vmmc-supply: a phandle of a fixed GPIO regulator

Being a fixed GPIO regulator is board specific and outside the scope of 
the binding. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +Optional properties:
> +- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> +  requires the CMD_DAT_DELAY control to be enabled.
> +
> +Example:
> +	sdhci3: mmc@1b010000 {
> +		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +		reg = <0x1b010000 0x10000>;
> +		interrupts = <0 265 0x4>;
> +		voltage-ranges = <3300 3300>;
> +		bus-width = <4>;
> +		clocks = <&clk 7>, <&ahb_clk>;
> +		clock-names = "core", "iface";
> +		cap-sdio-irq;
> +		vmmc-supply = <&vcc_sdhci3>;
> +		fujitsu,cmd-dat-delay-select;
> +	};
> -- 
> 1.9.1
> 
> 
