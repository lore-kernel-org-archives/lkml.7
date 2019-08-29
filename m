Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78841C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372732339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hhi5Rbg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfH2Fws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:52:48 -0400
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:51427
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfH2Fwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt8O8PEf8XALWjCOgDupg9yizGxWrFwTTq6jtjcVRuhcn2WRvm8TXExR+aSCS//5+xzqoFyw/GaxS2A5I8QVgpz0RgpDVDdXVqXTDBy1DT922IH4Rib4qiYkEVTnQWppeITu+v7Umf7sVUmnzdEJlmuVD3Hv7bLKAGiKlKfJarvjgZlAecdvymvFpvD3gv64AwNZSqCVXA4mCpnuR1eEDxr53cHn+ATfopwR9pXXi+l129OIrrgY4IiEOfIkKHGyX9UasZWKlqMd+ybVxjGgLrLTWRjLFtcPzpwY+DvxZ+4NBQC3jaC4v+Q0D/mYjz/q1Aso0xamLQFLE/AFiHYS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IxIHnC7humA1Ep3oOSBU2WGb7Ael6ukfqkATRy2gmI=;
 b=Cwk+2zKkCx+9kXOf6IcSbMCGQeT7cvDxWupwkqlJHduC86hQVCFEyAZdVUR4fTQGUn1qAw0BYYKBKLigYM62CsJr8PLWJCTYJPMEtnnZB9Hvp8kKTrLTxBpXe1vw4L4afMb0ivooP9LLNKZxLiHimurLRacBsuSLVsdV514b7CyTzhHUbhUPqnDZrfAZHbtbh9qUWFO+lX58FABH17btfBnpsOX6rGaj6GQu722xhNnApLo1bwiK1gZU4lwihKy5r+nQdUrUPYxUPXwSMo1GyGxwhhl9wPqaL7zO7yZ8zA+Jpxx6InKDd+6W9Dl9jrYG8E10Ebe7U2i/+x7P7Ey+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IxIHnC7humA1Ep3oOSBU2WGb7Ael6ukfqkATRy2gmI=;
 b=Hhi5Rbg0URuEY6hdec3J+Xdh/xWQELAkb2o64PDbLo5WBuCIkhQPNIFgsfC1UpsxNdrT4Zc6AVCUAOH6XCC1suT10NVmKhAOJQYQHaDbdz374donpskO3lEhMr75VXSgdn+SkpQiCcdupDG1wX/FeM0bUZmM25CdgEM7d8bh/nU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3803.eurprd04.prod.outlook.com (52.134.71.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 05:52:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 05:52:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Topic: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Index: AQHU+yZqSSaC+SqMKEqyvy0FwIJdyKZNkJKAgIxln0CAFA6VYIAkYDVg
Date:   Thu, 29 Aug 2019 05:52:38 +0000
Message-ID: <DB3PR0402MB39163A24C4949FD9AD5D2553F5A20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
 <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39165F69F8B684D323C683B1F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F96CD6F3E874204E6972F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F96CD6F3E874204E6972F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1655797-d1f5-4691-a7fb-08d72c451959
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3803;
x-ms-traffictypediagnostic: DB3PR0402MB3803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3803815FB59E7057E6CA064DF5A20@DB3PR0402MB3803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(6116002)(478600001)(26005)(6246003)(66946007)(66556008)(102836004)(64756008)(74316002)(86362001)(99286004)(6436002)(5660300002)(186003)(7696005)(110136005)(66476007)(316002)(76176011)(3846002)(2201001)(4326008)(66446008)(2906002)(53936002)(71200400001)(8676002)(14454004)(6506007)(25786009)(476003)(229853002)(446003)(9686003)(66066001)(11346002)(6636002)(486006)(52536014)(33656002)(44832011)(71190400001)(55016002)(7416002)(7736002)(8936002)(81166006)(76116006)(14444005)(81156014)(256004)(305945005)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3803;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bqHltWoIV5ogCyOpjHeUemLexwqzpls7I6y32HDgEa0HMDAwt2ncpQsR4Keb7Bzb9hwWP1ifMsmXwePEw5sFbbl8Q3nXZHNJAKQtfG8Wi8UtPRfwrHHyNFFYCU5GEL/OkNQ3lXdpTvn7rsjE1fkbiXsL2Z5npQszdlRTg1FotJicYhUFDfGTDznqshCq6mFFzLQOceBuLDHlPz74YQWeR1FrfnI+jqwY8ywdu64PQdbvQalJHq+kzRs0oOakYrabKHmd9la1UZvZzeCju0+T/lqDAt9zuroyith+Y2W7kGM3wyEZwPsxxQzfoJ9tFyPvoaTTju++yZ2I8YEWwNNtP2ly2fCFJDY1CYo0rE2nKEeRVJYn2KLIy9EBLpkzALm3N4lwfdjNLLmcYdsZc8LfxYMYEkmxdK/ij0EopFORT7k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1655797-d1f5-4691-a7fb-08d72c451959
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 05:52:38.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTEQTUV0DWLxY2h1ZsRXF04mClEPKZ+2XWxj2Sf0j3/SaWVTJHQMGT6LyoTP/8iXTR85KBy5SUAtg1KB1i8haw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gY2xrOiBpbXg6IGRpc2Fi
bGUgaS5teDd1bHAgY29tcG9zaXRlIGNsb2NrIGR1cmluZw0KPiBpbml0aWFsaXphdGlvbg0KPiAN
Cj4gSGksIFN0ZXBoZW4NCj4gCUkgdGhpbmsgd2Ugc2hvdWxkIHJlc3VtZSB0aGlzIHRocmVhZCwg
d2l0aG91dCB0aGlzIHBhdGNoLCBtYWlubGluZQ0KPiBrZXJuZWwgYm9vdCB1cCB3aWxsIGNhdXNl
IG1tYyB0aW1lb3V0IGFsbCB0aGUgdGltZS4gSWYgaXQgaXMgTk9UIGdvb2QgdG8NCj4gZGlzYWJs
aW5nIHRob3NlIHBlcmlwaGVyYWwgZGV2aWNlcycgY2xvY2sgaW4gaS5NWDdVTFAncyBjbG9jayBk
cml2ZXIsIHRoZW4gd2UNCj4gaGF2ZSB0byBjaGFuZ2UgdGhlIGNvcmUgZnJhbWV3b3JrIHRvIGRp
c2FibGUgY2xvY2sgZXhwbGljaXRseSBpZiB0aGUNCj4gQ0xLX1NFVF9SQVRFX0dBVEUvQ0xLX1NF
VF9QQVJFTlRfR0FURSBpcyBwcmVzZW50LCBtb3N0IGxpa2VseSBpdCB3aWxsDQo+IGltcGFjdCBv
dGhlciBwbGF0Zm9ybXMgSSB0aGluaywgc28gdGhlIG1vc3Qgc2FmZSB3YXkgaXMganVzdCB0byBk
byBpdCBpbnNpZGUgb3VyDQo+IGkuTVg3VUxQIGNvbXBvc2l0ZSBjbG9jayBkcml2ZXIuIFdoYXQg
ZG8geW91IHRoaW5rPw0KDQpXaGF0IGlzIHlvdXIgb3BpbmlvbiBvbiB0aGlzPw0KDQpUaGFua3Ms
DQpBbnNvbg0KDQo+IA0KPiBUaGFua3MsDQo+IEFuc29uDQo+IA0KPiA+IEhpLCBTdGVwaGVuDQo+
ID4NCj4gPiA+IFF1b3RpbmcgQW5zb24gSHVhbmcgKDIwMTktMDQtMjQgMjI6MTk6MTIpDQo+ID4g
PiA+IGkuTVg3VUxQIHBlcmlwaGVyYWwgY2xvY2sgT05MWSBhbGxvdyBwYXJlbnQvcmF0ZSB0byBi
ZSBjaGFuZ2VkDQo+ID4gPiA+IHdpdGggY2xvY2sgZ2F0ZWQsIGhvd2V2ZXIsIGR1cmluZyBjbG9j
ayB0cmVlIGluaXRpYWxpemF0aW9uLCB0aGUNCj4gPiA+ID4gcGVyaXBoZXJhbCBjbG9jayBjb3Vs
ZCBiZSBlbmFibGVkIGJ5IGJvb3Rsb2FkZXIsIGJ1dCB0aGUgcHJlcGFyZQ0KPiA+ID4gPiBjb3Vu
dCBpbiBjbG9jayB0cmVlIGlzIHN0aWxsIHplcm8sIHNvIGNsb2NrIGNvcmUgZHJpdmVyIHdpbGwg
YWxsb3cNCj4gPiA+ID4gcGFyZW50L3JhdGUgY2hhbmdlZCBldmVuIHdpdGgNCj4gPiBDTEtfU0VU
X1JBVEVfR0FURS9DTEtfU0VUX1BBUkVOVF9HQVRFDQo+ID4gPg0KPiA+ID4gVGhhdCdzIGEgYnVn
LiBDYW4geW91IHNlbmQgYSBwYXRjaCB0byBmaXggdGhlIGNvcmUgZnJhbWV3b3JrIGNvZGUgdG8N
Cj4gPiA+IGZhaWwgYW4gYXNzaWduZWQgcmF0ZSBvciBwYXJlbnQgY2hhbmdlIGlmIHRob3NlIGZs
YWdzIGFyZSBzZXQ/IE9yIGlzDQo+ID4gPiB0aGF0IGJlY2F1c2UgdGhlIGNvcmUgZG9lc24ndCBy
ZXNwZWN0IHRoZXNlIGZsYWdzIHdoZW4gdGhleSdyZQ0KPiA+ID4gYnVyaWVkIGluIHRoZSBtaWRk
bGUgb2YgdGhlIGNsayB0cmVlIGFuZCBzb21lIHJhdGUgb3IgcGFyZW50IGNoYW5nZQ0KPiA+ID4g
Y29tZXMgaW4gYW5kIGFmZmVjdHMgdGhlIG1pZGRsZSBvZiB0aGUgdHJlZSB0aGF0IGhhcyB0aGUg
ZmxhZyBzZXQgb24gaXQ/DQo+ID4NCj4gPiBJZiBjaGFuZ2luZyB0aGUgY29yZSBmcmFtZXdvcmsg
Y29kZSB0byByZXR1cm4gZmFpbCBmb3IgY2xrIHBhcmVudC9yYXRlDQo+ID4gYXNzaWdubWVudCwg
dGhhdCBtZWFucyBjbGsgYXNzaWdubWVudCBpbiBEVCB3aWxsIE5PVCB3b3JrIGZvcg0KPiA+IGku
TVg3VUxQLCB0aGVuIGFsbCB0aGUgY2xrIHJhdGUvcGFyZW50IHNldHRpbmdzIHdpbGwgYmUgZG9u
ZSBpbg0KPiA+IGRyaXZlcj8gVGhhdCB3aWxsIGxlYWQgdG8gbW9yZSBpc3N1ZXMvY2hhbmdlcy4N
Cj4gPg0KPiA+IEl0IGlzIGp1c3QgYmVjYXVzZSBjb3JlIGZyYW1ld29yayBPTkxZIGNoZWNrcyB0
aGUgcHJlcGFyZV9jb3VudCBhbmQNCj4gPiBDTEtfU0VUX1BBUkVOVF9HQVRFIGZsYWcgdG8gZGV0
ZXJtaW5lIGlmIHRoZSBwYXJlbnQgc3dpdGNoIGlzIGFsbG93ZWQsDQo+ID4gaG93ZXZlciwgZHVy
aW5nIGNsb2NrIHRyZWUgaW5pdGlhbGl6YXRpb24sIHRoZSBwcmVwYXJlX2NvdW50IGlzIGFsd2F5
cw0KPiA+IDAgYnV0IHRoZSBIVyBzdGF0dXMgY291bGQgYmUgZW5hYmxlZCBhY3R1YWxseSwgc28g
dGhlIGNvcmUgZnJhbWV3b3JrDQo+ID4gd2lsbCBhbGxvdyB0aGUgcGFyZW50IHN3aXRjaCB3aGls
ZSBIVyBzdGF0dXMgZG9lcyBOT1QgYWxsb3cgdGhlIHBhcmVudA0KPiA+IHN3aXRjaCwgc28gY29y
ZSBmcmFtZXdvcmsgd2lsbCB0cmVhdCB0aGUgcGFyZW50IHN3aXRjaCBzdWNjZXNzZnVsbHkgYnV0
IEhXDQo+IGlzIGFjdHVhbGx5IE5PVC4NCj4gPg0KPiA+IEkgdGhpbmsgd2UgY2FuIHRyZWF0IGl0
IGFzIHBsYXRmb3JtIHNwZWNpZmljIGlzc3VlLCBpZiBib290bG9hZGVyIGNhbg0KPiA+IGd1YXJh
bnRlZSBhbGwgcGVyaXBoZXJhbCBjbG9ja3MgYXJlIGRpc2FibGVkIGJlZm9yZSBqdW1waW5nIHRv
IGtlcm5lbCwNCj4gPiB0aGVuIHRoZXJlIHdpbGwgYmUgbm8gaXNzdWUsIGJ1dCB3ZSBjYW4gTk9U
IGFzc3VtZSB0aGF0LCBzbyBJIGhhdmUgdG8NCj4gPiBmaW5kIHNvbWUgcGxhY2UgaW4gZWFybHkg
a2VybmVsIHBoYXNlIHRvIGRpc2FibGUgdGhvc2UgcGVyaXBoZXJhbCBjbG9ja3MuDQo+ID4NCj4g
PiA+DQo+ID4gPiA+IHNldCwgYnV0IHRoZSBjaGFuZ2Ugd2lsbCBmYWlsIGR1ZSB0byBIVyBOT1Qg
YWxsb3cgcGFyZW50L3JhdGUNCj4gPiA+ID4gY2hhbmdlIHdpdGggY2xvY2sgZW5hYmxlZC4gSXQg
d2lsbCBjYXVzZSBjbG9jayBIVyBzdGF0dXMgbWlzbWF0Y2gNCj4gPiA+ID4gd2l0aCBjbG9jayB0
cmVlIGluZm8gYW5kIGxlYWQgdG8gZnVuY3Rpb24gaXNzdWUuIEJlbG93IGlzIGFuIGV4YW1wbGU6
DQo+ID4gPiA+DQo+ID4gPiA+IHVzZGhjMCdzIHBjYyBjbG9jayB2YWx1ZSBpcyAweEM1MDAwMDAw
IGR1cmluZyBrZXJuZWwgYm9vdCB1cCwgaXQNCj4gPiA+ID4gbWVhbnMNCj4gPiA+ID4gdXNkaGMw
IGNsb2NrIGlzIGVuYWJsZWQsIGl0cyBwYXJlbnQgaXMgQVBMTF9QRkQxLiBJbiBEVCBmaWxlLCB0
aGUNCj4gPiA+ID4gdXNkaGMwIGNsb2NrIHNldHRpbmdzIGFyZSBhcyBiZWxvdzoNCj4gPiA+ID4N
Cj4gPiA+ID4gYXNzaWduZWQtY2xvY2tzID0gPCZwY2MyIElNWDdVTFBfQ0xLX1VTREhDMD47DQo+
ID4gPiA+IGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPQ0KPiA+ID4gPiA8JnNjZzEgSU1YN1VMUF9D
TEtfTklDMV9ESVY+Ow0KPiA+ID4gPg0KPiA+ID4gPiB3aGVuIGtlcm5lbCBib290IHVwLCB0aGUg
Y2xvY2sgdHJlZSBpbmZvIGlzIGFzIGJlbG93LCBidXQgdGhlDQo+ID4gPiA+IHVzZGhjMCBQQ0Mg
cmVnaXN0ZXIgaXMgc3RpbGwgMHhDNTAwMDAwMCwgd2hpY2ggbWVhbnMgaXRzIHBhcmVudCBpcw0K
PiA+ID4gPiBzdGlsbCBmcm9tIEFQTExfUEZEMSwgd2hpY2ggaXMgaW5jb3JyZWN0IGFuZCBjYXVz
ZSB1c2RoYzAgTk9UIHdvcmsuDQo+ID4gPiA+DQo+ID4gPiA+IG5pYzFfY2xrICAgICAgIDIgICAg
ICAgIDIgICAgICAgIDAgICAxNzYwMDAwMDAgICAgICAgICAgMCAgICAgMCAgNTAwMDANCj4gPiA+
ID4gICAgIHVzZGhjMCAgICAgICAwICAgICAgICAwICAgICAgICAwICAgMTc2MDAwMDAwICAgICAg
ICAgIDAgICAgIDAgIDUwMDAwDQo+ID4gPiA+DQo+ID4gPiA+IEFmdGVyIG1ha2luZyBzdXJlIHRo
ZSBwZXJpcGhlcmFsIGNsb2NrIGlzIGRpc2FibGVkIGR1cmluZyBjbG9jaw0KPiA+ID4gPiB0cmVl
IGluaXRpYWxpemF0aW9uLCB0aGUgdXNkaGMwIGlzIHdvcmtpbmcsIGFuZCB0aGlzIGNoYW5nZSBp
cw0KPiA+ID4gPiBuZWNlc3NhcnkgZm9yIGFsbCBpLk1YN1VMUCBwZXJpcGhlcmFsIGNsb2Nrcy4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay1jb21w
b3NpdGUtN3VscC5jIHwgMTMgKysrKysrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAuYw0KPiA+ID4gPiBiL2RyaXZlcnMvY2xrL2lteC9j
bGstY29tcG9zaXRlLTd1bHAuYw0KPiA+ID4gPiBpbmRleCAwNjBmODYwLi4xYTA1NDExIDEwMDY0
NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS03dWxwLmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtN3VscC5jDQo+ID4gPiA+
IEBAIC0zMiw2ICszMiw3IEBAIHN0cnVjdCBjbGtfaHcgKmlteDd1bHBfY2xrX2NvbXBvc2l0ZShj
b25zdCBjaGFyDQo+ID4gPiAqbmFtZSwNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgY2xrX2dhdGUg
KmdhdGUgPSBOVUxMOw0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBjbGtfbXV4ICptdXggPSBOVUxM
Ow0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBjbGtfaHcgKmh3Ow0KPiA+ID4gPiArICAgICAgIHUz
MiB2YWw7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgaWYgKG11eF9wcmVzZW50KSB7DQo+ID4g
PiA+ICAgICAgICAgICAgICAgICBtdXggPSBremFsbG9jKHNpemVvZigqbXV4KSwgR0ZQX0tFUk5F
TCk7IEBAIC03MCw2DQo+ID4gPiA+ICs3MSwxOCBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3dWxwX2Ns
a19jb21wb3NpdGUoY29uc3QgY2hhciAqbmFtZSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdh
dGVfaHcgPSAmZ2F0ZS0+aHc7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBnYXRlLT5yZWcgPSBy
ZWc7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBnYXRlLT5iaXRfaWR4ID0gUENHX0NHQ19TSElG
VDsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
KiBtYWtlIHN1cmUgY2xvY2sgaXMgZ2F0ZWQgZHVyaW5nIGNsb2NrIHRyZWUgaW5pdGlhbGl6YXRp
b24sDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiB0aGUgSFcgT05MWSBhbGxvdyBjbG9jayBw
YXJlbnQvcmF0ZSBjaGFuZ2VkDQo+ID4gPiA+ICsgd2l0aCBjbG9jaw0KPiA+IGdhdGVkLA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICogZHVyaW5nIGNsb2NrIHRyZWUgaW5pdGlhbGl6YXRpb24s
IGNsb2NrcyBjb3VsZCBiZSBlbmFibGVkDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBieSBi
b290bG9hZGVyLCBzbyB0aGUgSFcgc3RhdHVzIHdpbGwgbWlzbWF0Y2ggd2l0aCBjbG9jaw0KPiB0
cmVlDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBwcmVwYXJlIGNvdW50LCB0aGVuIGNsb2Nr
IGNvcmUgZHJpdmVyIHdpbGwgYWxsb3cgcGFyZW50L3JhdGUNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAqIGNoYW5nZSBzaW5jZSB0aGUgcHJlcGFyZSBjb3VudCBpcyB6ZXJvLCBidXQgSFcgYWN0
dWFsbHkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIHByZXZlbnQgdGhlIHBhcmVudC9yYXRl
IGNoYW5nZSBkdWUgdG8gdGhlIGNsb2NrIGlzIGVuYWJsZWQuDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgKi8NCj4gPiA+DQo+ID4gPiBJcyBpdCBPSyB0byBmb3JjaWJseSBnYXRlIHRoZSBjbGsg
bGlrZSB0aGlzIGF0IGluaXQgdGltZT8gSWYgc28sIHdoeQ0KPiA+ID4gY2FuJ3Qgd2UgZm9yY2Ug
dGhlIGNsayBvZmYgd2hlbiB3ZSBjaGFuZ2UgdGhlIHJhdGUgYW5kIHRoZW4gcmVzdG9yZQ0KPiA+
ID4gdGhlIG9uIHN0YXRlIGFmdGVyIGNoYW5naW5nIHRoZSByYXRlPyBUaGF0IHdvdWxkIGJlIG1v
cmUgInJvYnVzdCINCj4gPiA+IHRoYW4gZG9pbmcgaXQgb25jZSBoZXJlLiBQbHVzIHRoZW4gd2Ug
Y291bGQgcmVtb3ZlIHRoZQ0KPiA+ID4gQ0xLX1NFVF9SQVRFX0dBVEUNCj4gPiBmbGFnLg0KPiA+
DQo+ID4gWWVzLCBpdCBpcyBPTkxZIGZvciBjb21wb3NpdGUgY2xvY2tzIHdoaWNoIGFyZSBmb3Ig
cGVyaXBoZXJhbCBjbG9ja3MsDQo+ID4gT05MWSBlYXJseWNvbiBjb3VsZCBiZSBpbXBhY3RlZCBi
dXQgd2UgY2FuIGFkZA0KPiA+IGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2NrcygpIGNhbGwgdG8gbWFr
ZSBlYXJseWNvbiBhbHNvIHdvcmsuDQo+ID4NCj4gPiBGb3JjaW5nIHRoZSBjbGsgb2ZmIGFuZCBy
ZXN0b3JlIHRoZW0gT04gZm9yIHJhdGUvcGFyZW50IGNoYW5nZSB3aWxsDQo+ID4gbmVlZCB0byBj
aGFuZ2UgY29tbW9uIGNvbXBvc2l0ZSBjbG9jayBvcHMsIGN1cnJlbnRseSBpLk1YN1VMUCBhbGwg
dXNlDQo+ID4gY29tbW9uIG9wcywgc28gdW5sZXNzIGkuTVg3VUxQIGltcGxlbWVudHMgY29tcG9z
aXRlIGNsb2NrIG9wcywgYW5kIHRoZQ0KPiA+IGNoYW5nZSB3aWxsIGJlIHZlcnkgc2lnbmlmaWNh
bnQuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQW5zb24NCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocmVnKTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgIHZhbCAmPSB+KDEgPDwgUENHX0NHQ19TSElGVCk7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHJlZyk7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4g
Pg0K
