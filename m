Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFBAC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903172077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGHiR6tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfDVEZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:25:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43943 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDVEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:25:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so5193824plp.10;
        Sun, 21 Apr 2019 21:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LgVpHhZnASfuRCS+c0R9jxeOE6l0uajXoRX2DmClENs=;
        b=jGHiR6tVvPxNUj8YYvuMJM+meJG8qnE4iuQs9vQ13tk2bJGHQ6T/yfoOns9zlr0J0D
         yPsHITuuA4H+NacmqF9ccCqEOVfbaO8R6ORQFWrxl8GxqgV+RQeEsOTHaZsRnJVFtgHO
         v2Pup5gcRTUpnpIYsUnF6ZHEO287z1otclNVoXGGE2+N5GKYzdS/6mXGBgtw46scXszw
         PjrJYS8qz3I4pr3Q0xa8aJTCcwGkh43SSQhTeKGdWu8xZTee6YeQQK/QOR8bbaOmRxPP
         BLuS1fE6Vb1ydI6JW2LEY3Wo+qAZV9mj7fqSPWz4zsNQ3Cs5EnE7aAP8R0wFYYKNx1wC
         tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LgVpHhZnASfuRCS+c0R9jxeOE6l0uajXoRX2DmClENs=;
        b=Zt7+ry3tUMWqKwH1Ronc0rEv+CFFNAdviA2h+TB0Bd3+ewq5E224XfeLvADY60aD4a
         A2nIMTY7wmwfIFppYm3JdOqmEijxa7fvMUgahxlwip06pI2+ix2bFazJy96VffWAgVud
         QJ2hwPZdDvuJ3tpxZOMfnAC0U4oStfpViJYQGH/HydO5MVeOBkTlwKL/oeN8v0DgXp9C
         mSBOhZCMFmYQWcyamxIXW68KMPQQylGosQZVszONRhiJGZ8nCRKBNORmXbmt/kMby1TG
         WtlIfVyeJSnydg2SEOSQtA/Dbe8uJ+cmbig/CuEjAw/TEn+gn8M/+5cRfFDyLoiDV6eq
         MQxQ==
X-Gm-Message-State: APjAAAV5g/QMhJOhibsu2z1Osjgt1AmUWDGWK5T79xWqmU1QOKujP4VB
        SO4I+dyRCyIu2OAnD5zRgMU=
X-Google-Smtp-Source: APXvYqxTKugQGWfVu1bLTkffozSkuF5sJNMOsGX76y54k1minWbE0w4ZWJ9JmpBJc+FURcsC2USYpw==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr17900960plb.143.1555907127555;
        Sun, 21 Apr 2019 21:25:27 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id k3sm9285633pfb.175.2019.04.21.21.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 21:25:26 -0700 (PDT)
Date:   Sun, 21 Apr 2019 21:25:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Message-ID: <20190422042519.GA4304@Asurada>
References: <VE1PR04MB647951B20E0F334FF1CC3B7AE3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647951B20E0F334FF1CC3B7AE3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 03:30:26AM +0000, S.j. Wang wrote:
> > > SAI has 4 clock sources, which can be selected using MSEL bit of SAI
> > > TCR2 register.
> > 
> > I have a doubt at this statement. As far as I can understand, this MSEL is
> > probably used by its internal clock MUX, so it's not really proving that SAI
> > has 4 MCLK inputs. What I know is that SAI block itself only has 3 MCLK
> > inputs as we defined in DT. It's just internally connects bus clock or MCLK1
> > to input0 of clock MUX's and connects MCLK[1-3] to input[1-3]. So adding an
> > MCLK0 here doesn't sound a right way to me. Unless someone can justify
> > for it, I think we should just fix it from driver side.
> > 
> > Thanks
> > Nicolin
> >
> 
> The MSEL bit width is 2 bit, so there is 4 options,  the MCLK0 maybe the same input as
> MCLK1 or bus clock as you said, so we think may be better to show this relation in DT, 
> And this is DT's capability.  Driver don't care about which clock connect to MCLK0, 
> it only need to know there is 4 MCLK from DT. 

I know what it is. But it feels weird that we add an MCLK0 just
because of what a register filed has, and there's no "MCLK0" be
mentioned in the RM at all. My point is that if SAI doesn't have
a port named "MCLK0", I don't feel it's that convincing to have
it in the DT.

Usually in DT we define the clock sources of an entire IP block
in audio use cases, not for an internal clock MUX. But taking a
step back, it might not be really wrong to do so, since the MUX
is a part of the hardware. If we redefine the MCLK[0-4] as "four
clock sources of SAI's clock MUX selecting a clock for bit clock
and frame clock providing" in the binding doc, I feel it'd make
a lot of sense.
