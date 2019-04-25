Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E75F217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDYFKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:10:37 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49482 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfDYFKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:10:36 -0400
X-Greylist: delayed 635 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 01:10:35 EDT
Received: by ajax-webmail-mail (Coremail) ; Thu, 25 Apr 2019 12:58:50 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [222.210.139.220]
Date:   Thu, 25 Apr 2019 12:58:50 +0800 (GMT+08:00)
From:   huangpei@loongson.cn
To:     "Paul Burton" <paul.burton@mips.com>
Cc:     "Peter Zijlstra" <peterz@infradead.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Huacai Chen" <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb()
 wreckage
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190424211759.52xraajqwudc2fza@pburton-laptop>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: uVvNfmZvb3Rlcl90eHQ9NDMzNjo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDxpuSKPsFctH7JAA--.11140W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQALAVEBqdXGLQAAsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWkCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gbXkgb3Bpbmlvbi4gcGF0Y2ggMi8zIGlzIGFib3V0IExvb25nc29uJ3MgYnVnLCBhbmQgcGF0
Y2ggNC81IGlzIGFub3RoZXIgdGhlbWUuIA0KDQpMZXQgbWUgZXhwbGFpbiB0aGUgYnVnIG1vcmUg
c3BlY2lmaWM6DQoNCnRoZSBidWcgT05MWSBtYXR0ZXJzIGluIGZvbGxvd2luZyBzaXR1YXRpb246
DQoNCiMuIG1vcmUgdGhhbiBvbmUgY3B1IChhc3N1bWUgY3B1IEEgYW5kIEIpIGRvaW5nIGxsL3Nj
IG9uIHNhbWUgc2hhcmVkIHZhciBWDQoNCiMuIHNwZWN1bGF0aXZlIG1lbW9yeSBhY2Nlc3MgZnJv
bSBBIGNhdXNlIEEgZXJyb25lb3VzbHkgc3VjY2VlZCBzYyBvcGVyYXRpb24sIHNpbmNlIHRoZQ0K
ZXJyb25lb3VzbHkgc3VjY2Vzc2Z1bCBzYyBvcGVyYXRpb24gdmlvbGF0ZSB0aGUgY29oZXJlbmNl
IHByb3RvY29sLiAoaGVyZSBjb2hlcmVuY2UgcHJvdG9jb2wgbWVhbnMgdGhlIHJ1bGVzIHRoYXQg
Q1BVIGZvbGxvdyB0byBpbXBsZW1lbnQgbGwvc2MgcmlnaHQpIA0KDQojLiBCIHN1Y2NlZWQgc2Mg
b3BlcmF0aW9uIHRvbywgYnV0IHRoaXMgc2Mgb3BlcmF0aW9uIGlzIHJpZ2h0IGJvdGggbG9naWNh
bGx5IGFuZCBmb2xsb3cNCnRoZSBjb2hlcmVuY2UgcHJvdG9jb2wsIGFuZCBtYWtlcyBBJ3Mgc2Mg
d3JvbmcgbG9naWNhbGx5IHNpbmNlIG9ubHkgT05FIHNjIG9wZXJhdGlvbg0KY2FuIHN1Y2NlZWQu
DQoNCklmIGl0IGlzIG5vdCBMTC9TQyBidXQgb3RoZXIgbWVtb3J5IGFjY2VzcyBmcm9tIEIgb24g
ViwgQSdzIGxsL3NjIGNhbiBmb2xsb3cgdGhlIGF0b21pYyBzZW1hbnRpY3MgZXZlbiBpZiBBIHZp
b2xhdGUgdGhlIGNvaGVyZW5jZSBwcm90b2NvbCBpbiB0aGUgc2FtZSBzaXR1YXRpb24uDQoNCklu
IG9uZSB3b3Jk77yMIHRoZSBidWcgb25seSBhZmZlY3QgbG9jYWwgY3B14oCYcyBsbC9zYyBvcGVy
YXRpb24sIGFuZCBhZmZlY3QgTVAgc3lzdGVtLg0KDQoNClBTOg0KDQpJZiBsb2NhbF90IGlzIG9u
bHkgbGwvc2MgbWFuaXB1bGF0ZWQgYnkgY3VycmVudCBDUFXvvIwgdGhlbiBubyBuZWVkIGZpeCBp
dC4NCg0KIA0KDQoNCg0KDQo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiAi
UGF1bCBCdXJ0b24iIDxwYXVsLmJ1cnRvbkBtaXBzLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDE5
LTA0LTI1IDA1OjE4OjA0ICjmmJ/mnJ/lm5spDQo+IOaUtuS7tuS6ujogIlBldGVyIFppamxzdHJh
IiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IOaKhOmAgTogInN0ZXJuQHJvd2xhbmQuaGFydmFy
ZC5lZHUiIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PiwgImFraXlrc0BnbWFpbC5jb20iIDxh
a2l5a3NAZ21haWwuY29tPiwgImFuZHJlYS5wYXJyaUBhbWFydWxhc29sdXRpb25zLmNvbSIgPGFu
ZHJlYS5wYXJyaUBhbWFydWxhc29sdXRpb25zLmNvbT4sICJib3F1bi5mZW5nQGdtYWlsLmNvbSIg
PGJvcXVuLmZlbmdAZ21haWwuY29tPiwgImRsdXN0aWdAbnZpZGlhLmNvbSIgPGRsdXN0aWdAbnZp
ZGlhLmNvbT4sICJkaG93ZWxsc0ByZWRoYXQuY29tIiA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4sICJq
LmFsZ2xhdmVAdWNsLmFjLnVrIiA8ai5hbGdsYXZlQHVjbC5hYy51az4sICJsdWMubWFyYW5nZXRA
aW5yaWEuZnIiIDxsdWMubWFyYW5nZXRAaW5yaWEuZnI+LCAibnBpZ2dpbkBnbWFpbC5jb20iIDxu
cGlnZ2luQGdtYWlsLmNvbT4sICJwYXVsbWNrQGxpbnV4LmlibS5jb20iIDxwYXVsbWNrQGxpbnV4
LmlibS5jb20+LCAid2lsbC5kZWFjb25AYXJtLmNvbSIgPHdpbGwuZGVhY29uQGFybS5jb20+LCAi
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+LCAidG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmciIDx0b3J2YWxkc0BsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4sICJIdWFjYWkgQ2hlbiIgPGNoZW5oY0BsZW1vdGUuY29tPiwgIkh1YW5nIFBl
aSIgPGh1YW5ncGVpQGxvb25nc29uLmNuPg0KPiDkuLvpopg6IFJlOiBbUkZDXVtQQVRDSCAyLzVd
IG1pcHMvYXRvbWljOiBGaXggbG9vbmdzb25fbGxzY19tYigpIHdyZWNrYWdlDQo+IA0KPiBIaSBQ
ZXRlciwNCj4gDQo+IE9uIFdlZCwgQXByIDI0LCAyMDE5IGF0IDAyOjM2OjU4UE0gKzAyMDAsIFBl
dGVyIFppamxzdHJhIHdyb3RlOg0KPiA+IFRoZSBjb21tZW50IGRlc2NyaWJpbmcgdGhlIGxvb25n
c29uX2xsc2NfbWIoKSByZW9yZGVyIGNhc2UgZG9lc24ndA0KPiA+IG1ha2UgYW55IHNlbnNlIHdo
YXQgc28gZXZlci4gSW5zdHJ1Y3Rpb24gcmUtb3JkZXJpbmcgaXMgbm90IGFuIFNNUA0KPiA+IGFy
dGlmYWN0LCBidXQgcmF0aGVyIGEgQ1BVIGxvY2FsIHBoZW5vbWVub24uIFRoaXMgbWVhbnMgdGhh
dCBfZXZlcnlfDQo+ID4gTEwvU0MgbG9vcCBuZWVkcyB0aGlzIGJhcnJpZXIgcmlnaHQgaW4gZnJv
bnQgdG8gYXZvaWQgdGhlIENQVSBmcm9tDQo+ID4gbGVha2luZyBhIG1lbW9wIGluc2lkZSBpdC4N
Cj4gDQo+IERvZXMgaXQ/DQo+IA0KPiBUaGUgTG9vbmdzb24gYnVnIGJlaW5nIGRlc2NyaWJlZCBo
ZXJlIGNhdXNlcyBhbiBzYyB0byBzdWNjZWVkDQo+IGVycm9uZW91c2x5IGlmIGNlcnRhaW4gbG9h
ZHMgb3Igc3RvcmVzIGFyZSBleGVjdXRlZCBiZXR3ZWVuIHRoZSBsbCAmDQo+IGFzc29jaWF0ZWQg
c2MsIGluY2x1ZGluZyBzcGVjdWxhdGl2ZWx5LiBPbiBhIFVQIHN5c3RlbSB0aGVyZSdzIG5vIGNv
ZGUNCj4gcnVubmluZyBvbiBvdGhlciBjb3JlcyB0byByYWNlIHdpdGggdXMgJiBjYXVzZSBvdXIg
c2MgdG8gZmFpbCAtIGllLiBzYw0KPiBzaG91bGQgYWx3YXlzIHN1Y2NlZWQgYW55d2F5LCBzbyBp
ZiB0aGUgYnVnIGhpdHMgJiB0aGUgc2Mgc3VjY2VlZHMNCj4gd2hhdCdzIHRoZSBiaWcgZGVhbD8g
SXQgd291bGQgaGF2ZSBzdWNjZWVkZWQgYW55d2F5LiBBdCBsZWFzdCB0aGF0J3MgbXkNCj4gdW5k
ZXJzdGFuZGluZyBiYXNlZCBvbiBkaXNjdXNzaW9ucyB3aXRoIExvb25nc29uIGVuZ2luZWVycyBh
IHdoaWxlIGFnby4NCj4gDQo+IEhhdmluZyBzYWlkIHRoYXQsIGlmIHlvdSBoYXZlIGEgc3Ryb25n
IHByZWZlcmVuY2UgZm9yIGFkZGluZyB0aGUgYmFycmllcg0KPiBpbiBVUCBzeXN0ZW1zIGFueXdh
eSB0aGVuIEkgZG9uJ3QgcmVhbGx5IG9iamVjdC4gSXQncyBub3QgbGlrZSBhbnlvbmUncw0KPiBs
aWtlbHkgdG8gd2FudCB0byBydW4gYSBVUCBrZXJuZWwgb24gdGhlIGFmZmVjdGVkIHN5c3RlbXMs
IG5ldmVybWluZA0KPiBjYXJlIGFib3V0IGEgbWluaXNjdWxlIHBlcmZvcm1hbmNlIGltcGFjdC4N
Cj4gDQo+IE9uZSBwb3NzaWJpbGl0eSB5b3VyIGNoYW5nZSBjb3VsZCBiZW5lZml0IHdvdWxkIGJl
IGlmIHNvbWVvbmUgcmFuIExpbnV4DQo+IG9uIGEgc3Vic2V0IG9mIGNvcmVzICYgc29tZSBub24t
TGludXggY29kZSBvbiBvdGhlciBjb3JlcywgaW4gd2hpY2ggY2FzZQ0KPiB0aGVyZSBjb3VsZCBi
ZSBzb21ldGhpbmcgdG8gY2F1c2UgdGhlIHNjIHRvIGZhaWwuIEkndmUgbm8gaWRlYSBpZiB0aGF0
J3MNCj4gc29tZXRoaW5nIHRoZXNlIExvb25nc29uIHN5c3RlbXMgZXZlciBkbyB0aG91Z2guDQo+
IA0KPiA+IEZvciB0aGUgYnJhbmNoIHNwZWN1bGF0aW9uIGNhc2U7IGlmIGZ1dGV4X2F0b21pY19j
bXB4Y2hnX2luYXRvbWljKCkNCj4gPiBuZWVkcyBvbmUgYXQgdGhlIGJuZSBicmFuY2ggdGFyZ2V0
LCB0aGVuIHN1cmVseSB0aGUgbm9ybWFsDQo+ID4gX19jbXB4Y2hfYXNtZygpIGltcGxlbWVudGF0
aW9uIGRvZXMgdG9vLiBXZSBjYW5ub3QgcmVseSBvbiB0aGUNCj4gDQo+IHMvY21weGNoX2FzbWcv
Y21weGNoZ19hc20vDQo+IA0KPiA+IGJhcnJpZXJzIGZyb20gY21weGNoZygpIGJlY2F1c2UgY21w
eGNoZ19sb2NhbCgpIGlzIGltcGxlbWVudGVkIHdpdGgNCj4gPiB0aGUgc2FtZSBtYWNybywgYW5k
IGJyYW5jaCBwcmVkaWN0aW9uIGFuZCBzcGVjdWxhdGlvbiBhcmUsIHRvbywgQ1BVDQo+ID4gbG9j
YWwuDQo+IA0KPiBTaW1pbGFyIHN0b3J5IC0gY21weGNoZ19sb2NhbCgpIG91Z2h0IG5vdCBoYXZl
IGhhdmUgQ1BVcyByYWNpbmcgZm9yDQo+IGFjY2VzcyB0byB0aGUgbWVtb3J5IGluIHF1ZXN0aW9u
LiBIYXZpbmcgc2FpZCB0aGF0IEkgZG9uJ3Qga25vdyB0aGUNCj4gZGV0YWlscyBvZiB3aGVuIExv
b25nc29uIGNsZWFycyBMTEJpdCAoaWUuIGNhdXNlcyBhbiBzYyB0byBmYWlsKSwgc28gaWYNCj4g
aXQgZG9lcyB0aGF0IG9uIGJhc2VkIHVwb24gYWNjZXNzIHRvIG1lbW9yeSBhdCBhIGxhcmdlciBn
cmFudWxhcml0eSB0aGFuDQo+IHRoZSAzMmIgb3IgNjRiIHZhbHVlIGJlaW5nIG9wZXJhdGVkIG9u
IHRoZW4gdGhhdCBjb3VsZCBiZSBhIHByb2JsZW0gc28NCj4gSSdtIHByZXR0eSBoYXBweSB3aXRo
IGFkZGluZyB0aGVzZSBiYXJyaWVycy4NCj4gDQo+IFRoYW5rcywNCj4gICAgIFBhdWwNCg0KDQrl
jJfkuqzluILmtbfmt4DljLrkuK3lhbPmnZHnjq/kv53np5HmioDnpLrojIPlm63pvpnoiq/kuqfk
uJrlm60y5Y+35qW8IDEwMDA5NeeUteivnTogKzg2ICgxMCkgNjI1NDY2NjjkvKDnnJ86ICs4NiAo
MTApIDYyNjAwODI2d3d3Lmxvb25nc29uLmNu5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z
6Iqv5Lit56eR5oqA5pyv5pyJ6ZmQ5YWs5Y+455qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ
5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB
5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ
5LqO5YWo6YOo5oiW6YOoIOWIhuWcsOazhOmcsuOAgeWkjeWItuaIluaVo+WPke+8ieacrOmCruS7
tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuacrOmCruS7tu+8jOiv
t+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7
tuOAgiANCg0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50
aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24NClRlY2hub2xvZ3kgQ29ycG9yYXRpb24gTGlt
aXRlZCwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkNCndo
b3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBj
b250YWluZWQgaGVyZWluIGluDQphbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0
bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLA0KcmVwcm9kdWN0aW9uIG9yIGRpc3NlbWlu
YXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpDQpp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgYnkNCnBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgaXQuIA==
