Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E5C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A39320870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDHKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:32:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28998 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfDHKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:32:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-50-vftf5hDOO5WPtyOLHhVuGw-1; Mon, 08 Apr 2019 11:32:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Apr 2019 11:33:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Apr 2019 11:33:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
CC:     Rajendra Nayak <rnayak@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] stm class: Fix out of bound access from bitmap allocation
Thread-Topic: [PATCH] stm class: Fix out of bound access from bitmap
 allocation
Thread-Index: AQHU66qDw2WxOhX8lUugt3I8pBQU16YtixUwgASIUaqAAAHoUA==
Date:   Mon, 8 Apr 2019 10:33:51 +0000
Message-ID: <2d5e435bf7b344fb835fc58ac36e1c19@AcuMS.aculab.com>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
 <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
 <dd266f56-b4ea-dc6b-eab1-50e13c820166@codeaurora.org>
 <850ba66b-0e4a-2027-5640-0ee339a7868c@arm.com>
In-Reply-To: <850ba66b-0e4a-2027-5640-0ee339a7868c@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vftf5hDOO5WPtyOLHhVuGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDA4IEFwcmlsIDIwMTkgMTE6MjQNCj4gT24gMDcv
MDQvMjAxOSAwNTozMSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOg0KPiA+IE9uIDQvNS8yMDE5
IDY6NDQgUE0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4gRnJvbTogU2FpIFByYWthc2ggUmFu
amFuDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHd0cmFjaW5nL3N0bS9jb3Jl
LmMgYi9kcml2ZXJzL2h3dHJhY2luZy9zdG0vY29yZS5jDQo+ID4+PiBpbmRleCA5M2NlM2FhNzQw
YTkuLjIxYTU4MzhmNmU2NyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaHd0cmFjaW5nL3N0
bS9jb3JlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5nL3N0bS9jb3JlLmMNCj4gPj4+
IEBAIC0xNjgsNyArMTY4LDcgQEAgc3RhdGljIGludCBzdHBfbWFzdGVyX2FsbG9jKHN0cnVjdCBz
dG1fZGV2aWNlDQo+ID4+PiAqc3RtLCB1bnNpZ25lZCBpbnQgaWR4KQ0KPiA+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3Qgc3RwX21hc3RlciAqbWFzdGVyOw0KPiA+Pj4gwqDCoMKgwqDCoCBzaXplX3Qgc2l6
ZTsNCj4gPj4+DQo+ID4+PiAtwqDCoMKgIHNpemUgPSBBTElHTihzdG0tPmRhdGEtPnN3X25jaGFu
bmVscywgOCkgLyA4Ow0KPiA+Pj4gK8KgwqDCoCBzaXplID0gQUxJR04oc3RtLT5kYXRhLT5zd19u
Y2hhbm5lbHMsIFNUTV9NQVNURVJfU1opIC8NCj4gPj4+IFNUTV9NQVNURVJfU1o7DQo+ID4+DQo+
ID4+IEknbSBub3Qgc3VyZSB0aGF0IHVzaW5nIFNUUF9NQVNURVJfU1ogaW1wcm92ZXMgcmVhZGFi
aWxpdHkgYXQgYWxsLg0KPiA+Pg0KPiA+DQo+ID4gSSB0aG91Z2h0IGl0IHdhcyBiZXR0ZXIgdG8g
aGF2ZSBhIG1hY3JvIHRoYW4gZGlyZWN0bHkgc3BlY2lmeWluZw0KPiA+IHNpemVvZih1bnNpZ25l
ZCBsb25nKSwgYW55d2F5cyBJIGNhbiBjaGFuZ2UgaXQuDQo+ID4NCj4gPj4gSXMgdGhlcmUgc29t
ZXRoaW5nIHRoYXQgZ2l2ZXMgdGhlIHNpemUgb2YgYSBiaXRtYXAgZm9yICduJyBpdGVtcz8NCj4g
Pj4NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIHRoZXJlIGlzIHNvbWV0aGluZy4NCj4gDQo+IElmIHlv
dSB3ZXJlIHRvIGFzayB0aGUgcXVlc3Rpb24gImhvdyBkb2VzIHRoZSBiaXRtYXAgY29kZSBpdHNl
bGYga25vdw0KPiB3aGF0IHRoZSB0b3RhbCBzaXplIG9mIGEgYml0bWFwIGlzPyIsIHRoYXQgd291
bGQgcXVpY2tseSBsZWFkIHlvdQ0KPiB0b3dhcmRzIEJJVFNfVE9fTE9OR1MoKSA7KQ0KPiANCj4g
QW5kIGdpdmVuIHRoYXQgc3RwX21hc3Rlcjo6Y2hhbl9tYXAgaXMgYWxyZWFkeSBhbiBhcHByb3By
aWF0ZSB0eXBlLCB0aGF0DQo+IHN1Z2dlc3RzIHNpbXBsaWZ5aW5nIHRoZSBlbnRpcmUgY2FsY3Vs
YXRpb24gZG93biB0byBzb21ldGhpbmcgbmVhdCBhbmQNCj4gdGlkeSBsaWtlOg0KPiANCj4gc2l6
ZSA9IG9mZnNldG9mKHN0cnVjdCBzdHBfbWFzdGVyLCBjaGFuX21hcFtCSVRTX1RPX0xPTkdTKHN0
bS0+ZGF0YS0+c3dfbmNoYW5uZWxzKV0pOw0KDQpFeGNlcHQgdGhhdCBpcyBpbnZhbGlkLg0KWW91
IGNhbid0IHVzZSBvZmZzZXRvZigpIHdpdGggc29tZXRoaW5nIHRoYXQgaXNuJ3QgYSBjb21waWxl
IHRpbWUgY29uc3RhbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

