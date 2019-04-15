Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A41E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfDOXBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:01:21 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:38966 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDOXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:01:21 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3FN114E020887
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:01:01 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3FN10wP013772;
        Tue, 16 Apr 2019 08:01:00 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3FN101m008501;
        Tue, 16 Apr 2019 08:01:00 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.139] [10.38.151.139]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4304439; Tue, 16 Apr 2019 08:00:27 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC11GP.gisp.nec.co.jp ([10.38.151.139]) with mapi id 14.03.0319.002; Tue,
 16 Apr 2019 08:00:26 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YCAAAJaAIAAAziAgAACJICAADc+AIAA6YwAgABjYACAAE/IgIAESQcAgAAjCICAABXVgIAA0vGA
Date:   Mon, 15 Apr 2019 23:00:25 +0000
Message-ID: <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
References: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
In-Reply-To: <20190415102525.GB29317@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BE12C17A1481C41BD1411DC7C61D5DC@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNS8xOSA3OjI1IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgQXBy
IDE1LCAyMDE5IGF0IDExOjA3OjE3QU0gKzAyMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+
IE9uIE1vbiwgQXByIDE1LCAyMDE5IGF0IDA3OjAxOjU0QU0gKzAwMDAsIEp1bmljaGkgTm9tdXJh
IHdyb3RlOg0KPj4+IE9LLiBUaGVuIEknbGwgZ28gYmFjayB0byB2MyBhbmQgbWFrZSBzdXJlIHRv
IGhhbmcgd2hlbg0KPj4+IHNvbWV0aGluZyBpcyB3cm9uZyBkdXJpbmcga2V4ZWMgYm9vdCBvbiBF
Rkkgc3lzdGVtLg0KPj4NCj4+IE5vIG5lZWQgLSBJIGhhdmUgaXQgaGVyZSBsb2NhbGx5LiBJJ2xs
IGNsZWFuIGl0IHVwIGFuZCBwb3N0IGl0IGZvcg0KPj4gcmV2aWV3Lg0KPiANCj4gSGVyZSBpdCBp
cy4gT2ssIG5vdCBvaz8NCg0KVGhhbmsgeW91LiAgQmFzaWNhbGx5IG9rLg0KSSBwdXQgc29tZSBj
b21tZW50cyBiZWxvdyBhYm91dCB3aGV0aGVyIHRvIGhhbmcgb3IgcmV0dXJuLg0KDQo+ICtzdGF0
aWMgYWNwaV9waHlzaWNhbF9hZGRyZXNzIGtleGVjX2dldF9yc2RwX2FkZHIodm9pZCkNCj4gK3sN
Cj4gKwllZmlfc3lzdGVtX3RhYmxlXzY0X3QgKnN5c3RhYjsNCj4gKwlzdHJ1Y3QgZWZpX3NldHVw
X2RhdGEgKmVzZDsNCj4gKwlzdHJ1Y3QgZWZpX2luZm8gKmVpOw0KPiArCWNoYXIgKnNpZzsNCj4g
Kw0KPiArCWVzZCA9IChzdHJ1Y3QgZWZpX3NldHVwX2RhdGEgKilnZXRfa2V4ZWNfc2V0dXBfZGF0
YV9hZGRyKCk7DQo+ICsJaWYgKCFlc2QpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJaWYgKCFl
c2QtPnRhYmxlcykgew0KPiArCQlkZWJ1Z19wdXRzdHIoIldyb25nIGtleGVjIFNFVFVQX0VGSSBk
YXRhLlxuIik7DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCg0KSSB0aG91Z2h0IHdlIHNob3VsZCBo
YW5nIGhlcmUgaW5zdGVhZCBvZiByZXR1cm4gc28gdGhhdCB3ZQ0KZG9uJ3QgcnVuIGludG8gZWZp
X2dldF9yc2RwX2FkZHIoKSBpbiBjYXNlIG9mIGtleGVjLg0KDQo+ICsJZWkgPSAmYm9vdF9wYXJh
bXMtPmVmaV9pbmZvOw0KPiArCXNpZyA9IChjaGFyICopJmVpLT5lZmlfbG9hZGVyX3NpZ25hdHVy
ZTsNCj4gKwlpZiAoc3RybmNtcChzaWcsIEVGSTY0X0xPQURFUl9TSUdOQVRVUkUsIDQpKSB7DQo+
ICsJCWRlYnVnX3B1dHN0cigiV3Jvbmcga2V4ZWMgRUZJIGxvYWRlciBzaWduYXR1cmUuXG4iKTsN
Cj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KDQpTYW1lIGhlcmUuDQoNCj4gKwkvKiBHZXQgc3lzdGFi
IGZyb20gYm9vdCBwYXJhbXMuICovDQo+ICsJc3lzdGFiID0gKGVmaV9zeXN0ZW1fdGFibGVfNjRf
dCAqKSAoZWktPmVmaV9zeXN0YWIgfCAoKF9fdTY0KWVpLT5lZmlfc3lzdGFiX2hpIDw8IDMyKSk7
DQo+ICsJaWYgKCFzeXN0YWIpDQo+ICsJCWVycm9yKCJFRkkgc3lzdGVtIHRhYmxlIG5vdCBmb3Vu
ZCBpbiBrZXhlYyBib290X3BhcmFtcy4iKTsNCj4gKw0KPiArCXJldHVybiBfX2VmaV9nZXRfcnNk
cF9hZGRyKCh1bnNpZ25lZCBsb25nKWVzZC0+dGFibGVzLCBzeXN0YWItPm5yX3RhYmxlcywgdHJ1
ZSk7DQoNClNhbWUgaGVyZSB3aGVuIF9fZWZpX2dldF9yc2RwX2FkZHIoKSByZXR1cm5zIDAuDQoN
CkknbSBmaW5lIHdpdGggZWl0aGVyIHdheSwgdGhvdWdoLg0KDQotLSANCkp1bidpY2hpIE5vbXVy
YSwgTkVDIENvcnBvcmF0aW9uIC8gTkVDIFNvbHV0aW9uIElubm92YXRvcnMsIEx0ZC4=

