Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12C208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NzDfX3Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfDZIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:54 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:4572
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDZIFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k50CCJij/s6qWEO4Fq0H7vns/NMsTvl743kCznP12O4=;
 b=NzDfX3Zfv535CVnLAS7aT02E/4huxvmwy0v72H6yh8WT859trmOepN0a5w2+WZahVibgFWKvw+72bDqCmJ4Nw/xVvy/BoWVrrJBATQz21UUciReUJtPqshb/oItY3FzYo+8nnCUaQ9ArD0Ii3iYzpF+y8FYiilN6zstV8FsiujQ=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.49.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:46 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:46 +0000
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
Subject: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround on i.mx6ul
Thread-Topic: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Index: AQHU/AbaiLNd2lkp3kyyQFeWzzS7gg==
Date:   Fri, 26 Apr 2019 08:05:45 +0000
Message-ID: <1556265512-9130-8-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: e5d5e094-bd7c-4eb8-e379-08d6ca1dfc4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4830;
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-microsoft-antispam-prvs: <VI1PR04MB48309B84D30949D7A3EFF47E893E0@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(36756003)(54906003)(81156014)(50226002)(8676002)(81166006)(8936002)(386003)(26005)(97736004)(2501003)(6506007)(4326008)(316002)(86362001)(3846002)(110136005)(6116002)(14444005)(11346002)(6436002)(446003)(256004)(66066001)(2906002)(99286004)(52116002)(476003)(5660300002)(186003)(71190400001)(2616005)(25786009)(14454004)(7416002)(53936002)(71200400001)(486006)(305945005)(64756008)(66556008)(6512007)(73956011)(66446008)(478600001)(66476007)(2201001)(102836004)(68736007)(66946007)(76176011)(6486002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yakCDsEFG4CgT5H738Qz6RNwprVJ/LmHBrsTkT+evdonCCbWufsc6uIEp4TmGTIYm4UuocLX8iURYMXiHo0SCVPvjZolNgbNT/7iDy6XmtFAVIrw+2U0Wewcj209eO1VzHQkrhcCN1jbDztYeiWchI/TwgcT9s1+i9VBvb60lCLH3Egt+qoFFlZc0tq/SbjP2Jrd7TXw3fa9ls82DOxcVy75JersrAJA9eEcOy1igzPcPurOFZiHi6ViO+liDjZiqnLaeVg5sYFOl2geyT46GT2/3J1hUBW5RWGiPzjn/DK5aQyZKMu30bh7isuJWb4qOyjQkyjpQYTUlYsXDA+s/vFCpv7tZ57/yJfRqtd17uX3xhtModm+kvcldtTNGF/HN1DGJJRpTd/ydJSe+k3DcQiewa7Yfa+1VzxfZm2lZi8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d5e094-bd7c-4eb8-e379-08d6ca1dfc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:45.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICAgRVJSMDA5MTY1IGZpeCBvbiBpLm14NnVsIGFuZCBuZXh0IGNoaXAsIHN1Y2ggYXMgaS5teDZ1
bGwvaS5teDhtcS9pLm14OG1tLg0KUmVtb3ZlIHdvcmthcm91bmQgb24gdGhvc2UgY2hpcHMuIEFk
ZCBuZXcgaS5teDZ1bCB0eXBlIGZvciB0aGF0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25n
IDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAzOSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3NwaS1pbXguYyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KaW5kZXggZWI1NmVhYy4uMmU1
ZTk3OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KKysrIGIvZHJpdmVycy9z
cGkvc3BpLWlteC5jDQpAQCAtNTcsNiArNTcsNyBAQCBlbnVtIHNwaV9pbXhfZGV2dHlwZSB7DQog
CUlNWDM1X0NTUEksCS8qIENTUEkgb24gYWxsIGkubXggZXhjZXB0IGFib3ZlICovDQogCUlNWDUx
X0VDU1BJLAkvKiBFQ1NQSSBvbiBpLm14NTEgKi8NCiAJSU1YNTNfRUNTUEksCS8qIEVDU1BJIG9u
IGkubXg1MyBhbmQgbGF0ZXIgKi8NCisJSU1YNlVMX0VDU1BJLAkvKiBFUlIwMDkxNjUgZml4IGZy
b20gaS5teDZ1bCAqLw0KIH07DQogDQogc3RydWN0IHNwaV9pbXhfZGF0YTsNCkBAIC0xMjgsNyAr
MTI5LDggQEAgc3RhdGljIGlubGluZSBpbnQgaXNfaW14MzVfY3NwaShzdHJ1Y3Qgc3BpX2lteF9k
YXRhICpkKQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IGlzX2lteDUxX2Vjc3BpKHN0cnVjdCBzcGlf
aW14X2RhdGEgKmQpDQogew0KLQlyZXR1cm4gZC0+ZGV2dHlwZV9kYXRhLT5kZXZ0eXBlID09IElN
WDUxX0VDU1BJOw0KKwlyZXR1cm4gZC0+ZGV2dHlwZV9kYXRhLT5kZXZ0eXBlID09IElNWDUxX0VD
U1BJIHx8DQorCSAgICAgICBkLT5kZXZ0eXBlX2RhdGEtPmRldnR5cGUgPT0gSU1YNlVMX0VDU1BJ
Ow0KIH0NCiANCiBzdGF0aWMgaW5saW5lIGludCBpc19pbXg1M19lY3NwaShzdHJ1Y3Qgc3BpX2lt
eF9kYXRhICpkKQ0KQEAgLTU4NSw5ICs1ODcsMTYgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3By
ZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCiAJY3RybCB8PSBt
eDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14LCB0LT5zcGVlZF9oeiwgJmNsayk7DQogCXNwaV9pbXgt
PnNwaV9idXNfY2xrID0gY2xrOw0KIA0KLQkvKiBFUlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUg
YXMgUElPICovDQotCWlmIChzcGlfaW14LT51c2VkbWEpDQotCQljdHJsICY9IH5NWDUxX0VDU1BJ
X0NUUkxfU01DOw0KKwkvKg0KKwkgKiBFUlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUgaW5zdGVh
ZCBvZiBTTUMgYXMgUElPIG9uIHRoZSBjaGlwcw0KKwkgKiBiZWZvcmUgaS5teDZ1bC4NCisJICov
DQorCWlmIChzcGlfaW14LT51c2VkbWEpIHsNCisJCWlmIChzcGlfaW14LT5kZXZ0eXBlX2RhdGEt
PmRldnR5cGUgPT0gSU1YNlVMX0VDU1BJKQ0KKwkJCWN0cmwgfD0gTVg1MV9FQ1NQSV9DVFJMX1NN
QzsNCisJCWVsc2UNCisJCQljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOw0KKwl9DQogDQog
CXdyaXRlbChjdHJsLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCiANCkBAIC02
MTUsNiArNjI0LDggQEAgc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhf
ZGF0YSAqc3BpX2lteCkNCiB7DQogCXUzMiB0eF93bWwgPSAwOw0KIA0KKwlpZiAoc3BpX2lteC0+
ZGV2dHlwZV9kYXRhLT5kZXZ0eXBlID09IElNWDZVTF9FQ1NQSSkNCisJCXR4X3dtbCA9IHNwaV9p
bXgtPndtbDsNCiAJLyoNCiAJICogQ29uZmlndXJlIHRoZSBETUEgcmVnaXN0ZXI6IHNldHVwIHRo
ZSB3YXRlcm1hcmsNCiAJICogYW5kIGVuYWJsZSBETUEgcmVxdWVzdC4NCkBAIC0xMDEyLDYgKzEw
MjMsMjIgQEAgc3RhdGljIHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSBpbXg1M19lY3NwaV9k
ZXZ0eXBlX2RhdGEgPSB7DQogCS5kZXZ0eXBlID0gSU1YNTNfRUNTUEksDQogfTsNCiANCitzdGF0
aWMgc3RydWN0IHNwaV9pbXhfZGV2dHlwZV9kYXRhIGlteDZ1bF9lY3NwaV9kZXZ0eXBlX2RhdGEg
PSB7DQorCS5pbnRjdHJsID0gbXg1MV9lY3NwaV9pbnRjdHJsLA0KKwkucHJlcGFyZV9tZXNzYWdl
ID0gbXg1MV9lY3NwaV9wcmVwYXJlX21lc3NhZ2UsDQorCS5wcmVwYXJlX3RyYW5zZmVyID0gbXg1
MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyLA0KKwkudHJpZ2dlciA9IG14NTFfZWNzcGlfdHJpZ2dl
ciwNCisJLnJ4X2F2YWlsYWJsZSA9IG14NTFfZWNzcGlfcnhfYXZhaWxhYmxlLA0KKwkucmVzZXQg
PSBteDUxX2Vjc3BpX3Jlc2V0LA0KKwkuc2V0dXBfd21sID0gbXg1MV9zZXR1cF93bWwsDQorCS5m
aWZvX3NpemUgPSA2NCwNCisJLmhhc19kbWFtb2RlID0gdHJ1ZSwNCisJLmR5bmFtaWNfYnVyc3Qg
PSB0cnVlLA0KKwkuaGFzX3NsYXZlbW9kZSA9IHRydWUsDQorCS5kaXNhYmxlID0gbXg1MV9lY3Nw
aV9kaXNhYmxlLA0KKwkuZGV2dHlwZSA9IElNWDZVTF9FQ1NQSSwNCit9Ow0KKw0KIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNwaV9pbXhfZGV2dHlwZVtdID0gew0KIAl7
DQogCQkubmFtZSA9ICJpbXgxLWNzcGkiLA0KQEAgLTEwMzUsNiArMTA2Miw5IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNwaV9pbXhfZGV2dHlwZVtdID0gew0KIAkJ
Lm5hbWUgPSAiaW14NTMtZWNzcGkiLA0KIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190
KSAmaW14NTNfZWNzcGlfZGV2dHlwZV9kYXRhLA0KIAl9LCB7DQorCQkubmFtZSA9ICJpbXg2dWwt
ZWNzcGkiLA0KKwkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmaW14NnVsX2Vjc3Bp
X2RldnR5cGVfZGF0YSwNCisJfSwgew0KIAkJLyogc2VudGluZWwgKi8NCiAJfQ0KIH07DQpAQCAt
MTA0Nyw2ICsxMDc3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3BpX2lt
eF9kdF9pZHNbXSA9IHsNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzUtY3NwaSIsIC5kYXRh
ID0gJmlteDM1X2NzcGlfZGV2dHlwZV9kYXRhLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg1MS1lY3NwaSIsIC5kYXRhID0gJmlteDUxX2Vjc3BpX2RldnR5cGVfZGF0YSwgfSwNCiAJeyAu
Y29tcGF0aWJsZSA9ICJmc2wsaW14NTMtZWNzcGkiLCAuZGF0YSA9ICZpbXg1M19lY3NwaV9kZXZ0
eXBlX2RhdGEsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsIC5kYXRh
ID0gJmlteDZ1bF9lY3NwaV9kZXZ0eXBlX2RhdGEsIH0sDQogCXsgLyogc2VudGluZWwgKi8gfQ0K
IH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc3BpX2lteF9kdF9pZHMpOw0KLS0gDQoyLjcu
NA0KDQo=
