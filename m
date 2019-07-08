Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E9CC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549032064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNBc9Ibt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfGHIuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:50:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46151 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfGHIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:50:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so2585658pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0f8cjmK92HlNgqdiIijajGEwI8ww5eZP9m3oc7p56Nc=;
        b=XNBc9Ibt2RD9ZScjtlSg3q03aKcjt0mkX8Tnqlq8ia3SlJkvgZLuf6bCf81oDV0c3g
         mh6NaGDyDwg2iBHEvtwDBdVmHb5o9isAOZ3qTc5cvLFw2fx41/9zqBIhamXiWOuk+auA
         2o0a+Vn5joLTl6S0zcEwQCZxvb0Ajiddc9J7o9f+U5KWykYYg+m4dNkDfKlSttULO4Gy
         c0Og20/SbiF75xz6+y08B+exkdUkdAa/17gaxv1zKVDFpyu/MGrVei5O9Kj2MG8Bw7Zt
         QFIizNqncdaiFzzHW12Xr172RlniGm1Ev8NfQHPgWZ4xYEiLO5SZ4M/CT/kCW9RNQDfB
         /ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0f8cjmK92HlNgqdiIijajGEwI8ww5eZP9m3oc7p56Nc=;
        b=OLSq0mqFHy7ZCO0FqF6efEmHWACILRhBg5iZ6EXFCUcJdP0J8LUdBU10vF5Sr/yL5x
         WzKo7Lm3S/uafnW10fXOTa0mY4DiEIc5oNWVl1SYdszua1L/ZbkXNPFYJDuvLKFbNPBw
         5g3QD+GofgypxK1T7VRy5aYcMMRJbKdN4W11YczAa7cdIjkVDCXAz9iKpSEKr1CuY4nF
         nzut+HKuoDwvHlBK/L35tk88hP4vSvw+Nj4YgaxwKLDCVGt+DRjogevzK3vw0/u/jmcV
         4hUOJrM6aDygRQVPmN7timBGKmgX4cu9lcIZoZQDLanv52wfWvoexhYB77HpYu+Xo/m2
         OLzA==
X-Gm-Message-State: APjAAAVMW6C1JapycenMW8EOvom5wBBtkFVFTpyhlfVB6Yqt7XAD/Pu7
        TsAWOcrsUEN5iBcFVUi9+2EQCg==
X-Google-Smtp-Source: APXvYqz2OAUpBgAYfslWqQ24NCOstvA/FjftUC0ZlsHmRwGfhGZVfXdBFIvrhykbYiXoTF6fiVa9dw==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr22686652pjc.3.1562575801326;
        Mon, 08 Jul 2019 01:50:01 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id t17sm18436886pgg.48.2019.07.08.01.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 01:50:00 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:19:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
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
Message-ID: <20190708084957.waiwdun327pgvfv4@vireshk-i7>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
 <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 08:43, Anson Huang wrote:
> Hi, Viresh
> 
> > On 04-07-19, 07:49, Leonard Crestez wrote:
> > > On 7/4/2019 9:23 AM, Anson.Huang@nxp.com wrote:
> > > > From: Anson Huang <Anson.Huang@nxp.com>
> > > >
> > > > Assign highest OPP as suspend OPP to reduce suspend/resume latency
> > > > on i.MX8MM.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > index b11fc5e..3a62407 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > @@ -136,6 +136,7 @@
> > > >   			opp-microvolt = <1000000>;
> > > >   			opp-supported-hw = <0x8>, <0x3>;
> > > >   			clock-latency-ns = <150000>;
> > > > +			opp-suspend;
> > > >   		};
> > > >   	};
> > >
> > > What if the highest OPP is unavailable due to speed grading?
> > 
> > What does this exactly mean ? How is the OPP made unavailable in your
> > case ?
> 
> That is because in i.MX8M series SoCs, the speed grading and market segment
> fuses settings could affect the OPP defined in DT, in a word, all possible OPPs
> are defined in DT, but each parts could ONLY select some of them to be working
> OPPs, so if the "opp-suspend" is added for 1 OPP in DT, if the part's speed grading or
> market segment fuse settings make that OPP as unavailable,  then that "opp-suspend"
> is NOT working at all.

How is this selection done ? You using some OPP helper or something
else ?

-- 
viresh
