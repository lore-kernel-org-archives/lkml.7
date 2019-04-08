Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC75C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614421473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDHNbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:31:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:26822 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfDHNbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:31:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 06:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="147483117"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 06:30:57 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.31]) with mapi id 14.03.0415.000;
 Mon, 8 Apr 2019 14:30:56 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU7dJsIdze6jSaA0qMnvHjeKNle6YyJqcAgAAYX2A=
Date:   Mon, 8 Apr 2019 13:30:56 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C43BBA@IRSMSX102.ger.corp.intel.com>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble>
In-Reply-To: <20190408124940.hb4d2mvwue7aydjj@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjQ1ODVlMWEtZTIwNS00ZTc4LWJmNzAtMTBiMTRkOWNhMmVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRXhMZGZPNXN5cHRZdE9qc1BnNmpZREpUSlNMa0o1V3hTRko4RWVkbmtuQzNLQ1hqU0Zzb1BhSndnTkxZcG1cL0wifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1vbiwgQXByIDA4LCAyMDE5IGF0IDA5OjEzOjU4QU0gKzAzMDAsIEVsZW5hIFJlc2hl
dG92YSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvY29tbW9uLmMgYi9h
cmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KPiA+IGluZGV4IDdiYzEwNWY0N2QyMS4uMzhkZGMyMTNh
NWU5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2VudHJ5L2NvbW1vbi5jDQo+ID4gKysrIGIv
YXJjaC94ODYvZW50cnkvY29tbW9uLmMNCj4gPiBAQCAtMzUsNiArMzUsMTIgQEANCj4gPiAgI2Rl
ZmluZSBDUkVBVEVfVFJBQ0VfUE9JTlRTDQo+ID4gICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvc3lz
Y2FsbHMuaD4NCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VU
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4NCj4gPiArDQo+ID4gK3ZvaWQgKmFsbG9j
YShzaXplX3Qgc2l6ZSk7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgI2lmZGVmIENPTkZJR19D
T05URVhUX1RSQUNLSU5HDQo+ID4gIC8qIENhbGxlZCBvbiBlbnRyeSBmcm9tIHVzZXIgbW9kZSB3
aXRoIElSUXMgb2ZmLiAqLw0KPiA+ICBfX3Zpc2libGUgaW5saW5lIHZvaWQgZW50ZXJfZnJvbV91
c2VyX21vZGUodm9pZCkNCj4gPiBAQCAtMjczLDYgKzI3OSwxMyBAQCBfX3Zpc2libGUgdm9pZCBk
b19zeXNjYWxsXzY0KHVuc2lnbmVkIGxvbmcgbnIsIHN0cnVjdA0KPiBwdF9yZWdzICpyZWdzKQ0K
PiA+ICB7DQo+ID4gIAlzdHJ1Y3QgdGhyZWFkX2luZm8gKnRpOw0KPiA+DQo+ID4gKyNpZmRlZiBD
T05GSUdfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQNCj4gPiArCXNpemVfdCBvZmZzZXQgPSAoKHNp
emVfdClwcmFuZG9tX3UzMigpKSAlIDI1NjsNCj4gPiArCWNoYXIgKnB0ciA9IGFsbG9jYShvZmZz
ZXQpOw0KPiA+ICsNCj4gPiArCWFzbSB2b2xhdGlsZSgiIjoiPW0iKCpwdHIpKTsNCj4gPiArI2Vu
ZGlmDQo+ID4gKw0KPiA+ICAJZW50ZXJfZnJvbV91c2VyX21vZGUoKTsNCj4gPiAgCWxvY2FsX2ly
cV9lbmFibGUoKTsNCj4gPiAgCXRpID0gY3VycmVudF90aHJlYWRfaW5mbygpOw0KPiANCj4gV291
bGQgaXQgbWFrZSBzZW5zZSB0byBhbHNvIGRvIHRoaXMgZm9yIHRoZSBjb21wYXQgc3lzY2FsbHMN
Cj4gKGRvX2Zhc3Rfc3lzY2FsbF8zMiwgZG9faW50ODBfc3lzY2FsbF8zMik/DQoNCkdvb2QgcXVl
c3Rpb24uIA0KT3JpZ2luYWxseSBJIHdhcyB0aGlua2luZyB0aGF0IGluLXN0YWNrIHJhbmRvbWl6
YXRpb24gbWFrZXMgc2Vuc2UNCm9ubHkgZm9yIHg4Nl82NCwgc2luY2UgdGhpcyBpcyB3aGF0IFZN
QVAgc3RhY2sgb24geDg2IGRlcGVuZHMgb24uDQpXaXRob3V0IFZNQVAgc3RhY2sgYW5kIGd1YXJk
IHBhZ2VzLCB0aGVyZSBhcmUgZWFzaWVyIHdheXMgdG8gYXR0YWNrLCANCnNvIGhhcmRlbmluZyB0
aGVyZSBkb2VzIG5vdCByZWFsbHkgbWFrZXMgdGhhdCBtdWNoIHNlbnNlIElNTy4gDQpIb3dldmVy
IHRoZSAzMiBlbXVsYXRpb24gY2FzZSBpcyBpbnRlcmVzdGluZywgSSBkaWRuJ3QgdGhpbmsgb2Yg
aXQgYmVmb3JlLg0KSSBndWVzcyBpZiBpdCB1c2VzIFZNQVAtYmFzZWQgc3RhY2ssIHRoZW4gd2Ug
c2hvdWxkIHN1cHBvcnQgdGhlc2UgY2FsbHMgYWxzbyANCndpdGggaW4tc3RhY2sgcmFuZG9taXph
dGlvbi4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQo=
