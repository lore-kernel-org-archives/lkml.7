Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6041AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAC62189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sngMBkG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfH1Gu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:50:29 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:35909
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfH1Gu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of05SN/sRxUDNYcZSrrYxQZfSqWMcUGOQ7P6MKrVEXl0Ji/hDYG/qt/6rRKrWzPnyCHaLz2mm8Ln5CzmHK+qfzBM2trXIOrNRAe2UUjMuGy6hBLmJrrMnSpV3TEOczvojDmoA5H6E+vuV8pxkeo4zPJj0Y549/KnlOESKgUmklrUFtckzDpxueCV5NUnvVgiQG+/38gk9Og10/lDhf+7iwt9PRSWEufGBk46btofcfxJWXljRJpGuhJ/Z8E01X5BzBQzO3scdFiGSGei571LXtMN5kP6S4TYeTQYHm+rDj+2JpY3pua7sqgkdyLedPx8SsLvwVn0db78l/STlwikQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1Uv7/FGWlQH8cbpc5YBS81ThPvhtPJdj+BEbQYnIXQ=;
 b=QUiiRzN5/a8zGaZTIyJgJGdZSB7ZtY/Sg/UMHk+pw1D7jPdLzPHpwrjVcGRXUNfz36DhW48+ZtEfvYXUOSDlWKRnoB2UUSWFOtLlLTbKxTXfWodGc2t777EXuSedHd4fWHmvzSTyLe3FouPIr6DukcmiuGd0KLBWlTedkSyqQq7kJhwWFeJZ+j01XxzVlRJIuZwIReK/FgNcmWeTWNWFA2HPLMYO6ME3MUnKtTtlhAFNCbId11XwsR131MDOvPaaMKxUOhzBdsHe50UgCbDpBRucIfxVEJxeFlZFl1DX9U8fA0B56Ek3N935bqCGFaCYu56+v+ic3hoT5GGUqvLItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1Uv7/FGWlQH8cbpc5YBS81ThPvhtPJdj+BEbQYnIXQ=;
 b=sngMBkG21/0gPX4KsIy/LEnT5bi5qXjck/awfo4cJJDNUQWmwFHo8yVixuHzcuuMMd7if0vLTURHnIaCKYxIPxDGSvflLui7GjimfMImuSnfIhpwSl9BIPJPeifIMrn2mcuVT1ElGt0xMOsSCxmLWVxMQl3qyfSrcXdlnl6fL5g=
Received: from DB8PR04MB6715.eurprd04.prod.outlook.com (20.179.251.14) by
 DB8PR04MB6668.eurprd04.prod.outlook.com (20.179.250.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:49:45 +0000
Received: from DB8PR04MB6715.eurprd04.prod.outlook.com
 ([fe80::b0ab:d127:ca27:e1fa]) by DB8PR04MB6715.eurprd04.prod.outlook.com
 ([fe80::b0ab:d127:ca27:e1fa%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:49:45 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>, "marex@denx.de" <marex@denx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 00/15] Improvements and fixes for mxsfb DRM driver
Thread-Topic: [PATCH v3 00/15] Improvements and fixes for mxsfb DRM driver
Thread-Index: AQHVXEMoAkTr3v1KH0a++/RR/KtX+qcQIQYA
Date:   Wed, 28 Aug 2019 06:49:44 +0000
Message-ID: <1566974984.3209.113.camel@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
         <20190826120548.GA14316@bogon.m.sigxcpu.org>
         <3bd35686e046048d35cd4987567a13cf@agner.ch>
         <VI1PR04MB70233374E91F85119FD21FD5EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70233374E91F85119FD21FD5EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15eb695f-652c-4737-9cd1-08d72b83e963
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6668;
x-ms-traffictypediagnostic: DB8PR04MB6668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6668B19FE0218C7AD8E02AB3E3A30@DB8PR04MB6668.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(199004)(189003)(316002)(99286004)(102836004)(66446008)(53936002)(7416002)(6436002)(66556008)(66476007)(26005)(64756008)(305945005)(53546011)(6506007)(110136005)(25786009)(54906003)(81156014)(6512007)(4326008)(50226002)(2616005)(7736002)(6486002)(8676002)(8936002)(446003)(11346002)(229853002)(476003)(486006)(81166006)(6246003)(44832011)(6116002)(2501003)(71190400001)(103116003)(71200400001)(86362001)(6636002)(3846002)(76116006)(478600001)(66946007)(66574012)(76176011)(14454004)(91956017)(256004)(5660300002)(2906002)(36756003)(186003)(66066001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6668;H:DB8PR04MB6715.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 784lAmne7CpXnCW7VaTD1p/rWsWnnEBzkFGfBdzEB6g2efdfOaUYNt3T4egztkjsL2+EP/yLjoIf6/6i1V+Xa0g6O7VDPeoddaAjZdWBnxAYnHMKLledCDFSQGwRb3OBaepde59shGnEIhHj4ycI29NFNyPoNyodTdD5u+8QRPQCsCatXvJ+kRZ7Z6FdX3K2YQMKTwpHi10vEh8D+d3BmkimO0hI9CnYaHSWf03SPqXeEC44KoAoNl23rhX/XevCszMe7/yNgHoGfWi4pnGx7GBd0p68JWRluVw8xNQ6oubnj3mq9ANCLJADxOSqQAUYsi2Rrp05cOBiq+0YBmKCieN1raR7BoEr8cM6b/01/q2Osqg/QArXlos1K/KuGbcxs8ppxBUM9XWRKSYp5sMRN5RfLx60dpceJalwXXr+658=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E488AAC1DAC36A4C8BD7B8F69517A21B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eb695f-652c-4737-9cd1-08d72b83e963
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:49:44.7826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pCqhmEqHG4S9su02BaqcnxmD3gn+99eZRsv7LXbFjJfxvu5iOjvG4yRUG8SIQHka+4LIps78uM2Y9ISLlV9JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvbmFyZCwNCg0KT24gTHUsIDIwMTktMDgtMjYgYXQgMTk6MTkgKzAwMDAsIExlb25hcmQg
Q3Jlc3RleiB3cm90ZToNCj4gT24gMjYuMDguMjAxOSAxNzozNSwgU3RlZmFuIEFnbmVyIHdyb3Rl
Og0KPiA+IA0KPiA+IE9uIDIwMTktMDgtMjYgMTQ6MDUsIEd1aWRvIEfDvG50aGVyIHdyb3RlOg0K
PiA+ID4gDQo+ID4gPiBIaSwNCj4gPiA+IE9uIFdlZCwgQXVnIDIxLCAyMDE5IGF0IDAxOjE1OjQw
UE0gKzAzMDAsIFJvYmVydCBDaGlyYXMgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBh
dGNoLXNldCBpbXByb3ZlcyB0aGUgdXNlIG9mIGVMQ0RJRiBibG9jayBvbiBpTVggOCBTb0NzDQo+
ID4gPiA+IChsaWtlIDhNUSwgOE1NDQo+ID4gPiA+IGFuZCA4UVhQKS4gRm9sbG93aW5nLCBhcmUg
dGhlIG5ldyBmZWF0dXJlcyBhZGRlZCBhbmQgZml4ZXMgZnJvbQ0KPiA+ID4gPiB0aGlzDQo+ID4g
PiA+IHBhdGNoLXNldDoNCj4gPiA+IEkndmUgYXBwbGllZCB0aGlzIHdob2xlIHNlcmllcyBvbiB0
b3Agb2YgbXkgTldMIHdvcmsgYW5kIGl0IGxvb2tzDQo+ID4gPiBnb29kDQo+ID4gPiB3aXRoIGEg
RFNJIHBhbmVsLiBBcHBseWluZyB0aGUgd2hvbGUgc2VyaWVzIGFsc28gZml4ZXMgYW4gaXNzdWUN
Cj4gPiA+IHdoZXJlDQo+ID4gPiBhZnRlciB1bmJsYW5rIHRoZSBvdXRwdXQgd2FzIHNvbWV0aW1l
cyBzaGlmdGVkIGFib3V0IGhhbGYgYQ0KPiA+ID4gc2NyZWVuIHdpZHRoDQo+ID4gPiB0byB0aGUg
cmlnaHQgKHdoaWNoIGRpZG4ndCBoYXBwZW4gd2l0aCBEQ1NTKS4gU28gYXQgbGVhc3QgZnJvbQ0K
PiA+ID4gdGhlIHBhcnRzDQo+ID4gPiBJIGNvdWxkIHRlc3Q6DQo+ID4gPiANCj4gPiA+IMKgwqDC
oFRlc3RlZC1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4NCj4gPiA+IA0KPiA+
ID4gZm9yIHRoZSB3aG9sZSB0aGluZy4NCj4gPiBUaGFua3MgZm9yIHRlc3RpbmchIFdoYXQgU29D
IGRpZCB5b3UgdXNlPyBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QNCj4gPiB0bw0KPiA+IGFsc28g
Z2l2ZSB0aGlzIGEgdHJ5IG9uIGkuTVggNyBvciBpLk1YIDZVTEwgYmVmb3JlIG1lcmdpbmcuDQo+
IEkgZGlkIGEgcXVpY2sgdGVzdCBvbiBpbXg2c3gtc2RiIGFuZCBpdCBzZWVtcyB0aGF0IFtQQVRD
SCAwNy8xNV3CoA0KPiAiZHJtL214c2ZiOiBGaXggdGhlIHZibGFuayBldmVudHMiIGNhdXNlcyBh
IGhhbmcgb24gYm9vdCwgZXZlbg0KPiB3aXRob3V0IGHCoA0KPiBwYW5lbC4NCj4gDQo+IElmIEkg
cmV2ZXJ0IHRoYXQgcGFydGljdWxhciBwYXRjaCBpdCBzZWVtcyB0byBiZSBmaW5lOiB0aGUgbmV3
IHBpeGVswqANCj4gZm9ybWF0cyBzZWVtIHRvIHdvcmsgaW4gbW9kZXRlc3QgKGNoZWNrZWQgd2l0
aCBzaWksNDN3dmYxZyBwYW5lbCkuDQpUaGFua3MgZm9yIGZlZWRiYWNrLiBJIHRlc3RlZCB0aGlz
IGFuZCwgaW5kZWVkIHRoZXJlIGFyZSBpc3N1ZXMgb24gNlNYDQp3aXRoIHRoaXMgcGFydGljdWxh
ciBwYXRjaC4gSXQgc2VlbXMgdGhhdCB0aGVyZSBpcyBhIHJhY2UtY29uZGl0aW9uDQpjYXVzZWQg
YnkgdGhlIHZibGFua19vbiBjYWxsIGluIGVuYWJsZSBhbmQgSVJRIHJvdXRpbmUuIFNpbmNlIHRo
aXMgaXMNCm5vdCBoYXBwZW5pbmcgb24gYW55IG9mIGkuTVg4IFNvQywgSSBzdXNwZWN0IHRoZSBh
eGkgY2xvY2sgdXNhZ2UuDQpJIHRoaW5rIEkgd2lsbCBqdXN0IHJlbW92ZSB0aGlzIHBhdGNoIGZy
b20gdGhlIHBhdGNoLXNldCBhbmQgaGFuZGxlDQp0aGlzIGNhc2Ugc2VwYXJhdGVseS4NCj4gDQo+
IC0tDQo+IFJlZ2FyZHMsDQo+IExlb25hcmQNCg0KUmVnYXJkcywNClJvYmVydA==
