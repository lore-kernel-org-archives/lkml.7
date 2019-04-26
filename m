Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A10C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A006D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IUvDw4yS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfDZIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:15 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:17411
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfDZIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UjQhbbFy/T++EXKpz6DWKpF/v1EFMO+s48zlvDjTsc=;
 b=IUvDw4ySXU0bkSiuUUTVpHTRHCInGW//fCCH3dV6DDh8crQ50NnpWzT6za8/EI8cKnNVQrVOFmxBJFZocdud9bvFpoPfZ1A2OzGxO/y19JOqbxHfeMuYxwnbA4YqQyHY/vCtSdNI7YDBiYwVwaHPa9k/RmcyUceJOgYm+4hOc/o=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:06:09 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:06:09 +0000
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
Subject: [PATCH v2 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work on
 i.mx8mm
Thread-Topic: [PATCH v2 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHU/AboNnaR79Yf70iMJSIYBzTGoQ==
Date:   Fri, 26 Apr 2019 08:06:09 +0000
Message-ID: <1556265512-9130-12-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 19d6d4ab-c627-4869-13bc-08d6ca1e0a79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-microsoft-antispam-prvs: <VI1PR04MB6109BB025A955D05F5DAAFB5893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(14444005)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t24skTUxrKZgve0BU5RhAFR+URKY/E5DD3gndNiQxHfDl+bmF1BP/Ge0yrgFBoWzhiG04sZib5zikzxEQnHU4FPpCgd98p8Hzr5cCISWPuWrS9j+khXj/TH4WBa/6cXtlSLARvt1hS5BlNGR4+g0oud+B0aHE9DzyaxaRwQyc47Fr5EMciufAeWE+hrNGjmgN5uEI5z00vsNo01qZDVUTZlCyfsEY+OPSWXgkoMYG9sHd1BgUv9/WGEYGsREVfqeeAYjz5rmUnBjj4CFUOfABrgaQKZ5ry7Ji1huo+5eWzRPnPdlJKM3BARyMCCnpeOTIFc10KnGI5Hzg9SveQIkAq98sWZ/g98rohjGaYo99cgsn0FeoQec4heESXTSuW1hkMSoPVXqRfd4Gc52DiI1SCW7//OsNdPIyZLDyb2hn6s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d6d4ab-c627-4869-13bc-08d6ca1e0a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:06:09.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRo
ZSBjb25kaXRpb24NCmNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBj
aGFubmVsIGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0
dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sgZXZlbnRfaWQwLCBjaGVja2luZw0KZXZlbnRfaWQxIGlz
IGVub3VnaCBmb3IgREVWXzJfREVWIGNhc2UgYmVjYXVzZSBpdCdzIHNvIGx1Y2t5IHRoYXQgZXZl
bnRfaWQxDQpuZXZlciBiZSAwLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5n
b25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTIgKysrKystLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQppbmRleCAzZTkxMmI2Li40YjJiN2NhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KQEAgLTEzNzEsOCArMTM3MSw4
IEBAIHN0YXRpYyB2b2lkIHNkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4g
KmNoYW4pDQogDQogCXNkbWFfY2hhbm5lbF9zeW5jaHJvbml6ZShjaGFuKTsNCiANCi0JaWYgKHNk
bWFjLT5ldmVudF9pZDApDQotCQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVu
dF9pZDApOw0KKwlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
Kw0KIAlpZiAoc2RtYWMtPmV2ZW50X2lkMSkNCiAJCXNkbWFfZXZlbnRfZGlzYWJsZShzZG1hYywg
c2RtYWMtPmV2ZW50X2lkMSk7DQogDQpAQCAtMTY3MSwxMSArMTY3MSw5IEBAIHN0YXRpYyBpbnQg
c2RtYV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpjaGFuLA0KIAltZW1jcHkoJnNkbWFjLT5zbGF2
ZV9jb25maWcsIGRtYWVuZ2luZV9jZmcsIHNpemVvZigqZG1hZW5naW5lX2NmZykpOw0KIA0KIAkv
KiBTZXQgRU5CTG4gZWFybGllciB0byBtYWtlIHN1cmUgZG1hIHJlcXVlc3QgdHJpZ2dlcmVkIGFm
dGVyIHRoYXQgKi8NCi0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCi0JCWlmIChzZG1hYy0+ZXZl
bnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLQkJCXJldHVybiAt
RUlOVkFMOw0KLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
LQl9DQorCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1f
ZXZlbnRzKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBz
ZG1hYy0+ZXZlbnRfaWQwKTsNCiANCiAJaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCiAJCWlmIChz
ZG1hYy0+ZXZlbnRfaWQxID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLS0g
DQoyLjcuNA0KDQo=
