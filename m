Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB21EC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889212147C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4BEI/OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfDVEy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:54:27 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:13070
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbfDVEy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN0Ucaxk2iMiksHeykiSYYXSutHMdigKbXP0tFwWZts=;
 b=G4BEI/OTAT4W0titl2PN8J4dj4CZGins60c0TAopWFrDwAKHGYgu4ITZOWny3XcSHxZZw+nfDfyMeuMUEf/KPsGcWvdf4ghbu0F/kPBoW/0MEhNR4LRFW/zqeykgjX6qcznJEIsxDoIlDpYHVahRVDm/NiZSdNPsnIyOXtNR+Q8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Mon, 22 Apr 2019 04:54:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:54:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] soc: imx: add i.MX8QXP SoC driver support
Thread-Topic: [PATCH 1/2] soc: imx: add i.MX8QXP SoC driver support
Thread-Index: AQHU+MdvI5VlMRhvBUyIasIKgR6dCA==
Date:   Mon, 22 Apr 2019 04:54:15 +0000
Message-ID: <1555908516-13354-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2acf25-47ef-4c2f-9e4d-08d6c6de9191
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850A1658E681289DF12251BF5220@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(136003)(376002)(199004)(189003)(186003)(8936002)(66446008)(66556008)(66476007)(66946007)(64756008)(476003)(50226002)(2906002)(73956011)(52116002)(6506007)(386003)(26005)(81166006)(486006)(81156014)(102836004)(99286004)(97736004)(2616005)(5660300002)(8676002)(68736007)(256004)(6486002)(4326008)(2501003)(66066001)(25786009)(71200400001)(14454004)(6512007)(110136005)(86362001)(71190400001)(316002)(2201001)(305945005)(7736002)(7416002)(36756003)(3846002)(478600001)(6116002)(53936002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cS8pt+pSUUmHKgeYaOYAtWG3JW2mcMRIahWieTIqjcRiCAmBKpwjRStkkChN52fS60hIJtqrql16r2uZdL0JxQmVHX8SZsWb3QkBS8kkY7TdmJtSgWU5jyX652akQwpMlsVukD0PVnyNjpcCfjeKpJVVajTKxngm/nuLkcLwNPMvI3vg4TeXw69OayAlAd9QMlf7ZZRb8bWwU73+nh3bB/u7P2NupMEAY7MTLL7jgPo2H3OtqW8Rgy37cKonCytHT3Sa72jdz+ePpgQX+2p3gXRctLipQqKXvmhsuG1nzyHpuQHOpxEUmqDnKaiMHddseX/r7678UCDVdBjhql92ADQJUTdaoRRjXcrKteREWCVlSrGXP3zxKnugatGeEgkPIeEfWghgY9VzDs0k3ihgiolInDOkiKq6OYP9RoFYluY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2acf25-47ef-4c2f-9e4d-08d6c6de9191
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:54:15.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIFNvQyBkcml2ZXIgc3VwcG9ydCwgaW50cm9kdWNlIGRyaXZlciBkZXBlbmRl
bmN5DQppbnRvIEtjb25maWcgYXMgQ09ORklHX0lNWF9TQ1UgbXVzdCBiZSBzZWxlY3RlZCB0byBz
dXBwb3J0DQppLk1YOFFYUCwgYWxzbyBuZWVkIHRvIHVzZSBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwg
dG8gbWFrZSBzdXJlDQpJTVhfU0NVIGRyaXZlciBpcyBwcm9iZWQgYmVmb3JlIGkuTVg4IFNvQyBk
cml2ZXIuDQoNCldpdGggdGhpcyBwYXRjaCwgU29DIGluZm8gY2FuIGJlIHJlYWQgZnJvbSBzeXNm
czoNCg0KaS5teDhxeHAtbWVrIyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvZmFtaWx5DQpGcmVlc2Nh
bGUgaS5NWA0KDQppLm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9zb2NfaWQNCmku
TVg4UVhQDQoNCmkubXg4cXhwLW1layMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL21hY2hpbmUNCkZy
ZWVzY2FsZSBpLk1YOFFYUCBNRUsNCg0KaS5teDhxeHAtbWVrIyBjYXQgL3N5cy9kZXZpY2VzL3Nv
YzAvcmV2aXNpb24NCjEuMQ0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL2lteC9LY29uZmlnICAgIHwgICA0ICsrDQog
ZHJpdmVycy9zb2MvaW14L01ha2VmaWxlICAgfCAgIDIgKy0NCiBkcml2ZXJzL3NvYy9pbXgvc29j
LWlteDguYyB8IDEyNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0NCiAzIGZpbGVzIGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L0tjb25maWcgYi9kcml2ZXJzL3NvYy9pbXgv
S2NvbmZpZw0KaW5kZXggZDgwZjg5OS4uYTQzNTNmOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29j
L2lteC9LY29uZmlnDQorKysgYi9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZw0KQEAgLTcsNCArNyw4
IEBAIGNvbmZpZyBJTVhfR1BDVjJfUE1fRE9NQUlOUw0KIAlzZWxlY3QgUE1fR0VORVJJQ19ET01B
SU5TDQogCWRlZmF1bHQgeSBpZiBTT0NfSU1YN0QNCiANCitjb25maWcgSU1YOF9TT0MNCisJYm9v
bCAiaS5NWDggU29DIGRyaXZlciINCisJZGVwZW5kcyBvbiBBUkNIX01YQyAmJiBJTVhfU0NVDQor
DQogZW5kbWVudQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZSBiL2RyaXZl
cnMvc29jL2lteC9NYWtlZmlsZQ0KaW5kZXggZDZiNTI5ZTAuLjViZjIzZjggMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvc29jL2lteC9NYWtlZmls
ZQ0KQEAgLTEsMyArMSwzIEBADQogb2JqLSQoQ09ORklHX0hBVkVfSU1YX0dQQykgKz0gZ3BjLm8N
CiBvYmotJChDT05GSUdfSU1YX0dQQ1YyX1BNX0RPTUFJTlMpICs9IGdwY3YyLm8NCi1vYmotJChD
T05GSUdfQVJDSF9NWEMpICs9IHNvYy1pbXg4Lm8NCitvYmotJChDT05GSUdfSU1YOF9TT0MpICs9
IHNvYy1pbXg4Lm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYyBiL2Ry
aXZlcnMvc29jL2lteC9zb2MtaW14OC5jDQppbmRleCBmYzY0MjlmLi4zYWQwYjFjIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMNCisrKyBiL2RyaXZlcnMvc29jL2lteC9z
b2MtaW14OC5jDQpAQCAtMyw4ICszLDExIEBADQogICogQ29weXJpZ2h0IDIwMTkgTlhQLg0KICAq
Lw0KIA0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPg0KKyNpbmNs
dWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4N
CiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNp
bmNsdWRlIDxsaW51eC9zeXNfc29jLmg+DQpAQCAtMTYsMTIgKzE5LDYxIEBADQogI2RlZmluZSBJ
TVg4TVFfU1dfSU5GT19CMQkJMHg0MA0KICNkZWZpbmUgSU1YOE1RX1NXX01BR0lDX0IxCQkweGZm
MDA1NWFhDQogDQorI2RlZmluZSBJTVg4X1NPQ19EUklWRVJfTkFNRQkJImlteDgtc29jIg0KKw0K
K3N0YXRpYyBzdHJ1Y3QgaW14X3NjX2lwYyAqc29jX2lwY19oYW5kbGU7DQorc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKmlteDhfc29jX3BkZXY7DQorDQorc3RydWN0IGlteF9zY19tc2df
bWlzY19nZXRfc29jX2lkIHsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCisJdW5pb24g
ew0KKwkJc3RydWN0IHsNCisJCQl1MzIgY29udHJvbDsNCisJCQl1MTYgcmVzb3VyY2U7DQorCQl9
IHNlbmQ7DQorCQlzdHJ1Y3Qgew0KKwkJCXUzMiBpZDsNCisJCQl1MTYgcmVzZXJ2ZWQ7DQorCQl9
IHJlc3A7DQorCX0gZGF0YTsNCit9Ow0KKw0KIHN0cnVjdCBpbXg4X3NvY19kYXRhIHsNCiAJY2hh
ciAqbmFtZTsNCiAJdTMyICgqc29jX3JldmlzaW9uKSh2b2lkKTsNCisJYm9vbCBoYXZlX2lteF9z
Y3U7DQogfTsNCiANCi1zdGF0aWMgdTMyIF9faW5pdCBpbXg4bXFfc29jX3JldmlzaW9uKHZvaWQp
DQorc3RhdGljIHUzMiBpbXg4cXhwX3NvY19yZXZpc2lvbih2b2lkKQ0KK3sNCisJc3RydWN0IGlt
eF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnICpo
ZHIgPSAmbXNnLmhkcjsNCisJdTMyIHJldiA9IDA7DQorCWludCByZXQ7DQorDQorCWhkci0+dmVy
ID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX01JU0M7
DQorCWhkci0+ZnVuYyA9IElNWF9TQ19NSVNDX0ZVTkNfR0VUX0NPTlRST0w7DQorCWhkci0+c2l6
ZSA9IDM7DQorDQorCW1zZy5kYXRhLnNlbmQuY29udHJvbCA9IElNWF9TQ19DX0lEOw0KKwltc2cu
ZGF0YS5zZW5kLnJlc291cmNlID0gSU1YX1NDX1JfU1lTVEVNOw0KKw0KKwlyZXQgPSBpbXhfc2N1
X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCisJaWYgKHJldCkgew0KKwkJ
ZGV2X2VycigmaW14OF9zb2NfcGRldi0+ZGV2LA0KKwkJCSJtaXNjIGdldCBjb250cm9sIGZhaWxl
ZCwgcmV0ICVkXG4iLCByZXQpOw0KKwkJcmV0dXJuIHJldjsNCisJfQ0KKw0KKwkvKiBmb3JtYXQg
cmV2aXNpb24gdmFsdWUgcGFzc2VkIGZyb20gU0NVIGZpcm13YXJlICovDQorCXJldiA9IChtc2cu
ZGF0YS5yZXNwLmlkID4+IDUpICYgMHhmOw0KKwlyZXYgPSAoKChyZXYgPj4gMikgKyAxKSA8PCA0
KSB8IChyZXYgJiAweDMpOw0KKw0KKwlyZXR1cm4gcmV2Ow0KK30NCisNCitzdGF0aWMgdTMyIGlt
eDhtcV9zb2NfcmV2aXNpb24odm9pZCkNCiB7DQogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQog
CXZvaWQgX19pb21lbSAqb2NvdHBfYmFzZTsNCkBAIC00OSwxMCArMTAxLDE4IEBAIHN0YXRpYyB1
MzIgX19pbml0IGlteDhtcV9zb2NfcmV2aXNpb24odm9pZCkNCiBzdGF0aWMgY29uc3Qgc3RydWN0
IGlteDhfc29jX2RhdGEgaW14OG1xX3NvY19kYXRhID0gew0KIAkubmFtZSA9ICJpLk1YOE1RIiwN
CiAJLnNvY19yZXZpc2lvbiA9IGlteDhtcV9zb2NfcmV2aXNpb24sDQorCS5oYXZlX2lteF9zY3Ug
PSBmYWxzZSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW14OF9zb2NfZGF0YSBpbXg4
cXhwX3NvY19kYXRhID0gew0KKwkubmFtZSA9ICJpLk1YOFFYUCIsDQorCS5zb2NfcmV2aXNpb24g
PSBpbXg4cXhwX3NvY19yZXZpc2lvbiwNCisJLmhhdmVfaW14X3NjdSA9IHRydWUsDQogfTsNCiAN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXg4X3NvY19tYXRjaFtdID0gew0K
IAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bXEiLCAuZGF0YSA9ICZpbXg4bXFfc29jX2RhdGEs
IH0sDQorCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAiLCAuZGF0YSA9ICZpbXg4cXhwX3Nv
Y19kYXRhLCB9LA0KIAl7IH0NCiB9Ow0KIA0KQEAgLTYxLDcgKzEyMSw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteDhfc29jX21hdGNoW10gPSB7DQogCWthc3ByaW50ZihH
RlBfS0VSTkVMLCAiJWQuJWQiLCAoc29jX3JldiA+PiA0KSAmIDB4ZiwgIHNvY19yZXYgJiAweGYp
IDogXA0KIAkidW5rbm93biINCiANCi1zdGF0aWMgaW50IF9faW5pdCBpbXg4X3NvY19pbml0KHZv
aWQpDQorc3RhdGljIGludCBpbXg4X3NvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIHsNCiAJc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICpzb2NfZGV2X2F0dHI7DQog
CXN0cnVjdCBzb2NfZGV2aWNlICpzb2NfZGV2Ow0KQEAgLTgzLDI1ICsxNDMsMzcgQEAgc3RhdGlj
IGludCBfX2luaXQgaW14OF9zb2NfaW5pdCh2b2lkKQ0KIAkJZ290byBmcmVlX3NvYzsNCiANCiAJ
aWQgPSBvZl9tYXRjaF9ub2RlKGlteDhfc29jX21hdGNoLCByb290KTsNCi0JaWYgKCFpZCkNCisJ
aWYgKCFpZCkgew0KKwkJcmV0ID0gLUVOT0RFVjsNCiAJCWdvdG8gZnJlZV9zb2M7DQorCX0NCiAN
CiAJb2Zfbm9kZV9wdXQocm9vdCk7DQogDQogCWRhdGEgPSBpZC0+ZGF0YTsNCiAJaWYgKGRhdGEp
IHsNCisJCWlmIChkYXRhLT5oYXZlX2lteF9zY3UpIHsNCisJCQlyZXQgPSBpbXhfc2N1X2dldF9o
YW5kbGUoJnNvY19pcGNfaGFuZGxlKTsNCisJCQlpZiAocmV0KQ0KKwkJCQlnb3RvIGZyZWVfc29j
Ow0KKwkJfQ0KKw0KIAkJc29jX2Rldl9hdHRyLT5zb2NfaWQgPSBkYXRhLT5uYW1lOw0KIAkJaWYg
KGRhdGEtPnNvY19yZXZpc2lvbikNCiAJCQlzb2NfcmV2ID0gZGF0YS0+c29jX3JldmlzaW9uKCk7
DQogCX0NCiANCiAJc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA9IGlteDhfcmV2aXNpb24oc29jX3Jl
dik7DQotCWlmICghc29jX2Rldl9hdHRyLT5yZXZpc2lvbikNCisJaWYgKCFzb2NfZGV2X2F0dHIt
PnJldmlzaW9uKSB7DQorCQlyZXQgPSAtRU5PREVWOw0KIAkJZ290byBmcmVlX3NvYzsNCisJfQ0K
IA0KIAlzb2NfZGV2ID0gc29jX2RldmljZV9yZWdpc3Rlcihzb2NfZGV2X2F0dHIpOw0KLQlpZiAo
SVNfRVJSKHNvY19kZXYpKQ0KKwlpZiAoSVNfRVJSKHNvY19kZXYpKSB7DQorCQlyZXQgPSAtRU5P
REVWOw0KIAkJZ290byBmcmVlX3JldjsNCisJfQ0KIA0KIAlyZXR1cm4gMDsNCiANCkBAIC0xMTAs
NiArMTgyLDQ2IEBAIHN0YXRpYyBpbnQgX19pbml0IGlteDhfc29jX2luaXQodm9pZCkNCiBmcmVl
X3NvYzoNCiAJa2ZyZWUoc29jX2Rldl9hdHRyKTsNCiAJb2Zfbm9kZV9wdXQocm9vdCk7DQotCXJl
dHVybiAtRU5PREVWOw0KKwlyZXR1cm4gcmV0Ow0KIH0NCi1kZXZpY2VfaW5pdGNhbGwoaW14OF9z
b2NfaW5pdCk7DQorDQorc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14OF9zb2NfZHJp
dmVyID0gew0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSBJTVg4X1NPQ19EUklWRVJfTkFNRSwN
CisJfSwNCisJLnByb2JlID0gaW14OF9zb2NfcHJvYmUsDQorfTsNCisNCitzdGF0aWMgaW50IF9f
aW5pdCBpbXg4X3NvY19pbml0KHZvaWQpDQorew0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBwbGF0
Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmlteDhfc29jX2RyaXZlcik7DQorCWlmIChyZXQpDQorCQly
ZXR1cm4gcmV0Ow0KKw0KKwlpbXg4X3NvY19wZGV2ID0NCisJCXBsYXRmb3JtX2RldmljZV9yZWdp
c3Rlcl9zaW1wbGUoSU1YOF9TT0NfRFJJVkVSX05BTUUsDQorCQkJCQkJLTEsDQorCQkJCQkJTlVM
TCwNCisJCQkJCQkwKTsNCisJaWYgKElTX0VSUihpbXg4X3NvY19wZGV2KSkgew0KKwkJcmV0ID0g
UFRSX0VSUihpbXg4X3NvY19wZGV2KTsNCisJCWdvdG8gdW5yZWdfcGxhdGZvcm1fZHJpdmVyOw0K
Kwl9DQorDQorCXJldHVybiAwOw0KKw0KK3VucmVnX3BsYXRmb3JtX2RyaXZlcjoNCisJcGxhdGZv
cm1fZHJpdmVyX3VucmVnaXN0ZXIoJmlteDhfc29jX2RyaXZlcik7DQorCXJldHVybiByZXQ7DQor
fQ0KKw0KK3N0YXRpYyB2b2lkIF9fZXhpdCBpbXg4X3NvY19leGl0KHZvaWQpDQorew0KKwlwbGF0
Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihpbXg4X3NvY19wZGV2KTsNCisJcGxhdGZvcm1fZHJpdmVy
X3VucmVnaXN0ZXIoJmlteDhfc29jX2RyaXZlcik7DQorfQ0KKw0KK21vZHVsZV9pbml0KGlteDhf
c29jX2luaXQpOw0KK21vZHVsZV9leGl0KGlteDhfc29jX2V4aXQpOw0KLS0gDQoyLjcuNA0KDQo=
