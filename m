Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE30C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E7E204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ub2C+/Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfGRBnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:43:00 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:29441
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727804AbfGRBnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On+J+56MN0+7umQWgArBfdK3LAUlyWGe4C+2HAORAKDWLeMydNrxgl2xSgoWmJ+duyHURFELRNB8V+xuOVBGT/jyCXqzt2KXeMAOMNS0PiGuByqBAqkg6KbpK38P7YYhR+yuI7+isIAfBsZ3jfOtymyHSo+7amuN3uOz0k7tDrqkYlR6UaGn+hWhppyCcxPD4Cx2a0cNLVT/pad+qeFS+hFPag++/71Wi6VnyGRKYQJqparbbrqWID3b4bsi41Vzzwp36U1DZdFuDXUGMtBfQRtr3FlSulbUTEJDqddhRejz7LLxUSQBeY8V/zXgY7Z/3VvXAk0/ymkmis48Y7OtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/0gsWW2r9nUPujKn+CUXWuDZt7h3TiMWe7F8dTj2xw=;
 b=CoRbN/+C55J2u/94ldHm2wixbWilyEanDf6OzGnN9+YQXAAF/D24gzoTHtbxS4D34rxt/SbW08pXZLnRg5+B9DGa9hWym3FKLaebz6ZS9mndzvJc5fHzSfNZfVqFO8HiLX71Bkdu5qeAER5yHUG2x7ONiVdQa7DRBt2Bn94tjuXPL7UbxjwfXsyQSAWmhhmVsnBZGT76/aWGq6qN30XOsGUd0W9i8WSi3wWGOPVXdoA/wdeTbb2zSlaIgRIFcDUPonkpsTvpyn37n68hMYPPCICHzN9VAp7A2AGCuDCtFLkrUVk6M+dwIRpuzHfXJVCxE/RY/mGA8zf6iWPLk9ypHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/0gsWW2r9nUPujKn+CUXWuDZt7h3TiMWe7F8dTj2xw=;
 b=Ub2C+/NuL0XHYMrcxyKatb02gQYHekhxspcGOYfLpRPVGURBiUaLxNR0pOV9+gBcrzy3yxh60/15Ud8yQwBVE7cf54FzSvW4qLAVh0FcEsycOFXV30Rjn/zW/z2EHZQh2kF6E1uIXR2IA2+ubaVH4O7bFWwwfMZEJOzgL02B644=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4434.eurprd04.prod.outlook.com (52.135.145.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 01:42:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 01:42:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v3 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVOvV8miufREPgWk29kTcXKZEuBabL6GiAgAO0YqA=
Date:   Thu, 18 Jul 2019 01:42:52 +0000
Message-ID: <AM0PR04MB44816D1B4251E7DDE34C5BDE88C80@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1563184103-8493-1-git-send-email-peng.fan@nxp.com>
 <1563184103-8493-2-git-send-email-peng.fan@nxp.com>
 <CAL_JsqJkt7pX9F9NggL2EXxS=2oiF07VJCOqVTvF-Zwz=cjmvg@mail.gmail.com>
In-Reply-To: <CAL_JsqJkt7pX9F9NggL2EXxS=2oiF07VJCOqVTvF-Zwz=cjmvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c05f2507-53f7-4350-5972-08d70b213ff6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4434;
x-ms-traffictypediagnostic: AM0PR04MB4434:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB44345D11C9EE48D4CDDD60A588C80@AM0PR04MB4434.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(186003)(7696005)(44832011)(26005)(68736007)(76176011)(486006)(99286004)(102836004)(6506007)(53936002)(53546011)(15650500001)(14444005)(33656002)(6436002)(52536014)(3846002)(2906002)(64756008)(81156014)(256004)(476003)(11346002)(446003)(8676002)(55016002)(6306002)(9686003)(6116002)(54906003)(86362001)(14454004)(316002)(25786009)(478600001)(6246003)(7736002)(4326008)(8936002)(229853002)(71200400001)(305945005)(76116006)(66556008)(5660300002)(81166006)(74316002)(66446008)(66946007)(66476007)(66066001)(71190400001)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4434;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OraqSPcUiNVQFMPUjigpl7L2hcZKsVn7mUavw+EKN9wBtJHCwMo2dgqRyc1cIRjlHgVIuimR2GR97JZfrgDG5nZ7pOFVPmw7kHdW0lzds2o1y4YlMktR4KRiYyHgSKmocaparUq6LhUgqi7uGyDU/CNUHTbnyh2/QfT8rjbDl965hPZgaGqa8qeZAm+zQ9Sv/FcENumC+jXkN1WhH5yVW0DQQfrCmgq8+VU+S5M7FrmaZRoe3MszAWBUGZdsHORZF8giI/z0x4YmB4au7bZ10xv9kbZyUYv7DJhaNxZ+6ppc0D3t8CHld+RhOJSbPyJTIFrIhorDeqg793U03+eRtvkCvOHMmk0LyuqTkJOQYL+9Pgfk08szeB+rVP/eS+aLz8+jvhW9rculLJfYcJ10yfPlXRP4LDKiq7NqFnJH7u8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05f2507-53f7-4350-5972-08d70b213ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 01:42:52.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogbWFp
bGJveDogYWRkIGJpbmRpbmcgZG9jIGZvciB0aGUgQVJNDQo+IFNNQy9IVkMgbWFpbGJveA0KPiAN
Cj4gT24gTW9uLCBKdWwgMTUsIDIwMTkgYXQgNDoxMCBBTSBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPg0KPiA+IFRoZSBBUk0gU01DL0hWQyBtYWlsYm94IGJpbmRpbmcgZGVzY3JpYmVzIGEgZmly
bXdhcmUgaW50ZXJmYWNlIHRvDQo+ID4gdHJpZ2dlciBhY3Rpb25zIGluIHNvZnR3YXJlIGxheWVy
cyBydW5uaW5nIGluIHRoZSBFTDIgb3IgRUwzIGV4Y2VwdGlvbiBsZXZlbHMuDQo+ID4gVGhlIHRl
cm0gIkFSTSIgaGVyZSByZWxhdGVzIHRvIHRoZSBTTUMgaW5zdHJ1Y3Rpb24gYXMgcGFydCBvZiB0
aGUgQVJNDQo+ID4gaW5zdHJ1Y3Rpb24gc2V0LCBub3QgYXMgYSBzdGFuZGFyZCBlbmRvcnNlZCBi
eSBBUk0gTHRkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBWMzoNCj4gPiAgQ29udmVydCB0byB5YW1sDQo+ID4g
IERyb3AgaW50ZXJydXB0DQo+ID4gIEludHJvdWRjZSB0cmFuc3BvcnRzIHRvIGluZGljYXRlIG1l
bS9yZWcgIFRoZSBmdW5jIGlkIGlzIHN0aWxsIGtlcHQNCj4gPiBhcyBvcHRpb25hbCwgYmVjYXVz
ZSBsaWtlIFNDTUkgaXQgb25seSAgY2FyZXMgYWJvdXQgbWVzc2FnZS4NCj4gPg0KPiA+IFYyOg0K
PiA+ICBJbnRyb2R1Y2UgaW50ZXJydXB0cyBhcyBhIHByb3BlcnR5Lg0KPiA+DQo+ID4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy55YW1sICAgICAgIHwgMTI0DQo+ICsr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTI0IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy55YW1sDQo+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9hcm0tc21jLnlhbWwN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGE5YjFh
MDNiYzRlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L2FybS1zbWMueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTI0IEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVz
ZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+ID4gK2h0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGZGV2aQ0KPiA+
DQo+ICtjZXRyZWUub3JnJTJGc2NoZW1hcyUyRm1haWxib3glMkZhcm0tc21jLnlhbWwlMjMmYW1w
O2RhdGE9MDIlNw0KPiBDMDElN0NwDQo+ID4NCj4gK2VuZy5mYW4lNDBueHAuY29tJTdDNDI0ZTBk
MWMxOWMzNDQ0MDZiNjAwOGQ3MDk0NjU1OTElN0M2ODZlYTENCj4gZDNiYzJiNGMNCj4gPg0KPiAr
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5ODgwNzAwMDI3NzI3MDUmYW1wO3NkYXRh
PURWDQo+IHN0USUyRmh1Tg0KPiA+ICtjNjclMkJ0MDh5WGliUXJYN3NJZW9jSHppWXAzZGtrZVJv
SjQlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+
ID4NCj4gK2NldHJlZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9
MDIlN0MwMSU3Q3BlDQo+IG5nLmZhbiUNCj4gPg0KPiArNDBueHAuY29tJTdDNDI0ZTBkMWMxOWMz
NDQ0MDZiNjAwOGQ3MDk0NjU1OTElN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkOQ0KPiA+DQo+
ICs5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5ODgwNzAwMDI3ODI2OTgmYW1wO3NkYXRhPUQlMkZh
MlNVDQo+IFclMkZDcWNsSmR5DQo+ID4gK1JiRmdncXFMJTJCQUV1bUVSMEszckFhaXNZMmJNYyUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4gPiArdGl0bGU6IEFSTSBTTUMgTWFpbGJveCBJbnRl
cmZhY2UNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFRoaXMgbWFp
bGJveCB1c2VzIHRoZSBBUk0gc21jIChzZWN1cmUgbW9uaXRvciBjYWxsKSBhbmQgaHZjDQo+ID4g
KyhoeXBlcnZpc29yDQo+ID4gKyAgY2FsbCkgaW5zdHJ1Y3Rpb24gdG8gdHJpZ2dlciBhIG1haWxi
b3gtY29ubmVjdGVkIGFjdGl2aXR5IGluDQo+ID4gK2Zpcm13YXJlLA0KPiA+ICsgIGV4ZWN1dGlu
ZyBvbiB0aGUgdmVyeSBzYW1lIGNvcmUgYXMgdGhlIGNhbGxlci4gQnkgbmF0dXJlIHRoaXMNCj4g
PiArb3BlcmF0aW9uDQo+ID4gKyAgaXMgc3luY2hyb25vdXMgYW5kIHRoaXMgbWFpbGJveCBwcm92
aWRlcyBubyB3YXkgZm9yIGFzeW5jaHJvbm91cw0KPiA+ICttZXNzYWdlcw0KPiA+ICsgIHRvIGJl
IGRlbGl2ZXJlZCB0aGUgb3RoZXIgd2F5IHJvdW5kLCBmcm9tIGZpcm13YXJlIHRvIHRoZSBPUywg
YnV0DQo+ID4gKyAgYXN5bmNocm9ub3VzIG5vdGlmaWNhdGlvbiBjb3VsZCBhbHNvIGJlIHN1cHBv
cnRlZC4gSG93ZXZlciB0aGUNCj4gPiArdmFsdWUgb2YNCj4gPiArICByMC93MC94MCB0aGUgZmly
bXdhcmUgcmV0dXJucyBhZnRlciB0aGUgc21jIGNhbGwgaXMgZGVsaXZlcmVkIGFzIGENCj4gPiAr
cmVjZWl2ZWQNCj4gPiArICBtZXNzYWdlIHRvIHRoZSBtYWlsYm94IGZyYW1ld29yaywgc28gYSBz
eW5jaHJvbm91cyBjb21tdW5pY2F0aW9uDQo+ID4gK2NhbiBiZQ0KPiA+ICsgIGVzdGFibGlzaGVk
LCBmb3IgYSBhc3luY2hyb25vdXMgbm90aWZpY2F0aW9uLCBubyB2YWx1ZSB3aWxsIGJlIHJldHVy
bmVkLg0KPiA+ICsgIFRoZSBleGFjdCBtZWFuaW5nIG9mIGJvdGggdGhlIGFjdGlvbiB0aGUgbWFp
bGJveCB0cmlnZ2VycyBhcyB3ZWxsDQo+ID4gK2FzIHRoZQ0KPiA+ICsgIHJldHVybiB2YWx1ZSBp
cyBkZWZpbmVkIGJ5IHRoZWlyIHVzZXJzIGFuZCBpcyBub3Qgc3ViamVjdCB0byB0aGlzIGJpbmRp
bmcuDQo+ID4gKw0KPiA+ICsgIE9uZSB1c2UgY2FzZSBvZiB0aGlzIG1haWxib3ggaXMgdGhlIFND
TUkgaW50ZXJmYWNlLCB3aGljaCB1c2VzDQo+ID4gKyBzaGFyZWQgbWVtb3J5ICB0byB0cmFuc2Zl
ciBjb21tYW5kcyBhbmQgcGFyYW1ldGVycywgYW5kIGEgbWFpbGJveA0KPiB0bw0KPiA+ICsgdHJp
Z2dlciBhIGZ1bmN0aW9uICBjYWxsLiBUaGlzIGFsbG93cyBTb0NzIHdpdGhvdXQgYSBzZXBhcmF0
ZQ0KPiA+ICsgbWFuYWdlbWVudCBwcm9jZXNzb3IgKG9yIHdoZW4gIHN1Y2ggYSBwcm9jZXNzb3Ig
aXMgbm90IGF2YWlsYWJsZSBvcg0KPiA+ICsgdXNlZCkgdG8gdXNlIHRoaXMgc3RhbmRhcmRpemVk
ICBpbnRlcmZhY2UgYW55d2F5Lg0KPiA+ICsNCj4gPiArICBUaGlzIGJpbmRpbmcgZGVzY3JpYmVz
IG5vIGhhcmR3YXJlLCBidXQgZXN0YWJsaXNoZXMgYSBmaXJtd2FyZQ0KPiBpbnRlcmZhY2UuDQo+
ID4gKyAgVXBvbiByZWNlaXZpbmcgYW4gU01DIHVzaW5nIG9uZSBvZiB0aGUgZGVzY3JpYmVkIFNN
QyBmdW5jdGlvbg0KPiA+ICsgaWRlbnRpZmllcnMsICB0aGUgZmlybXdhcmUgaXMgZXhwZWN0ZWQg
dG8gdHJpZ2dlciBzb21lIG1haWxib3ggY29ubmVjdGVkDQo+IGZ1bmN0aW9uYWxpdHkuDQo+ID4g
KyAgVGhlIGNvbW11bmljYXRpb24gZm9sbG93cyB0aGUgQVJNIFNNQyBjYWxsaW5nIGNvbnZlbnRp
b24uDQo+ID4gKyAgRmlybXdhcmUgZXhwZWN0cyBhbiBTTUMgZnVuY3Rpb24gaWRlbnRpZmllciBp
biByMCBvciB3MC4gVGhlDQo+ID4gKyBzdXBwb3J0ZWQgIGlkZW50aWZpZXJzIGFyZSBwYXNzZWQg
ZnJvbSBjb25zdW1lcnMsIG9yIGxpc3RlZCBpbiB0aGUNCj4gPiArIHRoZSBhcm0sZnVuYy1pZHMg
IHByb3BlcnRpZXMgYXMgZGVzY3JpYmVkIGJlbG93LiBUaGUgZmlybXdhcmUgY2FuDQo+ID4gKyBy
ZXR1cm4gb25lIHZhbHVlIGluICB0aGUgZmlyc3QgU01DIHJlc3VsdCByZWdpc3RlciwgaXQgaXMg
ZXhwZWN0ZWQNCj4gPiArIHRvIGJlIGFuIGVycm9yIHZhbHVlLCAgd2hpY2ggc2hhbGwgYmUgcHJv
cGFnYXRlZCB0byB0aGUgbWFpbGJveCBjbGllbnQuDQo+ID4gKw0KPiA+ICsgIEFueSBjb3JlIHdo
aWNoIHN1cHBvcnRzIHRoZSBTTUMgb3IgSFZDIGluc3RydWN0aW9uIGNhbiBiZSB1c2VkLCBhcw0K
PiA+ICsgbG9uZyBhcyAgYSBmaXJtd2FyZSBjb21wb25lbnQgcnVubmluZyBpbiBFTDMgb3IgRUwy
IGlzIGhhbmRsaW5nIHRoZXNlDQo+IGNhbGxzLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4g
PiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IGFybSxzbWMtbWJveA0KPiA+ICsNCj4g
PiArICAiI21ib3gtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgYXJt
LG51bS1jaGFuczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVyIG9mIGNoYW5uZWxz
IHN1cHBvcnRlZC4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiANCj4gQ29uc3RyYWludHM/IDAgaXMgdmFsaWQ/IDJeMzI/DQoNCjAgaXMg
bm90IHZhbGlkLiBUaGVyZSBzaG91bGQgYmUgbGltaXRlZCBjaGFubmVscywgYnV0IGRlcGVuZHMg
b24gZmlybXdhcmUgZGVzaWduLg0KDQo+IA0KPiA+ICsNCj4gPiArICBtZXRob2Q6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBzbWMNCj4gPiAr
ICAgICAgICAgIC0gaHZjDQo+ID4gKw0KPiA+ICsgIHRyYW5zcG9ydHM6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBtZW0NCj4gPiArICAgICAg
ICAgIC0gcmVnDQo+IA0KPiBXaGF0IGlmIHNvbWVvbmUgd2FudHMgdG8gY29uZmlndXJlIHRoaXMg
cGVyIGNoYW5uZWw/IFBlcmhhcHMgI21ib3gtY2VsbHMNCj4gc2hvdWxkIGJlIDIgYW5kIHRoaXMg
Y2FuIGJlIGEgY2xpZW50IHBhcmFtZXRlci4NCg0KSSBuZWVkIHRvIGNoZWNrLiBDdXJyZW50bHkg
SSBvbmx5IHVzZSBvbmUgdHlwZS4gVGhlcmUgbWlnaHQgYmUgcGVvcGxlDQp3YW50IHRvIHVzZSBk
aWZmZXJlbnQgdHJhbnNwb3J0cyBmb3IgZWFjaCBjaGFubmVscy4NCg0KPiANCj4gTWluaW1hbGx5
LCB0aGlzIG5lZWRzIGEgJ2FybScgdmVuZG9yIHByZWZpeCBpZiBpdCBzdGF5cy4NCg0KImFybSx0
cmFuc3BvcnRzIiBpbiB2NC4NCg0KPiANCj4gPiArDQo+ID4gKyAgYXJtLGZ1bmMtaWRzOg0KPiA+
ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgQW4gYXJyYXkgb2YgMzItYml0IHZhbHVl
cyBzcGVjaWZ5aW5nIHRoZSBmdW5jdGlvbiBJRHMgdXNlZCBieSBlYWNoDQo+ID4gKyAgICAgIG1h
aWxib3ggY2hhbm5lbC4gVGhvc2UgZnVuY3Rpb24gSURzIGZvbGxvdyB0aGUgQVJNIFNNQyBjYWxs
aW5nDQo+ID4gKyAgICAgIGNvbnZlbnRpb24gc3RhbmRhcmQgWzFdLg0KPiANCj4gV2hhdCdzIHRo
ZSBkZWZhdWx0IGlmIG5vdCBzcGVjaWZpZWQ/IE9yIHRoaXMgc2hvdWxkIGJlIHJlcXVpcmVkPw0K
DQpJZiBub3Qgc3BlY2lmaWVkLCBpdCBtZWFucyB0aGUgY2xpZW50IGZpcm13YXJlIGRyaXZlciB3
aWxsIHBhc3MgaXQgdG8gbWFpbGJveCBkcml2ZXIuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
ID4gKw0KPiA+ICsgICAgICBUaGVyZSBpcyBvbmUgaWRlbnRpZmllciBwZXIgY2hhbm5lbCBhbmQg
dGhlIG51bWJlciBvZiBzdXBwb3J0ZWQNCj4gPiArICAgICAgY2hhbm5lbHMgaXMgZGV0ZXJtaW5l
ZCBieSB0aGUgbGVuZ3RoIG9mIHRoaXMgYXJyYXkuDQo+ID4gKyAgICBtaW5JdGVtczogMA0KPiA+
ICsgICAgbWF4SXRlbXM6IDQwOTYgICAjIFNob3VsZCBiZSBlbm91Z2g/DQo+ID4gKw0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtICIjbWJveC1jZWxscyINCj4g
PiArICAtIGFybSxudW0tY2hhbnMNCj4gPiArICAtIHRyYW5zcG9ydHMNCj4gPiArICAtIG1ldGhv
ZA0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzcmFtQDkxMDAw
MCB7DQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAibW1pby1zcmFtIjsNCj4gPiArICAgICAgcmVn
ID0gPDB4MCAweDkzZjAwMCAweDAgMHgxMDAwPjsNCj4gPiArICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gKyAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICByYW5nZXMg
PSA8MCAweDAgMHg5M2YwMDAgMHgxMDAwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgY3B1X3NjcF9s
cHJpOiBzY3Atc2htZW1AMCB7DQo+ID4gKyAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxzY21p
LXNobWVtIjsNCj4gPiArICAgICAgICAgIHJlZyA9IDwweDAgMHgyMDA+Ow0KPiA+ICsgICAgICAg
IH07DQo+ID4gKw0KPiA+ICsgICAgICAgIGNwdV9zY3BfaHByaTogc2NwLXNobWVtQDIwMCB7DQo+
ID4gKyAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxzY21pLXNobWVtIjsNCj4gPiArICAgICAg
ICAgIHJlZyA9IDwweDIwMCAweDIwMD47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+
ID4gKw0KPiA+ICsgICAgZmlybXdhcmUgew0KPiA+ICsgICAgICBzbWNfbWJveDogbWFpbGJveCB7
DQo+ID4gKyAgICAgICAgI21ib3gtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJhcm0sc21jLW1ib3giOw0KPiA+ICsgICAgICAgIG1ldGhvZCA9ICJzbWMiOw0KPiA+ICsg
ICAgICAgIGFybSxudW0tY2hhbnMgPSA8MHgyPjsNCj4gPiArICAgICAgICB0cmFuc3BvcnRzID0g
Im1lbSI7DQo+ID4gKyAgICAgICAgLyogT3B0aW9uYWwgKi8NCj4gPiArICAgICAgICBhcm0sZnVu
Yy1pZHMgPSA8MHhjMjAwMDBmZT4sIDwweGMyMDAwMGZmPjsNCj4gPiArICAgICAgfTsNCj4gPiAr
DQo+ID4gKyAgICAgIHNjbWkgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNjbWki
Ow0KPiA+ICsgICAgICAgIG1ib3hlcyA9IDwmbWFpbGJveCAwICZtYWlsYm94IDE+Ow0KPiA+ICsg
ICAgICAgIG1ib3gtbmFtZXMgPSAidHgiLCAicngiOw0KPiA+ICsgICAgICAgIHNobWVtID0gPCZj
cHVfc2NwX2xwcmkgJmNwdV9zY3BfaHByaT47DQo+ID4gKyAgICAgIH07DQo+ID4gKyAgICB9Ow0K
PiA+ICsNCj4gPiArLi4uDQo+ID4gLS0NCj4gPiAyLjE2LjQNCj4gPg0K
