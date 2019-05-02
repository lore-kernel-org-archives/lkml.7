Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7993920675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SVyAFJ4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEBIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:07:57 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbfEBIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Zd1hiv1LPfTMDOycuMddd4tHyWtWHZ25l35F1azSI=;
 b=SVyAFJ4VTDYncVbEopl2ssreS+nHOp1x8924XNh1g3OwzXpy3IltJ6++JlNEpZ7W71oZiKCXh0aCvhKmPGNEhryb4ryiGtUj9Y6UwZpEdw2E+ak1ah81nWiXcP9/rFtu7wm9RYyJYj9TWrfPQH9IYQymeno2BWELMwVDP+XNBQA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 06/18] clk: imx: clk-gate2: Switch to clk_hw based API
Thread-Topic: [PATCH v2 06/18] clk: imx: clk-gate2: Switch to clk_hw based API
Thread-Index: AQHVAL37v0rQ3S2aIkuHpd73wmKkow==
Date:   Thu, 2 May 2019 08:06:45 +0000
Message-ID: <1556784376-7191-7-git-send-email-abel.vesa@nxp.com>
References: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:800:60::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcc9db4e-760a-4cd2-1f73-08d6ced51e53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB456362CAB8411766D95114D8F6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(14444005)(486006)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0FZiW8EG3IL1CjWJkITmeChqQbxkbuO/8s7bts7M4DL2AFRsOi4EXg4qh3Kbo9YzO9KsnAQMUoFWzlgei/QE3zUEJCYFX/1IgkmfHlh+wnlubGIzQfCNqvJ+5h8lSz0NUMHC9xFW4rT6xTza+NzDud9QvmEhoqmcZ6r//zXplHR5bqZFU0EiNBo2W+kikdQm3E/EHp6lKiw1bgLcWR2Bz7EB61ClRmZIEMCNY/45ltbjcapJesZKaTqbLsYOx/j3ALlSnEFQJanI95zdZWr13Vov8R3c7fAMuJwUPy5n4rM2euiETMgMpmP21Ogpz2NnX5VA+0bUnKb3/mYyK1vJii1l/0M/OyAOhFTA9P34vwfY1paGrNO8mosBrUFPYVCHCw5x5E6yL0N8E1k5w/DOPsSLLkohK3P27TTE6xekVE4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc9db4e-760a-4cd2-1f73-08d6ced51e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:45.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBjbGtfcmVnaXN0ZXJfZ2F0ZTIgZnVuY3Rpb24gdG8gY2xrX2h3IGJhc2VkIEFQ
SSwgcmVuYW1lDQphY2NvcmRpbmdseSBhbmQgYWRkIGEgbWFjcm8gZm9yIGNsayBiYXNlZCBsZWdh
Y3kuIFRoaXMgYWxsb3dzIHVzIHRvDQptb3ZlIGNsb3NlciB0byBhIGNsZWFyIHNwbGl0IGJldHdl
ZW4gY29uc3VtZXIgYW5kIHByb3ZpZGVyIGNsayBBUElzLg0KDQpTaWduZWQtb2ZmLWJ5OiBBYmVs
IFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1nYXRl
Mi5jIHwgMTQgKysrKysrKysrLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLmggICAgICAgfCAg
NyArKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1nYXRlMi5jIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay1nYXRlMi5jDQppbmRleCA2MGZjOWQ3Li4xNDU1MWZkMyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY2xrL2lteC9jbGstZ2F0ZTIuYw0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Ns
ay1nYXRlMi5jDQpAQCAtMTI1LDE1ICsxMjUsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtf
b3BzIGNsa19nYXRlMl9vcHMgPSB7DQogCS5pc19lbmFibGVkID0gY2xrX2dhdGUyX2lzX2VuYWJs
ZWQsDQogfTsNCiANCi1zdHJ1Y3QgY2xrICpjbGtfcmVnaXN0ZXJfZ2F0ZTIoc3RydWN0IGRldmlj
ZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KK3N0cnVjdCBjbGtfaHcgKmNsa19od19yZWdpc3Rl
cl9nYXRlMihzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQogCQljb25zdCBj
aGFyICpwYXJlbnRfbmFtZSwgdW5zaWduZWQgbG9uZyBmbGFncywNCiAJCXZvaWQgX19pb21lbSAq
cmVnLCB1OCBiaXRfaWR4LCB1OCBjZ3JfdmFsLA0KIAkJdTggY2xrX2dhdGUyX2ZsYWdzLCBzcGlu
bG9ja190ICpsb2NrLA0KIAkJdW5zaWduZWQgaW50ICpzaGFyZV9jb3VudCkNCiB7DQogCXN0cnVj
dCBjbGtfZ2F0ZTIgKmdhdGU7DQotCXN0cnVjdCBjbGsgKmNsazsNCisJc3RydWN0IGNsa19odyAq
aHc7DQogCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQ7DQorCWludCByZXQ7DQogDQogCWdhdGUg
PSBremFsbG9jKHNpemVvZihzdHJ1Y3QgY2xrX2dhdGUyKSwgR0ZQX0tFUk5FTCk7DQogCWlmICgh
Z2F0ZSkNCkBAIC0xNTQsMTAgKzE1NSwxMyBAQCBzdHJ1Y3QgY2xrICpjbGtfcmVnaXN0ZXJfZ2F0
ZTIoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KIAlpbml0Lm51bV9wYXJl
bnRzID0gcGFyZW50X25hbWUgPyAxIDogMDsNCiANCiAJZ2F0ZS0+aHcuaW5pdCA9ICZpbml0Ow0K
KwlodyA9ICZnYXRlLT5odzsNCiANCi0JY2xrID0gY2xrX3JlZ2lzdGVyKGRldiwgJmdhdGUtPmh3
KTsNCi0JaWYgKElTX0VSUihjbGspKQ0KKwlyZXQgPSBjbGtfaHdfcmVnaXN0ZXIoTlVMTCwgaHcp
Ow0KKwlpZiAocmV0KSB7DQogCQlrZnJlZShnYXRlKTsNCisJCXJldHVybiBFUlJfUFRSKHJldCk7
DQorCX0NCiANCi0JcmV0dXJuIGNsazsNCisJcmV0dXJuIGh3Ow0KIH0NCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9pbXgvY2xrLmggYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCmluZGV4IDk5NmRj
YzYuLmM4MTljZTE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay5oDQorKysgYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLmgNCkBAIC01OCw2ICs1OCwxMSBAQCBzdHJ1Y3QgaW14X3BsbDE0
eHhfY2xrIHsNCiAjZGVmaW5lIGlteF9jbGtfY3B1KG5hbWUsIHBhcmVudF9uYW1lLCBkaXYsIG11
eCwgcGxsLCBzdGVwKSBcDQogCWlteF9jbGtfaHdfY3B1KG5hbWUsIHBhcmVudF9uYW1lLCBkaXYs
IG11eCwgcGxsLCBzdGVwKS0+Y2xrDQogDQorI2RlZmluZSBjbGtfcmVnaXN0ZXJfZ2F0ZTIoZGV2
LCBuYW1lLCBwYXJlbnRfbmFtZSwgZmxhZ3MsIHJlZywgYml0X2lkeCwgXA0KKwkJCQljZ3JfdmFs
LCBjbGtfZ2F0ZV9mbGFncywgbG9jaywgc2hhcmVfY291bnQpIFwNCisJY2xrX2h3X3JlZ2lzdGVy
X2dhdGUyKGRldiwgbmFtZSwgcGFyZW50X25hbWUsIGZsYWdzLCByZWcsIGJpdF9pZHgsIFwNCisJ
CQkJY2dyX3ZhbCwgY2xrX2dhdGVfZmxhZ3MsIGxvY2ssIHNoYXJlX2NvdW50KS0+Y2xrDQorDQog
c3RydWN0IGNsayAqaW14X2Nsa19wbGwxNHh4KGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIg
KnBhcmVudF9uYW1lLA0KIAkJIHZvaWQgX19pb21lbSAqYmFzZSwgY29uc3Qgc3RydWN0IGlteF9w
bGwxNHh4X2NsayAqcGxsX2Nsayk7DQogDQpAQCAtOTYsNyArMTAxLDcgQEAgc3RydWN0IGNsayAq
aW14X2Nsa19wbGx2MyhlbnVtIGlteF9wbGx2M190eXBlIHR5cGUsIGNvbnN0IGNoYXIgKm5hbWUs
DQogc3RydWN0IGNsa19odyAqaW14X2Nsa19wbGx2NChjb25zdCBjaGFyICpuYW1lLCBjb25zdCBj
aGFyICpwYXJlbnRfbmFtZSwNCiAJCQkgICAgIHZvaWQgX19pb21lbSAqYmFzZSk7DQogDQotc3Ry
dWN0IGNsayAqY2xrX3JlZ2lzdGVyX2dhdGUyKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hh
ciAqbmFtZSwNCitzdHJ1Y3QgY2xrX2h3ICpjbGtfaHdfcmVnaXN0ZXJfZ2F0ZTIoc3RydWN0IGRl
dmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KIAkJY29uc3QgY2hhciAqcGFyZW50X25hbWUs
IHVuc2lnbmVkIGxvbmcgZmxhZ3MsDQogCQl2b2lkIF9faW9tZW0gKnJlZywgdTggYml0X2lkeCwg
dTggY2dyX3ZhbCwNCiAJCXU4IGNsa19nYXRlX2ZsYWdzLCBzcGlubG9ja190ICpsb2NrLA0KLS0g
DQoyLjcuNA0KDQo=
