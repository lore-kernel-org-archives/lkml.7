Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E38ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970FB206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1dCX3LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfJIDWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:22:15 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:56707
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729658AbfJIDWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+mpWyemT+xPpPzWQmldMVL/+NtFg9wJ4Slqsjjh/LGQKavAi3AtUp/pxj54WXUCZ7TBuLU79IsJ2wkmudLmFBco1m4N3mCXUW8qa8GVijuh6KQ1C81NTg6GXrP8ORP3FBHucC+bOXTQ2ock5tB+dQMQNWK1XT/awKqcAtiscFmYOHufEC7UCXGCFTGdwubhCdzxbr0zwGfe4CLl7jSgOLOH1YSKHbHVKfhvD2xxvOMy1EC2fDUPFe4ipGL57z25XZbbhSsYui//mWeupTMJU0ivJAE4ancEgbY/qJ/FRYLxibXDEYjEl4yd/IIczhnbHhhUplIRQjJeTNIxcutU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X4N0NhRzmgcCoQXPaOC3+g6thJbZ+fNnZGXy1l2vwA=;
 b=U17TEBF/f1/IbqdInx2WrMzhz3xSK0FldQU/3Rb3dQpd7oEsmWbqQtUv6R3sb87UUZxUr7nb12nvSlmiA9++tJ4wJBRWx/++hFM2yTODFcbl7YpupQQg5odwOKUvGRjiEDTZXa0bd8r7O/3c6wLdeAs5UVS5yNGGwDCG0L3GT21ONWlz2P0YJ9ihSH8Beqkc4XBbkFsxoRwiXDKzuv3gH0mWdARnbm4TFrFxLMd9z2IRCfkLkN2yXnPEjyQwR8oikH0m8wjQXY8i4LmDJ4ft7q+fFB0AGnNdh0UJMNymxa5AoA3oFUvv/7a2AVqmOljStSwoXvEEGYvLpb1bS0Iwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X4N0NhRzmgcCoQXPaOC3+g6thJbZ+fNnZGXy1l2vwA=;
 b=f1dCX3LGyRqO+Ga3z+k0ArrUo2nvetdS4U4a58FukvX80agcYMbH+NmXxaPdIi90cpzr2M2G44LhFw8kF2e/ictXe9Yw5Zi48vzsE+OUwh6JSGeHIB+O6snhTzO12uioG/UadgM377HzKsATYVpfEHhsrMiBv+r6vSNTEMwxUHg=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB6603.eurprd04.prod.outlook.com (20.179.249.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 03:20:29 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 03:20:29 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     Yang Li <pku.leo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Topic: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Index: AQHVOH5G67Ou1TF8sk6MaGtvp7Q7iKbaT5kAgABcbSCAAUpwgIBd8ygAgBg/3PA=
Date:   Wed, 9 Oct 2019 03:20:28 +0000
Message-ID: <DB8PR04MB68268ECD73BA976CB59A3EDDF1950@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190712064206.48249-1-ran.wang_1@nxp.com>
 <20190724204222.GA1234@bogus>
 <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
 <CADRPPNRHOda+ZfB25CeqReXBb-MrB1oAeTHF-3muXVExn+G+Dg@mail.gmail.com>
In-Reply-To: <CADRPPNRHOda+ZfB25CeqReXBb-MrB1oAeTHF-3muXVExn+G+Dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86eded9a-69a3-4729-e631-08d74c67a2e3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB8PR04MB6603:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR04MB6603C48CAB3F0172E735C375F1950@DB8PR04MB6603.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(199004)(189003)(81166006)(81156014)(8676002)(76116006)(52536014)(9686003)(229853002)(55016002)(8936002)(6246003)(6436002)(5660300002)(25786009)(6306002)(4326008)(71190400001)(71200400001)(33656002)(486006)(966005)(102836004)(110136005)(54906003)(26005)(11346002)(446003)(476003)(14444005)(256004)(76176011)(6506007)(53546011)(99286004)(66066001)(305945005)(66556008)(6116002)(2906002)(74316002)(14454004)(86362001)(7736002)(7696005)(3846002)(186003)(15650500001)(66476007)(66446008)(316002)(66946007)(478600001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6603;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1gxdR4XMGOACooUYNs3NsmVmCOb67tU1/VytRHQJ8yVgNLVD4XpMod3PQ8KCe/G9qNr9ZQFghnkcWHK/fJ0i74azqechLPMg9tt+6qeH6AHeJH3VTxc5wHlzw3cpULn8/938a5fN3M/XNB9dJUJVsETIEinHPNxLR84r+rGYLP8lBd3FwMfpFIjz7QhdVqShlbJN//J5aOb4GGb3WqRLG3wBh+b/87c9DrRgcyPMSmKMMVF8q/6KLxWxnZdewD2XnYRrkPHxri4ApSxCUrM2NY9Mbc3YDFrJBiyVwoaL5H2m8sJ6bX9H5hiZXMSrZ6P+MIgvfV3zvcXzWNQYHum+nJ8BNl+bz97+pqoStrnWGE6Xt4ABJTGO64ZHNIgTnj6sNM/iv2U+0uQ43ILBq71LFzmQtLUoETCxSmhcCA5XfeJNwfqMDN7mQ9bzdrs58FLNvEUsgx7U+UkUnQMANmYhQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eded9a-69a3-4729-e631-08d74c67a2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 03:20:29.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nymbkon8Aou4hU40DCByD5JaT/nkNx1B+4wlGdc7HVBtDulQRfQ3BoVHVgE5CSAvu5rs1TVQ9EjBp3Sw4EdhHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBGZWxpcGUsDQoNCk9uIFR1ZXNkYXksIFNlcHRlbWJlciAyNCwgMjAxOSAwMDozOCwg
WWFuZyBMaSB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVsIDI1LCAyMDE5IGF0IDQ6NTYgUE0gUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIEp1bCAy
NCwgMjAxOSBhdCA4OjI5IFBNIFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+IHdyb3RlOg0K
PiA+ID4NCj4gPiA+IEhpIFJvYiwNCj4gPiA+DQo+ID4gPiBPbiBUaHVyc2RheSwgSnVseSAyNSwg
MjAxOSAwNDo0MiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gT24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMDI6NDI6MDVQTSArMDgwMCwgUmFuIFdh
bmcgd3JvdGU6DQo+ID4gPiA+ID4gU29tZSBMYXllcnNjYXBlIHBhbHRmb3JtcyAoc3VjaCBhcyBM
UzEwODhBLCBMUzIwODhBLCBldGMpDQo+ID4gPiA+ID4gZW5jb3VudGVyIFVTQiBkZXRlY3QgZmFp
bHVlcyB3aGVuIGFkZGluZyBkbWEtY29oZXJlbnQgdG8gRFdDMw0KPiA+ID4gPiA+IG5vZGUuIFRo
aXMgaXMgYmVjYXVzZSB0aGUgSFcgZGVmYXVsdCBjYWNoZSB0eXBlIGNvbmZpZ3VyYXRpb24gb2YN
Cj4gPiA+ID4gPiB0aG9zZSBTb0MgYXJlIG5vdCByaWdodCwgbmVlZCB0byBiZSB1cGRhdGVkIGlu
IERUUy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhbiBXYW5nIDxyYW4u
d2FuZ18xQG54cC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gQ2hhbmdlIGluIHYyOg0K
PiA+ID4gPiA+ICAgICAtIE5ldyBmaWxlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQgfCA0Mw0KPiA+ID4gPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MyBp
bnNlcnRpb25zKCspDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPiA+ID4gPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPiA+ID4gPiA+IGluZGV4
IDhlNTI2NWUuLjdiYzFjZWYgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQNCj4gPiA+ID4gPiBAQCAtMTEw
LDYgKzExMCw0MyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+ICAgLSBpbiBhZGRp
dGlvbiBhbGwgcHJvcGVydGllcyBmcm9tIHVzYi14aGNpLnR4dCBmcm9tIHRoZSBjdXJyZW50IGRp
cmVjdG9yeQ0KPiBhcmUNCj4gPiA+ID4gPiAgICAgc3VwcG9ydGVkIGFzIHdlbGwNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ICsqIENhY2hlIHR5cGUgbm9kZXMgKG9wdGlvbmFsKQ0KPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiArVGhlIENhY2hlIHR5cGUgbm9kZSBpcyB1c2VkIHRvIHRlbGwgaG93IHRvIGNv
bmZpZ3VyZSBjYWNoZSB0eXBlDQo+ID4gPiA+ID4gK29uIDQgZGlmZmVyZW50IHRyYW5zZmVyIHR5
cGVzOiBEYXRhIFJlYWQsIERlc2MgUmVhZCwgRGF0YSBXcml0ZQ0KPiA+ID4gPiA+ICthbmQgRGVz
YyB3cml0ZS4gRm9yIGVhY2ggdHJlYXNmZXIgdHlwZSwgY29udHJvbGxlciBoYXMgYSA0LWJpdA0K
PiA+ID4gPiA+ICtyZWdpc3RlciBmaWVsZCB0byBlbmFibGUgZGlmZmVyZW50IGNhY2hlIHR5cGUu
IFF1b3RlZCBmcm9tIERXQzMNCj4gPiA+ID4gPiArZGF0YSBib29rIFRhYmxlIDYtNQ0KPiA+ID4g
PiBDYWNoZSBUeXBlIEJpdCBBc3NpZ25tZW50czoNCj4gPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4g
PiA+ICtNQlVTX1RZUEV8IGJpdFszXSAgICAgICB8Yml0WzJdICAgICAgIHxiaXRbMV0gICAgIHxi
aXRbMF0NCj4gPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ICtBSEIgICAgICB8Q2FjaGVhYmxl
ICAgICB8QnVmZmVyYWJsZSAgIHxQcml2aWxlZ2dlIHxEYXRhDQo+ID4gPiA+ID4gK0FYSTMgICAg
IHxXcml0ZSBBbGxvY2F0ZXxSZWFkIEFsbG9jYXRlfENhY2hlYWJsZSAgfEJ1ZmZlcmFibGUNCj4g
PiA+ID4gPiArQVhJNCAgICAgfEFsbG9jYXRlIE90aGVyfEFsbG9jYXRlICAgICB8TW9kaWZpYWJs
ZSB8QnVmZmVyYWJsZQ0KPiA+ID4gPiA+ICtBWEk0ICAgICB8T3RoZXIgQWxsb2NhdGV8QWxsb2Nh
dGUgICAgIHxNb2RpZmlhYmxlIHxCdWZmZXJhYmxlDQo+ID4gPiA+ID4gK05hdGl2ZSAgIHxTYW1l
IGFzIEFYSSAgIHxTYW1lIGFzIEFYSSAgfFNhbWUgYXMgQVhJfFNhbWUgYXMgQVhJDQo+ID4gPiA+
ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+ID4gPiA+ICstDQo+ID4gPiA+ID4gK05vdGU6IFRoZSBBSEIsIEFYSTMs
IEFYSTQsIGFuZCBQQ0llIGJ1c3NlcyB1c2UgZGlmZmVyZW50IG5hbWVzDQo+ID4gPiA+ID4gK2Zv
ciBjZXJ0YWluIHNpZ25hbHMsIHdoaWNoIGhhdmUgdGhlIHNhbWUgbWVhbmluZzoNCj4gPiA+ID4g
PiArICBCdWZmZXJhYmxlID0gUG9zdGVkDQo+ID4gPiA+ID4gKyAgQ2FjaGVhYmxlID0gTW9kaWZp
YWJsZSA9IFNub29wIChuZWdhdGlvbiBvZiBObyBTbm9vcCkNCj4gPiA+ID4NCj4gPiA+ID4gVGhp
cyBzaG91bGQgYWxsIGJlIGltcGxpZWQgZnJvbSB0aGUgU29DIHNwZWNpZmljIGNvbXBhdGlibGUg
c3RyaW5ncy4NCj4gPiA+DQo+ID4gPiBEaWQgeW91IG1lYW4gSSBjb3VsZCBpbXBsZW1lbnQgYSBz
b2MgZHJpdmVyIHdoaWNoIGNhbiBiZSBtYXRjaGVkIGJ5DQo+IGNvbXBhdGlibGUgb2YgJ2ZzbCxs
czEwODhhLWR3YzMnIHdoaWNoIHdpbGwgcGFzcyBrbm93biBidXMgdHlwZSB0byBEV0MzIGRyaXZl
cj8NCj4gSWYgeWVzLCBob3cgdG8gcGFzcz8NCj4gPg0KPiA+IFllcy4gVGhlIERUIG1hdGNoIHRh
YmxlIGNhbiBoYXZlIGRhdGEgYXNzb2NpYXRlZCB3aXRoIHRoYXQgY29tcGF0aWJsZQ0KPiA+IHN0
cmluZy4gQmV5b25kIHRoYXQsIEknbSBub3QgcmVhbGx5IGZhbWlsaWFyIHdpdGggdGhlIERXQzMg
ZHJpdmVyLg0KPiANCj4gSGkgUm9iLA0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGF0IHRoZSBjdXJy
ZW50IGR3YzMgYmluZGluZyBwZXJmZXJzIHRvIGRlZmluZSBnZW5lcmFsIHF1aXJrcyBpbg0KPiBk
ZXZpY2UgdHJlZSBwcm9wZXJ0aWVzIGluc3RlYWQgb2YgdHJ5aW5nIHRvIHJlbHkgb24gdGhlIGNv
bXBhdGlibGUgc3RyaW5nIHRvDQo+IGRldGVybWluZSBxdWlya3MuICBJbiB0aGlzIGNhc2UsIGNh
biB3ZSBrZWVwIGZvbGxvd2luZyB0aGUgZXhpc3RpbmcgcHJlZmVyZW5jZQ0KPiBpbnN0ZWFkIG9m
IGNob29zaW5nIHRoZSBvdGhlciB3YXk/DQoNCkxvb2tzIGxpa2UgeW91IGhhdmUgZGlmZmVyZW50
IG9waW5pb25zIG9uIHRoaXMgc29sdXRpb24sIHNvIEkgJ2QgbGlrZSB0byBoYXZlIGFsbCBvcGVu
cw0KZ2V0IHNldHRsZWQgaGVyZSB0byBoZWxwIG1lIGZpbmQgYSBhY2NlcHRhYmxlIHNvbHV0aW9u
IGZvciBib3RoIG9mIHlvdS4gDQpQbGVhc2UgbGV0IG1lIGV4cGxhaW4gbW9yZSBhYm91dCB0aGlz
Og0KDQoxLiBUaGlzIGZlYXR1cmUgKGNvbmZpZ3VyZSBjYWNoZSB0eXBlKSBpcyBuYXRpdmVseSBm
cm9tIERXQzMgSVAgKHdlIGNhbiBmaW5kIGl0IGZyb20gZGF0YSBib29rKSwNCiAgICBub3QgYSBT
b0Mgc3BlY2lmaWMgZmVhdHVyZSAobW9yZSBkZXRhaWxzIHBsZWFzZSBzZWUgdjEgZGlzY3Vzc2lv
bjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzg1MTMwNi8pDQoNCjIu
IEhvd2V2ZXIsIGluIG1vc3QgU29DLCB0aGUgSFcgZGVmYXVsdCBzZXR0aW5nIGxvb2tzIGZpbmUg
KG5vIG5lZWQgZHJpdmVyIGhlbHApLCBidXQgc29tZSBjYXNlDQogICAgKGxpa2UgTGF5ZXJzY2Fw
ZSkgbWlnaHQgbmVlZCBkcml2ZXIgdG8gZG8gc29tZSBwcm9ncmFtbWluZyB0byBmaXggVVNCIG5v
IGRldGVjdCBpc3N1ZS4NCiAgICBUaGF0J3Mgd2h5IEkgaW1wbGVtZW50IHRoaXMgcGF0Y2guDQoN
CjMuIEZvciBub3csIFJvYiB0aGluayB0aGlzIHNob3VsZCBiZSBoYW5kbGVkIGJ5IFNvQyBzcGVj
aWZpYyBjb2RlIHJhdGhlciB0aGFuIGFkZGluZyBhIHByb3BlcnR5IHRvDQogICAgY29udHJvbCBp
dCAoYnkgRFdDMyBjb3JlIGRyaXZlcikuIEFuZCBGZWxpcGUgcHJlZmVyIHRvIGF2b2lkIHVzaW5n
IGdsdWUgZGl2ZXIuIFNvIEkgYW0gbm90IHN1cmUgaG93DQogICAgdG8gbWVldCB0aGlzIHJlcXVp
cmVtZW50cyBhdCB0aGUgc2FtZSB0aW1lLiANCiAgIA0KQW55IGZ1cnRoZXIgc3VnZ2VzdGlvbiBh
cmUgcmVhbGx5IGFwcHJlY2lhdGVkLiBUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpSYW4NCg==
