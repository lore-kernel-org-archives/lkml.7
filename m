Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BF5C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAF7214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VSWH1xCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFHJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:58:25 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:15332
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfFHJ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmgkqwBruHtNALP9L1EvNSNz6ctunYWDqlNYRr314ZM=;
 b=VSWH1xCqTpCOs5HnhOBplFq6Vnq4nUi/asxgqFS7uDThfWPEObqlXT+4aaEsEm2/AeM4Oc9Hd5oDC6rjYvTOzmzHdcjhnhyHXedrhCqfKV/EV93issJruU6kr9UUlikcUy8hLyL8jdSocdjQfmbBCVOES2i8vAkG10ghbqOOAjM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Sat, 8 Jun 2019 09:58:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.017; Sat, 8 Jun 2019
 09:58:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix .de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGnjztvJ1Vzt1002Z3uISz7VXoaaO1AeAgACJypCAASMQAIABCS1g
Date:   Sat, 8 Jun 2019 09:58:18 +0000
Message-ID: <DB3PR0402MB391678C245944942EA2A7F62F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
 <20190604015928.23157-3-Anson.Huang@nxp.com>
 <20190606162543.EFFB820645@mail.kernel.org>
 <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190607180039.611C7208C0@mail.kernel.org>
In-Reply-To: <20190607180039.611C7208C0@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a98e75-9af9-4ef6-4430-08d6ebf7d577
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-antispam-prvs: <DB3PR0402MB37080EB83064F4DFAC8CE37AF5110@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0062BDD52C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(396003)(376002)(189003)(199004)(13464003)(68736007)(229853002)(74316002)(110136005)(33656002)(446003)(11346002)(476003)(486006)(316002)(44832011)(99286004)(7696005)(256004)(7416002)(76176011)(53546011)(6506007)(2201001)(2501003)(102836004)(66066001)(86362001)(71200400001)(6436002)(305945005)(7736002)(71190400001)(3846002)(6116002)(9686003)(2906002)(478600001)(8936002)(8676002)(81166006)(81156014)(14454004)(55016002)(66946007)(64756008)(66556008)(66476007)(76116006)(52536014)(4326008)(66446008)(26005)(5660300002)(6246003)(186003)(25786009)(53936002)(73956011)(6636002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bp8T1gfyDCQDOFymjsDJFPyUKIebr8ABmSChSnri2AYuILa8LgYJVfvGnYylwqDq+ilxNXD2gQQ44ijg160L4o3Rx+Bxn6H7xXfdQSsYm4a3+mMeigDEzvOCfw1/fkPAXyZJHQDIXoeathtUcgzLzgFBxkI0yfcxu7rurFMTIOgS2NiC8+vHjC3M+kEf/8OeiF4W1z3FjVHiS/Eyy46JROszZeVh6PY7tbjUXCaWBuYLa5s6k0lwQuW5w9gF8Xgz0JIlztL3weKM09KQh9jLL/CpvDzeeS/8VIGqMYexS9rSW50/zQZlIwkxsgTFmWLnK7D3D0OooQ+0zO3RMlWBB/sVe2SAe9xVB8rOrCgujLWcpKCakQYmuhrngQqksp/saeDop+0W52E56m8yhP5CNOI9gT1wl74SLUtK3VB7lbk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a98e75-9af9-4ef6-4430-08d6ebf7d577
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2019 09:58:18.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDgsIDIw
MTkgMjowMSBBTQ0KPiBUbzogYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGluZ3V5ZW5Aa2Vy
bmVsLm9yZzsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgamFnYW5AYW1hcnVsYXNvbHV0aW9u
cy5jb207DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsg
bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOyBtdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgb2xvZkBsaXhvbS5uZXQ7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peCAuZGUgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBBYmVsIFZlc2ENCj4gPGFiZWwudmVzYUBueHAu
Y29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uDQo+IEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgTGVv
bmFyZA0KPiBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gQ2M6IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjMgMy80XSBj
bGs6IGlteDogQWRkIHN1cHBvcnQgZm9yIGkuTVg4TU4gY2xvY2sgZHJpdmVyDQo+IA0KPiBRdW90
aW5nIEFuc29uIEh1YW5nICgyMDE5LTA2LTA2IDE3OjUwOjI4KQ0KPiA+DQo+ID4gSSB3aWxsIHVz
ZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSBpbnN0ZWFkIG9mIGlvcmVtYXAoKSwg
YW5kDQo+ID4gY2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0IGRldm1pZmllZCBjbGsgcmVn
aXN0cmF0aW9uPw0KPiA+DQo+IA0KPiBJIG1lYW4gdXNpbmcgdGhpbmdzIGxpa2UgZGV2bV9jbGtf
aHdfcmVnaXN0ZXIoKS4NCg0KU29ycnksIEkgYW0gc3RpbGwgYSBsaXR0bGUgY29uZnVzZWQsIGFs
bCB0aGUgY2xvY2sgcmVnaXN0ZXIoY2xrX3JlZ2lzdGVyKCkpIGFyZSB2aWEgZWFjaCBkaWZmZXJl
bnQNCmNsb2NrIHR5cGVzIGxpa2UgaW14X2Nsa19nYXRlNC9pbXhfY2xrX3BsbDE0eHgsIGlmIHVz
aW5nIGNsa19od19yZWdpc3RlciwgbWVhbnMgd2UgbmVlZA0KdG8gcmUtd3JpdGUgdGhlIGNsb2Nr
IGRyaXZlciB1c2luZyBkaWZmZXJlbnQgY2xrIHJlZ2lzdGVyIG1ldGhvZCwgdGhhdCB3aWxsIG1h
a2UgdGhlIGRyaXZlcg0KY29tcGxldGVseSBkaWZmZXJlbnQgZnJvbSBpLm14OG1xL2kubXg4bW0s
IHRoZXkgYXJlIGFjdHVhbGx5IHNhbWUgc2VyaWVzIG9mIFNvQyBhcyBpLm14OG1uLA0KaXQgd2ls
bCBpbnRyb2R1Y2UgbWFueSBjb25mdXNpb24sIGlzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8g
QW5kIGlzIGl0IE9LIHRvIGp1c3Qga2VlcCB3aGF0DQppdCBpcyBhbmQgbWFrZSB0aGVtIGFsbCBh
bGlnbmVkPw0KDQpUaGFua3MsDQpBbnNvbi4NCg0KDQo=
