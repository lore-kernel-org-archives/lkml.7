Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9FC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034BA2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R+M2Dzzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEEGTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:19:07 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:46711
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfEEGTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLTcXIF5q0jcu7mUu5dJevpTDo1M7PLHmmE7VlAybHM=;
 b=R+M2DzzmppPM9osM0jt9kKGjEEvhoVG1TIGRuh1wUWQJAn8gtkIKU7yzlWruKmzjsqw0K8AAh/LvELxZ4yc3jQAxiQaLcvG7na2TZtRs3VdoQNYy567wdW4IijSGPmhoMXa7Tz432Kh14t3WsR9LDq36ZWfQ/Bli6cAVI1mOj38=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 06:18:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:18:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "pp@emlix.com" <pp@emlix.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for masking
 MMDC channel
Thread-Topic: [PATCH 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for
 masking MMDC channel
Thread-Index: AQHVAwpq3WdYtTz4rkK30M4PU6T31A==
Date:   Sun, 5 May 2019 06:18:54 +0000
Message-ID: <1557036830-13567-2-git-send-email-Anson.Huang@nxp.com>
References: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22779d57-d265-4c0c-03b6-08d6d1218cb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB394790B69221433720005461F5370@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(486006)(36756003)(7736002)(186003)(7416002)(52116002)(110136005)(11346002)(2616005)(476003)(99286004)(256004)(446003)(50226002)(86362001)(81166006)(5660300002)(8676002)(81156014)(76176011)(2906002)(71200400001)(71190400001)(102836004)(26005)(305945005)(8936002)(6506007)(386003)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(2201001)(6436002)(316002)(3846002)(53936002)(478600001)(6116002)(6512007)(25786009)(14454004)(68736007)(6486002)(4326008)(2501003)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1t8EwvapNDtudr7Lr4rdDgl70Oah8nal2NlVwoxOtyOnSr7XsV8w4IxiuW2dj60I7p0oi5oOUOl+queRA42NwpRlIfK2gQcwlpK8J1ZatsMSK1dMdHPfmWD5AqcI83aX1+vpvO2BsPS3AIzZws5QluIJTClylllN9Hb6cwTq8KdyvM8IM+MCh4gq8uMe8X9SFSeOrhQFqx/PAqX+gYXESac8bvjHVnK6uLRZpF8qSrx3NZDEU/Mf4o3JOsn4aptJRu0Dn7Gi1RFfgG4M289lRyFzn64RNWe6/oAP+0akaGsWaukdxMrsYbUeq+SKfWmGTw/RbzA5TV3v3mtIeK7AQk+WPtp7oHG5H0q0LiC5Pj9Bp2eutKPeI1lSFJid6AmJnMhNxkb7K9y1SJ5WFu9mSr4H046ZxVDwo4TLlO66FhA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22779d57-d265-4c0c-03b6-08d6d1218cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:18:54.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGlteF9tbWRjX21hc2tfaGFuZHNoYWtlKCkgQVBJIGluc3RlYWQgb2YgcHJvZ3JhbW1pbmcg
Q0NNDQpyZWdpc3RlciBkaXJlY3RseSBpbiBlYWNoIHBsYXRmb3JtIHRvIG1hc2sgdW51c2VkIE1N
REMgY2hhbm5lbCdzDQpoYW5kc2hha2UuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2cS5jICAg
fCAxMyArLS0tLS0tLS0tLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2c2wuYyAgfCAgNSAr
LS0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsbC5jIHwgIDMgKy0tDQogZHJpdmVycy9j
bGsvaW14L2Nsay1pbXg2c3guYyAgfCAgNSArLS0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGstaW14
NnVsLmMgIHwgIDUgKy0tLS0NCiA1IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMjYg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZxLmMg
Yi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZxLmMNCmluZGV4IDcwOGU3YzUuLjA3NzI3NmIgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZxLmMNCisrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14NnEuYw0KQEAgLTI2MCwyNSArMjYwLDE0IEBAIHN0YXRpYyBib29sIHBsbDZf
YnlwYXNzZWQoc3RydWN0IGRldmljZV9ub2RlICpub2RlKQ0KIAlyZXR1cm4gZmFsc2U7DQogfQ0K
IA0KLSNkZWZpbmUgQ0NNX0NDRFIJCTB4MDQNCiAjZGVmaW5lIENDTV9DQ1NSCQkweDBjDQogI2Rl
ZmluZSBDQ01fQ1MyQ0RSCQkweDJjDQogDQotI2RlZmluZSBDQ0RSX01NRENfQ0gxX01BU0sJCUJJ
VCgxNikNCiAjZGVmaW5lIENDU1JfUExMM19TV19DTEtfU0VMCQlCSVQoMCkNCiANCiAjZGVmaW5l
IENTMkNEUl9MREJfREkwX0NMS19TRUxfU0hJRlQJOQ0KICNkZWZpbmUgQ1MyQ0RSX0xEQl9ESTFf
Q0xLX1NFTF9TSElGVAkxMg0KIA0KLXN0YXRpYyB2b2lkIF9faW5pdCBpbXg2cV9tbWRjX2NoMV9t
YXNrX2hhbmRzaGFrZSh2b2lkIF9faW9tZW0gKmNjbV9iYXNlKQ0KLXsNCi0JdW5zaWduZWQgaW50
IHJlZzsNCi0NCi0JcmVnID0gcmVhZGxfcmVsYXhlZChjY21fYmFzZSArIENDTV9DQ0RSKTsNCi0J
cmVnIHw9IENDRFJfTU1EQ19DSDFfTUFTSzsNCi0Jd3JpdGVsX3JlbGF4ZWQocmVnLCBjY21fYmFz
ZSArIENDTV9DQ0RSKTsNCi19DQotDQogLyoNCiAgKiBUaGUgb25seSB3YXkgdG8gZGlzYWJsZSB0
aGUgTU1EQ19DSDEgY2xvY2sgaXMgdG8gbW92ZSBpdCB0byBwbGwzX3N3X2Nsaw0KICAqIHZpYSBw
ZXJpcGgyX2NsazJfc2VsIGFuZCB0aGVuIHRvIGRpc2FibGUgcGxsM19zd19jbGsgYnkgc2VsZWN0
aW5nIHRoZQ0KQEAgLTY1MSw3ICs2NDAsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW14NnFfY2xv
Y2tzX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpjY21fbm9kZSkNCiANCiAJZGlzYWJsZV9hbmF0
b3BfY2xvY2tzKGFuYXRvcF9iYXNlKTsNCiANCi0JaW14NnFfbW1kY19jaDFfbWFza19oYW5kc2hh
a2UoYmFzZSk7DQorCWlteF9tbWRjX21hc2tfaGFuZHNoYWtlKGJhc2UsIDEpOw0KIA0KIAlpZiAo
Y2xrX29uX2lteDZxcCgpKSB7DQogCQljbGtbSU1YNlFETF9DTEtfTERCX0RJMF9TRUxdICAgICAg
PSBpbXhfY2xrX211eF9mbGFncygibGRiX2RpMF9zZWwiLCBiYXNlICsgMHgyYywgOSwgIDMsIGxk
Yl9kaV9zZWxzLCAgICAgIEFSUkFZX1NJWkUobGRiX2RpX3NlbHMpLCBDTEtfU0VUX1JBVEVfUEFS
RU5UKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzbC5jIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg2c2wuYw0KaW5kZXggZTEzZDg4MS4uYWNiNTk4MyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14NnNsLmMNCkBAIC0xNyw4ICsxNyw2IEBADQogDQogI2luY2x1ZGUgImNsay5oIg0KIA0K
LSNkZWZpbmUgQ0NEUgkJCQkweDQNCi0jZGVmaW5lIEJNX0NDTV9DQ0RSX01NRENfQ0gwX01BU0sJ
KDEgPDwgMTcpDQogI2RlZmluZSBDQ1NSCQkJMHhjDQogI2RlZmluZSBCTV9DQ1NSX1BMTDFfU1df
Q0xLX1NFTAkoMSA8PCAyKQ0KICNkZWZpbmUgQ0FDUlIJCQkweDEwDQpAQCAtNDE0LDggKzQxMiw3
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbXg2c2xfY2xvY2tzX2luaXQoc3RydWN0IGRldmljZV9u
b2RlICpjY21fbm9kZSkNCiAJY2xrc1tJTVg2U0xfQ0xLX1VTREhDNF0gICAgICAgPSBpbXhfY2xr
X2dhdGUyKCJ1c2RoYzQiLCAgICAgICAidXNkaGM0X3BvZGYiLCAgICAgICBiYXNlICsgMHg4MCwg
OCk7DQogDQogCS8qIEVuc3VyZSB0aGUgTU1EQyBDSDAgaGFuZHNoYWtlIGlzIGJ5cGFzc2VkICov
DQotCXdyaXRlbF9yZWxheGVkKHJlYWRsX3JlbGF4ZWQoYmFzZSArIENDRFIpIHwNCi0JCUJNX0ND
TV9DQ0RSX01NRENfQ0gwX01BU0ssIGJhc2UgKyBDQ0RSKTsNCisJaW14X21tZGNfbWFza19oYW5k
c2hha2UoYmFzZSwgMCk7DQogDQogCWlteF9jaGVja19jbG9ja3MoY2xrcywgQVJSQVlfU0laRShj
bGtzKSk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2c2xsLmMgYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzbGwuYw0KaW5kZXggN2VlYTQ0OC4uM2FhNzFjOSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsbC5jDQorKysgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDZzbGwuYw0KQEAgLTE2LDcgKzE2LDYgQEANCiAjaW5jbHVkZSAiY2xrLmgi
DQogDQogI2RlZmluZSBDQ01fQU5BTE9HX1BMTF9CWVBBU1MJCSgweDEgPDwgMTYpDQotI2RlZmlu
ZSBCTV9DQ01fQ0NEUl9NTURDX0NIMF9NQVNLCSgweDIgPDwgMTYpDQogI2RlZmluZSB4UExMX0NM
UihvZmZzZXQpCQkob2Zmc2V0ICsgMHg4KQ0KIA0KIHN0YXRpYyBjb25zdCBjaGFyICpwbGxfYnlw
YXNzX3NyY19zZWxzW10gPSB7ICJvc2MiLCAiZHVtbXkiLCB9Ow0KQEAgLTM0MCw3ICszMzksNyBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgaW14NnNsbF9jbG9ja3NfaW5pdChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKmNjbV9ub2RlKQ0KIAljbGtzW0lNWDZTTExfQ0xLX1VTREhDM10JPSBpbXhfY2xrX2dhdGUy
KCJ1c2RoYzMiLCAidXNkaGMzX3BvZGYiLCAgYmFzZSArIDB4ODAsCTYpOw0KIA0KIAkvKiBtYXNr
IGhhbmRzaGFrZSBvZiBtbWRjICovDQotCXdyaXRlbF9yZWxheGVkKEJNX0NDTV9DQ0RSX01NRENf
Q0gwX01BU0ssIGJhc2UgKyAweDQpOw0KKwlpbXhfbW1kY19tYXNrX2hhbmRzaGFrZShiYXNlLCAw
KTsNCiANCiAJaW14X2NoZWNrX2Nsb2NrcyhjbGtzLCBBUlJBWV9TSVpFKGNsa3MpKTsNCiANCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzeC5jIGIvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg2c3guYw0KaW5kZXggOTE1NThiMC4uMjRmN2I0ZCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14NnN4LmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnN4
LmMNCkBAIC0yMiw5ICsyMiw2IEBADQogDQogI2luY2x1ZGUgImNsay5oIg0KIA0KLSNkZWZpbmUg
Q0NEUiAgICAweDQNCi0jZGVmaW5lIEJNX0NDTV9DQ0RSX01NRENfQ0gwX01BU0sgICAgICAgKDB4
MiA8PCAxNikNCi0NCiBzdGF0aWMgY29uc3QgY2hhciAqc3RlcF9zZWxzW10JCT0geyAib3NjIiwg
InBsbDJfcGZkMl8zOTZtIiwgfTsNCiBzdGF0aWMgY29uc3QgY2hhciAqcGxsMV9zd19zZWxzW10J
PSB7ICJwbGwxX3N5cyIsICJzdGVwIiwgfTsNCiBzdGF0aWMgY29uc3QgY2hhciAqcGVyaXBoX3By
ZV9zZWxzW10JPSB7ICJwbGwyX2J1cyIsICJwbGwyX3BmZDJfMzk2bSIsICJwbGwyX3BmZDBfMzUy
bSIsICJwbGwyXzE5OG0iLCB9Ow0KQEAgLTQ4OCw3ICs0ODUsNyBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQgaW14NnN4X2Nsb2Nrc19pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2NtX25vZGUpDQogCWNs
a3NbSU1YNlNYX0NMS19DS08yXSAgICAgICAgID0gaW14X2Nsa19nYXRlKCJja28yIiwgICAgICAg
ICAgICJja28yX3BvZGYiLCAgICAgICAgIGJhc2UgKyAweDYwLCAyNCk7DQogDQogCS8qIG1hc2sg
aGFuZHNoYWtlIG9mIG1tZGMgKi8NCi0Jd3JpdGVsX3JlbGF4ZWQoQk1fQ0NNX0NDRFJfTU1EQ19D
SDBfTUFTSywgYmFzZSArIENDRFIpOw0KKwlpbXhfbW1kY19tYXNrX2hhbmRzaGFrZShiYXNlLCAw
KTsNCiANCiAJaW14X2NoZWNrX2Nsb2NrcyhjbGtzLCBBUlJBWV9TSVpFKGNsa3MpKTsNCiANCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZ1bC5jIGIvZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg2dWwuYw0KaW5kZXggZmQ2MGQxNS4uNGJmMzIyNiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14NnVsLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnVs
LmMNCkBAIC0yMiw5ICsyMiw2IEBADQogDQogI2luY2x1ZGUgImNsay5oIg0KIA0KLSNkZWZpbmUg
Qk1fQ0NNX0NDRFJfTU1EQ19DSDBfTUFTSwkoMHgyIDw8IDE2KQ0KLSNkZWZpbmUgQ0NEUgkweDQN
Ci0NCiBzdGF0aWMgY29uc3QgY2hhciAqcGxsX2J5cGFzc19zcmNfc2Vsc1tdID0geyAib3NjIiwg
ImR1bW15IiwgfTsNCiBzdGF0aWMgY29uc3QgY2hhciAqcGxsMV9ieXBhc3Nfc2Vsc1tdID0geyAi
cGxsMSIsICJwbGwxX2J5cGFzc19zcmMiLCB9Ow0KIHN0YXRpYyBjb25zdCBjaGFyICpwbGwyX2J5
cGFzc19zZWxzW10gPSB7ICJwbGwyIiwgInBsbDJfYnlwYXNzX3NyYyIsIH07DQpAQCAtNDY0LDcg
KzQ2MSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbXg2dWxfY2xvY2tzX2luaXQoc3RydWN0IGRl
dmljZV9ub2RlICpjY21fbm9kZSkNCiAJY2xrc1tJTVg2VUxfQ0xLX0NLTzJdCQk9IGlteF9jbGtf
Z2F0ZSgiY2tvMiIsCQkiY2tvMl9wb2RmIiwJIGJhc2UgKyAweDYwLAkyNCk7DQogDQogCS8qIG1h
c2sgaGFuZHNoYWtlIG9mIG1tZGMgKi8NCi0Jd3JpdGVsX3JlbGF4ZWQoQk1fQ0NNX0NDRFJfTU1E
Q19DSDBfTUFTSywgYmFzZSArIENDRFIpOw0KKwlpbXhfbW1kY19tYXNrX2hhbmRzaGFrZShiYXNl
LCAwKTsNCiANCiAJaW14X2NoZWNrX2Nsb2NrcyhjbGtzLCBBUlJBWV9TSVpFKGNsa3MpKTsNCiAN
Ci0tIA0KMi43LjQNCg0K
