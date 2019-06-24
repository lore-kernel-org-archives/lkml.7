Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB0C48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1563F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a4YAHAC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFXC0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:26:09 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:32782
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbfFXC0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuwY5M+LhzNtMX2fFp8HUfde8HKxnfuq2nGJMebwqwU=;
 b=a4YAHAC0xcpOdCkgp9SYHAH6PhncGSGV1mXnGE0PKHmxGXFduoWQY9JIM4axmq8ZW8MP1IfTGQGbNEfR4/Q7Q+t3zvR9iU1VEzn+i2WHQeSxc8bjPBcJ1pnyLXuTcQRlUNf5hptuEyv2jkCg/IoGod+Ua6Ikjh5+z9zzMz0PN4o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 02:26:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 02:26:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Topic: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Index: AQHVJ/+7WzrDWTethU+K40MoFm49OKaqFzaAgAAA3XA=
Date:   Mon, 24 Jun 2019 02:26:04 +0000
Message-ID: <DB3PR0402MB39160E3867ACE054098229B8F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon>
In-Reply-To: <20190624022200.GN3800@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d46b71f9-bafe-4f40-67d5-08d6f84b4f05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-microsoft-antispam-prvs: <DB3PR0402MB37393993549361114AB166C4F5E00@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(13464003)(102836004)(229853002)(256004)(6116002)(446003)(11346002)(305945005)(74316002)(7696005)(476003)(9686003)(6506007)(81166006)(81156014)(68736007)(486006)(44832011)(54906003)(66066001)(76176011)(55016002)(3846002)(7736002)(53546011)(6436002)(53936002)(2906002)(316002)(99286004)(6246003)(8936002)(4326008)(26005)(186003)(33656002)(8676002)(7416002)(25786009)(66556008)(66446008)(52536014)(73956011)(76116006)(66946007)(66476007)(64756008)(14454004)(5660300002)(86362001)(71200400001)(71190400001)(478600001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: upGZ5zHy7wHyBNgNGSgusdrvfpokECAdTlBCyOGj3SDwOnG/HIzSkn46DZp6TPldXqiXxQU5oZDQYAIVeVZyEfhom1MK6PgwGj9/OTbnh6KXhgrO8rIvTpO73JG1W4m54V3Do+hvdqdKp9O2V7Oq4sjt8PKnwuZLJO3XDLrllndOL2WGQIX35hWk+B1mi/USsF8upM/9+xeAZqZcMo0RkSsRLF4Q+SKCBCn71XKTFT75PTOlCBShGsd6D714lnLeCIIESM+2yloIIvZMUIpHP6SZolCOJ95S8omL8yv7g0G9ty8BpHG6Oa8wSmOrWuLfCeIwOfV6STbkAIUxfe8Y9scH67ZpM+x6V0FU+gPtmWEMYukYFwy7uR72ETm+RQDCmwSXoTXZPGHTtociXVzC3UkNKD/Bzl0KvX3pQ9G0+w8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46b71f9-bafe-4f40-67d5-08d6f84b4f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 02:26:04.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjQsIDIwMTkg
MTA6MjIgQU0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzog
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IG10dXJxdWV0dGVAYmF5
bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQu
Y3Jlc3RlekBueHAuY29tPjsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47
IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5i
YWx1dGFAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgQWJlbCBWZXNhDQo+
IDxhYmVsLnZlc2FAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGFybTY0OiBFbmFibGUg
VElNRVJfSU1YX1NZU19DVFIgZm9yIEFSQ0hfTVhDDQo+IHBsYXRmb3Jtcw0KPiANCj4gT24gRnJp
LCBKdW4gMjEsIDIwMTkgYXQgMDM6MDc6MTdQTSArMDgwMCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0K
PiA+IEFSQ0hfTVhDIHBsYXRmb3JtcyBuZWVkcyBzeXN0ZW0gY291bnRlciBhcyBicm9hZGNhc3Qg
dGltZXIgdG8gc3VwcG9ydA0KPiA+IGNwdWlkbGUsIGVuYWJsZSBpdCBieSBkZWZhdWx0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgfCAxICsNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9LY29uZmlnLnBsYXRmb3Jtcw0KPiA+IGIvYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3Jt
cyBpbmRleCA0Nzc4Yzc3Li5mNWU2MjNmIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvS2Nv
bmZpZy5wbGF0Zm9ybXMNCj4gPiArKysgYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+
ID4gQEAgLTE3Myw2ICsxNzMsNyBAQCBjb25maWcgQVJDSF9NWEMNCj4gPiAgCXNlbGVjdCBQTQ0K
PiA+ICAJc2VsZWN0IFBNX0dFTkVSSUNfRE9NQUlOUw0KPiA+ICAJc2VsZWN0IFNPQ19CVVMNCj4g
PiArCXNlbGVjdCBUSU1FUl9JTVhfU1lTX0NUUg0KPiANCj4gV2hlcmUgaXMgdGhhdCBkcml2ZXI/
DQoNClRoZSBkcml2ZXIgaXMgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtc3lzY3RyLmMs
IHNpbWlsYXIgZnVuY3Rpb24gYXMgR1BULg0KDQpUaGFua3MsDQpBbnNvbg0KDQo+IA0KPiBTaGF3
bg0KPiANCj4gPiAgCWhlbHANCj4gPiAgCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBB
Uk12OCBiYXNlZCBTb0NzIGluIHRoZQ0KPiA+ICAJICBOWFAgaS5NWCBmYW1pbHkuDQo+ID4gLS0N
Cj4gPiAyLjcuNA0KPiA+DQo=
