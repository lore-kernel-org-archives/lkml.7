Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2727C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54EF23405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfH2OcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:32:25 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:37485 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfH2OcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:32:24 -0400
Received: from webmail.promanet.nl (edge2.prtnl [192.168.1.170])
        by sparta (Postfix) with ESMTP id CA70B44A0065;
        Thu, 29 Aug 2019 16:34:20 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Aug 2019 16:32:22 +0200
From:   robin <robin@protonic.nl>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
In-Reply-To: <20190829115052.s2m4jw4p3rknqoxb@pengutronix.de>
References: <20190827123216.32728-1-robin@protonic.nl>
 <20190828091550.pdc57wanu6twew5p@pengutronix.de>
 <6d353af709ea545cc34abca5c40674e3@protonic.nl>
 <20190829081712.timamprawezzbesn@pengutronix.de>
 <VE1PR04MB6638A54664EE3FFE16BD419189A20@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190829115052.s2m4jw4p3rknqoxb@pengutronix.de>
Message-ID: <efbaeee1422412098076488fa494a42f@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-29 13:50, Marco Felsch wrote:
> On 19-08-29 09:11, Robin Gong wrote:
>> 
>> On 2019-08-29 16:17, Marco Felsch wrote:
>> > > > While reading the rm it seems that
>> > > > the snvs block has a dedicated version register. IMHO this could be
>> > > > a better way to apply the change also to existing devices with old
>> > > > firmware.
>> > >
>> > > I thought the same thing, and fully agree with you. However I do not
>> > > have a way to determine which versions are out there. Since I couldn't
>> > > find any documentation on this, and I only have i.MX6 S/DL, D/Q and UL
>> > laying around.
>> >
>> > @NXP Kernel Team
>> > Can we get some more information here?
>> Go ahead, please. That snvs version register SNVS_HPVIDR1 should work 
>> as expect.
>> MINOR_REV checking is enough, none-zero means for soc after i.mx6sx, 
>> but
>> Zero means i.mx6q/dl/sl elder soc.
> 
> Thanks. Robin can you integrate that so we can drop the different
> dt-handling?

No problem, I'll post an updated patch tomorrow.

> 
> Regards,
>   Marco
> 
>> >
>> > Regards,
>> >   Marco
>> >
>> > > Regards,
>> > > Robin van der Gracht
>> > >
>> >
>> > --
>> > Pengutronix e.K.                           |
>> > |
>> > Industrial Linux Solutions                 |
>> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.p
>> > engutronix.de%2F&amp;data=02%7C01%7Cyibin.gong%40nxp.com%7C8d4e1
>> > 0cd77bd4652f3eb08d72c594e76%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
>> > C0%7C0%7C637026634390359345&amp;sdata=mhXlUxmLWg8qtwhPQfkJZm
>> > VAn4QQ3YybLOSh83uf27E%3D&amp;reserved=0  |
>> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
>> > |
>> > Amtsgericht Hildesheim, HRA 2686           | Fax:
>> > +49-5121-206917-5555 |
>> 
