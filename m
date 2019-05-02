Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4762089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HF6jVqTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:49 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfEBIGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iISrDjyAoc6TDYWK96wenQgzdLPqBXlHCjl2IjXhpn8=;
 b=HF6jVqTAfzDVon/M835T3fiXA4NM9KFH/VGmjzTb2vsWq0KYkVA0Zmx9xfYhgtPBCZrffpI3EOcJgwss81+HQm4XpInpS/Q4MzRod/GwuZAXBVwn3GFbCO2u7GTbmviLGQQeen3DPJJVJGnRL+pxfeSxo5NfFFAo4TzbxgS9Q70=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:40 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:40 +0000
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
Subject: [PATCH v2 01/18] clk: imx: Add imx_obtain_fixed_clock clk_hw based
 variant
Thread-Topic: [PATCH v2 01/18] clk: imx: Add imx_obtain_fixed_clock clk_hw
 based variant
Thread-Index: AQHVAL35/2k4N46H6UCnqYXwrcRJjg==
Date:   Thu, 2 May 2019 08:06:40 +0000
Message-ID: <1556784376-7191-2-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: d36d3cfd-22dc-4d71-fb72-08d6ced51b64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB45637E9F40459D4343A60AF5F6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(14444005)(486006)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8DLgjDcn4HIogCG4XchsY8es3GgkWMnJMWIdtw/YO0+D3k2taBFaLYaDw9NffmKvMxl+/H/qMU3+Xq2VPYsJ+DNF869EMTThWjHX7UYKdz/0WLYhnzfE4b1I/G/LPvXYpsaNL/YtEQTKE8/rxHaJvd7X9/94Afn+9BTO3Vf0n95z9BhvDEgtZ4Qcw6jDyOcPjVwduiQIy4XlcV2A5E1MmDE64bTkIVYsK1nTovv+SZE1ZUYhiG1bqTJi84Rp3a/Fje7UEGIqK3M3BvqxJvHWFfzDJgNfjWqNJ7KX2mf+vCv4OnvfIBrvPGUMbcR43W+JoGok3MYp2krg15QOVYic+hC9WjsihT2jhUIOKvcmWdHj//skhPSrd2WYgXk4thsw/ZF+57EwGPnRkYaF4E79RFMgnHHFy4WTSMq9w7qDCuU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36d3cfd-22dc-4d71-fb72-08d6ced51b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:40.4681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gb3JkZXIgdG8gbW92ZSB0byBjbGtfaHcgYmFzZWQgQVBJLCBpbXhfb2J0YWluX2ZpeGVkX2Ns
b2NrX2h3DQppcyBhZGRlZC4gVGhlIGVuZCBnb2FsIGhlcmUgaXMgdG8gaGF2ZSBhbGwgdGhlIGNs
ayBwcm92aWRlcnMgdXNlDQp0aGUgY2xrX2h3IGJhc2VkIEFQSS4NCg0KU2lnbmVkLW9mZi1ieTog
QWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGsu
YyB8IDExICsrKysrKysrKysrDQogZHJpdmVycy9jbGsvaW14L2Nsay5oIHwgIDMgKysrDQogMiBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9pbXgvY2xrLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCmluZGV4IDFlZmVkODYuLmQ5Y2U5
MTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCisrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGsuYw0KQEAgLTU5LDYgKzU5LDE3IEBAIHN0cnVjdCBjbGsgKiBfX2luaXQgaW14X29i
dGFpbl9maXhlZF9jbG9jaygNCiAJcmV0dXJuIGNsazsNCiB9DQogDQorc3RydWN0IGNsa19odyAq
IF9faW5pdCBpbXhfb2J0YWluX2ZpeGVkX2Nsb2NrX2h3KA0KKwkJCWNvbnN0IGNoYXIgKm5hbWUs
IHVuc2lnbmVkIGxvbmcgcmF0ZSkNCit7DQorCXN0cnVjdCBjbGsgKmNsazsNCisNCisJY2xrID0g
aW14X29idGFpbl9maXhlZF9jbG9ja19mcm9tX2R0KG5hbWUpOw0KKwlpZiAoSVNfRVJSKGNsaykp
DQorCQljbGsgPSBpbXhfY2xrX2ZpeGVkKG5hbWUsIHJhdGUpOw0KKwlyZXR1cm4gX19jbGtfZ2V0
X2h3KGNsayk7DQorfQ0KKw0KIHN0cnVjdCBjbGtfaHcgKiBfX2luaXQgaW14X29idGFpbl9maXhl
ZF9jbGtfaHcoc3RydWN0IGRldmljZV9ub2RlICpucCwNCiAJCQkJCSAgICAgICBjb25zdCBjaGFy
ICpuYW1lKQ0KIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmggYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLmgNCmluZGV4IDg2MzlhOGYuLmY3NmZhMjIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2Nsay9pbXgvY2xrLmgNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KQEAgLTk1LDYg
Kzk1LDkgQEAgc3RydWN0IGNsayAqY2xrX3JlZ2lzdGVyX2dhdGUyKHN0cnVjdCBkZXZpY2UgKmRl
diwgY29uc3QgY2hhciAqbmFtZSwNCiBzdHJ1Y3QgY2xrICogaW14X29idGFpbl9maXhlZF9jbG9j
aygNCiAJCQljb25zdCBjaGFyICpuYW1lLCB1bnNpZ25lZCBsb25nIHJhdGUpOw0KIA0KK3N0cnVj
dCBjbGtfaHcgKmlteF9vYnRhaW5fZml4ZWRfY2xvY2tfaHcoDQorCQkJY29uc3QgY2hhciAqbmFt
ZSwgdW5zaWduZWQgbG9uZyByYXRlKTsNCisNCiBzdHJ1Y3QgY2xrX2h3ICppbXhfb2J0YWluX2Zp
eGVkX2Nsa19odyhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KIAkJCQkgICAgICAgY29uc3QgY2hh
ciAqbmFtZSk7DQogDQotLSANCjIuNy40DQoNCg==
