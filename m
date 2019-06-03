Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83906C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235A27CD8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gqw/Q3LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFCHjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:39:22 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:16513
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfFCHjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a59xJXFODoYoZ2OQ859HEp6YnMugEzWXFGbkK/dNPGI=;
 b=Gqw/Q3LG3H+9ZIsxmmgfhrD5W9yuVq76AJe0ciR4FX5Xxhe+vModpF4/g6ygQfDbsO8oXMr2YLMeRMCUxPiOE5fHyMmj02wlIpVQoPKLXSxdm7HPs0VcZPhTIcwkJtiIAja9mKUZzgveTmvpKnklZjVkQMSUsb/VKiTFetRxQxM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 07:39:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 07:39:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGaxeLRS7zF6kSEqSfwNQzT+zYKaJiQwAgAAB34A=
Date:   Mon, 3 Jun 2019 07:39:16 +0000
Message-ID: <DB3PR0402MB3916D2B09BACABB79E8989A2F5140@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
 <20190603013503.40626-2-Anson.Huang@nxp.com>
 <20190603073018.j236j57ooc7t5hp6@fsr-ub1664-175>
In-Reply-To: <20190603073018.j236j57ooc7t5hp6@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2606a84-a578-4357-dc30-08d6e7f694f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39297A64556810077704F318F5140@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(13464003)(199004)(189003)(43544003)(2906002)(66946007)(53936002)(66066001)(99286004)(6246003)(7736002)(305945005)(76116006)(74316002)(6436002)(6862004)(68736007)(256004)(6116002)(3846002)(73956011)(86362001)(7416002)(229853002)(71200400001)(66476007)(55016002)(71190400001)(476003)(11346002)(446003)(486006)(52536014)(66446008)(8936002)(186003)(44832011)(478600001)(26005)(64756008)(66556008)(6636002)(316002)(14454004)(6506007)(8676002)(54906003)(25786009)(53546011)(102836004)(81156014)(76176011)(4326008)(9686003)(5660300002)(7696005)(33656002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f/bekEb9A8jyb63/ZEG43qDhtDT5HnUjEML7lxQRO7rGmOiT6ypdR9KmtFFdNvcKyE9ppZO6jkyTI9VFRXbqXEpfIZ/Bs/SMmBi2DNtluC0r4UC3UTdS+RMsr9qgGWQwjYj5FjMGw7TbucHUasHVhlI3PgrODlDXBhxfaAujrUodix8l4bCrjaskAnl5rKdluW/ga1iRHMZw60231J9xqdpVPV6STXaJWpfQd+xYWm53cu6630DIPA8wXgZw7mBVAksqf8mUstW/LYNvB2C1u9YZYgOpYRnoi3I8o5vj7E3ifhCJUY7AhlGQR/fxaMsYwC/Af4xjoHbknlJDNlHM4EQMfEVuinN8POch3QgOKAG3+rn6ElhC/oQ7OK9maoZ4qNs7w6U4VPrsqj0RpVnoyBtCCUKF4pL3Pr75TAIWD2I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2606a84-a578-4357-dc30-08d6e7f694f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 07:39:16.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFiZWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBYmVsIFZl
c2ENCj4gU2VudDogTW9uZGF5LCBKdW5lIDMsIDIwMTkgMzozMCBQTQ0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsg
c2JveWRAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29t
OyBvbG9mQGxpeG9tLm5ldDsNCj4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGphZ2FuQGFt
YXJ1bGFzb2x1dGlvbnMuY29tOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgTGVvbmFy
ZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IGRpbmd1eWVuQGtlcm5lbC5v
cmc7IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVu
Zy5kb25nQG54cC5jb20+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+Ow0KPiBsLnN0YWNo
QHBlbmd1dHJvbml4LmRlOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAyLzNdIGNsazogaW14OiBBZGQgc3Vw
cG9ydCBmb3IgaS5NWDhNTiBjbG9jayBkcml2ZXINCj4gDQo+IE9uIDE5LTA2LTAzIDA5OjM1OjAy
LCBBbnNvbi5IdWFuZ0BueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGkuTVg4TU4gY2xvY2sg
ZHJpdmVyIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+IAkt
IGFkZCBHUElPeCBjbG9ja3MuDQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgaW14
X3BsbDE0eHhfY2xrIGlteDhtbl9zeXNfcGxsIF9faW5pdGRhdGEgPSB7DQo+ID4gKwkJLnR5cGUg
PSBQTExfMTQxNlgsDQo+ID4gKwkJLnJhdGVfdGFibGUgPSBpbXg4bW5fcGxsMTQxNnhfdGJsLA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKnBsbF9yZWZfc2Vsc1tdID0g
eyAib3NjXzI0bSIsICJkdW1teSIsICJkdW1teSIsDQo+ID4gKyJkdW1teSIsIH07DQo+IA0KPiBB
bGwgb2YgdGhlc2Ugc2hvdWxkIGJlICJzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0ICIuDQoNCk9L
Lg0KDQo+IA0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqYXVkaW9fcGxsMV9ieXBhc3Nfc2Vsc1td
ID0geyJhdWRpb19wbGwxIiwNCj4gPiArImF1ZGlvX3BsbDFfcmVmX3NlbCIsIH07IHN0YXRpYyBj
b25zdCBjaGFyICphdWRpb19wbGwyX2J5cGFzc19zZWxzW10NCj4gPiArPSB7ImF1ZGlvX3BsbDIi
LCAiYXVkaW9fcGxsMl9yZWZfc2VsIiwgfTsNCj4gDQo+IC4uLg0KPiANCj4gPiArCWNsa19kYXRh
LmNsa3MgPSBjbGtzOw0KPiA+ICsJY2xrX2RhdGEuY2xrX251bSA9IEFSUkFZX1NJWkUoY2xrcyk7
DQo+ID4gKwlyZXQgPSBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5wLCBvZl9jbGtfc3JjX29uZWNlbGxf
Z2V0LCAmY2xrX2RhdGEpOw0KPiA+ICsJaWYgKHJldCA8IDApIHsNCj4gPiArCQlwcl9lcnIoImZh
aWxlZCB0byByZWdpc3RlciBjbGtzIGZvciBpLk1YOE1OXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpbXhfcmVnaXN0ZXJfdWFydF9jbG9ja3ModWFy
dF9jbGtzKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtDTEtfT0ZfREVD
TEFSRV9EUklWRVIoaW14OG1uLCAiZnNsLGlteDhtbi1jY20iLA0KPiBpbXg4bW5fY2xvY2tzX2lu
aXQpOw0KPiANCj4gQW55IHJlYXNvbiB3aHkgdGhpcyBjYW5ub3QgYmUgYSBwbGF0Zm9ybSBkcml2
ZXIgPw0KDQpJdCBzaG91bGQgY2FuIGJlLCBJIGp1c3QgZGlkIE5PVCB0YWtlIGNhcmUgb2YgaXQs
IDhNUSB1c2VzIHBsYXRmb3JtIGRyaXZlciBtb2RlbCwgd2hpbGUNCjhNTSBkb2VzIE5PVCwgSSB3
aWxsIG1vZGlmeSBib3RoIG9mIHRoZW0gdG8gdXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbC4NCg0K
VGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
