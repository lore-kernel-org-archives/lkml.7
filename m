Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD866C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC592084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfILIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:51:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23360 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730237AbfILIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:51:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-61-S_5-WXazM2aTiQdkIjpwWQ-1; Thu, 12 Sep 2019 09:50:59 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Sep 2019 09:50:57 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Sep 2019 09:50:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <irogers@google.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, "mbd@fb.com" <mbd@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: RE: [RFC][PATCH 1/2] Fix event.c misaligned address error
Thread-Topic: [RFC][PATCH 1/2] Fix event.c misaligned address error
Thread-Index: AQHVaICHKgF7F6wdzUmQAPm92kF936cnvPzQ
Date:   Thu, 12 Sep 2019 08:50:57 +0000
Message-ID: <f8b80a11d1f44503b7dda233a04b11c2@AcuMS.aculab.com>
References: <20190724224954.229540-1-nums@google.com>
 <20190724224954.229540-2-nums@google.com>
 <CAP-5=fUf1BN634Ojkp-sPUV5iryzZ-qbv_UVS-GoNOgj-454dQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUf1BN634Ojkp-sPUV5iryzZ-qbv_UVS-GoNOgj-454dQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: S_5-WXazM2aTiQdkIjpwWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAxMSBTZXB0ZW1iZXIgMjAxOSAxMDowOQ0KPiBPbiBX
ZWQsIEp1bCAyNCwgMjAxOSBhdCAzOjUwIFBNIE51bWZvciBNYml6aXdvLVRpYXBvIDxudW1zQGdv
b2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIHVic2FuICh1bmRlZmluZWQgYmVoYXZpb3Ig
c2FuaXRpemVyKSBidWlsZCBvZiBwZXJmIHRocm93cyBhbg0KPiA+IGVycm9yIHdoZW4gdGhlIHN5
bnRoZXNpemUgIlN5bnRoZXNpemUgY3B1IG1hcCIgZnVuY3Rpb24gZnJvbQ0KPiA+IHBlcmYgdGVz
dCBpcyBydW4uDQo+ID4NCj4gPiBUaGlzIGNhbiBiZSByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcgKGZy
b20gdGhlIHRpcCBkaXJlY3RvcnkpOg0KPiA+IG1ha2UgLUMgdG9vbHMvcGVyZiBVU0VfQ0xBTkc9
MSBFWFRSQV9DRkxBR1M9Ii1mc2FuaXRpemU9dW5kZWZpbmVkIg0KPiA+DQo+ID4gKHNlZSBjb3Zl
ciBsZXR0ZXIgZm9yIHdoeSBwZXJmIG1heSBub3QgYnVpbGQpDQo+ID4NCj4gPiB0aGVuIHJ1bm5p
bmc6IHRvb2xzL3BlcmYvcGVyZiB0ZXN0IDQ0IC12DQo+ID4NCj4gPiBUaGlzIGJ1ZyBvY2N1cnMg
YmVjYXVzZSB0aGUgY3B1X21hcF9kYXRhX19zeW50aGVzaXplIGZ1bmN0aW9uIGluDQo+ID4gZXZl
bnQuYyBjYWxscyBzeW50aGVzaXplX21hc2ssIGNhc3RpbmcgdGhlICdkYXRhJyB2YXJpYWJsZQ0K
PiA+IChvZiB0eXBlIGNwdV9tYXBfZGF0YSopIHRvIGEgY3B1X21hcF9tYXNrKi4gU2luY2Ugc3Ry
dWN0DQo+ID4gY3B1X21hcF9kYXRhIGlzIDIgYnl0ZSBhbGlnbmVkIGFuZCBzdHJ1Y3QgY3B1X21h
cF9tYXNrIGlzIDggYnl0ZQ0KPiA+IGFsaWduZWQgdGhpcyBjYXVzZXMgbWVtb3J5IGFsaWdubWVu
dCBpc3N1ZXMuDQo+ID4NCj4gPiBUaGlzIGlzIGZpeGVkIGJ5IGFkZGluZyA2IGJ5dGVzIG9mIHBh
ZGRpbmcgdG8gdGhlIHN0cnVjdCBjcHVfbWFwX2RhdGEsDQo+ID4gaG93ZXZlciwgdGhpcyB3aWxs
IGJyZWFrIGNvbXBhdGliaWxpdHkgYmV0d2VlbiBwZXJmIGRhdGEgZmlsZXMgLSBhIGZpbGUNCj4g
PiB3cml0dGVuIGJ5IGFuIG9sZCBwZXJmIHdvdWxkbid0IHdvcmsgd2l0aCBhIHBlcmYgd2l0aCB0
aGlzIHBhdGNoIGR1ZQ0KPiA+IHRvIGV2ZW50IGRhdGEgYWxpZ25tZW50IGNoYW5naW5nLg0KPiA+
DQo+ID4gQ29tbWVudHM/DQo+ID4NCj4gPiBOb3QtUXVpdGUtU2lnbmVkLW9mZi1ieTogTnVtZm9y
IE1iaXppd28tVGlhcG8gPG51bXNAZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvcGVy
Zi91dGlsL2V2ZW50LmggfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2V2ZW50LmggYi90b29scy9w
ZXJmL3V0aWwvZXZlbnQuaA0KPiA+IGluZGV4IGViOTVmMzM4NDk1OC4uODJlYWYwNmMyNjA0IDEw
MDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9ldmVudC5oDQo+ID4gKysrIGIvdG9vbHMv
cGVyZi91dGlsL2V2ZW50LmgNCj4gPiBAQCAtNDMzLDYgKzQzMyw3IEBAIHN0cnVjdCBjcHVfbWFw
X21hc2sgew0KPiA+DQo+ID4gIHN0cnVjdCBjcHVfbWFwX2RhdGEgew0KPiA+ICAgICAgICAgdTE2
ICAgICB0eXBlOw0KPiA+ICsgICAgICAgdTggcGFkWzZdOw0KPiA+ICAgICAgICAgY2hhciAgICBk
YXRhW107DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjIuMC42NTcuZzk2MGU5MmQyNGYt
Z29vZw0KPiA+DQo+IEFuIGlkZWEgaGVyZSBpcyB0aGF0LCBpZiB0aGlzIGJyZWFrcyBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5LCB3ZQ0KPiBpbnRyb2R1Y2UgYW4gYWxpZ25lZCB2YXJpYW50IGFuZCB3
b3JrIHRvIGRlcHJlY2F0ZSB0aGUgdW5hbGlnbmVkDQo+IHZhcmlhbnQuIEkgd2lsbCBsb29rIGlu
dG8gbWFraW5nIGEgcGF0Y2ggc2V0Lg0KDQpBZGRpbmcgYSBwYWRbNl0gbWFrZXMgbm8gZGlmZmVy
ZW5jZS4NCllvdSBuZWVkIHRvIGFkZCBhbGlnZW5lZCg4KSB0byB0aGUgc3RydWN0dXJlIGl0c2Vs
ZiBhcyB3ZWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

