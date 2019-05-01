Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DAFC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C9A20578
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556741414;
	bh=AV+5t3l62F3zf8yV66aVKy1r4g8vDQo8zZMAK6XnJLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HA97Lqm4j2jMSFF6oAyD2dnQQ605nxEF12a8OLajPKvKpnbIVtEpvMb9tWD+CE3v+
	 Fp6V1ru4jGCUZv0EUr+h51GK0m3RWx66dBKpieTUEoSLfV1H9zhcnDQMGjoXGDyGHG
	 BZpgjtKqeCv6bUL+tMvPOFa45wMnjwBzsp6xt73A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAUKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:10:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36742 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:10:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id b18so98794otq.3;
        Wed, 01 May 2019 13:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Li1WCYAdhD2QkMcE4ruPAS6fhCxmScJLOyEkxKVVobU=;
        b=Y1NJ0Z13ozOJpjCrpF35pfhMGlyD2vOOIvljemWguUt/AzW9/c0oK8G+zletYrXAlJ
         fI+4bCa2gFCoG8TBrpym5BubCwE7dmkhpZIFOLyjf1S70UmS0MXpz4TxrYluSNm9n/V1
         17Xl0qJ2GP8l/52zsx96xJhyOl11gJ+ZEVaRso3j3iAY2GV3/MNlIedEiOo4Pr/9q0YP
         /6AmA95yFRP8sJjws1UhLTW9fRkGu/GxqkT3OCRVBxSqk93khWZKDKm1aPm3nwtdcSQT
         u3zVkD5akN7RYLZlQINQdhzgfKxPBpWa84fy3TuFhjydc5S2RyKKNpAIEXm3Ec1YRmIZ
         /qlQ==
X-Gm-Message-State: APjAAAU0JwWy0EOsch9V7lQ78Y8m0n1TMuUuEYGhvuHTlaHAc7kys4gi
        C6Gv1eoDPcYyEypzjfMKoFvIpaU=
X-Google-Smtp-Source: APXvYqyd/tRgzRRtNvYE+Ndpu5/eEiN+nwsOv+vpJslnGlpkbWEws5Vx8h9SHYzmsSInIENUj5oIxg==
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr9873837otk.316.1556741411946;
        Wed, 01 May 2019 13:10:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d78sm5529492oib.15.2019.05.01.13.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:10:11 -0700 (PDT)
Date:   Wed, 1 May 2019 15:10:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Message-ID: <20190501201010.GA7249@bogus>
References: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 03:27:00AM +0000, Anson Huang wrote:
> i.MX system controller watchdog has pretimeout function which
> depends on i.MX SCU driver, so watchdog DT node needs to be
> subnode of SCU, this patch adds i.MX system controller watchdog
> binding to SCU binding doc.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 5d7dbab..1b56557 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -133,6 +133,16 @@ RTC bindings based on SCU Message Protocol
>  Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>  
> +Watchdog bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be:
> +              "fsl,imx8qxp-sc-wdt"
> +              followed by "fsl,imx-sc-wdt";
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.

This should be the time to reset the system, but the subject talks about 
the pre-timeout which I guess is just an interrupt. If it is pre-timeout 
you want add a new property and don't abuse the existing one.

Rob
