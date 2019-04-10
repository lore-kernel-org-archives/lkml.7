Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D474C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639FA2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTn2ShmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfDJHnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:43:19 -0400
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:54302
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDJHnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orjKlCVHXrwxafKzAP89ZK1y6z3BVga/JXa6K4sY+wY=;
 b=HTn2ShmAYGN5+w1mDG4EvtmAY5EGyEoXha5enGxnPQE/M9qpfAZaQa2u0fpYXilLTP78LIzHy0RnLFz96+7/PnVG1uUUt5bVne/8pN2NsfrTrJVmN9GPrGAjZM4nQGaCdHUoHEuPii/gvfAJWUtWg3fT8MEva+fg/Jg1pfpCKnY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Wed, 10 Apr 2019 07:43:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 07:43:13 +0000
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
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V11 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Topic: [PATCH RESEND V11 2/4] thermal: imx_sc: add i.MX system
 controller thermal support
Thread-Index: AQHU73ENqQHtRU602k6XLq6MLOET1A==
Date:   Wed, 10 Apr 2019 07:43:13 +0000
Message-ID: <1554881866-26333-2-git-send-email-Anson.Huang@nxp.com>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0155.apcprd02.prod.outlook.com (10.171.30.15) To
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a660c5a7-077e-4e7b-f93d-08d6bd882f8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3770FAC5BFF3D5FA156D2B57F52E0@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(86362001)(478600001)(7416002)(52116002)(97736004)(110136005)(76176011)(386003)(6506007)(2501003)(316002)(102836004)(186003)(2201001)(81156014)(81166006)(14454004)(2906002)(66066001)(8676002)(26005)(256004)(305945005)(6116002)(3846002)(7736002)(71190400001)(446003)(71200400001)(11346002)(68736007)(5660300002)(476003)(2616005)(6512007)(53936002)(36756003)(99286004)(106356001)(6436002)(105586002)(6486002)(8936002)(50226002)(25786009)(486006)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ay5DO8pRYqOXgwfLqFlFF8z4cDGmnwjyyAwrDNH3wAwZ3x2miboHhq07BStCKPulODNFMtQBGB96BIxQTSIWNBvWtf1yk2a9XCXZrxP3wpOo7oSzSeRoaq3x2QnSlCmqTY8upzt4t2Z7VK8z0EoXKTqd1icf9RpvaB/LvpbT1PwMrYnTiXdGplN4dqwdso/BvIcwi0pQ14vHopwFy+tGZIWxPuJZLdwMSpdrKYouFd2Z0xMM8rOksdUrpwczgt/bbQ0t96iRT6r5a8dDycdnb/SI+mr2hJn2CesApvHz4+xmEynL06ujb6C8NgWs+4uN81P83B5nNcrFQovpaoMn7XIk9sq2dcpxybocYZNZtoe295NRJuUipXWk4P3Bl/WXXGG8M6rZH9RrDdjOMkwQxmHIpdWh9E2WUN4j4s+thgI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a660c5a7-077e-4e7b-f93d-08d6bd882f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:43:13.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
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
Ci0tLQ0KQ2hhbmdlcyBzaW5jZSBWMTA6DQoJLSByZW1vdmUgImlteCxzZW5zb3ItcmVzb3VyY2Ut
aWQiIHByb3BlcnR5LCBwdXQgdGhlIEhXIHJlc291cmNlIElEIGluc2lkZSB0aGVybWFsLXpvbmVz
IG5vZGUsDQoJICBhbmQgZHJpdmVyIG5lZWRzIHRvIHBhcnNlIHRoZSBwaGFuZGxlIGFyZ3VtZW50
IHRvIGdldCBIVyByZXNvdXJjZSBJRCBhbmQgdXNlIGl0IHRvIHJlZ2lzdGVyDQoJICB0aGVybWFs
IHpvbmUuDQotLS0NCiBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAgICB8ICAxMSArKysN
CiBkcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgICAgICAgICB8ICAgMSArDQogZHJpdmVycy90aGVy
bWFsL2lteF9zY190aGVybWFsLmMgfCAxNTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxNzEgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYw0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90aGVybWFsL0tjb25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KaW5k
ZXggNjUzYWEyNy4uNGU0ZmE3ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdGhlcm1hbC9LY29uZmln
DQorKysgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KQEAgLTIyMyw2ICsyMjMsMTcgQEAgY29u
ZmlnIElNWF9USEVSTUFMDQogCSAgY3B1ZnJlcSBpcyB1c2VkIGFzIHRoZSBjb29saW5nIGRldmlj
ZSB0byB0aHJvdHRsZSBDUFVzIHdoZW4gdGhlDQogCSAgcGFzc2l2ZSB0cmlwIGlzIGNyb3NzZWQu
DQogDQorY29uZmlnIElNWF9TQ19USEVSTUFMDQorCXRyaXN0YXRlICJUZW1wZXJhdHVyZSBzZW5z
b3IgZHJpdmVyIGZvciBOWFAgaS5NWCBTb0NzIHdpdGggU3lzdGVtIENvbnRyb2xsZXIiDQorCWRl
cGVuZHMgb24gKEFSQ0hfTVhDICYmIElNWF9TQ1UpIHx8IENPTVBJTEVfVEVTVA0KKwlkZXBlbmRz
IG9uIE9GDQorCWhlbHANCisJICBTdXBwb3J0IGZvciBUZW1wZXJhdHVyZSBNb25pdG9yIChURU1Q
TU9OKSBmb3VuZCBvbiBOWFAgaS5NWCBTb0NzIHdpdGgNCisJICBzeXN0ZW0gY29udHJvbGxlciBp
bnNpZGUsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0NCisJICBj
b250cm9sbGVyIHZpYSBNVSAobWVzc2FnZSB1bml0KSBJUEMgdG8gZ2V0IHRlbXBlcmF0dXJlIGZy
b20gdGhlcm1hbA0KKwkgIHNlbnNvci4gSXQgc3VwcG9ydHMgb25lIGNyaXRpY2FsIHRyaXAgcG9p
bnQgYW5kIG9uZQ0KKwkgIHBhc3NpdmUgdHJpcCBwb2ludCBmb3IgZWFjaCB0aGVybWFsIHNlbnNv
ci4NCisNCiBjb25maWcgTUFYNzc2MjBfVEhFUk1BTA0KIAl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUg
c2Vuc29yIGRyaXZlciBmb3IgTWF4aW0gTUFYNzc2MjAgUE1JQyINCiAJZGVwZW5kcyBvbiBNRkRf
TUFYNzc2MjANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUgYi9kcml2ZXJz
L3RoZXJtYWwvTWFrZWZpbGUNCmluZGV4IDQ4NmQ2ODIuLjQwNjI2MjcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3RoZXJtYWwvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZQ0K
QEAgLTQwLDYgKzQwLDcgQEAgb2JqLSQoQ09ORklHX0RCODUwMF9USEVSTUFMKQkrPSBkYjg1MDBf
dGhlcm1hbC5vDQogb2JqLSQoQ09ORklHX0FSTUFEQV9USEVSTUFMKQkrPSBhcm1hZGFfdGhlcm1h
bC5vDQogb2JqLSQoQ09ORklHX1RBTkdPX1RIRVJNQUwpCSs9IHRhbmdvX3RoZXJtYWwubw0KIG9i
ai0kKENPTkZJR19JTVhfVEhFUk1BTCkJKz0gaW14X3RoZXJtYWwubw0KK29iai0kKENPTkZJR19J
TVhfU0NfVEhFUk1BTCkJKz0gaW14X3NjX3RoZXJtYWwubw0KIG9iai0kKENPTkZJR19NQVg3NzYy
MF9USEVSTUFMKQkrPSBtYXg3NzYyMF90aGVybWFsLm8NCiBvYmotJChDT05GSUdfUU9SSVFfVEhF
Uk1BTCkJKz0gcW9yaXFfdGhlcm1hbC5vDQogb2JqLSQoQ09ORklHX0RBOTA2Ml9USEVSTUFMKQkr
PSBkYTkwNjItdGhlcm1hbC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2lteF9zY190
aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJtYWwuYw0KbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjBhZjBmMDkNCi0tLSAvZGV2L251bGwNCisrKyBiL2Ry
aXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQpAQCAtMCwwICsxLDE1OSBAQA0KKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qDQorICogQ29weXJpZ2h0IDIwMTgt
MjAxOSBOWFAuDQorICovDQorDQorI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KKyNpbmNsdWRlIDxs
aW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KKyNp
bmNsdWRlIDxsaW51eC9vZi5oPg0KKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4N
CisjaW5jbHVkZSA8bGludXgvdGhlcm1hbC5oPg0KKw0KKyNpbmNsdWRlICJ0aGVybWFsX2NvcmUu
aCINCisNCisjZGVmaW5lIElNWF9TQ19NSVNDX0ZVTkNfR0VUX1RFTVAJMTMNCisjZGVmaW5lIElN
WF9TQ19DX1RFTVAJCQkwDQorDQorc3RhdGljIHN0cnVjdCBpbXhfc2NfaXBjICp0aGVybWFsX2lw
Y19oYW5kbGU7DQorDQorc3RydWN0IGlteF9zY19zZW5zb3Igew0KKwlzdHJ1Y3QgdGhlcm1hbF96
b25lX2RldmljZSAqdHpkOw0KKwl1MzIgcmVzb3VyY2VfaWQ7DQorfTsNCisNCitzdHJ1Y3QgcmVx
X2dldF90ZW1wIHsNCisJdTE2IHJlc291cmNlX2lkOw0KKwl1OCB0eXBlOw0KK30gX19wYWNrZWQ7
DQorDQorc3RydWN0IHJlc3BfZ2V0X3RlbXAgew0KKwl1MTYgY2Vsc2l1czsNCisJdTggdGVudGhz
Ow0KK30gX19wYWNrZWQ7DQorDQorc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfdGVtcCB7DQor
CXN0cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQorCXVuaW9uIHsNCisJCXN0cnVjdCByZXFfZ2V0
X3RlbXAgcmVxOw0KKwkJc3RydWN0IHJlc3BfZ2V0X3RlbXAgcmVzcDsNCisJfSBkYXRhOw0KK30g
X19wYWNrZWQ7DQorDQorc3RhdGljIGludCBpbXhfc2NfdGhlcm1hbF9nZXRfdGVtcCh2b2lkICpk
YXRhLCBpbnQgKnRlbXApDQorew0KKwlzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF90ZW1wIG1z
ZzsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNnLmhkcjsNCisJc3RydWN0IGlt
eF9zY19zZW5zb3IgKnNlbnNvciA9IGRhdGE7DQorCWludCByZXQ7DQorDQorCW1zZy5kYXRhLnJl
cS5yZXNvdXJjZV9pZCA9IHNlbnNvci0+cmVzb3VyY2VfaWQ7DQorCW1zZy5kYXRhLnJlcS50eXBl
ID0gSU1YX1NDX0NfVEVNUDsNCisNCisJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQor
CWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQzsNCisJaGRyLT5mdW5jID0gSU1YX1NDX01J
U0NfRlVOQ19HRVRfVEVNUDsNCisJaGRyLT5zaXplID0gMjsNCisNCisJcmV0ID0gaW14X3NjdV9j
YWxsX3JwYyh0aGVybWFsX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KKwlpZiAocmV0KSB7DQor
CQlwcl9lcnIoInJlYWQgdGVtcCBzZW5zb3IgJWQgZmFpbGVkLCByZXQgJWRcbiIsDQorCQkJc2Vu
c29yLT5yZXNvdXJjZV9pZCwgcmV0KTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCisJKnRlbXAg
PSBtc2cuZGF0YS5yZXNwLmNlbHNpdXMgKiAxMDAwICsgbXNnLmRhdGEucmVzcC50ZW50aHMgKiAx
MDA7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IHRoZXJtYWxf
em9uZV9vZl9kZXZpY2Vfb3BzIGlteF9zY190aGVybWFsX29wcyA9IHsNCisJLmdldF90ZW1wID0g
aW14X3NjX3RoZXJtYWxfZ2V0X3RlbXAsDQorfTsNCisNCitzdGF0aWMgaW50IGlteF9zY190aGVy
bWFsX2dldF9zZW5zb3JfaWQoc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsIHUzMiAqaWQp
DQorew0KKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIHNlbnNvcl9zcGVjczsNCisJaW50IHJldDsN
CisNCisJcmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3Moc2Vuc29yX25wLA0KKwkJCQkJ
ICJ0aGVybWFsLXNlbnNvcnMiLA0KKwkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KKwkJ
CQkJIDAsDQorCQkJCQkgJnNlbnNvcl9zcGVjcyk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0
Ow0KKw0KKwlpZiAoc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPj0gMSkgew0KKwkJKmlkID0gc2Vu
c29yX3NwZWNzLmFyZ3NbMF07DQorCQlXQVJOKHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50ID4gMSwN
CisJCSAgICAgIiVwT0ZuOiB0b28gbWFueSBjZWxscyBpbiBzZW5zb3Igc3BlY2lmaWVyICVkXG4i
LA0KKwkJICAgICBzZW5zb3Jfc3BlY3MubnAsIHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50KTsNCisJ
fSBlbHNlIHsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQorCXJldHVybiAwOw0KK30NCisN
CitzdGF0aWMgaW50IGlteF9zY190aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQorew0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCAqY2hpbGQ7DQorCWludCByZXQ7
DQorDQorCXJldCA9IGlteF9zY3VfZ2V0X2hhbmRsZSgmdGhlcm1hbF9pcGNfaGFuZGxlKTsNCisJ
aWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQorCW5wID0gb2ZfZmluZF9ub2RlX2J5X25hbWUo
TlVMTCwgInRoZXJtYWwtem9uZXMiKTsNCisJaWYgKCFucCkNCisJCXJldHVybiAtRU5PREVWOw0K
Kw0KKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShucCwgY2hpbGQpIHsNCisJCXN0
cnVjdCBpbXhfc2Nfc2Vuc29yICpzZW5zb3IgPQ0KKwkJCWRldm1fa3phbGxvYygmcGRldi0+ZGV2
LCBzaXplb2YoKnNlbnNvciksIEdGUF9LRVJORUwpOw0KKwkJaWYgKCFzZW5zb3IpDQorCQkJcmV0
dXJuIC1FTk9NRU07DQorDQorCQlyZXQgPSBpbXhfc2NfdGhlcm1hbF9nZXRfc2Vuc29yX2lkKGNo
aWxkLCAmc2Vuc29yLT5yZXNvdXJjZV9pZCk7DQorCQlpZiAocmV0IDwgMCkgew0KKwkJCWRldl9l
cnIoJnBkZXYtPmRldiwNCisJCQkJImZhaWxlZCB0byBnZXQgdmFsaWQgc2Vuc29yIHJlc291cmNl
IGlkOiAlZFxuIiwNCisJCQkJcmV0KTsNCisJCQlicmVhazsNCisJCX0NCisNCisJCXNlbnNvci0+
dHpkID0gZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCZwZGV2LT5kZXYsDQor
CQkJCQkJCQkgICBzZW5zb3ItPnJlc291cmNlX2lkLA0KKwkJCQkJCQkJICAgc2Vuc29yLA0KKwkJ
CQkJCQkJICAgJmlteF9zY190aGVybWFsX29wcyk7DQorCQlpZiAoSVNfRVJSKHNlbnNvci0+dHpk
KSkgew0KKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFs
IHpvbmVcbiIpOw0KKwkJCXJldCA9IFBUUl9FUlIoc2Vuc29yLT50emQpOw0KKwkJCWJyZWFrOw0K
KwkJfQ0KKwl9DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3RhYmxlW10gPSB7DQorCXsgLmNvbXBhdGlibGUg
PSAiZnNsLGlteC1zYy10aGVybWFsIiwgfSwNCisJe30NCit9Ow0KK01PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIGlteF9zY190aGVybWFsX3RhYmxlKTsNCisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBpbXhfc2NfdGhlcm1hbF9kcml2ZXIgPSB7DQorCQkucHJvYmUgPSBpbXhfc2NfdGhl
cm1hbF9wcm9iZSwNCisJCS5kcml2ZXIgPSB7DQorCQkJLm5hbWUgPSAiaW14LXNjLXRoZXJtYWwi
LA0KKwkJCS5vZl9tYXRjaF90YWJsZSA9IGlteF9zY190aGVybWFsX3RhYmxlLA0KKwkJfSwNCit9
Ow0KK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjX3RoZXJtYWxfZHJpdmVyKTsNCisNCitN
T0RVTEVfQVVUSE9SKCJBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4iKTsNCitNT0RV
TEVfREVTQ1JJUFRJT04oIlRoZXJtYWwgZHJpdmVyIGZvciBOWFAgaS5NWCBTb0NzIHdpdGggc3lz
dGVtIGNvbnRyb2xsZXIiKTsNCitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQotLSANCjIuNy40
DQoNCg==
