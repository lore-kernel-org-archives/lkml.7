Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2032CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EC62075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OrJ9/9m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfDQDN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:13:26 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:2974
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbfDQDN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5raZK1s/iBgUhuGUEDBssuoqdFd21CajsQK3NUOIEhI=;
 b=OrJ9/9m5kw0PWAp9AAV37uVXBnWKekUE91kDkcEd+/RzWn2bh95ws/NM4t91EGW+JHVojqaoyDDeUCV/jI0VyiXwHbUhKXG9IeHPDMsFzUvPlm1yGcBaYTwmwJ1YgHmzSFRpwf17FBWMkJABEjBJs9tXZXlXZqGC34Qm28ijycQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.91.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Wed, 17 Apr 2019 03:13:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 03:13:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
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
Thread-Index: AQHU9ME0meJbs59NTkCxa+Er7M94G6Y/rRyA
Date:   Wed, 17 Apr 2019 03:13:21 +0000
Message-ID: <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dddbf20-a5ae-4f68-8276-08d6c2e2a579
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4290;
x-ms-traffictypediagnostic: AM0PR04MB4290:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4290CEF6D946B763E716A4F180250@AM0PR04MB4290.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(31014005)(51234002)(199004)(11346002)(81166006)(86362001)(8676002)(25786009)(446003)(4326008)(8936002)(14444005)(74316002)(486006)(44832011)(256004)(7416002)(33656002)(186003)(81156014)(105586002)(26005)(305945005)(2201001)(476003)(7736002)(2501003)(3846002)(6116002)(99286004)(9686003)(5660300002)(66066001)(229853002)(71190400001)(6246003)(106356001)(71200400001)(53936002)(68736007)(55016002)(6506007)(52536014)(14454004)(102836004)(97736004)(110136005)(316002)(478600001)(7696005)(6436002)(76176011)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zvBc1Qlk1BrNUzz9xpuEqXyYwNM2berM19kDmw2FBHP+ef1ICOb3kDX4Jg+1OnWEbEh8l+M6bgZvusjyop/wGY8QufV3FWRLwjK4pIZPO9HHiESTA6h5neexrWMH6auwhJKRaJ+Q1m1qQhye6m5Q8Ii5tgEH0peEweW6XXEAAcH6IGRNFgEEKp/2tGtdBA1SxkWqO8EqHGzxGTxaJT89vCFbhqIHZjQUgLJmPIbe1JGwtFS0rnbY0bxwj0F69OOvfg/7zfK3aJf3/5XUNCnUUMrOTD9Nx3ig9yKqDg1669sshYyvy4sOiZrWoZRL3VOGwYVUaFI5RIffaP8pXxDUVwuuJAwZWBNuBhR+QQyFeJ4MCThV5K9gWIJSvqAfdCUCgUcaF8BssIkmLFtS/Lqozf1RqV/AtVAwIDmcLYrZ4Ic=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dddbf20-a5ae-4f68-8276-08d6c2e2a579
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 03:13:21.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE3LCAyMDE5IDEw
OjAwIEFNDQo+IA0KPiBUaGUgd2F5IG9mIGdldHRpbmcgcHJpdmF0ZSBpbXhfaTJjX3N0cnVjdCBp
biBpMmNfaW14X2Nsa19ub3RpZmllcl9jYWxsKCkgaXMNCj4gaW5jb3JyZWN0LCBzaG91bGQgdXNl
IGNsa19jaGFuZ2VfbmIgZWxlbWVudCB0byBnZXQgY29ycmVjdCBhZGRyZXNzIGFuZCBhdm9pZA0K
PiBiZWxvdyBrZXJuZWwgZHVtcCBkdXJpbmcgUE9TVF9SQVRFX0NIQU5HRSBub3RpZnkgYnkgY2xr
DQo+IGZyYW1ld29yazoNCj4gDQo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1
ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyAwM2VmMTQ4OCBwZ2QgPQ0KPiAocHRydmFsKSBbMDNlZjE0
ODhdICpwZ2Q9MDAwMDAwMDAgSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUIFNN
UA0KPiBBUk0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGkuTVg2IFF1YWQvRHVhbExpdGUgKERl
dmljZSBUcmVlKQ0KPiBXb3JrcXVldWU6IGV2ZW50cyByZWR1Y2VfYnVzX2ZyZXFfaGFuZGxlciBQ
QyBpcyBhdA0KPiBpMmNfaW14X3NldF9jbGsrMHgxMC8weGI4IExSIGlzIGF0IGkyY19pbXhfY2xr
X25vdGlmaWVyX2NhbGwrMHgyMC8weDI4DQo+IHBjIDogWzw4MDZhODkzYz5dICAgIGxyIDogWzw4
MDZhOGEwND5dICAgIHBzcjogYTAwODAwMTMNCj4gc3AgOiBiZjM5OWRkOCAgaXAgOiBiZjM0MzJh
YyAgZnAgOiBiZjdjMWRjMA0KPiByMTA6IDAwMDAwMDAyICByOSA6IDAwMDAwMDAwICByOCA6IDAw
MDAwMDAwDQo+IHI3IDogMDNlZjE0ODAgIHI2IDogYmYzOTllNTAgIHI1IDogZmZmZmZmZmYgIHI0
IDogMDAwMDAwMDANCj4gcjMgOiBiZjAyNTMwMCAgcjIgOiBiZjM5OWU1MCAgcjEgOiAwMGI3MWIw
MCAgcjAgOiBiZjM5OWJlOA0KPiBGbGFnczogTnpDdiAgSVJRcyBvbiAgRklRcyBvbiAgTW9kZSBT
VkNfMzIgIElTQSBBUk0gIFNlZ21lbnQgbm9uZQ0KPiBDb250cm9sOiAxMGM1Mzg3ZCAgVGFibGU6
IDRlMDMwMDRhICBEQUM6IDAwMDAwMDUxIFByb2Nlc3Mga3dvcmtlci8yOjENCj4gKHBpZDogMzgs
IHN0YWNrIGxpbWl0ID0gMHgocHRydmFsKSkNCj4gU3RhY2s6ICgweGJmMzk5ZGQ4IHRvIDB4YmYz
OWEwMDApDQo+IDlkYzA6DQo+IDgwNmE4OWU0IDAwMDAwMDAwDQo+IDlkZTA6IGZmZmZmZmZmIGJm
Mzk5ZTUwIDAwMDAwMDAyIDgwNmE4YTA0IDgwNmE4OWU0IDgwMTQyOTAwIGZmZmZmZmZmDQo+IDAw
MDAwMDAwDQo+IDllMDA6IGJmMzRlZjE4IGJmMzRlZjA0IDAwMDAwMDAwIGZmZmZmZmZmIGJmMzk5
ZTUwIDgwMTQyZDg0IDAwMDAwMDAwDQo+IGJmMzk5ZTZjDQo+IDllMjA6IGJmMzRlZjAwIDgwZjIx
NGM0IGJmMDI1MzAwIDAwMDAwMDAyIDgwZjA4ZDA4IGJmMDE3NDgwIDAwMDAwMDAwDQo+IDgwMTQy
ZGYwDQo+IDllNDA6IDAwMDAwMDAwIDgwMTY2ZWQ4IDgwYzI3NjM4IDgwNDVkZTU4IGJmMzUyMzQw
IDAzZWYxNDgwDQo+IDAwYjcxYjAwIDBmODJlMjQyDQo+IDllNjA6IGJmMDI1MzAwIDAwMDAwMDAy
IDAzZWYxNDgwIDgwZjYwZTVjIDAwMDAwMDAxIDgwNDVlZGYwDQo+IDAwMDAwMDAyIDgwNDVlYjA4
DQo+IDllODA6IGJmMDI1MzAwIDAwMDAwMDAyIDAzZWYxNDgwIDgwNDVlZTEwIDAzZWYxNDgwIDgw
NDVlYjA4DQo+IGJmMDFiZTQwIDAwMDAwMDAyDQo+IDllYTA6IDAzZWYxNDgwIDgwNDVlZTEwIDA3
ZGUyOTAwIDgwNDVlYjA4IGJmMDFiNzgwIDAwMDAwMDAyDQo+IDA3ZGUyOTAwIDgwNDVlZTEwDQo+
IDllYzA6IDgwYzI3ODk4IGJmMzk5ZWU0IGJmMDIwYTgwIDAwMDAwMDAyIDFmNzhhNDAwIDgwNDVl
ZTEwIDgwZjYwZTVjDQo+IDgwNDYwNTE0DQo+IDllZTA6IDgwZjYwZTVjIGJmMDFiNjAwIGJmMDFi
NDgwIDgwNDYwNDYwIDBmODJlMjQyIGJmMzgzYTgwIGJmMzgzYTAwDQo+IDgwZjYwZTVjDQo+IDlm
MDA6IDAwMDAwMDAwIGJmN2MxZGMwIDgwZjYwZTcwIDgwNDYwNTY0IDgwZjYwZGYwIDgwZjYwZDI0
IDgwZjYwZGYwDQo+IDgwMTFlNzJjDQo+IDlmMjA6IDAwMDAwMDAwIDgwZjYwZGYwIDgwZjYwZTZj
IGJmN2M0ZjAwIDAwMDAwMDAwIDgwMTFlN2FjIGJmMjc0MDAwDQo+IDgwMTNiZDg0DQo+IDlmNDA6
IGJmN2MxZGQ4IDgwZjAzZDAwIGJmMjc0MDAwIGJmN2MxZGMwIGJmMjc0MDE0IGJmN2MxZGQ4IDgw
ZjAzZDAwDQo+IGJmMzk4MDAwDQo+IDlmNjA6IDAwMDAwMDA4IDgwMTNiZmI0IDAwMDAwMDAwIGJm
MjVkMTAwIGJmMjVkMGMwIDAwMDAwMDAwDQo+IGJmMjc0MDAwIDgwMTNiZjg4DQo+IDlmODA6IGJm
MjVkMTFjIGJmMGNmZWJjIDAwMDAwMDAwIDgwMTQxNDBjIGJmMjVkMGMwIDgwMTQxMmVjIDAwMDAw
MDAwDQo+IDAwMDAwMDAwDQo+IDlmYTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDgwMTAx
MGU4IDAwMDAwMDAwIDAwMDAwMDAwDQo+IDAwMDAwMDAwIDAwMDAwMDAwDQo+IDlmYzA6IDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo+IDAwMDAw
MDAwIDAwMDAwMDAwDQo+IDlmZTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDEzIDAwMDAwMDAwDQo+IDAwMDAwMDAwIDAwMDAwMDAwIFs8ODA2YTg5M2M+XSAoaTJj
X2lteF9zZXRfY2xrKSBmcm9tIFs8ODA2YThhMDQ+XQ0KPiAoaTJjX2lteF9jbGtfbm90aWZpZXJf
Y2FsbCsweDIwLzB4MjgpDQo+IFs8ODA2YThhMDQ+XSAoaTJjX2lteF9jbGtfbm90aWZpZXJfY2Fs
bCkgZnJvbSBbPDgwMTQyOTAwPl0NCj4gKG5vdGlmaWVyX2NhbGxfY2hhaW4rMHg0NC8weDg0KSBb
PDgwMTQyOTAwPl0gKG5vdGlmaWVyX2NhbGxfY2hhaW4pIGZyb20NCj4gWzw4MDE0MmQ4ND5dIChf
X3NyY3Vfbm90aWZpZXJfY2FsbF9jaGFpbisweDQ0LzB4OTgpDQo+IFs8ODAxNDJkODQ+XSAoX19z
cmN1X25vdGlmaWVyX2NhbGxfY2hhaW4pIGZyb20gWzw4MDE0MmRmMD5dDQo+IChzcmN1X25vdGlm
aWVyX2NhbGxfY2hhaW4rMHgxOC8weDIwKQ0KPiBbPDgwMTQyZGYwPl0gKHNyY3Vfbm90aWZpZXJf
Y2FsbF9jaGFpbikgZnJvbSBbPDgwNDVkZTU4Pl0NCj4gKF9fY2xrX25vdGlmeSsweDc4LzB4YTQp
IFs8ODA0NWRlNTg+XSAoX19jbGtfbm90aWZ5KSBmcm9tIFs8ODA0NWVkZjA+XQ0KPiAoX19jbGtf
cmVjYWxjX3JhdGVzKzB4NjAvMHhiNCkgWzw4MDQ1ZWRmMD5dIChfX2Nsa19yZWNhbGNfcmF0ZXMp
IGZyb20NCj4gWzw4MDQ1ZWUxMD5dIChfX2Nsa19yZWNhbGNfcmF0ZXMrMHg4MC8weGI0KQ0KPiBD
b2RlOiBlOTJkNDBmOCBlNTkwMzI5OCBlNTkwNzJhMCBlMTUzMDAwMSAoZTU5NzUwMDgpIC0tLVsg
ZW5kIHRyYWNlDQo+IGZjN2Y1NTE0Yjk3YjZjYmIgXS0tLQ0KPiANCj4gRml4ZXM6IDkwYWQyY2Jl
ODhjMigiaTJjOiBpbXg6IHVzZSBjbGsgbm90aWZpZXIgZm9yIHJhdGUgY2hhbmdlcyIpDQo+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpQbGVhc2Ug
YWxzbyBwcm92aWRlIGhvdyB0byByZXByb2R1Y2UgaXQuDQpBbmQgaXQgc2VlbXMgbm90IGEgbmV3
IGlzc3VlLCBzaG91bGQgd2UgQ0Mgc3RhYmxlPw0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0K
PiAtLS0NCj4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCA0ICsrLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtaW14LmMgaW5kZXgNCj4gYzBjMzA0My4uZmQ3MGIxMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlt
eC5jDQo+IEBAIC01MTUsOSArNTE1LDkgQEAgc3RhdGljIGludCBpMmNfaW14X2Nsa19ub3RpZmll
cl9jYWxsKHN0cnVjdA0KPiBub3RpZmllcl9ibG9jayAqbmIsDQo+ICAJCQkJICAgICB1bnNpZ25l
ZCBsb25nIGFjdGlvbiwgdm9pZCAqZGF0YSkgIHsNCj4gIAlzdHJ1Y3QgY2xrX25vdGlmaWVyX2Rh
dGEgKm5kYXRhID0gZGF0YTsNCj4gLQlzdHJ1Y3QgaW14X2kyY19zdHJ1Y3QgKmkyY19pbXggPSBj
b250YWluZXJfb2YoJm5kYXRhLT5jbGssDQo+ICsJc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNf
aW14ID0gY29udGFpbmVyX29mKG5iLA0KPiAgCQkJCQkJICAgICAgc3RydWN0IGlteF9pMmNfc3Ry
dWN0LA0KPiAtCQkJCQkJICAgICAgY2xrKTsNCj4gKwkJCQkJCSAgICAgIGNsa19jaGFuZ2VfbmIp
Ow0KPiANCj4gIAlpZiAoYWN0aW9uICYgUE9TVF9SQVRFX0NIQU5HRSkNCj4gIAkJaTJjX2lteF9z
ZXRfY2xrKGkyY19pbXgsIG5kYXRhLT5uZXdfcmF0ZSk7DQo+IC0tDQo+IDIuNy40DQoNCg==
