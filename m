Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0755FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B194720652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rBj1b6iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfFRGoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:44:03 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:51415
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfFRGoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wXvJewqrtiDMSHHLbKEOlIfCwnU1chKsuXmAgZsmuE=;
 b=rBj1b6iAiSF5BuHdi6yf8+x2ejfo/ZjPKOXcQUN+Itgyd3GbV3Ivdnwwz8SjJwBWh1k233bhdx8z9MEr+VOOmlV1YpR1NpFPAoMWfx912fuV2/OSH6zf1WbSKf9arLzNFCD8CTTf2k7SuFTtYlOVse2wXrHXRYzj1Gjtf2R5uBs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4664.namprd05.prod.outlook.com (52.135.233.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.10; Tue, 18 Jun 2019 05:59:45 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Tue, 18 Jun 2019
 05:59:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] modules: fix BUG when load module with rodata=n
Thread-Topic: [PATCH] modules: fix BUG when load module with rodata=n
Thread-Index: AQHVJNeLWYilb0LHCEaDvjE+2ICz0Kag7F4A
Date:   Tue, 18 Jun 2019 05:59:44 +0000
Message-ID: <55BF5B29-880D-4489-A93D-E8CEE5C09045@vmware.com>
References: <1560754797-40683-1-git-send-email-yangyingliang@huawei.com>
In-Reply-To: <1560754797-40683-1-git-send-email-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3656d0e5-8488-499a-e01e-08d6f3b229d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4664;
x-ms-traffictypediagnostic: BYAPR05MB4664:
x-microsoft-antispam-prvs: <BYAPR05MB46641190C26F56E7B1EF8237D0EA0@BYAPR05MB4664.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(25786009)(6116002)(3846002)(478600001)(476003)(2616005)(66066001)(486006)(73956011)(76116006)(66946007)(256004)(86362001)(446003)(5660300002)(316002)(14454004)(36756003)(54906003)(11346002)(68736007)(6916009)(33656002)(26005)(229853002)(4326008)(8676002)(81166006)(6486002)(81156014)(2906002)(64756008)(53936002)(66556008)(66476007)(186003)(53546011)(6246003)(76176011)(6506007)(102836004)(6436002)(99286004)(66446008)(8936002)(71200400001)(71190400001)(6512007)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4664;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +cveC6bW25nLf9VIOSRargUu8x1AWEPBHoaC03JaT4u/HxwLNp1Ba5RzupVUp24ak6wUtuNc6627S9qSikCFJhRmEbGC98VsMLl4xD0EUPmWHwVUljSJQ/N23UNBIx1S6rXz+dGzo/DrkHsqAYYBB2MSOsX9NVVwFFoKSdf4R4TTccEfa1CLjgmn8Y2/od0fZFfwaxhwSgpRHPvfX9/ZavL5DnDGyqNQ6zHwjeMHg2Pyurno0tssVUXQV781sqN8ySNm1QZKMvDvX7X9W7ozHikQRjPgfTOZL325hHMZehvNAwvHBaWs7yLa/T1JqN/aKtt7FeJH19jNwtz91Nh1DUB0Orut3rXwOc2i3xu7ERjN02OI+oVki/JT8Rue1vh9TEur7pFjRnAUfzhh/q4uynYEJ78Lvq9WWOzqb5W4yUI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68DC4BAC3245747A0920C87CE325458@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3656d0e5-8488-499a-e01e-08d6f3b229d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:59:44.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTYsIDIwMTksIGF0IDExOjU5IFBNLCBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmds
aWFuZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IFdoZW4gbG9hZGluZyBhIG1vZHVsZSB3aXRo
IHJvZGF0YT1uLCBpdCBjYXVzZXMgYW4gZXhlY3V0aW5nDQo+IE5YLXByb3RlY3RlZCBwYWdlIEJV
Ry4NCj4gDQo+IFsgICAzMi4zNzkxOTFdIGtlcm5lbCB0cmllZCB0byBleGVjdXRlIE5YLXByb3Rl
Y3RlZCBwYWdlIC0gZXhwbG9pdCBhdHRlbXB0PyAodWlkOiAwKQ0KPiBbICAgMzIuMzgyOTE3XSBC
VUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzczogZmZmZmZmZmZjMDAw
NTAwMA0KPiBbICAgMzIuMzg1OTQ3XSAjUEY6IHN1cGVydmlzb3IgaW5zdHJ1Y3Rpb24gZmV0Y2gg
aW4ga2VybmVsIG1vZGUNCj4gWyAgIDMyLjM4NzY2Ml0gI1BGOiBlcnJvcl9jb2RlKDB4MDAxMSkg
LSBwZXJtaXNzaW9ucyB2aW9sYXRpb24NCj4gWyAgIDMyLjM4OTM1Ml0gUEdEIDI0MGMwNjcgUDRE
IDI0MGMwNjcgUFVEIDI0MGUwNjcgUE1EIDQyMWE1MjA2NyBQVEUgODAwMDAwMDQyMWE1MzA2Mw0K
PiBbICAgMzIuMzkxMzk2XSBPb3BzOiAwMDExIFsjMV0gU01QIFBUSQ0KPiBbICAgMzIuMzkyNDc4
XSBDUFU6IDcgUElEOiAyNjk3IENvbW06IGluc21vZCBUYWludGVkOiBHICAgICAgICAgICBPICAg
ICAgNS4yLjAtcmM1KyAjMjAyDQo+IFsgICAzMi4zOTQ1ODhdIEhhcmR3YXJlIG5hbWU6IFFFTVUg
U3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0xLjEyLjEtMC1nYTVj
YWI1OGU5YTNmLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4gWyAgIDMyLjM5ODE1N10g
UklQOiAwMDEwOmtvX3Rlc3RfaW5pdCsweDAvMHgxMDAwIFtrb190ZXN0XQ0KPiBbICAgMzIuMzk5
NjYyXSBDb2RlOiBCYWQgUklQIHZhbHVlLg0KPiBbICAgMzIuNDAwNjIxXSBSU1A6IDAwMTg6ZmZm
ZmM5MDAwMjlmM2NhOCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFsgICAzMi40MDIxNzFdIFJBWDogMDAw
MDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IFsgICAzMi40MDQzMzJdIFJEWDogMDAwMDAwMDAwMDAwMDRjNyBSU0k6IDAwMDAwMDAwMDAw
MDBjYzAgUkRJOiBmZmZmZmZmZmMwMDA1MDAwDQo+IFsgICAzMi40MDYzNDddIFJCUDogZmZmZmZm
ZmZjMDAwNTAwMCBSMDg6IGZmZmY4ODg0MmZiZWJjNDAgUjA5OiBmZmZmZmZmZjgxMGVkZTRhDQo+
IFsgICAzMi40MDgzOTJdIFIxMDogZmZmZmVhMDAxMDhlMzQ4MCBSMTE6IDAwMDAwMDAwMDAwMDAw
MDAgUjEyOiBmZmZmODg4NDJiZWUyMWEwDQo+IFsgICAzMi40MTA0NzJdIFIxMzogMDAwMDAwMDAw
MDAwMDAwMSBSMTQ6IDAwMDAwMDAwMDAwMDAwMDEgUjE1OiBmZmZmYzkwMDAyOWYzZTc4DQo+IFsg
ICAzMi40MTI2MDldIEZTOiAgMDAwMDdmYjRmMGMwYTcwMCgwMDAwKSBHUzpmZmZmODg4NDJmYmMw
MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gWyAgIDMyLjQxNDcyMl0gQ1M6ICAw
MDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbICAgMzIuNDE2
MjkwXSBDUjI6IGZmZmZmZmZmYzAwMDRmZDYgQ1IzOiAwMDAwMDAwNDIxYTkwMDA0IENSNDogMDAw
MDAwMDAwMDAyMGVlMA0KPiBbICAgMzIuNDE4NDcxXSBDYWxsIFRyYWNlOg0KPiBbICAgMzIuNDE5
MTM2XSAgZG9fb25lX2luaXRjYWxsKzB4NDEvMHgxZGYNCj4gWyAgIDMyLjQyMDE5OV0gID8gX2Nv
bmRfcmVzY2hlZCsweDEwLzB4NDANCj4gWyAgIDMyLjQyMTQzM10gID8ga21lbV9jYWNoZV9hbGxv
Y190cmFjZSsweDM2LzB4MTYwDQo+IFsgICAzMi40MjI4MjddICBkb19pbml0X21vZHVsZSsweDU2
LzB4MWY3DQo+IFsgICAzMi40MjM5NDZdICBsb2FkX21vZHVsZSsweDFlNjcvMHgyNTgwDQo+IFsg
ICAzMi40MjQ5NDddICA/IF9fYWxsb2NfcGFnZXNfbm9kZW1hc2srMHgxNTAvMHgyYzANCj4gWyAg
IDMyLjQyNjQxM10gID8gbWFwX3ZtX2FyZWErMHgyZC8weDQwDQo+IFsgICAzMi40Mjc1MzBdICA/
IF9fdm1hbGxvY19ub2RlX3JhbmdlKzB4MWVmLzB4MjYwDQo+IFsgICAzMi40Mjg4NTBdICA/IF9f
ZG9fc3lzX2luaXRfbW9kdWxlKzB4MTM1LzB4MTcwDQo+IFsgICAzMi40MzAwNjBdICA/IF9jb25k
X3Jlc2NoZWQrMHgxMC8weDQwDQo+IFsgICAzMi40MzEyNDldICBfX2RvX3N5c19pbml0X21vZHVs
ZSsweDEzNS8weDE3MA0KPiBbICAgMzIuNDMyNTQ3XSAgZG9fc3lzY2FsbF82NCsweDQzLzB4MTIw
DQo+IFsgICAzMi40MzM4NTNdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8w
eGE5DQo+IA0KPiBCZWNhdXNlIGlmIHJvZGF0YT1uLCBzZXRfbWVtb3J5X3goKSBjYW5uJ3QgYmUg
Y2FsbGVkLCBmaXggdGhpcyBieQ0KPiBjYWxsaW5nIHNldF9tZW1vcnlfeCBpbiBjb21wbGV0ZV9m
b3JtYXRpb24oKTsNCj4gDQo+IEZpeGVzOiBmMmM2NWZiMzIyMWEgKCJ4ODYvbW9kdWxlczogQXZv
aWQgYnJlYWtpbmcgV15YIHdoaWxlIGxvYWRpbmcgbW9kdWxlcyIpDQo+IFN1Z2dlc3RlZC1ieTog
SmlhbiBDaGVuZyA8Y2ouY2hlbmdqaWFuQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlh
bmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiBrZXJuZWwv
bW9kdWxlLmMgfCA5ICsrKysrKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUuYyBiL2tl
cm5lbC9tb2R1bGUuYw0KPiBpbmRleCA4MGM3YzA5NTg0Y2YuLjFhNWQ4Nzk1NzNjMyAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL21vZHVsZS5jDQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUuYw0KPiBAQCAt
MTk0OSwxMiArMTk0OSwxMCBAQCB2b2lkIG1vZHVsZV9lbmFibGVfcm8oY29uc3Qgc3RydWN0IG1v
ZHVsZSAqbW9kLCBib29sIGFmdGVyX2luaXQpDQo+IAlzZXRfdm1fZmx1c2hfcmVzZXRfcGVybXMo
bW9kLT5jb3JlX2xheW91dC5iYXNlKTsNCj4gCXNldF92bV9mbHVzaF9yZXNldF9wZXJtcyhtb2Qt
PmluaXRfbGF5b3V0LmJhc2UpOw0KPiAJZnJvYl90ZXh0KCZtb2QtPmNvcmVfbGF5b3V0LCBzZXRf
bWVtb3J5X3JvKTsNCj4gLQlmcm9iX3RleHQoJm1vZC0+Y29yZV9sYXlvdXQsIHNldF9tZW1vcnlf
eCk7DQo+IA0KPiAJZnJvYl9yb2RhdGEoJm1vZC0+Y29yZV9sYXlvdXQsIHNldF9tZW1vcnlfcm8p
Ow0KPiANCj4gCWZyb2JfdGV4dCgmbW9kLT5pbml0X2xheW91dCwgc2V0X21lbW9yeV9ybyk7DQo+
IC0JZnJvYl90ZXh0KCZtb2QtPmluaXRfbGF5b3V0LCBzZXRfbWVtb3J5X3gpOw0KPiANCj4gCWZy
b2Jfcm9kYXRhKCZtb2QtPmluaXRfbGF5b3V0LCBzZXRfbWVtb3J5X3JvKTsNCj4gDQo+IEBAIC0y
MDE4LDYgKzIwMTYsMTIgQEAgdm9pZCBzZXRfYWxsX21vZHVsZXNfdGV4dF9ybyh2b2lkKQ0KPiBz
dGF0aWMgdm9pZCBtb2R1bGVfZW5hYmxlX254KGNvbnN0IHN0cnVjdCBtb2R1bGUgKm1vZCkgeyB9
DQo+ICNlbmRpZg0KPiANCj4gK3N0YXRpYyB2b2lkIG1vZHVsZV9lbmFibGVfeChjb25zdCBzdHJ1
Y3QgbW9kdWxlICptb2QpDQo+ICt7DQo+ICsJZnJvYl90ZXh0KCZtb2QtPmNvcmVfbGF5b3V0LCBz
ZXRfbWVtb3J5X3gpOw0KPiArCWZyb2JfdGV4dCgmbW9kLT5pbml0X2xheW91dCwgc2V0X21lbW9y
eV94KTsNCj4gK30NCj4gKw0KPiAjaWZkZWYgQ09ORklHX0xJVkVQQVRDSA0KPiAvKg0KPiAgKiBQ
ZXJzaXN0IEVsZiBpbmZvcm1hdGlvbiBhYm91dCBhIG1vZHVsZS4gQ29weSB0aGUgRWxmIGhlYWRl
ciwNCj4gQEAgLTM2MTYsNiArMzYyMCw3IEBAIHN0YXRpYyBpbnQgY29tcGxldGVfZm9ybWF0aW9u
KHN0cnVjdCBtb2R1bGUgKm1vZCwgc3RydWN0IGxvYWRfaW5mbyAqaW5mbykNCj4gDQo+IAltb2R1
bGVfZW5hYmxlX3JvKG1vZCwgZmFsc2UpOw0KPiAJbW9kdWxlX2VuYWJsZV9ueChtb2QpOw0KPiAr
CW1vZHVsZV9lbmFibGVfeChtb2QpOw0KPiANCj4gCS8qIE1hcmsgc3RhdGUgYXMgY29taW5nIHNv
IHN0cm9uZ190cnlfbW9kdWxlX2dldCgpIGlnbm9yZXMgdXMsDQo+IAkgKiBidXQga2FsbHN5bXMg
ZXRjLiBjYW4gc2VlIHVzLiAqLw0KPiAtLSANCj4gMi4xNy4xDQoNCkl0IGRvZXMgc2VlbSB0aGF0
IEkgc2NyZXdlZCB1cCAodGhhbmtzIGZvciBmaXhpbmcgaXQhKS4NCg0KTWFrZXMgbWUgd29uZGVy
IHdoeSBtb2R1bGVfZW5hYmxlX3JvKCkgaXMgbmVlZGVkIHRvIGJlIGNhbGxlZCB0d2ljZQ0KKGV4
Y2x1ZGluZyB0aGUgd3JpdGUtcHJvdGVjdGluZyBvZiB0aGUgY29yZV9sYXlvdXQpLiBJIHdvbmRl
ciBzaW5jZSB0aGlzDQpwYXRjaCB3b3VsZCBlbGltaW5hdGUgc29tZSBjYWxscyB0byBzZXRfbWVt
b3J5X3goKSwgd2hpY2ggaW5kZWVkIGRvIG5vdCBzZWVtDQpuZWNlc3NhcnkuDQoNClNraW1taW5n
IDQ0NGQxM2ZmMTBmYjEgKCJtb2R1bGVzOiBhZGQgcm9fYWZ0ZXJfaW5pdCBzdXBwb3J04oCdKSwg
SSBjb3VsZA0Kbm90IHVuZGVyc3RhbmQgd2h5Lg0KDQpBbnlob3csDQoNClJldmlld2VkLWJ5OiBO
YWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg==
