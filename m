Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77605C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E8521951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563832576;
	bh=XkozeM/glxcpfud8LpknywGps7aojXZ0uD0T3+fnMMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yqMUd8JTkfsYjX/FxYkO+aK0cfPV0wYR9s0f88MdTZd9RpAXP9/dm8pdPxHkhZv7D
	 A8SgtlCnQx6b/tVhcJeLgTuWy0Da3fvnkFf1ScXDdvYhw3VSXfOweycu9KXq7QQjos
	 WKDyWD+YbCqg6Fc6BUV6FjsqSYqBcDtogKnjSiOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfGVV4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:56:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35016 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGVV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:56:14 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so77461311ioo.2;
        Mon, 22 Jul 2019 14:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUAUcHROFVykrQfoIqNUbHZZ4/oOTJrle0TfSFnaOy4=;
        b=VNRcFhT+ON8gfY/lTSkivnWTk5xAQOvIX+dz8m1SnD48c+9FlDq/v9h3k88uGMHpQX
         hXRg0xCVMtQH0rUAAj7gkuWrJpBsohhFXklE1S/UsGArlJVxgaiVnZYLJOdKTYRL3X2P
         gQmVxRfaz88aKKMf6TyZCtJr6vYz5MQ+gZtxEgOOqgSY3kKn8SVYRrdZODESYOsQe3NN
         ixL70ZnwVFGge8PGCeggSLuqQ5AtnoAWtRl2q9xIvQlcxvG2SzP7fUCPbM96H6q2f3Ss
         YI3a7q5xG8ps8kBoBdkQD0CbGRwHgfxV3XD4rnwVyDx7Yqsgd8vVSzjY0lmbo83LHPrw
         AB8A==
X-Gm-Message-State: APjAAAWPraBzu3qHUq1b+9AQ0/323aKlsE0fHo54F/DLHC7RaJtctSb9
        S+WHqUOlmKPJKun+3C5FEA==
X-Google-Smtp-Source: APXvYqwEG3LbLYKC9307yBEM7CSfFu+SMect//sr3rtgOi3zgZ3iXYwZmp1iA6jx8W+hWbvB1UR7qw==
X-Received: by 2002:a6b:b7d5:: with SMTP id h204mr65978346iof.188.1563832573342;
        Mon, 22 Jul 2019 14:56:13 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id j5sm31150050iom.69.2019.07.22.14.56.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:56:12 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:56:12 -0600
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
Subject: Re: [PATCH v2 05/11] dt-bindings: mmc: arasan: Update Documentation
 for the input clock
Message-ID: <20190722215612.GA5437@bogus>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-6-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561958991-21935-6-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:59:45AM +0530, Manish Narani wrote:
> Add documentation for an optional input clock which is essentially used
> in sampling the input data coming from the card.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 15c6397..7c79496 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -23,10 +23,10 @@ Required Properties:
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> -		 Apart from these two there is one more optional clock which
> -		 is "clk_sdcard". This clock represents output clock from
> -		 controller and card. This must be specified when #clock-cells
> -		 is specified.
> +		 Apart from these two there are two more optional clocks which
> +		 are "clk_sdcard" and "clk_sample". These two clocks represent
> +		 output and input clocks between controller and card. These
> +		 must be specified when #clock-cells is specified.
>    - interrupts: Interrupt specifier
>  
>  Required Properties for "arasan,sdhci-5.1":
> @@ -40,9 +40,9 @@ Optional Properties:
>    - clock-output-names: If specified, this will be the name of the card clock
>      which will be exposed by this device.  Required if #clock-cells is
>      specified.
> -  - #clock-cells: If specified this should be the value <0>. With this
> -    property in place we will export one clock representing the Card
> -    Clock. This clock is expected to be consumed by our PHY. You must also
> +  - #clock-cells: If specified this should be the value <0> or <1>. With this
> +    property in place we will export one or two clocks representing the Card
> +    Clock. These clocks are expected to be consumed by our PHY. You must also

What are the 2 clocks?

>      specify
>    - xlnx,fails-without-test-cd: when present, the controller doesn't work when
>      the CD line is not connected properly, and the line is not connected
> -- 
> 2.1.1
> 
