Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7961C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797AC2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j80nvRxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfISFhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:37:01 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:35649
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfISFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:37:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrlsqKdZAcbSNHZOqBsUuSiScDbyHC9W9pRcjSy0MvDPKCPPjsZgf2Sw7IYNk59PQ15wRres93/lT9AhY0oeLMj5P/Ht7YUOKowmls3qpowkZO0kRnIRP66d5zyGH3WvEesdB1EDT5I1f5IYRs5O7zKPKwt4WIzcJ+m2d/wP48KHBLcjJSLkpjqAzyXKGP2xMh0o3Ox31+N334EWD5AcZHmrwECgQOlyGzUjkdo0F2uDSOfxpIGjTZdW3oxsm1EXi4tpOGF/Fx2VPs197O9rsssYXulLzwCBNSCalgQBku0l2P7T0jqs56sGsgecOWhh5GorIcnMnEA0V2pTvvEEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQZoUPdEtsiUpNAx+bVS7cNzlcIveB4QjuafgnUvWRk=;
 b=Xo76GuX+qPW4ovkIZGE9VmFwcAyQDS+LmMMwVattCB68eMozFbPF3LMqCJXMxFFQFdKjl9MfYgbFC7SKXsYupU3VQbWlEImCSBzl4TQWUZQanMa6FyUolq7oql2XwCXeUIn22TvsgmbFO46NGOuq8lHtju1QlBZNgjhuGwIAHPTgW6/H56P0ad12gh/PATGx1GhmyWrscPCnZqPO/en8HwnHyUwXtq1UMwleiSVZQPhIgC+2yBKEy0AmOJZog1y0QMippafLy1Wi/9Q/999YAGC+47h4o4034OrnPjBlmhrrS9guojSYnrqZ4s6a6dJNOAfmOcREK5cqNCBk1gocGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQZoUPdEtsiUpNAx+bVS7cNzlcIveB4QjuafgnUvWRk=;
 b=j80nvRxDcUGciSo46EQxupbTCmRORaR7QJumo45VLjlLnEpMKhxdiCdIqfRsCkUcJgiGM68YcSvdOLTRdcrHkCgLkZg/wb5LfRxWpgV/f/NJn6fKwpmzhPdU9vKqGpSGJ7o3Kg/diBkP8IUnYgGtlF6ZqlWFM4mIUqr0GlParIY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5105.eurprd04.prod.outlook.com (52.134.89.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Thu, 19 Sep 2019 05:36:56 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 05:36:56 +0000
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
Subject: RE: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V6 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVbHNdulW1qSzh8kulKbzCOfhGf6cwJKgAgAECNoCAABASgIAAOwuAgAENcaA=
Date:   Thu, 19 Sep 2019 05:36:56 +0000
Message-ID: <AM0PR04MB4481AC40243BFFF45CFD6E7988890@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-3-git-send-email-peng.fan@nxp.com>
 <20190917183856.2342beed@donnerap.cambridge.arm.com>
 <AM0PR04MB44813D62FF7E6762BB17460E888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190918110037.4edefb2f@donnerap.cambridge.arm.com>
 <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
In-Reply-To: <CABb+yY2G8s9gV8Pu+f__8-bubjCJsVQrQikbVMZXmpTwSMBxiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc42f6cb-0614-483f-4fd8-08d73cc3626c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5105;
x-ms-traffictypediagnostic: AM0PR04MB5105:|AM0PR04MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5105680853FDC7211AAF46E488890@AM0PR04MB5105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(14454004)(33656002)(102836004)(81156014)(9686003)(6436002)(2906002)(110136005)(6246003)(54906003)(14444005)(486006)(44832011)(229853002)(99286004)(66066001)(256004)(55016002)(6506007)(26005)(66446008)(76176011)(76116006)(71200400001)(305945005)(15650500001)(53546011)(11346002)(86362001)(64756008)(446003)(316002)(5660300002)(476003)(71190400001)(66946007)(66556008)(52536014)(7696005)(186003)(478600001)(66476007)(7736002)(25786009)(74316002)(8936002)(6116002)(8676002)(4326008)(3846002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5105;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mCqkHOP0QRQb5th+Al78KNQtIbF1GaKwoyYY/y+j0JpFaDhuWaRm6V1uVert4Lu+1UeX877xoDLabT38hZbEegCDPwbuspc4xDpjUbqGVdadMI7uhk3PgM9F5nG+b0rD2SFq2mk7AVLo4Gs+IEUPvCq2XvXxQFVvHyjvchoEYNWzea+v+dIJ/YfY+Kf7JKx4UhB4hSYdJg2UTj/UrjgKvmweqsabUIR/9HvrCAX8cq8MtqQaaNAS2AzN9iRgPHdzTU0tRoNZ5QcxW3K+t60k59Z6xJQLsXTPU/tKSwVSWUGJMT9pkkk0NNwdBIJFgaRVbcr4I57OAxcPjQFKNTkJMkZBvqes4T3AYf2dmP7P/yK8YULnAexsG9SRFdhfsISRoEZkNs47dplIRBH3jfd4WsVTrvC4FSON4xFO0jmDMN8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc42f6cb-0614-483f-4fd8-08d73cc3626c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 05:36:56.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSx4FrzlzJAdR/D/QH2t3Ws1dP2RWzy4CYQP8hRYrO6BeDyFz0hIDYb69y5ZGeeqzZhnCKG94KBCmsLnKJ/Jqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNiAyLzJdIG1haWxib3g6IGludHJv
ZHVjZSBBUk0gU01DIGJhc2VkIG1haWxib3gNCj4gDQo+IE9uIFdlZCwgU2VwIDE4LCAyMDE5IGF0
IDU6MDAgQU0gQW5kcmUgUHJ6eXdhcmENCj4gPGFuZHJlLnByenl3YXJhQGFybS5jb20+IHdyb3Rl
Og0KPiANCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gKyB9Ow0KPiA+ID4gPiA+ICt9Ow0KPiA+
ID4gPg0KPiA+ID4gPiBJZiB0aGlzIGlzIHRoZSBkYXRhIHN0cnVjdHVyZSB0aGF0IHRoaXMgbWFp
bGJveCBjb250cm9sbGVyIHVzZXMsIEkNCj4gPiA+ID4gd291bGQgZXhwZWN0IHRoaXMgdG8gYmUg
ZG9jdW1lbnRlZCBzb21ld2hlcmUsIG9yIGV2ZW4gZXhwb3J0ZWQuDQo+ID4gPg0KPiA+ID4gRXhw
b3J0IHRoaXMgc3RydWN0dXJlIGluIGluY2x1ZGUvbGludXgvbWFpbGJveC9zbWMtbWFpbGJveC5o
Pw0KPiA+DQo+ID4gRm9yIGluc3RhbmNlLCBldmVuIHRob3VnaCBJIGFtIG5vdCBzdXJlIHRoaXMg
aXMgcmVhbGx5IGRlc2lyZWQgb3IgaGVscGZ1bCwgc2luY2UNCj4gd2UgZXhwZWN0IGEgZ2VuZXJp
YyBtYWlsYm94IGNsaWVudCAodGhlIFNDUEkgb3IgU0NNSSBkcml2ZXIpIHRvIGRlYWwgd2l0aCB0
aGF0DQo+IG1haWxib3guDQo+ID4NCj4gPiBCdXQgYXQgbGVhc3QgdGhlIGV4cGVjdGVkIGZvcm1h
dCBzaG91bGQgYmUgZG9jdW1lbnRlZCwgd2hpY2ggY291bGQganVzdCBiZQ0KPiBpbiB3cml0aW5n
LCBub3QgbmVjZXNzYXJpbHkgaW4gY29kZS4NCj4gPg0KPiBZZXMsIHRoZSBwYWNrZXQgZm9ybWF0
IGlzIHNwZWNpZmllZCBieSB0aGUgY29udHJvbGxlciBhbmQgZGVmaW5lZCBpbiBzb21lDQo+IGhl
YWRlciBmb3IgY2xpZW50cyB0byBpbmNsdWRlLiBPdGhlciBwbGF0Zm9ybXMgZG8gdGhhdCBhbHJl
YWR5Lg0KDQpTbyB5b3UgcHJlZmVyIGFkZCB0aGUgc3RydWN0dXJlIGluIGluY2x1ZGUvbGludXgv
bWFpbGJveC9zbWMtbWFpbGJveC5oPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiANCj4gDQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICt0eXBlZGVmIHVuc2lnbmVkIGxvbmcgKHNtY19tYm94X2Zu
KSh1bnNpZ25lZCBpbnQsIHVuc2lnbmVkIGxvbmcsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZywgdW5zaWduZWQgbG9uZywNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBsb25n
LA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcp
OyBzdGF0aWMNCj4gc21jX21ib3hfZm4NCj4gPiA+ID4gPiArKmludm9rZV9zbWNfbWJveF9mbjsN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK3N0YXRpYyBpbnQgYXJtX3NtY19zZW5kX2RhdGEoc3Ry
dWN0IG1ib3hfY2hhbiAqbGluaywgdm9pZA0KPiA+ID4gPiA+ICsqZGF0YSkgeyAgc3RydWN0IGFy
bV9zbWNfY2hhbl9kYXRhICpjaGFuX2RhdGEgPSBsaW5rLT5jb25fcHJpdjsNCj4gPiA+ID4gPiAr
c3RydWN0IGFybV9zbWNjY19tYm94X2NtZCAqY21kID0gZGF0YTsgIHVuc2lnbmVkIGxvbmcgcmV0
Ow0KPiA+ID4gPiA+ICsgdTMyIGZ1bmN0aW9uX2lkOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
IGZ1bmN0aW9uX2lkID0gY2hhbl9kYXRhLT5mdW5jdGlvbl9pZDsgaWYgKCFmdW5jdGlvbl9pZCkN
Cj4gPiA+ID4gPiArICAgICAgICAgZnVuY3Rpb25faWQgPSBjbWQtPmZ1bmN0aW9uX2lkOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArIGlmIChmdW5jdGlvbl9pZCAmIEJJVCgzMCkpIHsNCj4gPiA+
ID4NCj4gPiA+ID4gICAgIGlmIChBUk1fU01DQ0NfSVNfNjQoZnVuY3Rpb25faWQpKSB7DQo+ID4g
Pg0KPiA+ID4gb2sNCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICAgICAgIHJldCA9IGlu
dm9rZV9zbWNfbWJveF9mbihmdW5jdGlvbl9pZCwNCj4gY21kLT5hcmdzX3NtY2NjNjRbMF0sDQo+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbWQtPmFyZ3Nfc21j
Y2M2NFsxXSwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNt
ZC0+YXJnc19zbWNjYzY0WzJdLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY21kLT5hcmdzX3NtY2NjNjRbM10sDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjbWQtPmFyZ3Nfc21jY2M2NFs0XSwNCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNtZC0+YXJnc19zbWNjYzY0WzVdKTsgfQ0K
PiBlbHNlDQo+ID4gPiA+ID4gKyB7DQo+ID4gPiA+ID4gKyAgICAgICAgIHJldCA9IGludm9rZV9z
bWNfbWJveF9mbihmdW5jdGlvbl9pZCwNCj4gY21kLT5hcmdzX3NtY2NjMzJbMF0sDQo+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbWQtPmFyZ3Nfc21jY2MzMlsx
XSwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNtZC0+YXJn
c19zbWNjYzMyWzJdLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY21kLT5hcmdzX3NtY2NjMzJbM10sDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbWQtPmFyZ3Nfc21jY2MzMls0XSwNCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNtZC0+YXJnc19zbWNjYzMyWzVdKTsgfQ0KPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiArIG1ib3hfY2hhbl9yZWNlaXZlZF9kYXRhKGxpbmssICh2b2lkICop
cmV0KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyByZXR1cm4gMDsNCj4gPiA+ID4gPiArfQ0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgX19pbnZva2VfZm5f
aHZjKHVuc2lnbmVkIGludCBmdW5jdGlvbl9pZCwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhcmcwLCB1bnNpZ25lZA0KPiBsb25nIGFyZzEs
DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
YXJnMiwgdW5zaWduZWQNCj4gbG9uZyBhcmczLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGFyZzQsIHVuc2lnbmVkDQo+IGxvbmcNCj4gPiA+
ID4gPiArYXJnNSkgeyAgc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiArIGFybV9zbWNjY19odmMoZnVuY3Rpb25faWQsIGFyZzAsIGFyZzEsIGFyZzIsIGFy
ZzMsIGFyZzQsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFyZzUsIDAsICZyZXMpOw0KPiA+
ID4gPiA+ICsgcmV0dXJuIHJlcy5hMDsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgX19pbnZva2VfZm5fc21jKHVuc2lnbmVkIGludCBm
dW5jdGlvbl9pZCwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyBhcmcwLCB1bnNpZ25lZA0KPiBsb25nIGFyZzEsDQo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYXJnMiwgdW5zaWduZWQNCj4g
bG9uZyBhcmczLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNp
Z25lZCBsb25nIGFyZzQsIHVuc2lnbmVkDQo+IGxvbmcNCj4gPiA+ID4gPiArYXJnNSkgeyAgc3Ry
dWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArIGFybV9zbWNj
Y19zbWMoZnVuY3Rpb25faWQsIGFyZzAsIGFyZzEsIGFyZzIsIGFyZzMsIGFyZzQsDQo+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgIGFyZzUsIDAsICZyZXMpOw0KPiA+ID4gPiA+ICsgcmV0dXJuIHJl
cy5hMDsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBtYm94X2NoYW5fb3BzIGFybV9zbWNfbWJveF9jaGFuX29wcyA9IHsNCj4gPiA+ID4g
PiArIC5zZW5kX2RhdGEgICAgICA9IGFybV9zbWNfc2VuZF9kYXRhLA0KPiA+ID4gPiA+ICt9Ow0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGludCBhcm1fc21jX21ib3hfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ID4gPiA+ICtzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2OyAgc3RydWN0IG1ib3hfY29udHJvbGxlciAqbWJveDsNCj4gPiA+ID4g
PiArc3RydWN0IGFybV9zbWNfY2hhbl9kYXRhICpjaGFuX2RhdGE7ICBpbnQgcmV0Ow0KPiA+ID4g
PiA+ICsgdTMyIGZ1bmN0aW9uX2lkID0gMDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyBpZiAo
b2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLCAiYXJtLHNtYy1tYm94IikpDQo+
ID4gPiA+ID4gKyAgICAgICAgIGludm9rZV9zbWNfbWJveF9mbiA9IF9faW52b2tlX2ZuX3NtYzsg
ZWxzZQ0KPiA+ID4gPiA+ICsgICAgICAgICBpbnZva2Vfc21jX21ib3hfZm4gPSBfX2ludm9rZV9m
bl9odmM7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgbWJveCA9IGRldm1fa3phbGxvYyhkZXYs
IHNpemVvZigqbWJveCksIEdGUF9LRVJORUwpOyBpZg0KPiA+ID4gPiA+ICsgKCFtYm94KQ0KPiA+
ID4gPiA+ICsgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
KyBtYm94LT5udW1fY2hhbnMgPSAxOw0KPiA+ID4gPiA+ICsgbWJveC0+Y2hhbnMgPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKm1ib3gtPmNoYW5zKSwNCj4gPiA+ID4gPiArIG1ib3gtPkdGUF9L
RVJORUwpOw0KPiA+ID4gPiA+ICsgaWYgKCFtYm94LT5jaGFucykNCj4gPiA+ID4gPiArICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgY2hhbl9kYXRhID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpjaGFuX2RhdGEpLCBHRlBfS0VSTkVMKTsNCj4gPiA+
ID4gPiArIGlmICghY2hhbl9kYXRhKQ0KPiA+ID4gPiA+ICsgICAgICAgICByZXR1cm4gLUVOT01F
TTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyBvZl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYtPm9m
X25vZGUsICJhcm0sZnVuYy1pZCIsDQo+ID4gPiA+ID4gKyAmZnVuY3Rpb25faWQpOyBjaGFuX2Rh
dGEtPmZ1bmN0aW9uX2lkID0gZnVuY3Rpb25faWQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsg
bWJveC0+Y2hhbnMtPmNvbl9wcml2ID0gY2hhbl9kYXRhOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArIG1ib3gtPnR4ZG9uZV9wb2xsID0gZmFsc2U7DQo+ID4gPiA+ID4gKyBtYm94LT50eGRvbmVf
aXJxID0gZmFsc2U7DQo+ID4gPiA+DQo+ID4gPiA+IERvbid0IHdlIG5lZWQgdG8gcHJvdmlkZSBz
b21ldGhpbmcgdG8gY29uZmlybSByZWNlcHRpb24gdG8gdGhlDQo+ID4gPiA+IGNsaWVudD8gSW4g
b3VyIGNhc2Ugd2UgY2FuIHNldCB0aGlzIGFzIHNvb24gYXMgdGhlIHNtYy9odmMgcmV0dXJucy4N
Cj4gPiA+DQo+ID4gPiBBcyBzbWMvaHZjIHJldHVybnMsIGl0IG1lYW5zIHRoZSB0cmFuc2ZlciBp
cyBvdmVyIGFuZCByZWNlaXZlIGlzIGRvbmUuDQo+ID4NCj4gPiBJIHVuZGVyc3RhbmQgdGhhdCwg
YnV0IHdhcyB3b25kZXJpbmcgaWYgdGhlIExpbnV4IG1haWxib3ggZnJhbWV3b3JrIGtub3dzDQo+
IGFib3V0IHRoYXQ/IEluIG15IG9sZGVyIHZlcnNpb24gSSB3YXMgY2FsbGluZyBtYm94X2NoYW5f
cmVjZWl2ZWRfZGF0YSgpDQo+IGFmdGVyIHRoZSBzbWMgY2FsbCByZXR1cm5lZC4NCj4gPg0KPiBU
aGUgY29kZSBhbHJlYWR5IGRvZXMgdGhhdCBhdCB0aGUgZW5kIG9mICBzZW5kX2RhdGENCj4gDQo+
ID4gQWxzbyB0aGVyZSBpcyBtYm94X2NoYW5fdHhkb25lKCkgd2l0aCB3aGljaCBhIGNvbnRyb2xs
ZXIgZHJpdmVyIGNhbiBzaWduYWwNCj4gVFggY29tcGxldGlvbiBleHBsaWNpdGx5Lg0KPiA+DQo+
IE5vLiBDb250cm9sbGVyIGNhbiB1c2UgdGhhdCBvbmx5IGlmIGl0IGhhcyBzcGVjaWZpZWQgdHhk
b25lX2lycSwgd2hpY2ggaXMgbm90IHRoZQ0KPiBjYXNlIGhlcmUuDQo+IA0KPiBUaGFua3MNCg==
