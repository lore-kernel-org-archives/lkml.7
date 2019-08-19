Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D5C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA7921773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="czWX7YY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfHSBFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:05:46 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:52189
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfHSBFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwh2fnOgZ6dlW0zMIjJpYRkRLZ8QLFb12+xWGUI+j5w52y2YKxXgDPtiLrInhZN2VId6d1McavYCrNyTF0u1iYQ6FMmxFl6cje5v/JqSxfqRFlkYxiw1ZoNBMicgz6+zlS1Z/S2cLJ3CkVSEmACnfmq9HkPgSiBUYdNXvmbgB+zYKowHfpG4z2jZQbYCloVfcr+3XKHSFjFpZJIOP3PhNo9wgcxveCXi9m02J55h7i8SnMt8Ll9i2f+rywkM8dRCeO9wAtPeInV51gReVyyh8AxJHwGksJMsL+piigIqaG56z3BeNEUxg8eTB+gpiQVMDtWg455KfdmdXGWTj76CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuAwhqBZoHAk+l/EB0D+UitonTnbToH6xnoQKDZkYsk=;
 b=kCG5it5g8Fz+sEP8z5I7euIiOBKCa6cTHh4lHailw4/BBmNJhMpkvstUZ+TZG9jdI5toKj9ncPOCS3D90J583fWYmMEN5HVHzEpIFaoxg6QMFSBq4bMjzCl5A4gGdwnqRqEPmz4VT+iMw9KpBqodsgZfCo0ZZOWiAA8NzxKGmTw1RI3DVZu9W/WksOTnERUHobkVwfRoufHVQYC4dJNFejBc6E0axa8jHv3FDJz6ox9P0bdxl2t2uHqm2MKy/PL+OZE1sAei5hIN4yyLC9GoynBGv6AeDnd5XSjxmNp0ogT6MHK7DGZ7Z5j3rOIj7YkCTMY0mBdpdVQdJv8pprstyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuAwhqBZoHAk+l/EB0D+UitonTnbToH6xnoQKDZkYsk=;
 b=czWX7YY/vmXBFU7r8vQXeHkTzx1kOz1s2vAan4suVcS68dAQ8Qky11ASpkJ/iLX31OiXoaPcxKpjno7kYNJNN/WASBvR8UkfsNWeTqALMXL1DqKkItd5ITtBPIXpZ8nqtLewOC7i73WraztllmOIbnOrdmN/t/YR/L3LGjTFYg8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5764.eurprd04.prod.outlook.com (20.178.202.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 01:05:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 01:05:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx8mn: fix int pll clk gate
Thread-Topic: [PATCH] clk: imx8mn: fix int pll clk gate
Thread-Index: AQHVUkRsRiUHuSVFHEaIh1LaSAH7AKb+FRQAgAOallA=
Date:   Mon, 19 Aug 2019 01:05:42 +0000
Message-ID: <AM0PR04MB4481D73817CFCB7491DE89CB88A80@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190814015312.11711-1-peng.fan@nxp.com>
 <20190816180246.D37BD20665@mail.kernel.org>
In-Reply-To: <20190816180246.D37BD20665@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2da7ba08-59ff-4e27-661f-08d724415bec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5764;
x-ms-traffictypediagnostic: AM0PR04MB5764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5764E36C5F35D6ECB7A4A86388A80@AM0PR04MB5764.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(2906002)(54906003)(11346002)(4326008)(110136005)(71200400001)(74316002)(186003)(6506007)(5660300002)(4744005)(476003)(6116002)(256004)(76176011)(7696005)(446003)(102836004)(71190400001)(3846002)(25786009)(6246003)(8676002)(478600001)(486006)(33656002)(26005)(86362001)(53936002)(64756008)(76116006)(44832011)(14454004)(66476007)(66556008)(8936002)(316002)(66946007)(9686003)(2201001)(66446008)(81166006)(81156014)(66066001)(229853002)(7736002)(99286004)(305945005)(55016002)(2501003)(52536014)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5764;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dX0y0DyABKpHz3upbgezRkEnmhQCZYZgzI7m4BGAR9CymFEUo1Sd+iQetjFjMzKIRUY4rImrYxVdrHaMdXnpHkRtv/luwXU1XZhk8o9685t0s3bA8XubX1yN8/PD9iyN9jclz0Ud7DaX5OAR5KyUI2Zn/XXmZAQrgI93nWcUwBmhCLy/5U8aXL6fr9XH1jiiEWdfcmYyxtMCbO2FeR2UGpF77DaVI4eas9yGlVghpqO2uWl3Qsa3WvyIBGEGx7hR/AWxhh4DmJ+R/9i+08vcgvPNGYj64/tuoUHnRzwhAbPqtUyD+uGSMIIA2MLz6owm+dLufD8cUKk4pZF4xnpUq7aa79L52QgvgC3H2Vc5zUv1a558fZYE9zQmLXv738KSXzf6dDfBX8bH1AuRgBCXzXuEVxXUYplnS/ev1K+QgM8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da7ba08-59ff-4e27-661f-08d724415bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 01:05:42.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCJy2ziF6tiABM5vvvkEi9lMJuCbKCYYpuBQwy0OPyV6V06ryxTZ5xTCvaOwU5DoCF5J56CU64bsReZ0o5/ZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDhtbjogZml4IGlu
dCBwbGwgY2xrIGdhdGUNCj4gDQo+IFF1b3RpbmcgcGVuZy5mYW5AbnhwLmNvbSAoMjAxOS0wOC0x
MyAxODo1MzoxMikNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0K
PiA+IFRvIEZyYWMgcGxsLCB0aGUgZ2F0ZSBzaGlmdCBpcyAxMywgaG93ZXZlciB0byBJbnQgUExM
IHRoZSBnYXRlIHNoaWZ0DQo+ID4gaXMgMTEuDQo+ID4NCj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+DQo+ID4gRml4ZXM6IDk2ZDYzOTJiNTRkYiAoImNsazogaW14OiBBZGQgc3VwcG9y
dCBmb3IgaS5NWDhNTiBjbG9jayBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBKYWNreSBCYWkgPHBpbmcuYmFp
QG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBUaGlzIGlzIGEgZml4IGZvciBhIGNoYW5nZSBpbiAt
bmV4dC4gV2h5IGlzIHN0YWJsZSBDY2VkPw0KDQpTb3JyeSwgdGhhdCB3YXMgYWRkZWQgYnkgbWlz
dGFrZW4uIFNob3VsZCBJIHJlc2VuZCB2MiB0byBkcm9wIGl0Pw0KDQpUaGFua3MsDQpQZW5nLg0K
DQo=
