Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D2C04AA9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBC02075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vpGZDjDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfECCij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 22:38:39 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:50758
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfECCij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 22:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DyR/VMc79T8e3vsOSHIHHZjnGjwQBVNynW38hDDuKo=;
 b=vpGZDjDnH4k6EZkhCURC6u5n6nbphTA2oYpA+h+QQJtgkFpyVSlWkx4PkrlMo6HoOctygTZk/pKPx0V2Yyso8ZHQ5eLNBbaym/k2UFkoeFd+9VXId8bqhC36JekJBXIwUNUpGHEgYIs2V7wLRPZUCp+OJ9HKSVkw1nuuYKlAKMk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5588.eurprd04.prod.outlook.com (20.178.119.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 02:38:35 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 02:38:35 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Topic: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Index: AQHU/u+rfzNhsf6HmUqZui5Dk6oOlaZWxBSAgAHvysA=
Date:   Fri, 3 May 2019 02:38:34 +0000
Message-ID: <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
 <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
In-Reply-To: <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f61156a8-36f4-46d9-aed9-08d6cf707083
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5588;
x-ms-traffictypediagnostic: AM0PR04MB5588:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB5588A574C15F7AAFE8C7575B80350@AM0PR04MB5588.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(256004)(478600001)(6436002)(966005)(11346002)(14454004)(66946007)(446003)(66066001)(55016002)(6306002)(110136005)(316002)(476003)(66476007)(66556008)(64756008)(33656002)(99286004)(9686003)(53936002)(66446008)(3846002)(6116002)(81156014)(8676002)(8936002)(81166006)(76116006)(6246003)(229853002)(68736007)(44832011)(73956011)(2501003)(7696005)(76176011)(2906002)(305945005)(4326008)(486006)(102836004)(6636002)(6506007)(25786009)(52536014)(5660300002)(7736002)(186003)(4744005)(26005)(2201001)(71200400001)(74316002)(86362001)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5588;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H1ewNlVAy4FDmQSMOq09xIwokzf0cl4onzDU/53npU7PzNc5irxJSpc01V5j0ni1FbMERiSxYSoUVrDYha8d//S1Heo5fEeXW8swYDHW60s7FMOgbx4ArGbi57M6jouHdzxGaytBX9pL9OvaqNuVSuRtq6DtTuGcH0yx4WkrLYT8YFpVZ2c6wMpdwIVVaM/jy9xRg5ufREHE7Jg+aRnv8LORogHt+22c+9H55UHv7H30tqO9rpwJP4Q72bpqH/EEWYWtj1HB9veFebFut4n5kRdxd2asXWo6Ly2Kn5H6rQGLsUwr4prf1ISHGnCiLq04ersZJQSqy10gKATahOzBGH5YO7LMoks8KbmxxHMadzuHeDmCgTXQ1OHAGT3UUsz46fahEi3plz5heBfPupgyGSIB1GSYIvO/Q9QHBXC9O0M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61156a8-36f4-46d9-aed9-08d6cf707083
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 02:38:34.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBU
aHVyc2RheSwgTWF5IDIsIDIwMTkgNTowMSBBTQ0KPiANCj4gVGhlIENvbnRlbnQtdHJhbnNmZXIt
ZW5jb2RpbmcgaGVhZGVyIGlzIHN0aWxsIGJhc2U2NC4gSSBndWVzcyBpdCBjYW4ndCBiZSBmaXhl
ZC4NCj4gDQoNCkhvdyBjYW4gd2Uga25vdyBpdCdzIGJhc2U2ND8NCkFzIEkgc2F3IGZyb20gdGhl
ICdIZWFkZXJzJyBpbiBwYXRjaHdvcmssIGl0J3M6DQoiQ29udGVudC1UeXBlOiB0ZXh0L3BsYWlu
OyBjaGFyc2V0PSJ1cy1hc2NpaSINCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDdiaXQiDQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwOTIyNjU3Lw0KDQpXZSdkIGxpa2Ug
dG8gZml4IGl0IHRoaXMuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IFF1b3RpbmcgQW5z
b24gSHVhbmcgKDIwMTktMDQtMjkgMTc6NTc6MjIpDQo+ID4gVGhlIHBsbHY0IHN1cHBvcnRzIGZy
YWN0aW9uYWwtTiBmdW5jdGlvbiwgdGhlIGZvcm11bGEgaXM6DQo+ID4NCj4gPiBQTEwgb3V0cHV0
IGZyZXEgPSBpbnB1dCAqIChtdWx0ICsgbnVtL2Rlbm9tKSwNCj4gPg0KPiA+IFRoaXMgcGF0Y2gg
YWRkcyBmcmFjdGlvbmFsLU4gZnVuY3Rpb24gc3VwcG9ydCwgaW5jbHVkaW5nIGNsb2NrIHJvdW5k
DQo+ID4gcmF0ZSwgY2FsY3VsYXRlIHJhdGUgYW5kIHNldCByYXRlLCB3aXRoIHRoaXMgcGF0Y2gs
IHRoZSBjbG9jayByYXRlIG9mDQo+ID4gQVBMTCBpbiBjbG9jayB0cmVlIGlzIG1vcmUgYWNjdXJh
dGUgdGhhbiBiZWZvcmU6DQo+ID4NCg==
