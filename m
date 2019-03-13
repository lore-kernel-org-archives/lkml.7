Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F7213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552506941;
	bh=340+p310qnidCobicGuTTNyECt8RLh9dAdPWAfEnmSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KviK3R/rIEJv/2PVVJmnrcTLL8hfJ3rJRso8/MwigFsFZqjwlu/HGInvQiefKDq6W
	 VCQjHloPlJIzLlUQ+QGND5kYOHws/2Zh9U92mtrUj+231cBvEpm1cdvVJaCNT/dNSi
	 aQZX59WwJgNQhZca/p+yUqKwQXZ9AGsis21325kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCMTzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfCMTzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:55:39 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77C92146E;
        Wed, 13 Mar 2019 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552506938;
        bh=340+p310qnidCobicGuTTNyECt8RLh9dAdPWAfEnmSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0xREk5X/HEIfk7hCOk3zX2dMh+ulg1ULwr+ych8MmAUG2l0ZC+rvMPDg0YI8f6tua
         CrsWImBAyQs+bjeQ5/BDwwWEbs8D7tF5LcQi7nQ+E75dKWOjrmwBjOX8B+9pP4jD6z
         +pE5w+P4ISLtvIKdvU59o7SMPoVpp8XV0+5fIi6Y=
Received: by mail-qt1-f174.google.com with SMTP id k2so3449481qtm.1;
        Wed, 13 Mar 2019 12:55:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUykycoD4G9/EFjnxQbOnJnsn2GP2jqMl1LGFOfNVVB+zEXYzF6
        UrFE6bG+1rggf8d+K1d3ZU3M/gsg0dJTeR3tbA==
X-Google-Smtp-Source: APXvYqwpsiDCY/J7tDtwAN9LWubhHpcUVEAXb1FzytPqwZ+DhdOVaOkHXcZIrixi5BiiEOQy2QDyC49rBL7zLGf8wU0=
X-Received: by 2002:ac8:6610:: with SMTP id c16mr3025992qtp.144.1552506938102;
 Wed, 13 Mar 2019 12:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com> <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net> <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net> <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
 <DB3PR0402MB391698A30FC58BA8BFAC20B3F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911BA1CDA911F94071BE320F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3911BA1CDA911F94071BE320F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Mar 2019 14:55:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFcTm0BUEhty+t6Yajc3m27BrieQRaEuTZjGZG35+N+Q@mail.gmail.com>
Message-ID: <CAL_JsqKFcTm0BUEhty+t6Yajc3m27BrieQRaEuTZjGZG35+N+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 3:11 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>         Do you have any feedback about adding imx scu watchdog node in dts? Thanks.

Yes, in my reply 2 days ago.

Rob
