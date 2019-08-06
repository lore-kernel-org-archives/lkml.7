Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AEEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552B208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKUOjTvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfHFCZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:25:38 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:37188
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731359AbfHFCZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNQ8gw6cFe5tYQkj1kqSAKXBg0vAG3A3k5CUstm6YQbRWnIfR8iTWkawlqCZ6bzAMioP6ONz7jH743pDVqSWnN4guvSRJopjWxIUdD+mfvFcrKIzsDWDD2yrhRbsB88KPdCQ0RvCxaahNH875vAiM6jXkoXd84dwokjI56KYqRd5FAsg+EU0Dn5Qx3YnzHTRfvWAcL3AXSN2aAnduBYyk8SReExjy0CF2LxT6xnFJRMHU8s46EA+18Jb3NujQjgkyBeLSlVACXFR0clPWX5+kd7obuz0ncAWc2RQ3kWzZ1C4/GSLWLVE+nDd9EC98zU2TVpwuGSqhc6urDgvyrj2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ovoz7QUI1zlTeJ/pJJEIZ1FjPcxhUF9Ra7yBoH/3D0=;
 b=ca2ywNs6Z3DzNwWgDIcHS55FLPGw7voHgg7iXvk/+YlR5UCrLeTra0HKkLxAA3jyDFGKunr0B3eiwO8uUnxvyAgWMKOjxUvxKbELe6mjy9KZpfmtjcu+HfkqaloYD/SmGvGGTmouhD1KBF4drrYcOuEPoFRW2/OxG/ivB9ccGzNlOI5znltAKlhN+M4ak0LJ8fi9odNqz7dxQolxeDgup+m+3Wdlq3/oCp6sKkcQSorgFtX5s1enPfQ80q9MSlgqQ47kQFAQOp2dXOP19e32V+5fnXuCt4k0HT9DHc7PiZWpru9JM1UPO7TE8F0MKgree1Gp1524UK1CY/hKTy+hjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ovoz7QUI1zlTeJ/pJJEIZ1FjPcxhUF9Ra7yBoH/3D0=;
 b=aKUOjTvUWThLqll4s1NJ/ewN54jwD36QMG9FMNNAcG7IH4R1LmIqyOntJF3hCE6KocJzfAe5zmSldXJfrC8SuJwRxQnqRVgXxzyJjnwmN5tB+plXXKcVi2vNhmoruV8M8kJGNSAyvTpx57H9768dmPQvszF7RUu1DowT4KQWppY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 02:25:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 02:25:31 +0000
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
Thread-Index: AQHU+yZqSSaC+SqMKEqyvy0FwIJdyKZNkJKAgIxln0CAFA6VYA==
Date:   Tue, 6 Aug 2019 02:25:31 +0000
Message-ID: <DB3PR0402MB3916F96CD6F3E874204E6972F5D50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
 <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39165F69F8B684D323C683B1F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39165F69F8B684D323C683B1F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a9c91f0-807a-4b42-41a9-08d71a155ae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3881;
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-antispam-prvs: <DB3PR0402MB38818E7C6F5880FC7706AE62F5D50@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(66446008)(71200400001)(71190400001)(186003)(52536014)(76116006)(74316002)(76176011)(6506007)(6436002)(55016002)(2501003)(7696005)(86362001)(66066001)(7416002)(26005)(6636002)(9686003)(53936002)(14454004)(81156014)(33656002)(110136005)(4326008)(8676002)(316002)(68736007)(102836004)(81166006)(5660300002)(44832011)(476003)(11346002)(446003)(486006)(2201001)(14444005)(6246003)(66556008)(64756008)(99286004)(256004)(6116002)(478600001)(229853002)(66476007)(7736002)(305945005)(3846002)(8936002)(66946007)(2906002)(25786009)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gt9oyl9Fza2dkQw6RCsTth94RSCYbsBHFiAJ3clKvlS87Pgg6muRJbtLKR7exWMgjlBLD1A9rtgHa/c0gMbGcTQ4BJoZxNY7AVxx7lQ8LJRqqXBF5wyUbaT/KC37uXZOmH07CZk1rxM/FIIt3e4dz5n9za5qR4a66eSuVV69NArM7Iv9QpmP47Hhbuu8c6CQ5/IP4nS/4H2pBuGIAtZtmBQNXjIFRMvXQDDRdjzn+I4QEx+SwiZ1lGgrKD1GzvQCD9x6KZb+L9Nw0Bnf4gkpZgIKpj1O/kwn3aFtvgZvKvvjvcT1C5TIR2i0Qeuc84wpILmyMjPSaBthDqG9TcDnW/Dd0rZytDMn9DPNWACZ5hJIVEyreWVbkaGXEWsUK+up8dzy4ugYRCL6vmWlGk5rcjLBrm9JnXA8G0lu40FUhfc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9c91f0-807a-4b42-41a9-08d71a155ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 02:25:31.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCglJIHRoaW5rIHdlIHNob3VsZCByZXN1bWUgdGhpcyB0aHJlYWQsIHdpdGhv
dXQgdGhpcyBwYXRjaCwgbWFpbmxpbmUga2VybmVsIGJvb3QgdXAgd2lsbCBjYXVzZSBtbWMgdGlt
ZW91dCBhbGwgdGhlIHRpbWUuIElmIGl0IGlzIE5PVCBnb29kIHRvIGRpc2FibGluZyB0aG9zZSBw
ZXJpcGhlcmFsIGRldmljZXMnIGNsb2NrIGluIGkuTVg3VUxQJ3MgY2xvY2sgZHJpdmVyLCB0aGVu
IHdlIGhhdmUgdG8gY2hhbmdlIHRoZSBjb3JlIGZyYW1ld29yayB0byBkaXNhYmxlIGNsb2NrIGV4
cGxpY2l0bHkgaWYgdGhlIENMS19TRVRfUkFURV9HQVRFL0NMS19TRVRfUEFSRU5UX0dBVEUgaXMg
cHJlc2VudCwgbW9zdCBsaWtlbHkgaXQgd2lsbCBpbXBhY3Qgb3RoZXIgcGxhdGZvcm1zIEkgdGhp
bmssIHNvIHRoZSBtb3N0IHNhZmUgd2F5IGlzIGp1c3QgdG8gZG8gaXQgaW5zaWRlIG91ciBpLk1Y
N1VMUCBjb21wb3NpdGUgY2xvY2sgZHJpdmVyLiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KVGhhbmtz
LA0KQW5zb24NCg0KPiBIaSwgU3RlcGhlbg0KPiANCj4gPiBRdW90aW5nIEFuc29uIEh1YW5nICgy
MDE5LTA0LTI0IDIyOjE5OjEyKQ0KPiA+ID4gaS5NWDdVTFAgcGVyaXBoZXJhbCBjbG9jayBPTkxZ
IGFsbG93IHBhcmVudC9yYXRlIHRvIGJlIGNoYW5nZWQgd2l0aA0KPiA+ID4gY2xvY2sgZ2F0ZWQs
IGhvd2V2ZXIsIGR1cmluZyBjbG9jayB0cmVlIGluaXRpYWxpemF0aW9uLCB0aGUNCj4gPiA+IHBl
cmlwaGVyYWwgY2xvY2sgY291bGQgYmUgZW5hYmxlZCBieSBib290bG9hZGVyLCBidXQgdGhlIHBy
ZXBhcmUNCj4gPiA+IGNvdW50IGluIGNsb2NrIHRyZWUgaXMgc3RpbGwgemVybywgc28gY2xvY2sg
Y29yZSBkcml2ZXIgd2lsbCBhbGxvdw0KPiA+ID4gcGFyZW50L3JhdGUgY2hhbmdlZCBldmVuIHdp
dGgNCj4gQ0xLX1NFVF9SQVRFX0dBVEUvQ0xLX1NFVF9QQVJFTlRfR0FURQ0KPiA+DQo+ID4gVGhh
dCdzIGEgYnVnLiBDYW4geW91IHNlbmQgYSBwYXRjaCB0byBmaXggdGhlIGNvcmUgZnJhbWV3b3Jr
IGNvZGUgdG8NCj4gPiBmYWlsIGFuIGFzc2lnbmVkIHJhdGUgb3IgcGFyZW50IGNoYW5nZSBpZiB0
aG9zZSBmbGFncyBhcmUgc2V0PyBPciBpcw0KPiA+IHRoYXQgYmVjYXVzZSB0aGUgY29yZSBkb2Vz
bid0IHJlc3BlY3QgdGhlc2UgZmxhZ3Mgd2hlbiB0aGV5J3JlIGJ1cmllZA0KPiA+IGluIHRoZSBt
aWRkbGUgb2YgdGhlIGNsayB0cmVlIGFuZCBzb21lIHJhdGUgb3IgcGFyZW50IGNoYW5nZSBjb21l
cyBpbg0KPiA+IGFuZCBhZmZlY3RzIHRoZSBtaWRkbGUgb2YgdGhlIHRyZWUgdGhhdCBoYXMgdGhl
IGZsYWcgc2V0IG9uIGl0Pw0KPiANCj4gSWYgY2hhbmdpbmcgdGhlIGNvcmUgZnJhbWV3b3JrIGNv
ZGUgdG8gcmV0dXJuIGZhaWwgZm9yIGNsayBwYXJlbnQvcmF0ZQ0KPiBhc3NpZ25tZW50LCB0aGF0
IG1lYW5zIGNsayBhc3NpZ25tZW50IGluIERUIHdpbGwgTk9UIHdvcmsgZm9yIGkuTVg3VUxQLA0K
PiB0aGVuIGFsbCB0aGUgY2xrIHJhdGUvcGFyZW50IHNldHRpbmdzIHdpbGwgYmUgZG9uZSBpbiBk
cml2ZXI/IFRoYXQgd2lsbCBsZWFkIHRvDQo+IG1vcmUgaXNzdWVzL2NoYW5nZXMuDQo+IA0KPiBJ
dCBpcyBqdXN0IGJlY2F1c2UgY29yZSBmcmFtZXdvcmsgT05MWSBjaGVja3MgdGhlIHByZXBhcmVf
Y291bnQgYW5kDQo+IENMS19TRVRfUEFSRU5UX0dBVEUgZmxhZyB0byBkZXRlcm1pbmUgaWYgdGhl
IHBhcmVudCBzd2l0Y2ggaXMgYWxsb3dlZCwNCj4gaG93ZXZlciwgZHVyaW5nIGNsb2NrIHRyZWUg
aW5pdGlhbGl6YXRpb24sIHRoZSBwcmVwYXJlX2NvdW50IGlzIGFsd2F5cyAwIGJ1dA0KPiB0aGUg
SFcgc3RhdHVzIGNvdWxkIGJlIGVuYWJsZWQgYWN0dWFsbHksIHNvIHRoZSBjb3JlIGZyYW1ld29y
ayB3aWxsIGFsbG93DQo+IHRoZSBwYXJlbnQgc3dpdGNoIHdoaWxlIEhXIHN0YXR1cyBkb2VzIE5P
VCBhbGxvdyB0aGUgcGFyZW50IHN3aXRjaCwgc28gY29yZQ0KPiBmcmFtZXdvcmsgd2lsbCB0cmVh
dCB0aGUgcGFyZW50IHN3aXRjaCBzdWNjZXNzZnVsbHkgYnV0IEhXIGlzIGFjdHVhbGx5IE5PVC4N
Cj4gDQo+IEkgdGhpbmsgd2UgY2FuIHRyZWF0IGl0IGFzIHBsYXRmb3JtIHNwZWNpZmljIGlzc3Vl
LCBpZiBib290bG9hZGVyIGNhbiBndWFyYW50ZWUNCj4gYWxsIHBlcmlwaGVyYWwgY2xvY2tzIGFy
ZSBkaXNhYmxlZCBiZWZvcmUganVtcGluZyB0byBrZXJuZWwsIHRoZW4gdGhlcmUgd2lsbCBiZQ0K
PiBubyBpc3N1ZSwgYnV0IHdlIGNhbiBOT1QgYXNzdW1lIHRoYXQsIHNvIEkgaGF2ZSB0byBmaW5k
IHNvbWUgcGxhY2UgaW4gZWFybHkNCj4ga2VybmVsIHBoYXNlIHRvIGRpc2FibGUgdGhvc2UgcGVy
aXBoZXJhbCBjbG9ja3MuDQo+IA0KPiA+DQo+ID4gPiBzZXQsIGJ1dCB0aGUgY2hhbmdlIHdpbGwg
ZmFpbCBkdWUgdG8gSFcgTk9UIGFsbG93IHBhcmVudC9yYXRlIGNoYW5nZQ0KPiA+ID4gd2l0aCBj
bG9jayBlbmFibGVkLiBJdCB3aWxsIGNhdXNlIGNsb2NrIEhXIHN0YXR1cyBtaXNtYXRjaCB3aXRo
DQo+ID4gPiBjbG9jayB0cmVlIGluZm8gYW5kIGxlYWQgdG8gZnVuY3Rpb24gaXNzdWUuIEJlbG93
IGlzIGFuIGV4YW1wbGU6DQo+ID4gPg0KPiA+ID4gdXNkaGMwJ3MgcGNjIGNsb2NrIHZhbHVlIGlz
IDB4QzUwMDAwMDAgZHVyaW5nIGtlcm5lbCBib290IHVwLCBpdA0KPiA+ID4gbWVhbnMNCj4gPiA+
IHVzZGhjMCBjbG9jayBpcyBlbmFibGVkLCBpdHMgcGFyZW50IGlzIEFQTExfUEZEMS4gSW4gRFQg
ZmlsZSwgdGhlDQo+ID4gPiB1c2RoYzAgY2xvY2sgc2V0dGluZ3MgYXJlIGFzIGJlbG93Og0KPiA+
ID4NCj4gPiA+IGFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQX0NMS19VU0RIQzA+OyBh
c3NpZ25lZC1jbG9jay1wYXJlbnRzDQo+ID4gPiA9DQo+ID4gPiA8JnNjZzEgSU1YN1VMUF9DTEtf
TklDMV9ESVY+Ow0KPiA+ID4NCj4gPiA+IHdoZW4ga2VybmVsIGJvb3QgdXAsIHRoZSBjbG9jayB0
cmVlIGluZm8gaXMgYXMgYmVsb3csIGJ1dCB0aGUgdXNkaGMwDQo+ID4gPiBQQ0MgcmVnaXN0ZXIg
aXMgc3RpbGwgMHhDNTAwMDAwMCwgd2hpY2ggbWVhbnMgaXRzIHBhcmVudCBpcyBzdGlsbA0KPiA+
ID4gZnJvbSBBUExMX1BGRDEsIHdoaWNoIGlzIGluY29ycmVjdCBhbmQgY2F1c2UgdXNkaGMwIE5P
VCB3b3JrLg0KPiA+ID4NCj4gPiA+IG5pYzFfY2xrICAgICAgIDIgICAgICAgIDIgICAgICAgIDAg
ICAxNzYwMDAwMDAgICAgICAgICAgMCAgICAgMCAgNTAwMDANCj4gPiA+ICAgICB1c2RoYzAgICAg
ICAgMCAgICAgICAgMCAgICAgICAgMCAgIDE3NjAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAw
MA0KPiA+ID4NCj4gPiA+IEFmdGVyIG1ha2luZyBzdXJlIHRoZSBwZXJpcGhlcmFsIGNsb2NrIGlz
IGRpc2FibGVkIGR1cmluZyBjbG9jayB0cmVlDQo+ID4gPiBpbml0aWFsaXphdGlvbiwgdGhlIHVz
ZGhjMCBpcyB3b3JraW5nLCBhbmQgdGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5DQo+ID4gPiBmb3Ig
YWxsIGkuTVg3VUxQIHBlcmlwaGVyYWwgY2xvY2tzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAg
ZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtN3VscC5jIHwgMTMgKysrKysrKysrKysrKw0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAuYw0KPiA+ID4gYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS03dWxwLmMNCj4gPiA+IGluZGV4IDA2MGY4NjAu
LjFhMDU0MTEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0
ZS03dWxwLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAu
Yw0KPiA+ID4gQEAgLTMyLDYgKzMyLDcgQEAgc3RydWN0IGNsa19odyAqaW14N3VscF9jbGtfY29t
cG9zaXRlKGNvbnN0IGNoYXINCj4gPiAqbmFtZSwNCj4gPiA+ICAgICAgICAgc3RydWN0IGNsa19n
YXRlICpnYXRlID0gTlVMTDsNCj4gPiA+ICAgICAgICAgc3RydWN0IGNsa19tdXggKm11eCA9IE5V
TEw7DQo+ID4gPiAgICAgICAgIHN0cnVjdCBjbGtfaHcgKmh3Ow0KPiA+ID4gKyAgICAgICB1MzIg
dmFsOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgaWYgKG11eF9wcmVzZW50KSB7DQo+ID4gPiAgICAg
ICAgICAgICAgICAgbXV4ID0ga3phbGxvYyhzaXplb2YoKm11eCksIEdGUF9LRVJORUwpOyBAQCAt
NzAsNg0KPiA+ID4gKzcxLDE4IEBAIHN0cnVjdCBjbGtfaHcgKmlteDd1bHBfY2xrX2NvbXBvc2l0
ZShjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gICAgICAgICAgICAgICAgIGdhdGVfaHcgPSAmZ2F0
ZS0+aHc7DQo+ID4gPiAgICAgICAgICAgICAgICAgZ2F0ZS0+cmVnID0gcmVnOw0KPiA+ID4gICAg
ICAgICAgICAgICAgIGdhdGUtPmJpdF9pZHggPSBQQ0dfQ0dDX1NISUZUOw0KPiA+ID4gKyAgICAg
ICAgICAgICAgIC8qDQo+ID4gPiArICAgICAgICAgICAgICAgICogbWFrZSBzdXJlIGNsb2NrIGlz
IGdhdGVkIGR1cmluZyBjbG9jayB0cmVlIGluaXRpYWxpemF0aW9uLA0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAqIHRoZSBIVyBPTkxZIGFsbG93IGNsb2NrIHBhcmVudC9yYXRlIGNoYW5nZWQgd2l0
aCBjbG9jaw0KPiBnYXRlZCwNCj4gPiA+ICsgICAgICAgICAgICAgICAgKiBkdXJpbmcgY2xvY2sg
dHJlZSBpbml0aWFsaXphdGlvbiwgY2xvY2tzIGNvdWxkIGJlIGVuYWJsZWQNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgKiBieSBib290bG9hZGVyLCBzbyB0aGUgSFcgc3RhdHVzIHdpbGwgbWlzbWF0
Y2ggd2l0aCBjbG9jayB0cmVlDQo+ID4gPiArICAgICAgICAgICAgICAgICogcHJlcGFyZSBjb3Vu
dCwgdGhlbiBjbG9jayBjb3JlIGRyaXZlciB3aWxsIGFsbG93IHBhcmVudC9yYXRlDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICogY2hhbmdlIHNpbmNlIHRoZSBwcmVwYXJlIGNvdW50IGlzIHplcm8s
IGJ1dCBIVyBhY3R1YWxseQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAqIHByZXZlbnQgdGhlIHBh
cmVudC9yYXRlIGNoYW5nZSBkdWUgdG8gdGhlIGNsb2NrIGlzIGVuYWJsZWQuDQo+ID4gPiArICAg
ICAgICAgICAgICAgICovDQo+ID4NCj4gPiBJcyBpdCBPSyB0byBmb3JjaWJseSBnYXRlIHRoZSBj
bGsgbGlrZSB0aGlzIGF0IGluaXQgdGltZT8gSWYgc28sIHdoeQ0KPiA+IGNhbid0IHdlIGZvcmNl
IHRoZSBjbGsgb2ZmIHdoZW4gd2UgY2hhbmdlIHRoZSByYXRlIGFuZCB0aGVuIHJlc3RvcmUNCj4g
PiB0aGUgb24gc3RhdGUgYWZ0ZXIgY2hhbmdpbmcgdGhlIHJhdGU/IFRoYXQgd291bGQgYmUgbW9y
ZSAicm9idXN0IiB0aGFuDQo+ID4gZG9pbmcgaXQgb25jZSBoZXJlLiBQbHVzIHRoZW4gd2UgY291
bGQgcmVtb3ZlIHRoZSBDTEtfU0VUX1JBVEVfR0FURQ0KPiBmbGFnLg0KPiANCj4gWWVzLCBpdCBp
cyBPTkxZIGZvciBjb21wb3NpdGUgY2xvY2tzIHdoaWNoIGFyZSBmb3IgcGVyaXBoZXJhbCBjbG9j
a3MsIE9OTFkNCj4gZWFybHljb24gY291bGQgYmUgaW1wYWN0ZWQgYnV0IHdlIGNhbiBhZGQgaW14
X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKCkgY2FsbCB0bw0KPiBtYWtlIGVhcmx5Y29uIGFsc28gd29y
ay4NCj4gDQo+IEZvcmNpbmcgdGhlIGNsayBvZmYgYW5kIHJlc3RvcmUgdGhlbSBPTiBmb3IgcmF0
ZS9wYXJlbnQgY2hhbmdlIHdpbGwgbmVlZCB0bw0KPiBjaGFuZ2UgY29tbW9uIGNvbXBvc2l0ZSBj
bG9jayBvcHMsIGN1cnJlbnRseSBpLk1YN1VMUCBhbGwgdXNlIGNvbW1vbg0KPiBvcHMsIHNvIHVu
bGVzcyBpLk1YN1VMUCBpbXBsZW1lbnRzIGNvbXBvc2l0ZSBjbG9jayBvcHMsIGFuZCB0aGUgY2hh
bmdlDQo+IHdpbGwgYmUgdmVyeSBzaWduaWZpY2FudC4NCj4gDQo+IFRoYW5rcywNCj4gQW5zb24N
Cj4gDQo+ID4NCj4gPiA+ICsgICAgICAgICAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHJlZyk7
DQo+ID4gPiArICAgICAgICAgICAgICAgdmFsICY9IH4oMSA8PCBQQ0dfQ0dDX1NISUZUKTsNCj4g
PiA+ICsgICAgICAgICAgICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHJlZyk7DQo+ID4gPiAgICAg
ICAgIH0NCj4gPiA+DQo=
