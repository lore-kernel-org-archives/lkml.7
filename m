Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50861C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CA208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cOsBxNTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEFJan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:30:43 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:44422
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfEFJam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/yr2+4XgjIt1yrCvauc3hlwLoU8NfQKnNtZbh1xxfQ=;
 b=cOsBxNThBJkGV96SyAPJULHYVa7eX7j1mgq/Wl2CukzQt3hqAPEa/p/cIWr6Jq6yDVfLLWvovolokT0UmO9Z9FQSCwBuplvh39QtgGUsh201lrI2nGIpOY6z59aNqq6X/JdFZyGGEf5s5ZshZTkRpk9LWOrYYUbYhNIkL4tDN+w=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 09:30:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:30:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] clk: imx8mm: add GPIO clocks to clock tree
Thread-Topic: [PATCH 2/3] clk: imx8mm: add GPIO clocks to clock tree
Thread-Index: AQHVA+yijIxFAG0DFkm3jMwYHPVMnqZd1MOw
Date:   Mon, 6 May 2019 09:30:38 +0000
Message-ID: <AM0PR04MB4211EBC80C4A821BEDBF203C80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
 <1557133994-5061-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557133994-5061-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea4548e8-6850-4955-f002-08d6d2058016
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-microsoft-antispam-prvs: <AM0PR04MB45158CBA0C844EDA5592477380300@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(478600001)(6436002)(2501003)(7696005)(66946007)(66476007)(66446008)(66556008)(64756008)(25786009)(55016002)(9686003)(52536014)(76176011)(316002)(256004)(3846002)(6116002)(229853002)(476003)(446003)(11346002)(486006)(99286004)(81166006)(81156014)(186003)(8676002)(8936002)(7736002)(68736007)(71190400001)(305945005)(33656002)(74316002)(6246003)(6506007)(53546011)(14454004)(7416002)(102836004)(53936002)(2906002)(4326008)(44832011)(110136005)(86362001)(71200400001)(2201001)(26005)(5660300002)(73956011)(76116006)(66066001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w/xPd/JYkdvK05bCXbmbwOEcb0e2Jf6f3axd1qo3P5WKsxYwmL5iWqQB4q4fowmWJ1jaiRTOkiL5aAQeWmvhV1hYgx5GXmknIWavzWmELiOkajYABwaakBmKdnYnyGz7WmUSZB0QrYqwWYmA2GXcGRd/M2ylV1OGucErDoqY/QjRPA3VxtcadAUqAlvNUpm58HHL+7hvxsR7XLKorwxBpdmdyJvlAt0Q0MPum37JJXw/zZqnGHEvlsf7AAfc5973i/cgdvZFIzocdhxxaZ1AbFvWWax9yEMajqixMkKEw90aCPGR7hGQ5YvKZ0A2TktLEpdbCUG01uUctroIdE1gMkp7YCaQKLBWyeSL8fygOdGPYvhVjgQ9LU7+zdUOMdXXwKDVl1CGKF2GH2K4AdXuXiKA2nU0791tf68U6ScDyNw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4548e8-6850-4955-f002-08d6d2058016
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:30:38.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDE5IDU6MTggUE0N
Cj4gU3ViamVjdDogW1BBVENIIDIvM10gY2xrOiBpbXg4bW06IGFkZCBHUElPIGNsb2NrcyB0byBj
bG9jayB0cmVlDQo+IA0KPiBpLk1YOE1NIGhhcyBjbG9jayBnYXRlIGZvciBlYWNoIEdQSU8gYmFu
aywgYWRkIHRoZW0gaW50byBjbG9jayB0cmVlIGZvcg0KPiBHUElPIGRyaXZlciB0byBtYW5hZ2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJl
Z2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4
bW0uYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jIGIvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bW0uYw0KPiBpbmRleCAxZWY4NDM4Li43MzNjYTIwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1tLmMNCj4gQEAgLTU5MCw2ICs1OTAsMTEgQEAgc3RhdGljIGludCBfX2luaXQgaW14
OG1tX2Nsb2Nrc19pbml0KHN0cnVjdA0KPiBkZXZpY2Vfbm9kZSAqY2NtX25vZGUpDQo+ICAJY2xr
c1tJTVg4TU1fQ0xLX0VDU1BJMl9ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImVjc3BpMl9yb290X2Ns
ayIsDQo+ICJlY3NwaTIiLCBiYXNlICsgMHg0MDgwLCAwKTsNCj4gIAljbGtzW0lNWDhNTV9DTEtf
RUNTUEkzX1JPT1RdID0gaW14X2Nsa19nYXRlNCgiZWNzcGkzX3Jvb3RfY2xrIiwNCj4gImVjc3Bp
MyIsIGJhc2UgKyAweDQwOTAsIDApOw0KPiAgCWNsa3NbSU1YOE1NX0NMS19FTkVUMV9ST09UXSA9
IGlteF9jbGtfZ2F0ZTQoImVuZXQxX3Jvb3RfY2xrIiwNCj4gImVuZXRfYXhpIiwgYmFzZSArIDB4
NDBhMCwgMCk7DQo+ICsJY2xrc1tJTVg4TU1fQ0xLX0dQSU8xX1JPT1RdID0gaW14X2Nsa19nYXRl
NCgiZ3BpbzFfcm9vdF9jbGsiLA0KPiAiaXBnX3Jvb3QiLCBiYXNlICsgMHg0MGIwLCAwKTsNCj4g
KwljbGtzW0lNWDhNTV9DTEtfR1BJTzJfUk9PVF0gPSBpbXhfY2xrX2dhdGU0KCJncGlvMl9yb290
X2NsayIsDQo+ICJpcGdfcm9vdCIsIGJhc2UgKyAweDQwYzAsIDApOw0KPiArCWNsa3NbSU1YOE1N
X0NMS19HUElPM19ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImdwaW8zX3Jvb3RfY2xrIiwNCj4gImlw
Z19yb290IiwgYmFzZSArIDB4NDBkMCwgMCk7DQo+ICsJY2xrc1tJTVg4TU1fQ0xLX0dQSU80X1JP
T1RdID0gaW14X2Nsa19nYXRlNCgiZ3BpbzRfcm9vdF9jbGsiLA0KPiAiaXBnX3Jvb3QiLCBiYXNl
ICsgMHg0MGUwLCAwKTsNCj4gKwljbGtzW0lNWDhNTV9DTEtfR1BJTzVfUk9PVF0gPSBpbXhfY2xr
X2dhdGU0KCJncGlvNV9yb290X2NsayIsDQo+ICsiaXBnX3Jvb3QiLCBiYXNlICsgMHg0MGYwLCAw
KTsNCj4gIAljbGtzW0lNWDhNTV9DTEtfR1BUMV9ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImdwdDFf
cm9vdF9jbGsiLCAiZ3B0MSIsDQo+IGJhc2UgKyAweDQxMDAsIDApOw0KPiAgCWNsa3NbSU1YOE1N
X0NMS19JMkMxX1JPT1RdID0gaW14X2Nsa19nYXRlNCgiaTJjMV9yb290X2NsayIsICJpMmMxIiwN
Cj4gYmFzZSArIDB4NDE3MCwgMCk7DQo+ICAJY2xrc1tJTVg4TU1fQ0xLX0kyQzJfUk9PVF0gPSBp
bXhfY2xrX2dhdGU0KCJpMmMyX3Jvb3RfY2xrIiwgImkyYzIiLA0KPiBiYXNlICsgMHg0MTgwLCAw
KTsNCj4gLS0NCj4gMi43LjQNCg0K
