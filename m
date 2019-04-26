Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C03C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406AA206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pe6c1YPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZIGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:02 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:55343
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfDZIGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN+WVuUAYjsWrpPQenSMDN19BF2GEAi3zyZ7KV9LX3Y=;
 b=pe6c1YPcBX7Pzb6C/63kx0gEReeOBj+HjkULrWj1RFZHiGha1SIiAKJk/30bAN+R71TdPJVltEB3ND6NDTg0YSz84nx/B5XLMjX7tIiNVMgi9A6YVD8ZdR/XetKcU1+83wWcOkmKifluypvL1plh7zpOY/np/wUd7KZILWkNnjQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:57 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 09/15] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Thread-Topic: [PATCH v2 09/15] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHU/AbhzDo5aHOQK0ir7dMEQEBu1Q==
Date:   Fri, 26 Apr 2019 08:05:57 +0000
Message-ID: <1556265512-9130-10-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d7758aa-4a35-412f-123f-08d6ca1e0353
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB6109E96A3F794CE348BD569A893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(6306002)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(966005)(7736002)(54906003)(71190400001)(305945005)(71200400001)(14444005)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K02b2ZzvvWFO3CrOGCOxtTa1hfb149aRa4IZ5n83OiPLT8COSbhjsdmtUYjg1JIOIvh01WOmeeEr5hSxEISieTBBKdHwlfpyByZTUozVM5qtY7UrJRiO6om4Hlgxj9ISaSXZcTJHD5Q1REgVxHbHybxVavxtRY9ePa9ElKQXWKjBntyTJNhg0XXmg2SWzu3lvgYRc9BTF4FKeIxaSt/jNSxe8uoxhc/kL6LknX+Yn+GgUUOitNRZtcsSqdF0ysbSTkrNzlDKP3xAOFIKs2bGg70PLAvK2yfjjz9NHpwg9MsojsgEPOZg9ZnidqYq3INwR7LxQZY271eFaQegDrPB5Pu/krwN8vwb2R+dzwdAikV2JZtVtcVAST2GSSdMd+D75xFWE4BhJwOSxUzjrsgMZrrfedsNzWTfKDyH9wEmsqc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7758aa-4a35-412f-123f-08d6ca1e0353
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:57.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RUNTUEkgaXNzdWUgZml4ZWQgZnJvbSBpLm14NnVsIGF0IGhhcmR3YXJlIGxldmVsLCBubyBuZWVk
DQpFUlIwMDkxNjUgYW55bW9yZSBvbiB0aG9zZSBjaGlwcyBzdWNoIGFzIGkubXg4bXEuIEFkZCBp
Lm14NnN4DQpmcm9tIHdoZXJlIGkubXg2dWwgc291cmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
CiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMN
CmluZGV4IDM1MmIwZDUuLjNlOTEyYjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtNDE5LDYgKzQxOSwxMyBAQCBz
dHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSB7DQogCWludCBudW1fZXZlbnRzOw0KIAlzdHJ1Y3Qgc2Rt
YV9zY3JpcHRfc3RhcnRfYWRkcnMJKnNjcmlwdF9hZGRyczsNCiAJYm9vbCBjaGVja19yYXRpbzsN
CisJLyoNCisJICogZWNzcGkgRVJSMDA5MTY1IGZpeGVkIHNob3VsZCBiZSBkb25lIGluIHNkbWEg
c2NyaXB0DQorCSAqIGFuZCBpdCBiZSBmaXhlZCBpbiBzb2MgZnJvbSBpLm14NnVsLg0KKwkgKiBw
bGVhc2UgZ2V0IG1vcmUgaW5mb3JtYXRpb24gZnJvbSBiZWxvdyBsaW5rOg0KKwkgKiBodHRwczov
L3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZEUUNFLnBkZg0KKwkgKi8NCisJYm9vbCBl
Y3NwaV9maXhlZDsNCiB9Ow0KIA0KIHN0cnVjdCBzZG1hX2VuZ2luZSB7DQpAQCAtNTM5LDYgKzU0
NiwzMSBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEgc2RtYV9pbXg2cSA9IHsNCiAJ
LnNjcmlwdF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg2cSwNCiB9Ow0KIA0KK3N0YXRpYyBzdHJ1
Y3Qgc2RtYV9zY3JpcHRfc3RhcnRfYWRkcnMgc2RtYV9zY3JpcHRfaW14NnN4ID0gew0KKwkuYXBf
Ml9hcF9hZGRyID0gNjQyLA0KKwkudWFydF8yX21jdV9hZGRyID0gODE3LA0KKwkubWN1XzJfYXBw
X2FkZHIgPSA3NDcsDQorCS51YXJ0c2hfMl9tY3VfYWRkciA9IDEwMzIsDQorCS5tY3VfMl9zaHBf
YWRkciA9IDk2MCwNCisJLmFwcF8yX21jdV9hZGRyID0gNjgzLA0KKwkuc2hwXzJfbWN1X2FkZHIg
PSA4OTEsDQorCS5zcGRpZl8yX21jdV9hZGRyID0gMTEwMCwNCisJLm1jdV8yX3NwZGlmX2FkZHIg
PSAxMTM0LA0KK307DQorDQorc3RhdGljIHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14
NnN4ID0gew0KKwkuY2huZW5ibDAgPSBTRE1BX0NITkVOQkwwX0lNWDM1LA0KKwkubnVtX2V2ZW50
cyA9IDQ4LA0KKwkuc2NyaXB0X2FkZHJzID0gJnNkbWFfc2NyaXB0X2lteDZzeCwNCit9Ow0KKw0K
K3N0YXRpYyBzdHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSBzZG1hX2lteDZ1bCA9IHsNCisJLmNobmVu
YmwwID0gU0RNQV9DSE5FTkJMMF9JTVgzNSwNCisJLm51bV9ldmVudHMgPSA0OCwNCisJLnNjcmlw
dF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg2c3gsDQorCS5lY3NwaV9maXhlZCA9IHRydWUsDQor
fTsNCisNCiBzdGF0aWMgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHNkbWFfc2NyaXB0
X2lteDdkID0gew0KIAkuYXBfMl9hcF9hZGRyID0gNjQ0LA0KIAkudWFydF8yX21jdV9hZGRyID0g
ODE5LA0KQEAgLTU2Miw2ICs1OTQsNyBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEg
c2RtYV9pbXg4bXEgPSB7DQogCS5udW1fZXZlbnRzID0gNDgsDQogCS5zY3JpcHRfYWRkcnMgPSAm
c2RtYV9zY3JpcHRfaW14N2QsDQogCS5jaGVja19yYXRpbyA9IDEsDQorCS5lY3NwaV9maXhlZCA9
IHRydWUsDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBz
ZG1hX2RldnR5cGVzW10gPSB7DQpAQCAtNTg0LDkgKzYxNywxNSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZV9pZCBzZG1hX2RldnR5cGVzW10gPSB7DQogCQkubmFtZSA9ICJp
bXg2cS1zZG1hIiwNCiAJCS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZCBsb25nKSZzZG1hX2lteDZx
LA0KIAl9LCB7DQorCQkubmFtZSA9ICJpbXg2c3gtc2RtYSIsDQorCQkuZHJpdmVyX2RhdGEgPSAo
dW5zaWduZWQgbG9uZykmc2RtYV9pbXg2c3gsDQorCX0sIHsNCiAJCS5uYW1lID0gImlteDdkLXNk
bWEiLA0KIAkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcpJnNkbWFfaW14N2QsDQogCX0s
IHsNCisJCS5uYW1lID0gImlteDZ1bC1zZG1hIiwNCisJCS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25l
ZCBsb25nKSZzZG1hX2lteDZ1bCwNCisJfSwgew0KIAkJLm5hbWUgPSAiaW14OG1xLXNkbWEiLA0K
IAkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcpJnNkbWFfaW14OG1xLA0KIAl9LCB7DQpA
QCAtNjAyLDcgKzY0MSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNkbWFf
ZHRfaWRzW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDM1LXNkbWEiLCAuZGF0YSA9
ICZzZG1hX2lteDM1LCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgzMS1zZG1hIiwgLmRh
dGEgPSAmc2RtYV9pbXgzMSwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MjUtc2RtYSIs
IC5kYXRhID0gJnNkbWFfaW14MjUsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1z
ZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXg2c3gsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlt
eDdkLXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDdkLCB9LA0KKwl7IC5jb21wYXRpYmxlID0gImZz
bCxpbXg2dWwtc2RtYSIsIC5kYXRhID0gJnNkbWFfaW14NnVsLCB9LA0KIAl7IC5jb21wYXRpYmxl
ID0gImZzbCxpbXg4bXEtc2RtYSIsIC5kYXRhID0gJnNkbWFfaW14OG1xLCB9LA0KIAl7IC8qIHNl
bnRpbmVsICovIH0NCiB9Ow0KQEAgLTExNjYsOCArMTIwNywxNyBAQCBzdGF0aWMgaW50IHNkbWFf
Y29uZmlnX2NoYW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KIAkJCWlmIChzZG1hYy0+cGVy
aXBoZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0FTUkNfU1AgfHwNCiAJCQkgICAgc2RtYWMtPnBl
cmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9BU1JDKQ0KIAkJCQlzZG1hX3NldF93YXRlcm1h
cmtsZXZlbF9mb3JfcDJwKHNkbWFjKTsNCi0JCX0gZWxzZQ0KKwkJfSBlbHNlIHsNCisJCQkvKg0K
KwkJCSAqIEVSUjAwOTE2NSBmaXhlZCBmcm9tIGkubXg2dWwsIG5vIGVycmF0YSBuZWVkLA0KKwkJ
CSAqIHNldCBiaXQzMSB0byBsZXQgc2RtYSBzY3JpcHQgc2tpcCB0aGUgZXJyYXRhLg0KKwkJCSAq
Lw0KKwkJCWlmIChzZG1hYy0+cGVyaXBoZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0NTUEkgJiYN
CisJCQkgICAgc2RtYWMtPmRpcmVjdGlvbiA9PSBETUFfTUVNX1RPX0RFViAmJg0KKwkJCSAgICBz
ZG1hYy0+c2RtYS0+ZHJ2ZGF0YS0+ZWNzcGlfZml4ZWQpDQorCQkJCV9fc2V0X2JpdCgzMSwgJnNk
bWFjLT53YXRlcm1hcmtfbGV2ZWwpOw0KIAkJCV9fc2V0X2JpdChzZG1hYy0+ZXZlbnRfaWQwLCBz
ZG1hYy0+ZXZlbnRfbWFzayk7DQorCQl9DQogDQogCQkvKiBBZGRyZXNzICovDQogCQlzZG1hYy0+
c2hwX2FkZHIgPSBzZG1hYy0+cGVyX2FkZHJlc3M7DQotLSANCjIuNy40DQoNCg==
