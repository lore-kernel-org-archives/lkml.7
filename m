Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF2FC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FF21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Goab1upz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfI3HyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:54:15 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:52802
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfI3HyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B62w/XCtyoSTokWTb51iWJvA5eypCijaBE9M2YrEkXhL+iGFK1bKkgeitkfPF4I22veUdugPIHm1Kad7RsG5PqmoKq770uttXMJg6XdwnuOfltrpslhbYM628dgkdT9Tc7UNNgm5tWPME16ZylGuLQNGzfM74uPezH+I+yuiM9Fgaw4q9ZUPWzEbUPFiAYlj7YhWj8T8GrW4y7SdClsRYuqSzM+2Dlf1k0DkBTZZMelv2WKCy5umQyWCoC7q2wkH3vX15edzM8G5WAWt8h3O2EVku4J8HORBDawYD1vgvEKDmVALkIr/nKA2xhikOsMbpBorWktRlVSEAJ3N1V8LUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVYuVKFrzvKLNSDUd2SSC4SQN2rgKURfC+0IJTWbNlk=;
 b=BUQVIVucBV5HqGBrrlfK4FcnC5ZPZRzT1K7XQ6ywsjL374PRHRMEypb3BRMlral5pfpJz5B20G3McYqlmZaWKZwLFn4ZWe47fmRqOmKOwoLRhD3s2m3sAv8dpDmKtQILOLCIykWOSvyx6Juz09boFz0qgUg6bw5cXBYK7PVZu6Py4kMZmEo2BZfXFZ+/8AmoZy/xz9KEgTdaYRmZvtdB32Z6Ei7NKW3QLSU5LBowkkQhNnwwfNferzq+Q2fN07NOY7PGFLJlCU8qvyqsOiaLUmHmp6PkZk2BQlZ2uDi8uSF/xhcoFmiOfSCnijug6/619R9eG2k7MUs2wFLevDZHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVYuVKFrzvKLNSDUd2SSC4SQN2rgKURfC+0IJTWbNlk=;
 b=Goab1upz/Nm2dP+ML59JrrLv5oP/PF+Cju9BCmgFVhP0I9IGBR/h2QeZY647aOhviEFRjdzaRC87YJrdk/fgXxkNdil2J2DgtbE6C96Oc+cwxBVbBscBzeCoxFkLewWeGtigLVbT3q/HawRbrax7zj4l0nDV7+8g/3AV0EosiqU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 07:54:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 07:54:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqdD3BbwgAAEytA=
Date:   Mon, 30 Sep 2019 07:54:09 +0000
Message-ID: <DB3PR0402MB391609C4C6A928E2E2F987C5F5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB702322F2F020A527AD2F8DDEEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB39169BC7E8DB3525A309034EF5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39169BC7E8DB3525A309034EF5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bbeed7d-a146-4f95-924e-08d7457b6056
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3916:|DB3PR0402MB3916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3916521234E5B368940914EEF5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(5660300002)(7696005)(26005)(486006)(66946007)(52536014)(7736002)(64756008)(66556008)(33656002)(66476007)(476003)(6506007)(99286004)(446003)(76116006)(53546011)(11346002)(305945005)(6246003)(66066001)(76176011)(25786009)(74316002)(102836004)(478600001)(66446008)(86362001)(81156014)(71200400001)(229853002)(71190400001)(55016002)(6116002)(8676002)(256004)(8936002)(4326008)(81166006)(44832011)(186003)(2940100002)(6436002)(110136005)(6636002)(316002)(54906003)(9686003)(14454004)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pp40Oa/D4dqARl5U0sW5/4hwpm6pyD2t2gpcyUJjVywhcRh1Ko41LCobVZdMMeFw8O45Fs8jiPrOZ9aWBul8SCUSf2V1jYSC58fb30TH7Sl11CrGTGGapitzfWIVP8wAmHMQEdN3/6zrlIKAv4HyJDL1z0/q8uRTYIFizvVeqHk0N4+WvrRG/D09MSZb3OUFSqp6u4kj4tP+/jKiH9vzS3jRnCwyzMdu4nopkgHNnneo4nKZeBILysfbiNbu4IVoKHYQrti1MfBFIJA6zkV/g9Rt76RQH3xDNsp9uRmURcNggWEYJhz6cthToXWXRUx9OXF7T4PxjUJ470mYN7K7nPhdFXAFPMr+SM8G3G7zBlz58utLZlkHmsl9xkIAUWXMQNayWjHzrto9uhk2v4PcySyIHISYsUzY+VVdUSoEmsA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbeed7d-a146-4f95-924e-08d7457b6056
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 07:54:09.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3m9b+cxHIHSK3xejFaYcfdvH7ZM8NDcpqnQNgkbZgPIEt/foWwHGUz1ZhZolR9MnuFpTbOblZoLUSJUlp+9dMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiA+IE9uIDIwMTktMDktMjcgNDoyMCBBTSwgQW5zb24gSHVhbmcgd3Jv
dGU6DQo+ID4gPj4gT24gMjAxOS0wOS0yNiAxOjA2IFBNLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+
ID4gPj4+IE9uIDE5LTA5LTI2IDA4OjAzLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+Pj4+PiBP
biAxOS0wOS0yNSAxODowNywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPj4+Pj4+IFRoZSBTQ1Ug
ZmlybXdhcmUgZG9lcyBOT1QgYWx3YXlzIGhhdmUgcmV0dXJuIHZhbHVlIHN0b3JlZCBpbg0KPiA+
ID4+Pj4+PiBtZXNzYWdlIGhlYWRlcidzIGZ1bmN0aW9uIGVsZW1lbnQgZXZlbiB0aGUgQVBJIGhh
cyByZXNwb25zZQ0KPiA+ID4+Pj4+PiBkYXRhLCB0aG9zZSBzcGVjaWFsIEFQSXMgYXJlIGRlZmlu
ZWQgYXMgdm9pZCBmdW5jdGlvbiBpbiBTQ1UNCj4gPiA+Pj4+Pj4gZmlybXdhcmUsIHNvIHRoZXkg
c2hvdWxkIGJlIHRyZWF0ZWQgYXMgcmV0dXJuIHN1Y2Nlc3MgYWx3YXlzLg0KPiA+ID4+Pj4+Pg0K
PiA+ID4+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfc2NfcnBjX21zZyB3aGl0ZWxpc3Rb
XSA9IHsNCj4gPiA+Pj4+Pj4gKwl7IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDLCAuZnVuYyA9
DQo+ID4gPj4+Pj4gSU1YX1NDX01JU0NfRlVOQ19VTklRVUVfSUQgfSwNCj4gPiA+Pj4+Pj4gKwl7
IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDLCAuZnVuYyA9DQo+ID4gPj4+Pj4+ICtJTVhfU0Nf
TUlTQ19GVU5DX0dFVF9CVVRUT05fU1RBVFVTIH0sIH07DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBJ
cyB0aGlzIGdvaW5nIHRvIGJlIGV4dGVuZGVkIGluIHRoZSBuZWFyIGZ1dHVyZT8gSSBzZWUgc29t
ZQ0KPiA+ID4+Pj4+IHVwY29taW5nIHByb2JsZW1zIGhlcmUgaWYgc29tZW9uZSB1c2VzIGEgZGlm
ZmVyZW50DQo+ID4gPj4+Pj4gc2N1LWZ3PC0+a2VybmVsIGNvbWJpbmF0aW9uIGFzIG54cCB3b3Vs
ZCBzdWdnZXN0Lg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IENvdWxkIGJlLCBidXQgSSBjaGVja2VkIHRo
ZSBjdXJyZW50IEFQSXMsIE9OTFkgdGhlc2UgMiB3aWxsIGJlDQo+ID4gPj4+PiB1c2VkIGluIExp
bnV4IGtlcm5lbCwgc28gSSBPTkxZIGFkZCB0aGVzZSAyIEFQSXMgZm9yIG5vdy4NCj4gPiA+Pj4N
Cj4gPiA+Pj4gT2theS4NCj4gPiA+Pj4NCj4gPiA+Pj4+IEhvd2V2ZXIsIGFmdGVyIHJldGhpbmss
IG1heWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBpbXhfc2NfcnBjDQo+ID4gPj4+PiBBUEkgZm9y
IHRob3NlIHNwZWNpYWwgQVBJcz8gVG8gYXZvaWQgY2hlY2tpbmcgaXQgZm9yIGFsbCB0aGUgQVBJ
cw0KPiA+ID4+Pj4gY2FsbGVkIHdoaWNoDQo+ID4gPj4gbWF5IGltcGFjdCBzb21lIHBlcmZvcm1h
bmNlLg0KPiA+ID4+Pj4gU3RpbGwgdW5kZXIgZGlzY3Vzc2lvbiwgaWYgeW91IGhhdmUgYmV0dGVy
IGlkZWEsIHBsZWFzZSBhZHZpc2UsIHRoYW5rcyENCj4gPiA+Pg0KPiA+ID4+IE15IHN1Z2dlc3Rp
b24gaXMgdG8gcmVmYWN0b3IgdGhlIGNvZGUgYW5kIGFkZCBhIG5ldyBBUEkgZm9yIHRoZQ0KPiA+
ID4+IHRoaXMgIm5vIGVycm9yIHZhbHVlIiBjb252ZW50aW9uLiBJbnRlcm5hbGx5IHRoZXkgY2Fu
IGNhbGwgYSBjb21tb24NCj4gPiA+PiBmdW5jdGlvbiB3aXRoIGZsYWdzLg0KPiA+ID4NCj4gPiA+
IElmIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGNvcnJlY3RseSwgdGhhdCBtZWFucyB0aGUgbG9v
cCBjaGVjayBvZg0KPiA+ID4gd2hldGhlciB0aGUgQVBJIGlzIHdpdGggIm5vIGVycm9yIHZhbHVl
IiBmb3IgZXZlcnkgQVBJIHN0aWxsIE5PVCBiZQ0KPiA+ID4gc2tpcHBlZCwgaXQgaXMganVzdCBy
ZWZhY3RvcmluZyB0aGUgY29kZSwgcmlnaHQ/DQo+ID4NCj4gPiBUaGVyZSB3b3VsZCBiZSBubyAi
bG9vcCIgYW55d2hlcmU6IHRoZSByZXNwb25zaWJpbGl0eSB3b3VsZCBmYWxsIG9uDQo+ID4gdGhl
IGNhbGwgdG8gY2FsbCB0aGUgcmlnaHQgUlBDIGZ1bmN0aW9uLiBJbiB0aGUgY3VycmVudCBsYXll
cmluZw0KPiA+IHNjaGVtZSAoZHJpdmVycyAtPiBSUEMgLT4NCj4gPiBtYWlsYm94KSB0aGUgUlBD
IGxheWVyIHRyZWF0cyBhbGwgY2FsbHMgdGhlIHNhbWUgYW5kIGl0J3MgdXAgdGhlIHRoZQ0KPiA+
IGNhbGxlciB0byBwcm92aWRlIGluZm9ybWF0aW9uIGFib3V0IGNhbGxpbmcgY29udmVudGlvbi4N
Cj4gPg0KPiA+IEFuIGV4YW1wbGUgaW1wbGVtZW50YXRpb246DQo+ID4gKiBSZW5hbWUgaW14X3Nj
X3JwY19jYWxsIHRvIF9faW14X3NjX3JwY19jYWxsX2ZsYWdzDQo+ID4gKiBNYWtlIGEgdGlueSBp
bXhfc2NfcnBjX2NhbGwgd3JhcHBlciB3aGljaCBqdXN0IGNvbnZlcnRzIHJlc3Avbm9yZXNwDQo+
ID4gdG8gYSBmbGFnDQo+ID4gKiBNYWtlIGdldCBidXR0b24gc3RhdHVzIGNhbGwgX19pbXhfc2Nf
cnBjX2NhbGxfZmxhZ3Mgd2l0aCB0aGUNCj4gPiBfSU1YX1NDX1JQQ19OT0VSUk9SIGZsYWcNCj4g
Pg0KPiA+IEhvcGUgdGhpcyBtYWtlcyBteSBzdWdnZXN0aW9uIGNsZWFyZXI/IFB1c2hpbmcgdGhp
cyB0byB0aGUgY2FsbGVyIGlzIGENCj4gPiBiaXQgdWdseSBidXQgSSB0aGluayBpdCdzIHdvcnRo
IHByZXNlcnZpbmcgdGhlIGZhY3QgdGhhdCB0aGUgaW14IHJwYw0KPiA+IGNvcmUgdHJlYXRzIHNl
cnZpY2VzIGluIGFuIHVuaWZvcm0gd2F5Lg0KPiANCj4gSXQgaXMgY2xlYXIgbm93LCBzbyBlc3Nl
bnRpYWxseSBpdCBpcyBzYW1lIGFzIDIgc2VwYXJhdGUgQVBJcywgc3RpbGwgbmVlZCB0byBjaGFu
Z2UNCj4gdGhlIGJ1dHRvbiBkcml2ZXIgYW5kIHVpZCBkcml2ZXIgdG8gdXNlIHRoZSBzcGVjaWFs
IGZsYWcsIG1lYW53aGlsZSwgbmVlZCB0bw0KPiBjaGFuZ2UgdGhlIHRoaXJkIHBhcmFtZW50IG9m
IGlteF9zY19ycGNfY2FsbCgpIGZyb20gYm9vbCB0byB1MzIuDQoNCkNvcnJlY3Qgb25lIHRoaW5n
LCBubyBuZWVkIHRvIGNoYW5nZSB0aGUgcGFyYW1ldGVyIG9mIGlteF9zY19ycGNfY2FsbCgpLCBq
dXN0IGFkZA0KYW5vdGhlciBBUEkgdXNpbmcgdGhlIGZsYWcgYXMgcGFyYW1ldGVyLCBhbmQgaW14
X3NjX3JwY19jYWxsKCkgY2FsbHMgdGhlIG5ldyBBUEkuDQoNCkFuc29uIA0KDQo+IA0KPiBJZiBu
byBvbmUgb3Bwb3NlcyB0aGlzIGFwcHJvYWNoLCBJIHdpbGwgcmVkbyB0aGUgcGF0Y2ggdG9nZXRo
ZXIgd2l0aCB0aGUNCj4gYnV0dG9uIGRyaXZlciBhbmQgdWlkIGRyaXZlciBhZnRlciBob2xpZGF5
Lg0KPiANCj4gQW5zb24NCg==
