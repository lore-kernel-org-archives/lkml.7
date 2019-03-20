Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE62EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714A621850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cACuFUq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCTGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:47:25 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:46350
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfCTGrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkOjd0mJEhxlRnzhIhy8Cdki0a5nyRib1h/pCbWDIfM=;
 b=cACuFUq6FGWrICOs27ShIUOuK17UzrFYI9h6Pv7Hqww6YpsDI7k5zSLAZZWrtF1Y2in6V2xq8GTs2H5tBrFGmj7mVQZcphg0yOqReOAltKyqAKZY/TlJTi34aeBkGzMj95aZBGDg5o/Uw2mDVpqQ8YMg9tzmtai+0yiMbcRsJZ0=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3735.eurprd04.prod.outlook.com (52.133.29.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 06:47:20 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::7cb2:3013:bfa9:8ddd%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 06:47:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] clk: imx7ulp: remove snvs clock
Thread-Topic: [PATCH 1/2] clk: imx7ulp: remove snvs clock
Thread-Index: AQHUz0NtVPRcCCKjzkOVq1EKU+GmAqYUMvYA
Date:   Wed, 20 Mar 2019 06:47:20 +0000
Message-ID: <AM6PR0402MB39113020252197C138A83DBBF5410@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db8b24c3-00bd-411a-6fb1-08d6acffe678
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3735;
x-ms-traffictypediagnostic: AM6PR0402MB3735:
x-microsoft-antispam-prvs: <AM6PR0402MB3735F95AF13736351A335FF7F5410@AM6PR0402MB3735.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(346002)(396003)(13464003)(199004)(189003)(71200400001)(110136005)(6116002)(3846002)(53546011)(71190400001)(229853002)(68736007)(2501003)(6436002)(478600001)(55016002)(9686003)(8936002)(256004)(6506007)(53936002)(186003)(26005)(6246003)(5660300002)(2906002)(97736004)(86362001)(11346002)(446003)(66066001)(99286004)(52536014)(14444005)(7696005)(7416002)(33656002)(316002)(102836004)(74316002)(305945005)(25786009)(76176011)(4326008)(8676002)(486006)(81156014)(81166006)(14454004)(105586002)(476003)(44832011)(106356001)(7736002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3735;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8UhPtuckUhMJcPoXtvD0/ZiusLMgaC/QsP7Li4iIEmCl4DTSiSRBxfQoavBz9P9hZYlmyn2efz3tjWXCADd314kA5FZ8A+eEb/f2hponI5/BVwN/PZYYvY7DhhI6eOkGTtfL+guDy1mraJV8+DRQmogAQfeUykPvSeKgXYt4jQ6tLuLh3jZjNb885sjb7839DoWpgUr/9dR9aeapuOz2zDFSHOpMn2BIHVVJhccFODUCVyGq5ekK8cxzdaKWFYXW/Hqyej+nx81rbcL8zPxn6C+PxTyv1FGWHiRN5vBJFPY9ZnG4Cud1suqQr28e7mhCJDoxOhpBPiapLtXtQWySSslIK3amHqyMxm0Qau4kxDy4dc5rNhTnimmEk4E3Sl66COCqGMbIvgpyTTB+QTFQ+pZ0VPXF31lSH6yVtz9sUWc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b24c3-00bd-411a-6fb1-08d6acffe678
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 06:47:20.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+IFNlbnQ6IDIwMTnE6jLUwjI4yNUg
MTY6NTYNCj4gVG86IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBz
aGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47IGd1c3Rhdm9AZW1iZWRkZWRvci5jb207IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDEvMl0gY2xrOiBp
bXg3dWxwOiByZW1vdmUgc252cyBjbG9jaw0KPiANCj4gU2luY2UgaS5NWDdVTFAgQjAgY2hpcCwg
dGhlIFNOVlMgbW9kdWxlIGlzIG1vdmVkIGludG8gTTQgZG9tYWluIGFuZCBpdHMNCj4gY2xvY2sg
aXMgYWxzbyBtb3ZlZCBpbnRvIFBDQzAgd2hpY2ggaXMgY29udG9ybGxlZCBieSBNNCwgTGludXgg
a2VybmVsIHNob3VsZA0KPiBOT1QgYWRkIGl0IGludG8gY2xvY2sgdHJlZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvY2xrL2lteC9jbGstaW14N3VscC5jIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14N3Vs
cC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCj4gaW5kZXggY2UzMDY2My4uNjY2
ODIxMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCj4gKysr
IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg3dWxwLmMNCj4gQEAgLTE1MSw3ICsxNTEsNiBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgaW14N3VscF9jbGtfcGNjMl9pbml0KHN0cnVjdA0KPiBkZXZpY2Vf
bm9kZSAqbnApDQo+ICAJY2xrc1tJTVg3VUxQX0NMS19ETUExXQkJPSBpbXhfY2xrX2h3X2dhdGUo
ImRtYTEiLA0KPiAibmljMV9jbGsiLCBiYXNlICsgMHgyMCwgMzApOw0KPiAgCWNsa3NbSU1YN1VM
UF9DTEtfUkdQSU8yUDFdCT0gaW14X2Nsa19od19nYXRlKCJyZ3BpbzJwMSIsDQo+ICJuaWMxX2J1
c19jbGsiLCBiYXNlICsgMHgzYywgMzApOw0KPiAgCWNsa3NbSU1YN1VMUF9DTEtfRE1BX01VWDFd
CT0NCj4gaW14X2Nsa19od19nYXRlKCJkbWFfbXV4MSIsICJuaWMxX2J1c19jbGsiLCBiYXNlICsg
MHg4NCwgMzApOw0KPiAtCWNsa3NbSU1YN1VMUF9DTEtfU05WU10JCT0gaW14X2Nsa19od19nYXRl
KCJzbnZzIiwNCj4gIm5pYzFfYnVzX2NsayIsIGJhc2UgKyAweDhjLCAzMCk7DQo+ICAJY2xrc1tJ
TVg3VUxQX0NMS19DQUFNXQkJPSBpbXhfY2xrX2h3X2dhdGUoImNhYW0iLA0KPiAibmljMV9jbGsi
LCBiYXNlICsgMHg5MCwgMzApOw0KPiAgCWNsa3NbSU1YN1VMUF9DTEtfTFBUUE00XQk9IGlteDd1
bHBfY2xrX2NvbXBvc2l0ZSgibHB0cG00IiwNCj4gcGVyaXBoX2J1c19zZWxzLCBBUlJBWV9TSVpF
KHBlcmlwaF9idXNfc2VscyksIHRydWUsIGZhbHNlLCB0cnVlLCBiYXNlICsNCj4gMHg5NCk7DQo+
ICAJY2xrc1tJTVg3VUxQX0NMS19MUFRQTTVdCT0gaW14N3VscF9jbGtfY29tcG9zaXRlKCJscHRw
bTUiLA0KPiBwZXJpcGhfYnVzX3NlbHMsIEFSUkFZX1NJWkUocGVyaXBoX2J1c19zZWxzKSwgdHJ1
ZSwgZmFsc2UsIHRydWUsIGJhc2UgKw0KPiAweDk4KTsNCj4gLS0NCj4gMi43LjQNCg0K
