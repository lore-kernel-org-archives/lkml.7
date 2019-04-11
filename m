Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9851C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B6D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OtClyIki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKGtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:49:23 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:64818
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfDKGtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMxeJQENe4MxlLJvvo6BuMS5uiNKaroK0JSJ2CA8Zus=;
 b=OtClyIkia6W59vCd0SP9Fhd6OKQZmlkvSagIqz3oMb7mz+GujhRCjQnxkrGPcVL81aEg5dNccZJ3L6ynSgAkZ7jeSU2UppgD3REYAaPXNc+dlhcBf6tjREJWgQwGkUSik4CFsD4Afz+PiOqD6ua9DUWuRU7qz4kht6eGzenN0o0=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Thu, 11 Apr 2019 06:49:13 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd%4]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 06:49:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>,
        Andy Gross <andy.gross@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Topic: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Index: AQHU8DKsAg9Kriz6B0mooDc33xId4w==
Date:   Thu, 11 Apr 2019 06:49:12 +0000
Message-ID: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dad51af-f545-4b4f-e4f0-08d6be49ce6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB3910919EBAA4C03FDB6DEF56F52F0@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(105586002)(2501003)(97736004)(6116002)(53936002)(5660300002)(508600001)(71190400001)(7736002)(3846002)(6436002)(25786009)(2906002)(14454004)(6486002)(305945005)(4326008)(6512007)(81156014)(186003)(52116002)(486006)(102836004)(476003)(386003)(50226002)(8676002)(2616005)(36756003)(6506007)(8936002)(256004)(71200400001)(316002)(86362001)(99286004)(2201001)(81166006)(106356001)(66066001)(110136005)(68736007)(7416002)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NllsBW0ExJCDxKzBcQLXreDHmYMks2wBwBA7sOr6rFeCKc6s0EzsFc+a8Z54GG5xtUvHLHRozUPgck/SP/eSrjGxgZsIQyYVuMb5IgoybbOBKHyqvwCtUGt8wdg4hsSJjXdpOdVrql3k0n9F/nI/oKsiElreYzY8Rwtj+aIjQ/mO7Mv8u1Jfw5tkBin8oWH9PnoVKOLjGLk8wbe3qx69KnJehbqzWylbvpYjwX2hPxux9l9B3EzVrNANiHRruRiBAepAwX8Yea8wXtoypLG9ZzZSRZz4tqS2WZTVMq7LQfD9TUo2tVpcISzEoV/bsUjLSBFEb7N4dg9ypfQbbqWVPeGt3UBehG2eSp22ciO3X2D5N5JFWL7d90+r8yfapVWJWWiLW/HUJzfdCM1Jqg6iPPLCtXXOf/Pcq4lEhR/ZZ/M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dad51af-f545-4b4f-e4f0-08d6be49ce6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 06:49:12.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdoaWNoIGhhcyBhIENvcnRleC1NNCBzeXN0ZW0gY29u
dHJvbGxlcg0KaW5zaWRlLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIGNv
bnRyb2xsaW5nIHBvd2VyLA0KY2xvY2sgYW5kIGZ1c2UgZXRjLi4NCg0KVGhpcyBwYXRjaCBhZGRz
IGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgc29jIGRyaXZlciBzdXBwb3J0LA0KTGludXgga2VybmVs
IGhhcyB0byBjb21tdW5pY2F0ZSB3aXRoIHN5c3RlbSBjb250cm9sbGVyIHZpYSBNVQ0KKG1lc3Nh
Z2UgdW5pdCkgSVBDIHRvIGdldCBzb2MgcmV2aXNpb24sIHVpZCBldGMuLg0KDQpXaXRoIHRoaXMg
cGF0Y2gsIHNvYyBpbmZvIGNhbiBiZSByZWFkIGZyb20gc3lzZnM6DQoNCmkubXg4cXhwLW1layMg
Y2F0IC9zeXMvZGV2aWNlcy9zb2MwL2ZhbWlseQ0KRnJlZXNjYWxlIGkuTVgNCg0KaS5teDhxeHAt
bWVrIyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvc29jX2lkDQppLk1YOFFYUA0KDQppLm14OHF4cC1t
ZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9tYWNoaW5lDQpGcmVlc2NhbGUgaS5NWDhRWFAgTUVL
DQoNCmkubXg4cXhwLW1layMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL3JldmlzaW9uDQoxLjENCg0K
aS5teDhxeHAtbWVrIyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvc29jX3VpZA0KN0I2NDI4MEI1N0FD
MTg5OA0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvc29jL2lteC9LY29uZmlnICAgICAgfCAgIDcgKysNCiBkcml2ZXJzL3Nv
Yy9pbXgvTWFrZWZpbGUgICAgIHwgICAxICsNCiBkcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zYy5j
IHwgMjIwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZp
bGVzIGNoYW5nZWQsIDIyOCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvc29jL2lteC9zb2MtaW14LXNjLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9L
Y29uZmlnIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcNCmluZGV4IGQ4MGY4OTkuLmM5MDJiODkg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9zb2Mv
aW14L0tjb25maWcNCkBAIC03LDQgKzcsMTEgQEAgY29uZmlnIElNWF9HUENWMl9QTV9ET01BSU5T
DQogCXNlbGVjdCBQTV9HRU5FUklDX0RPTUFJTlMNCiAJZGVmYXVsdCB5IGlmIFNPQ19JTVg3RA0K
IA0KK2NvbmZpZyBJTVhfU0NfU09DDQorCWRlcGVuZHMgb24gSU1YX1NDVSB8fCBDT01QSUxFX1RF
U1QNCisJdHJpc3RhdGUgImkuTVggU3lzdGVtIENvbnRyb2xsZXIgU29DIHN1cHBvcnQiDQorCWhl
bHANCisJICAgSWYgeW91IHNheSB5ZXMgaGVyZSB5b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBpLk1Y
IFN5c3RlbQ0KKwkgICBDb250cm9sbGVyIFNvQyBtb2R1bGUuDQorDQogZW5kbWVudQ0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZSBiL2RyaXZlcnMvc29jL2lteC9NYWtlZmls
ZQ0KaW5kZXggNTA2YTZmMy4uZDAwNjA2ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL2lteC9N
YWtlZmlsZQ0KKysrIGIvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQpAQCAtMSwyICsxLDMgQEAN
CiBvYmotJChDT05GSUdfSEFWRV9JTVhfR1BDKSArPSBncGMubw0KIG9iai0kKENPTkZJR19JTVhf
R1BDVjJfUE1fRE9NQUlOUykgKz0gZ3BjdjIubw0KK29iai0kKENPTkZJR19JTVhfU0NfU09DKSAr
PSBzb2MtaW14LXNjLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zYy5j
IGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2MuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmlu
ZGV4IDAwMDAwMDAuLjAyOWQ3NTQNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvc29jL2lt
eC9zb2MtaW14LXNjLmMNCkBAIC0wLDAgKzEsMjIwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjArDQorLyoNCisgKiBDb3B5cmlnaHQgMjAxOSBOWFAuDQorICovDQorDQor
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Zpcm13YXJlL2lteC9yc3JjLmg+DQorI2luY2x1ZGUgPGxp
bnV4L2Zpcm13YXJlL2lteC9zY2kuaD4NCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4NCisjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPg0KKyNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGludXgvb2YuaD4NCisN
CisjaW5jbHVkZSA8c29jL2lteC9yZXZpc2lvbi5oPg0KKw0KKyNkZWZpbmUgSU1YX1NDX1NPQ19E
UklWRVJfTkFNRQkiaW14LXNjLXNvYyINCisNCisjZGVmaW5lIFNPQ19SRVZfTUFKT1JfT0ZGU0VU
CTB4NA0KKyNkZWZpbmUgU09DX1JFVl9NQUpPUl9NQVNLCTB4Zg0KKyNkZWZpbmUgU09DX1JFVl9N
SU5PUl9PRkZTRVQJMHg0DQorI2RlZmluZSBTT0NfUkVWX01JTk9SX01BU0sJMHhmDQorDQorI2Rl
ZmluZSBnZXRfc29jX3Jldl9tYWpvcihyZXYpICgocmV2ID4+IFNPQ19SRVZfTUFKT1JfT0ZGU0VU
KSAmIFNPQ19SRVZfTUFKT1JfTUFTSykNCisjZGVmaW5lIGdldF9zb2NfcmV2X21pbm9yKHJldikg
KChyZXYgPj4gU09DX1JFVl9NSU5PUl9PRkZTRVQpICYgU09DX1JFVl9NSU5PUl9NQVNLKQ0KKw0K
K3N0YXRpYyB1MzIgaW14X3NjX3NvY19yZXYgPSBJTVhfQ0hJUF9SRVZJU0lPTl9VTktOT1dOOw0K
K3N0YXRpYyB1NjQgaW14X3NjX3NvY191aWQ7DQorDQorc3RhdGljIHN0cnVjdCBpbXhfc2NfaXBj
ICpzb2NfaXBjX2hhbmRsZTsNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqaW14X3Nj
X3NvY19wZGV2Ow0KKw0KK3N0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3NvY19pZCB7DQorCXN0
cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQorCXVuaW9uIHsNCisJCXN0cnVjdCB7DQorCQkJdTMy
IGNvbnRyb2w7DQorCQkJdTE2IHJlc291cmNlOw0KKwkJfSBfX3BhY2tlZCBzZW5kOw0KKwkJc3Ry
dWN0IHsNCisJCQl1MzIgaWQ7DQorCQkJdTE2IHJlc2VydmVkOw0KKwkJfSBfX3BhY2tlZCByZXNw
Ow0KKwl9IGRhdGE7DQorfTsNCisNCitzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfdWlk
IHsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCisJdTMyIGlkX2w7DQorCXUzMiBpZF9o
Ow0KK307DQorDQorc3RhdGljIGlubGluZSB2b2lkIGlteF9zY19zZXRfc29jX3JldmlzaW9uKHUz
MiByZXYpDQorew0KKwlpbXhfc2Nfc29jX3JldiA9IHJldjsNCit9DQorDQordW5zaWduZWQgaW50
IGlteF9nZXRfc29jX3JldmlzaW9uKHZvaWQpDQorew0KKwlyZXR1cm4gaW14X3NjX3NvY19yZXY7
DQorfQ0KK0VYUE9SVF9TWU1CT0woaW14X2dldF9zb2NfcmV2aXNpb24pOw0KKw0KK3N0YXRpYyB1
MzIgaW14X2luaXRfcmV2aXNpb25fZnJvbV9zY3Uodm9pZCkNCit7DQorCXN0cnVjdCBpbXhfc2Nf
bXNnX21pc2NfZ2V0X3NvY19pZCBtc2c7DQorCXN0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3Nv
Y191aWQgbXNnMTsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNnLmhkcjsNCisJ
c3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIxID0gJm1zZzEuaGRyOw0KKwl1MzIgaWQsIHJldjsN
CisJaW50IHJldDsNCisNCisJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQorCWhkci0+
c3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQzsNCisJaGRyLT5mdW5jID0gSU1YX1NDX01JU0NfRlVO
Q19HRVRfQ09OVFJPTDsNCisJaGRyLT5zaXplID0gMzsNCisNCisJbXNnLmRhdGEuc2VuZC5jb250
cm9sID0gSU1YX1NDX0NfSUQ7DQorCW1zZy5kYXRhLnNlbmQucmVzb3VyY2UgPSBJTVhfU0NfUl9T
WVNURU07DQorDQorCXJldCA9IGlteF9zY3VfY2FsbF9ycGMoc29jX2lwY19oYW5kbGUsICZtc2cs
IHRydWUpOw0KKwlpZiAocmV0KSB7DQorCQlwcl9lcnIoIm1pc2MgZ2V0IGNvbnRyb2wgZmFpbGVk
LCByZXQgJWRcbiIsIHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCWlkID0gbXNnLmRh
dGEucmVzcC5pZDsNCisNCisJcmV2ID0gKGlkID4+IDUpICYgMHhmOw0KKwlyZXYgPSAoKChyZXYg
Pj4gMikgKyAxKSA8PCA0KSB8IChyZXYgJiAweDMpOw0KKw0KKwlpbXhfc2Nfc2V0X3NvY19yZXZp
c2lvbihyZXYpOw0KKw0KKwloZHIxLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQorCWhkcjEt
PnN2YyA9IElNWF9TQ19SUENfU1ZDX01JU0M7DQorCWhkcjEtPmZ1bmMgPSBJTVhfU0NfTUlTQ19G
VU5DX1VOSVFVRV9JRDsNCisJaGRyMS0+c2l6ZSA9IDE7DQorDQorCS8qIHRoZSByZXR1cm4gdmFs
dWUgb2YgU0NVIEZXIGlzIGluIGNvcnJlY3QsIGNhbiBOT1QgY2hlY2sgdGhlIHJldCAqLw0KKwly
ZXQgPSBpbXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnMSwgdHJ1ZSk7DQorDQor
CWlteF9zY19zb2NfdWlkID0gbXNnMS5pZF9oOw0KKwlpbXhfc2Nfc29jX3VpZCA8PD0gMzI7DQor
CWlteF9zY19zb2NfdWlkIHw9IG1zZzEuaWRfbDsNCisNCisJcmV0dXJuIHJldjsNCit9DQorDQor
c3RhdGljIHNzaXplX3QgaW14X3NjX2dldF9zb2NfdWlkKHN0cnVjdCBkZXZpY2UgKmRldiwNCisJ
CQkJICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCisJCQkJICBjaGFyICpidWYpDQor
ew0KKwlyZXR1cm4gc3ByaW50ZihidWYsICIlMDE2bGxYXG4iLCBpbXhfc2Nfc29jX3VpZCk7DQor
fQ0KKw0KK3N0YXRpYyBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBpbXhfc2NfdWlkID0NCisJX19B
VFRSKHNvY191aWQsIDA0NDQsIGlteF9zY19nZXRfc29jX3VpZCwgTlVMTCk7DQorDQorc3RhdGlj
IGludCBpbXhfc2Nfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0K
KwlzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKnNvY19kZXZfYXR0cjsNCisJdTMyIHJldiA9
IElNWF9DSElQX1JFVklTSU9OX1VOS05PV047DQorCXN0cnVjdCBzb2NfZGV2aWNlICpzb2NfZGV2
Ow0KKwl1MzIgc29jX3JldjsNCisJaW50IHJldDsNCisNCisJcmV0ID0gaW14X3NjdV9nZXRfaGFu
ZGxlKCZzb2NfaXBjX2hhbmRsZSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlz
b2NfZGV2X2F0dHIgPSBremFsbG9jKHNpemVvZigqc29jX2Rldl9hdHRyKSwgR0ZQX0tFUk5FTCk7
DQorCWlmICghc29jX2Rldl9hdHRyKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXNvY19kZXZf
YXR0ci0+ZmFtaWx5ID0gIkZyZWVzY2FsZSBpLk1YIjsNCisNCisJaWYgKG9mX21hY2hpbmVfaXNf
Y29tcGF0aWJsZSgiZnNsLGlteDhxeHAiKSkNCisJCXNvY19kZXZfYXR0ci0+c29jX2lkID0gImku
TVg4UVhQIjsNCisJZWxzZQ0KKwkJc29jX2Rldl9hdHRyLT5zb2NfaWQgPSAidW5rbm93biI7DQor
DQorCXJldiA9IGlteF9pbml0X3JldmlzaW9uX2Zyb21fc2N1KCk7DQorCWlmIChyZXYgPT0gSU1Y
X0NISVBfUkVWSVNJT05fVU5LTk9XTikNCisJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJDUFUgaWRl
bnRpZmllZCBhcyAlcywgdW5rbm93biByZXZpc2lvblxuIiwNCisJCQkgc29jX2Rldl9hdHRyLT5z
b2NfaWQpOw0KKwllbHNlDQorCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAiQ1BVIGlkZW50aWZpZWQg
YXMgJXMsIHNpbGljb24gcmV2ICVkLiVkXG4iLA0KKwkJCSBzb2NfZGV2X2F0dHItPnNvY19pZCwN
CisJCQkgZ2V0X3NvY19yZXZfbWFqb3IocmV2KSwNCisJCQkgZ2V0X3NvY19yZXZfbWlub3IocmV2
KSk7DQorDQorCXNvY19yZXYgPSBpbXhfZ2V0X3NvY19yZXZpc2lvbigpOw0KKwlzb2NfZGV2X2F0
dHItPnJldmlzaW9uID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIlZC4lZCIsDQorCQkJCQkgICBn
ZXRfc29jX3Jldl9tYWpvcihyZXYpLA0KKwkJCQkJICAgZ2V0X3NvY19yZXZfbWlub3IocmV2KSk7
DQorCWlmICghc29jX2Rldl9hdHRyLT5yZXZpc2lvbikgew0KKwkJcmV0ID0gLUVOT01FTTsNCisJ
CWdvdG8gZnJlZV9zb2M7DQorCX0NCisNCisJb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcob2Zfcm9v
dCwgIm1vZGVsIiwgJnNvY19kZXZfYXR0ci0+bWFjaGluZSk7DQorDQorCXNvY19kZXYgPSBzb2Nf
ZGV2aWNlX3JlZ2lzdGVyKHNvY19kZXZfYXR0cik7DQorCWlmIChJU19FUlIoc29jX2RldikpIHsN
CisJCXJldCA9IFBUUl9FUlIoc29jX2Rldik7DQorCQlnb3RvIGZyZWVfcmV2Ow0KKwl9DQorDQor
CXJldCA9IGRldmljZV9jcmVhdGVfZmlsZShzb2NfZGV2aWNlX3RvX2RldmljZShzb2NfZGV2KSwg
JmlteF9zY191aWQpOw0KKwlpZiAocmV0KQ0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiY291bGQg
bm90IHJlZ2lzdGVyIHN5c2ZzIGVudHJ5XG4iKTsNCisNCisJcmV0dXJuIHJldDsNCisNCitmcmVl
X3JldjoNCisJa2ZyZWUoc29jX2Rldl9hdHRyLT5yZXZpc2lvbik7DQorZnJlZV9zb2M6DQorCWtm
cmVlKHNvY19kZXZfYXR0cik7DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIGlteF9zY19zb2NfZHJpdmVyID0gew0KKwkuZHJpdmVyID0gew0KKwkJ
Lm5hbWUgPSBJTVhfU0NfU09DX0RSSVZFUl9OQU1FLA0KKwl9LA0KKwkucHJvYmUgPSBpbXhfc2Nf
c29jX3Byb2JlLA0KK307DQorDQorc3RhdGljIGludCBfX2luaXQgaW14X3NjX3NvY19pbml0KHZv
aWQpDQorew0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIo
JmlteF9zY19zb2NfZHJpdmVyKTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQorCWlt
eF9zY19zb2NfcGRldiA9DQorCQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKElNWF9T
Q19TT0NfRFJJVkVSX05BTUUsDQorCQkJCQkJLTEsDQorCQkJCQkJTlVMTCwNCisJCQkJCQkwKTsN
CisJaWYgKElTX0VSUihpbXhfc2Nfc29jX3BkZXYpKSB7DQorCQlyZXQgPSBQVFJfRVJSKGlteF9z
Y19zb2NfcGRldik7DQorCQlnb3RvIHVucmVnX3BsYXRmb3JtX2RyaXZlcjsNCisJfQ0KKw0KKwly
ZXR1cm4gMDsNCisNCit1bnJlZ19wbGF0Zm9ybV9kcml2ZXI6DQorCXBsYXRmb3JtX2RyaXZlcl91
bnJlZ2lzdGVyKCZpbXhfc2Nfc29jX2RyaXZlcik7DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0
YXRpYyB2b2lkIF9fZXhpdCBpbXhfc2Nfc29jX2V4aXQodm9pZCkNCit7DQorCXBsYXRmb3JtX2Rl
dmljZV91bnJlZ2lzdGVyKGlteF9zY19zb2NfcGRldik7DQorCXBsYXRmb3JtX2RyaXZlcl91bnJl
Z2lzdGVyKCZpbXhfc2Nfc29jX2RyaXZlcik7DQorfQ0KKw0KK21vZHVsZV9pbml0KGlteF9zY19z
b2NfaW5pdCk7DQorbW9kdWxlX2V4aXQoaW14X3NjX3NvY19leGl0KTsNCi0tIA0KMi43LjQNCg0K
