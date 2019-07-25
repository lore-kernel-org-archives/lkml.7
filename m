Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76382C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525652238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGYNGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:06:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:56094 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfGYNGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:06:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-goYqbzeaPXGDmAUnMJc0LA-1; Thu, 25 Jul 2019 14:06:33 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 25 Jul 2019 14:06:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Jul 2019 14:06:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Numfor Mbiziwo-Tiapo' <nums@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "mbd@fb.com" <mbd@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH 3/3] Fix insn.c misaligned address error
Thread-Topic: [PATCH 3/3] Fix insn.c misaligned address error
Thread-Index: AQHVQk/5K6bxIN0Ik02+UTPYCG0F5abbToOQ
Date:   Thu, 25 Jul 2019 13:06:32 +0000
Message-ID: <c256d9b6702b4d37a0c21b93f319b476@AcuMS.aculab.com>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com>
In-Reply-To: <20190724184512.162887-4-nums@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: goYqbzeaPXGDmAUnMJc0LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTnVtZm9yIE1iaXppd28tVGlhcG8NCj4gU2VudDogMjQgSnVseSAyMDE5IDE5OjQ1DQo+
IA0KPiBUaGUgdWJzYW4gKHVuZGVmaW5lZCBiZWhhdmlvciBzYW5pdGl6ZXIpIHZlcnNpb24gb2Yg
cGVyZiB0aHJvd3MgYW4NCj4gZXJyb3Igb24gdGhlICd4ODYgaW5zdHJ1Y3Rpb24gZGVjb2RlciAt
IG5ldyBpbnN0cnVjdGlvbnMnIGZ1bmN0aW9uDQo+IG9mIHBlcmYgdGVzdC4NCj4gDQo+IFRvIHJl
cHJvZHVjZSB0aGlzIHJ1bjoNCj4gbWFrZSAtQyB0b29scy9wZXJmIFVTRV9DTEFORz0xIEVYVFJB
X0NGTEFHUz0iLWZzYW5pdGl6ZT11bmRlZmluZWQiDQo+IA0KPiB0aGVuIHJ1bjogdG9vbHMvcGVy
Zi9wZXJmIHRlc3QgNjIgLXYNCj4gDQo+IFRoZSBlcnJvciBvY2N1cnMgaW4gdGhlIF9fZ2V0X25l
eHQgbWFjcm8gKGxpbmUgMzQpIHdoZXJlIGFuIGludCBpcw0KPiByZWFkIGZyb20gYSBwb3RlbnRp
YWxseSB1bmFsaWduZWQgYWRkcmVzcy4gVXNpbmcgbWVtY3B5IGluc3RlYWQgb2YNCj4gYXNzaWdu
bWVudCBmcm9tIGFuIHVuYWxpZ25lZCBwb2ludGVyLg0KLi4uDQo+ICAjZGVmaW5lIF9fZ2V0X25l
eHQodCwgaW5zbikJXA0KPiAtCSh7IHQgciA9ICoodCopaW5zbi0+bmV4dF9ieXRlOyBpbnNuLT5u
ZXh0X2J5dGUgKz0gc2l6ZW9mKHQpOyByOyB9KQ0KPiArCSh7IHQgcjsgbWVtY3B5KCZyLCBpbnNu
LT5uZXh0X2J5dGUsIHNpemVvZih0KSk7IFwNCj4gKwkJaW5zbi0+bmV4dF9ieXRlICs9IHNpemVv
Zih0KTsgcjsgfSkNCg0KSXNuJ3QgdGhlcmUgYSBnZXRfdW5hbGlnbmVkX3UzMigpIChvciBzaW1p
bGFyKSB0aGF0IGNhbiBiZSB1c2VkPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

