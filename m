Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA09C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB80720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554904008;
	bh=2nswS69CDtp9fvAuz8uZGuDaTGzpUSj3n/3joypwHMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3rWI84qRN5VFDfqVnQB6liV/K4hkKQuWlkFRtyL+r/pGT9c1nPqabMdMHCsdTBRZ
	 RRezEBzo54LeREzJ6NefPqZ2rlw4MDz4WS7SeTuHhdc87KixJfmfDaR7GQ6NRaKyUt
	 Mthh5t+NvJRhHGBJMXckl9yaGPWUU3FVbHpfnNBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfDJNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:46:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41638 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbfDJNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:46:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so1779907oie.8;
        Wed, 10 Apr 2019 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7e9AYwPzT58yoRTV+jXQpTmddagPMp1FA3EKEqM6BvY=;
        b=r+QbEPsRRtmfWqEZO3F+VyKPwxw6t3tgOx1FMUMDLfhGtSlJ0pHMr53t6XVp89x4Js
         RineKpz2VFfaVxve9sfdCZFxf2Ez25kRoInQ0zMm+5b2aW+Ww4lpHoQuXZRmB2PxxlOx
         quVAEVd5qJNbUeC5hZA3c2nYcZEqq61OdGKiNfT0MPBCFbq5GdlLFWWxRiTi2Wkdphsk
         CB/NLUz62suHERZU5aiTXbhnA/J5XQ6Rdpf4NJr+Coo58+3HOfP/ny70mpFTiJZzoEU1
         uT1tmj35nYqm0mCL3wG5hshUGUU5ct+xrRjoanwSUb8Nd6aKc64NqfEKdmkHsHuhhTCa
         DvWw==
X-Gm-Message-State: APjAAAX0ot72fo57bitg1t9/GTeH2rbRpfCywPFNSDfDgHpArbm8llpy
        aSE7J4b6H0JyTEhluq4pHw==
X-Google-Smtp-Source: APXvYqx8hh0xzLjkmrMLGFY1VvjmXmk7wFgdT5tmYJuozIFtf+N8aZWkxQd9TrXLpEoiTgTA7u18qw==
X-Received: by 2002:aca:47d2:: with SMTP id u201mr2603795oia.130.1554904005956;
        Wed, 10 Apr 2019 06:46:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f97sm13988899otf.5.2019.04.10.06.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:46:45 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:46:44 -0500
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
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V11 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190410134644.GA7399@bogus>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 07:43:04AM +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V10:
> 	- remove property "imx,sensor-resource-id".
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
