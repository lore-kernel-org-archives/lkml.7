Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD22C46470
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6845321019
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KWjBTHo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFGAue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:50:34 -0400
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:54158
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfFGAud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omlK5zp6dte7Oei0z9VufJ8JyT98rq2g0ReYCmbi7lk=;
 b=KWjBTHo0WahuAJC3VyuE6q4sk1KWwc0SyjOPE1POlXzgpoUKHu/cbMQ2+V651NJNXAyy+gPe+GMjoYf+cKDwV+L3+Qiss9wqH97iQM3dEpnmJt1tWrPhDpcvJ/aOXc69t/IBU17t9qkBV+BSml0xoG5Uo8DmotZ7XebXte+KPEY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 00:50:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 00:50:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>, Jacky Bai <ping.bai@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGnjztvJ1Vzt1002Z3uISz7VXoaaO1AeAgACJypA=
Date:   Fri, 7 Jun 2019 00:50:28 +0000
Message-ID: <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
 <20190604015928.23157-3-Anson.Huang@nxp.com>
 <20190606162543.EFFB820645@mail.kernel.org>
In-Reply-To: <20190606162543.EFFB820645@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9173b80e-6a46-4f9b-709d-08d6eae22291
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB39454AB65C2C49A6B30E8039F5100@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(13464003)(199004)(189003)(8936002)(2906002)(5660300002)(229853002)(7696005)(86362001)(256004)(2201001)(11346002)(6116002)(3846002)(102836004)(76176011)(71200400001)(71190400001)(4326008)(53546011)(6506007)(486006)(53936002)(6246003)(44832011)(25786009)(81166006)(476003)(52536014)(186003)(99286004)(478600001)(26005)(7416002)(316002)(6436002)(2501003)(55016002)(446003)(110136005)(73956011)(76116006)(66446008)(66476007)(64756008)(66946007)(305945005)(68736007)(7736002)(9686003)(14454004)(66556008)(66066001)(74316002)(81156014)(8676002)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QO4bP6Iq/Njk+vWalW4qdQP6DFm2Qk6UNIvgqAcGhTuWcVHtL9rImRuS/Vg7ijwcXl8x0iWAZ3sZ6i4qKy3oJlR7aDhMxEdx8/+lj8dwOVQh6c7Y/O99MZt//rCBAH1bYQF9yOPP+IOMJC6gmreTJJ6J6v4DH+xzNOf119HPUUx9A7omu/gp+YiSvqLhEwsEi79/mI6TXDGj3bW7vl75WWTe+maYNjJ0uL3y30hE1iKj7KZQbQmPAE4234b6L3U/kjIuP34UO4qQLLF+jqHflS2ewjBy6YGsU95gdx4X4/cGM8y5NqA4GlehQCzx2Ks7fmgYT4YWgRGwcwpjmxf97rhkQvvurnrNl6LDZq5/FapHCFH60byOvJy9FDq8vPd85gImMdb8JmNDvw+HIwSD20noqcMWh7g7A0d87M6W6ec=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173b80e-6a46-4f9b-709d-08d6eae22291
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 00:50:28.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSA3LCAyMDE5
IDEyOjI2IEFNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEFiZWwg
VmVzYQ0KPiA8YWJlbC52ZXNhQG54cC5jb20+OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPjsNCj4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGluZ3V5ZW5Aa2VybmVsLm9y
ZzsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgZmVzdGV2YW1AZ21haWwuY29tOw0K
PiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgTGVvbmFy
ZCBDcmVzdGV6DQo+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBtYXhpbWUu
cmlwYXJkQGJvb3RsaW4uY29tOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgb2xvZkBsaXhvbS5u
ZXQ7DQo+IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsN
Cj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgd2lsbC5kZWFj
b25AYXJtLmNvbQ0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBWMyAzLzRdIGNsazogaW14OiBBZGQgc3VwcG9ydCBmb3IgaS5NWDhN
TiBjbG9jayBkcml2ZXINCj4gDQo+IFF1b3RpbmcgQW5zb24uSHVhbmdAbnhwLmNvbSAoMjAxOS0w
Ni0wMyAxODo1OToyNykNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNv
bT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YOE1OIGNsb2NrIGRyaXZlciBzdXBwb3J0
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMjoNCj4gPiAgICAgICAgIC0gdXNlIHBs
YXRmb3JtIGRyaXZlciBtb2RlbCBmb3IgdGhpcyBjbG9jayBkcml2ZXI7DQo+IA0KPiBDYW4geW91
IGFsc28gdXNlIHBsYXRmb3JtIGRldmljZSBBUElzIGxpa2UgcGxhdGZvcm1fKigpLA0KPiBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UoKSBhbmQgZGV2bWlmaWVkIGNsayByZWdpc3RyYXRpb24/DQoNCkkg
d2lsbCB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgaW5zdGVhZCBvZiBpb3Jl
bWFwKCksDQphbmQgY2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0IGRldm1pZmllZCBjbGsg
cmVnaXN0cmF0aW9uPw0KDQpUaGFua3MsDQpBbnNvbg0K
