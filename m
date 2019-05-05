Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA91C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A93206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IXiYZQT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfEEN2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:28:23 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:29022
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEEN2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7IpHhxDHFhbinA9GdFxWj12hZtsdgry8kW3W6c6xck=;
 b=IXiYZQT/KubqARQb7bftcOI1SXrVY3CP7AUkbzUz61wTmXEqZUKI2xi3ocEzLe/Gw1lR/JuKnPGdlPrdqN4H2GPXYNkEiFK97TYB8YOnVMWFIupZK7S6Sy8K2gEHNKaf53NIfhDGIPnB8GwKjK787CQD51JsdyU1JqKembzCy8s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 13:28:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 13:28:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVA0ZmyuV26b+HdU+wzmbIrs3FtA==
Date:   Sun, 5 May 2019 13:28:17 +0000
Message-ID: <20190505134130.28071-2-peng.fan@nxp.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d64af35-bd01-42d5-5388-08d6d15d8862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4259;
x-ms-traffictypediagnostic: AM0PR04MB4259:
x-microsoft-antispam-prvs: <AM0PR04MB4259E46B5B8BB0920B15196588370@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(486006)(54906003)(110136005)(68736007)(446003)(2906002)(11346002)(476003)(2616005)(8936002)(8676002)(66066001)(81166006)(7416002)(7736002)(305945005)(44832011)(53936002)(36756003)(50226002)(4326008)(25786009)(86362001)(2201001)(1076003)(5660300002)(81156014)(52116002)(99286004)(76176011)(102836004)(316002)(6506007)(3846002)(6116002)(386003)(478600001)(256004)(14444005)(6512007)(71200400001)(14454004)(6486002)(6436002)(2501003)(66946007)(73956011)(186003)(71190400001)(66446008)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vdXR6lOafMzZV0TvwuVHXOmEpInsRgX6wPGqgAnTOa21jAkVdZ9OcwLF9kERf+Sis7wVmzfIwlXikY+ZdV7fQUA6Lm1Goqj0eUcHfrReDSOK3yLb7AvJIT0zd5Ip7xFywMewm0ofGSPgZ1rZjP/3LZIf+v1d2I0qLMhAGqqh2efIuLochqFghpRdaocyT4xoS4n2WstT3PIJQXBHxDkSWeZ5560ZS/ndKw5uAsyjrj71sGsjZ7FX8hZiSfuqW7jMgxFsd6Tyr50Go9+osBudbI18Cqt8PN2nmlLUz5c+xhtRZyBbJC1gRU5b1cFhnhRf6Q+SyLZSEQdR5a6gD7uhCxftrvZFAEd2KeJkQU3U7OHhvrVLhK7k3kpss6C7g8DuZxszWUZy3rYuy76UDZr8bYDRmoLIYSfu+yQm6bicn50=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d64af35-bd01-42d5-5388-08d6d15d8862
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 13:28:17.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg4IG52bWVtIG9jb3RwIGRyaXZlciB0byBhY2Nlc3MgZnVzZSB2
aWENClJQQyB0byBpLk1YOCBzeXN0ZW0gY29udHJvbGxlci4NCg0KU2lnbmVkLW9mZi1ieTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQpDYzogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2
YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnPg0KQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz4NCkNjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQpDYzogUGVu
Z3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4NCkNjOiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQpDYzogTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlt
eEBueHAuY29tPg0KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KLS0t
DQogZHJpdmVycy9udm1lbS9LY29uZmlnICAgICAgICAgfCAgIDcgKysrDQogZHJpdmVycy9udm1l
bS9NYWtlZmlsZSAgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5j
IHwgMTM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMgZmls
ZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vS2Nv
bmZpZyBiL2RyaXZlcnMvbnZtZW0vS2NvbmZpZw0KaW5kZXggNTMwZDU3MDcyNGM5Li4wZTcwNWMw
NGJkOGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWVtL0tjb25maWcNCisrKyBiL2RyaXZlcnMv
bnZtZW0vS2NvbmZpZw0KQEAgLTM2LDYgKzM2LDEzIEBAIGNvbmZpZyBOVk1FTV9JTVhfT0NPVFAN
CiAJICBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYgc28sIHRo
ZSBtb2R1bGUNCiAJICB3aWxsIGJlIGNhbGxlZCBudm1lbS1pbXgtb2NvdHAuDQogDQorY29uZmln
IE5WTUVNX0lNWF9PQ09UUF9TQ1UNCisJdHJpc3RhdGUgImkuTVg4IE9uLUNoaXAgT1RQIENvbnRy
b2xsZXIgc3VwcG9ydCINCisJZGVwZW5kcyBvbiBJTVhfU0NVDQorCWhlbHANCisJICBUaGlzIGlz
IGEgZHJpdmVyIGZvciB0aGUgT24tQ2hpcCBPVFAgQ29udHJvbGxlciAoT0NPVFApDQorCSAgYXZh
aWxhYmxlIG9uIGkuTVg4IFNvQ3MuDQorDQogY29uZmlnIE5WTUVNX0xQQzE4WFhfRUVQUk9NDQog
CXRyaXN0YXRlICJOWFAgTFBDMThYWCBFRVBST00gTWVtb3J5IFN1cHBvcnQiDQogCWRlcGVuZHMg
b24gQVJDSF9MUEMxOFhYIHx8IENPTVBJTEVfVEVTVA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZW0vTWFrZWZpbGUgYi9kcml2ZXJzL252bWVtL01ha2VmaWxlDQppbmRleCAyZWNlOGZmZmZkZGEu
LjMwZDY1M2QzNGU1NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUNCisrKyBi
L2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUNCkBAIC0xMyw2ICsxMyw4IEBAIG9iai0kKENPTkZJR19O
Vk1FTV9JTVhfSUlNKQkrPSBudm1lbS1pbXgtaWltLm8NCiBudm1lbS1pbXgtaWltLXkJCQk6PSBp
bXgtaWltLm8NCiBvYmotJChDT05GSUdfTlZNRU1fSU1YX09DT1RQKQkrPSBudm1lbS1pbXgtb2Nv
dHAubw0KIG52bWVtLWlteC1vY290cC15CQk6PSBpbXgtb2NvdHAubw0KK29iai0kKENPTkZJR19O
Vk1FTV9JTVhfT0NPVFBfU0NVKQkrPSBudm1lbS1pbXgtb2NvdHAtc2N1Lm8NCitudm1lbS1pbXgt
b2NvdHAtc2N1LXkJCTo9IGlteC1vY290cC1zY3Uubw0KIG9iai0kKENPTkZJR19OVk1FTV9MUEMx
OFhYX0VFUFJPTSkJKz0gbnZtZW1fbHBjMTh4eF9lZXByb20ubw0KIG52bWVtX2xwYzE4eHhfZWVw
cm9tLXkJOj0gbHBjMTh4eF9lZXByb20ubw0KIG9iai0kKENPTkZJR19OVk1FTV9MUEMxOFhYX09U
UCkJKz0gbnZtZW1fbHBjMTh4eF9vdHAubw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vaW14
LW9jb3RwLXNjdS5jIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLjA3ZTFlYmEzODVhYw0KLS0tIC9kZXYvbnVs
bA0KKysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCkBAIC0wLDAgKzEsMTM1IEBA
DQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyoNCisgKiBpLk1YOCBP
Q09UUCBmdXNlYm94IGRyaXZlcg0KKyAqDQorICogQ29weXJpZ2h0IDIwMTkgTlhQDQorICoNCisg
KiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCisgKi8NCisNCisjaW5jbHVkZSA8bGludXgv
ZmlybXdhcmUvaW14L3NjaS5oPg0KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVk
ZSA8bGludXgvbnZtZW0tcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+
DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9z
bGFiLmg+DQorDQorZW51bSBvY290cF9kZXZ0eXBlIHsNCisJSU1YOFFYUCwNCit9Ow0KKw0KK3N0
cnVjdCBvY290cF9kZXZ0eXBlX2RhdGEgew0KKwlpbnQgZGV2dHlwZTsNCisJaW50IG5yZWdzOw0K
K307DQorDQorc3RydWN0IG9jb3RwX3ByaXYgew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQorCWNv
bnN0IHN0cnVjdCBvY290cF9kZXZ0eXBlX2RhdGEgKmRhdGE7DQorCXN0cnVjdCBpbXhfc2NfaXBj
ICpudm1lbV9pcGM7DQorfTsNCisNCitzdGF0aWMgc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSBp
bXg4cXhwX2RhdGEgPSB7DQorCS5kZXZ0eXBlID0gSU1YOFFYUCwNCisJLm5yZWdzID0gODAwLA0K
K307DQorDQorc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3JlYWQodm9pZCAqY29udGV4dCwgdW5z
aWduZWQgaW50IG9mZnNldCwNCisJCQkgICAgICB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCit7
DQorCXN0cnVjdCBvY290cF9wcml2ICpwcml2ID0gY29udGV4dDsNCisJdTMyIGNvdW50LCBpbmRl
eCwgbnVtX2J5dGVzOw0KKwl1OCAqYnVmLCAqcDsNCisJaW50IGksIHJldDsNCisNCisJaW5kZXgg
PSBvZmZzZXQgPj4gMjsNCisJbnVtX2J5dGVzID0gcm91bmRfdXAoKG9mZnNldCAlIDQpICsgYnl0
ZXMsIDQpOw0KKwljb3VudCA9IG51bV9ieXRlcyA+PiAyOw0KKw0KKwlpZiAoY291bnQgPiAocHJp
di0+ZGF0YS0+bnJlZ3MgLSBpbmRleCkpDQorCQljb3VudCA9IHByaXYtPmRhdGEtPm5yZWdzIC0g
aW5kZXg7DQorDQorCXAgPSBremFsbG9jKG51bV9ieXRlcywgR0ZQX0tFUk5FTCk7DQorCWlmICgh
cCkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlidWYgPSBwOw0KKw0KKwlmb3IgKGkgPSBpbmRl
eDsgaSA8IChpbmRleCArIGNvdW50KTsgaSsrKSB7DQorCQlpZiAocHJpdi0+ZGF0YS0+ZGV2dHlw
ZSA9PSBJTVg4UVhQKSB7DQorCQkJaWYgKChpID4gMjcxKSAmJiAoaSA8IDU0NCkpIHsNCisJCQkJ
Kih1MzIgKilidWYgPSAwOw0KKwkJCQlidWYgKz0gNDsNCisJCQkJY29udGludWU7DQorCQkJfQ0K
KwkJfQ0KKw0KKwkJcmV0ID0gaW14X3NjX21pc2Nfb3RwX2Z1c2VfcmVhZChwcml2LT5udm1lbV9p
cGMsIGksDQorCQkJCQkJKHUzMiAqKWJ1Zik7DQorCQlpZiAocmV0KSB7DQorCQkJa2ZyZWUocCk7
DQorCQkJcmV0dXJuIHJldDsNCisJCX0NCisJCWJ1ZiArPSA0Ow0KKwl9DQorDQorCWluZGV4ID0g
b2Zmc2V0ICUgNDsNCisJbWVtY3B5KHZhbCwgJnBbaW5kZXhdLCBieXRlcyk7DQorDQorCWtmcmVl
KHApOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHN0cnVjdCBudm1lbV9jb25maWcg
aW14X3NjdV9vY290cF9udm1lbV9jb25maWcgPSB7DQorCS5uYW1lID0gImlteC1vY290cCIsDQor
CS5yZWFkX29ubHkgPSB0cnVlLA0KKwkud29yZF9zaXplID0gNCwNCisJLnN0cmlkZSA9IDEsDQor
CS5vd25lciA9IFRISVNfTU9EVUxFLA0KKwkucmVnX3JlYWQgPSBpbXhfc2N1X29jb3RwX3JlYWQs
DQorfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhfc2N1X29jb3Rw
X2R0X2lkc1tdID0gew0KKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLW9jb3RwIiwgKHZv
aWQgKikmaW14OHF4cF9kYXRhIH0sDQorCXsgfSwNCit9Ow0KK01PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIGlteF9zY3Vfb2NvdHBfZHRfaWRzKTsNCisNCitzdGF0aWMgaW50IGlteF9zY3Vfb2NvdHBf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7DQorCXN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQorCXN0cnVjdCBvY290cF9wcml2ICpwcml2Ow0KKwlzdHJ1Y3Qg
bnZtZW1fZGV2aWNlICpudm1lbTsNCisJaW50IHJldDsNCisNCisJcHJpdiA9IGRldm1fa3phbGxv
YyhkZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KKwlpZiAoIXByaXYpDQorCQlyZXR1
cm4gLUVOT01FTTsNCisNCisJcmV0ID0gaW14X3NjdV9nZXRfaGFuZGxlKCZwcml2LT5udm1lbV9p
cGMpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJcHJpdi0+ZGF0YSA9IG9mX2Rl
dmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KKwlwcml2LT5kZXYgPSBkZXY7DQorCWlteF9zY3Vf
b2NvdHBfbnZtZW1fY29uZmlnLnNpemUgPSA0ICogcHJpdi0+ZGF0YS0+bnJlZ3M7DQorCWlteF9z
Y3Vfb2NvdHBfbnZtZW1fY29uZmlnLmRldiA9IGRldjsNCisJaW14X3NjdV9vY290cF9udm1lbV9j
b25maWcucHJpdiA9IHByaXY7DQorCW52bWVtID0gZGV2bV9udm1lbV9yZWdpc3RlcihkZXYsICZp
bXhfc2N1X29jb3RwX252bWVtX2NvbmZpZyk7DQorDQorCXJldHVybiBQVFJfRVJSX09SX1pFUk8o
bnZtZW0pOw0KK30NCisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2N1X29j
b3RwX2RyaXZlciA9IHsNCisJLnByb2JlCT0gaW14X3NjdV9vY290cF9wcm9iZSwNCisJLmRyaXZl
ciA9IHsNCisJCS5uYW1lCT0gImlteF9zY3Vfb2NvdHAiLA0KKwkJLm9mX21hdGNoX3RhYmxlID0g
aW14X3NjdV9vY290cF9kdF9pZHMsDQorCX0sDQorfTsNCittb2R1bGVfcGxhdGZvcm1fZHJpdmVy
KGlteF9zY3Vfb2NvdHBfZHJpdmVyKTsNCisNCitNT0RVTEVfQVVUSE9SKCJQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4iKTsNCitNT0RVTEVfREVTQ1JJUFRJT04oImkuTVg4UU0gT0NPVFAgZnVz
ZSBib3ggZHJpdmVyIik7DQorTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KLS0gDQoyLjE2LjQN
Cg0K
