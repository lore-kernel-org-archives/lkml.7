Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189BC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8CD20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDHHWw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:22:52 -0400
Received: from smtp.asem.it ([151.1.184.197]:50917 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfDHHWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:22:52 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003797119.MSG 
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:22:44 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Mon, 8
 Apr 2019 09:22:44 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Mon, 8 Apr 2019 09:22:44 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Index: AQHU6izzMP9bJdl0YUGdR5AsgVFjFaYuiBOAgAByKgCAAuR9QA==
Date:   Mon, 8 Apr 2019 07:22:44 +0000
Message-ID: <58b8e1bc2b064abcb67db04369cf9c6e@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <5ca84214.1c69fb81.e3ace.21e5@mx.google.com>
 <20190406125550.GA7480@piout.net>
In-Reply-To: <20190406125550.GA7480@piout.net>
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
X-SGOP-RefID: str=0001.0A0B0213.5CAAF6C5.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

> On 06/04/2019 01:07:13-0500, Rob Herring wrote:
> > On Wed, Apr 03, 2019 at 04:52:44PM +0200, Flavio Suligoi wrote:
> > > Some RTC devices have a battery-low automatic detection circuit.
> > > The battery-low event is usually reported with:
> > >
> > > - a bit change in a RTC status register
> > > - a hw signaling (generally using an interrupt generation), changing
> > >   the hw level of a specific pin;
> > >
> > > The new property "battery-low-hw-alarm" enable the RTC to generate the
> > > hw signaling in case of battery-low event.
> > >
> > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt
> b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > index a97fc6a..f93a44d 100644
> > > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > @@ -31,6 +31,9 @@ below.
> > >                              expressed in femto Farad (fF).
> > >                              The default value shall be listed (if
> optional),
> > >                              and likewise all valid values.
> > > +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This
> function
> > > +                            is available on the following devices:
> > > +                            - pcf2127 - pin used for alarm: INTn
> >
> > Boolean? If there's cases where which pin is selectable, then we'd need
> > this to take a value. Not sure how likely that is?
> >
> 
> Indeed, there is at least the pcf85363 that has two possible pins for
> that interrupt. How would you select the pin then? a zero based index? a
> string?

I think the string could be clearer for the final user and would give
more freedom for future changes.
For example, we can call this property, instead of "battery-low-alarm" or 
"low-voltage-alarm", simply: "alarm-pin_1" and then the string argument 
can describe the function used; for example:

alarm-pin_1 = "backup-supply-low-voltage-alarm";
alarm-pin_2 = "......";

Flavio Suligoi
