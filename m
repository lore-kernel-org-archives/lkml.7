Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6420878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p6PEVUGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfDZAeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:34:02 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:29443
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729434AbfDZAeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLVSnkfV7Lr3Ed2Zc8oueHPg/om0OZZz9Hfa//63np8=;
 b=p6PEVUGgmmf9+CICW63livICB+bd0ghNnXv1wDUNAN7zUtMvKtfTT30oBfYEFoqPrbEIUBKevqoJ3spYMTdwAYnqXYMVPaRUxZ8OJDcCO3iA9Ps+bSL6+5O17XlRLnvbecC7H6KfcdMnRS8KBWx5hbUbujE2Vhv4gPq8mSpB1KQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 00:33:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 00:33:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: correct i.MX7D AV PLL num/denom offset
Thread-Topic: [PATCH] clk: imx: correct i.MX7D AV PLL num/denom offset
Thread-Index: AQHU+OX1DkBqqv6CPk2NXEG9vnlY3qZNc5QAgAApkAA=
Date:   Fri, 26 Apr 2019 00:33:55 +0000
Message-ID: <DB3PR0402MB3916C8BA5E721BEE7522D43AF53E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555921647-21931-1-git-send-email-Anson.Huang@nxp.com>
 <155622979855.15276.5762308594961916461@swboyd.mtv.corp.google.com>
In-Reply-To: <155622979855.15276.5762308594961916461@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7c3a9f-6f3f-4ca9-1df8-08d6c9dedd49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-microsoft-antispam-prvs: <DB3PR0402MB3723DBA4F2ABCBE3A2427D53F53E0@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(13464003)(52314003)(6636002)(6436002)(2906002)(26005)(229853002)(66946007)(102836004)(3846002)(6116002)(4326008)(256004)(14444005)(86362001)(53936002)(66066001)(66446008)(6246003)(97736004)(66556008)(64756008)(66476007)(73956011)(81166006)(8676002)(81156014)(7736002)(305945005)(74316002)(8936002)(55016002)(52536014)(76116006)(9686003)(476003)(99286004)(486006)(25786009)(316002)(68736007)(7696005)(110136005)(446003)(186003)(33656002)(478600001)(11346002)(14454004)(2201001)(44832011)(6506007)(5660300002)(53546011)(71200400001)(45080400002)(2501003)(7416002)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HfAxaWf69iNXH8MSeP1zK7eXttlOT1l8QoeR9/8sV5Cvy+mE0c8Bz8AV+zodcc0lVStfdUHki6BeGvsyiO8V0sJ+OK6plF2png/yuE0TZLjJDfbghPmK1hRI5ehy09EetQqTQLKKqijJlD4pIyYeoUAvQWWjWP5O6cS641dORh1nYzuWJxlCrfxW9PXCDZ/ufuqPb1qgcvEsqxx3tPeezU/vJLcLJwJWsmmyf0gz7ofz5x1G2HuKQ4kxOkLRDB6vnXoTdqtHqG1ft6ujfUGVtE6ST0JCeTYF5UOCzqmlt472msw4qXyGjW94VmcE5TcLEYghLexNG60nW6KHnrzfx/2wWnbw3OU2JVdwScl+4gi2BM1VsC+9SBj3LrKUervp8EC43ZIIVIxXzG0Ut7PM7dW/0KQqIkeYPIvXPuj6g64=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7c3a9f-6f3f-4ca9-1df8-08d6c9dedd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 00:33:55.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBGcmlkYXksIEFwcmls
IDI2LCAyMDE5IDY6MDMgQU0NCj4gVG86IGZlc3RldmFtQGdtYWlsLmNvbTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eEByZW1wZWwtcHJpdmF0LmRlOyBtdHVycXVldHRl
QGJheWxpYnJlLmNvbTsNCj4gcnVpLnNpbHZhQGxpbmFyby5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHN0ZWZhbkBhZ25lci5jaDsgdGlueS53aW5k
enpAZ21haWwuY29tOyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsNCj4gQWlzaGVuZyBE
b25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uIEh1YW5nDQo+IDxhbnNvbi5odWFuZ0Bu
eHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPg0KPiBDYzogZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBpbXg6IGNv
cnJlY3QgaS5NWDdEIEFWIFBMTCBudW0vZGVub20gb2Zmc2V0DQo+IA0KPiBRdW90aW5nIEFuc29u
IEh1YW5nICgyMDE5LTA0LTIyIDAxOjMyOjQ1KQ0KPiA+IEFjY29yZGluZyByZWZlcmVuY2UgbWFu
dWFsLCBpLk1YN0QncyBhdWRpby92aWRlbyBQTEwncyBudW0vZGVub20NCj4gPiByZWdpc3RlciBv
ZmZzZXQgYXJlIDB4MjAvMHgzMCwgdGhleSBhcmUgZGlmZmVyZW50IGZyb20gaS5NWDYncw0KPiA+
IGF1ZGlvL3ZpZGVvIFBMTCwgY29ycmVjdCBpdCBieSBpbnRyb2R1Y2luZyBuZXcgb2Zmc2V0IHZh
cmlhYmxlcyBmb3INCj4gPiBhdWRpby92aWRlbyBQTEwgYW5kIHVzaW5nIHJ1bnRpbWUgYXNzaWdu
bWVudCBiYXNlZCBvbiBQTEwgdHlwZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gSXMgdGhlcmUgYW55IHdh
eSB5b3UgY2FuIHNlbmQgcGxhaW4tdGV4dCBlbWFpbHMgaW5zdGVhZCBvZiBiYXNlNjQgZW5jb2Rl
ZA0KPiBlbWFpbHM/IEkgaGFkIHRvIGdldCB0aGlzIGVtYWlsIHByb3Blcmx5IGRlY29kZWQgaW4g
cGxhaW4gdGV4dCBzbyB0aGF0IGl0IHdvdWxkDQo+IGFwcGx5IGNvcnJlY3RseS4gSSB0aGluayBp
dCdzIGFuIE91dGxvb2sgcHJvYmxlbS4NCg0KWWVzLCBpdCBzaG91bGQgYmUgZGVmYXVsdCBPdXRs
b29rIHNldHRpbmcgcHJvYmxlbSwgbm93IEkgY2hhbmdlIHRoZSBwcmVmZXJyZWQgZW5jb2RpbmcN
CmFzIFVuaWNvZGUgKFVURi04KSBmb3Igb3V0LWdvaW5nIG1lc3NhZ2UsIGl0IHdhcyBHQjIzMTIg
YmVmb3JlLCBob3BlIGl0IGNhbiBmaXggdGhpcyBpc3N1ZS4NClRoYW5rcyBmb3IgcmVtaW5kZXIg
YW5kIHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4NCg0KQW5zb24uDQoNCj4gDQo+IEFueXdh
eSwgYXBwbGllZCB0byBjbGstbmV4dA0KDQo=
