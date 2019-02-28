Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0A2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551365365;
	bh=8f48wUUeSLC+Rnw+ZrIjGxXv3bdAo0O7v/LpCtisZsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YgdiLrc8S4a8b3EUkPDDiqc+f7KtApSSGO2C3+T6KbtJyEcHF09PplFbE0YGB7fBE
	 R8bBaxzN91zAXxAyn9mO7xX3qHSz3x0pYuJvGdOb/6yrUiE6v5T2gubQTJ1IJoDUwm
	 e3Un8KMsMqhSehZR/0h8/e8JpUiLGocWKthb01UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbfB1OtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731596AbfB1OtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:49:23 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3C62133D;
        Thu, 28 Feb 2019 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551365362;
        bh=8f48wUUeSLC+Rnw+ZrIjGxXv3bdAo0O7v/LpCtisZsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mt2meIGfcM6XIWDXEsrFqMmYr4812rPFVjvwY0q3JtoIvM8WMEzhq2RviR94nBp5V
         2AbYUBI28oQ2v4m9vBAEl18lizgtb/sUBVN63IzEHWztweuMOWk1Kp9uXnWSAWjFSi
         on0eQFGr4L4t+zsug3kWCPxGlWvvfmGB/Ewl/EpI=
Received: by mail-qt1-f174.google.com with SMTP id z25so23696411qti.13;
        Thu, 28 Feb 2019 06:49:22 -0800 (PST)
X-Gm-Message-State: AHQUAub1z+ism91pBaQjoxyO674A1m6IeanT10otsMM4Gq57gMZ5BdM6
        tqB5KOD7eK8MM1Jz+DmqFyuQlzHY3pd05ZguWQ==
X-Google-Smtp-Source: APXvYqwArNLNu6IoxcFOelngG1wPzhzX/Nh6mxb1fErAflWBtXCcgzuILiL8ZDvonFLLaDrEU3r4h1uRgsdXr2Z1FZw=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr6588361qtk.26.1551365361359;
 Thu, 28 Feb 2019 06:49:21 -0800 (PST)
MIME-Version: 1.0
References: <1551256894-21954-1-git-send-email-Anson.Huang@nxp.com>
 <20190227235455.GA15211@bogus> <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391673518C43A0ABE9BDB55FF5750@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Feb 2019 08:49:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
Message-ID: <CAL_JsqJct4BztHEak+=iNK3G7dwYR-pQPeUqb4kBnEdRQMLr6A@mail.gmail.com>
Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:48 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>
> Best Regards!
> Anson Huang
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2019=E5=B9=B42=E6=9C=8828=E6=97=A5 7:55
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; sboyd@kernel.org;
> > Daniel Baluta <daniel.baluta@nxp.com>; Andy Gross
> > <andy.gross@linaro.org>; horms+renesas@verge.net.au; heiko@sntech.de;
> > arnd@arndb.de; maxime.ripard@bootlin.com; bjorn.andersson@linaro.org;
> > jagan@amarulasolutions.com; enric.balletbo@collabora.com;
> > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; lin=
ux-
> > pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V10 1/4] dt-bindings: fsl: scu: add thermal binding
> >
> > On Wed, Feb 27, 2019 at 08:46:21AM +0000, Anson Huang wrote:
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power, clock
> > > and thermal sensors etc. management, Linux kernel has to communicate
> > > with system controller via MU (message unit) IPC to get temperature
> > > from thermal sensors, this patch adds binding doc for i.MX system
> > > controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V9:
> > >     - change #thermal-sensor-cells value in example to 1, since there=
 are
> > other
> > >       thermal sensors inside system controller, it is just because th=
ere are
> > still
> > >       some issue, so system controller does NOT expose them for now,
> > they could
> > >       be exposed later, so it should be 1 from HW perspective.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt   | 21
> > +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index 72d481c..855270b 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -122,6 +122,21 @@ RTC bindings based on SCU Message Protocol
> > > Required properties:
> > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > >
> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible:                      Should be :
> > > +                             "fsl,imx8qxp-sc-thermal"
> > > +                           followed by "fsl,imx-sc-thermal";
> > > +
> > > +- #thermal-sensor-cells:   See
> > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +                           for a description.
> > > +
> > > +- imx,sensor-resource-id:  A single integer for single thermal zone'=
s
> > resource ID or
> > > +                           an array of integers to specify each ther=
mal
> > zone's sensor
> > > +                           resource ID.
> >
> > Can't you put the resource ids in the thermal-sensor cells? Why do you =
need
> > to list them here?
>
> For the thermal-sensor cells, if you meant the argument of tsens phandle,=
 then
> the reason is that argument is for sensor index starting from 0, previous=
 I use
> it for our resource ID, but it looks confused, since user will think ther=
e are many
> sensors there per Eduardo's comment.
>
> +                       thermal-sensors =3D <&tsens 0>;
>
> If you meant putting it in each thermal sensor node instead of "tsens" no=
de, then
> in previous patch series, I put this " imx,sensor-resource-id " property =
in each thermal
> sensor node, but the thermal sensor nodes are parsed by common thermal fr=
amework,
> thermal driver will need to find the thermal zone node and go through eve=
ry child node
> to get the resource id again, so Eduardo suggested to put it in our platf=
orm tsens node, that makes
> our thermal driver code much more simple.

The phandle args are meant to be an id typically. There's absolutely
no requirement they are 0-N based. They often are because things like
interrupts are 0-N or clocks have no h/w id. If you already have an
id, use it. Don't invent your own.

Rob
