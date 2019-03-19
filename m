Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5917C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855C92146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lRfSzEJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCSM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:28:38 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:20197
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfCSM2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGP11BBQQPM/6oNU39C+8P6X45/Mg42/1uo1ehjeac8=;
 b=lRfSzEJX11TOuA3xw4mJpmNcFq9wzXey019neePxgiuzGRj591H5SX4b2EXD6SnF6xSfwljFILX38UAgZixhlxLloLm2jnRye8ZxSq8GEKkycspMF/cU1biJVpTZqP52+yBId+Pdrmwgp3Y+4bTJFgxGy7AsSzRPdfiKAslRb60=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5603.eurprd04.prod.outlook.com (20.178.203.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 12:28:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 12:28:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init
 fail
Thread-Topic: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when
 imx_soc_device_init fail
Thread-Index: AQHU2Xv55ycgcbWqOUOiTJMdwKpBc6YMfvcAgAArCTCAAAw4AIAGNBew
Date:   Tue, 19 Mar 2019 12:28:31 +0000
Message-ID: <AM0PR04MB44819E0CEE2EFD6F52CA695388400@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <20190313091757.16410-2-peng.fan@nxp.com>
 <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB44817A913A33ECEC6D572D7E88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB42118397D4F1F1DD2F14E7FB80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42118397D4F1F1DD2F14E7FB80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df04570d-ac5e-41a7-7060-08d6ac6665c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5603;
x-ms-traffictypediagnostic: AM0PR04MB5603:
x-microsoft-antispam-prvs: <AM0PR04MB56036A6BB1BB1CED329C58D388400@AM0PR04MB5603.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(366004)(136003)(39860400002)(346002)(13464003)(199004)(189003)(25786009)(4326008)(86362001)(2201001)(44832011)(6436002)(52536014)(66066001)(256004)(81156014)(305945005)(478600001)(74316002)(8936002)(7736002)(68736007)(81166006)(14454004)(8676002)(229853002)(5660300002)(26005)(14444005)(2501003)(6506007)(186003)(102836004)(446003)(99286004)(3846002)(7696005)(6116002)(6246003)(476003)(2906002)(11346002)(71200400001)(71190400001)(316002)(93886005)(53936002)(486006)(105586002)(53546011)(33656002)(106356001)(97736004)(110136005)(76176011)(55016002)(9686003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5603;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNr2uPrTEXYgzuQXnYU6pOOEOLEWWKpyODoVfD1hEb6nUY6tfcmjE2zGwleota+LeSsVvGxDadbc+iBAOFke3/+AT79GSWEHcMy5OQcoJGTgmWmzpwll2nbkw31Mp3QTvMUEDAmrBpuUZrAlPf5/nqiXuXd7ZXsq+dZ/INfgnVk4Z2CLPCzrskec08+Jgj8UU5sEXuu87rzJwt13NIDFSO9jBlPnLzOM1TznLR0ZG/8cWz8ZD09XoKax8G7n9kOyTk7lifXwLA3rp8p9k9KbFyDeiuECXcz1uJvcl+BsW4tjmIFs0cX1Ui5MPvYf9tshyWa2c8Gs4l3w+LaNL3yni21ndcfuFPha+hPRP18/O4F0/nkEZqyyn26bZOaJxu/KakjOm//6KxO6AkPxc119QhY3oB3GR6F8Ir7gxtXrpqA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df04570d-ac5e-41a7-7060-08d6ac6665c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 12:28:31.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+
IFNlbnQ6IDIwMTnE6jPUwjE1yNUgMjE6NDANCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47DQo+
IGFybmRAYXJuZGIuZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogdmFuLmZyZWVuaXhAZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBBUk06IGlteDogbWFjaC1pbXg3dWxwOiB3YXJu
IHdoZW4NCj4gaW14X3NvY19kZXZpY2VfaW5pdCBmYWlsDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+
ID4gRm9sbG93IG90aGVyIGkuTVg2LzcgbWFjaGluY2UgY29kZSB0byBjaGVjayByZXR1cm4gdmFs
dWUgb2YNCj4gPiA+ID4gaW14X3NvY19kZXZpY2VfaW5pdCBhbmQgd2FybiB3aGVuIGZhaWwuDQo+
ID4gPiA+DQo+ID4gPiA+IEFsc28gZHJvcCBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlLCBi
ZWNhdXNlDQo+ID4gPiA+ICJhcmNoX2luaXRjYWxsX3N5bmMob2ZfcGxhdGZvcm1fZGVmYXVsdF9w
b3B1bGF0ZV9pbml0KTsiIGNvdWxkIGJlDQo+ID4gPiA+IHVzZWQgdG8gcG9wdWxhdGUgdGhlIGRl
dmljZSB0cmVlLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFRoaXMgY291bGQgYmUgaW4gc2VwYXJh
dGUgcGF0Y2guDQo+ID4NCj4gPiBJJ2xsIGRvIGl0IGluIHYyIGFmdGVyIHdlIGFncmVlIHRoZSBj
aGFuZ2UgaW4gdGhlIGZpcnN0IHBhdGNoLg0KPiA+DQo+IA0KPiBJIHRoaW5rIGlteDd1bHAgZG9l
cyBub3QgaGF2ZSB0aGUgaXNzdWUgaW4gcGF0Y2ggMS4NCg0KTWlzc2VkIHRvIHJlcGx5IHlvdS4N
ClNvIGRvIHlvdSBhZ3JlZSB0byBzcGxpdCB0aGlzIHBhdGNoIGludG8gdHdvDQpwYXRjaGVzID8g
b3IgbGVhdmUgdGhlIGNvZGUgYXMgaXQgaXM/DQoNClRoZSBmaXJzdCBpcyBmb2xsb3cgb3RoZXIg
aS5teDYvNyB0byBjaGVjayByZXR1cm4gdmFsdWUgb2YNCmlteF9zb2NfZGV2aWNlX2luaXQuIA0K
VGhlIHNlY29uZCBpcyBkcm9wIHRoZSBjYWxsIHRvIG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxh
dGUuDQoNClRoYW5rcywNClBlbmcNCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4g
DQo+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDd1bHAu
YyB8IDcgKysrKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1pbXgvbWFjaC1pbXg3dWxwLmMNCj4gPiA+ID4gYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlt
eDd1bHAuYw0KPiA+ID4gPiBpbmRleCAxMWFjNzFhYWY5NjUuLjZkODIzZjA1ZDlhYSAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg3dWxwLmMNCj4gPiA+ID4g
KysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg3dWxwLmMNCj4gPiA+ID4gQEAgLTUzLDEx
ICs1MywxNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW14N3VscF9zZXRfcmV2aXNpb24odm9pZCkN
Cj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyB2b2lkIF9faW5pdCBpbXg3dWxwX2luaXRfbWFjaGlu
ZSh2b2lkKSAgew0KPiA+ID4gPiArCXN0cnVjdCBkZXZpY2UgKnNvY19kZXY7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwlzb2NfZGV2ID0gaW14X3NvY19kZXZpY2VfaW5pdCgpOw0KPiA+ID4gPiArCWlm
IChzb2NfZGV2ID09IE5VTEwpDQo+ID4gPiA+ICsJCXByX3dhcm4oImZhaWxlZCB0byBpbml0aWFs
aXplIHNvYyBkZXZpY2VcbiIpOw0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gU2hvdWxkIHRoaXMg
YmUgdW5kZXIgc2V0IHJldmlzaW9uPw0KPiA+DQo+ID4gSnVzdCBmb2xsb3cgb3RoZXIgaS5NWDYv
NyBwbGF0Zm9ybXMgcHJhY3RpY2UsIEkgY291bGQgbW92ZSB0aGlzIHVuZGVyDQo+ID4gc2V0IHJl
dmlzaW9uIGluIHYyIGlmIHlvdSBwcmVmZXIuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gUGVuZy4N
Cj4gPg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMNCj4gPiA+IERvbmcgQWlzaGVuZw0KPiA+ID4NCj4g
PiA+ID4gIAlpbXg3dWxwX3BtX2luaXQoKTsNCj4gPiA+ID4NCj4gPiA+ID4gIAlteGNfc2V0X2Nw
dV90eXBlKE1YQ19DUFVfSU1YN1VMUCk7DQo+ID4gPiA+ICAJaW14N3VscF9zZXRfcmV2aXNpb24o
KTsNCj4gPiA+ID4gLQlvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlKE5VTEwsIE5VTEwsIGlt
eF9zb2NfZGV2aWNlX2luaXQoKSk7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+ICBzdGF0
aWMgY29uc3QgY2hhciAqY29uc3QgaW14N3VscF9kdF9jb21wYXRbXSBfX2luaXRjb25zdCA9IHsN
Cj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNi40DQoNCg==
