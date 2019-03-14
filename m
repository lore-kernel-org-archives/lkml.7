Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F14C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623FE2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCNJ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:56:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42420 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbfCNJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:56:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-74-TobEOxoeMTG-CuDkP8MQ6g-1; Thu, 14 Mar 2019 09:56:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 14 Mar 2019 09:57:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 14 Mar 2019 09:57:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "James Y Knight" <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] lib/string.c: implement a basic bcmp
Thread-Topic: [PATCH v4] lib/string.c: implement a basic bcmp
Thread-Index: AQHU2eHAzQyEtWlUlk+QZlb9ZBEAGqYK4nwg
Date:   Thu, 14 Mar 2019 09:57:05 +0000
Message-ID: <953400721b6c4b869b9278c44e0aa796@AcuMS.aculab.com>
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
 <20190313211335.165605-1-ndesaulniers@google.com>
In-Reply-To: <20190313211335.165605-1-ndesaulniers@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: TobEOxoeMTG-CuDkP8MQ6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxMyBNYXJjaCAyMDE5IDIxOjE0DQouLi4N
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3RyaW5nLmggYi9pbmNsdWRlL2xpbnV4L3N0
cmluZy5oDQo+IGluZGV4IDc5MjdiODc1ZjgwYy4uNmFiMGE2ZmE1MTJlIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3N0cmluZy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3RyaW5nLmgN
Cj4gQEAgLTE1MCw2ICsxNTAsOSBAQCBleHRlcm4gdm9pZCAqIG1lbXNjYW4odm9pZCAqLGludCxf
X2tlcm5lbF9zaXplX3QpOw0KPiAgI2lmbmRlZiBfX0hBVkVfQVJDSF9NRU1DTVANCj4gIGV4dGVy
biBpbnQgbWVtY21wKGNvbnN0IHZvaWQgKixjb25zdCB2b2lkICosX19rZXJuZWxfc2l6ZV90KTsN
Cj4gICNlbmRpZg0KPiArI2lmbmRlZiBfX0hBVkVfQVJDSF9CQ01QDQo+ICtleHRlcm4gaW50IGJj
bXAoY29uc3Qgdm9pZCAqLGNvbnN0IHZvaWQgKixfX2tlcm5lbF9zaXplX3QpOw0KPiArI2VuZGlm
DQoNClNob3VsZG4ndCB0aGF0IHByb3RvdHlwZSBhbHdheXMgYmUgcHJlc2VudD8NCkFueSBhcmNo
aXRlY3R1cmUgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gYmV0dGVyIGhhdmUgdGhlIHNhbWUgZGVm
aW5pdGlvbi4NClRoaXMgaXMgcGFydGljdWxhcmx5IHRydWUgaGVyZSBzaW5jZSB0aGUgY29tcGls
ZXIgaXMgZ29pbmcgdG8gYXNzdW1lDQp0aGUgZGVmYXVsdCBjYWxsaW5nIGNvbnZlbnRpb24uDQoN
ClRoZSBvbmx5IHRpbWUgeW91IHdvdWxkbid0IHdhbnQgaXQgaXMgd2hlbiB0aGUgYXJjaGl0ZWN0
dXJlIHNwZWNpZmljDQppbXBsZW1lbnRhdGlvbiBpcyBpbmxpbmUgYXNtLg0KSWYgdGhhdCB3ZXJl
IGFuIG9wdGlvbiB0aGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiB3b3VsZCBuZWVkIHRvIGJlDQpl
eGNsdWRlZCB1c2luZyBhIGRpZmZlcmVudCAjZGVmaW5lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

