Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5718C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9737020848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553546252;
	bh=ufVg/qE/roK0t5LfnDCU22s5RcEoMGPJqzy38kmHK10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0sWzp5uGM/8sWyZR2/S8PO8iMSG5XVTVg0862JBGWHgcXiqemaMMQk+oe+CUrY1xV
	 STDV0Nfei+uMC0hU/qATW59FRnGiiBuTRRcDFOKRDjqRBA3CdEQsDt6OA5lWp2bCnt
	 wAJWUVVHkJfORIhB1sTbCE5kGnnljftyvzatCmNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfCYUhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:37:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42829 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfCYUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:37:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id w139so8119004oie.9;
        Mon, 25 Mar 2019 13:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3j+XAw6q7YP8RPPJ6tNml/405QzPFH70m3fes/AW7o=;
        b=VkcL8Ww/vabOGHWTs4QTqqCCQOVEoC8aHcS8P36NQoFwRE/qMS32CgsTE5asvVHtBJ
         +4aIMON7uWJq+akZMcnDhhZWvuHOj6oxYj2lDx604SmyHhKALzNRvjPTDzt2qm9nnJwS
         aRyAM989xYkKmwuDkRL6NyD6M4SPuZG8xLR7SuUT4pvvTz9Tb4sDXzVdG+wnUv6ZbBF6
         uFKOxvqSGNahMYHss8iFZwafcadkmCtaZxkTGY158f+NQ78vRg9AU8nNZMXxRZUPR5jJ
         UB2nChgUERccnz43Rn8xGNma4riYPYC9wLkLg9u0N/5PcqxeFnDEBAuVEWKKJbKeH1Hr
         26uA==
X-Gm-Message-State: APjAAAXu/HDixf4gCGPvFHrz9eTub0UZMc2X4RXnR0Al6zU7WX/+xFXQ
        ClE6fvoq4VYo1wJo0VEU7A==
X-Google-Smtp-Source: APXvYqyrK4UHeRK88a8BNOaaysXneXBkvCcqc83Uccd0XMqopVd3qVVEtPTke90TRGRqiimWTjPFZw==
X-Received: by 2002:aca:3608:: with SMTP id d8mr12108044oia.104.1553546248398;
        Mon, 25 Mar 2019 13:37:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t35sm875696otb.80.2019.03.25.13.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 13:37:27 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:37:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Message-ID: <20190325203727.GA27661@bogus>
References: <1553134884-1720-1-git-send-email-Anson.Huang@nxp.com>
 <1553134884-1720-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553134884-1720-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:26:38AM +0000, Anson Huang wrote:
> Add i.MX system controller watchdog binding doc.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V8:
> 	- add optional property "timeout-sec" according to driver change.
> ---
>  .../bindings/watchdog/fsl-imx-sc-wdt.txt           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt

I still think what's in ATF should be discoverable, but:

Acked-by: Rob Herring <robh@kernel.org>
