Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA212238A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563832452;
	bh=s/kAzh0WTncvMBghUTA3wsaFGNQL6Ki8OY/82ZkpZtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eZd8EAQ6Btq1LsEgC1LAjpeqFw0qs+X/pUNuyQZq0wvHH2zj+S3VjgR/KYpjDgZQ4
	 Qdcw8l6RY1C7HCDiXM5Xu2FGSdepjFtCqK6w8ZyiBypK/jwgI4USlb6XBOOMp4Jxqr
	 iU778/FJ21jBcvwYXqxCPi7IV5e4ayfO9LuJ1+Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfGVVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:54:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46200 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732997AbfGVVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:54:06 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so77336061iol.13;
        Mon, 22 Jul 2019 14:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/tFZBmBqzo/zPORNqy/FURXPMyOxXiM7Nwwcf4TGGM=;
        b=AzNkjmVaMFiMzdY0wulQWK0sc9DN+zQy8pyPfcVYB651ytv58A7zuosdPRz+zQr8GC
         P2MMqn/JbMcO16ghUSJ/hhpX7w5afBYiKYF3lCJBkslof6GfsGTKpdgm0lbiy7gyoi8p
         aujpOdiF3HzNmfyTTfhxFXIokA2Eo+AFm78iCfiFKIauMM9GuNfIfEXSXORPIoLfh7/K
         XSIHlpQy0PJwdysENMk5TvVAhdmjgYZ6zBFkYigbF3uAlJ9VcwmFinUw5VjZR+wLUT2z
         4Cp3O631wiJbjm4RASfNlRqDFIhQKEiQrFPR/goB/cdtjUeIp5m7EI62HhpJYVoh5zQW
         S0CA==
X-Gm-Message-State: APjAAAXFnCZ+gDd4I8xxiFPP5LHkjPKwNs6sO+7e8nEBaXNywIfYbRZ4
        XOf9myHhUEm5Ui5fdu7TEw==
X-Google-Smtp-Source: APXvYqyUL19XUYrZJxeGwxCR1U5Xwb7mxgpPlG0YNI4SIrs8fiL5rMGhTWsuUHHsuUiVX5EpIhEE/Q==
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr67180363iok.52.1563832445617;
        Mon, 22 Jul 2019 14:54:05 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s4sm52874406iop.25.2019.07.22.14.54.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:54:05 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:54:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com, heiko@sntech.de,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        olof@lixom.net, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Message-ID: <20190722215404.GA28292@bogus>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:59:41AM +0530, Manish Narani wrote:
> The clock handling is to be updated in the Arasan SDHCI. As the
> 'devm_clk_register' is deprecated in the clock framework, this needs to
> specify one more clock named 'clk_sdcard' to get the clock in the driver
> via 'devm_clk_get()'. This clock represents the clock from controller to
> the card.

Please explain why in terms of the binding, not some driver calls.

 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb04..15c6397 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -23,6 +23,10 @@ Required Properties:
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> +		 Apart from these two there is one more optional clock which
> +		 is "clk_sdcard". This clock represents output clock from
> +		 controller and card. This must be specified when #clock-cells
> +		 is specified.
>    - interrupts: Interrupt specifier
>  
>  Required Properties for "arasan,sdhci-5.1":
> @@ -36,9 +40,10 @@ Optional Properties:
>    - clock-output-names: If specified, this will be the name of the card clock
>      which will be exposed by this device.  Required if #clock-cells is
>      specified.
> -  - #clock-cells: If specified this should be the value <0>.  With this property
> -    in place we will export a clock representing the Card Clock.  This clock
> -    is expected to be consumed by our PHY.  You must also specify
> +  - #clock-cells: If specified this should be the value <0>. With this
> +    property in place we will export one clock representing the Card
> +    Clock. This clock is expected to be consumed by our PHY. You must also
> +    specify

specify what?

The 3rd clock input I assume? This statement means any existing users 
with 2 clock inputs and #clock-cells are in error now. Is that correct? 

>    - xlnx,fails-without-test-cd: when present, the controller doesn't work when
>      the CD line is not connected properly, and the line is not connected
>      properly. Test mode can be used to force the controller to function.
> @@ -70,8 +75,8 @@ Example:
>  		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
>  		reg = <0x0 0xfe330000 0x0 0x10000>;
>  		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> -		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>, <&sdhci 0>;
> +		clock-names = "clk_xin", "clk_ahb", "clk_sdcard";
>  		arasan,soc-ctl-syscon = <&grf>;
>  		assigned-clocks = <&cru SCLK_EMMC>;
>  		assigned-clock-rates = <200000000>;
> -- 
> 2.1.1
> 
