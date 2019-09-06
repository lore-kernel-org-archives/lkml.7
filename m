Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C8C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF006206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j0GsJfC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfIFBEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:04:44 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:36949
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731344AbfIFBEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAPn13ZKT43ynf5J9FLWBpnfCYgvfMPLSwend5fooxmshlY5tWvbizg6YNagS0asJxxO8EqMCvX2mX0yWS6uagx7V1KL2WZ3YCapPZuvvw8PBuhsgX2dzfoS8kVDvETWRrJocw16a4Evecz6uKkv+RI8x36S6mfKT33K9fAVW5puouOpfKc0c7EApLOd8c1dQjwo5KTmwnb/qVRSmyiQvGq4gxc+RJ7VlUrEZMd1C2cmc9wda4nBcSIojviYoviwk3BRRySUXn/DNiT4B56CZgsv+kU7fui2xSe1aMlQE5nM0uOJFhVu1i7Ne5jL8mp235Awh0avyy2GRiwH6h0nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udYJCCRSp7KblBxA7rBcq2S46lq18WDU8pY8F6vN3lw=;
 b=THFg8m8Zd/2VZ+hk5CcZuBEFxFvJhTA+nb6dq9cgxy4FG+0V/LMq8YMgrBmD1rq6qXvM9KPbjH4zvasyaOZVg54yuyyCP2qJZ1A/b8Zy2LwLppoD9+rrtUME7KfOTj/3TCPXcx0qndUh8yjO8/iNAnGMF94MXDw77CHucTjfJk+b1DI3fslrdlul3xp9QNg26efZB/9QE2LNrpbkC4qkWtP0rGBAi6KpCZGgVNOhLmMSWgtzu4ooGSnLEF+HkosnTNKRe9xGOvuZcHVCQldD+y+vT3YvzETVShyeIpl35cnOUL+/PT3ogsLNFU/PBUbmUoEziNheKKfmhdVaVLUhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udYJCCRSp7KblBxA7rBcq2S46lq18WDU8pY8F6vN3lw=;
 b=j0GsJfC+KTGrvSg9T7ocjOxxOT/55jOMW7XLX+L8F59rvKJ4kgt5A9VV+gyIB1ktCOKO/Ty9bgC5KizcvE5jNiEdKL2Rig7hXaNz/P59CzhlpzrSelcxV6gHg99iWVMrUUOME1IvGs/EURbZoeDWYuKclVKsaS6/QqnRzstoltE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 6 Sep 2019 01:03:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.027; Fri, 6 Sep 2019
 01:03:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Fancy Fang <chen.fang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure to
 common place
Thread-Topic: [PATCH 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure to
 common place
Thread-Index: AQHVY9CbkBSOjf4lJEuj9oVFkY5eUacd1VTg
Date:   Fri, 6 Sep 2019 01:03:58 +0000
Message-ID: <DB3PR0402MB3916535DC3A2F539326A43E8F5BA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567720699-23514-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023460FBB9FB8D034ECC2A1EEBB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023460FBB9FB8D034ECC2A1EEBB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2896bf8c-9871-4dd8-4c7e-08d73266190f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38175D7E8420B0904663FA19F5BA0@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(14454004)(2906002)(86362001)(256004)(25786009)(6246003)(52536014)(5660300002)(53936002)(9686003)(66066001)(55016002)(102836004)(99286004)(26005)(478600001)(186003)(76176011)(4326008)(71190400001)(6506007)(53546011)(7696005)(76116006)(71200400001)(6116002)(11346002)(305945005)(486006)(476003)(3846002)(446003)(6436002)(316002)(66476007)(66556008)(8676002)(44832011)(74316002)(7736002)(54906003)(110136005)(64756008)(66446008)(229853002)(7416002)(66946007)(6636002)(33656002)(8936002)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBWQ0nBRDytHkcByASpGqByEpFSeQDeXblgC4TK+/f0X9sChYXvnUAA1J5sg3a8viyc9ZyAYrszlE6tx+LTmEZ+igUDStTarSyWxME4v3YJV4bwCkNm8BdZjUb8dlooWs5UyuLF5a0AgKLGS9WYN8cJZwdL44KvuTrZBuLOjeTssxXhDhvga6ao1YuSg8SFebjTshY7M9toqHM2bUKA4KUzDLCUs/4U1elR7q/+4QX1AE/ig5JflXPofpv4ews3jYyJbSHZBedU1bZtPaGbvhG+T8QkX2fGrzdToaVdOIBdXCyCQt58MWFMxzzsTni9lHDgD54KErKrJMg9he+GxGF9fgHBFEf2ONFTzLlRPfeEnOZHwSzV8DZzh1rimgbXIcZ5JzS2ObIempbQFtEwGx2bGIGvbHyq5MwCHHyXjx5U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2896bf8c-9871-4dd8-4c7e-08d73266190f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 01:03:58.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWNFuzRYvTvxwqcju8oJPNg/gNT17gwwefXS0YdJDoplv3RE6GyfvkwRPklvI1bk/USRd9VxZq5MJpNewBP6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAwNS4wOS4yMDE5IDEyOjU5LCBBbnNvbiBIdWFuZyB3cm90ZToN
Cj4gPiBNYW55IGkuTVg4TSBTb0NzIHVzZSBzYW1lIDE0NDNYLzE0MTZYIFBMTCwgc3VjaCBhcyBp
Lk1YOE1NLA0KPiBpLk1YOE1ODQo+ID4gYW5kIGxhdGVyIGkuTVg4TSBTb0NzLCBtb3ZpbmcgdGhl
c2UgUExMIGRlZmluaXRpb25zIHRvIGNvbW1vbiBwbGFjZQ0KPiA+IGNhbiBzYXZlIGEgbG90IG9m
IGR1cGxpY2F0ZWQgY29kZSBvbiBlYWNoIHBsYXRmb3JtLg0KPiANCj4gVGhlcmUgYXJlIGxvdHMg
b2Ygc2ltaWxhcml0aWVzIGJldHdlZW4gaW14OG0gY2xvY2tzLCBkbyB5b3UgcGxhbiB0byBkbw0K
PiBjb21iaW5lIHRoZW0gZnVydGhlcj8NCg0KSSB3aWxsIGNvbnNpZGVyIGl0IGxhdGVyLCBtYXli
ZSB3ZSBjYW4gY3JlYXRlIGEgbmV3IGNsb2NrIGZpbGUgbmFtZWQgY2xrLWlteDhtLmMNCmFzIGNv
bW1vbiBjbG9jayBmb3IgaS5NWDhNIFNvQ3Mgd2hpY2ggYXJlIHNpbWlsYXIuDQoNCj4gDQo+ID4g
TWVhbndoaWxlLCBubyBuZWVkIHRvIGRlZmluZSBQTEwgY2xvY2sgc3RydWN0dXJlIGZvciBldmVy
eSBtb2R1bGUNCj4gPiB3aGljaCB1c2VzIHNhbWUgdHlwZSBvZiBQTEwsIGUuZy4sIGF1ZGlvL3Zp
ZGVvL2RyYW0gdXNlIDE0NDNYIFBMTCwNCj4gPiBhcm0vZ3B1L3ZwdS9zeXMgdXNlIDE0MTZYIFBM
TCwgZGVmaW5lIDIgUExMIGNsb2NrIHN0cnVjdHVyZSBmb3IgZWFjaA0KPiA+IGdyb3VwIGlzIGVu
b3VnaC4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBiL2RyaXZl
cnMvY2xrL2lteC9jbGsuYw0KPiANCj4gPiArY29uc3Qgc3RydWN0IGlteF9wbGwxNHh4X3JhdGVf
dGFibGUgaW14X3BsbDE0MTZ4X3RibFtdID0gew0KPiA+ICsJUExMXzE0MTZYX1JBVEUoMTgwMDAw
MDAwMFUsIDIyNSwgMywgMCksDQo+ID4gKwlQTExfMTQxNlhfUkFURSgxNjAwMDAwMDAwVSwgMjAw
LCAzLCAwKSwNCj4gPiArCVBMTF8xNDE2WF9SQVRFKDEyMDAwMDAwMDBVLCAzMDAsIDMsIDEpLA0K
PiA+ICsJUExMXzE0MTZYX1JBVEUoMTAwMDAwMDAwMFUsIDI1MCwgMywgMSksDQo+ID4gKwlQTExf
MTQxNlhfUkFURSg4MDAwMDAwMDBVLCAgMjAwLCAzLCAxKSwNCj4gPiArCVBMTF8xNDE2WF9SQVRF
KDc1MDAwMDAwMFUsICAyNTAsIDIsIDIpLA0KPiA+ICsJUExMXzE0MTZYX1JBVEUoNzAwMDAwMDAw
VSwgIDM1MCwgMywgMiksDQo+ID4gKwlQTExfMTQxNlhfUkFURSg2MDAwMDAwMDBVLCAgMzAwLCAz
LCAyKSwgfTsNCj4gPiArDQo+ID4gK2NvbnN0IHN0cnVjdCBpbXhfcGxsMTR4eF9yYXRlX3RhYmxl
IGlteF9wbGwxNDQzeF90YmxbXSA9IHsNCj4gPiArCVBMTF8xNDQzWF9SQVRFKDY1MDAwMDAwMFUs
IDMyNSwgMywgMiwgMCksDQo+ID4gKwlQTExfMTQ0M1hfUkFURSg1OTQwMDAwMDBVLCAxOTgsIDIs
IDIsIDApLA0KPiA+ICsJUExMXzE0NDNYX1JBVEUoMzkzMjE2MDAwVSwgMjYyLCAyLCAzLCA5NDM3
KSwNCj4gPiArCVBMTF8xNDQzWF9SQVRFKDM2MTI2NzIwMFUsIDM2MSwgMywgMywgMTc1MTEpLCB9
Ow0KPiA+ICsNCj4gPiArc3RydWN0IGlteF9wbGwxNHh4X2NsayBpbXhfMTQ0M3hfcGxsID0gew0K
PiA+ICsJLnR5cGUgPSBQTExfMTQ0M1gsDQo+ID4gKwkucmF0ZV90YWJsZSA9IGlteF9wbGwxNDQz
eF90YmwsDQo+ID4gKwkucmF0ZV9jb3VudCA9IEFSUkFZX1NJWkUoaW14X3BsbDE0NDN4X3RibCks
IH07DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteF8xNDE2eF9wbGwgPSB7
DQo+ID4gKwkudHlwZSA9IFBMTF8xNDE2WCwNCj4gPiArCS5yYXRlX3RhYmxlID0gaW14X3BsbDE0
MTZ4X3RibCwNCj4gPiArCS5yYXRlX2NvdW50ID0gQVJSQVlfU0laRShpbXhfcGxsMTQxNnhfdGJs
KSwgfTsNCj4gDQo+IFBlcmhhcHMgdGhlc2UgY29uc3RzIHNob3VsZCBiZSBpbiBjbGstcGxsMTR4
eC5jPyBUaGF0IHdheSB0aGV5IHdvbid0IGJlDQo+IGNvbXBpbGVkIGZvciBpbXg2IGFzIHdlbGwu
DQoNCk1ha2Ugc2Vuc2UsIEkgd2lsbCBkbyBpdCBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24NCg0K
DQo=
