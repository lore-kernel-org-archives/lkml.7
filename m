Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF274C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF02171F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551311702;
	bh=470P0LyzcUsOcAmdiOvsS2DZ2zLBHxBaH5W9jzH71gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFz65AalFEqspjF2Ptksy041P7r6SMTJR6G2lvGp94bGzxuCBzxVA16X53ECOApwV
	 F6OBGmUk1HF7SpntUJg11uNvk09cVuAO0dJ5qQvyCZFRBkr8LgEFNhnE9WJ1+xa3D3
	 QX5pmQJbNn77j/QNaUApiufVoDmYoPKhjrqdNQVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfB0XzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:55:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40160 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0Xy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:54:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id x187so15026493oia.7;
        Wed, 27 Feb 2019 15:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dRnsnvc++2BSVesveEuIM74VIJT7QPyOQhMUfCmmHZY=;
        b=T8stCLHwdkgEYKVqddDS9BUFCfBuL8679hfyvAeMcLJI1UYH4tgHycz4ubtVWkFpuw
         W9oUBlgu+ALt2H1z8O4If78WUbT32+VwnkcPjhfXyo1i9oGJ2O2n76Zd5+iT8Q044/xJ
         RP2JHs+ohxJ4C0gAS0/B78g5uOvJ46CqgUHmnfxfoRbteA6MwnUe+l+I88Gi4jn7o1lQ
         OHXjKuaomYi/e84rm1GFEgxll9wEwbqtcUDC4yG5iht27vDCj7RE/TzCsiMQFhn5KuZj
         FGaaz+WDZrflCEDtAt6CPcLVXlcGGzX3e9lYhZk5OUQiOR7ZlKpXtQYvk4pgM1gvoO1r
         1cpg==
X-Gm-Message-State: AHQUAubwARNEB3hs5w8oZZcihQfK/1+/EfViRxVIgVuOqfPtJDRrSKKX
        ismei8ie1EJzfFd2VxqraQ==
X-Google-Smtp-Source: AHgI3IYrRgjOuoVpR9oqaxXEGpn240Nus78kidoUe/69C7ZUJ2UIoyAbqGKGHDKPxKNVMMbsUw4qAg==
X-Received: by 2002:aca:4d53:: with SMTP id a80mr1279553oib.154.1551311696690;
        Wed, 27 Feb 2019 15:54:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm2043571oia.15.2019.02.27.15.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:54:55 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:54:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190227235455.GA15211@bogus>
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:46:21AM +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V9:
> 	- change #thermal-sensor-cells value in example to 1, since there are other
> 	  thermal sensors inside system controller, it is just because there are still
> 	  some issue, so system controller does NOT expose them for now, they could
> 	  be exposed later, so it should be 1 from HW perspective.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..855270b 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
>  Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>  
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible:			Should be :
> +				  "fsl,imx8qxp-sc-thermal"
> +				followed by "fsl,imx-sc-thermal";
> +
> +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> +				for a description.
> +
> +- imx,sensor-resource-id: 	A single integer for single thermal zone's resource ID or
> +				an array of integers to specify each thermal zone's sensor
> +				resource ID.

Can't you put the resource ids in the thermal-sensor cells? Why do you 
need to list them here?

Rob
