Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB9AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4850206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDCPtL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:49:11 -0400
Received: from smtp.asem.it ([151.1.184.197]:62577 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDCPtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:49:10 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003789739.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:49:03 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 3
 Apr 2019 17:49:03 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 3 Apr 2019 17:49:03 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] rtc: pcf2127: add battery-low INTn generation
Thread-Topic: [PATCH 2/2] rtc: pcf2127: add battery-low INTn generation
Thread-Index: AQHU6izzDrhx33Rd2E28nY3Qp112E6YqaEkAgAAhzmD//+S2gIAAI/HA
Date:   Wed, 3 Apr 2019 15:49:03 +0000
Message-ID: <fd4bef0bb64e4b6fbdf74cbebaa12de3@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
 <20190403150824.GO22216@piout.net> <452a4cf1410a41c8b6f767ac6258482e@asem.it>
 <20190403153143.GQ22216@piout.net>
In-Reply-To: <20190403153143.GQ22216@piout.net>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0210.5CA4D5F0.003A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On 03/04/2019 16:52:45+0200, Flavio Suligoi wrote:
> > > > The pcf2127 has an automatic battery-low detection function.
> > > >
> > > > In case of battery-low event, an interrupt generation through
> > > > the pin INTn (active low) can be enabled, setting the flag BLIE
> > > > in the register Control_3.
> > > >
> > > > This function is activated by the "battery-low-hw-alarm" DT
> property.
> > > >
> > > > Example of use for an NXP i.MX7D board:
> > > >
> > > > &i2c3 {
> > > > 	clock-frequency = <100000>;
> > > > 	pinctrl-names = "default";
> > > > 	pinctrl-0 = <&pinctrl_i2c3>;
> > > > 	status = "okay";
> > > >
> > > > 	pcf2127@51 {
> > > > 		compatible = "nxp,pcf2127";
> > > > 		reg = <0x51>;
> > > > 		battery-low-hw-alarm;
> > > > 		status = "okay";
> > > > 	};
> > > > };
> > > >
> > >
> > > So I'm curious, how do you then use that signal? I have a (not yet
> sent)
> > > series adding alarm support for the pcf2127. The issue having BLIE is
> > > that then this will prevent the alarm to work properly.
> > >
> > > So my guess is that you have nINT connected to an LED or something
> that
> > > the user can see?
> > >
> >
> > I'm working on our custom embedded board with an NXP i.MX7D,
> > developed here, in Asem (www.asem.it).
> > The nINT pin is connected to a GPIO of the MX7 and then
> > used by an applicative sw, to generate an alarm for the user.
> >
> 
> Then, you should probably not enable BLIE because this will cause issues
> with the alarm functionnality.. It is certainly enough to use
> RTC_VL_READ periodically.

We use the nINT signaling solution because of this pin, in addition
to be used by the CPU, can be also connected to an external connector,
available for the final user.
Anyway, even if the BLIE is set, the sw low voltage alarm works,
with the message (displayed about every 12 minutes):

rtc-pcf2127-i2c 2-0051: low voltage detected, check/replace RTC battery.

What kind of issues did you find with BLIE enabled?

Flavio

