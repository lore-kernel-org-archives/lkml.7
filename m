Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B26BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C74B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pIWzDcVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEBIG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:59 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEBIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF9uHNOS2uLHLx0k6rAAqNW/V9aASYd5kznhvt4+XTM=;
 b=pIWzDcVeREznlL0sbCGWd3u8cBLm3zOiCPKaCXfhTE5LIHNKOY7KJIVxUe9pGCEZqmLt9aK28Rwygr4g+3PXppia6zY1I/6sEmBMrU6R7adwihMlhl9k8HH4PmyEdpVgAS4mUXuFhDsb88+t+XvoP0skXihpB1rvGsz0D1W+NeE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:44 +0000
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
Subject: [PATCH v2 05/18] clk: imx: clk-cpu: Switch to clk_hw based API
Thread-Topic: [PATCH v2 05/18] clk: imx: clk-cpu: Switch to clk_hw based API
Thread-Index: AQHVAL37FpiL5xT6JUqEET5f3vjLMA==
Date:   Thu, 2 May 2019 08:06:44 +0000
Message-ID: <1556784376-7191-6-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 04c2db65-7541-4b68-181b-08d6ced51dcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB456322771AA82628FA77A373F6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(14444005)(486006)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5+yV+yODsI/vqluS82qm+y+fHvti68kL3ldr57F8Hc7vzYjRX5ciFAe0uAe8/E2EBJctAXaMNd1G5QmvGwdbSBDoAzWeqwMmf7kXtqnLW3qMXT24Fq7sadEVNlXjLGCxG8mAmtyZnxW+cyz1KsKu3v+BVcDi40CIw6+m6R916IhMPKqd6sCFSRog14K4vGZ3f61Jokx3iR1iJHm9rGIaPfsNe6obbuzTnaHEqKXB65ZN3n0qfwN3WIQ3m2nkMh/sAVvhJXJICyopmzp/dJ3yK1INtOfmx4QmLnuYu4eCaW/p+8C4qEfQfja8s5TjwpqZFvx1511el2aSZr+HF6aPKHSKpGgts2Xij6xyY8u1puKGRl1F5uJKCqj1tNecfRmHOnBl8vKRk5cnxVWdNRIFCT8Jj54f8mmAu0JaWXx2COQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2db65-7541-4b68-181b-08d6ced51dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:44.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBjbGtfY3B1IGNsb2NrIHJlZ2lzdGVyaW5nIGZ1bmN0aW9uIHRvIGNsa19odyBi
YXNlZCBBUEkgYW5kIGFkZA0KYSBtYWNybyBmb3IgY2xrIGJhc2VkIGxlZ2FjeS4gVGhpcyBhbGxv
d3MgdXMgdG8gbW92ZSBjbG9zZXIgdG8gYSBjbGVhcg0Kc3BsaXQgYmV0d2VlbiBjb25zdW1lciBh
bmQgcHJvdmlkZXIgY2xrIEFQSXMuDQoNClNpZ25lZC1vZmYtYnk6IEFiZWwgVmVzYSA8YWJlbC52
ZXNhQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWNwdS5jIHwgMTQgKysrKysr
KysrLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLmggICAgIHwgIDUgKysrKy0NCiAyIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNwdS5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1jcHUuYw0K
aW5kZXggZWQxYjdlOS4uYTdiOTAwNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
Y3B1LmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstY3B1LmMNCkBAIC03NSwxMyArNzUsMTQg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIGNsa19jcHVfb3BzID0gew0KIAkuc2V0X3Jh
dGUJPSBjbGtfY3B1X3NldF9yYXRlLA0KIH07DQogDQotc3RydWN0IGNsayAqaW14X2Nsa19jcHUo
Y29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25hbWUsDQorc3RydWN0IGNsa19o
dyAqaW14X2Nsa19od19jcHUoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25h
bWUsDQogCQlzdHJ1Y3QgY2xrICpkaXYsIHN0cnVjdCBjbGsgKm11eCwgc3RydWN0IGNsayAqcGxs
LA0KIAkJc3RydWN0IGNsayAqc3RlcCkNCiB7DQogCXN0cnVjdCBjbGtfY3B1ICpjcHU7DQotCXN0
cnVjdCBjbGsgKmNsazsNCisJc3RydWN0IGNsa19odyAqaHc7DQogCXN0cnVjdCBjbGtfaW5pdF9k
YXRhIGluaXQ7DQorCWludCByZXQ7DQogDQogCWNwdSA9IGt6YWxsb2Moc2l6ZW9mKCpjcHUpLCBH
RlBfS0VSTkVMKTsNCiAJaWYgKCFjcHUpDQpAQCAtOTksMTAgKzEwMCwxMyBAQCBzdHJ1Y3QgY2xr
ICppbXhfY2xrX2NwdShjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICpwYXJlbnRfbmFtZSwN
CiAJaW5pdC5udW1fcGFyZW50cyA9IDE7DQogDQogCWNwdS0+aHcuaW5pdCA9ICZpbml0Ow0KKwlo
dyA9ICZjcHUtPmh3Ow0KIA0KLQljbGsgPSBjbGtfcmVnaXN0ZXIoTlVMTCwgJmNwdS0+aHcpOw0K
LQlpZiAoSVNfRVJSKGNsaykpDQorCXJldCA9IGNsa19od19yZWdpc3RlcihOVUxMLCBodyk7DQor
CWlmIChyZXQpIHsNCiAJCWtmcmVlKGNwdSk7DQorCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KKwl9
DQogDQotCXJldHVybiBjbGs7DQorCXJldHVybiBodzsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbGsvaW14L2Nsay5oIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQppbmRleCBlYWQ2NjhlMS4u
OTk2ZGNjNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KKysrIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay5oDQpAQCAtNTUsNiArNTUsOSBAQCBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xr
IHsNCiAjZGVmaW5lIGlteF9jbGtfYnVzeV9tdXgobmFtZSwgcmVnLCBzaGlmdCwgd2lkdGgsIGJ1
c3lfcmVnLCBidXN5X3NoaWZ0LCBwYXJlbnRfbmFtZXMsIG51bV9wYXJlbnRzKSBcDQogCWlteF9j
bGtfaHdfYnVzeV9tdXgobmFtZSwgcmVnLCBzaGlmdCwgd2lkdGgsIGJ1c3lfcmVnLCBidXN5X3No
aWZ0LCBwYXJlbnRfbmFtZXMsIG51bV9wYXJlbnRzKS0+Y2xrDQogDQorI2RlZmluZSBpbXhfY2xr
X2NwdShuYW1lLCBwYXJlbnRfbmFtZSwgZGl2LCBtdXgsIHBsbCwgc3RlcCkgXA0KKwlpbXhfY2xr
X2h3X2NwdShuYW1lLCBwYXJlbnRfbmFtZSwgZGl2LCBtdXgsIHBsbCwgc3RlcCktPmNsaw0KKw0K
IHN0cnVjdCBjbGsgKmlteF9jbGtfcGxsMTR4eChjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFy
ICpwYXJlbnRfbmFtZSwNCiAJCSB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IHN0cnVjdCBpbXhf
cGxsMTR4eF9jbGsgKnBsbF9jbGspOw0KIA0KQEAgLTM4Myw3ICszODYsNyBAQCBzdGF0aWMgaW5s
aW5lIHN0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfbXV4X2ZsYWdzKGNvbnN0IGNoYXIgKm5hbWUs
DQogCQkJCSAgIHJlZywgc2hpZnQsIHdpZHRoLCAwLCAmaW14X2NjbV9sb2NrKTsNCiB9DQogDQot
c3RydWN0IGNsayAqaW14X2Nsa19jcHUoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFy
ZW50X25hbWUsDQorc3RydWN0IGNsa19odyAqaW14X2Nsa19od19jcHUoY29uc3QgY2hhciAqbmFt
ZSwgY29uc3QgY2hhciAqcGFyZW50X25hbWUsDQogCQlzdHJ1Y3QgY2xrICpkaXYsIHN0cnVjdCBj
bGsgKm11eCwgc3RydWN0IGNsayAqcGxsLA0KIAkJc3RydWN0IGNsayAqc3RlcCk7DQogDQotLSAN
CjIuNy40DQoNCg==
