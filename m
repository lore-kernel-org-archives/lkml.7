Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52044C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184F120651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y81/puwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBIGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:51 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfEBIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX1zcMKRqIVg29mc/4nz3GvFhP8QLtpoN17PQAnAhZs=;
 b=Y81/puwhZVjeVHfLl4uDkNxeH3Nng9Z2Y4qTdpM+MI5yfTUYNbRBSeLxb0E5jVFLX2goA5WHrL44O3ot8/8ApStEX9LXwfQHamYbXc5YZbJ/oLb4BnRS+hK5M0F9UPrMusiQp23WwrtWeCUFC3Q15Gqfq+gzvQQOR8+fUKb38kg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:41 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:41 +0000
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
Subject: [PATCH v2 02/18] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Topic: [PATCH v2 02/18] clk: imx6sx: Do not reparent to unregistered
 IMX6SX_CLK_AXI
Thread-Index: AQHVAL35WmG4+8Wp/Ua+lzjPl71Z5A==
Date:   Thu, 2 May 2019 08:06:41 +0000
Message-ID: <1556784376-7191-3-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 457436e1-ab4b-4125-dbc4-08d6ced51bec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB456365DBA815BE3D5C01645BF6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(4744005)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(486006)(476003)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zK5XnEuHaVNWs+pNKI+TJuuKEK4Ngj9IeNQf/916f7QyCz1i5mavtxpUSLsU3gIfnrfd6xBZmSUuGCS4FrrpQPB6bB0V0FzzVAfwyuMwRtgo06mkVu91ObCklqlPubyQDG6Sbo6OWjOmTiwv37KOn0TTT32QUCjwEdnw2OYYBld3iLtp6c97nAD5kG9PFE6vCmLT0xsx0UawgorXPs7BGdTlRyFmq5tjt8gU4Lhc8j5L+NcMnXQRklnj4HZtM0LlKUComaChQvge2XxC6yiuH0HxaAOwmBLM6xjX0joVP3r5eGRndtnshRs1sRbXV5IhGhRYwaHZRN8UZooNX5dhabBSSPaoB6xUn2q9jYOu0yG17goiixy4hpgyavC77cjU0q8iqWuIATUtUumCULVutYQzYawGFjfnll8YQGy1VOo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457436e1-ab4b-4125-dbc4-08d6ced51bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:41.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNsb2NrIElNWDZTWF9DTEtfQVhJIGlzIG5vdCByZWdpc3RlcmVkIGF0IGFsbC4NCg0KU2ln
bmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Y2xrL2lteC9jbGstaW14NnN4LmMgfCAyIC0tDQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzeC5jIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg2c3guYw0KaW5kZXggOTE1NThiMC4uNGVkMTgwYyAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnN4LmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14NnN4LmMNCkBAIC01MTIsOCArNTEyLDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDZz
eF9jbG9ja3NfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKmNjbV9ub2RlKQ0KIAkvKiBTZXQgdGhl
IHBhcmVudCBjbGtzIG9mIFBDSWUgbHZkczEgYW5kIHBjaWVfYXhpIHRvIGJlIHBjaWUgcmVmLCBh
eGkgKi8NCiAJaWYgKGNsa19zZXRfcGFyZW50KGNsa3NbSU1YNlNYX0NMS19MVkRTMV9TRUxdLCBj
bGtzW0lNWDZTWF9DTEtfUENJRV9SRUZfMTI1TV0pKQ0KIAkJcHJfZXJyKCJGYWlsZWQgdG8gc2V0
IHBjaWUgYnVzIHBhcmVudCBjbGsuXG4iKTsNCi0JaWYgKGNsa19zZXRfcGFyZW50KGNsa3NbSU1Y
NlNYX0NMS19QQ0lFX0FYSV9TRUxdLCBjbGtzW0lNWDZTWF9DTEtfQVhJXSkpDQotCQlwcl9lcnIo
IkZhaWxlZCB0byBzZXQgcGNpZSBwYXJlbnQgY2xrLlxuIik7DQogDQogCS8qDQogCSAqIEluaXQg
ZW5ldCBzeXN0ZW0gQUhCIGNsb2NrLCBzZXQgdG8gMjAwTUh6DQotLSANCjIuNy40DQoNCg==
