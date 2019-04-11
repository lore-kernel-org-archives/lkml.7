Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKNKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:10:11 -0400
Received: from smtp.asem.it ([151.1.184.197]:53582 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKNKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:10:10 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003807555.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:10:07 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 11
 Apr 2019 15:10:05 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Thu, 11 Apr 2019 15:10:05 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] spi: pxa2xx: fix SCR (divisor) calculation
Thread-Topic: [PATCH 1/2] spi: pxa2xx: fix SCR (divisor) calculation
Thread-Index: AQHU75yNrNIZZVaFvEqq7UBMv/VqLKY2ukaAgAA1bGA=
Date:   Thu, 11 Apr 2019 13:10:04 +0000
Message-ID: <3ceba8bc20f8496a9c72653fd450d729@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <34b8442a-15ac-dea2-a088-fde8b1966e1e@linux.intel.com>
In-Reply-To: <34b8442a-15ac-dea2-a088-fde8b1966e1e@linux.intel.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B020A.5CAF3CAD.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFya2tvLA0KDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYyBi
L2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYw0KPiA+IGluZGV4IGY3MDY4Y2MuLmM5NTYwYTEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4gQEAgLTg4NCwxMCArODg0LDE1IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgc3NwX2dldF9jbGtfZGl2KHN0cnVjdA0KPiBkcml2ZXJfZGF0YSAqZHJ2X2RhdGEs
IGludCByYXRlKQ0KPiA+DQo+ID4gICAJcmF0ZSA9IG1pbl90KGludCwgc3NwX2NsaywgcmF0ZSk7
DQo+ID4NCj4gPiArCS8qDQo+ID4gKwkgKiBDYWxjdWxhdGUgdGhlIGRpdmlzb3IgZm9yIHRoZSBT
Q1IgKFNlcmlhbCBDbG9jayBSYXRlKSwgYXZvaWRpbmcNCj4gPiArCSAqIHRoYXQgdGhlIFNTUCB0
cmFuc21pc3Npb24gcmF0ZSBjYW4gYmUgZ3JlYXRlciB0aGFuIHRoZSBkZXZpY2UNCj4gcmF0ZQ0K
PiA+ICsJICovDQo+ID4gICAJaWYgKHNzcC0+dHlwZSA9PSBQWEEyNXhfU1NQIHx8IHNzcC0+dHlw
ZSA9PSBDRTQxMDBfU1NQKQ0KPiA+IC0JCXJldHVybiAoc3NwX2NsayAvICgyICogcmF0ZSkgLSAx
KSAmIDB4ZmY7DQo+ID4gKwkJcmV0dXJuIChzc3BfY2xrIC8gKDIgKiByYXRlKSAtIDEgKw0KPiA+
ICsJCQkoc3NwX2NsayAlICgyICogcmF0ZSkgPyAxIDogMCkpICYgMHhmZjsNCj4gPiAgIAllbHNl
DQo+ID4gLQkJcmV0dXJuIChzc3BfY2xrIC8gcmF0ZSAtIDEpICYgMHhmZmY7DQo+ID4gKwkJcmV0
dXJuIChzc3BfY2xrIC8gcmF0ZSAtIDEgKyAoc3NwX2NsayAlIHJhdGUgPyAxIDogMCkpICYNCj4g
MHhmZmY7DQo+ID4gICB9DQo+ID4NCj4gSSB0aGluayBESVZfUk9VTkRfVVAoKSAtIDEgd291bGQg
YWxzbyBmaXggdGhpcz8NCj4gDQo+IEkgcmVhbGl6ZWQgd2UgaGF2ZSBhbHNvIGFub3RoZXIgaXNz
dWUgaGVyZSB3aXRoIHRoZSBsb3cgcmF0ZXMuDQo+IENhbGN1bGF0ZWQgZGl2aWRlciB3aWxsIHVu
ZGVyZmxvdyBkdWUgbWFza2luZyB3aXRoIDB4ZmYgb3IgMHhmZmYgd2hlbg0KPiB0aGUgcmF0ZSBp
cyBsb3cgZW5vdWdoLg0KPiANCj4gV291bGQgeW91IHdhbnQgdG8gZml4IHRoYXQgYnkgc2V0dGlu
ZyB0aGUgY3Rsci0+bWluX3NwZWVkX2h6IHNvIHRoYXQgc3BpDQo+IGNvcmUgY2FuIHZhbGlkYXRl
IHRoZSByYXRlPyBJJ20gYXNraW5nIHNpbmNlIGl0IGdvZXMgd2VsbCB0b2dldGhlciB3aXRoDQo+
IHlvdXIgZml4LiBNYXliZSBvbmUgcGF0Y2ggc2V0dGluZyB0aGUgbWluX3NwZWVkX2h6IGFuZCBn
ZXR0aW5nIG1hc2tpbmcNCj4gb2ZmIGZyb20gaGVyZSBhbmQgdGhlbiBhbm90aGVyIGZpeGluZyB0
aGUgcmF0ZSBjYWxjdWxhdGlvbi4NCg0KT2sgZm9yIHRoZSB0d28gc2VwYXJhdGUgcGF0Y2hlcywg
SSBwcmVwYXJlIHRoZW0gYXMgc29vbiBhcyBJIGNhbi4NCg0KVGhhbmtzLA0KDQpGbGF2aW8NCg==
