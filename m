Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E342C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C2621773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfC2Jhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:37:35 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:48727 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2Jhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:37:35 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T9bI86003605
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 18:37:18 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T9bI2t024459;
        Fri, 29 Mar 2019 18:37:18 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T9b3tM029639;
        Fri, 29 Mar 2019 18:37:18 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3818361; Fri, 29 Mar 2019 18:37:01 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 18:37:00 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Chao Fan <fanc.fnst@cn.fujitsu.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXaYgAhGAgAAQvICAAIi3AIAAvAQAgABdKwCAAAdoAIAAAt2AgAAF2AA=
Date:   Fri, 29 Mar 2019 09:37:00 +0000
Message-ID: <ee8045cf-5100-6bd6-1ccc-e9654da922b6@ce.jp.nec.com>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
 <20190329090550.GI4234@localhost.localdomain>
 <20190329091605.GB21152@zn.tnic>
In-Reply-To: <20190329091605.GB21152@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B78E28343064C543B7A0311C886FAE38@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8xOSA2OjE2IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIEZyaSwgTWFy
IDI5LCAyMDE5IGF0IDA1OjA1OjUwUE0gKzA4MDAsIENoYW8gRmFuIHdyb3RlOg0KPj4gQnV0IGlu
IG15IGNvZGUsIEkgYW0gbm90IHN1cmUgd2hpY2ggdmVyc2lvbiB3aWxsIGJlIGZvdW5kIGZpcnN0
bHksIHNvIEkNCj4+IHdyaXRlIHRoaXMgbG9naWNhbCwgaWYgQUNQSTIwIGZvdW5kLCByZXR1cm4g
ZGlyZWN0bHksIHRoZW4gY29uc2lkZXIgQUNQSSAxLjAuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiBK
dW5pY2hpLCBwbGVhc2UgYWRkIGEgc2hvcnRlciB2ZXJzaW9uIG9mIHRoYXQgYXMgYSBjb21tZW50
IHRvIHRoZSBjb2RlLA0KPiBhYm92ZSB0aGUgZnVuY3Rpb24gbmFtZSBzbyB0aGF0IGl0IGlzIGNs
ZWFyIHdoeSB3ZSdyZSBwcmVmZXJyaW5nIHRoZSAyLjANCj4gdmVyc2lvbi4NCg0KU3VyZSwgSSds
bCBhZGQgdGhpcyBhYm92ZSBfX2VmaV9nZXRfcnNkcF9hZGRyKCkuDQoNCi8qDQogKiBTZWFyY2gg
RUZJIHN5c3RlbSB0YWJsZXMgZm9yIFJTRFAuICBJZiBib3RoIEFDUElfMjBfVEFCTEVfR1VJRCBh
bmQNCiAqIEFDUElfVEFCTEVfR1VJRCBhcmUgZm91bmQsIHRha2UgdGhlIGZvcm1lciwgd2hpY2gg
aGFzIG1vcmUgZmVhdHVyZXMuDQogKi8NCg0KLS0gDQpKdW4naWNoaSBOb211cmEsIE5FQyBDb3Jw
b3JhdGlvbiAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

