Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD02133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RI/qWhbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfHOErm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:47:42 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:28958
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfHOErl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:47:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZKsxfcTgE3F9eyyoqm+14H6Kw7wgRb7RRky4OTBPjgI/IG7cCdj8YzhZkAeKpnfUihvD8rAax4GRlhUmn8ys07W230N80RDVTDwFAgB8N8RBSy585VjF4Tib+Ug4UtfLl0Su8k3qqd0QN4oLF2vRPPiesrEdljtj+tvh2JGHUlTVAH9uRHhzFDt1HDSUW2VM1AtvrJCQtYJG0bH+wWLPRmxeAzbwHvM+LDFiTecMOiumhO0ICCxrP2nn0ouvSaTPhFgaxKukB6rCbPwNNAOOw5aasvj9RSAho9mQIsBXmn5TmwKVJzqVN3YZ3BWTBKZ90L1+Fqjrj7cXrZa2a5QUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V3RE0Jhu3jKodCrgCrUtsF7eHeoaZOXBRHMQE9yPy4=;
 b=i+XrZNl3WadVJb+rFoRCnU+eWSfldhnXF7gcB0dPv4JyHBV8sh4oHclM2aCtUsjYpjDZ6W8wxepz/Ynxs9ZtBtjtg0f1Ww3GxBC+PkqVi6wGqvCOie0Fdv5zws8BMAh5HuxYGZwDmANBu57rfOkcI/kAQCgBzOHgzPBCTDO9bdqsETG+NqqIrr9P22RWppxGjWnB6aMr1cPf7qx2zAyvERGWYnJYfkFjrqtx3xUrblQcu7xmiWwSvBPmh7fF5DEwDI11nrx/13zI9OmFmcW5wYBE0NWtWwYS5fCZysTgdlhchOPhBMrgyayB6jams0382uaaGb9/6qA6W7WY4YgBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V3RE0Jhu3jKodCrgCrUtsF7eHeoaZOXBRHMQE9yPy4=;
 b=RI/qWhbNOnxZcLNOj/T9xBG1JcwfJcGtrjskkmYWYIqB475kB2Yom9aro9tcShE+3/gc1Xgz6IDDqF3zg9e9vgjxEM9UoVeVa6PnG8xXOFmJBu9DEF5TAZbgoKjMtg8EKCHxpCdh8yZPnkW8KIcZVdWXPpCqmpFEbLxB5W4RPi8=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5244.eurprd04.prod.outlook.com (20.176.236.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Thu, 15 Aug 2019 04:47:35 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 04:47:35 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: [EXT] Re: [v1 1/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v1 1/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVUPY4W0/1jc4OTECL6cM1T4AZFqb5Zv+AgADMHOCAALX7gIAAvetQ
Date:   Thu, 15 Aug 2019 04:47:35 +0000
Message-ID: <DB7PR04MB51958B1AC5911AB59B953D39E2AC0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190812100103.34393-1-wen.he_1@nxp.com>
 <20190813182520.2914520665@mail.kernel.org>
 <DB7PR04MB51955595AB182A80162E313AE2AD0@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20190814172712.7F8F6206C1@mail.kernel.org>
In-Reply-To: <20190814172712.7F8F6206C1@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443d6fbe-0e3a-4e77-8353-08d7213bb0e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5244;
x-ms-traffictypediagnostic: DB7PR04MB5244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB52447965F07C195ACECF79E9E2AC0@DB7PR04MB5244.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(13464003)(199004)(189003)(5660300002)(76176011)(81156014)(64756008)(186003)(6246003)(26005)(305945005)(53936002)(66446008)(74316002)(7696005)(102836004)(86362001)(52536014)(66946007)(66476007)(66556008)(7736002)(81166006)(8676002)(14454004)(2501003)(76116006)(478600001)(446003)(2201001)(486006)(11346002)(25786009)(6506007)(256004)(53546011)(476003)(99286004)(316002)(110136005)(3846002)(66066001)(6116002)(33656002)(2906002)(229853002)(8936002)(6436002)(71190400001)(9686003)(71200400001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5244;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rr52sKqZB8i/purfeqj3TaE+jnHrgtCRO5NxagB/wiOVhvyMVsJQKjLqGGFUEKHS5iN6vkm2apGM02rJjLa7nMwN4ENWSkzkPBuR9YoR29eZaLmW+vVu60wnuu/6FZ5dB/BZihKm/e/VSyWhYZ6szNqrPCDzVDDScML29wqp9wGOifg5tgjiIvRkU8/ZpW+xkZ/EmeEXsAJyLlEm/mlq0tEJ1218KUZ7eE7x7QcXzSHUqN884tkS8ErCeW9vTHtmWhGlk6XKQZUn8+i4V/X9GHCXHWzdHolsd/qUp6b79M8zmp88uRznbHNj4DvUvZCu5Gn0afsSMvQfTQTUBMKK8rkum6n8MxpvU9sIOoHE3AyU4Q+guklal+uJOe8ENMc67XJlaHL6F/AxHWYebt9aN/ORo5+upgQ1GpCH6smbYKo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d6fbe-0e3a-4e77-8353-08d7213bb0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 04:47:35.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1STRRqUyIkzP766UyZmZdoC0DDyig+s9vpLcXow07+EvuzdPy1otjWPdwfZpeks0TL/kCP9I7oYKZbSaUFMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDE15pelIDE6MjcNCj4gVG86IGxp
bnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGkubnhwLmNvbTsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGl2aXUuZHVkYXVAYXJtLmNvbTsgTGVv
IExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb20+OyBXZW4NCj4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbRVhUXSBSZTogW3YxIDEvM10gY2xrOiBsczEwMjhhOiBBZGQgY2xvY2sgZHJpdmVyIGZv
ciBEaXNwbGF5IG91dHB1dA0KPiBpbnRlcmZhY2UNCj4gDQo+IA0KPiBRdW90aW5nIFdlbiBIZSAo
MjAxOS0wOC0xNCAwMjozODoyMSkNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+
ID4gU2VudDogMjAxOeW5tDjmnIgxNOaXpSAyOjI1DQo+ID4gPiBUbzogTWljaGFlbCBUdXJxdWV0
dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgV2VuIEhlDQo+ID4gPiA8d2VuLmhlXzFAbnhw
LmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gPiA+IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGkubnhwLmNvbTsNCj4gPiA+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpdml1LmR1ZGF1QGFybS5jb20NCj4gPiA+IENjOiBX
ZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW3YxIDEv
M10gY2xrOiBsczEwMjhhOiBBZGQgY2xvY2sgZHJpdmVyIGZvcg0KPiA+ID4gRGlzcGxheSBvdXRw
dXQgaW50ZXJmYWNlDQo+ID4gPg0KPiA+ID4NCj4gPiA+IFF1b3RpbmcgV2VuIEhlICgyMDE5LTA4
LTEyIDAzOjAxOjAzKQ0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvS2NvbmZpZyBi
L2RyaXZlcnMvY2xrL0tjb25maWcgaW5kZXgNCj4gPiA+ID4gODAxZmExY2QwMzIxLi4wZTZjNzAy
N2Q2MzcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL0tjb25maWcNCj4gPiA+ID4g
KysrIGIvZHJpdmVycy9jbGsvS2NvbmZpZw0KPiA+ID4gPiBAQCAtMjIzLDYgKzIyMywxNSBAQCBj
b25maWcgQ0xLX1FPUklRDQo+ID4gPiA+ICAgICAgICAgICBUaGlzIGFkZHMgdGhlIGNsb2NrIGRy
aXZlciBzdXBwb3J0IGZvciBGcmVlc2NhbGUgUW9ySVENCj4gcGxhdGZvcm1zDQo+ID4gPiA+ICAg
ICAgICAgICB1c2luZyBjb21tb24gY2xvY2sgZnJhbWV3b3JrLg0KPiA+ID4gPg0KPiA+ID4gPiAr
Y29uZmlnIENMS19QTExESUcNCj4gPiA+ID4gKyAgICAgICAgYm9vbCAiQ2xvY2sgZHJpdmVyIGZv
ciBMUzEwMjhBIERpc3BsYXkgb3V0cHV0Ig0KPiA+ID4gPiArICAgICAgICBkZXBlbmRzIG9uIEFS
Q0hfTEFZRVJTQ0FQRSAmJiBPRg0KPiA+ID4NCj4gPiA+IERvZXMgaXQgYWN0dWFsbHkgZGVwZW5k
IG9uIGVpdGhlciBvZiB0aGVzZSB0byBidWlsZD8gUHJvYmFibCBub3QsIHNvDQo+ID4gPiBtYXli
ZSBqdXN0IGRlZmF1bHQgQVJDSF9MQVlFUlNDQVBFICYmIE9GPyBBbHNvLCBjYW4geW91ciBLY29u
ZmlnDQo+ID4gPiB2YXJpYWJsZSBiZSBuYW1lZCBzb21ldGhpbmcgbW9yZSBzcGVjaWZpYyBsaWtl
IENMS19MUzEwMjhBX1BMTERJRz8NCj4gPg0KPiA+IEFjdHVhbGx5IGl0IGFsc28gZGVwZW5kcyBE
aXNwbGF5IG1vZHVsZXMsIGJ1dCB3ZSBhbGxvdyBidWlsZGluZw0KPiA+IGRpc3BsYXkgZHJpdmVy
cyBhcyBtb2R1bGVzLCBzbyBpcyBoZXJlIHdoZXRoZXIgbmVlZCBhZGQgRGlzcGxheQ0KPiA+IG1v
ZHVsZXMgZGVwZW5kIGFuZCBhbHNvIGFsbG93IGNsb2NrIGRyaXZlciBidWlsZGluZyB0byBhIG1v
ZHVsZT8NCj4gPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgdGhl
IG1vZHVsZXMgaW5zZXJ0LCBJIHRoaW5rDQo+ID4gdGhlIGNsb2NrIGRyaXZlciBzaG91bGQgYmUg
bG9uZyBhdmFpbGFibGUgZm9yIHRoZSBzeXN0ZW0uDQo+IA0KPiBJJ20gYXNraW5nIGlmIGl0IGFj
dHVhbGx5IHJlcXVpcmVzIEFSQ0hfTEFZRVJTQ0FQRSBvciBPRiB0byBzdWNjZXNzZnVsbHkNCj4g
Y29tcGlsZSB0aGUgZmlsZS4gSXMgdGhhdCB0cnVlPyBJIGRvbid0IHNlZSBhbnkgYXNtLyBpbmNs
dWRlcyBvciBhbnl0aGluZyB0aGF0J3MNCj4gZ29pbmcgdG8gZmFpbCBpZiBlaXRoZXIgb2YgdGhl
c2UgY29uZmlncyBhcmVuJ3QgZW5hYmxlZC4NCj4gU28gaXQgc2VlbXMgc2FmZSB0byBjaGFuZ2Ug
dGhpcyB0bw0KPiANCj4gICAgICAgICBkZXBlbmRzIG9uIEFSQ0hfTEFZRVJTQ0FQRSB8fCBDT01Q
SUxFX1RFU1QNCj4gICAgICAgICBkZWZhdWx0IEFSQ0hfTEFZRVJTQ0FQRQ0KPiANCj4gc28gdGhh
dCBpdCdzIGNvbXBpbGVkIGJ5IGRlZmF1bHQgb24gdGhpcyBhcmNoaXRlY3R1cmUgYW5kIGlzIGF2
YWlsYWJsZSB0byBiZQ0KPiBjb21waWxlIHRlc3RlZCBieSB2YXJpb3VzIHRlc3QgYnVpbGRlcnMu
DQoNClVuZGVyc3RhbmQsIFdpbGwgc2VuZCBuZXh0IHBhdGNoIHZlcnNpb24uDQoNCkJlc3QgUmVn
YXJkcywNCldlbg0KDQo+IA0KPiA+DQo+ID4gbG9va3MgbGlrZSBncmVhdCBpZiBuYW1lZCBLY29u
ZmlnIHZhcmlhYmxlIHRvICdDTEtfTFMxMDI4QV9QTExESUcnLg0KPiA+DQo+ID4gPg0K
