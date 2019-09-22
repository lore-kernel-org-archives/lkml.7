Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2A820830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfIVQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:14:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46699 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfIVQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:14:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4F20D8031F; Sun, 22 Sep 2019 18:13:53 +0200 (CEST)
Date:   Sun, 22 Sep 2019 18:14:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/5] input: keyboard: imx_sc: Add i.MX system
 controller power key support
Message-ID: <20190922161401.GC1999@bug>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com>
 <6d8dd5df-02da-b4cd-e61d-a4a15d0bf0c8@pengutronix.de>
 <DB3PR0402MB391602C6B425DD7EBFB9AF1DF5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <dbe0ba0a-29bc-ee96-541d-244b3dbf0b81@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe0ba0a-29bc-ee96-541d-244b3dbf0b81@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Why is it global struct? It seems to be flexible configurable over devicetree.
> >>So I would assume it should be able to handle more then one button. Please
> >>remove global variables, make it allocatable per OF node.
> >
> >There is ONLY one button available for SC key, but yes, I think I can make the structure
> >private and get all necessary data from the structure using container_of.
> 
> And we will never need more then 640 kB RAM ;)
> https://en.wikiquote.org/wiki/Talk:Bill_Gates

Right question is "is it worth complicating kernel now (and making it slower/bigger)
for future flexibility?". And I believe answer is "no", but it is not a big deal
either way.								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
