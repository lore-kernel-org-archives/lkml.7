Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E55D20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDOXPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:15:24 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:41414 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOXPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:15:24 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3FNF56F030293
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:15:05 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3FNF5SQ023468;
        Tue, 16 Apr 2019 08:15:05 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3FNF5ai016353;
        Tue, 16 Apr 2019 08:15:05 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4307334; Tue, 16 Apr 2019 08:14:35 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Tue,
 16 Apr 2019 08:14:34 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>
CC:     Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqAgACP04CAAAH9AIAABdcAgAAJ5YCAAAJaAIAAAziAgAACJICAADc+AIAA6YwAgABjYACAAE/IgIAESQcAgAAjCICAABXVgIAA0vGAgAAD9AA=
Date:   Mon, 15 Apr 2019 23:14:34 +0000
Message-ID: <4dbbbb4b-7af9-bd98-b567-890407a15cd1@ce.jp.nec.com>
References: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
In-Reply-To: <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <10D4B959CC531049896B4751EA2CD217@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8xOSA4OjAwIEFNLCBKdW5pY2hpIE5vbXVyYSB3cm90ZToNCj4gT24gNC8xNS8xOSA3
OjI1IFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBNb24sIEFwciAxNSwgMjAxOSBh
dCAxMTowNzoxN0FNICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24gTW9uLCBB
cHIgMTUsIDIwMTkgYXQgMDc6MDE6NTRBTSArMDAwMCwgSnVuaWNoaSBOb211cmEgd3JvdGU6DQo+
Pj4+IE9LLiBUaGVuIEknbGwgZ28gYmFjayB0byB2MyBhbmQgbWFrZSBzdXJlIHRvIGhhbmcgd2hl
bg0KPj4+PiBzb21ldGhpbmcgaXMgd3JvbmcgZHVyaW5nIGtleGVjIGJvb3Qgb24gRUZJIHN5c3Rl
bS4NCj4+Pg0KPj4+IE5vIG5lZWQgLSBJIGhhdmUgaXQgaGVyZSBsb2NhbGx5LiBJJ2xsIGNsZWFu
IGl0IHVwIGFuZCBwb3N0IGl0IGZvcg0KPj4+IHJldmlldy4NCj4+DQo+PiBIZXJlIGl0IGlzLiBP
aywgbm90IG9rPw0KPiANCj4gVGhhbmsgeW91LiAgQmFzaWNhbGx5IG9rLg0KPiBJIHB1dCBzb21l
IGNvbW1lbnRzIGJlbG93IGFib3V0IHdoZXRoZXIgdG8gaGFuZyBvciByZXR1cm4uDQo+IA0KPj4g
K3N0YXRpYyBhY3BpX3BoeXNpY2FsX2FkZHJlc3Mga2V4ZWNfZ2V0X3JzZHBfYWRkcih2b2lkKQ0K
Pj4gK3sNCj4+ICsJZWZpX3N5c3RlbV90YWJsZV82NF90ICpzeXN0YWI7DQo+PiArCXN0cnVjdCBl
Zmlfc2V0dXBfZGF0YSAqZXNkOw0KPj4gKwlzdHJ1Y3QgZWZpX2luZm8gKmVpOw0KPj4gKwljaGFy
ICpzaWc7DQo+PiArDQo+PiArCWVzZCA9IChzdHJ1Y3QgZWZpX3NldHVwX2RhdGEgKilnZXRfa2V4
ZWNfc2V0dXBfZGF0YV9hZGRyKCk7DQo+PiArCWlmICghZXNkKQ0KPj4gKwkJcmV0dXJuIDA7DQo+
PiArDQo+PiArCWlmICghZXNkLT50YWJsZXMpIHsNCj4+ICsJCWRlYnVnX3B1dHN0cigiV3Jvbmcg
a2V4ZWMgU0VUVVBfRUZJIGRhdGEuXG4iKTsNCj4+ICsJCXJldHVybiAwOw0KPj4gKwl9DQo+IA0K
PiBJIHRob3VnaHQgd2Ugc2hvdWxkIGhhbmcgaGVyZSBpbnN0ZWFkIG9mIHJldHVybiBzbyB0aGF0
IHdlDQo+IGRvbid0IHJ1biBpbnRvIGVmaV9nZXRfcnNkcF9hZGRyKCkgaW4gY2FzZSBvZiBrZXhl
Yy4NCj4gDQo+PiArCWVpID0gJmJvb3RfcGFyYW1zLT5lZmlfaW5mbzsNCj4+ICsJc2lnID0gKGNo
YXIgKikmZWktPmVmaV9sb2FkZXJfc2lnbmF0dXJlOw0KPj4gKwlpZiAoc3RybmNtcChzaWcsIEVG
STY0X0xPQURFUl9TSUdOQVRVUkUsIDQpKSB7DQo+PiArCQlkZWJ1Z19wdXRzdHIoIldyb25nIGtl
eGVjIEVGSSBsb2FkZXIgc2lnbmF0dXJlLlxuIik7DQo+PiArCQlyZXR1cm4gMDsNCj4+ICsJfQ0K
PiANCj4gU2FtZSBoZXJlLg0KDQpPbmUgbW9yZSBxdWVzdGlvbiBqdXN0IGZvciBjbGFyaWZpY2F0
aW9uLg0KDQpJIHNlZSBrZXhlYyBpcyBvbmx5IHN1cHBvcnRlZCBvbiA2NGJpdCBrZXJuZWwuIEJ1
dCBhcmUgd2Ugc3VyZQ0Kd2UgZG9uJ3QgbmVlZCB0byBzdXBwb3J0IGtleGVjIG9uIEVGSTMyICsg
NjRiaXQga2VybmVsPw0KDQpJIGRvbid0IGhhdmUgc3VjaCBhbiBlbnZpcm9ubWVudCBhbmQgYXMg
ZmFyIGFzIEkgdHJpZWQgd2l0aCBPVk1GIGkzODYNCmFuZCBLVk0gZ3Vlc3QsIHRoYXQgY29tYmlu
YXRpb24gZG9lc24ndCB3b3JrIHJlbGlhYmx5IGV2ZW4gd2l0aCB2NS4wLg0KU28gSSBzdXBwb3Nl
IHBlb3BsZSBkb24ndCBjYXJlLg0KDQo+PiArCS8qIEdldCBzeXN0YWIgZnJvbSBib290IHBhcmFt
cy4gKi8NCj4+ICsJc3lzdGFiID0gKGVmaV9zeXN0ZW1fdGFibGVfNjRfdCAqKSAoZWktPmVmaV9z
eXN0YWIgfCAoKF9fdTY0KWVpLT5lZmlfc3lzdGFiX2hpIDw8IDMyKSk7DQo+PiArCWlmICghc3lz
dGFiKQ0KPj4gKwkJZXJyb3IoIkVGSSBzeXN0ZW0gdGFibGUgbm90IGZvdW5kIGluIGtleGVjIGJv
b3RfcGFyYW1zLiIpOw0KPj4gKw0KPj4gKwlyZXR1cm4gX19lZmlfZ2V0X3JzZHBfYWRkcigodW5z
aWduZWQgbG9uZyllc2QtPnRhYmxlcywgc3lzdGFiLT5ucl90YWJsZXMsIHRydWUpOw0KPiANCj4g
U2FtZSBoZXJlIHdoZW4gX19lZmlfZ2V0X3JzZHBfYWRkcigpIHJldHVybnMgMC4NCj4gDQo+IEkn
bSBmaW5lIHdpdGggZWl0aGVyIHdheSwgdGhvdWdoLg0KDQotLSANCkp1bidpY2hpIE5vbXVyYSwg
TkVDIENvcnBvcmF0aW9uIC8gTkVDIFNvbHV0aW9uIElubm92YXRvcnMsIEx0ZC4=

