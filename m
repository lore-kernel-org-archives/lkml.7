Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129CC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3BF2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZuDgyc3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfILDFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:05:45 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:47898
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfILDFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsleQXr0+y5LrTeNAO3dR17DwC0iJF4vObQ49mthFYutfqH/f4n7MVu8+PyyG/MmR+vezMbzBQscoKGUtYqpcaBrmPNmzusNldn162c1DnvbzqStj3QsGqspAByCH/v39q6AxYtZddYuqiq+coPFRz472tAcgE7sHHkC3UszWOBRyDjrz6wykWs9/dwVxLwU3NE0f76lPGc1PhW3ivVq5LSLYbIF8yGQDG9QOgRE6FnNqExFzFRSN3W3nW2Y9bEsq9cDNg4EU1UaHY1mXuY7CaajPrEzXmzh+Oo8exTq27JZUctDepAc16Wh8cCgyanUs4lD/oEbuZ5z+SaPwd30fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReJAlDDRtsij5AsPyTqjt4ZhZa95sZBco3hFfLI0zVg=;
 b=eTr9CxhfnfHfvYXFAlwZDUvAuxefhoOssp0NK8ty6u0zoJDmpVjq54g1TJZL1svE5IhAtZCbDijNl2bNaf5OCUc5IfwdPn3RpfDrKo1W+qWLAtWqJZjCqpzvOoKSM6GrX0DG+tjq68oPUdiZs3s7ixjxmwForNorQtScI4IHTNjr4RgW16LIy/GD/EHavIlcl/CqKowixRAT1QC+qV+iDhmoMFFo4j8ibuIUseKEmY3QVOihkSxu3l+OER23nKzEIlbBMMZc3cwS3F2aiPRokmSaxtuCQOPu0JeGhQG6346Z+rtz56aOrCKZrQsftJtp43b69asFpgSHIZ5y8fzNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReJAlDDRtsij5AsPyTqjt4ZhZa95sZBco3hFfLI0zVg=;
 b=ZuDgyc3GykeNL5AY8wglI7tT0N7EZNjZt4zyXiEDQ58+a1UNWK2by07BCKJudMwM9HwIaO5It3opx/MFMC6OktJI9zrMPEVXsFCsmtWNZ/g7XMc7fV5elSEZGqVOoQg4RmpjDzeyPtIK/eMDIjg6ep7SkW32to+QvOHT0V8zjho=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5699.eurprd04.prod.outlook.com (20.178.119.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 03:05:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 03:05:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4Vacjj6wAgAJLToCAAM52AIAAH0yAgACplHA=
Date:   Thu, 12 Sep 2019 03:05:39 +0000
Message-ID: <AM0PR04MB4481538B358440C42EC4041B88B00@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <20190909164208.6605054e@donnerap.cambridge.arm.com>
 <CABb+yY2rppSOgqMy+R294d94xwi5UPR55Eo-WB8KA6m11nG3iQ@mail.gmail.com>
 <20190911160308.30878cc3@donnerap.cambridge.arm.com>
 <CABb+yY1oZxvX+mRNmObAHsGoBfN0F4GO+9PSj06EFaF3DsnstA@mail.gmail.com>
In-Reply-To: <CABb+yY1oZxvX+mRNmObAHsGoBfN0F4GO+9PSj06EFaF3DsnstA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 246858d8-beaa-4dff-1cb1-08d7372e17bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5699;
x-ms-traffictypediagnostic: AM0PR04MB5699:|AM0PR04MB5699:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5699A8995DC2B5119A00805588B00@AM0PR04MB5699.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(486006)(26005)(74316002)(186003)(76176011)(305945005)(15650500001)(14454004)(7736002)(54906003)(110136005)(66066001)(102836004)(6506007)(53546011)(7696005)(11346002)(446003)(316002)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(33656002)(478600001)(8936002)(81166006)(81156014)(8676002)(52536014)(2906002)(9686003)(53936002)(6246003)(25786009)(229853002)(6436002)(3846002)(6116002)(71200400001)(71190400001)(86362001)(99286004)(14444005)(44832011)(256004)(4326008)(55016002)(476003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5699;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Vjn6MNrZ9XcinDZBGcNudmPjQNRX1mozj0eMWfRyrr9+5tcZOgXR6IvodtQtClKnl2kkMYrH8hVx8GPAD/xKQ32O43A1roiJBOwZf1+bOyEVigyyVAnTNTJBehDifrYAqcMOS6t61tV18TAKsL7n9/GvXViIvag4OVpjPqU2nKdTHCthKOm+jGJDLui0nOaXFGLuYHsDGbc6OqnMrlFUpKHJde/TXmcHgS0qA58XZbQpFBipPGuqukjgVZSvgztXXom4GxvI0ioe6cme9/DJK+0U5rMM3K+UHlWzhyuaO3b3P/cPayn5Vs3yKjLTRzyrWEPxEv/1iFa0LZIX/Uu/V0aXrr1IbicxDY4szJ48zh0DUkGpnV/st8Ts9NxT0vUPj3Q6q/bZIH3jM7GlF01GiNvnsQi/yIHT+lbax4nlhw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246858d8-beaa-4dff-1cb1-08d7372e17bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 03:05:40.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVC1l9pYHgKuwsLPz0+nT/4fMcaHQ1XoTK3IbtfNBALL0dNxpLktPuKwfWxazPj8GHzBoInDRw2zNP8easEIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMl0gZHQtYmluZGluZ3M6IG1haWxib3g6IGFkZCBi
aW5kaW5nIGRvYyBmb3IgdGhlIEFSTQ0KPiBTTUMvSFZDIG1haWxib3gNCj4gDQo+IE9uIFdlZCwg
U2VwIDExLCAyMDE5IGF0IDEwOjAzIEFNIEFuZHJlIFByenl3YXJhDQo+IDxhbmRyZS5wcnp5d2Fy
YUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgMTAgU2VwIDIwMTkgMjE6NDQ6MTEg
LTA1MDANCj4gPiBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gSGksDQo+ID4NCj4gPiA+IE9uIE1vbiwgU2VwIDksIDIwMTkgYXQgMTA6NDIgQU0g
QW5kcmUgUHJ6eXdhcmENCj4gPGFuZHJlLnByenl3YXJhQGFybS5jb20+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBXZWQsIDI4IEF1ZyAyMDE5IDAzOjAyOjU4ICswMDAwIFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiBbIC4uLiBdDQo+
ID4gPiA+DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgIGFybSxmdW5jLWlkczoNCj4gPiA+ID4g
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ID4gKyAgICAgIEFuIGFycmF5IG9mIDMyLWJp
dCB2YWx1ZXMgc3BlY2lmeWluZyB0aGUgZnVuY3Rpb24gSURzIHVzZWQgYnkNCj4gZWFjaA0KPiA+
ID4gPiA+ICsgICAgICBtYWlsYm94IGNoYW5uZWwuIFRob3NlIGZ1bmN0aW9uIElEcyBmb2xsb3cg
dGhlIEFSTSBTTUMNCj4gY2FsbGluZw0KPiA+ID4gPiA+ICsgICAgICBjb252ZW50aW9uIHN0YW5k
YXJkIFsxXS4NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgIFRoZXJlIGlzIG9uZSBpZGVu
dGlmaWVyIHBlciBjaGFubmVsIGFuZCB0aGUgbnVtYmVyIG9mDQo+IHN1cHBvcnRlZA0KPiA+ID4g
PiA+ICsgICAgICBjaGFubmVscyBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBsZW5ndGggb2YgdGhpcyBh
cnJheS4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayB0aGlzIG1ha2VzIGl0IG9idmlvdXMgdGhh
dCBhcm0sbnVtLWNoYW5zIGlzIG5vdCBuZWVkZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEFsc28gdGhp
cyBzb21ld2hhdCBjb250cmFkaWN0cyB0aGUgZHJpdmVyIGltcGxlbWVudGF0aW9uLCB3aGljaCBh
bGxvd3MNCj4gdGhlIGFycmF5IHRvIGJlIHNob3J0ZXIsIG1hcmtpbmcgdGhpcyBhcyBVSU5UX01B
WCBhbmQgbGF0ZXIgb24gdXNpbmcgdGhlIGZpcnN0DQo+IGRhdGEgaXRlbSBhcyBhIGZ1bmN0aW9u
IGlkZW50aWZpZXIuIFRoaXMgaXMgc29tZXdoYXQgc3VycHJpc2luZyBhbmQgbm90DQo+IGRvY3Vt
ZW50ZWQgKHVubGVzcyBJIG1pc3NlZCBzb21ldGhpbmcpLg0KPiA+ID4gPg0KPiA+ID4gPiBTbyBJ
IHdvdWxkIHN1Z2dlc3Q6DQo+ID4gPiA+IC0gV2UgZHJvcCB0aGUgdHJhbnNwb3J0cyBwcm9wZXJ0
eSwgYW5kIGFsd2F5cyBwdXQgdGhlIGNsaWVudCBwcm92aWRlZA0KPiBkYXRhIGluIHRoZSByZWdp
c3RlcnMsIGFjY29yZGluZyB0byB0aGUgU01DQ0MuIERvY3VtZW50IHRoaXMgaGVyZS4NCj4gPiA+
ID4gICBBIGNsaWVudCBub3QgbmVlZGluZyB0aG9zZSBjb3VsZCBhbHdheXMgcHV0cyB6ZXJvcyAo
b3IgZ2FyYmFnZSkgaW4NCj4gdGhlcmUsIHRoZSByZXNwZWN0aXZlIGZpcm13YXJlIHdvdWxkIGp1
c3QgaWdub3JlIHRoZSByZWdpc3RlcnMuDQo+ID4gPiA+IC0gV2UgZHJvcCAiYXJtLG51bS1jaGFu
cyIsIGFzIHRoaXMgaXMganVzdCByZWR1bmRhbnQgd2l0aCB0aGUgbGVuZ3RoIG9mDQo+IHRoZSBm
dW5jLWlkcyBhcnJheS4NCj4gPiA+ID4gLSBXZSBkb24ndCBpbXBvc2UgYW4gYXJiaXRyYXJ5IGxp
bWl0IG9uIHRoZSBudW1iZXIgb2YgY2hhbm5lbHMuIEZyb20NCj4gdGhlIGZpcm13YXJlIHBvaW50
IG9mIHZpZXcgdGhpcyBpcyBqdXN0IGRpZmZlcmVudCBmdW5jdGlvbiBJRHMsIGZyb20gTGludXgn
IHBvaW50DQo+IG9mIHZpZXcganVzdCB0aGUgc2l6ZSBvZiB0aGUgbWVtb3J5IHVzZWQuIEJvdGgg
ZG9uJ3QgbmVlZCB0byBiZSBsaW1pdGVkDQo+IGFydGlmaWNpYWxseSBJTUhPLg0KPiA+ID4gPg0K
PiA+ID4gU291bmRzIGxpa2Ugd2UgYXJlIGluIHN5bmMuDQo+ID4gPg0KPiA+ID4gPiAtIFdlIG1h
cmsgYXJtLGZ1bmMtaWRzIGFzIHJlcXVpcmVkLCBhcyB0aGlzIG5lZWRzIHRvIGJlIGZpeGVkLCBh
bGxvY2F0ZWQNCj4gbnVtYmVyLg0KPiA+ID4gPg0KPiA+ID4gSSBzdGlsbCB0aGluayBmdW5jLWlk
IGNhbiBiZSBkb25lIHdpdGhvdXQuIEEgY2xpZW50IGNhbiBhbHdheXMgcGFzcw0KPiA+ID4gdGhl
IHZhbHVlIGFzIGl0IGtub3dzIHdoYXQgaXQgZXhwZWN0cy4NCj4gPg0KPiA+IEkgZG9uJ3QgdGhp
bmsgaXQncyB0aGUgcmlnaHQgYWJzdHJhY3Rpb24uIFRoZSBtYWlsYm94ICpjb250cm9sbGVyKiB1
c2VzIGENCj4gc3BlY2lmaWMgZnVuYy1pZCwgdGhpcyBoYXMgdG8gbWF0Y2ggdGhlIG9uZSB0aGUg
ZmlybXdhcmUgZXhwZWN0cy4gU28gdGhpcyBpcyBhDQo+IHByb3BlcnR5IG9mIHRoZSBtYWlsYm94
IHRyYW5zcG9ydCBjaGFubmVsICh0aGUgU01DIGNhbGwpLCBhbmQgdGhlICpjbGllbnQqDQo+IHNo
b3VsZCAqbm90KiBjYXJlIGFib3V0IGl0LiBJdCBqdXN0IHNlZXMgdGhlIGxvZ2ljYWwgY2hhbm5l
bCBJRCAoaWYgd2UgaGF2ZSBvbmUpLA0KPiB3aGljaCB0aGUgY29udHJvbGxlciB0cmFuc2xhdGVz
IGludG8gdGhlIGZ1bmMtSUQuDQo+ID4NCj4gYXJnMCBpcyBzcGVjaWFsIG9ubHkgdG8gdGhlIGNs
aWVudC9wcm90b2NvbCwgb3RoZXJ3aXNlIGl0IGlzIHNpbXBseSB0aGUgZmlyc3QNCj4gYXJndW1l
bnQgZm9yIHRoZSBhcm1fc21jY2Nfc21jICppbnN0cnVjdGlvbiogY29udHJvbGxlci4NCj4gYXJn
WzEsN10gYXJlIGFscmVhZHkgcHJvdmlkZWQgYnkgdGhlIGNsaWVudCwgc28gaXQgaXMgb25seSBu
ZWF0ZXIgaWYNCj4gYXJnMCBpcyBhbHNvIHRha2VuIGZyb20gdGhlIGNsaWVudC4NCj4gDQo+IEJ1
dCBhcyBJIHNhaWQsIEkgYW0gc3RpbGwgb2sgaWYgZnVuYy1pZCBpcyBwYXNzZWQgZnJvbSBkdCBh
bmQgYXJnMCBmcm9tIGNsaWVudCBpcw0KPiBpZ25vcmVkIGJlY2F1c2Ugd2UgaGF2ZSBvbmUgY2hh
bm5lbCBwZXIgY29udHJvbGxlciBkZXNpZ24gYW5kIHdlIGRvbid0IGhhdmUNCj4gdG8gd29ycnkg
YWJvdXQgbnVtYmVyIG9mIGNoYW5uZWxzIHRoZXJlIGNhbiBiZSBkZWRpY2F0ZWQgdG8gc3BlY2lm
aWMNCj4gZnVuY3Rpb25zLg0KDQpPaywgc28gSSdsbCBtYWtlIGl0IGFuIG9wdGlvbmFsIHByb3Bl
cnR5Lg0KDQo+IA0KPiA+IFNvIGl0IHNob3VsZCByZWFsbHkgbG9vayBsaWtlIHRoaXMgKGFzc3Vt
aW5nIG9ubHkgc2luZ2xlIGNoYW5uZWwgY29udHJvbGxlcnMpOg0KPiA+IG1haWxib3g6IHNtYy1t
YWlsYm94IHsNCj4gPiAgICAgI21ib3gtY2VsbHMgPSA8MD47DQo+ID4gICAgIGNvbXBhdGlibGUg
PSAiYXJtLHNtYy1tYm94IjsNCj4gPiAgICAgbWV0aG9kID0gInNtYyI7DQo+ID4NCj4gRG8gd2Ug
d2FudCB0byBkbyBhd2F5IHdpdGggJ21ldGhvZCcgcHJvcGVydHkgYW5kIHVzZSBkaWZmZXJlbnQg
J2NvbXBhdGlibGUnDQo+IHByb3BlcnRpZXMgaW5zdGVhZD8NCj4gIGNvbXBhdGlibGUgPSAiYXJt
LHNtYy1tYm94IjsgICAgIG9yICAgIGNvbXBhdGlibGUgPSAiYXJtLGh2Yy1tYm94IjsNCg0KSSBh
bSBvaywganVzdCBuZWVkIGFkZCBkYXRhIGluIGRyaXZlciB0byBkaWZmZXJlbnRpYXRlIHNtYy9o
dmMuDQpBbmRyZSwgYXJlIHlvdSBvaz8NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gPiAgICAg
YXJtLGZ1bmMtaWQgPSA8MHg4MjAwMDBmZT47DQo+ID4gfTsNCj4gPiBzY21pIHsNCj4gPiAgICAg
Y29tcGF0aWJsZSA9ICJhcm0sc2NtaSI7DQo+ID4gICAgIG1ib3hlcyA9IDwmc21jX21ib3g+Ow0K
PiA+ICAgICBtYm94LW5hbWVzID0gInR4IjsgLyogcnggaXMgb3B0aW9uYWwgKi8NCj4gPiAgICAg
c2htZW0gPSA8JmNwdV9zY3BfaHByaT47DQo+ID4gfTsNCj4gPg0KPiA+IElmIHlvdSBhbGxvdyB0
aGUgY2xpZW50IHRvIHByb3ZpZGUgdGhlIGZ1bmN0aW9uIElEIChhbmQgSSBhbSBub3Qgc2F5aW5n
IHRoaXMgaXMNCj4gYSBnb29kIGlkZWEpOiB3aGVyZSB3b3VsZCB0aGlzIGZ1bmMgSUQgY29tZSBm
cm9tPyBJdCB3b3VsZCBuZWVkIHRvIGJlIGENCj4gcHJvcGVydHkgb2YgdGhlIGNsaWVudCBEVCBu
b2RlLCB0aGVuLiBTbyBvbmUgd2F5IHdvdWxkIGJlIHRvIHVzZSB0aGUgZnVuYyBJRA0KPiBhcyB0
aGUgTGludXggbWFpbGJveCBjaGFubmVsIElEOg0KPiA+IG1haWxib3g6IHNtYy1tYWlsYm94IHsN
Cj4gPiAgICAgI21ib3gtY2VsbHMgPSA8MT47DQo+ID4gICAgIGNvbXBhdGlibGUgPSAiYXJtLHNt
Yy1tYm94IjsNCj4gPiAgICAgbWV0aG9kID0gInNtYyI7DQo+ID4gfTsNCj4gPiBzY21pIHsNCj4g
PiAgICAgY29tcGF0aWJsZSA9ICJhcm0sc2NtaSI7DQo+ID4gICAgIG1ib3hlcyA9IDwmc21jX21i
b3ggMHg4MjAwMDBmZT47DQo+ID4gICAgIG1ib3gtbmFtZXMgPSAidHgiOyAvKiByeCBpcyBvcHRp
b25hbCAqLw0KPiA+ICAgICBzaG1lbSA9IDwmY3B1X3NjcF9ocHJpPjsNCj4gPiB9Ow0KPiA+DQo+
ID4gQnV0IHRoaXMgZG9lc24ndCBsb29rIGRlc2lyYWJsZS4NCj4gPg0KPiA+IEFuZCBhcyBJIG1l
bnRpb25lZCB0aGlzIGJlZm9yZTogYWxsb3dpbmcgc29tZSBtYWlsYm94IGNsaWVudHMgdG8gcHJv
dmlkZQ0KPiB0aGUgZnVuY3Rpb24gSURzIHNvdW5kIHNjYXJ5LCBhcyB0aGV5IGNvdWxkIHVzZSBh
bnl0aGluZyB0aGV5IHdhbnQsIHRyaWdnZXJpbmcNCj4gcmFuZG9tIGZpcm13YXJlIGFjdGlvbnMg
KHRoaW5rIFBTQ0lfQ1BVX09GRikuDQo+ID4NCj4gVGhhdCBwYXJhbm9pYSBpcyB1bndhcnJhbnRl
ZC4gV2UgaGF2ZSB0byBrZWVwIGZhaXRoIGluIGtlcm5lbC1zcGFjZSBjb2RlDQo+IGRvaW5nIHRo
ZSByaWdodCB0aGluZy4NCj4gRWl0aGVyIHRoZSBpbGxlZ2l0aW1hdGUgZnVuY3Rpb24gcmVxdWVz
dCBzaG91bGQgYmUgcmVqZWN0ZWQgYnkgdGhlIGZpcm13YXJlIG9yDQo+IGNsaWVudCBkcml2ZXIg
YmUgY2FsbGVkIGJ1Z2d5Li4uLiBqdXN0IGFzIHdlIHdvdWxkIGNhbGwgYSBibG9jayBkZXZpY2Ug
ZHJpdmVyDQo+IGJ1Z2d5IGlmIGl0IG1lc3NlZCB1cCB0aGUgc2VjdG9yIG51bWJlcnMgaW4gYSB3
cml0ZSByZXF1ZXN0Lg0KPiANCj4gdGhueC4NCg==
