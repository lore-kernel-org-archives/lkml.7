Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49872C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F023920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZMkZRDwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDQDV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:21:28 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:47340
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbfDQDV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk+WXDdsFxQNoAFAqsGiGHfdRKjMyynb7s+/a6w8NRI=;
 b=ZMkZRDwdF58Wm7wac1U+fJqOtrsgVkNsUl9rttlXjIaRI2OR0/tQKIWXXwZu1Oww+rGHwG/Pl+328VmkrbCbUp14Cz5Iy3mwM8LF6efH8cVyBtJ1yPGg/EQv7BdCZWW8EQ2AH7jrcnlaZ2nZQLmrRH0WaEoErP04veiVDnrCSfs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 03:18:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 03:18:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "eha@deif.com" <eha@deif.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Topic: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Thread-Index: AQHU9ME0meJbs59NTkCxa+Er7M94G6Y/rRyAgAABNzA=
Date:   Wed, 17 Apr 2019 03:18:39 +0000
Message-ID: <DB3PR0402MB39164854EB00BD26E8B70E76F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e51a4f-3aa4-4174-d7c9-08d6c2e36337
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36419D4875B363DEA146DA2FF5250@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(31014005)(13464003)(51234002)(199004)(189003)(68736007)(66066001)(229853002)(446003)(81166006)(99286004)(74316002)(97736004)(305945005)(186003)(106356001)(11346002)(316002)(2906002)(7736002)(8936002)(7696005)(486006)(476003)(81156014)(105586002)(8676002)(52536014)(7416002)(44832011)(26005)(5660300002)(14454004)(53546011)(6246003)(33656002)(6506007)(2201001)(2501003)(86362001)(478600001)(53936002)(6436002)(76176011)(6116002)(102836004)(4326008)(71200400001)(110136005)(256004)(9686003)(14444005)(25786009)(71190400001)(3846002)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V10xlNVcN7CLWS+3ZrKWiQf57lqeDC5AEudeMtN0rdgCW7IuGm2musENdaqy4bbB5MQ42uneYscNgscZ5Hh62EBp6AfCSfZf1/sFt/sx2w69M72z6tgrxuofoMCOuWVxNF4hiBUJOKUkE5nFJ23HlHTWlFG1plbGBg3m1wKLZLi4G7KjM3N34hg9gbIVazKq+HPEAh2JRuxQPc4EuvC2FJ89QIP/GHo/XBkwqW++Lo1sVJ7DhCrslwWnSRLowf8KDM6Js5fID835Qzv62UrmQEq3V2HrEqV1PgmyuCEFz6FgubLQQHvumSAZbhICNEV0qfFzQ/qMtbzwrPVm5gD7WC+JZUem3hXxUrCnMgHlYXOZ/mk4R2V5BUlKAGeqh/NqwQy/f1Bl2yOZ2kT5PXYm2qIlrNEJNqWqguekFzaIoKQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e51a4f-3aa4-4174-d7c9-08d6c2e36337
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 03:18:39.6181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFpc2hlbmcNCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaXNoZW5nIERvbmcNCj4gU2VudDogV2VkbmVzZGF5
LCBBcHJpbCAxNywgMjAxOSAxMToxMyBBTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5n
QG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gd3NhK3JlbmVz
YXNAc2FuZy1lbmdpbmVlcmluZy5jb207IHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZTsN
Cj4gZWhhQGRlaWYuY29tOyBsaW51eEByZW1wZWwtcHJpdmF0LmRlOyBtb2poYUBjb2RlYXVyb3Jh
Lm9yZzsgTGF1cmVudGl1DQo+IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT47IHBlZGFA
YXhlbnRpYS5zZTsgbGludXgtDQo+IGkyY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0hdIGkyYzogaW14OiBjb3JyZWN0IHRoZSBtZXRob2Qgb2YgZ2V0dGluZyBwcml2YXRlIGRh
dGEgaW4NCj4gbm90aWZpZXJfY2FsbA0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+IFNl
bnQ6IFdlZG5lc2RheSwgQXByaWwgMTcsIDIwMTkgMTA6MDAgQU0NCj4gPg0KPiA+IFRoZSB3YXkg
b2YgZ2V0dGluZyBwcml2YXRlIGlteF9pMmNfc3RydWN0IGluDQo+ID4gaTJjX2lteF9jbGtfbm90
aWZpZXJfY2FsbCgpIGlzIGluY29ycmVjdCwgc2hvdWxkIHVzZSBjbGtfY2hhbmdlX25iDQo+ID4g
ZWxlbWVudCB0byBnZXQgY29ycmVjdCBhZGRyZXNzIGFuZCBhdm9pZCBiZWxvdyBrZXJuZWwgZHVt
cCBkdXJpbmcNCj4gPiBQT1NUX1JBVEVfQ0hBTkdFIG5vdGlmeSBieSBjbGsNCj4gPiBmcmFtZXdv
cms6DQo+ID4NCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2
aXJ0dWFsIGFkZHJlc3MgMDNlZjE0ODggcGdkDQo+ID4gPQ0KPiA+IChwdHJ2YWwpIFswM2VmMTQ4
OF0gKnBnZD0wMDAwMDAwMCBJbnRlcm5hbCBlcnJvcjogT29wczogNSBbIzFdIFBSRUVNUFQNCj4g
PiBTTVAgQVJNIEhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YNiBRdWFkL0R1YWxMaXRlIChE
ZXZpY2UgVHJlZSkNCj4gPiBXb3JrcXVldWU6IGV2ZW50cyByZWR1Y2VfYnVzX2ZyZXFfaGFuZGxl
ciBQQyBpcyBhdA0KPiA+IGkyY19pbXhfc2V0X2NsaysweDEwLzB4YjggTFIgaXMgYXQgaTJjX2lt
eF9jbGtfbm90aWZpZXJfY2FsbCsweDIwLzB4MjgNCj4gPiBwYyA6IFs8ODA2YTg5M2M+XSAgICBs
ciA6IFs8ODA2YThhMDQ+XSAgICBwc3I6IGEwMDgwMDEzDQo+ID4gc3AgOiBiZjM5OWRkOCAgaXAg
OiBiZjM0MzJhYyAgZnAgOiBiZjdjMWRjMA0KPiA+IHIxMDogMDAwMDAwMDIgIHI5IDogMDAwMDAw
MDAgIHI4IDogMDAwMDAwMDANCj4gPiByNyA6IDAzZWYxNDgwICByNiA6IGJmMzk5ZTUwICByNSA6
IGZmZmZmZmZmICByNCA6IDAwMDAwMDAwDQo+ID4gcjMgOiBiZjAyNTMwMCAgcjIgOiBiZjM5OWU1
MCAgcjEgOiAwMGI3MWIwMCAgcjAgOiBiZjM5OWJlOA0KPiA+IEZsYWdzOiBOekN2ICBJUlFzIG9u
ICBGSVFzIG9uICBNb2RlIFNWQ18zMiAgSVNBIEFSTSAgU2VnbWVudCBub25lDQo+ID4gQ29udHJv
bDogMTBjNTM4N2QgIFRhYmxlOiA0ZTAzMDA0YSAgREFDOiAwMDAwMDA1MSBQcm9jZXNzIGt3b3Jr
ZXIvMjoxDQo+ID4gKHBpZDogMzgsIHN0YWNrIGxpbWl0ID0gMHgocHRydmFsKSkNCj4gPiBTdGFj
azogKDB4YmYzOTlkZDggdG8gMHhiZjM5YTAwMCkNCj4gPiA5ZGMwOg0KPiA+IDgwNmE4OWU0IDAw
MDAwMDAwDQo+ID4gOWRlMDogZmZmZmZmZmYgYmYzOTllNTAgMDAwMDAwMDIgODA2YThhMDQgODA2
YTg5ZTQgODAxNDI5MDAgZmZmZmZmZmYNCj4gPiAwMDAwMDAwMA0KPiA+IDllMDA6IGJmMzRlZjE4
IGJmMzRlZjA0IDAwMDAwMDAwIGZmZmZmZmZmIGJmMzk5ZTUwIDgwMTQyZDg0IDAwMDAwMDAwDQo+
ID4gYmYzOTllNmMNCj4gPiA5ZTIwOiBiZjM0ZWYwMCA4MGYyMTRjNCBiZjAyNTMwMCAwMDAwMDAw
MiA4MGYwOGQwOCBiZjAxNzQ4MCAwMDAwMDAwMA0KPiA+IDgwMTQyZGYwDQo+ID4gOWU0MDogMDAw
MDAwMDAgODAxNjZlZDggODBjMjc2MzggODA0NWRlNTggYmYzNTIzNDAgMDNlZjE0ODANCj4gPiAw
MGI3MWIwMCAwZjgyZTI0Mg0KPiA+IDllNjA6IGJmMDI1MzAwIDAwMDAwMDAyIDAzZWYxNDgwIDgw
ZjYwZTVjIDAwMDAwMDAxIDgwNDVlZGYwDQo+ID4gMDAwMDAwMDIgODA0NWViMDgNCj4gPiA5ZTgw
OiBiZjAyNTMwMCAwMDAwMDAwMiAwM2VmMTQ4MCA4MDQ1ZWUxMCAwM2VmMTQ4MCA4MDQ1ZWIwOA0K
PiA+IGJmMDFiZTQwIDAwMDAwMDAyDQo+ID4gOWVhMDogMDNlZjE0ODAgODA0NWVlMTAgMDdkZTI5
MDAgODA0NWViMDggYmYwMWI3ODAgMDAwMDAwMDINCj4gPiAwN2RlMjkwMCA4MDQ1ZWUxMA0KPiA+
IDllYzA6IDgwYzI3ODk4IGJmMzk5ZWU0IGJmMDIwYTgwIDAwMDAwMDAyIDFmNzhhNDAwIDgwNDVl
ZTEwIDgwZjYwZTVjDQo+ID4gODA0NjA1MTQNCj4gPiA5ZWUwOiA4MGY2MGU1YyBiZjAxYjYwMCBi
ZjAxYjQ4MCA4MDQ2MDQ2MCAwZjgyZTI0MiBiZjM4M2E4MCBiZjM4M2EwMA0KPiA+IDgwZjYwZTVj
DQo+ID4gOWYwMDogMDAwMDAwMDAgYmY3YzFkYzAgODBmNjBlNzAgODA0NjA1NjQgODBmNjBkZjAg
ODBmNjBkMjQgODBmNjBkZjANCj4gPiA4MDExZTcyYw0KPiA+IDlmMjA6IDAwMDAwMDAwIDgwZjYw
ZGYwIDgwZjYwZTZjIGJmN2M0ZjAwIDAwMDAwMDAwIDgwMTFlN2FjIGJmMjc0MDAwDQo+ID4gODAx
M2JkODQNCj4gPiA5ZjQwOiBiZjdjMWRkOCA4MGYwM2QwMCBiZjI3NDAwMCBiZjdjMWRjMCBiZjI3
NDAxNCBiZjdjMWRkOCA4MGYwM2QwMA0KPiA+IGJmMzk4MDAwDQo+ID4gOWY2MDogMDAwMDAwMDgg
ODAxM2JmYjQgMDAwMDAwMDAgYmYyNWQxMDAgYmYyNWQwYzAgMDAwMDAwMDANCj4gPiBiZjI3NDAw
MCA4MDEzYmY4OA0KPiA+IDlmODA6IGJmMjVkMTFjIGJmMGNmZWJjIDAwMDAwMDAwIDgwMTQxNDBj
IGJmMjVkMGMwIDgwMTQxMmVjIDAwMDAwMDAwDQo+ID4gMDAwMDAwMDANCj4gPiA5ZmEwOiAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCA4MDEwMTBlOCAwMDAwMDAwMCAwMDAwMDAwMA0KPiA+IDAw
MDAwMDAwIDAwMDAwMDAwDQo+ID4gOWZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCj4gPiAwMDAwMDAwMCAwMDAwMDAwMA0KPiA+IDlmZTA6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwDQo+
ID4gMDAwMDAwMDAgMDAwMDAwMDAgWzw4MDZhODkzYz5dIChpMmNfaW14X3NldF9jbGspIGZyb20g
Wzw4MDZhOGEwND5dDQo+ID4gKGkyY19pbXhfY2xrX25vdGlmaWVyX2NhbGwrMHgyMC8weDI4KQ0K
PiA+IFs8ODA2YThhMDQ+XSAoaTJjX2lteF9jbGtfbm90aWZpZXJfY2FsbCkgZnJvbSBbPDgwMTQy
OTAwPl0NCj4gPiAobm90aWZpZXJfY2FsbF9jaGFpbisweDQ0LzB4ODQpIFs8ODAxNDI5MDA+XSAo
bm90aWZpZXJfY2FsbF9jaGFpbikNCj4gPiBmcm9tIFs8ODAxNDJkODQ+XSAoX19zcmN1X25vdGlm
aWVyX2NhbGxfY2hhaW4rMHg0NC8weDk4KQ0KPiA+IFs8ODAxNDJkODQ+XSAoX19zcmN1X25vdGlm
aWVyX2NhbGxfY2hhaW4pIGZyb20gWzw4MDE0MmRmMD5dDQo+ID4gKHNyY3Vfbm90aWZpZXJfY2Fs
bF9jaGFpbisweDE4LzB4MjApDQo+ID4gWzw4MDE0MmRmMD5dIChzcmN1X25vdGlmaWVyX2NhbGxf
Y2hhaW4pIGZyb20gWzw4MDQ1ZGU1OD5dDQo+ID4gKF9fY2xrX25vdGlmeSsweDc4LzB4YTQpIFs8
ODA0NWRlNTg+XSAoX19jbGtfbm90aWZ5KSBmcm9tIFs8ODA0NWVkZjA+XQ0KPiA+IChfX2Nsa19y
ZWNhbGNfcmF0ZXMrMHg2MC8weGI0KSBbPDgwNDVlZGYwPl0gKF9fY2xrX3JlY2FsY19yYXRlcykg
ZnJvbQ0KPiA+IFs8ODA0NWVlMTA+XSAoX19jbGtfcmVjYWxjX3JhdGVzKzB4ODAvMHhiNCkNCj4g
PiBDb2RlOiBlOTJkNDBmOCBlNTkwMzI5OCBlNTkwNzJhMCBlMTUzMDAwMSAoZTU5NzUwMDgpIC0t
LVsgZW5kIHRyYWNlDQo+ID4gZmM3ZjU1MTRiOTdiNmNiYiBdLS0tDQo+ID4NCj4gPiBGaXhlczog
OTBhZDJjYmU4OGMyKCJpMmM6IGlteDogdXNlIGNsayBub3RpZmllciBmb3IgcmF0ZSBjaGFuZ2Vz
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gDQo+IFBsZWFzZSBhbHNvIHByb3ZpZGUgaG93IHRvIHJlcHJvZHVjZSBpdC4NCj4gQW5kIGl0
IHNlZW1zIG5vdCBhIG5ldyBpc3N1ZSwgc2hvdWxkIHdlIENDIHN0YWJsZT8NCg0KVGhpcyBpc3N1
ZSBpcyBOT1QgZWFzeSB0byByZXByb2R1Y2UgdW5sZXNzIGNyZWF0aW5nIGEgZGVkaWNhdGVkIHRl
c3QgY2FzZSwgdXBzdHJlYW0NCmtlcm5lbCBub3JtYWxseSBkb2VzIE5PVCBnbyBpbnRvIHRoaXMg
cGF0aCwgSSBtZXQgdGhpcyBpc3N1ZSBkdXJpbmcgaW50ZXJuYWwgYnVzLWZyZXENCnRlc3QsIGFu
ZCBpdCBzaG91bGQgYmUgYSByZWFsIGlzc3VlLiBDb2RlIHJldmlldyBhbHNvIGNhbiBmaW5kIHRo
aXMgaXNzdWUgSSB0aGluay4NCg0KWWVzLCBpZiBpdCBpcyBpbmRlZWQgYSByZWFsIGlzc3VlLCB3
ZSBzaG91bGQgQ0Mgc3RhYmxlLg0KDQpBbnNvbi4NCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFp
c2hlbmcNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCA0
ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+
ID4gYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jIGluZGV4DQo+ID4gYzBjMzA0My4uZmQ3
MGIxMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlteC5jDQo+ID4g
KysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYw0KPiA+IEBAIC01MTUsOSArNTE1LDkg
QEAgc3RhdGljIGludCBpMmNfaW14X2Nsa19ub3RpZmllcl9jYWxsKHN0cnVjdA0KPiA+IG5vdGlm
aWVyX2Jsb2NrICpuYiwNCj4gPiAgCQkJCSAgICAgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQg
KmRhdGEpICB7DQo+ID4gIAlzdHJ1Y3QgY2xrX25vdGlmaWVyX2RhdGEgKm5kYXRhID0gZGF0YTsN
Cj4gPiAtCXN0cnVjdCBpbXhfaTJjX3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZigmbmRh
dGEtPmNsaywNCj4gPiArCXN0cnVjdCBpbXhfaTJjX3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5l
cl9vZihuYiwNCj4gPiAgCQkJCQkJICAgICAgc3RydWN0IGlteF9pMmNfc3RydWN0LA0KPiA+IC0J
CQkJCQkgICAgICBjbGspOw0KPiA+ICsJCQkJCQkgICAgICBjbGtfY2hhbmdlX25iKTsNCj4gPg0K
PiA+ICAJaWYgKGFjdGlvbiAmIFBPU1RfUkFURV9DSEFOR0UpDQo+ID4gIAkJaTJjX2lteF9zZXRf
Y2xrKGkyY19pbXgsIG5kYXRhLT5uZXdfcmF0ZSk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KDQo=
