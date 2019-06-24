Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50684C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41F62089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="JIau2vH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfFXLLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:11:08 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com ([40.107.14.107]:40942
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfFXLLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P51FPziiyHaBfce1MdqBmvEnx+Q/UHK7sx73UwWEQls=;
 b=JIau2vH957J/shtCoZAmM6NMSGJ0aykYvSRuM+/J6vhvcvlU1mCDxLhLLa3mcJUG4dIgeh/SCWc6nguivBQvQF6pvNDzkcwqX7MAdHSeWKHDwg1K+QymJuycJNPoOqYq+45osFAR9XJZwerP/89K9BXqqOb+PDabs69ix0FXkWA=
Received: from VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) by
 VI1PR0502MB3950.eurprd05.prod.outlook.com (52.134.17.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 24 Jun 2019 11:10:23 +0000
Received: from VI1PR0502MB3648.eurprd05.prod.outlook.com
 ([fe80::878:9343:183f:9e91]) by VI1PR0502MB3648.eurprd05.prod.outlook.com
 ([fe80::878:9343:183f:9e91%5]) with mapi id 15.20.1987.014; Mon, 24 Jun 2019
 11:10:23 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVD9h2Jvq9SRrSGEWyDMAz3sEU8KaZboEAgAl9dQCAB+8tAA==
Date:   Mon, 24 Jun 2019 11:10:23 +0000
Message-ID: <67279bb061304ae8a5e97225dfea4be5c079e121.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
        ,<79fa1a0855bfcc1abad348aa047e7a69fffb8225.camel@toradex.com>
         <AM6PR05MB65351FF540C6CD22167A6F90F9E50@AM6PR05MB6535.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB65351FF540C6CD22167A6F90F9E50@AM6PR05MB6535.eurprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9478c6e9-bd1a-43b9-f2e1-08d6f8948db5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3950;
x-ms-traffictypediagnostic: VI1PR0502MB3950:
x-microsoft-antispam-prvs: <VI1PR0502MB395037FB0189733A5F86FDC4FBE00@VI1PR0502MB3950.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(396003)(136003)(366004)(346002)(189003)(199004)(44832011)(86362001)(54906003)(4326008)(66556008)(68736007)(2906002)(25786009)(76176011)(2616005)(476003)(6512007)(53936002)(6436002)(229853002)(6246003)(186003)(446003)(66066001)(316002)(11346002)(486006)(66946007)(305945005)(91956017)(73956011)(36756003)(53546011)(66446008)(118296001)(26005)(6486002)(99286004)(102836004)(76116006)(5660300002)(66476007)(2501003)(81166006)(14444005)(14454004)(71200400001)(8676002)(81156014)(8936002)(6636002)(256004)(6116002)(3846002)(7736002)(478600001)(6506007)(71190400001)(64756008)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3950;H:VI1PR0502MB3648.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NcDpdsYCEF1bB57L4RDjdY6773SkNwRh5eSKgtqgzb9E0lWodw46AFfPnfAFnhCG+/n+NK24D+41gLtHjXh8iXxHBxvD65Yz38nP98YcjewNv7rHXqFmXe572lWzVko2JCofhW+bWy9dnhCoLhf1zpNnTFM3AXg4BSkCthxjLKQoiqYIYSqF9jvqm7FEx7addrLhK93JJx/5yZSsA7F3WgcDDJjQ3bN/84MYf55ImKmf93PgFl0fZDr3enJGIWLSziIiFqMEcSK0zUf4mZf21WCEuQzat4AS+rzhZJ7DgluvSH7czSl/1spEZBgNsZMv7ygluAhtLgmGU63i4xPyPtHGFgzhMdv2E3dCrJ7F9Bk3WB2wgakVyFVayPIyQtWZDwhHQz8ZFd08xviowNefFNj5vAAIJjhZjXEBv92ZYDQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A18CCEB3238F3B41A90027D07E5756F3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9478c6e9-bd1a-43b9-f2e1-08d6f8948db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 11:10:23.3754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTE5IGF0IDEwOjAwICswMDAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90
ZToNCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gRnJv
bTogTWFyY2VsIFppc3dpbGVyDQo+ID4gU2VudDogVGh1cnNkYXksIEp1bmUgMTMsIDIwMTkgMTI6
MDUNCj4gPiBUbzogZmVzdGV2YW1AZ21haWwuY29tOyBPbGVrc2FuZHIgU3V2b3Jvdg0KPiA+IENj
OiBJZ29yIE9wYW5pdWs7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiA+IGFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS82XSBB
U29DOiBzZ3RsNTAwMDogRml4IGRlZmluaXRpb24gb2YgVkFHDQo+ID4gUmFtcCBDb250cm9sDQo+
ID4gDQo+ID4gT24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjM2ICswMzAwLCBPbGVrc2FuZHIgU3V2
b3JvdiB3cm90ZToNCj4gPiA+IFNHVEw1MDAwX1NNQUxMX1BPUCBpcyBhIGJpdCBtYXNrLCBub3Qg
YSB2YWx1ZS4gVXNhZ2Ugb2YNCj4gPiA+IGNvcnJlY3QgZGVmaW5pdGlvbiBtYWtlcyBkZXZpY2Ug
cHJvYmluZyBjb2RlIG1vcmUgY2xlYXIuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE9s
ZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4NCj4gPiANCj4g
PiBSZXZpZXdlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5j
b20+DQo+ID4gDQo+ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gIHNvdW5kL3NvYy9jb2RlY3Mvc2d0
bDUwMDAuYyB8IDIgKy0NCj4gPiA+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmggfCAyICst
DQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+
ID4gPiBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gPiANCj4gPiBJJ20gbm90IHN1cmUg
aG93IGV4YWN0bHkgeW91IGdlbmVyYXRlZCB0aGlzIHBhdGNoIHNldCBidXQgdXN1YWxseQ0KPiA+
IGdpdA0KPiA+IGZvcm1hdC1wYXRjaCBpbnNlcnRzIGFuIGFkZGl0aW9uYWwgZm9sZGVyIGxldmVs
IGNhbGxlZCBhL2Igd2hpY2ggaXMNCj4gPiB3aGF0IGdpdCBhbSBhY2NlcHRzIGJ5IGRlZmF1bHQg
ZS5nLg0KPiANCj4gSSBqdXN0IHVzZWQgcGF0bWFuIHRvIGdlbmVyYXRlIHRoaXMgc2V0IG9mIHBh
dGNoZXMuIEJ1dCBteSAuZ2l0Y29uZmlnDQo+IGluY2x1ZGVkIGRpZmYgb3B0aW9uICJub3ByZWZp
eCIuDQo+IFRoYW5rcyBmb3IgcG9pbnRpbmcgbWUhIEZpeGVkLiBTaG91bGQgSSByZXNlbnQgcmVn
ZW5lcmF0ZWQgcGF0Y2hzZXQNCj4gd2l0aCB0aGUgcHJlZml4Pw0KDQpJIGd1ZXNzIGJ1dCBtb3Jl
IGltcG9ydGFudGx5IGFsc28gbWFrZSBzdXJlIHRvIGFjdHVhbGx5IHNlbmQgdmFsaWQNCmVtYWls
cyBjb25jZXJuaW5nIFNQRi9ES0lNIGNvbmZpZ3VyYXRpb24uDQoNCj4gPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+ID4gYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1
MDAwLmMNCj4gPiANCj4gPiA+IGluZGV4IGE2YTQ3NDhjOTdmOS4uNWU0OTUyM2VlMGI2IDEwMDY0
NA0KPiA+ID4gLS0tIHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiA+ID4gKysrIHNvdW5k
L3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiA+IA0KPiA+IE9mIGNvdXJzZSwgdGhlIHNhbWUgYS9i
IHN0dWZmIGFwcGxpZXMgaGVyZToNCj4gPiANCj4gPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3Nn
dGw1MDAwLmMNCj4gPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gPiANCj4g
PiA+IEBAIC0xMjk2LDcgKzEyOTYsNyBAQCBzdGF0aWMgaW50IHNndGw1MDAwX3Byb2JlKHN0cnVj
dA0KPiA+ID4gc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCj4gPiA+IA0KPiA+ID4gICAg
ICAgLyogZW5hYmxlIHNtYWxsIHBvcCwgaW50cm9kdWNlIDQwMG1zIGRlbGF5IGluIHR1cm5pbmcg
b2ZmDQo+ID4gPiAqLw0KPiA+ID4gICAgICAgc25kX3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMo
Y29tcG9uZW50LA0KPiA+ID4gU0dUTDUwMDBfQ0hJUF9SRUZfQ1RSTCwNCj4gPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNHVEw1MDAwX1NNQUxMX1BPUCwgMSk7DQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTR1RMNTAwMF9TTUFMTF9QT1AsDQo+ID4gPiBTR1RM
NTAwMF9TTUFMTF9QT1ApOw0KPiA+ID4gDQo+ID4gPiAgICAgICAvKiBkaXNhYmxlIHNob3J0IGN1
dCBkZXRlY3RvciAqLw0KPiA+ID4gICAgICAgc25kX3NvY19jb21wb25lbnRfd3JpdGUoY29tcG9u
ZW50LA0KPiA+ID4gU0dUTDUwMDBfQ0hJUF9TSE9SVF9DVFJMLA0KPiA+ID4gMCk7DQo+ID4gPiBk
aWZmIC0tZ2l0IHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuaA0KPiA+ID4gc291bmQvc29jL2Nv
ZGVjcy9zZ3RsNTAwMC5oDQo+ID4gPiBpbmRleCAxOGNhZTA4YmJkM2EuLmE0YmY0YmNhOTViZiAx
MDA2NDQNCj4gPiA+IC0tLSBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmgNCj4gPiA+ICsrKyBz
b3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmgNCj4gPiA+IEBAIC0yNzMsNyArMjczLDcgQEANCj4g
PiA+ICAjZGVmaW5lIFNHVEw1MDAwX0JJQVNfQ1RSTF9NQVNLICAgICAgICAgICAgICAgICAgICAg
IDB4MDAwZQ0KPiA+ID4gICNkZWZpbmUgU0dUTDUwMDBfQklBU19DVFJMX1NISUZUICAgICAgICAg
ICAgIDENCj4gPiA+ICAjZGVmaW5lIFNHVEw1MDAwX0JJQVNfQ1RSTF9XSURUSCAgICAgICAgICAg
ICAzDQo+ID4gPiAtI2RlZmluZSBTR1RMNTAwMF9TTUFMTF9QT1AgICAgICAgICAgICAgICAgICAg
MQ0KPiA+ID4gKyNkZWZpbmUgU0dUTDUwMDBfU01BTExfUE9QICAgICAgICAgICAgICAgICAgIDB4
MDAwMQ0KPiA+ID4gDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBTR1RMNTAwMF9DSElQX01JQ19DVFJM
DQo+ID4gPiAtLQ0KPiA+ID4gMi4yMC4xDQo=
