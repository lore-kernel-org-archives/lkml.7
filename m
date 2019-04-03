Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B475206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDCQJY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:09:24 -0400
Received: from smtp.asem.it ([151.1.184.197]:55907 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfDCQJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:09:21 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003789787.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 18:09:15 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 3
 Apr 2019 18:09:15 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 3 Apr 2019 18:09:15 +0200
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
Thread-Index: AQHU6izzDrhx33Rd2E28nY3Qp112E6YqaEkAgAAhzmD//+S2gIAAI/HA///jGACAACKDsA==
Date:   Wed, 3 Apr 2019 16:09:14 +0000
Message-ID: <8367f68a023d468f8235810b0cf583bc@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
 <20190403150824.GO22216@piout.net> <452a4cf1410a41c8b6f767ac6258482e@asem.it>
 <20190403153143.GQ22216@piout.net> <fd4bef0bb64e4b6fbdf74cbebaa12de3@asem.it>
 <20190403155654.GR22216@piout.net>
In-Reply-To: <20190403155654.GR22216@piout.net>
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
X-SGOP-RefID: str=0001.0A0B0201.5CA4DAAB.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On 03/04/2019 15:49:03+0000, Flavio Suligoi wrote:
> > > Then, you should probably not enable BLIE because this will cause
> issues
> > > with the alarm functionnality.. It is certainly enough to use
> > > RTC_VL_READ periodically.
> >
> > We use the nINT signaling solution because of this pin, in addition
> > to be used by the CPU, can be also connected to an external connector,
> > available for the final user.
> > Anyway, even if the BLIE is set, the sw low voltage alarm works,
> > with the message (displayed about every 12 minutes):
> >
> 
> I agree the DT property makes sense when the nINT pin is not connected
> to the CPU. But if it is, then you have an issue that nINT will be
> pulled low until the user changes the battery, meaning that you will
> not get any alarm interrupt anymore, possibly leading to a system that
> is not waking up anymore.

Ah, ok, thanks for the info. 
I know this, but in our specific case, this is not a problem,
since we don't use the nINT for other purposes, but only for
a battery low indicator. On the contrary, in our case, it's better
that the alarm signal remains low until the battery is changed.

Anyway, I can specify this collateral effect in a specific file for the
Pcf2127 in the DT bindings Documentation. What do you think?


Flavio Suligoi
