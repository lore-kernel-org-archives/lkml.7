Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEFC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E427DE2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BftrIDsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfFCJBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:01:40 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:29038
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbfFCJBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4lMmQ5IOK3yFjAuwD9kRjqaVsV4ogoUCOJJcal1oQs=;
 b=BftrIDswrGVoc03wgZKhzpNukQuzzcua6n/36RfuRee6n/o3Cd94dsM2spDoEu9DlWESHyx5Npw/iTP6gL/+YsFERNAVDdY0uaxlgVXOw3WMU/811I8ZUGaZZQuCISngUbjMlv/ltzhftbK9nJ8IM6VMEvuwLQ9oLTKjCD2gKec=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 09:01:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 09:01:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGaxeLRS7zF6kSEqSfwNQzT+zYKaJonPw
Date:   Mon, 3 Jun 2019 09:01:33 +0000
Message-ID: <DB3PR0402MB39162498C890AB92D9722595F5140@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
 <20190603013503.40626-2-Anson.Huang@nxp.com>
 <VI1PR04MB5055D6EB38E84E370E881425EE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5055D6EB38E84E370E881425EE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e689b54-883d-4a3d-7660-08d6e8021383
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-antispam-prvs: <DB3PR0402MB3818825C7C401FA173C5A1E3F5140@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:113;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(13464003)(53546011)(478600001)(8936002)(76176011)(316002)(229853002)(8676002)(25786009)(6506007)(7736002)(81166006)(71190400001)(81156014)(305945005)(256004)(11346002)(44832011)(102836004)(86362001)(74316002)(71200400001)(6436002)(476003)(2201001)(446003)(7416002)(33656002)(486006)(68736007)(53936002)(6246003)(55016002)(2501003)(5660300002)(9686003)(52536014)(14454004)(2906002)(66066001)(110136005)(26005)(7696005)(6116002)(99286004)(73956011)(64756008)(3846002)(66946007)(186003)(76116006)(66446008)(4326008)(66556008)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5EhKgCqbkxVJFWFHUW+do0fx6ehLjMR/AbhN23eUHbXTy84CLYqgVUjxoJNQsSq2RldPHN2YUuRN/1o99abBS8fn++Dq4uBR9PiUhOFG8rUNNFNtdID0SxQbKeZQed23gG6SvxT1ZSaTBSXy9W3asUo7AtM4MoKUCLUGeAjkQ94WpLlnNknsdU0fz+cgeJZ80s1f/nM/P2VCyKHGzCCt5fHwSsEYocIN6ch8hWdjN7mgwNVZukwmE5oKSbscTgbQm+ZoDhiIj6R3cVSzYgot7DO54z5hMwy0JDU8nwgp6G6isJ0wzn5EojnGh+Vj9+83gfSO5d9qsRk0xPbxcumGevUB7wKjHVSBprhjHuWG9QmH7kNJ417LpVwAIygXEg5Mo6/t423TlLuJcvABXaVz6BiI/no3KMK2MIc2emrDoSc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e689b54-883d-4a3d-7660-08d6e8021383
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 09:01:33.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbmFyZCBDcmVzdGV6
DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAzLCAyMDE5IDQ6NDUgUE0NCj4gVG86IEFuc29uIEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPjsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lk
QGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBjYXRhbGluLm1hcmluYXNAYXJtLmNv
bTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gbWF4aW1lLnJpcGFyZEBib290bGluLmNvbTsgb2xv
ZkBsaXhvbS5uZXQ7IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1Ow0KPiBqYWdhbkBhbWFydWxh
c29sdXRpb25zLmNvbTsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IGRpbmd1eWVuQGtl
cm5lbC5vcmc7IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IEFpc2hlbmcgRG9uZw0KPiA8
YWlzaGVuZy5kb25nQG54cC5jb20+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBBYmVs
IFZlc2ENCj4gPGFiZWwudmVzYUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8zXSBjbGs6IGlteDogQWRkIHN1cHBvcnQgZm9yIGkuTVg4
TU4gY2xvY2sgZHJpdmVyDQo+IA0KPiBPbiA2LzMvMjAxOSA0OjMzIEFNLCBBbnNvbi5IdWFuZ0Bu
eHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGkuTVg4TU4gY2xvY2sgZHJpdmVyIHN1cHBvcnQu
DQo+IA0KPiA+ICsjaW5jbHVkZSAiY2xrLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBMTF8xNDE2
WF9SQVRFKF9yYXRlLCBfbSwgX3AsIF9zKQkJXA0KPiA+ICsJewkJCQkJCVwNCj4gPiArCQkucmF0
ZQk9CShfcmF0ZSksCQlcDQo+ID4gKwkJLm1kaXYJPQkoX20pLAkJCVwNCj4gPiArCQkucGRpdgk9
CShfcCksCQkJXA0KPiA+ICsJCS5zZGl2CT0JKF9zKSwJCQlcDQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsjZGVmaW5lIFBMTF8xNDQzWF9SQVRFKF9yYXRlLCBfbSwgX3AsIF9zLCBfaykJCVwNCj4gPiAr
CXsJCQkJCQlcDQo+ID4gKwkJLnJhdGUJPQkoX3JhdGUpLAkJXA0KPiA+ICsJCS5tZGl2CT0JKF9t
KSwJCQlcDQo+ID4gKwkJLnBkaXYJPQkoX3ApLAkJCVwNCj4gPiArCQkuc2Rpdgk9CShfcyksCQkJ
XA0KPiA+ICsJCS5rZGl2CT0JKF9rKSwJCQlcDQo+ID4gKwl9DQo+IA0KPiBUaGVzZSBtYWNyb3Mg
YXJlIHNoYXJlZCB3aXRoIGNsay1pbXg4bW0gKGFuZCBwZXJoYXBzIHNvbWUgZnV0dXJlIGNoaXBz
KQ0KPiBzbyB0aGV5IHNob3VsZCBiZSBtb3ZlZCB0byBkcml2ZXIvY2xrL2lteC9jbGsuaA0KDQpP
Sywgd2lsbCBtb3ZlIHRoZW0gaW50byBjbGsuaCBpbiBWMy4NCg0KQW5zb24uDQo=
