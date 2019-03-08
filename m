Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A43C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8320643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHCDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:03:54 -0500
Received: from mx23.baidu.com ([61.135.165.120]:46999 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfCHCDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:03:53 -0500
Received: from M1-MAIL-EX11.internal.baidu.com (unknown [10.44.89.51])
        by Forcepoint Email with ESMTPS id D55D0FDE19C13;
        Fri,  8 Mar 2019 10:03:42 +0800 (CST)
Received: from BC-Mail-Ex14.internal.baidu.com (172.31.40.50) by
 M1-MAIL-EX11.internal.baidu.com (10.44.89.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 8 Mar 2019 10:03:44 +0800
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 BC-Mail-Ex14.internal.baidu.com (172.31.40.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 8 Mar 2019 10:03:43 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Fri, 8 Mar 2019 10:03:43 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBpcGM6IHByZXZlbnQgbG9ja3VwIG9uIGFsbG9jX21z?=
 =?gb2312?Q?g_and_free=5Fmsg?=
Thread-Topic: [PATCH] ipc: prevent lockup on alloc_msg and free_msg
Thread-Index: AQHU1RED+JJ/26G40kaCEpraSHsZDaYA+3zQ
Date:   Fri, 8 Mar 2019 02:03:43 +0000
Message-ID: <f04f089a3312471bb795e8d9e1254a26@baidu.com>
References: <1551946222-25470-1-git-send-email-lirongqing@baidu.com>
 <20190307101010.919d18394ae43ecf9d2a2212@linux-foundation.org>
In-Reply-To: <20190307101010.919d18394ae43ecf9d2a2212@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.148.75]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogbGludXgta2VybmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5v
cmddILT6se0gQW5kcmV3IE1vcnRvbg0KPiC3osvNyrG85DogMjAxOcTqM9TCOMjVIDI6MTANCj4g
ytW8/sjLOiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ILOty806IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkbG9ociBCdWVzbyA8ZGJ1ZXNvQHN1c2UuZGU+
Ow0KPiBEb21pbmlrIEJyb2Rvd3NraSA8bGludXhAZG9taW5pa2Jyb2Rvd3NraS5uZXQ+OyBNYW5m
cmVkIFNwcmF1bA0KPiA8bWFuZnJlZEBjb2xvcmZ1bGxpZmUuY29tPjsgQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4g1vfM4jogUmU6IFtQQVRDSF0gaXBjOiBwcmV2ZW50IGxvY2t1cCBv
biBhbGxvY19tc2cgYW5kIGZyZWVfbXNnDQo+IA0KPiBPbiBUaHUsICA3IE1hciAyMDE5IDE2OjEw
OjIyICswODAwIExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gd3JvdGU6DQo+
IA0KPiA+IEZyb206IExpIFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+
IG1zZ2N0bDEwIG9mIGx0cCB0cmlnZ2VycyB0aGUgZm9sbG93aW5nIGxvY2t1cCBXaGVuIENPTkZJ
R19LQVNBTiBpcw0KPiA+IGVuYWJsZWQgb24gbGFyZ2UgbWVtb3J5IFNNUCBzeXN0ZW1zLCB0aGUg
cGFnZXMgaW5pdGlhbGl6YXRpb24gY2FuIHRha2UNCj4gPiBhIGxvbmcgdGltZSwgaWYgbXNnY3Rs
MTAgcmVxdWVzdHMgYSBodWdlIGJsb2NrIG1lbW9yeSwgYW5kIGl0IHdpbGwNCj4gPiBibG9jayBy
Y3Ugc2NoZWR1bGVyLCBzbyByZWxlYXNlIGNwdSBhY3RpdmVseS4NCj4gPg0KPiA+IC4uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgWXUgPHpoYW5neXUzMUBiYWlkdS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiANCj4g
VGhpcyBzaWdub2ZmIG9yZGVyaW5nIHNvbWV3aGF0IGltcGxpZXMgdGhhdCBaaGFuZyBZdSB3YXMg
dGhlIGF1dGhvci4NCj4gQnV0IHlvdSBhZGRlZCAiRnJvbTogTGkgUm9uZ3FpbmciLCBzbyB5b3Ug
d2lsbCBiZSByZWNvcmRlZCBhcyB0aGUgcGF0Y2gncw0KPiBhdXRob3IuICBJcyB0aGlzIGNvcnJl
Y3Q/DQo+IA0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkkgd2lsbCByZXZlcnQgdGhpcyBvcmRl
cg0KDQo+ID4gLS0tIGEvaXBjL21zZ3V0aWwuYw0KPiA+ICsrKyBiL2lwYy9tc2d1dGlsLmMNCj4g
PiBAQCAtMTgsNiArMTgsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvdXRzbmFtZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvcHJvY19ucy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vz
cy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAi
dXRpbC5oIg0KPiA+DQo+ID4gQEAgLTcyLDYgKzczLDcgQEAgc3RhdGljIHN0cnVjdCBtc2dfbXNn
ICphbGxvY19tc2coc2l6ZV90IGxlbikNCj4gPiAgCQlzZWctPm5leHQgPSBOVUxMOw0KPiA+ICAJ
CXBzZWcgPSAmc2VnLT5uZXh0Ow0KPiA+ICAJCWxlbiAtPSBhbGVuOw0KPiA+ICsJCWNvbmRfcmVz
Y2hlZCgpOw0KPiA+ICAJfQ0KPiANCj4gVGhpcyBsb29rcyBPSy4NCj4gDQo+ID4gIAlyZXR1cm4g
bXNnOw0KPiA+IEBAIC0xNzgsNSArMTgwLDYgQEAgdm9pZCBmcmVlX21zZyhzdHJ1Y3QgbXNnX21z
ZyAqbXNnKQ0KPiA+ICAJCXN0cnVjdCBtc2dfbXNnc2VnICp0bXAgPSBzZWctPm5leHQ7DQo+ID4g
IAkJa2ZyZWUoc2VnKTsNCj4gPiAgCQlzZWcgPSB0bXA7DQo+ID4gKwkJY29uZF9yZXNjaGVkKCk7
DQo+ID4gIAl9DQo+IA0KPiBUaGlzIGRvZXMgbm90LiAgbXF1ZXVlX2V2aWN0X2lub2RlKCkgKGF0
IGxlYXN0KSBjYWxscyBmcmVlX21zZygpIGZyb20gdW5kZXINCj4gc3Bpbl9sb2NrKCkuDQoNCg0K
SSB3aWxsIHRyeSB0byBmaXggaXQgYnkgbW92aW5nIHRoZSBmcmVlX21zZygpIG91dCBvZiBzcGlu
bG9jayAsIHRoYW5rcw0KDQotUm9uZ1FpbmcNCg0K
