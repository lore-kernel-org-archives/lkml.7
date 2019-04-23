Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E98C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8AC217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRMGE9fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfDWNv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:27 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:42823
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbfDWNvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnAi6PbHKY6vHxw2cqa7GlKamzagrksb7yfDyyUpMBw=;
 b=BRMGE9fjP4xJQ2+C1w8Kr5LYcBi/cYzbIL7tUSkMiLZzUzDihJoVSyeov3es1vkabCXfpRz5p0uJ6PeSwaTv1ZUrYj49vIkVlQK+CF9gNhmAll7IWcxaQhPy3M/xPaH4Nb/4kTtxHR8qPhlDUZLV8PilQ9IrqmoKwYKTLjBFxBg=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:20 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 09/15] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Thread-Topic: [PATCH v1 09/15] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHU+duhNxDL83JmL0GLRhhK1S/t/Q==
Date:   Tue, 23 Apr 2019 13:51:20 +0000
Message-ID: <1556027045-5269-10-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4340dc29-38c0-4b7e-cf5f-08d6c7f2c3e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-microsoft-antispam-prvs: <VI1PR04MB5901AE9858FFE9CE7C43846489230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e4sKTJXWDeGPFDRcz0nsjrCC2VA9Y8INP6qNFhK0lSZmQuwc5ef6DsIrHqtBWf0DOzbEVyTax0nUqvPkZffjVoNPZLoZh12qGUz1sQ4nx5GbExuxD0mXZPe7ebXhzNIxJ/qTyTY366ZMQ8etU2zh25Sp8KnlGDq+ps07V7b7EI99xZEY8MguV/EG+68Jb5fN/SeUMDqXQHKT4rnx3XKpwebdQt+Z2mufNY7w4870c55kFigDSY5imCyc6AVv7Hz2dBTF2lOBH4szozqVf3bYlEu/xGw+y8pFrWq+MdshJW1IvnJnNzOV4jd/qfSMcBRv4IMVegJRyi7nLD9xbat+IH/Rq/ZQviDeridAEHJxCauwtBb5/gXey45FpzWEtoQCA4IKv/lj07cpjBAP1YizoCYjAkaWEPjNZOGd/z5waM4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4340dc29-38c0-4b7e-cf5f-08d6c7f2c3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:20.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RUNTUEkgaXNzdWUgZml4ZWQgZnJvbSBpLm14NnVsIGF0IGhhcmR3YXJlIGxldmVsLCBubyBuZWVk
DQpFUlIwMDkxNjUgYW55bW9yZSBvbiB0aG9zZSBjaGlwcyBzdWNoIGFzIGkubXg4bXEuIEFkZCBp
Lm14NnN4DQpmcm9tIHdoZXJlIGkubXg2dWwgc291cmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXgg
MWUyMDQ3MC4uOTljNDRhNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisr
KyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCkBAIC00MTksNiArNDE5LDcgQEAgc3RydWN0IHNk
bWFfZHJpdmVyX2RhdGEgew0KIAlpbnQgbnVtX2V2ZW50czsNCiAJc3RydWN0IHNkbWFfc2NyaXB0
X3N0YXJ0X2FkZHJzCSpzY3JpcHRfYWRkcnM7DQogCWJvb2wgY2hlY2tfcmF0aW87DQorCWJvb2wg
ZWNzcGlfZml4ZWQ7DQogfTsNCiANCiBzdHJ1Y3Qgc2RtYV9lbmdpbmUgew0KQEAgLTUzOSw2ICs1
NDAsMzEgQEAgc3RhdGljIHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14NnEgPSB7DQog
CS5zY3JpcHRfYWRkcnMgPSAmc2RtYV9zY3JpcHRfaW14NnEsDQogfTsNCiANCitzdGF0aWMgc3Ry
dWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHNkbWFfc2NyaXB0X2lteDZzeCA9IHsNCisJLmFw
XzJfYXBfYWRkciA9IDY0MiwNCisJLnVhcnRfMl9tY3VfYWRkciA9IDgxNywNCisJLm1jdV8yX2Fw
cF9hZGRyID0gNzQ3LA0KKwkudWFydHNoXzJfbWN1X2FkZHIgPSAxMDMyLA0KKwkubWN1XzJfc2hw
X2FkZHIgPSA5NjAsDQorCS5hcHBfMl9tY3VfYWRkciA9IDY4MywNCisJLnNocF8yX21jdV9hZGRy
ID0gODkxLA0KKwkuc3BkaWZfMl9tY3VfYWRkciA9IDExMDAsDQorCS5tY3VfMl9zcGRpZl9hZGRy
ID0gMTEzNCwNCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3Qgc2RtYV9kcml2ZXJfZGF0YSBzZG1hX2lt
eDZzeCA9IHsNCisJLmNobmVuYmwwID0gU0RNQV9DSE5FTkJMMF9JTVgzNSwNCisJLm51bV9ldmVu
dHMgPSA0OCwNCisJLnNjcmlwdF9hZGRycyA9ICZzZG1hX3NjcmlwdF9pbXg2c3gsDQorfTsNCisN
CitzdGF0aWMgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEgc2RtYV9pbXg2dWwgPSB7DQorCS5jaG5l
bmJsMCA9IFNETUFfQ0hORU5CTDBfSU1YMzUsDQorCS5udW1fZXZlbnRzID0gNDgsDQorCS5zY3Jp
cHRfYWRkcnMgPSAmc2RtYV9zY3JpcHRfaW14NnN4LA0KKwkuZWNzcGlfZml4ZWQgPSB0cnVlLA0K
K307DQorDQogc3RhdGljIHN0cnVjdCBzZG1hX3NjcmlwdF9zdGFydF9hZGRycyBzZG1hX3Njcmlw
dF9pbXg3ZCA9IHsNCiAJLmFwXzJfYXBfYWRkciA9IDY0NCwNCiAJLnVhcnRfMl9tY3VfYWRkciA9
IDgxOSwNCkBAIC01NjIsNiArNTg4LDcgQEAgc3RhdGljIHN0cnVjdCBzZG1hX2RyaXZlcl9kYXRh
IHNkbWFfaW14OG1xID0gew0KIAkubnVtX2V2ZW50cyA9IDQ4LA0KIAkuc2NyaXB0X2FkZHJzID0g
JnNkbWFfc2NyaXB0X2lteDdkLA0KIAkuY2hlY2tfcmF0aW8gPSAxLA0KKwkuZWNzcGlfZml4ZWQg
PSB0cnVlLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQg
c2RtYV9kZXZ0eXBlc1tdID0gew0KQEAgLTU4NCw5ICs2MTEsMTUgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgc2RtYV9kZXZ0eXBlc1tdID0gew0KIAkJLm5hbWUgPSAi
aW14NnEtc2RtYSIsDQogCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZykmc2RtYV9pbXg2
cSwNCiAJfSwgew0KKwkJLm5hbWUgPSAiaW14NnN4LXNkbWEiLA0KKwkJLmRyaXZlcl9kYXRhID0g
KHVuc2lnbmVkIGxvbmcpJnNkbWFfaW14NnN4LA0KKwl9LCB7DQogCQkubmFtZSA9ICJpbXg3ZC1z
ZG1hIiwNCiAJCS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZCBsb25nKSZzZG1hX2lteDdkLA0KIAl9
LCB7DQorCQkubmFtZSA9ICJpbXg2dWwtc2RtYSIsDQorCQkuZHJpdmVyX2RhdGEgPSAodW5zaWdu
ZWQgbG9uZykmc2RtYV9pbXg2dWwsDQorCX0sIHsNCiAJCS5uYW1lID0gImlteDhtcS1zZG1hIiwN
CiAJCS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZCBsb25nKSZzZG1hX2lteDhtcSwNCiAJfSwgew0K
QEAgLTYwMiw3ICs2MzUsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZG1h
X2R0X2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgzNS1zZG1hIiwgLmRhdGEg
PSAmc2RtYV9pbXgzNSwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14MzEtc2RtYSIsIC5k
YXRhID0gJnNkbWFfaW14MzEsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDI1LXNkbWEi
LCAuZGF0YSA9ICZzZG1hX2lteDI1LCB9LA0KKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg2c3gt
c2RtYSIsIC5kYXRhID0gJnNkbWFfaW14NnN4LCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg3ZC1zZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXg3ZCwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJm
c2wsaW14NnVsLXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDZ1bCwgfSwNCiAJeyAuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OG1xLXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDhtcSwgfSwNCiAJeyAvKiBz
ZW50aW5lbCAqLyB9DQogfTsNCkBAIC0xMTY3LDggKzEyMDIsMTQgQEAgc3RhdGljIGludCBzZG1h
X2NvbmZpZ19jaGFubmVsKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCiAJCQlpZiAoc2RtYWMtPnBl
cmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9BU1JDX1NQIHx8DQogCQkJICAgIHNkbWFjLT5w
ZXJpcGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfQVNSQykNCiAJCQkJc2RtYV9zZXRfd2F0ZXJt
YXJrbGV2ZWxfZm9yX3AycChzZG1hYyk7DQotCQl9IGVsc2UNCisJCX0gZWxzZSB7DQorCQkJLyog
RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgbm8gZXJyYXRhIG5lZWQgKi8NCisJCQlpZiAo
c2RtYWMtPnBlcmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9DU1BJICYmDQorCQkJICAgIHNk
bWFjLT5kaXJlY3Rpb24gPT0gRE1BX01FTV9UT19ERVYgJiYNCisJCQkgICAgc2RtYWMtPnNkbWEt
PmRydmRhdGEtPmVjc3BpX2ZpeGVkKQ0KKwkJCQlfX3NldF9iaXQoMzEsICZzZG1hYy0+d2F0ZXJt
YXJrX2xldmVsKTsNCiAJCQlfX3NldF9iaXQoc2RtYWMtPmV2ZW50X2lkMCwgc2RtYWMtPmV2ZW50
X21hc2spOw0KKwkJfQ0KIA0KIAkJLyogQWRkcmVzcyAqLw0KIAkJc2RtYWMtPnNocF9hZGRyID0g
c2RtYWMtPnBlcl9hZGRyZXNzOw0KLS0gDQoyLjcuNA0KDQo=
