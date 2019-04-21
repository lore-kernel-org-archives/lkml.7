Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F46C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192FD2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfDUIZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:25:55 -0400
Received: from mail-oln040092064083.outbound.protection.outlook.com ([40.92.64.83]:53121
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfDUIZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:25:55 -0400
Received: from HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (10.152.0.55) by HE1EUR01HT105.eop-EUR01.prod.protection.outlook.com
 (10.152.0.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Sun, 21 Apr
 2019 08:25:50 +0000
Received: from VE1PR03MB5903.eurprd03.prod.outlook.com (10.152.0.57) by
 HE1EUR01FT044.mail.protection.outlook.com (10.152.0.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Sun, 21 Apr 2019 08:25:50 +0000
Received: from VE1PR03MB5903.eurprd03.prod.outlook.com
 ([fe80::f8db:e92b:9081:b6d6]) by VE1PR03MB5903.eurprd03.prod.outlook.com
 ([fe80::f8db:e92b:9081:b6d6%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 08:25:50 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] drm/bridge: dw-hdmi: fix SCDC configuration for ddc-i2c-bus
Thread-Topic: [PATCH] drm/bridge: dw-hdmi: fix SCDC configuration for
 ddc-i2c-bus
Thread-Index: AQHU+BvUv7RBPzRYLEqP671+fqzvcg==
Date:   Sun, 21 Apr 2019 08:25:50 +0000
Message-ID: <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::43) To VE1PR03MB5903.eurprd03.prod.outlook.com
 (2603:10a6:803:115::21)
x-incomingtopheadermarker: OriginalChecksum:DE07A34B12E7626245208ABA893DC1CDAF7F553C3FBB3A98DC82BBCA4013886C;UpperCasedChecksum:4E87828E1BCDFCED8AD990EA84BCB43BCFE32955E553E5F99E7B0EB88A721269;SizeAsReceived:7764;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [V76zmSnQ1KD93ONEwd024QZrvmQNcSrH]
x-microsoft-original-message-id: <20190421082533.1220-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:HE1EUR01HT105;
x-ms-traffictypediagnostic: HE1EUR01HT105:
x-microsoft-antispam-message-info: cEgLOcxeFGNr1+op+/cPIOx+Ul8LlywXv+9rmVTgdesc39ZhftV8CThjg4EPzSdMGemWGPc8/TeByBRqxliyCtJ3ZlEKTgzyh6hBxbmLYnboNuDU/6EGL/7CGcNk/eKztaOWfrgYVM8lU/FNy66Dy7BlarDemgcXXpRMJZ+pBZ8GncW2wARMMEOE4TfQbtA6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 65278a36-f667-4cc1-fb59-08d6c632f635
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 08:25:50.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBkZGMtaTJjLWJ1cyBwcm9wZXJ0eSBpcyB1c2VkLCBhIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBpcyByZXBvcnRlZDoNCg0KWyAgIDMxLjA0MTY2OV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwOA0K
WyAgIDMxLjA0MTY3MV0gcGdkID0gNGQzYzE2ZjYNClsgICAzMS4wNDE2NzNdIFswMDAwMDAwOF0g
KnBnZD0wMDAwMDAwMA0KWyAgIDMxLjA0MTY3OF0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDUgWyMx
XSBTTVAgQVJNDQoNClsgICAzMS4wNDE3MTFdIEhhcmR3YXJlIG5hbWU6IFJvY2tjaGlwIChEZXZp
Y2UgVHJlZSkNClsgICAzMS4wNDE3MThdIFBDIGlzIGF0IGkyY190cmFuc2ZlcisweDgvMHhlNA0K
WyAgIDMxLjA0MTcyMV0gTFIgaXMgYXQgZHJtX3NjZGNfcmVhZCsweDU0LzB4ODQNClsgICAzMS4w
NDE3MjNdIHBjIDogWzxjMDczMjczYz5dICAgIGxyIDogWzxjMDU5MjZjND5dICAgIHBzcjogMjgw
ZjAwMTMNClsgICAzMS4wNDE3MjVdIHNwIDogZWRmZmRhZDAgIGlwIDogNWNjYjU1MTEgIGZwIDog
MDAwMDAwNTgNClsgICAzMS4wNDE3MjddIHIxMDogMDAwMDA3ODAgIHI5IDogZWRmOTE2MDggIHI4
IDogYzExYjBmNDgNClsgICAzMS4wNDE3MjhdIHI3IDogMDAwMDA0MzggIHI2IDogMDAwMDAwMDAg
IHI1IDogMDAwMDAwMDAgIHI0IDogMDAwMDAwMDANClsgICAzMS4wNDE3MzBdIHIzIDogZWRmZmRh
ZTcgIHIyIDogMDAwMDAwMDIgIHIxIDogZWRmZmRhZWMgIHIwIDogMDAwMDAwMDANCg0KWyAgIDMx
LjA0MTkwOF0gWzxjMDczMjczYz5dIChpMmNfdHJhbnNmZXIpIGZyb20gWzxjMDU5MjZjND5dIChk
cm1fc2NkY19yZWFkKzB4NTQvMHg4NCkNClsgICAzMS4wNDE5MTNdIFs8YzA1OTI2YzQ+XSAoZHJt
X3NjZGNfcmVhZCkgZnJvbSBbPGMwNTkyODU4Pl0gKGRybV9zY2RjX3NldF9zY3JhbWJsaW5nKzB4
MzAvMHhiYykNClsgICAzMS4wNDE5MTldIFs8YzA1OTI4NTg+XSAoZHJtX3NjZGNfc2V0X3NjcmFt
YmxpbmcpIGZyb20gWzxjMDVjYzBmND5dIChkd19oZG1pX3VwZGF0ZV9wb3dlcisweDE0NDAvMHgx
NjEwKQ0KWyAgIDMxLjA0MTkyNl0gWzxjMDVjYzBmND5dIChkd19oZG1pX3VwZGF0ZV9wb3dlcikg
ZnJvbSBbPGMwNWNjNTc0Pl0gKGR3X2hkbWlfYnJpZGdlX2VuYWJsZSsweDJjLzB4NzApDQpbICAg
MzEuMDQxOTMyXSBbPGMwNWNjNTc0Pl0gKGR3X2hkbWlfYnJpZGdlX2VuYWJsZSkgZnJvbSBbPGMw
NWFlZDQ4Pl0gKGRybV9icmlkZ2VfZW5hYmxlKzB4MjQvMHgzNCkNClsgICAzMS4wNDE5MzhdIFs8
YzA1YWVkNDg+XSAoZHJtX2JyaWRnZV9lbmFibGUpIGZyb20gWzxjMDU5MTA2MD5dIChkcm1fYXRv
bWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFibGVzKzB4MTE0LzB4MjIwKQ0KWyAgIDMxLjA0
MTk0M10gWzxjMDU5MTA2MD5dIChkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFi
bGVzKSBmcm9tIFs8YzA1YzNmZTA+XSAocm9ja2NoaXBfYXRvbWljX2hlbHBlcl9jb21taXRfdGFp
bF9ycG0rMHgyOC8weDY0KQ0KDQpoZG1pLT5pMmMgbWF5IG5vdCBiZSBzZXQgd2hlbiBkZGMtaTJj
LWJ1cyBwcm9wZXJ0eSBpcyB1c2VkIGluIGRldmljZSB0cmVlLg0KRml4IHRoaXMgYnkgdXNpbmcg
aGRtaS0+ZGRjIGFzIHRoZSBpMmMgYWRhcHRlciB3aGVuIGNhbGxpbmcgZHJtX3NjZGNfKigpLg0K
QWxzbyByZXBvcnQgdGhhdCBTQ0RDIGlzIG5vdCBzdXBwb3J0ZWQgd2hlbiB0aGVyZSBpcyBubyBE
REMgYnVzLg0KDQpGaXhlczogMjY0ZmNlNmNjMmMxICgiZHJtL2JyaWRnZTogZHctaGRtaTogQWRk
IFNDREMgYW5kIFRNRFMgU2NyYW1ibGluZyBzdXBwb3J0IikNClNpZ25lZC1vZmYtYnk6IEpvbmFz
IEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uv
c3lub3BzeXMvZHctaGRtaS5jIHwgMTIgKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctaGRtaS5jIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9z
eW5vcHN5cy9kdy1oZG1pLmMNCmluZGV4IDdhNDdjNjVkOGVjYi4uZmQxYzMxOWE0ZWUwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1oZG1pLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctaGRtaS5jDQpAQCAtMTA0Niw2ICsx
MDQ2LDEwIEBAIHN0YXRpYyBib29sIGR3X2hkbWlfc3VwcG9ydF9zY2RjKHN0cnVjdCBkd19oZG1p
ICpoZG1pKQ0KIAlpZiAoaGRtaS0+dmVyc2lvbiA8IDB4MjAwYSkNCiAJCXJldHVybiBmYWxzZTsN
CiANCisJLyogRGlzYWJsZSBpZiBubyBEREMgYnVzICovDQorCWlmICghaGRtaS0+ZGRjKQ0KKwkJ
cmV0dXJuIGZhbHNlOw0KKw0KIAkvKiBEaXNhYmxlIGlmIFNDREMgaXMgbm90IHN1cHBvcnRlZCwg
b3IgaWYgYW4gSEYtVlNEQiBibG9jayBpcyBhYnNlbnQgKi8NCiAJaWYgKCFkaXNwbGF5LT5oZG1p
LnNjZGMuc3VwcG9ydGVkIHx8DQogCSAgICAhZGlzcGxheS0+aGRtaS5zY2RjLnNjcmFtYmxpbmcu
c3VwcG9ydGVkKQ0KQEAgLTE2ODMsMTMgKzE2ODcsMTMgQEAgc3RhdGljIHZvaWQgaGRtaV9hdl9j
b21wb3NlcihzdHJ1Y3QgZHdfaGRtaSAqaGRtaSwNCiAJCQkgKiBTb3VyY2UgRGV2aWNlcyBjb21w
bGlhbnQgc2hhbGwgc2V0IHRoZQ0KIAkJCSAqIFNvdXJjZSBWZXJzaW9uID0gMS4NCiAJCQkgKi8N
Ci0JCQlkcm1fc2NkY19yZWFkYigmaGRtaS0+aTJjLT5hZGFwLCBTQ0RDX1NJTktfVkVSU0lPTiwN
CisJCQlkcm1fc2NkY19yZWFkYihoZG1pLT5kZGMsIFNDRENfU0lOS19WRVJTSU9OLA0KIAkJCQkg
ICAgICAgJmJ5dGVzKTsNCi0JCQlkcm1fc2NkY193cml0ZWIoJmhkbWktPmkyYy0+YWRhcCwgU0NE
Q19TT1VSQ0VfVkVSU0lPTiwNCisJCQlkcm1fc2NkY193cml0ZWIoaGRtaS0+ZGRjLCBTQ0RDX1NP
VVJDRV9WRVJTSU9OLA0KIAkJCQltaW5fdCh1OCwgYnl0ZXMsIFNDRENfTUlOX1NPVVJDRV9WRVJT
SU9OKSk7DQogDQogCQkJLyogRW5hYmxlZCBTY3JhbWJsaW5nIGluIHRoZSBTaW5rICovDQotCQkJ
ZHJtX3NjZGNfc2V0X3NjcmFtYmxpbmcoJmhkbWktPmkyYy0+YWRhcCwgMSk7DQorCQkJZHJtX3Nj
ZGNfc2V0X3NjcmFtYmxpbmcoaGRtaS0+ZGRjLCAxKTsNCiANCiAJCQkvKg0KIAkJCSAqIFRvIGFj
dGl2YXRlIHRoZSBzY3JhbWJsZXIgZmVhdHVyZSwgeW91IG11c3QgZW5zdXJlDQpAQCAtMTcwNSw3
ICsxNzA5LDcgQEAgc3RhdGljIHZvaWQgaGRtaV9hdl9jb21wb3NlcihzdHJ1Y3QgZHdfaGRtaSAq
aGRtaSwNCiAJCQloZG1pX3dyaXRlYihoZG1pLCAwLCBIRE1JX0ZDX1NDUkFNQkxFUl9DVFJMKTsN
CiAJCQloZG1pX3dyaXRlYihoZG1pLCAodTgpfkhETUlfTUNfU1dSU1RaX1RNRFNTV1JTVF9SRVEs
DQogCQkJCSAgICBIRE1JX01DX1NXUlNUWik7DQotCQkJZHJtX3NjZGNfc2V0X3NjcmFtYmxpbmco
JmhkbWktPmkyYy0+YWRhcCwgMCk7DQorCQkJZHJtX3NjZGNfc2V0X3NjcmFtYmxpbmcoaGRtaS0+
ZGRjLCAwKTsNCiAJCX0NCiAJfQ0KIA0KLS0gDQoyLjE3LjENCg0K
