Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A974C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAA821019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nle6OdqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfEHC4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:56:12 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:39299
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hFFxNgh5ARUbIYzJoJMVIljXfcRYd+7pJihQpGmD4U=;
 b=Nle6OdqBWP/9Df9+vGgSHt7mSj3daihc++NUg0oQcUd+nkrKDc+EvogHPAOnAVIBuoJnX00KGO756po7WqXUpeC5Hrf9KW9jdoRNX7UfOFwaPbfiSRK4c0mljFxNle7xeDmQYKYpdpSpB97T9v8TAIPeEvWWalFFE1LedlTIBIc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5153.eurprd04.prod.outlook.com (20.177.40.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 02:56:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 02:56:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH V2 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH V2 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVBUmUyhPYZQPb306ccqN8amt06Q==
Date:   Wed, 8 May 2019 02:56:06 +0000
Message-ID: <20190508030927.16668-2-peng.fan@nxp.com>
References: <20190508030927.16668-1-peng.fan@nxp.com>
In-Reply-To: <20190508030927.16668-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5b684d1-dbdb-4393-37cd-08d6d360b732
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5153;
x-ms-traffictypediagnostic: AM0PR04MB5153:
x-microsoft-antispam-prvs: <AM0PR04MB51536EA92963990BAD6E695B88320@AM0PR04MB5153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(26005)(1076003)(68736007)(66446008)(14444005)(14454004)(2501003)(66946007)(186003)(52116002)(305945005)(102836004)(7736002)(316002)(66556008)(64756008)(66476007)(53936002)(73956011)(25786009)(7416002)(50226002)(8936002)(5660300002)(4326008)(71190400001)(71200400001)(6512007)(478600001)(54906003)(110136005)(6116002)(76176011)(3846002)(2906002)(36756003)(81156014)(81166006)(8676002)(86362001)(2201001)(66066001)(6436002)(6486002)(446003)(11346002)(2616005)(256004)(6506007)(486006)(44832011)(386003)(99286004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5153;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZcSX9qfXRC5aiZaQ6c7zv94SCGPiBPYxyaOv/kJ+1rIUeda1CerOdpK69N3NJGsQfUJNoHEtRKZCtbqip1gykewLDXd5SBcuFx6cftYVqRJI9aqwiQpLxVYiXjtgo7TcCT30uMqTgABYd63KZJzSFz1GsUa5rDV2FPVqUBLMikkh6604d9dXgt8T39Y4ROHPnn3TYCy4Mn8msnT0IZlQfI6qWFtqYg6Xpdn3e9xV01K1IFsLSYoyUU+KBWE3pGIyt+EccbFGGhvhjgRYGPzy4a/mfGpbHfw4UAvKlm/WIJN5o9d1p+9UB740R3hx5/jzH3pFsU/ES1s2F+rikAlyWjH4MzrRAu//UhCXvunxJ+8+OfwUBoDT2jJY+UPnRpicOSR5xPT8aymf/Z5pYoGG/q0+7KYQKf+JiSjsd3jdnCM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b684d1-dbdb-4393-37cd-08d6d360b732
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 02:56:06.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg4IG52bWVtIG9jb3RwIGRyaXZlciB0byBhY2Nlc3MgZnVzZSB2
aWENClJQQyB0byBpLk1YOCBzeXN0ZW0gY29udHJvbGxlci4NCg0KQ2M6IFNyaW5pdmFzIEthbmRh
Z2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCkNjOiBTaGF3biBHdW8gPHNo
YXduZ3VvQGtlcm5lbC5vcmc+DQpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4
LmRlPg0KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+
DQpDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KQ2M6IE5YUCBMaW51eCBU
ZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNClNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KLS0t
DQoNClYyOg0KIEFkZCAic2N1IiBvciAiU0NVIiwgQWRkIGlteF9zY19taXNjX290cF9mdXNlX3Jl
YWQsIG1pbm9yIGZpeGVzDQoNCiBkcml2ZXJzL252bWVtL0tjb25maWcgICAgICAgICB8ICAgNyAr
Kw0KIGRyaXZlcnMvbnZtZW0vTWFrZWZpbGUgICAgICAgIHwgICAyICsNCiBkcml2ZXJzL252bWVt
L2lteC1vY290cC1zY3UuYyB8IDE3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDE3OSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWVtL0tjb25maWcgYi9kcml2ZXJzL252bWVtL0tjb25maWcNCmluZGV4IDUzMGQ1
NzA3MjRjOS4uNzlhZmU0NDE5NWExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lbS9LY29uZmln
DQorKysgYi9kcml2ZXJzL252bWVtL0tjb25maWcNCkBAIC0zNiw2ICszNiwxMyBAQCBjb25maWcg
TlZNRU1fSU1YX09DT1RQDQogCSAgVGhpcyBkcml2ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBt
b2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlDQogCSAgd2lsbCBiZSBjYWxsZWQgbnZtZW0taW14LW9j
b3RwLg0KIA0KK2NvbmZpZyBOVk1FTV9JTVhfT0NPVFBfU0NVDQorCXRyaXN0YXRlICJpLk1YOCBT
Q1UgT24tQ2hpcCBPVFAgQ29udHJvbGxlciBzdXBwb3J0Ig0KKwlkZXBlbmRzIG9uIElNWF9TQ1UN
CisJaGVscA0KKwkgIFRoaXMgaXMgYSBkcml2ZXIgZm9yIHRoZSBTQ1UgT24tQ2hpcCBPVFAgQ29u
dHJvbGxlciAoT0NPVFApDQorCSAgYXZhaWxhYmxlIG9uIGkuTVg4IFNvQ3MuDQorDQogY29uZmln
IE5WTUVNX0xQQzE4WFhfRUVQUk9NDQogCXRyaXN0YXRlICJOWFAgTFBDMThYWCBFRVBST00gTWVt
b3J5IFN1cHBvcnQiDQogCWRlcGVuZHMgb24gQVJDSF9MUEMxOFhYIHx8IENPTVBJTEVfVEVTVA0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUgYi9kcml2ZXJzL252bWVtL01ha2Vm
aWxlDQppbmRleCAyZWNlOGZmZmZkZGEuLjMwZDY1M2QzNGU1NyAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbnZtZW0vTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUNCkBAIC0xMyw2
ICsxMyw4IEBAIG9iai0kKENPTkZJR19OVk1FTV9JTVhfSUlNKQkrPSBudm1lbS1pbXgtaWltLm8N
CiBudm1lbS1pbXgtaWltLXkJCQk6PSBpbXgtaWltLm8NCiBvYmotJChDT05GSUdfTlZNRU1fSU1Y
X09DT1RQKQkrPSBudm1lbS1pbXgtb2NvdHAubw0KIG52bWVtLWlteC1vY290cC15CQk6PSBpbXgt
b2NvdHAubw0KK29iai0kKENPTkZJR19OVk1FTV9JTVhfT0NPVFBfU0NVKQkrPSBudm1lbS1pbXgt
b2NvdHAtc2N1Lm8NCitudm1lbS1pbXgtb2NvdHAtc2N1LXkJCTo9IGlteC1vY290cC1zY3Uubw0K
IG9iai0kKENPTkZJR19OVk1FTV9MUEMxOFhYX0VFUFJPTSkJKz0gbnZtZW1fbHBjMTh4eF9lZXBy
b20ubw0KIG52bWVtX2xwYzE4eHhfZWVwcm9tLXkJOj0gbHBjMTh4eF9lZXByb20ubw0KIG9iai0k
KENPTkZJR19OVk1FTV9MUEMxOFhYX09UUCkJKz0gbnZtZW1fbHBjMTh4eF9vdHAubw0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jIGIvZHJpdmVycy9udm1lbS9pbXgt
b2NvdHAtc2N1LmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLjAz
OGU3NDRjODU4OA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAt
c2N1LmMNCkBAIC0wLDAgKzEsMTcwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArDQorLyoNCisgKiBpLk1YOCBPQ09UUCBmdXNlYm94IGRyaXZlcg0KKyAqDQorICogQ29w
eXJpZ2h0IDIwMTkgTlhQDQorICoNCisgKiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCisg
Ki8NCisNCisjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPg0KKyNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvbnZtZW0tcHJvdmlkZXIuaD4NCisjaW5j
bHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQorDQorZW51bSBvY290cF9kZXZ0eXBlIHsN
CisJSU1YOFFYUCwNCit9Ow0KKw0KK3N0cnVjdCBvY290cF9kZXZ0eXBlX2RhdGEgew0KKwlpbnQg
ZGV2dHlwZTsNCisJaW50IG5yZWdzOw0KK307DQorDQorc3RydWN0IG9jb3RwX3ByaXYgew0KKwlz
dHJ1Y3QgZGV2aWNlICpkZXY7DQorCWNvbnN0IHN0cnVjdCBvY290cF9kZXZ0eXBlX2RhdGEgKmRh
dGE7DQorCXN0cnVjdCBpbXhfc2NfaXBjICpudm1lbV9pcGM7DQorfTsNCisNCitzdHJ1Y3QgaW14
X3NjX21zZ19yZXFfbWlzY19mdXNlX3JlYWQgew0KKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgaGRy
Ow0KKwl1MzIgd29yZDsNCit9IF9fcGFja2VkOw0KKw0KK3N0cnVjdCBpbXhfc2NfbXNnX3Jlc3Bf
bWlzY19mdXNlX3JlYWQgew0KKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgaGRyOw0KKwl1MzIgdmFs
Ow0KK30gX19wYWNrZWQ7DQorDQorc3RhdGljIHN0cnVjdCBvY290cF9kZXZ0eXBlX2RhdGEgaW14
OHF4cF9kYXRhID0gew0KKwkuZGV2dHlwZSA9IElNWDhRWFAsDQorCS5ucmVncyA9IDgwMCwNCit9
Ow0KKw0KK3N0YXRpYyBpbnQgaW14X3NjX21pc2Nfb3RwX2Z1c2VfcmVhZChzdHJ1Y3QgaW14X3Nj
X2lwYyAqaXBjLCB1MzIgd29yZCwNCisJCQkJICAgICB1MzIgKnZhbCkNCit7DQorCXN0cnVjdCBp
bXhfc2NfbXNnX3JlcV9taXNjX2Z1c2VfcmVhZCBtc2c7DQorCXN0cnVjdCBpbXhfc2NfbXNnX3Jl
c3BfbWlzY19mdXNlX3JlYWQgKnJlc3A7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0g
Jm1zZy5oZHI7DQorCWludCByZXQ7DQorDQorCWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJTSU9O
Ow0KKwloZHItPnN2YyA9ICh1aW50OF90KUlNWF9TQ19SUENfU1ZDX01JU0M7DQorCWhkci0+ZnVu
YyA9ICh1aW50OF90KUlNWF9TQ19NSVNDX0ZVTkNfT1RQX0ZVU0VfUkVBRDsNCisJaGRyLT5zaXpl
ID0gMjsNCisNCisJbXNnLndvcmQgPSB3b3JkOw0KKw0KKwlyZXQgPSBpbXhfc2N1X2NhbGxfcnBj
KGlwYywgJm1zZywgdHJ1ZSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlyZXNw
ID0gKHN0cnVjdCBpbXhfc2NfbXNnX3Jlc3BfbWlzY19mdXNlX3JlYWQgKikmbXNnOw0KKwlpZiAo
dmFsICE9IE5VTEwpDQorCQkqdmFsID0gcmVzcC0+dmFsOw0KKw0KKwlyZXR1cm4gMDsNCit9DQor
DQorc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3JlYWQodm9pZCAqY29udGV4dCwgdW5zaWduZWQg
aW50IG9mZnNldCwNCisJCQkgICAgICB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCit7DQorCXN0
cnVjdCBvY290cF9wcml2ICpwcml2ID0gY29udGV4dDsNCisJdTMyIGNvdW50LCBpbmRleCwgbnVt
X2J5dGVzOw0KKwl1MzIgKmJ1ZjsNCisJdm9pZCAqcDsNCisJaW50IGksIHJldDsNCisNCisJaW5k
ZXggPSBvZmZzZXQgPj4gMjsNCisJbnVtX2J5dGVzID0gcm91bmRfdXAoKG9mZnNldCAlIDQpICsg
Ynl0ZXMsIDQpOw0KKwljb3VudCA9IG51bV9ieXRlcyA+PiAyOw0KKw0KKwlpZiAoY291bnQgPiAo
cHJpdi0+ZGF0YS0+bnJlZ3MgLSBpbmRleCkpDQorCQljb3VudCA9IHByaXYtPmRhdGEtPm5yZWdz
IC0gaW5kZXg7DQorDQorCXAgPSBremFsbG9jKG51bV9ieXRlcywgR0ZQX0tFUk5FTCk7DQorCWlm
ICghcCkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlidWYgPSBwOw0KKw0KKwlmb3IgKGkgPSBp
bmRleDsgaSA8IChpbmRleCArIGNvdW50KTsgaSsrKSB7DQorCQlpZiAocHJpdi0+ZGF0YS0+ZGV2
dHlwZSA9PSBJTVg4UVhQKSB7DQorCQkJaWYgKChpID4gMjcxKSAmJiAoaSA8IDU0NCkpIHsNCisJ
CQkJKih1MzIgKilidWYgPSAwOw0KKwkJCQlidWYgKz0gNDsNCisJCQkJY29udGludWU7DQorCQkJ
fQ0KKwkJfQ0KKw0KKwkJcmV0ID0gaW14X3NjX21pc2Nfb3RwX2Z1c2VfcmVhZChwcml2LT5udm1l
bV9pcGMsIGksIGJ1Zik7DQorCQlpZiAocmV0KSB7DQorCQkJa2ZyZWUocCk7DQorCQkJcmV0dXJu
IHJldDsNCisJCX0NCisJCWJ1ZisrOw0KKwl9DQorDQorCW1lbWNweSh2YWwsIHAgKyBvZmZzZXQg
JSA0LCBieXRlcyk7DQorDQorCWtmcmVlKHApOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3Rh
dGljIHN0cnVjdCBudm1lbV9jb25maWcgaW14X3NjdV9vY290cF9udm1lbV9jb25maWcgPSB7DQor
CS5uYW1lID0gImlteC1zY3Utb2NvdHAiLA0KKwkucmVhZF9vbmx5ID0gdHJ1ZSwNCisJLndvcmRf
c2l6ZSA9IDQsDQorCS5zdHJpZGUgPSAxLA0KKwkub3duZXIgPSBUSElTX01PRFVMRSwNCisJLnJl
Z19yZWFkID0gaW14X3NjdV9vY290cF9yZWFkLA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgaW14X3NjdV9vY290cF9kdF9pZHNbXSA9IHsNCisJeyAuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1zY3Utb2NvdHAiLCAodm9pZCAqKSZpbXg4cXhwX2RhdGEgfSwNCisJ
eyB9LA0KK307DQorTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X3NjdV9vY290cF9kdF9pZHMp
Ow0KKw0KK3N0YXRpYyBpbnQgaW14X3NjdV9vY290cF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCisJc3Ry
dWN0IG9jb3RwX3ByaXYgKnByaXY7DQorCXN0cnVjdCBudm1lbV9kZXZpY2UgKm52bWVtOw0KKwlp
bnQgcmV0Ow0KKw0KKwlwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQ
X0tFUk5FTCk7DQorCWlmICghcHJpdikNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlyZXQgPSBp
bXhfc2N1X2dldF9oYW5kbGUoJnByaXYtPm52bWVtX2lwYyk7DQorCWlmIChyZXQpDQorCQlyZXR1
cm4gcmV0Ow0KKw0KKwlwcml2LT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7
DQorCXByaXYtPmRldiA9IGRldjsNCisJaW14X3NjdV9vY290cF9udm1lbV9jb25maWcuc2l6ZSA9
IDQgKiBwcml2LT5kYXRhLT5ucmVnczsNCisJaW14X3NjdV9vY290cF9udm1lbV9jb25maWcuZGV2
ID0gZGV2Ow0KKwlpbXhfc2N1X29jb3RwX252bWVtX2NvbmZpZy5wcml2ID0gcHJpdjsNCisJbnZt
ZW0gPSBkZXZtX252bWVtX3JlZ2lzdGVyKGRldiwgJmlteF9zY3Vfb2NvdHBfbnZtZW1fY29uZmln
KTsNCisNCisJcmV0dXJuIFBUUl9FUlJfT1JfWkVSTyhudm1lbSk7DQorfQ0KKw0KK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteF9zY3Vfb2NvdHBfZHJpdmVyID0gew0KKwkucHJvYmUJ
PSBpbXhfc2N1X29jb3RwX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUJPSAiaW14X3Nj
dV9vY290cCIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBpbXhfc2N1X29jb3RwX2R0X2lkcywNCisJ
fSwNCit9Ow0KK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoaW14X3NjdV9vY290cF9kcml2ZXIpOw0K
Kw0KK01PRFVMRV9BVVRIT1IoIlBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiIpOw0KK01PRFVM
RV9ERVNDUklQVElPTigiaS5NWDggU0NVIE9DT1RQIGZ1c2UgYm94IGRyaXZlciIpOw0KK01PRFVM
RV9MSUNFTlNFKCJHUEwgdjIiKTsNCi0tIA0KMi4xNi40DQoNCg==
