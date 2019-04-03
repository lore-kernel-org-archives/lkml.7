Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47487C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220EB206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDCPcj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:32:39 -0400
Received: from smtp.asem.it ([151.1.184.197]:64447 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDCPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:32:39 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003789678.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:32:31 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 3
 Apr 2019 17:32:31 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 3 Apr 2019 17:32:31 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Index: AQHU6izzMP9bJdl0YUGdR5AsgVFjFaYqZSSAgAAiZeD//+Z9AIAAIfPw
Date:   Wed, 3 Apr 2019 15:32:31 +0000
Message-ID: <f1462ff647f54a04a7009a64359f9f3e@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <20190403145709.GN22216@piout.net> <b45fc9a86a0d4126ad6d8dda9c883043@asem.it>
 <20190403152856.GP22216@piout.net>
In-Reply-To: <20190403152856.GP22216@piout.net>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020A.5CA4D210.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> On 03/04/2019 15:06:17+0000, Flavio Suligoi wrote:
> > Hi Alexandre,
> >
> > > Hi,
> > >
> > > On 03/04/2019 16:52:44+0200, Flavio Suligoi wrote:
> > > > Some RTC devices have a battery-low automatic detection circuit.
> > > > The battery-low event is usually reported with:
> > > >
> > > > - a bit change in a RTC status register
> > > > - a hw signaling (generally using an interrupt generation), changing
> > > >   the hw level of a specific pin;
> > > >
> > > > The new property "battery-low-hw-alarm" enable the RTC to generate
> the
> > > > hw signaling in case of battery-low event.
> > > >
> > > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > > > ---
> > > >  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt
> > > b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > index a97fc6a..f93a44d 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > @@ -31,6 +31,9 @@ below.
> > > >                              expressed in femto Farad (fF).
> > > >                              The default value shall be listed (if
> > > optional),
> > > >                              and likewise all valid values.
> > > > +- battery-low-hw-alarm :    Enable the "battery-low" output pin.
> This
> > > function
> > >
> > > I would name that voltage-low-alarm as not all the secondary voltages
> > > are batteries.
> >
> > You have right. So we can also name the property a: "voltage-low-hw-
> alarm".
> > I prefer to have the word "hw" in the property name, since the "sw"
> voltage
> > low alarm is already present is some RTC drivers.
> > In this way, with the word "hw", is more clear that we are speaking
> about
> > an hw pin signaling.
> >
> 
> Well, the device tree always describes the hardware so there is no point
> in specifying hw.

Right, so I rename the property in "voltage-low-alarm"

> 
> 
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Flavio Suligoi
