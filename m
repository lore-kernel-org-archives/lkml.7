Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71859C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424DA20828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH2LvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:51:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfH2LvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:51:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1i3Ix4-0002md-Ut; Thu, 29 Aug 2019 13:50:54 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1i3Ix2-0007yd-A0; Thu, 29 Aug 2019 13:50:52 +0200
Date:   Thu, 29 Aug 2019 13:50:52 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     robin <robin@protonic.nl>, Mark Rutland <mark.rutland@arm.com>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-input @ vger . kernel . org" <linux-input@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel @ lists . infradead . org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] input: keyboard: snvs_pwrkey: Send key events for
 i.MX6 S, DL and Q
Message-ID: <20190829115052.s2m4jw4p3rknqoxb@pengutronix.de>
References: <20190827123216.32728-1-robin@protonic.nl>
 <20190828091550.pdc57wanu6twew5p@pengutronix.de>
 <6d353af709ea545cc34abca5c40674e3@protonic.nl>
 <20190829081712.timamprawezzbesn@pengutronix.de>
 <VE1PR04MB6638A54664EE3FFE16BD419189A20@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638A54664EE3FFE16BD419189A20@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:49:36 up 103 days, 18:07, 63 users,  load average: 0.02, 0.01,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-29 09:11, Robin Gong wrote:
> 
> On 2019-08-29 16:17, Marco Felsch wrote:
> > > > While reading the rm it seems that
> > > > the snvs block has a dedicated version register. IMHO this could be
> > > > a better way to apply the change also to existing devices with old
> > > > firmware.
> > >
> > > I thought the same thing, and fully agree with you. However I do not
> > > have a way to determine which versions are out there. Since I couldn't
> > > find any documentation on this, and I only have i.MX6 S/DL, D/Q and UL
> > laying around.
> > 
> > @NXP Kernel Team
> > Can we get some more information here?
> Go ahead, please. That snvs version register SNVS_HPVIDR1 should work as expect.
> MINOR_REV checking is enough, none-zero means for soc after i.mx6sx, but
> Zero means i.mx6q/dl/sl elder soc.

Thanks. Robin can you integrate that so we can drop the different
dt-handling?

Regards,
  Marco

> > 
> > Regards,
> >   Marco
> > 
> > > Regards,
> > > Robin van der Gracht
> > >
> > 
> > --
> > Pengutronix e.K.                           |
> > |
> > Industrial Linux Solutions                 |
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.p
> > engutronix.de%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7C8d4e1
> > 0cd77bd4652f3eb08d72c594e76%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> > C0%7C0%7C637026634390359345&amp;sdata=mhXlUxmLWg8qtwhPQfkJZm
> > VAn4QQ3YybLOSh83uf27E%3D&amp;reserved=0  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> > +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
