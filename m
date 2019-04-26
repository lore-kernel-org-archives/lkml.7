Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9968208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="grYNcojw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDZIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:34 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:28900
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfDZIFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfwnvc3K8QGX0wDh9tfJHNbMun62ZXLaxv+aLZ1evlc=;
 b=grYNcojwYQln1xtvT4eiv13lnPwwAyLOLKqgt96+skuY1GciRpOH2uCUHWOX65eCLBiKQnrshxMRnB9g0IHOJdc/d8xiwTd4oNxc4nqO8MYHZYPS3LZSkva4KrC/Qc4OerUd/976EJ0nWicYEyXQuu0DR8sMlFHsspZvQ1Gg2s0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.49.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:28 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:28 +0000
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
Subject: [PATCH v2 04/15] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Topic: [PATCH v2 04/15] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Thread-Index: AQHU/AbP1rsXnGb6N0CwHad5RS36+g==
Date:   Fri, 26 Apr 2019 08:05:28 +0000
Message-ID: <1556265512-9130-5-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 28010d20-070c-4513-eac6-08d6ca1df1da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4830;
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-microsoft-antispam-prvs: <VI1PR04MB4830AF71AC04B7C754AA03DE893E0@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(36756003)(54906003)(81156014)(50226002)(8676002)(81166006)(8936002)(386003)(26005)(97736004)(2501003)(6506007)(4326008)(316002)(86362001)(3846002)(110136005)(6116002)(11346002)(6436002)(446003)(256004)(66066001)(2906002)(99286004)(52116002)(476003)(5660300002)(186003)(71190400001)(2616005)(25786009)(14454004)(7416002)(53936002)(71200400001)(486006)(305945005)(64756008)(66556008)(6512007)(73956011)(66446008)(478600001)(66476007)(2201001)(102836004)(68736007)(66946007)(4744005)(76176011)(6486002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y5PUfRzZ14bGprCQjiMpT6O12BWaHZc2JftOZn/5/vUylSEcAH68M3+ky4TkT4TElhuETXLARgLcZp2gqpUdUpyTEgubpBOe1kT42h+pN12HSMTPaAN2Uj4OA8hJSuF+svKcARsfhIbqZdVWhhEPSlrj9sgnorh8hHGKlsUpp/qeF7EcwiXieBWw9PYWlnWXNx+0k0V9r82O6y7BXjRjaSpHdB4Hyzdr8Vykcop+BB+Rp53p0PhFdT+D7SMWNItu4fswPQp3/mvhZqw6Eek6Trtj2CJH/Nnuu7bcFDtdeqVyLTqws2yz2zTaMU7vxa66GdJIB7E3ILD3QmsAEChOrkQZz+bmDkLP82xprHJEW91D9iX5wBo/u0gIS9eoSBrMAtfBkemnwIC/+joioDU7lozseyDxQYYXyDsPJhVib78=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28010d20-070c-4513-eac6-08d6ca1df1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:28.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCA1ICstLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDQwN2E1NmUu
Ljg2YTMxYjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2
ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtMTEzNCw3ICsxMTM0LDYgQEAgc3RhdGljIHZvaWQgc2Rt
YV9zZXRfd2F0ZXJtYXJrbGV2ZWxfZm9yX3AycChzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYykN
CiBzdGF0aWMgaW50IHNkbWFfY29uZmlnX2NoYW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0K
IHsNCiAJc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19zZG1hX2NoYW4oY2hhbik7DQot
CWludCByZXQ7DQogDQogCXNkbWFfZGlzYWJsZV9jaGFubmVsKGNoYW4pOw0KIA0KQEAgLTExNzQs
OSArMTE3Myw3IEBAIHN0YXRpYyBpbnQgc2RtYV9jb25maWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4pDQogCQlzZG1hYy0+d2F0ZXJtYXJrX2xldmVsID0gMDsgLyogRklYTUU6IE0zX0JB
U0VfQUREUkVTUyAqLw0KIAl9DQogDQotCXJldCA9IHNkbWFfbG9hZF9jb250ZXh0KHNkbWFjKTsN
Ci0NCi0JcmV0dXJuIHJldDsNCisJcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9z
ZXRfY2hhbm5lbF9wcmlvcml0eShzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCi0tIA0KMi43
LjQNCg0K
