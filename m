Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DFC04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA95208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LwCEbAUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEEGS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:18:59 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:30195
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfEEGS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8R0MvHKzj411tNX4gfJsUNaKlHZwVSg7Jb/ueDwO8=;
 b=LwCEbAUyw4dHFSgee2v5gZgwkJJvIUd1xBFhoPFT+Ws9GSGIanxqUuvNrZKPH7RNYUeaLBd74GiGavwddVrlkGPswldUNEsYSQ/4QeBYmZl0ETNpLL6c73RvLWblbpnvfLEBIyaL76KDyhqJbOknev9PcFpkw6erKJ0nWtP3ndU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4354.eurprd04.prod.outlook.com (52.134.90.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 06:18:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:18:55 +0000
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
Thread-Index: AQHU/u+rfzNhsf6HmUqZui5Dk6oOlaZWxBSAgAHvysCAAODygIACgJxA
Date:   Sun, 5 May 2019 06:18:55 +0000
Message-ID: <AM0PR04MB4211AC8E7CC006F31565BB9880370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
 <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <155689923561.200842.16988174858654134777@swboyd.mtv.corp.google.com>
In-Reply-To: <155689923561.200842.16988174858654134777@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9539e486-3764-4c01-7dde-08d6d1218d42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4354;
x-ms-traffictypediagnostic: AM0PR04MB4354:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB4354C78C53FC8C28CD4BAEA180370@AM0PR04MB4354.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(2501003)(86362001)(26005)(966005)(110136005)(33656002)(71190400001)(53936002)(2201001)(7696005)(99286004)(6636002)(76176011)(316002)(3846002)(6116002)(14444005)(71200400001)(2906002)(102836004)(44832011)(256004)(478600001)(6506007)(53546011)(14454004)(186003)(486006)(11346002)(476003)(446003)(305945005)(66066001)(66556008)(66946007)(7736002)(64756008)(73956011)(66446008)(76116006)(8676002)(81156014)(8936002)(81166006)(66476007)(6436002)(5660300002)(229853002)(68736007)(74316002)(52536014)(6246003)(6306002)(55016002)(9686003)(25786009)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4354;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0scLZRmpCkb9Q2RH0poq9nBOqY7FG6R+wf/KqmV7kPoGpQuya/KD5WDIvoaoXxhaOgbZsLzRCmM/QdYcymXr4edCAYdhOL3e3fylhQamyXPuvF06SYXAs2Psf8nuFfPuWBPo9b22wi1+hBOihAKuoZUUXjj99fhaq6SVhVa+A1JILq+z53+2fEVCpIHUv0oXRWOfgKnLVip1Bee7tUWNl6NWBS5IggiYnCZLpsUKzenplNR3eYjc48bKopOVDvleQa23RFjvBXKYXTtSnm0yvx7MMp/MnAnDX60T9sb9U6VX8+i2XKyBsbEiDR8SH4xiyZQRGrg29npb72q7IRK8fO7ALtxfd93olr9bLiNI4Vrng/tokcTCNRXyp1voawWaOepGOyru5L8BxAEUO6ZDFWLSiw6R+KynXJQ7W3/PiWo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9539e486-3764-4c01-7dde-08d6d1218d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:18:55.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBT
YXR1cmRheSwgTWF5IDQsIDIwMTkgMTI6MDEgQU0NCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMl0g
Y2xrOiBpbXg6IHBsbHY0OiBhZGQgZnJhY3Rpb25hbC1OIHBsbCBzdXBwb3J0DQo+IA0KPiBRdW90
aW5nIEFpc2hlbmcgRG9uZyAoMjAxOS0wNS0wMiAxOTozODozNCkNCj4gPiA+IEZyb206IFN0ZXBo
ZW4gQm95ZCBbbWFpbHRvOnNib3lkQGtlcm5lbC5vcmddDQo+ID4gPiBTZW50OiBUaHVyc2RheSwg
TWF5IDIsIDIwMTkgNTowMSBBTQ0KPiA+ID4NCj4gPiA+IFRoZSBDb250ZW50LXRyYW5zZmVyLWVu
Y29kaW5nIGhlYWRlciBpcyBzdGlsbCBiYXNlNjQuIEkgZ3Vlc3MgaXQgY2FuJ3QgYmUNCj4gZml4
ZWQuDQo+ID4gPg0KPiA+IEhvdyBjYW4gd2Uga25vdyBpdCdzIGJhc2U2ND8NCj4gPiBBcyBJIHNh
dyBmcm9tIHRoZSAnSGVhZGVycycgaW4gcGF0Y2h3b3JrLCBpdCdzOg0KPiA+ICJDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9InVzLWFzY2lpIg0KPiA+IENvbnRlbnQtVHJhbnNmZXIt
RW5jb2Rpbmc6IDdiaXQiDQo+ID4NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwOTIyNjU3Lw0KPiA+DQo+ID4gV2UnZCBsaWtlIHRvIGZpeCBpdCB0aGlzLg0KPiA+DQo+
IA0KPiBBbHNvLCBpZiB5b3UgbG9vayBhdCB0aGUgb25lIGZvciBsaW51eC1jbGsgbWFpbGluZyBs
aXN0IHlvdSdsbCBzZWUNCj4gYmFzZTY0IENURToNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMDkyMTExNS8NCg0KV2Ugc3VzcGVjdCBpdCdzIG91ciBzZXJ2ZXIgY29uZmln
dXJhdGlvbiBpc3N1ZS4NCkkndmUgYWxyZWFkeSBzdWJtaXR0ZWQgYSB0aWNrZXQgZm9yIG91ciBJ
VCBkZXBhcnRtZW50IHRvIGNoZWNrLg0KDQpCVFcsIGZvciB3aHkgd2UgZGlkIG5vdCBzZWUgYmFz
ZTY0IGVuY29kaW5nIGZyb20gYXJtIExpbnV4IG1haWxsaXN0LA0KTm90IHN1cmUgaWYgaXQncyBh
dXRvbWF0aWNhbGx5IGNvbnZlcnRlZCB0byA4Yml0IGVuY29kaW5nIGJ5IGFybS1saW51eA0KbWFp
bGxpc3QgcGF0Y2h3b3JrLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
