Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE06C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B365721848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="flPylLZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfISDxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:53:38 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:15170
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731770AbfISDxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDiB3BFmOpMyFkVPo/b9/oA2EQRNdPnB+Xvx8O+tvvLZX3ApTZJl9S7+wykD8ZwnNmbqzOGw2WzTs7Wc40cv47lyJNsABmoRKFrLHFM7vbTRV3YIQQw8ZH6WYZKp5vXQIbFsO8h6zHTCYFXqSWcpeuMYER6vECPr5p8ENCFp1eJpkuj4sZLJhmCJipc0ww0ZMzNG4pycFqWYgvwuDQKcDpY/C1+0goC2Zll8EciY8HEYYsqx1peKRs6L8funZu6VxPKHlSETrjuCHgR7qAPB5P70DR3sbPNj7cndIgIUBYZwvu+TQPLAhnSctDPAeZDcxa+7aE881MMDh246OKDWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Z6S5xg9YnxSKWFHGTC66CZMg90GqiIcUddwRDAZV0=;
 b=d7oeXyVHbZ8CuNc5gwP14nCo46iRuUK2cwS4tqNFRDglKtd/Ck0cTj/nP02epzmPpklqTQlK4TQj4KzzLHUKFrP6PUl862KobU7hRhyDt4kg/PTHWSkI8aMsllmuRjJwvkHKE+Nw+jlRwoAdXDR9FZyDq/78G7DDcuVwOdjsOnxjht/HZKOgXYAtoRM+lqWFmvP8ZgPlKPV2e+P17cTJ7DT0d8YvspsorHzWuTO7xQkU3rJSQXAwsnbWxUHvZ5nmVAbc7nFeFpKZUndFyGj4CFqay3BL6x48Tfib+7ftMkPGZpUsOL6k8yeidFgCYCPIOdWbzhTqe3AdXmRhflTxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Z6S5xg9YnxSKWFHGTC66CZMg90GqiIcUddwRDAZV0=;
 b=flPylLZfOtKVYgQezHPp7JNA5kHKmbFxu49KkgpYx2NYHUkV3z08ooGv3pvjkue4t989fkayfW9M0zg+pcjJwBK+rzfMwC9enX4L5J6TbbUz2+ZIdJ3tir4JyipIZgcICUIcuH7bwdMu6Xvv7AlN0gJ1g7MOoFLtF7mvGOXNH5k=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4794.eurprd04.prod.outlook.com (20.176.234.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Thu, 19 Sep 2019 03:53:33 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::5cca:4549:eda4:7baf]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::5cca:4549:eda4:7baf%7]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 03:53:33 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v4 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v4 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVXlpDrHv3fQeGqUSSXzTNL08A8qcu3V4AgAISl5CAANiVAIAArxnA
Date:   Thu, 19 Sep 2019 03:53:33 +0000
Message-ID: <DB7PR04MB519538CC79789CB6DF65B9B2E2890@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190829105919.44363-1-wen.he_1@nxp.com>
 <20190829105919.44363-2-wen.he_1@nxp.com>
 <20190916202637.B5F542067B@mail.kernel.org>
 <DB7PR04MB51953099D6331F4F844A45EFE28E0@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20190918170051.2AEAF21848@mail.kernel.org>
In-Reply-To: <20190918170051.2AEAF21848@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1f6553-60c8-46b2-4b9d-08d73cb4f150
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4794;
x-ms-traffictypediagnostic: DB7PR04MB4794:|DB7PR04MB4794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB47945268854512DF7A53AB64E2890@DB7PR04MB4794.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(13464003)(199004)(6116002)(486006)(66066001)(76116006)(81166006)(99286004)(71200400001)(64756008)(66556008)(9686003)(81156014)(66946007)(14454004)(66446008)(66476007)(2906002)(71190400001)(2201001)(25786009)(256004)(4326008)(14444005)(478600001)(3846002)(8676002)(110136005)(86362001)(305945005)(446003)(33656002)(74316002)(7736002)(54906003)(2501003)(8936002)(6246003)(52536014)(229853002)(11346002)(476003)(6436002)(7696005)(102836004)(76176011)(186003)(53546011)(6506007)(26005)(316002)(5660300002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4794;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WUY/E19WadIwPVHtOlC1x4ZQNkqHviWNZ8Fp+GeZWtQ6AQCWKUFXu8ojg5mVi3I8zRLq2QgCtPe3LrKyuA8FJkMNLb2UMc67YPUPXnn/gGMIJ/V53N4NM4t1vfSKcPJ5+j/y8WsCquHZHuVOXyGIopjLBiVelRHFM41MdIF7/rhLTRh2YtiI9+bpiAxFGYxx30GcFfgtJcLaj9kAemApo20fqxTb2cLUipRn3cWz5Lt4ZeHJJt/W/+mj7kq1+9mjqN9VZQx5K/9MCm3BOOt2aLLvVLz2ah8ouSASNNnlQSUuTzgdUD7J4AGfVqiuE35OSAW7JwySPdSXTfulAXRp/SBJG1sXcog4rfnG2cVBhUcF9QURk0GbcqWPIXDYiDx5tcyNdw1TbiGwwVDGBD0XxNm0bI/pCuXb8aEZ2Pn03sI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f6553-60c8-46b2-4b9d-08d73cb4f150
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 03:53:33.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZDptzTfsTOc+xUX01sQWanLy61YtRLqsnojSh3UDM7/2c0plMKCwHaV4xQdMmag06K+lgIwWHMyIP/vU9we/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OeaciDE55pelIDE6MDENCj4gVG86IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1kZXZlbEBsaW51eC5ueGRpLm54cC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1
ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+Ow0KPiBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiBDYzogTGVvIExpIDxsZW95
YW5nLmxpQG54cC5jb20+OyBsaXZpdS5kdWRhdUBhcm0uY29tDQo+IFN1YmplY3Q6IFJFOiBbRVhU
XSBSZTogW3Y0IDIvMl0gY2xrOiBsczEwMjhhOiBBZGQgY2xvY2sgZHJpdmVyIGZvciBEaXNwbGF5
IG91dHB1dA0KPiBpbnRlcmZhY2UNCj4gDQo+IA0KPiBRdW90aW5nIFdlbiBIZSAoMjAxOS0wOS0x
OCAwMjoyMDoyNikNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IFF1b3RpbmcgV2VuIEhlICgyMDE5LTA4
LTI5DQo+ID4gPiAwMzo1OToxOSkNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Ns
ay1wbGxkaWcuYyBiL2RyaXZlcnMvY2xrL2Nsay1wbGxkaWcuYw0KPiA+ID4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmQzMjM5YmNmNTlkZQ0KPiA+ID4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1wbGxkaWcuYw0KPiA+ID4g
PiBAQCAtMCwwICsxLDI5OCBAQA0KPiBbLi4uXQ0KPiA+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4g
PiA+ICsvKiBNYXhpbXVtIG9mIHRoZSBkaXZpZGVyICovDQo+ID4gPiA+ICsjZGVmaW5lIE1BWF9S
RkRQSEkxICAgICAgICAgIDYzDQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qIEJlc3QgdmFsdWUgb2Yg
bXVsdGlwbGljYXRpb24gZmFjdG9yIGRpdmlkZXIgKi8NCj4gPiA+ID4gKyNkZWZpbmUgUExMRElH
X0RFRkFVTEVfTVVMVCAgICAgICAgIDQ0DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qDQo+ID4gPiA+
ICsgKiBDbG9jayBjb25maWd1cmF0aW9uIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSBQSEkxDQo+
ID4gPiA+ICtmcmVxdWVuY3koZnBsbF9waGkpIGFuZA0KPiA+ID4gPiArICogdGhlIG91dHB1dCBm
cmVxdWVuY3kgb2YgdGhlIFBMTCBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBQTExEViwNCj4gPiA+ID4g
K2FjY29yZGluZyB0bw0KPiA+ID4gPiArICogdGhlIGZvbGxvd2luZyBlcXVhdGlvbjoNCj4gPiA+
ID4gKyAqIGZwbGxfcGhpID0gKHBsbF9yZWYgKiBtZmQpIC8gZGl2X3JmZHBoaTEgICovIHN0cnVj
dA0KPiA+ID4gPiArcGxsZGlnX3BoaTFfcGFyYW0gew0KPiA+ID4gPiArICAgICAgIHVuc2lnbmVk
IGxvbmcgcmF0ZTsNCj4gPiA+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgcmZkcGhpMTsNCj4gPiA+
ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgbWZkOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArZW51bSBwbGxkaWdfcGhpMV9mcmVxX3JhbmdlIHsNCj4gPiA+ID4gKyAgICAgICBQSEkx
X01JTiAgICAgICAgPSAyNzAwMDAwMFUsDQo+ID4gPiA+ICsgICAgICAgUEhJMV9NQVggICAgICAg
ID0gNjAwMDAwMDAwVQ0KPiA+ID4gPiArfTsNCj4gPiA+DQo+ID4gPiBQbGVhc2UganVzdCBpbmxp
bmUgdGhlc2UgdmFsdWVzIGluIHRoZSBvbmUgcGxhY2UgdGhleSdyZSB1c2VkLg0KPiA+ID4NCj4g
PiA+ID4gKw0KPiA+ID4gPiArc3RydWN0IGNsa19wbGxkaWcgew0KPiA+ID4gPiArICAgICAgIHN0
cnVjdCBjbGtfaHcgaHc7DQo+ID4gPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpyZWdzOw0KPiA+
ID4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+DQo+ID4gPiBQbGVhc2UgcmVt
b3ZlIHRoaXMsIGl0IGlzIHVudXNlZC4NCj4gPg0KPiA+IEl0IGlzIHVzZWQgZm9yIHByb2JlLg0K
PiANCj4gVXNlIGEgbG9jYWwgdmFyaWFibGUgYW5kIGRvbid0IHN0b3JlIGl0IGF3YXkgZm9yZXZl
ciBpbiB0aGUgc3RydWN0Lg0KPiANCg0KVW5kZXJzdGFuZCwgd2lsbCByZW1vdmUgaXQuDQoNCj4g
PiA+DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICB2YWwgPSByZWFkbChkYXRhLT5yZWdzICsg
UExMRElHX1JFR19QTExEVik7DQo+ID4gPiA+ICsgICAgICAgdmFsID0gcGhpMV9wYXJhbS5tZmQ7
DQo+ID4gPiA+ICsgICAgICAgcmZkcGhpMSA9IHBoaTFfcGFyYW0ucmZkcGhpMTsNCj4gPiA+ID4g
KyAgICAgICB2YWwgfD0gcmZkcGhpMTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHdyaXRl
bCh2YWwsIGRhdGEtPnJlZ3MgKyBQTExESUdfUkVHX1BMTERWKTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgICAgIC8qIGRlbGF5IDIwMHVzIG1ha2Ugc3VyZSB0aGF0IG9sZCBsb2NrIHN0YXRlIGlz
IGNsZWFyZWQgKi8NCj4gPiA+ID4gKyAgICAgICB1ZGVsYXkoMjAwKTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICAgIC8qIFdhaXQgdW50aWwgUExMIGlzIGxvY2tlZCBvciB0aW1lb3V0IChtYXhp
bXVtIDEwMDAgdXNlY3MpICovDQo+ID4gPiA+ICsgICAgICAgcmV0ID0gcmVhZGxfcG9sbF90aW1l
b3V0X2F0b21pYyhkYXRhLT5yZWdzICsNCj4gPiA+ID4gKyBQTExESUdfUkVHX1BMTFNSLA0KPiA+
ID4gY29uZCwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbmQgJg0KPiBQTExESUdfTE9DS19NQVNLLA0KPiA+ID4gMCwNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFVTRUNfUEVSX01TRUMpOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+DQo+ID4gPiBKdXN0IHJldHVybiBy
ZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKC4uLikgaGVyZS4NCj4gPg0KPiA+IE1heWJlIHVzZSBi
ZWxvdyBjb2RlIHdpbGwgdG8gYmVzdCBkZXNjcmliZXMuDQo+ID4NCj4gPiBJZiAocmV0KQ0KPiA+
ICAgICAgICAgcmV0dXJuIC1FVElNRU9VVDsNCj4gPg0KPiA+IHJldHVybiAwOw0KPiANCj4gTm8s
IGp1c3QgcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKS4NCg0KVW5kZXJzdGFuZCwg
SSB3aWxsIHNlbmQgbmV4dCB2ZXJzaW9uIHBhdGNoIGZvciB0aGlzLg0KDQpUaGFua3MgJiYgQmVz
dCBSZWdhcmRzLA0KV2VuDQoNCg==
