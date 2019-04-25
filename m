Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984DCC282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFA7217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQcw7bI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfDYGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:51:16 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:48803
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfDYGvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEi1+h0hnkRl10SAZP0I5s7pZVgx2A8EPLUTWKGvmvs=;
 b=WQcw7bI6AG0QvGegif0u97JyJ7WYZW5ORqP/Xfibc6jvn1uoZKuTrNWRNkYj/UPLRl2lzMnExjoN37oY7VUQvg/VWuYIcRMr9iCmHqh+hH3EcHZVv2xXiexbv7Trr1XPKQFjzZFvHpV61++eER0LKW5+By+o3+ZfsHrzz2ryjc4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 06:51:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 06:51:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Thread-Topic: [PATCH 1/2] firmware: imx: SCU irq should ONLY be enabled after
 SCU IPC is ready
Thread-Index: AQHU+wQ3bxGkLXDjYkSt99sp4EdO4aZMI2OAgABLrhA=
Date:   Thu, 25 Apr 2019 06:51:11 +0000
Message-ID: <DB3PR0402MB39163FEF47E9D59FC2D78EB3F53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
 <4a89a37c-fc7b-3248-4cc3-ae232ab310b7@roeck-us.net>
In-Reply-To: <4a89a37c-fc7b-3248-4cc3-ae232ab310b7@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cac9f7b3-127c-4409-8f76-08d6c94a678a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3802;
x-ms-traffictypediagnostic: DB3PR0402MB3802:
x-microsoft-antispam-prvs: <DB3PR0402MB38021027010F75E0EED27799F53D0@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(13464003)(199004)(189003)(64756008)(305945005)(66476007)(66556008)(66446008)(73956011)(5660300002)(14444005)(71190400001)(5024004)(25786009)(6246003)(74316002)(4326008)(256004)(476003)(66066001)(55016002)(229853002)(26005)(76176011)(9686003)(33656002)(44832011)(2906002)(7736002)(186003)(102836004)(52536014)(71200400001)(478600001)(2501003)(53936002)(110136005)(316002)(68736007)(99286004)(53546011)(11346002)(86362001)(97736004)(2201001)(66946007)(6506007)(486006)(14454004)(81166006)(8936002)(81156014)(7696005)(6116002)(8676002)(6436002)(76116006)(3846002)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EWLEWqKzgqID1xGbMcLcJmoH19JI3k3p2CTiclX9IHV9XKdJ/T4uAAD2MOtwLnw2Bnc0B2MTGBv69AKIv415R6C/t+NuCknCKWcyGqfKciPxyCIdNNv+Z7Yf6roKX1DphlgPK6c/oPiZM83wxWXXCPV4GUxPXYej24ECYArt0QT1R5apzgfGWT3Yec2lBRU/lrnREcL6eMa7YeSp0jvoeI2OfuFSquq2QqjNHjH2gkaEe3JKHsZACbsHfHjS93s9KRSu/JxVMMIdzqRmqN6B1GXACm42yVz0opl/4srHrWHqb6FQkL3dM8wKlIpv5rEgqCkOZQg89/Cy6PqcK0IJlXSLle3lfR2mWOfoc4HHEDfgdcDfJs9LROmdVfm/vIQOmedozuseaxnz+2lGwbdK3WgfSCj0v2LDzsT+gOaP6bQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac9f7b3-127c-4409-8f76-08d6c94a678a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 06:51:11.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVu
dGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVy
DQo+IFJvZWNrDQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyNSwgMjAxOSAxMDoxNSBBTQ0KPiBU
bzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3Jn
Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3Rl
dmFtQGdtYWlsLmNvbTsNCj4gd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsgQWlzaGVuZyBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBmaXJtd2FyZTogaW14OiBTQ1UgaXJxIHNob3VsZCBP
TkxZIGJlIGVuYWJsZWQNCj4gYWZ0ZXIgU0NVIElQQyBpcyByZWFkeQ0KPiANCj4gT24gNC8yNC8x
OSA2OjE0IFBNLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBUaGUgaW14X3NjdV9pcnFfZ3JvdXBf
ZW5hYmxlKCkgaXMgbm9ybWFsbHkgY2FsbGVkIGR1cmluZyBtb2R1bGUgZHJpdmVyDQo+ID4gcHJv
YmUgcGhhc2UgdG8gZW5hYmxlIFNDVSBncm91cCBpcnEsIGUuZy4sIGkuTVggc3lzdGVtIGNvbnRy
b2xsZXINCj4gPiB3YXRjaGRvZyBkcml2ZXIgd2lsbCBjYWxsIGl0IGR1cmluZyBpdHMgZHJpdmVy
IHByb2JlIHBoYXNlLCBhcyBpLk1YDQo+ID4gc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cgZHJp
dmVyIGRvZXMgTk9UIG5lZWQgU0NVIElQQyBoYW5kbGUgZm9yDQo+ID4gb3BlcmF0aW9ucywgc28g
aXQgY291bGQgYmUgcHJvYmVkIGJlZm9yZSBpLk1YIFNDVSBJUEMgaXMgcmVhZHksIGFuZA0KPiA+
IGJlbG93IGR1bXAgd2lsbCBzaG93IG91dDoNCj4gPg0KPiA+IFsgICAgMC45MzMwMDFdIEhhcmR3
YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YOFFYUCBNRUsgKERUKQ0KPiA+IFsgICAgMC45MzgxMjld
IHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8pDQo+ID4gWyAgICAwLjk0Mjkw
N10gcGMgOiBpbXhfc2N1X2NhbGxfcnBjKzB4MTE0LzB4MTU4DQo+ID4gWyAgICAwLjk0NzI1MV0g
bHIgOiBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUrMHg3NC8weGM0DQo+ID4gWyAgICAwLjk1MjEx
M10gc3AgOiBmZmZmMDAwMDEwMDViYWUwDQo+ID4gWyAgICAwLjk1NTQxNV0geDI5OiBmZmZmMDAw
MDEwMDViYWUwIHgyODogZmZmZjAwMDAxMTFiYjBhMA0KPiA+IFsgICAgMC45NjA3MTJdIHgyNzog
ZmZmZjAwMDAxMTQwYjAwMCB4MjY6IGZmZmYwMDAwMTExMTA2OGMNCj4gPiBbICAgIDAuOTY2MDEx
XSB4MjU6IGZmZmYwMDAwMTExYmIxMDAgeDI0OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgICAw
Ljk3MTMxMV0geDIzOiBmZmZmMDAwMDExM2Q5Y2Q4IHgyMjogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+
IFsgICAgMC45NzY2MTBdIHgyMTogMDAwMDAwMDAwMDAwMDAwMSB4MjA6IGZmZmY4MDA4M2I1MWE0
MTANCj4gPiBbICAgIDAuOTgxOTA5XSB4MTk6IGZmZmYwMDAwMTEyNTkwMDAgeDE4OiAwMDAwMDAw
MDAwMDAwNDgwDQo+ID4gWyAgICAwLjk4NzIwOV0geDE3OiAwMDAwMDAwMDAwMjNmZmI4IHgxNjog
MDAwMDAwMDAwMDAwMDAxMA0KPiA+IFsgICAgMC45OTI1MDhdIHgxNTogMDAwMDAwMDAwMDAwMDIz
ZiB4MTQ6IGZmZmZmZmZmZmZmZmZmZmYNCj4gPiBbICAgIDAuOTk3ODA3XSB4MTM6IDAwMDAwMDAw
MDAwMDAwMTggeDEyOiAwMDAwMDAwMDAwMDAwMDMwDQo+ID4gWyAgICAxLjAwMzEwN10geDExOiAw
MDAwMDAwMDAwMDAwMDAzIHgxMDogMDEwMTAxMDEwMTAxMDEwMQ0KPiA+IFsgICAgMS4wMDg0MDZd
IHg5IDogZmZmZmZmZmZmZmZmZmZmZiB4OCA6IDdmN2Y3ZjdmN2Y3ZjdmN2YNCj4gPiBbICAgIDEu
MDEzNzA2XSB4NyA6IGZlZmVmZWZmNjQ2YzYwNmQgeDYgOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4g
WyAgICAxLjAxOTAwNV0geDUgOiBmZmZmMDAwMDExMjU5NmM4IHg0IDogMDAwMDAwMDAwMDAwMDAw
OA0KPiA+IFsgICAgMS4wMjQzMDRdIHgzIDogMDAwMDAwMDAwMDAwMDAwMyB4MiA6IDAwMDAwMDAw
MDAwMDAwMDENCj4gPiBbICAgIDEuMDI5NjA0XSB4MSA6IGZmZmYwMDAwMTAwNWJiNTggeDAgOiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgICAxLjAzNDkwNV0gQ2FsbCB0cmFjZToNCj4gPiBbICAg
IDEuMDM3MzQxXSAgaW14X3NjdV9jYWxsX3JwYysweDExNC8weDE1OA0KPiA+IFsgICAgMS4wNDEz
MzRdICBpbXhfc2N1X2lycV9ncm91cF9lbmFibGUrMHg3NC8weGM0DQo+ID4gWyAgICAxLjA0NTg1
Nl0gIGlteF9zY193ZHRfcHJvYmUrMHgyNC8weDE1MA0KPiA+IFsgICAgMS4wNDk3NjZdICBwbGF0
Zm9ybV9kcnZfcHJvYmUrMHg0Yy8weGIwDQo+ID4gWyAgICAxLjA1Mzc2Ml0gIHJlYWxseV9wcm9i
ZSsweDFmOC8weDJjOA0KPiA+IFsgICAgMS4wNTc0MDddICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4
NTgvMHhmYw0KPiA+IFsgICAgMS4wNjE0OTBdICBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDY4LzB4
NzANCj4gPiBbICAgIDEuMDY1NjYwXSAgX19kcml2ZXJfYXR0YWNoKzB4OTQvMHhkYw0KPiA+IFsg
ICAgMS4wNjkzOTddICBidXNfZm9yX2VhY2hfZGV2KzB4NjQvMHhjMA0KPiA+IFsgICAgMS4wNzMy
MjBdICBkcml2ZXJfYXR0YWNoKzB4MjAvMHgyOA0KPiA+IFsgICAgMS4wNzY3ODJdICBidXNfYWRk
X2RyaXZlcisweDE0OC8weDFmYw0KPiA+IFsgICAgMS4wODA2MDFdICBkcml2ZXJfcmVnaXN0ZXIr
MHg2OC8weDEyMA0KPiA+IFsgICAgMS4wODQ0MjRdICBfX3BsYXRmb3JtX2RyaXZlcl9yZWdpc3Rl
cisweDRjLzB4NTQNCj4gPiBbICAgIDEuMDg5MTIwXSAgaW14X3NjX3dkdF9kcml2ZXJfaW5pdCsw
eDE4LzB4MjANCj4gPiBbICAgIDEuMDkzNDYzXSAgZG9fb25lX2luaXRjYWxsKzB4NTgvMHgxYjgN
Cj4gPiBbICAgIDEuMDk3Mjg3XSAga2VybmVsX2luaXRfZnJlZWFibGUrMHgxY2MvMHgyODgNCj4g
PiBbICAgIDEuMTAxNjMwXSAga2VybmVsX2luaXQrMHgxMC8weDEwMA0KPiA+IFsgICAgMS4xMDUx
MDFdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgxOA0KPiA+IFsgICAgMS4xMDg2NjldIC0tLVsgZW5k
IHRyYWNlIDllMDMzMDIxMTQ0NTdkZTkgXS0tLQ0KPiA+IFsgICAgMS4xMTMyOTZdIGVuYWJsZSBp
cnEgZmFpbGVkLCBncm91cCAxLCBtYXNrIDEsIHJldCAtMjINCj4gPg0KPiA+IFRvIGF2b2lkIHN1
Y2ggc2NlbmFyaW8sIHJldHVybiAtRVBST0JFX0RFRkVSIGluDQo+ID4gaW14X3NjdV9pcnFfZ3Jv
dXBfZW5hYmxlKCkgQVBJIGlmIFNDVSBJUEMgaXMgTk9UIHJlYWR5LCB0aGVuIG1vZHVsZQ0KPiA+
IGRyaXZlciB3aGljaCBjYWxscyB0aGlzIEFQSSBpbiBwcm9iZSBwaGFzZSB3aWxsIGRlZmVyIHBy
b2JlIGFmdGVyIFNDVSBJUEMNCj4gcmVhZHkuDQo+ID4NCj4gRGlmZmljdWx0IHRvIGNvbW1lbnQg
LSBJIHNlZW0gdG8gaGF2ZSBtaXNzZWQgdGhlIHBhdGNoIGludHJvZHVjaW5nIHRoZSBjYWxsIHRv
DQo+IGlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZSgpIGZyb20gdGhlIHdhdGNoZG9nIGRyaXZlciwg
YW5kIEkgZG9uJ3Qgc2VlIGl0IGluIC0NCj4gbmV4dCBlaXRoZXIuDQo+IA0KPiBIb3dldmVyLCBh
cyBmYXIgYXMgSSBjYW4gc2VlLCBpbXhfc2NfaXJxX2lwY19oYW5kbGUgaXMgaW5pdGlhbGl6ZWQg
ZnJvbQ0KPiBpbXhfc2N1X3Byb2JlKCkuIElmIHRoZSB3YXRjaGRvZyBkcml2ZXIgZGVwZW5kcyBv
biBpdCwgaXQgc2hvdWxkIGJlIGEgc3ViLQ0KPiBub2RlIG9mIGZzbCxpbXgtc2N1LCBhbmQgYmUg
aW5zdGFudGlhdGVkIGZyb20gdGhlIGNhbGwgdG8NCj4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0
ZSgpIGluIGlteF9zY3VfcHJvYmUoKS4gVGhpcyBzaG91bGQgbWFrZSB0aGUNCj4gRVBST0JFX0RF
RkVSIHVubmVjZXNzYXJ5Lg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHRoZSBhYm92ZSBzdGF0ZW1l
bnQgImkuTVggc3lzdGVtIGNvbnRyb2xsZXIgd2F0Y2hkb2cNCj4gZHJpdmVyIGRvZXMgTk9UIG5l
ZWQgU0NVIElQQyBoYW5kbGUgZm9yIG9wZXJhdGlvbnMiIGlzIG5vIGxvbmdlciBhY2N1cmF0ZS4N
Cj4gSWYgaXQgbmVlZHMgdGhlIGludGVycnVwdCwgYW5kIHRoZSBpbnRlcnJ1cHQgbmVlZHMgdGhl
IElQQyBoYW5kbGUsIHRoZQ0KPiB3YXRjaGRvZyBkcml2ZXIgZG9lcyByZXF1aXJlIHRoZSBJUEMg
aGFuZGxlLiBJdCB3b3VsZCBvdGhlcndpc2Ugbm90IG5lZWQgdG8NCj4gZGVmZXIgaXRzIHByb2Jl
IGZ1bmN0aW9uIHVudGlsIHRoZSBJUEMgaGFuZGxlIGlzIGF2YWlsYWJsZS4NCj4gDQo+IEkgd291
bGQgbGlrZSB0byBhZGQgdGhhdCBpdCBpcyBoaWdobHkgdW51c3VhbCBmb3IgYSB3YXRjaGRvZyBk
cml2ZXIgdG8gZGVwZW5kDQo+IG9uIGEgZmlybXdhcmUgZHJpdmVyLiBIb3dldmVyLCBhZ2Fpbiwg
dGhhdCBpcyBkaWZmaWN1bHQgdG8gYXJndWUgc2luY2UgSSBzZWVtIHRvDQo+IGhhdmUgbWlzc2Vk
IHRoZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNpbmcgdGhhdCBkZXBlbmRlbmN5Lg0KDQpJIGFncmVl
ZCB3YXRjaGRvZyBzaG91bGQgYmUgYSBzdWItbm9kZSBvZiBTQ1UgaWYgaXQgZGVwZW5kcyBPTiBp
dCwgYnV0IGFzIHRoaXMgQVBJIGlzDQpleHBvc2VkLCBJIHRoaW5rIGFkZGluZyBzdWNoIGNoZWNr
IGlzIG5lY2Vzc2FyeSwgd2UgZG8gTk9UIGtub3cgd2hlbiB0aGlzIEFQSSBjb3VsZA0KYmUgY2Fs
bGVkLCBzbyB0aGlzIHByb3RlY3Rpb24gc2hvdWxkIGJlIG5lY2Vzc2FyeSwgaXQgaXMganVzdCBi
ZWNhdXNlIEkgbWV0IHRoaXMgaXNzdWUNCmR1cmluZyBhZGRpbmcgcHJldGltZW91dCBmdW5jdGlv
biBvZiBpLk1YIFNDIHdkb2csIHNvIEkgcHV0IHRoZSBwYXRjaGVzIHRvZ2V0aGVyLg0KDQpUaGFu
a3MsDQpBbnNvbg0KDQo+IA0KPiBHdWVudGVyDQo+IA0KPiA+IEZpeGVzOiA4NTE4MjZjNzU2NmUg
KCJmaXJtd2FyZTogaW14OiBlbmFibGUgaW14IHNjdSBnZW5lcmFsIGlycQ0KPiA+IGZ1bmN0aW9u
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMgfCAzICsr
Kw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gPiBiL2RyaXZlcnMv
ZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gPiBpbmRleCAwNDM4MzNhLi42ODcxMjFmIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQo+ID4gQEAgLTEwMCw2ICsx
MDAsOSBAQCBpbnQgaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3VwLCB1MzIgbWFzaywN
Cj4gdTggZW5hYmxlKQ0KPiA+ICAgCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5o
ZHI7DQo+ID4gICAJaW50IHJldDsNCj4gPg0KPiA+ICsJaWYgKCFpbXhfc2NfaXJxX2lwY19oYW5k
bGUpDQo+ID4gKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+ID4gKw0KPiA+ICAgCWhkci0+dmVy
ID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KPiA+ICAgCWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNf
SVJROw0KPiA+ICAgCWhkci0+ZnVuYyA9IElNWF9TQ19JUlFfRlVOQ19FTkFCTEU7DQo+ID4NCg0K
