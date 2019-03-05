Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C40820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ptf7pKV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCEIgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:36:10 -0500
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:39232
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfCEIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF9qRI5WdX1KAW2Zq6R93g/wUYV8NEte/JzvyingKFU=;
 b=Ptf7pKV/YYL44Y2mqmt3xTrDKdWLR75g8y8R4cyahETSCk3XK/dH5tS5v6dQr9n//rwWyMLBM9tlANuq5hOvndjayDAdHx1hnTKTPGJvxbaBBV7wYzGzMqCAqEUuFasnkoze1uLefclIniTkKQhsDk2oO/8/IaA8NJ/CgJweWHE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5970.eurprd04.prod.outlook.com (20.178.115.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 5 Mar 2019 08:36:02 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 08:36:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: freescale: fix link errors
Thread-Topic: [PATCH] pinctrl: freescale: fix link errors
Thread-Index: AQHU0siXMm/T+Al1I0+bP+tD9ymveqX8WLJQgABc4wCAAADHAA==
Date:   Tue, 5 Mar 2019 08:36:02 +0000
Message-ID: <AM0PR04MB4211D92C87F80E08805D4A8180720@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190304202640.1765847-1-arnd@arndb.de>
 <AM0PR04MB42119B4C4FE9DE3A352A0FB480720@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAK8P3a2jAc_5A1cTF8BEmmqNRVDp0vAhcKTcPT7eK4GQYn-tOw@mail.gmail.com>
In-Reply-To: <CAK8P3a2jAc_5A1cTF8BEmmqNRVDp0vAhcKTcPT7eK4GQYn-tOw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11cee869-655f-4b85-dbd1-08d6a14599c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5970;
x-ms-traffictypediagnostic: AM0PR04MB5970:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI1OTcwOzIzOnQ0eWljTk9oWDNTTnM3VFRlVkpuL2tiZzVQ?=
 =?utf-8?B?RHp5N1kxREpSMWw1bDBqQ0RsZ0RmZXJvMVExMFpLMTdOd1E2V0hLaVdtY0Nw?=
 =?utf-8?B?WDMvSnZMN1JGSTlJLzdJVWxnLzZ1cjNvTUdEL1pOeVhCcUJ5a3NKc1NFSUhh?=
 =?utf-8?B?K2Y0UFUrZjlWQUc5MmdaM0VCVnNxcU12bzBRSFR5ZzVuWTdvOVNpcEY3b1V6?=
 =?utf-8?B?MFNJWTJtRmFrdnFTMEdyNDFPRUs0NEUwRDNtbUxVaENzSmJBMlFpZ1IvNEoy?=
 =?utf-8?B?ZGZYalJSU3FjZklicWRvVng5N1p3blJ3NnNPVytxdndTZDJkMWpzTTFOZXZD?=
 =?utf-8?B?L0FiZmNheXBsbXBEY0xzRFYzSVRvckNTTkdCQkE2TisrZzI4V0NpbWo3bVRK?=
 =?utf-8?B?czdNYnkxSS9iVldxbFUvOEVMZ3JmblI1YWFKQlM0bEVVWUJqMExyUW9mdGd5?=
 =?utf-8?B?UnE5azVwY0xTRjhSVzRoNEM3NXgrWU9McWQybFdRMEdKeUtycDB4WTV1bnVp?=
 =?utf-8?B?ZXJBemY4V045bGgzRExPZGU4ZG1iVFdHU3Nsa0pmem84VzZsckhPOXp5TU5F?=
 =?utf-8?B?VFYyVElOUGc3dGkzT0FvUW5ucGoxbDJXN3FVa3B3N09aQ3NQK0Y3a3JsWnVn?=
 =?utf-8?B?TWh1cnZqNUhPVjJLbUpnWVgwUERiTVlkUXIrbWFnQ1BiMjJRUVZRNVJiSVFO?=
 =?utf-8?B?WVZNQmhlOURYWmxNWC9yL3FXdUlLM2xia0hYZ3ZadElaRldRdENnTGt6V3Ru?=
 =?utf-8?B?RzBoclZrQjBjUGx6ZGdYUGxtWTk4aUIwKzA4VERlT1lmT2pUQlhhUmdtWXFl?=
 =?utf-8?B?TUFXVHlRQUVMK1FGN3lEQWZ6dGFYZlpycDBGbFBTOHRDL0tNWUVaMTNSRjk1?=
 =?utf-8?B?djcvRUFRVTVPYVVqZEtjNEhTekxFQU9ScENaNWRhVkIxdngraWd1ZUlwMnlK?=
 =?utf-8?B?bHVFbk9JVDZJMGNpRXNTczlNSVcvZnFGSlNsc3pPMUZZd3hxd3c5V1VTVVA3?=
 =?utf-8?B?R09qWDNlNEJ3a2YyRDhUSGZiMVV4SHpVRlA5UmJIdzZGd0JoZVROQWU0NkR3?=
 =?utf-8?B?UkpjeGxOK2JkZXJZMlN1Sk9nVFVEdGdKS1VjcFM2WnVzd2lSVGhRQ2V0WXBl?=
 =?utf-8?B?bDB3T1VGSjZKbWI0eHZybXBFeXRyMUJiOXJwSnBNUmxCOCtkQk9CbkdGZG9o?=
 =?utf-8?B?NTdkL2VFZTRYcFZ1TVV2Y2xWYWNCd0UzK2swUFVGRTlmMEdhd1JoTnpaN1V4?=
 =?utf-8?B?Y2NrUnVIWjVvOXZuTXorb0ZjMlZrSUQ1VWpaS3pkOVQzU2dOL0VwVG83eGhw?=
 =?utf-8?B?UExuVjJmTnEza0FXT1l1WFFoQndvSzlIbGFGMEplM0ZuZmczMm94TEJkdjFS?=
 =?utf-8?B?RndpNm9iRUtPUmdhTThVay9ITFovYm5YTExqVE9NTDhCZU0xSzl0UnlObWlE?=
 =?utf-8?B?OGczRXplNlJsdC94MHpqaHZJY1ZTaU5FV2RUdldTNmJTQklCZHAwS1NLSlFj?=
 =?utf-8?B?RHdZbEY2S2FFK09CK05BSFp0V21lS29JNDgrb1V3UXc0b2M5Tm9wVXd6RXJa?=
 =?utf-8?B?TXdPdVZlZ2hBdFl4R0ZWQ0xjSmR4Z05ITElnMk5UcFlaTFZZaGR6L2VCSm9F?=
 =?utf-8?B?UVNUYVpxNjRlenNUa3dsWk1VRUhtNXVyYUE0R041dEo3WnJuMTh6UG0xUnMy?=
 =?utf-8?B?RXFXdFpnZWRaWXJ6cllzQjZVT05MU1FzUlNST3ZZd2V4Nm1HdG10aXZlTnFH?=
 =?utf-8?Q?k1JTFVKDfes9pYcAKQJEQOVPgp54QBATcKI+E=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5970AB9AFA8A723D1A89AC9F80720@AM0PR04MB5970.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(25786009)(4744005)(81156014)(2906002)(7416002)(186003)(97736004)(486006)(44832011)(105586002)(6916009)(33656002)(476003)(106356001)(11346002)(229853002)(5660300002)(8676002)(478600001)(305945005)(71190400001)(71200400001)(256004)(6246003)(6346003)(81166006)(7696005)(99286004)(74316002)(446003)(55016002)(102836004)(9686003)(3846002)(6436002)(66066001)(26005)(4326008)(52536013)(7736002)(86362001)(54906003)(316002)(53546011)(14454004)(68736007)(76176011)(6116002)(6506007)(8936002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5970;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RMddPfT9u9xXQW03GYmn/pWt+e1FLiZ3sxlsJ/p8/xkiMUgE5gxozezsLR5o6A/BDE5CpykMg7pXCqiA4MgjqQW0h/+50L6RFO+G4hqYiTbTPeIhZly55onZ+0x9SacTxYcHCD4V6iQiSmIq38n+YM+M1rR0BV8sbmF7/Y/OH8ZscJlXw62ugJpTKIcQ0JfbF2HsyjWl4XrHjFH0dgk8TRHUIU9isvZs9CbgTNuXdxbGKk28F1wXoAxuyC+KdCPvB2lGVxn4DgDUbhgxJSEMscnnFKlfB2+y/kZkmQoreWJtZISwN5WjCIkQjySizjOPtNiYUt4hwwiMOb+tc0LkiI5D5DtVtWfti9Dau1In3FkhZ3SugilTuIWkZpYcyaZgQnJYJjaN1HOYrn66s4Erpt16ZpKK4jcr2CozH9cdBbo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cee869-655f-4b85-dbd1-08d6a14599c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 08:36:02.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWlsdG86YXJuZEBhcm5kYi5kZV0NCj4gU2VudDogVHVl
c2RheSwgTWFyY2ggNSwgMjAxOSA0OjMwIFBNDQo+IE9uIFR1ZSwgTWFyIDUsIDIwMTkgYXQgNDow
MCBBTSBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEhpIEFybmQsDQo+ID4NCj4gPiA+IEZyb206IEFybmQgQmVyZ21hbm4gW21haWx0bzphcm5k
QGFybmRiLmRlXQ0KPiA+ID4gU2VudDogVHVlc2RheSwgTWFyY2ggNSwgMjAxOSA0OjI2IEFNDQo+
ID4gPg0KPiA+ID4gU3VibWl0dGVkIGJ5IEFuZGVycyBSb3hlbGwgYWxyZWFkeQ0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4NCj4g
PiBIb3cgd291bGQgc3VnZ2VzdCB0byBoYW5kbGUgdGhpcyBwYXRjaD8NCj4gPg0KPiA+IEkndmUg
YWxyZWFkeSBnaXZlbiBhbiBBY2sgdG8gQW5kcmVzJyB2MyBwYXRjaCB3aXRoIGEgZmV3IGFkZGl0
aW9uYWwNCj4gPiBjb21tZW50cywgYnV0IHNlZW1zIGRpZCBub3Qgc2VlIGFueSBmb2xsb3cgdXBz
Lg0KPiA+DQo+IA0KPiBTb3JyeSBhYm91dCB0aGF0LCBJIHNlbnQgdGhpcyBvdXQgYXMgcGFydCBv
ZiBhIGxvbmcgc2V0IG9mIGJ1Z2ZpeGVzLCBhbmQgdGhlDQo+IGNvbW1lbnQgaW4gbXkgcGF0Y2gg
d2FzIHN1cHBvc2VkIHRvIHRlbGwgbWUgbm90IHRvIHNlbmQgaXQuIFBsZWFzZSBqdXN0DQo+IGln
bm9yZSBteSBzdWJtaXNzaW9uLCBhbmQgbGV0J3MgZ28gb24gd2l0aCBoaXMgdmVyc2lvbi4NCj4g
DQoNCk5ldmVyIG1pbmQsIGl0IGRvZXMgcmVtaW5kIG1lIHRoYXQgbWlzc2luZyBmaXhlcy4NCkkg
d2lsbCBzZW5kIG91dCB0aGF0IHBhdGNoIGZvciBBbmRyZXMuDQoNClJlZ2FyZHMNCkRvbmcgQWlz
aGVuZw0KDQo+ICAgICAgICBBcm5kDQo=
