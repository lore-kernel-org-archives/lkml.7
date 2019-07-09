Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06918C606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01B3205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfZKXd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfGIEpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:45:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfGIEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:45:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so8753907pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8T1boIzFFoSOnmUYhW8pmkZUoG7ex2MB+rDKpzf8fs=;
        b=XfZKXd7gmjz5FPaPLVypAzfMeQL7XUAQdYsunJCY3edTML1McnkNitbWb6ADc6SBhM
         Qo0eMq66Gu9Gv56plq3V0zoMDHhQApGnazKdIpO84Qk9i6oqX32jNLCetDrieaCdg+v8
         EJrv1Cy3o3HIijQtdKVW1jbOnR62iGkmeLqCOrMOtR7lQwTf7qKtB6WW50HzQHvyaW6e
         w7Oiq41vBHBavgTsowi5sXY3Wm/rL+7C+KAK/1lwea//U4oQmdcylRmlpNm8diu/JF3+
         M9vnE/7+ELnEwQikJXNppyxGHxZjtjIm3Nz+RMt9X0D6uI/jIQg0NYt6YEOV8gY8gTXt
         zIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8T1boIzFFoSOnmUYhW8pmkZUoG7ex2MB+rDKpzf8fs=;
        b=mqMpvpvfUYoKFcyUdP/9meFgkghVneUb0pyuQUo4mTNuz5CulwUL/mHwGb+QsmOwrp
         7WTSDL5wrHTcq63iFY1Xzek3PA/W//JC35L/EDa8dIRYjZ6ew2iqR1PYkloqTfzAcXOe
         9Qnosx9YpMKSS44xX8zvck1yPUlWNe8+xl9pRc5hOkVvCU5XlBwuIHlmAI3tMJQgtJig
         hChNpkjuaDypMex7w1I/U3/3V+EwG98JsgweWlOhBaF7htAWDK2Ky3SM4S59uxGJjhiY
         1+gTjIlmyXtPcZnFjlNh8S34n04K4geDS7OI7zMmx2qOl8pDeu0Tsb2STz1ouAg/Ndim
         wvBA==
X-Gm-Message-State: APjAAAX2aSOW5j0i42V4aHGXwihQqowJMiPWJ4YjXwDSahWTO7TNYH8x
        S7228kLnshWAbBFt3uoXvXMERg==
X-Google-Smtp-Source: APXvYqxS1+TfUWQ4K5tWV/rky+PwoP/Nuue4PVUm0srLpT8NGOpInpCXQV6wKkHekUNntK1m1G9cwg==
X-Received: by 2002:a63:e953:: with SMTP id q19mr28343284pgj.313.1562647508410;
        Mon, 08 Jul 2019 21:45:08 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 14sm38828425pfj.36.2019.07.08.21.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 21:45:06 -0700 (PDT)
Date:   Tue, 9 Jul 2019 10:15:04 +0530
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
Message-ID: <20190709044504.gyljwwnxdt5niur5@vireshk-i7>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <20190708082511.py7gnjbqyp7bnhqx@vireshk-i7>
 <DB3PR0402MB391622133CD116FDE26A4F9AF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190708084957.waiwdun327pgvfv4@vireshk-i7>
 <DB3PR0402MB39164E2F386181255ED37F45F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39164E2F386181255ED37F45F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-19, 08:54, Anson Huang wrote:
> Each OPP has "opp-supported-hw" property as below, the first value needs to be
> checked with speed grading fuse, and the second one needs to be checked with
> market segment fuse, ONLY both of them passed, then this OPP is supported. It
> calls dev_pm_opp_set_supported_hw() to tell OPP framework to parse the OPP
> table, this is my understanding.
> 
> opp-supported-hw = <0x8>, <0x3>;

Right, so that's what I was expecting.

One thing we can do is change the binding of OPP core a bit to allow
multiple OPP nodes to contain the "opp-suspend" property and select
the one finally with the highest frequency. That would be a better as
a generic solution IMO.

And then a small OPP core patch will fix it.

-- 
viresh
