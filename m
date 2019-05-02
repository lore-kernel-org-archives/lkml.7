Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87ECC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB96A20675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kEVBJPmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEBIIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:08:36 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfEBIGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7PUOPhG0pA0jWDdcfQv9NZdpnckzyspBXeabEN7aa8=;
 b=kEVBJPmT42sruVifUsEaZlybZfGQJms/dNlN14qJCCSLi68xS6jnSATFT3/BuWZ2e3K3oq//g7pRAurPDiBJTXsq+fMGFK6UNsrph1pgw+b0oVuSIZGWLWJOx1EUDEQm90//tFMSXjOjiemWnDhktmklOwmL3vcLbVUn4X3MbKM=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:42 +0000
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
Subject: [PATCH v2 03/18] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Topic: [PATCH v2 03/18] clk: imx6q: Do not reparent uninitialized
 IMX6QDL_CLK_PERIPH2 clock
Thread-Index: AQHVAL36FVOgLCrgTk2aJfrH28ZViw==
Date:   Thu, 2 May 2019 08:06:42 +0000
Message-ID: <1556784376-7191-4-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: b40d0542-088f-4e6d-c8e2-08d6ced51c77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-microsoft-antispam-prvs: <AM0PR04MB456370EA40972576B928A4ACF6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(71200400001)(71190400001)(99286004)(8936002)(14454004)(76176011)(50226002)(11346002)(446003)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(486006)(476003)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KwwTc0xDw9v5gUm0fHfBqX08d49AsdLAqwMcs3aXhPDFbWy9lfz+xoPiV4Tl71N2tlngCWggEVxTKFM8dZ54TzpBhJ1RW3AWN70OJCyb7jgS774LJudXMyAI7GQIvlChQmDd7BrhSFV90TE19INYRiixesDlri4hVHzN6FqldgwVEKL3jjWgw715yHdY0OP1T2qClyRBYJJlp5/mXYPzl/jeq85CDpQteoqmeF/KNPjWCkmI6JzrZ2rZ4w37Dr5GxGAMqkDV9snhs+RYG86Vc90mMGGrVidMILwSo9TDcEt2U47h4kfg0Kzn9spI5TLDwxf4/gw9/BrUhcu2J6TI+tUt+5IR+kc3sMYJQjnsKa9CbuVWmPHE2cr048pNXS62PEAUFI29P5F8FkKyctZrAtNVWY9vDHC0Qx5iICFK4gM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40d0542-088f-4e6d-c8e2-08d6ced51c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:42.3600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNsb2NrIGlzIHJlZ2lzdGVyZWQgbGF0ZXIgdGhhbiB0aGVzZSB0d28gcmUtcGFyZW50aW5n
cy4NCg0KU2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvY2xrL2lteC9jbGstaW14NnEuYyB8IDggLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14
NnEuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnEuYw0KaW5kZXggNzA4ZTdjNS4uYzdiNjcx
ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnEuYw0KKysrIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg2cS5jDQpAQCAtMjkxLDEyICsyOTEsNiBAQCBzdGF0aWMgdm9pZCBt
bWRjX2NoMV9kaXNhYmxlKHZvaWQgX19pb21lbSAqY2NtX2Jhc2UpDQogCWNsa19zZXRfcGFyZW50
KGNsa1tJTVg2UURMX0NMS19QRVJJUEgyX0NMSzJfU0VMXSwNCiAJCSAgICAgICBjbGtbSU1YNlFE
TF9DTEtfUExMM19VU0JfT1RHXSk7DQogDQotCS8qDQotCSAqIEhhbmRzaGFrZSB3aXRoIG1tZGNf
Y2gxIG1vZHVsZSBtdXN0IGJlIG1hc2tlZCB3aGVuIGNoYW5naW5nDQotCSAqIHBlcmlwaDJfY2xr
X3NlbC4NCi0JICovDQotCWNsa19zZXRfcGFyZW50KGNsa1tJTVg2UURMX0NMS19QRVJJUEgyXSwg
Y2xrW0lNWDZRRExfQ0xLX1BFUklQSDJfQ0xLMl0pOw0KLQ0KIAkvKiBEaXNhYmxlIHBsbDNfc3df
Y2xrIGJ5IHNlbGVjdGluZyB0aGUgYnlwYXNzIGNsb2NrIHNvdXJjZSAqLw0KIAlyZWcgPSByZWFk
bF9yZWxheGVkKGNjbV9iYXNlICsgQ0NNX0NDU1IpOw0KIAlyZWcgfD0gQ0NTUl9QTEwzX1NXX0NM
S19TRUw7DQpAQCAtMzExLDggKzMwNSw2IEBAIHN0YXRpYyB2b2lkIG1tZGNfY2gxX3JlZW5hYmxl
KHZvaWQgX19pb21lbSAqY2NtX2Jhc2UpDQogCXJlZyA9IHJlYWRsX3JlbGF4ZWQoY2NtX2Jhc2Ug
KyBDQ01fQ0NTUik7DQogCXJlZyAmPSB+Q0NTUl9QTEwzX1NXX0NMS19TRUw7DQogCXdyaXRlbF9y
ZWxheGVkKHJlZywgY2NtX2Jhc2UgKyBDQ01fQ0NTUik7DQotDQotCWNsa19zZXRfcGFyZW50KGNs
a1tJTVg2UURMX0NMS19QRVJJUEgyXSwgY2xrW0lNWDZRRExfQ0xLX1BFUklQSDJfUFJFXSk7DQog
fQ0KIA0KIC8qDQotLSANCjIuNy40DQoNCg==
