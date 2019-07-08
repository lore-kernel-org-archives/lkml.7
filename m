Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A461C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8120665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvcxpHNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfGHIZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:25:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40828 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:25:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so7865848pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBSOpGeilh1d+k1ITUctDAa0jlGTfzm/XYHfd6NAVZs=;
        b=TvcxpHNWz4hgGUB+LNuHI5YWHzDVJt/1XgqQ6DFUhvMzKA3okKMpxbvr4ipDQOrT6v
         cwArEjpPjqqcYw8uYvas1+s7vRj7ogC++JHqyLHMMj42y9wJKuSrE99NAaIapSSpHd0Z
         bX3Qd8NBsMFZOfz4Dxqr3ghsVHfjX5JWFsctmRGbOuQQkxw+te0XbnZkUMzFGfHV+xDi
         X1W1bPjecr55Nnewqc2U778mZbu4vyBHm/2woeQ+8Lyvq6WLSKzDktV/ZgZTtD+d1W8R
         dCeTcHk0vXB/0ru0tum/y/vkPNnHtMUbAsKqibaCZaPqNAKKOV3l2wR1Y1vl+UFCpR2A
         LFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBSOpGeilh1d+k1ITUctDAa0jlGTfzm/XYHfd6NAVZs=;
        b=th31eM/SCyw6dEkMgPo/0d21GEQfx48c8Nr+BY7Y22Zws7e2cLcYJmYXCV5CM5EbjU
         OKUHPAFgvPbfo6KmjM3z16x7h/ClhCU4+cD1Irj87k6YJuB+izTHsICBRVuxUvDzQCQB
         Qr4vmy6gll4x+6lraySZ7wPySIbvAUsTO+hX+7+YtO5vkUbaUaep2sktdzo0Vvt63ASv
         xDZTP7rwxpwZI9NC0sPLzIcH7OrfZZq3RVf8A0nc41oH9DWpxPRyAVYcdjf9TmJij+CK
         TCQPe5Wbh/1nNnPbziBbZxq9+G9DcXluNjjIsGtKwPPmDjgslltyArI+FMIC4fl5BRNy
         mrKg==
X-Gm-Message-State: APjAAAVxosV+meH+9cDfSpl+dsf0n4qcoevxFmyMd71xFXBEdGaCL5rw
        sQnwi9TUrVKgzETYoUprhjmSag==
X-Google-Smtp-Source: APXvYqwCjNEbxbwIuNxeO93iHJHDw+JddjwVlDj89IzeQ0Xpdb6vLLbspbd5Q1ZKCMscFgvOECoAXw==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr21412249plb.164.1562574313802;
        Mon, 08 Jul 2019 01:25:13 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id k22sm22327205pfg.77.2019.07.08.01.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 01:25:12 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:55:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend opp
Message-ID: <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-19, 07:49, Leonard Crestez wrote:
> On 7/4/2019 9:23 AM, Anson.Huang@nxp.com wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> > 
> > Assign highest OPP as suspend OPP to reduce suspend/resume
> > latency on i.MX8MM.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index b11fc5e..3a62407 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -136,6 +136,7 @@
> >   			opp-microvolt = <1000000>;
> >   			opp-supported-hw = <0x8>, <0x3>;
> >   			clock-latency-ns = <150000>;
> > +			opp-suspend;
> >   		};
> >   	};
> 
> What if the highest OPP is unavailable due to speed grading?

What does this exactly mean ? How is the OPP made unavailable in your
case ?

What will dev_pm_opp_get_suspend_opp_freq() return in this case ?

> Ideally we 
> should find a way to suspend at the highest *supported* OPP.
> 
> Maybe the opp-suspend marking could be assigned from imx-cpufreq-dt 
> driver code?

Sorry for jumping in late, the latest patch from Anson drew my
attention to this topic :)

-- 
viresh
