Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA29DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DFB2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556138971;
	bh=vFKxkMdTx4Uvizz7u1yAsOjQ0dHVcCJhqrlMzXejfKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dDZwym0QkcDvB5t3+0cxuwAHwRZSWlkychr1pGrHnRuO118GHa81x/2naARs2jSG0
	 tVdeL0tGaAPl/e/yS5UMD6qLho/+hG94Vp9Cm0QNxfWZUFzq/AaQM8Ghl03bDrnLIe
	 8CoHh/0QjLVCSri/NTpQmv186c9/BymyWgvDVspo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfDXUta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:49:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33511 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbfDXUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:49:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so15476937oii.0;
        Wed, 24 Apr 2019 13:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hA9wyW5hWL/UGprMldN2tXNfvuMbYYLtufWQs+OYr98=;
        b=NgN2b5g+7z59SROUrLjYkQlOjGs966ft934Opnqti4Ad86Xqx3DVfYm2lGIep8IF8Q
         5/gGTNl/zStYVngMsqf3iQUH5LEDPfIqeVw6VD8bTmDSJSAYRkxNJnl3rlzGuaqWtp4D
         jfqM9q5hRT9miKOdQIvwwzRgWu06c1S4RTd5oN6jC2ik56R9XUaT/EStjthRMBMqx/Pr
         rwV907+786GM/ECHaublBg2DYfiZO2clWok0YX5EJR1Vbf+hPCeiX5RvHb3EbBEG6Mnb
         CBhO+rHIPIM0XH3HSjQ2lnVuXGSIYxohQR5p1FhRHauqQEwHryHC/gN4a+/YoH/U+VJF
         DgDw==
X-Gm-Message-State: APjAAAVIgzCiFvC9nZQGBKFlUrHqTESrBcfDDgiSwxFV8JIe8Xd7iW5U
        K4WszHUvUTFE9L7133S9qA==
X-Google-Smtp-Source: APXvYqxQl9Ydr8xtWFHPej3FcBb6/xoLMBl0WclDB9AVwHhY6wXcxIXRWP45v1OBBTKvAXTK/Yw6rg==
X-Received: by 2002:aca:3084:: with SMTP id w126mr790535oiw.102.1556138968680;
        Wed, 24 Apr 2019 13:49:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v201sm8735745oia.39.2019.04.24.13.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 13:49:27 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:49:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190424204927.GA31960@bogus>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 03:22:09 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
