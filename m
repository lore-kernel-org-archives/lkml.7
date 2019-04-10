Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7FD20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDJXhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:37:06 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:58629 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:37:06 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x3ANah5O015380
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Apr 2019 08:36:43 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3ANagIs027706;
        Thu, 11 Apr 2019 08:36:43 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x3ANaPuq031742;
        Thu, 11 Apr 2019 08:36:42 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4172004; Thu, 11 Apr 2019 08:34:53 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Thu,
 11 Apr 2019 08:34:52 +0900
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
Thread-Index: AQHU78DnNYRsXw6c0kywKGsyat34OKY1dZqA
Date:   Wed, 10 Apr 2019 23:34:51 +0000
Message-ID: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
In-Reply-To: <20190410171431.GE26580@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42379DDBC7FCB549917A8ED9EFB6AABE@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xMS8xOSAyOjE0IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgQXBy
IDA4LCAyMDE5IGF0IDExOjEwOjE3UE0gKzAwMDAsIEp1bmljaGkgTm9tdXJhIHdyb3RlOg0KPj4g
LSNpZmRlZiBDT05GSUdfRUZJDQo+PiAtCXVuc2lnbmVkIGxvbmcgc3lzdGFiLCBzeXN0YWJfdGFi
bGVzLCBjb25maWdfdGFibGVzOw0KPj4gLQl1bnNpZ25lZCBpbnQgbnJfdGFibGVzOw0KPj4gK3N0
YXRpYyB2b2lkIGVmaV9yZWFkX2Jvb3RfcGFyYW1zKHZvaWQpDQo+PiArew0KPj4gKwlzdHJ1Y3Qg
ZWZpX3NldHVwX2RhdGEgKmVzZDsNCj4+ICAJc3RydWN0IGVmaV9pbmZvICplaTsNCj4+IC0JYm9v
bCBlZmlfNjQ7DQo+PiAtCWludCBzaXplLCBpOw0KPj4gIAljaGFyICpzaWc7DQo+PiAgDQo+PiAr
CWtleGVjX2VmaV9zZXR1cF9kYXRhID0gZWZpX2dldF9rZXhlY19zZXR1cF9kYXRhX2FkZHIoKTsN
Cj4gDQo+IFdoeSBpcyB0aGF0IHdyaXR0ZW4gaGVyZSBhbmQgdGVzdGVkIGluIGFub3RoZXIgZnVu
Y3Rpb24/IT8NCg0KQm90aCBlZmlfZ2V0X3JzZHBfYWRkcigpIGFuZCBrZXhlY19nZXRfcnNkcF9h
ZGRyKCkgbmVlZCB0byBjaGVjaw0KdGhlIHJlc3VsdCBvZiBlZmlfZ2V0X2tleGVjX3NldHVwX2Rh
dGFfYWRkcigpOyB0aGUgZm9ybWVyIHRvIGNoZWNrDQp3aGV0aGVyIHRvIGV4aXQgZWFybHksIHRo
ZSBsYXR0ZXIgdG8gdXNlIHRoZSBhZGRyZXNzIG9mIHRoZSB0YWJsZXMuDQpJIHRob3VnaHQgaXQn
cyBiZXR0ZXIgdG8gc3RvcmUgdGhlIHJlc3VsdCBpbnN0ZWFkIG9mIGNhbGxpbmcgdHdpY2UuDQoN
Cj4+ICsNCj4+ICAJZWkgPSAmYm9vdF9wYXJhbXMtPmVmaV9pbmZvOw0KPj4gIAlzaWcgPSAoY2hh
ciAqKSZlaS0+ZWZpX2xvYWRlcl9zaWduYXR1cmU7DQo+PiAgDQo+PiAgCWlmICghc3RybmNtcChz
aWcsIEVGSTY0X0xPQURFUl9TSUdOQVRVUkUsIDQpKSB7DQo+PiAgCQllZmlfNjQgPSB0cnVlOw0K
Pj4gKwkJZWZpX2Jvb3RlZCA9IHRydWU7DQo+IA0KPiBXaGF0IGlzIHRoYXQgdWdsaW5lc3MgZm9y
PyBIYXZlIHlvdSBoZWFyZCBvZiBmdW5jdGlvbnMgcmV0dXJuaW5nIHZhbHVlcz8NCg0KU2FtZSBh
cyBhYm92ZS4gSSBkaWRuJ3Qgd2FudCB0byBkbyBzaWduYXR1cmUgY2hlY2sgdHdpY2UsIGluDQpl
ZmlfZ2V0X3JzZHBfYWRkcigpIGFuZCBrZXhlY19nZXRfcnNkcF9hZGRyKCkuDQpBbHNvLCB0aGUg
c2lnbmF0dXJlIGNoZWNrIGhhcyAyIHJldHVybiB2YWx1ZXMsIHdoZXRoZXIgaXQgd2FzIDMyYml0
DQpvciA2NGJpdCwgYW5kIHdoZXRoZXIgdGhlIHNpZ25hdHVyZSB3YXMgdmFsaWQgb3Igbm90Lg0K
SSBjb3VsZCByZXR1cm4gb25lIG9mIHRoZW0gdmlhIHBvaW50ZXIgcGFzc2VkIHBhcmFtZXRlciBi
dXQgSSB0aG91Z2h0DQppdCdzIGEgbGl0dGxlIGJpdCB1Z2x5LiAgT3IgSSBjb3VsZCBlbmNvZGUg
dGhlbSBhcyBzb21ldGhpbmcgbGlrZQ0KRUZJX1NJR05BVFVSRV82NCwgRUZJX1NJR05BVFVSRV8z
MiwgYW5kIEVGSV9TSUdOQVRVUkVfSU5WQUxJRC4NCkJ1dCBJJ20gbm90IHN1cmUgaXQncyBnb29k
IHRvIGludHJvZHVjZSBzdWNoIGEgdGhpbmcganVzdCBmb3IgaGVyZS4NCg0KPj4gK3N0YXRpYyBh
Y3BpX3BoeXNpY2FsX2FkZHJlc3MgZWZpX2dldF9yc2RwX2FkZHIodm9pZCkNCj4+ICt7DQo+PiAr
I2lmZGVmIENPTkZJR19FRkkNCj4+ICsJdW5zaWduZWQgbG9uZyBjb25maWdfdGFibGVzOw0KPj4g
Kwl1bnNpZ25lZCBpbnQgbnJfdGFibGVzOw0KPj4gKw0KPj4gKwllZmlfcmVhZF9ib290X3BhcmFt
cygpOw0KPiANCj4gV2h5IGRvIHlvdSByZWFkIGJvb3QgcGFyYW1zIGhlcmU/DQo+IA0KPiBObywg
bm8sIG5vLg0KPiANCj4gRmlyc3QgeW91IGRvDQo+IA0KPiAJZWZpX2dldF9yc2RwX2FkZHIoKQ0K
PiANCj4gaWYgeW91IGNhbm5vdCBnZXQgYW4gYWRkcmVzcywgeW91DQoNCkJ1dCBlZmlfZ2V0X3Jz
ZHBfYWRkcigpIG5lZWRzIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGtlcm5lbCB3YXMNCmtleGVjIGJv
b3RlZCB0byBhdm9pZCBhY2Nlc3NpbmcgaW52YWxpZCBFRkkgdGFibGUgYWRkcmVzcy4NCmVmaV9n
ZXRfa2V4ZWNfc2V0dXBfZGF0YV9hZGRyKCkgaXMgdGhlIG9ubHkgbWV0aG9kIEkga25vdw0KdG8g
Y2hlY2sgaWYgaXQgd2FzIGtleGVjLWJvb3RlZC4NCg0KPiAJLSBwYXJzZSBib290IHBhcmFtcw0K
PiAJLSB0aGVuIHBhcnNlIEVGSSB0YWJsZXMgZnJvbSB0aGUgYWRkcmVzcyB0aGUga2V4ZWNlZCBr
ZXJuZWwgcmVjZWl2ZWQNCj4gDQo+IE5vIGludGVybWl4aW5nIG9mIGNvZGUgcGF0aHMgYW5kIGFz
c2lnbmluZyB2YXJpYWJsZXMgaW4gb25lIGZ1bmN0aW9uIGFuZA0KPiB1c2luZyB0aGVtIGluIGFu
b3RoZXIuDQoNClllYWgsIEkgZG9uJ3QgbGlrZSB0aGF0LiBCdXQgaWYgd2UgYXJlIHRvIGhhbmRs
ZSAzMmJpdCBFRkkgY2FzZSwNCmVmaV9nZXRfcnNkcF9hZGRyKCkgYW5kIGtleGVjX2dldF9yc2Rw
X2FkZHIoKSBiZWNvbWUgZnVsbCBvZg0KZHVwbGljYXRpb24uDQoNCj4gWW91IHdlcmUgb24gdGhl
IHJpZ2h0IHRyYWNrIHdpdGggdjMuLi4NCg0KLS0gDQpKdW4naWNoaSBOb211cmEsIE5FQyBDb3Jw
b3JhdGlvbiAvIE5FQyBTb2x1dGlvbiBJbm5vdmF0b3JzLCBMdGQu

