Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD47B20578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W77bfmC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEHK4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:56:21 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:28801
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfEHK4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inx5d25rd8G6Df9jrjb5Sa7t1OqRpA2ZrIRCEqAyGGc=;
 b=W77bfmC4mMlax66fYrZaNK/GouS7bqb3/mgnDue1lbAoxOoMHty7TqpiImUdlBKG+8rLToO5m4cF7t0oHIEiIuXZok0HZd1zb1Ij1ivivc3/MUTFQuVbswIH+y8EABk3Dh0FV56kCoHgDx7O0qkAY1QJP3H+73gOBWASlXPvuxk=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB5762.eurprd04.prod.outlook.com (20.178.117.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:56:15 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:56:15 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
Thread-Topic: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
Thread-Index: AQHVBYyobLWsdGwT6EecAzQIJ3ESOw==
Date:   Wed, 8 May 2019 10:56:15 +0000
Message-ID: <20190508105755.5881-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To AM0PR04MB4865.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78fd17f4-e5d9-465a-55ab-08d6d3a3ca89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5762;
x-ms-traffictypediagnostic: AM0PR04MB5762:
x-microsoft-antispam-prvs: <AM0PR04MB57628E35BBF13BD4FA69A8FEE2320@AM0PR04MB5762.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(136003)(346002)(189003)(199004)(2906002)(6486002)(7736002)(53936002)(6436002)(2501003)(71200400001)(36756003)(71190400001)(14454004)(305945005)(478600001)(6512007)(4326008)(1076003)(6116002)(3846002)(5660300002)(66066001)(86362001)(2201001)(8676002)(81156014)(81166006)(316002)(476003)(102836004)(486006)(50226002)(66946007)(110136005)(66476007)(73956011)(66446008)(66556008)(64756008)(8936002)(68736007)(99286004)(25786009)(14444005)(256004)(54906003)(26005)(52116002)(6506007)(186003)(386003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5762;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tnqYuSZdJfBR5LmEtVmt629o+RSgdnlH/ki+XVqrk0sHrY3UUfaKFbUHn+0GEzifDVodT5tlssYkNGx0K7z0vf7OyINcSVBl3Y3fu8ayHRPeMQgZ+/6td/JpokDYOUWGBV2wg+gSV88lygO9TxM70f/F4naEPH+2Ey5i94I/YDZOze6WSpC141ndNgogpCMbwo0mHgC/jUX0vPVt8j8VzhC2EDganeiASdrGkhgSoeWrKC+r56nQm73WJKPEBCabGbcZ96+oqad+YUrSil1FDcXpIAR5q1MzBZ9ALlWHw1jpgHKt+heAPtNCntx6RZ/ZgTgdbv4YUK6OsBJo8E1jAyuX9drSjDGtDI/oXpfQAxilPbL4v/UMT6wcuOhM9fCHAHv7T8YXeSb7SrivAvXm+6VC49TGgTAeEvrnfINPo4U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fd17f4-e5d9-465a-55ab-08d6d3a3ca89
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:56:15.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG5ldyBMUzEwMjhBIERQIGRyaXZlciBjb2RlIGNhdXNlcyBhIGxpbmsgZmFpbHVyZSB3aGVu
IERSTV9JTVggYnVpbHQtaW4sDQpidXQgcGxhdGZvcm0gaXMgQVJDSF9MQVlFUlNDQVBFOg0KDQpk
cml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYzo1MTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgaXB1X3ByZ19lbmFibGUnDQpkcml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYzo1Mjog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgaXB1X2RjX2VuYWJsZScNCmRyaXZlcnMvZ3B1L2RybS9p
bXgvaXB1djMtY3J0Yy5jOjUzOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpcHVfZGNfZW5hYmxl
X2NoYW5uZWwnDQpkcml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYzo1NDogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgaXB1X2RpX2VuYWJsZScNCmRyaXZlcnMvZ3B1L2RybS9pbXgvaXB1djMt
Y3J0Yy5vOiBJbiBmdW5jdGlvbiBgaXB1X2NydGNfbW9kZV9zZXRfbm9mYg0KDQpBZGRpbmcgYSBL
Y29uZmlnIGRlcGVuZGVuY3kgYWxsb3cgdG8gYnVpbGQgaWYgQVJDSF9MQVlFUlNDQVBFIGlzIGVu
YWJsZS4NCg0KU2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvaXB1LXYzL0tjb25maWcgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9pcHUt
djMvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2lwdS12My9LY29uZmlnDQppbmRleCBmZTZmOGM1YjQ0
NDUuLjUxZWE4OGM0NDBkZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2lwdS12My9LY29uZmln
DQorKysgYi9kcml2ZXJzL2dwdS9pcHUtdjMvS2NvbmZpZw0KQEAgLTEsNiArMSw2IEBADQogY29u
ZmlnIElNWF9JUFVWM19DT1JFDQogCXRyaXN0YXRlICJJUFV2MyBjb3JlIHN1cHBvcnQiDQotCWRl
cGVuZHMgb24gU09DX0lNWDUgfHwgU09DX0lNWDZRIHx8IEFSQ0hfTVVMVElQTEFURk9STSB8fCBD
T01QSUxFX1RFU1QNCisJZGVwZW5kcyBvbiBTT0NfSU1YNSB8fCBTT0NfSU1YNlEgfHwgQVJDSF9N
VUxUSVBMQVRGT1JNIHx8IENPTVBJTEVfVEVTVCB8fCBBUkNIX0xBWUVSU0NBUEUNCiAJZGVwZW5k
cyBvbiBEUk0gfHwgIURSTSAjIGlmIERSTT1tLCB0aGlzIGNhbid0IGJlICd5Jw0KIAlzZWxlY3Qg
QklUUkVWRVJTRQ0KIAlzZWxlY3QgR0VORVJJQ19BTExPQ0FUT1IgaWYgRFJNDQotLSANCjIuMTcu
MQ0KDQo=
