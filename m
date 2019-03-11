Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E21EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552339591;
	bh=R6Ae/Y9icFFsz4L42BLG/1JtO76ZQRtYXcqZwEcCw+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LJeYsWfHbx/QCKllLoMUF3M8ZpYJrmaiHgGu3oSR21+Xc0fHUK4zVj6seSCVc1WdZ
	 yqQHjx9q9fqv/VWQb4m37EvIycjCkV/i2jSlrq1hRTKq6V57OPLmmZ73l2Ibg5RnR5
	 JXhjDe1vYhnKqYFrCiQvMn16SIXc8XQjyE+Kgpd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCKV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCKV03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:26:29 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A8D2087C;
        Mon, 11 Mar 2019 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552339588;
        bh=R6Ae/Y9icFFsz4L42BLG/1JtO76ZQRtYXcqZwEcCw+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cyLU8CVkuWOMj9tQv97A1pwcs25QFHjKaVYyPOF+xK/0crH+a7tU8r7UqqeQJGwPM
         blMUQn118aqZvoFO6izBja0HQSuNyLpqhEbuK1TVE3saohpZhlDejXYFfCXLC1gspx
         tWzlgY8L6cQj0oz5gTMsusQjA+G4cLZPkQqsiHTY=
Received: by mail-qt1-f180.google.com with SMTP id u7so257505qtg.9;
        Mon, 11 Mar 2019 14:26:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXVG2s9UAlQDfmaTcjYzLqTikG1qNdrOfZDCQwQpaLvbop5O+8I
        1VPb2UhbYeuErB4u6YCEXSzlL1PQqo3Ux1ISUA==
X-Google-Smtp-Source: APXvYqzghD8vQ8o5ed8SI+d/2B6BuqrYk2fEyaXtHY2+deG5NRZLbiPaLV8uDICjy2YoWMM9+UBtn98b6eCooIjvs8I=
X-Received: by 2002:a0c:b14f:: with SMTP id r15mr28007307qvc.90.1552339587095;
 Mon, 11 Mar 2019 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com> <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net> <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net> <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com> <AM0PR04MB4211EAEA6F03465D372B0B4F804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211EAEA6F03465D372B0B4F804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Mar 2019 16:26:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJiKx8UvZ8qu-YaaPooLbSMKANSX=YZQO=Nm_anD2v9gw@mail.gmail.com>
Message-ID: <CAL_JsqJiKx8UvZ8qu-YaaPooLbSMKANSX=YZQO=Nm_anD2v9gw@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jens W

On Thu, Mar 7, 2019 at 6:22 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Hi Rob,
>
> > > > I think Rob suggested that the SCU parent driver should instantiate
> > > > the watchdog without explicit watchdog node. That would be possible,
> > > > but it currently uses
> > > > devm_of_platform_populate() to do the instantiation, and changing
> > > > that would be a mess. Besides, it does sem to me that your suggested
> > > > node would describe the hardware, so I am not sure I understand the
> > reasoning.
> >
> > It would just be a call to create a platform device instead. How is that a mess?
> >
> > It's describing firmware. We have DT for describing h/w we've failed to make
> > discoverable. We should not repeat that and just describe firmware in DT.
> > Make the firmware discoverable! Though there are cases like firmware
> > provided clocks where we still need something in DT, but this is not one of
> > them.
> >
>
> The watchdog node here in question actually is not using SCU firmware call.
> Due to security requirement by SCU, watchdog can only be accessed in
> security mode, for IMX case, via ARM Trust Firmware. That means the
> watchdog used in Linux actually is using ARM SMC call and does not
> depend SCU driver. So It would be strange for SCU driver to instantiate it.
>
> For this situation, do you think we can move watchdog out of scu node?
> Maybe rename the compatible string like "fsl,imx8qxp-sip-watchdog"
> because it's actually a watchdog serviced by ATF firmware.

Yes, but that creates more questions. What exactly does ATF talk to
for the watchdog? The SCU firmware?

Maybe ATF should define and provide a standard watchdog interface? It
is still a question of making the firmware discoverable rather than
trying to describe the firmware in DT.

Rob
