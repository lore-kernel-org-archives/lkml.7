Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A38C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768B218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfDYMPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:15:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58565 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:15:05 -0400
Received: by ajax-webmail-mail (Coremail) ; Thu, 25 Apr 2019 20:14:27 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [222.210.139.220]
Date:   Thu, 25 Apr 2019 20:14:27 +0800 (GMT+08:00)
From:   huangpei@loongson.cn
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Paul Burton" <paul.burton@mips.com>,
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
Subject: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb()
 wreckage
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <20190425090907.GB14281@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <20190425090907.GB14281@hirez.programming.kicks-ass.net>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: nRVDSGZvb3Rlcl90eHQ9Mzc3Mjo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2868b58c.c040.16a546b1ea1.Coremail.huangpei@loongson.cn>
X-CM-TRANSID: QMiowPDxpuSjpMFc7r_JAA--.11176W
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/1tbiAQALAVEBqdXJxQABsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlBldGVyIFppamxz
dHJhIiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAxOS0wNC0yNSAx
NzowOTowNyAo5pif5pyf5ZubKQ0KPiDmlLbku7bkuro6IGh1YW5ncGVpQGxvb25nc29uLmNuDQo+
IOaKhOmAgTogIlBhdWwgQnVydG9uIiA8cGF1bC5idXJ0b25AbWlwcy5jb20+LCAic3Rlcm5Acm93
bGFuZC5oYXJ2YXJkLmVkdSIgPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+LCAiYWtpeWtzQGdt
YWlsLmNvbSIgPGFraXlrc0BnbWFpbC5jb20+LCAiYW5kcmVhLnBhcnJpQGFtYXJ1bGFzb2x1dGlv
bnMuY29tIiA8YW5kcmVhLnBhcnJpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPiwgImJvcXVuLmZlbmdA
Z21haWwuY29tIiA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+LCAiZGx1c3RpZ0BudmlkaWEuY29tIiA8
ZGx1c3RpZ0BudmlkaWEuY29tPiwgImRob3dlbGxzQHJlZGhhdC5jb20iIDxkaG93ZWxsc0ByZWRo
YXQuY29tPiwgImouYWxnbGF2ZUB1Y2wuYWMudWsiIDxqLmFsZ2xhdmVAdWNsLmFjLnVrPiwgImx1
Yy5tYXJhbmdldEBpbnJpYS5mciIgPGx1Yy5tYXJhbmdldEBpbnJpYS5mcj4sICJucGlnZ2luQGdt
YWlsLmNvbSIgPG5waWdnaW5AZ21haWwuY29tPiwgInBhdWxtY2tAbGludXguaWJtLmNvbSIgPHBh
dWxtY2tAbGludXguaWJtLmNvbT4sICJ3aWxsLmRlYWNvbkBhcm0uY29tIiA8d2lsbC5kZWFjb25A
YXJtLmNvbT4sICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz4sICJ0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZyIgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiwgIkh1YWNhaSBDaGVuIiA8Y2hlbmhjQGxlbW90ZS5jb20+
DQo+IOS4u+mimDogUmU6IFJlOiBbUkZDXVtQQVRDSCAyLzVdIG1pcHMvYXRvbWljOiBGaXggbG9v
bmdzb25fbGxzY19tYigpIHdyZWNrYWdlDQo+IA0KPiBPbiBUaHUsIEFwciAyNSwgMjAxOSBhdCAw
OTozMzo0OEFNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gDQo+ID4gPiBMZXQgbWUg
ZXhwbGFpbiB0aGUgYnVnIG1vcmUgc3BlY2lmaWM6DQo+ID4gPiANCj4gPiA+IHRoZSBidWcgT05M
WSBtYXR0ZXJzIGluIGZvbGxvd2luZyBzaXR1YXRpb246DQo+ID4gPiANCj4gPiA+ICMuIG1vcmUg
dGhhbiBvbmUgY3B1IChhc3N1bWUgY3B1IEEgYW5kIEIpIGRvaW5nIGxsL3NjIG9uIHNhbWUgc2hh
cmVkDQo+ID4gPiB2YXIgVg0KPiA+ID4gDQo+ID4gPiAjLiBzcGVjdWxhdGl2ZSBtZW1vcnkgYWNj
ZXNzIGZyb20gQSBjYXVzZSBBIGVycm9uZW91c2x5IHN1Y2NlZWQgc2MNCj4gPiA+IG9wZXJhdGlv
biwgc2luY2UgdGhlIGVycm9uZW91c2x5IHN1Y2Nlc3NmdWwgc2Mgb3BlcmF0aW9uIHZpb2xhdGUg
dGhlDQo+ID4gPiBjb2hlcmVuY2UgcHJvdG9jb2wuIChoZXJlIGNvaGVyZW5jZSBwcm90b2NvbCBt
ZWFucyB0aGUgcnVsZXMgdGhhdCBDUFUNCj4gPiA+IGZvbGxvdyB0byBpbXBsZW1lbnQgbGwvc2Mg
cmlnaHQpDQo+ID4gPiANCj4gPiA+ICMuIEIgc3VjY2VlZCBzYyBvcGVyYXRpb24gdG9vLCBidXQg
dGhpcyBzYyBvcGVyYXRpb24gaXMgcmlnaHQgYm90aA0KPiA+ID4gbG9naWNhbGx5IGFuZCBmb2xs
b3cgdGhlIGNvaGVyZW5jZSBwcm90b2NvbCwgYW5kIG1ha2VzIEEncyBzYyB3cm9uZw0KPiA+ID4g
bG9naWNhbGx5IHNpbmNlIG9ubHkgT05FIHNjIG9wZXJhdGlvbiBjYW4gc3VjY2VlZC4NCj4gPiAN
Cj4gPiAoSSBrbm93IHlvdXIgY29oZXJlbmNlIHByb3RvY29sIGlzIHByb2JhYmx5IG1vcmUgY29t
cGxpY2F0ZWQgdGhhbiBNRVNJLA0KPiA+IGJ1dCBiZWFyIHdpdGggbWUpDQo+ID4gDQo+ID4gU28g
QSBzcGVjdWxhdGl2ZWx5IGdldHMgVidzIGxpbmUgaW4gRXhjbHVzaXZlIG1vZGUsIHNwZWN1bGF0
ZXMgdGhlIExvY2sNCj4gPiBmbGFnIGlzIHN0aWxsIHRoZXJlIGFuZCBjb21wbGV0ZXMgdGhlIFN0
b3JlLiBUaGlzIHNwZWN1bGF0aXZlIHN0b3JlIHRoZW4NCj4gPiBsZWFrcyBvdXQgYW5kIHZpb2xh
dGVzIE1FU0kgYmVjYXVzZSB0aGVyZSBfc2hvdWxkXyBvbmx5IGJlIG9uZSBFeGNsdXNpdmUNCj4g
PiBvd25lciBvZiBhIGxpbmUgKEIpLg0KPiA+IA0KPiA+IFNvbWV0aGluZyBsaWtlIHRoYXQ/DQo+
IA0KPiBTbyBCIGdldHMgRSAoZnJvbSBMTCksIGRvZXMgSSBvbiBBLCB0aGVuIFNDIHN1Y2NlZWRz
IGFuZCBnZXQgTS4gIEEgZ290DQo+IEksIHNwZWN1bGF0ZXMgRSwgc3BlY3VsYXRlcyBNIGFuZCBs
ZXRzIHRoZSBNIGVzY2FwZS4NCj4gDQo+IFRoYXQgZ2V0cyB1cyB3aXRoIDIgY29tcGV0aW5nIE1z
ICh3aGljaCBpcyBvZiBjb3Vyc2UgY29tcGxldGVseQ0KPiBpbnNhbmUpLCBvbmUgd2lucyBvbmUg
bG9vc2VzIChhdCByYW5kb20gSSBwcmVzdW1lKS4NCj4gDQo+IEFuZCB0aGlzIHZpb2xhdGVzIGF0
b21pYyBndWFyYW50ZWVzIGJlY2F1c2Ugb25lIG9wZXJhdGlvbiBnb3QgbG9zdC4NCg0KDQpCYXNl
ZCBvbiB3aGF0IEkgd2FzIHRvbGQ6IA0KDQojLiBBIGdldCBFIGZyb20gTEwsIHByZXZpb3VzIHNw
ZWN1bGF0aXZlIGFjY2VzcyBmcm9tIEEgDQpraWNrIFYgb3V0LCBzbyBBIHNob3VsZCBnZXQgSSwg
YnV0IEEgc3RpbGwgdGhvdWdodCBBIGdldCBFIDsNCg0KIy4gYW5kIEIgZ2V0IEUgZnJvbSBMTCxz
byBCIGdldCBzYyBkb25lIHJpZ2h0OyBWIGdldCBzYyBhdG9taWNhbGx5IGJ5IEI7DQoNCiMuIEEg
c3RpbGwgdGhvdWdodCBpdCBnZXQgRSwgc28gQSBnZXQgc2MgZG9uZSwgViBnZXQgc2MgYnkgQSwg
YnV0IG5vdCBhdG9taWNhbGx5Lg0KDQoNCiANCj4gDQo+ID4gPiBJZiBpdCBpcyBub3QgTEwvU0Mg
YnV0IG90aGVyIG1lbW9yeSBhY2Nlc3MgZnJvbSBCIG9uIFYsIEEncyBsbC9zYyBjYW4NCj4gPiA+
IGZvbGxvdyB0aGUgYXRvbWljIHNlbWFudGljcyBldmVuIGlmIEEgdmlvbGF0ZSB0aGUgY29oZXJl
bmNlIHByb3RvY29sDQo+ID4gPiBpbiB0aGUgc2FtZSBzaXR1YXRpb24uDQo+ID4gDQo+ID4gKnNo
dWRkZXIqLi4uDQo+ID4gDQo+ID4gICBDIGF0b21pYy1zZXQNCj4gPiANCj4gPiAgIHsNCj4gPiAJ
ICBhdG9taWNfc2V0KHYsIDEpOw0KPiA+ICAgfQ0KPiA+IA0KPiA+ICAgUDEoYXRvbWljX3QgKnYp
DQo+ID4gICB7DQo+ID4gCSAgYXRvbWljX2FkZF91bmxlc3ModiwgMSwgMCk7DQo+ID4gICB9DQo+
ID4gDQo+ID4gICBQMihhdG9taWNfdCAqdikNCj4gPiAgIHsNCj4gPiAJICBhdG9taWNfc2V0KHYs
IDApOw0KPiA+ICAgfQ0KPiA+IA0KPiA+ICAgZXhpc3RzDQo+ID4gICAodj0yKQ0KPiA+IA0KPiA+
IFNvIHRoYXQgb25lIHdpbGwgc3RpbGwgd29yaz8gKHRoYXQgaXMsIHY9MiBpcyBmb3JiaWRkZW4p
DQo+IA0KPiBCdXQgdGhlbiBpbiB0aGlzIGNhc2UsIFAxIGhhcyBFIGZyb20gTEwsIFAyIGRvZXMg
TSBmcm9tIHRoZSBTVE9SRSwgd2hpY2gNCj4gc2hvdWxkIGNhdXNlIEkgb24gUDEuIFAxIHNwZWN1
bGF0ZXMgRSwgc3BlY3VsYXRlcyBNIGFuZCBsZXRzIE0gZXNjYXBlLg0KPiANCj4gV2UgYWdhaW4g
aGF2ZSB0d28gY29tcGV0aW5nIE1zLCBvbmUgd2lucyBhdCByYW5kb20sIGFuZCB2PT0yIGlmIFAx
DQo+IHdpbnMuIFRoaXMgYWdhaW4gdmlvbGF0ZXMgdGhlIGF0b21pYyBndWFyYW50ZWVzIGFuZCB3
b3VsZCBpbnZhbGlkYXRlDQo+IHlvdXIgY2xhaW0gb2YgaXQgb25seSBtYXR0ZXJpbmcgZm9yIGNv
bXBldGluZyBMTC9TQy4NCj4gDQo+IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/IChxdWl0ZSBs
aWtlbHksIEkgYWx3YXlzIGdldCBjb25mdXNlZCB3aXRoDQo+IHRoZXNlIHRoaW5ncykNCg0KDQrl
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
