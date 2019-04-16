Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85849C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aIZ7zX0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDPDWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:22:32 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:10921
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDPDWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=510j1AbXBqLs5c6+KYCcTvdMaCgrIcbV/GU6fvQxwjo=;
 b=aIZ7zX0qEPZl6pCL+v4o6mMK035Dfs3+uLp+6/C63RTLxJxsSXDBTERqFMFNmlJgR5sikKBpu3vMkU54yemPfUWbY4KU5Z+h7g7Z0B960npB7NCaRmdOTEexZypqbT+1AuFker5sKWtCOeD+XCdAFTRkbjtRIITPPph9xsQ6DPE=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:22:25 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:22:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHU9AOc8iXKmYQeMUm4+FbUnbYclA==
Date:   Tue, 16 Apr 2019 03:22:25 +0000
Message-ID: <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3adab16f-1c94-42b7-e8e1-08d6c21abf2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB3895C964EA58E9B049F5FEE0F5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6512007)(106356001)(105586002)(53936002)(2501003)(36756003)(6116002)(3846002)(66066001)(68736007)(486006)(110136005)(316002)(5660300002)(11346002)(446003)(476003)(2616005)(97736004)(71190400001)(71200400001)(81166006)(99286004)(8936002)(81156014)(8676002)(50226002)(52116002)(102836004)(256004)(14454004)(478600001)(6506007)(386003)(26005)(7736002)(4326008)(76176011)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(6486002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hQehXe3LHrDIgZ5CNShQgP13uDVCMjcqVgBzIl969dZW5spFzy7KHgYVELrYdxlrjUZfRimbgwRxLfXO7sGzCUYwV7IgYfcggv1zcEFRND4gLpBLO2rRhnEnKlSt8D/ZjflBzupnEDhwa4ARNNoVXZG1aGzT0i3ZBs+lJngzneX3ODLVzFjS0E/aOBvikpFKcH7P4TxQSMgXtGCAIjmFjN2uOUSBeD6DjdgqWIW207RzQ9VKf8Bvcn25tVhcxHJ7uLLAT0V8baB3PGA94e1mALmOhfHg5nlECrwtMjZ+JpC1kLE8BzF9puAy7Ye6i6EN3iYVoS2pp5g33BOSoUQCtuXHDvGQ8cKgA/aabd1DhCB0OTKsFp5Yl6tc7RcemnrYOHoNlx+conPsH/M04AXya9u1Mazjx2Pj0+VwB+U1tbI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adab16f-1c94-42b7-e8e1-08d6c21abf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:22:25.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdoaWNoIGhhcyBhIENvcnRleC1NNCBzeXN0ZW0gY29u
dHJvbGxlcg0KaW5zaWRlLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIGNv
bnRyb2xsaW5nIHBvd2VyLA0KY2xvY2sgYW5kIHRoZXJtYWwgc2Vuc29ycyBldGMuLg0KDQpUaGlz
IHBhdGNoIGFkZHMgaS5NWCBzeXN0ZW0gY29udHJvbGxlciB0aGVybWFsIGRyaXZlciBzdXBwb3J0
LA0KTGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZSB3aXRoIHN5c3RlbSBjb250cm9sbGVy
IHZpYSBNVQ0KKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCBlYWNoIHRoZXJtYWwgc2Vuc29yJ3Mg
dGVtcGVyYXR1cmUsDQppdCBzdXBwb3J0cyBtdWx0aXBsZSBzZW5zb3JzIHdoaWNoIGFyZSBwYXNz
ZWQgZnJvbSBkZXZpY2UgdHJlZSwNCnBsZWFzZSBzZWUgdGhlIGJpbmRpbmcgZG9jIGZvciBkZXRh
aWxzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Ci0tLQ0KQ2hhbmdlcyBzaW5jZSBWMTE6DQoJLSBtb3ZlIHRoZSBBUEkgb2YgZ2V0dGluZyB0aGVy
bWFsIHpvbmUgc2Vuc29yIElEIHRvIG9mLXRoZXJtYWwuYyBhcyBnZW5lcmljIEFQSTsNCgktIHJl
bW92ZSB1bm5lY2Vzc2FyeSBfX3BhY2tlZC4NCi0tLQ0KIGRyaXZlcnMvdGhlcm1hbC9LY29uZmln
ICAgICAgICAgIHwgIDExICsrKysNCiBkcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgICAgICAgICB8
ICAgMSArDQogZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMgfCAxMzcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxNDkgaW5z
ZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RoZXJtYWwvaW14X3NjX3Ro
ZXJtYWwuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL0tjb25maWcgYi9kcml2ZXJz
L3RoZXJtYWwvS2NvbmZpZw0KaW5kZXggNjUzYWEyNy4uNGU0ZmE3ZSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdGhlcm1hbC9LY29uZmlnDQorKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KQEAg
LTIyMyw2ICsyMjMsMTcgQEAgY29uZmlnIElNWF9USEVSTUFMDQogCSAgY3B1ZnJlcSBpcyB1c2Vk
IGFzIHRoZSBjb29saW5nIGRldmljZSB0byB0aHJvdHRsZSBDUFVzIHdoZW4gdGhlDQogCSAgcGFz
c2l2ZSB0cmlwIGlzIGNyb3NzZWQuDQogDQorY29uZmlnIElNWF9TQ19USEVSTUFMDQorCXRyaXN0
YXRlICJUZW1wZXJhdHVyZSBzZW5zb3IgZHJpdmVyIGZvciBOWFAgaS5NWCBTb0NzIHdpdGggU3lz
dGVtIENvbnRyb2xsZXIiDQorCWRlcGVuZHMgb24gKEFSQ0hfTVhDICYmIElNWF9TQ1UpIHx8IENP
TVBJTEVfVEVTVA0KKwlkZXBlbmRzIG9uIE9GDQorCWhlbHANCisJICBTdXBwb3J0IGZvciBUZW1w
ZXJhdHVyZSBNb25pdG9yIChURU1QTU9OKSBmb3VuZCBvbiBOWFAgaS5NWCBTb0NzIHdpdGgNCisJ
ICBzeXN0ZW0gY29udHJvbGxlciBpbnNpZGUsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNh
dGUgd2l0aCBzeXN0ZW0NCisJICBjb250cm9sbGVyIHZpYSBNVSAobWVzc2FnZSB1bml0KSBJUEMg
dG8gZ2V0IHRlbXBlcmF0dXJlIGZyb20gdGhlcm1hbA0KKwkgIHNlbnNvci4gSXQgc3VwcG9ydHMg
b25lIGNyaXRpY2FsIHRyaXAgcG9pbnQgYW5kIG9uZQ0KKwkgIHBhc3NpdmUgdHJpcCBwb2ludCBm
b3IgZWFjaCB0aGVybWFsIHNlbnNvci4NCisNCiBjb25maWcgTUFYNzc2MjBfVEhFUk1BTA0KIAl0
cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgTWF4aW0gTUFYNzc2MjAgUE1J
QyINCiAJZGVwZW5kcyBvbiBNRkRfTUFYNzc2MjANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJt
YWwvTWFrZWZpbGUgYi9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCmluZGV4IDQ4NmQ2ODIuLjQw
NjI2MjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCisrKyBiL2RyaXZl
cnMvdGhlcm1hbC9NYWtlZmlsZQ0KQEAgLTQwLDYgKzQwLDcgQEAgb2JqLSQoQ09ORklHX0RCODUw
MF9USEVSTUFMKQkrPSBkYjg1MDBfdGhlcm1hbC5vDQogb2JqLSQoQ09ORklHX0FSTUFEQV9USEVS
TUFMKQkrPSBhcm1hZGFfdGhlcm1hbC5vDQogb2JqLSQoQ09ORklHX1RBTkdPX1RIRVJNQUwpCSs9
IHRhbmdvX3RoZXJtYWwubw0KIG9iai0kKENPTkZJR19JTVhfVEhFUk1BTCkJKz0gaW14X3RoZXJt
YWwubw0KK29iai0kKENPTkZJR19JTVhfU0NfVEhFUk1BTCkJKz0gaW14X3NjX3RoZXJtYWwubw0K
IG9iai0kKENPTkZJR19NQVg3NzYyMF9USEVSTUFMKQkrPSBtYXg3NzYyMF90aGVybWFsLm8NCiBv
YmotJChDT05GSUdfUU9SSVFfVEhFUk1BTCkJKz0gcW9yaXFfdGhlcm1hbC5vDQogb2JqLSQoQ09O
RklHX0RBOTA2Ml9USEVSTUFMKQkrPSBkYTkwNjItdGhlcm1hbC5vDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3Ro
ZXJtYWwuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmRjZjE2ZmMNCi0t
LSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQpAQCAt
MCwwICsxLDEzNyBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8q
DQorICogQ29weXJpZ2h0IDIwMTgtMjAxOSBOWFAuDQorICovDQorDQorI2luY2x1ZGUgPGxpbnV4
L2Vyci5oPg0KKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQorI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KKyNpbmNsdWRlIDxsaW51
eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4NCisjaW5jbHVkZSA8bGludXgvdGhlcm1hbC5oPg0KKw0KKyNp
bmNsdWRlICJ0aGVybWFsX2NvcmUuaCINCisNCisjZGVmaW5lIElNWF9TQ19NSVNDX0ZVTkNfR0VU
X1RFTVAJMTMNCisjZGVmaW5lIElNWF9TQ19DX1RFTVAJCQkwDQorDQorc3RhdGljIHN0cnVjdCBp
bXhfc2NfaXBjICp0aGVybWFsX2lwY19oYW5kbGU7DQorDQorc3RydWN0IGlteF9zY19zZW5zb3Ig
ew0KKwlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkOw0KKwl1MzIgcmVzb3VyY2VfaWQ7
DQorfTsNCisNCitzdHJ1Y3QgcmVxX2dldF90ZW1wIHsNCisJdTE2IHJlc291cmNlX2lkOw0KKwl1
OCB0eXBlOw0KK30gX19wYWNrZWQ7DQorDQorc3RydWN0IHJlc3BfZ2V0X3RlbXAgew0KKwl1MTYg
Y2Vsc2l1czsNCisJdTggdGVudGhzOw0KK30gX19wYWNrZWQ7DQorDQorc3RydWN0IGlteF9zY19t
c2dfbWlzY19nZXRfdGVtcCB7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQorCXVuaW9u
IHsNCisJCXN0cnVjdCByZXFfZ2V0X3RlbXAgcmVxOw0KKwkJc3RydWN0IHJlc3BfZ2V0X3RlbXAg
cmVzcDsNCisJfSBkYXRhOw0KK307DQorDQorc3RhdGljIGludCBpbXhfc2NfdGhlcm1hbF9nZXRf
dGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXApDQorew0KKwlzdHJ1Y3QgaW14X3NjX21zZ19taXNj
X2dldF90ZW1wIG1zZzsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNnLmhkcjsN
CisJc3RydWN0IGlteF9zY19zZW5zb3IgKnNlbnNvciA9IGRhdGE7DQorCWludCByZXQ7DQorDQor
CW1zZy5kYXRhLnJlcS5yZXNvdXJjZV9pZCA9IHNlbnNvci0+cmVzb3VyY2VfaWQ7DQorCW1zZy5k
YXRhLnJlcS50eXBlID0gSU1YX1NDX0NfVEVNUDsNCisNCisJaGRyLT52ZXIgPSBJTVhfU0NfUlBD
X1ZFUlNJT047DQorCWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQzsNCisJaGRyLT5mdW5j
ID0gSU1YX1NDX01JU0NfRlVOQ19HRVRfVEVNUDsNCisJaGRyLT5zaXplID0gMjsNCisNCisJcmV0
ID0gaW14X3NjdV9jYWxsX3JwYyh0aGVybWFsX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KKwlp
ZiAocmV0KSB7DQorCQlwcl9lcnIoInJlYWQgdGVtcCBzZW5zb3IgJWQgZmFpbGVkLCByZXQgJWRc
biIsDQorCQkJc2Vuc29yLT5yZXNvdXJjZV9pZCwgcmV0KTsNCisJCXJldHVybiByZXQ7DQorCX0N
CisNCisJKnRlbXAgPSBtc2cuZGF0YS5yZXNwLmNlbHNpdXMgKiAxMDAwICsgbXNnLmRhdGEucmVz
cC50ZW50aHMgKiAxMDA7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIGlteF9zY190aGVybWFsX29wcyA9IHsNCisJ
LmdldF90ZW1wID0gaW14X3NjX3RoZXJtYWxfZ2V0X3RlbXAsDQorfTsNCisNCitzdGF0aWMgaW50
IGlteF9zY190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0K
KwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCAqY2hpbGQ7DQorCWludCByZXQ7DQorDQorCXJldCA9
IGlteF9zY3VfZ2V0X2hhbmRsZSgmdGhlcm1hbF9pcGNfaGFuZGxlKTsNCisJaWYgKHJldCkNCisJ
CXJldHVybiByZXQ7DQorDQorCW5wID0gb2ZfZmluZF9ub2RlX2J5X25hbWUoTlVMTCwgInRoZXJt
YWwtem9uZXMiKTsNCisJaWYgKCFucCkNCisJCXJldHVybiAtRU5PREVWOw0KKw0KKwlmb3JfZWFj
aF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShucCwgY2hpbGQpIHsNCisJCXN0cnVjdCBvZl9waGFu
ZGxlX2FyZ3Mgc2Vuc29yX3NwZWNzOw0KKwkJc3RydWN0IGlteF9zY19zZW5zb3IgKnNlbnNvciA9
DQorCQkJZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc2Vuc29yKSwgR0ZQX0tFUk5F
TCk7DQorCQlpZiAoIXNlbnNvcikNCisJCQlyZXR1cm4gLUVOT01FTTsNCisNCisJCXJldCA9IHRo
ZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKGNoaWxkLA0KKwkJCQkJCSAgICAmc2Vuc29yX3Nw
ZWNzLA0KKwkJCQkJCSAgICAmc2Vuc29yLT5yZXNvdXJjZV9pZCk7DQorCQlpZiAocmV0IDwgMCkg
ew0KKwkJCWRldl9lcnIoJnBkZXYtPmRldiwNCisJCQkJImZhaWxlZCB0byBnZXQgdmFsaWQgc2Vu
c29yIHJlc291cmNlIGlkOiAlZFxuIiwNCisJCQkJcmV0KTsNCisJCQlicmVhazsNCisJCX0NCisN
CisJCXNlbnNvci0+dHpkID0gZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCZw
ZGV2LT5kZXYsDQorCQkJCQkJCQkgICBzZW5zb3ItPnJlc291cmNlX2lkLA0KKwkJCQkJCQkJICAg
c2Vuc29yLA0KKwkJCQkJCQkJICAgJmlteF9zY190aGVybWFsX29wcyk7DQorCQlpZiAoSVNfRVJS
KHNlbnNvci0+dHpkKSkgew0KKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdp
c3RlciB0aGVybWFsIHpvbmVcbiIpOw0KKwkJCXJldCA9IFBUUl9FUlIoc2Vuc29yLT50emQpOw0K
KwkJCWJyZWFrOw0KKwkJfQ0KKwl9DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3RhYmxlW10gPSB7DQorCXsg
LmNvbXBhdGlibGUgPSAiZnNsLGlteC1zYy10aGVybWFsIiwgfSwNCisJe30NCit9Ow0KK01PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIGlteF9zY190aGVybWFsX3RhYmxlKTsNCisNCitzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2NfdGhlcm1hbF9kcml2ZXIgPSB7DQorCQkucHJvYmUg
PSBpbXhfc2NfdGhlcm1hbF9wcm9iZSwNCisJCS5kcml2ZXIgPSB7DQorCQkJLm5hbWUgPSAiaW14
LXNjLXRoZXJtYWwiLA0KKwkJCS5vZl9tYXRjaF90YWJsZSA9IGlteF9zY190aGVybWFsX3RhYmxl
LA0KKwkJfSwNCit9Ow0KK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjX3RoZXJtYWxfZHJp
dmVyKTsNCisNCitNT0RVTEVfQVVUSE9SKCJBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4iKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIlRoZXJtYWwgZHJpdmVyIGZvciBOWFAgaS5NWCBT
b0NzIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIiKTsNCitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7
DQotLSANCjIuNy40DQoNCg==
