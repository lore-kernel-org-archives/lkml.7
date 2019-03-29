Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224DE21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfC2DYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:24:46 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:40493 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2DYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:24:45 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2T3ONCm009286
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 12:24:23 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T3OMNl031248;
        Fri, 29 Mar 2019 12:24:22 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2T3Lmfp017668;
        Fri, 29 Mar 2019 12:24:22 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3797547; Fri, 29 Mar 2019 12:05:54 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Fri,
 29 Mar 2019 12:05:53 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "bhe@redhat.com" <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU5R0gSF49+PGwf02T2oxnk4CVXaYgAhGAgAAQvICAAIi3AIAAvAQA
Date:   Fri, 29 Mar 2019 03:05:52 +0000
Message-ID: <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
References: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic> <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
In-Reply-To: <20190328155256.GP22720@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43DE5C6092BE1F4889EA2F790EF2A411@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8xOSAxMjo1MiBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBzdGF0aWMgYWNw
aV9waHlzaWNhbF9hZGRyZXNzDQo+IF9fZWZpX2dldF9yc2RwX2FkZHIodW5zaWduZWQgbG9uZyBj
b25maWdfdGFibGVzLCB1bnNpZ25lZCBpbnQgbnJfdGFibGVzLA0KPiAgICAgICAgICAgICAgICAg
ICAgIGludCBzaXplLCBib29sIGVmaV82NCkNCj4gDQo+IA0KPj4gIHsNCj4+ICAJYWNwaV9waHlz
aWNhbF9hZGRyZXNzIHJzZHBfYWRkciA9IDA7DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0aGF0IHZh
cmlhYmxlIGFuZCBjYW4gcmV0dXJuICJ0YWJsZSIgb3IgMCBhZnRlciB0aGUgZW5kaWYNCj4gYmVs
b3cuDQoNCkkgY291bGQgZG8gdGhhdCBidXQgaXQgd2lsbCBzbGlnaHRseSBjaGFuZ2UgdGhlIGN1
cnJlbnQgbG9naWMuDQoNCkV4aXN0aW5nIGNvZGUgZG9lcyB0aGlzOg0KDQogICAgICAgICAgICAg
ICAgaWYgKCEoZWZpX2d1aWRjbXAoZ3VpZCwgQUNQSV9UQUJMRV9HVUlEKSkpDQogICAgICAgICAg
ICAgICAgICAgICAgICByc2RwX2FkZHIgPSB0YWJsZTsNCiAgICAgICAgICAgICAgICBlbHNlIGlm
ICghKGVmaV9ndWlkY21wKGd1aWQsIEFDUElfMjBfVEFCTEVfR1VJRCkpKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHRhYmxlOw0KDQpJIHRob3VnaHQgaXQgd2FzIHRvIHJldHVybiB0
aGUgdGFibGUgZm9yIEFDUElfMjBfVEFCTEVfR1VJRA0KaWYgYm90aCB0YWJsZXMgZXhpc3QuICBJ
ZiB3ZSByZW1vdmUgcnNkcF9hZGRyLCB0aGUgY29kZSB3aWxsIGJlOg0KDQogICAgICAgICAgICAg
ICAgaWYgKCEoZWZpX2d1aWRjbXAoZ3VpZCwgQUNQSV9UQUJMRV9HVUlEKSkpDQogICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gdGFibGU7DQogICAgICAgICAgICAgICAgZWxzZSBpZiAoIShl
ZmlfZ3VpZGNtcChndWlkLCBBQ1BJXzIwX1RBQkxFX0dVSUQpKSkNCiAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiB0YWJsZTsNCg0KU28gaWYgdGhlcmUgYXJlIDIgdGFibGVzLCB3ZSByZXR1
cm4gdGhlIG9uZSB0aGF0IGNvbWVzIGZpcnN0Lg0KSXMgaXQgb2s/DQoNCi0tIA0KSnVuJ2ljaGkg
Tm9tdXJhLCBORUMgQ29ycG9yYXRpb24gLyBORUMgU29sdXRpb24gSW5ub3ZhdG9ycywgTHRkLg==

