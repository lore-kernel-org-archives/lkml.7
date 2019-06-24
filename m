Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8850AC48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581BC208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="edz9BwIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFXCfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:35:15 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:48377
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfFXCfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZeeXzWt1XmqT19Qpk7iZfEjso8yLeo1VZwQGVaEWxI=;
 b=edz9BwIliZ/aMTAs1liCH64je3tItsS0a3NzjD4PxSvcp8SNCRtFPRoZdTYkWXGCP7wnmkSgaEAMVlWF3t3j5kicfNDGuXgodDiRYW2Ql7Rp/dx59NP7oY4H1m9c6PT7j3oia82GRbfbt1NM7/dfFJOJmRjMA2yLq4jR4Hi01S0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 02:35:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 02:35:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Topic: [PATCH 1/4] arm64: Enable TIMER_IMX_SYS_CTR for ARCH_MXC
 platforms
Thread-Index: AQHVJ/+7WzrDWTethU+K40MoFm49OKaqFzaAgAABdQCAAADrQA==
Date:   Mon, 24 Jun 2019 02:35:10 +0000
Message-ID: <DB3PR0402MB39162662C69B45BDB948D002F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190624022200.GN3800@dragon> <20190624022713.GO3800@dragon>
In-Reply-To: <20190624022713.GO3800@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c3dd5c-e3ab-4c9d-b1da-08d6f84c940e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB38331DAAB7A0F22A906BDEC6F5E00@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(13464003)(199004)(189003)(26005)(256004)(486006)(68736007)(446003)(54906003)(33656002)(66446008)(71190400001)(71200400001)(7736002)(476003)(305945005)(229853002)(99286004)(74316002)(7696005)(2906002)(14454004)(73956011)(8676002)(81156014)(81166006)(66946007)(9686003)(66476007)(66556008)(64756008)(102836004)(55016002)(66066001)(76116006)(14444005)(478600001)(186003)(76176011)(11346002)(316002)(6436002)(3846002)(53546011)(6506007)(6116002)(44832011)(4326008)(6916009)(86362001)(25786009)(52536014)(5660300002)(7416002)(6246003)(8936002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +QjgEHai9r1W1l4kjkaB92skWpd7Qp4zdMfWOwejloY/2iRNLLlVfwmbla1h0840Ewt2B6Xp7HXaSqGphA5EZM5lqpix7lvkLrNkHFWkmwopFIlszOFi6Hdxs5WbbBwbdOyZA+XXUxgzBAKDApsuLcZTKgosW3cqz+V5fjSnBKtJMPDKG78lKfH9x1JHKP4SP3ILtvf1S+HpRhB2s4dQpukYc6lqBwh9XVs1Wc1UC8tpeuHZSdmD+FoG0iecJnYEqI/Dsr1rQ+A4m5MS9qNuxRKrrBZEu6XcTbWrymUDWvK5fFCoGGEJ9NoWneVu7YMbgHxVW5Ij5KiN+qTg8RZx3GSWNhXXI1VmIFAErD6KkL150hs9ZywCAkAW6VX95GLfh0CChKY7aZLyg/vg7RWib1bZLXSKbcP5uSxjvnj++xY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c3dd5c-e3ab-4c9d-b1da-08d6f84c940e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 02:35:10.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjQsIDIwMTkg
MTA6MjcgQU0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzog
bWFyay5ydXRsYW5kQGFybS5jb207IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
OyBQZW5nDQo+IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbTsgSmFj
a3kgQmFpDQo+IDxwaW5nLmJhaUBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IHNib3lkQGtlcm5lbC5vcmc7DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGFuaWVsIEJh
bHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gaW14QG54cC5j
b20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IExlb25hcmQgQ3Jlc3Rleg0KPiA8bGVvbmFyZC5j
cmVzdGV6QG54cC5jb20+OyB3aWxsQGtlcm5lbC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29t
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEFiZWwgVmVzYSA8YWJl
bC52ZXNhQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBhcm02NDogRW5hYmxl
IFRJTUVSX0lNWF9TWVNfQ1RSIGZvciBBUkNIX01YQw0KPiBwbGF0Zm9ybXMNCj4gDQo+IE9uIE1v
biwgSnVuIDI0LCAyMDE5IGF0IDEwOjIyOjAxQU0gKzA4MDAsIFNoYXduIEd1byB3cm90ZToNCj4g
PiBPbiBGcmksIEp1biAyMSwgMjAxOSBhdCAwMzowNzoxN1BNICswODAwLCBBbnNvbi5IdWFuZ0Bu
eHAuY29tIHdyb3RlOg0KPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gPg0KPiA+ID4gQVJDSF9NWEMgcGxhdGZvcm1zIG5lZWRzIHN5c3RlbSBjb3VudGVy
IGFzIGJyb2FkY2FzdCB0aW1lciB0bw0KPiA+ID4gc3VwcG9ydCBjcHVpZGxlLCBlbmFibGUgaXQg
YnkgZGVmYXVsdC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gvYXJtNjQvS2NvbmZpZy5w
bGF0Zm9ybXMgfCAxICsNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
PiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3Jtcw0KPiA+
ID4gYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zIGluZGV4IDQ3NzhjNzcuLmY1ZTYyM2Yg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+ID4gPiAr
KysgYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+ID4gPiBAQCAtMTczLDYgKzE3Myw3
IEBAIGNvbmZpZyBBUkNIX01YQw0KPiA+ID4gIAlzZWxlY3QgUE0NCj4gPiA+ICAJc2VsZWN0IFBN
X0dFTkVSSUNfRE9NQUlOUw0KPiA+ID4gIAlzZWxlY3QgU09DX0JVUw0KPiA+ID4gKwlzZWxlY3Qg
VElNRVJfSU1YX1NZU19DVFINCj4gPg0KPiA+IFdoZXJlIGlzIHRoYXQgZHJpdmVyPw0KPiANCj4g
T2theSwganVzdCBmb3VuZCBpdCBpbiB0aGUgbWFpbGJveC4gIFRoZXkgc2VlbSB0byBiZSBzZW50
IGluIHRoZSB3cm9uZyBvcmRlci4NCj4gUmVhbGx5LCB5b3Ugc2hvdWxkIHNlbmQgdGhpcyBzZXJp
ZXMgb25seSBhZnRlciB0aGUgZHJpdmVyIGxhbmRzIG9uIG1haW5saW5lLg0KDQpPSywganVzdCBu
b3RpY2VkIHRoYXQgbWFpbmxpbmUgZG9lcyBOT1QgaGF2ZSBpdCwgc2luY2UgSSBkaWQgaXQgYmFz
ZWQgb24gbmV4dCB0cmVlLg0KSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIGFmdGVyIHRo
ZSBzeXN0ZW0gY291bnRlciBkcml2ZXIgbGFuZGluZyBvbiBtYWlubGluZS4NCg0KVGhhbmtzLA0K
QW5zb24uDQoNCj4gDQo+IFNoYXduDQo=
