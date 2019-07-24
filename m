Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA7C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43593206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJLH7waR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGXI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:28:49 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:9219
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfGXI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXCQSavRxY6x2/Y/HpxH9LmwW56yldvwsXR7S0Hiyh0LrWIwIU226HTHmcBhC/8f4FstU7HHMBWHb8VaFHabM0GGr/7sq96kVw7SuqvCDIa7VdTWXi5QbG7cBg1dxIkK0wSMpuk6+zUCBLFTeamUyuNi4VXJ7UoYayHEZLmceOyWikxe+mCwXJ2dSb9gLAK1KRgTl9ttIN1aAx+6srbnMB1+bB5vIqx7P8l2v+9yUSzGF5PO2zKzT7Di2UaPpUq/l98BLR3zlOqePD5nsRZieiOn9kS4kuyCBFumKbvzf9nACQnAfVOe4LqzYu+NiYuOylRnGfOZvL2+n6eoqIJTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byw149FiJqX8CdXdqGX7zUhH7nmCMj1YNcuGPVWllf4=;
 b=b03gWIFyxG7eBbNySC7ICcUuocsBeUvtUskzr/BM72iM5Ibia2z1I4zun4jggT5dCLJD97mEnZjmNpPWX9LJQWG/pR1oCHGYFY1oenk4QTnPrNjolFeN/SYhcwU9M5NjtuKkB9ks0Z8iPfJilXb3o3RKjdSgs6mxH5JmrwyMLPoczMDGvjjYna9n88rgYfjaYYgUAzfZ5YzS683eafGRFaKcLVqDaMMMmPvwNdCf4orNZP1B/6SGE0nayg1ohKn48L/Puc28OTA4SBhDE9vc8sOFmpIZ/tIfCf3egeg78wZ5IXhGc6szVwfMaOoQA3x87qTLChttbc9+NUQViUo0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byw149FiJqX8CdXdqGX7zUhH7nmCMj1YNcuGPVWllf4=;
 b=pJLH7waRnZ4rfHeJqj3EMlfGhrdAd2bstbMkhlbzODxoYu49aPfOm+KIcBVRK2hiGFd/MmIB87MyE6yQ7hSozj9zP34fLgFTZ7eTzgpG1WlbKWMGwYvnJsIJU+HLPPgt+6JeJ+yr0NakzkTzpp0FUNB6Q2rgUzz0odUC9gxUqs4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.15; Wed, 24 Jul 2019 08:27:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019
 08:27:03 +0000
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
Thread-Index: AQHU+yZqSSaC+SqMKEqyvy0FwIJdyKZNkJKAgIxln0A=
Date:   Wed, 24 Jul 2019 08:27:03 +0000
Message-ID: <DB3PR0402MB39165F69F8B684D323C683B1F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
 <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
In-Reply-To: <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b9e2e78-94c6-439b-a1f2-08d71010b4cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB383321E2F65884C849CDFE2AF5C60@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(76176011)(110136005)(102836004)(33656002)(7696005)(81156014)(186003)(7416002)(6506007)(74316002)(8936002)(305945005)(81166006)(486006)(7736002)(66066001)(476003)(5660300002)(26005)(64756008)(66946007)(66556008)(478600001)(66476007)(2906002)(229853002)(99286004)(316002)(44832011)(66446008)(52536014)(68736007)(86362001)(14454004)(71190400001)(55016002)(25786009)(446003)(71200400001)(11346002)(6436002)(6636002)(6116002)(76116006)(14444005)(256004)(53936002)(9686003)(4326008)(6246003)(8676002)(2501003)(2201001)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x1W68VbMdHnlSeF/FRaqcW283Nqe+mSC16s5DkxRPHm5jKGRw2BjOaskfu7hQ+0Lfgavj/ZEqbuVcvNhR5UktB1kQ1yBzJAfnrxjW6HRuwVlr6e7OrEhPOr0cf337PMs4t2BD3+3a9ov+opTpkG8Ci6oBsZLDBAS20OK9A8/8XpsniCiTLKq7FFntlp7gfbCzY243Xursqgh1A16C2lXt8EWDFHuFjRIYekDZpUbCRouwFN8klrEFEthjnjIN9+E6QWUwHgiI4w8yRi1mcqaHTbt77LkCb2ehrbmIU498pnmTYFK0GjtwTpq5tixM9gqdgQiXk2tJf3N4nTDLQIft5yHAvejwqHxAVNoDLs5uYBoucklVa9sWCZQfvNe1tyMPt+B2fo1akPZAi2GmKQYebAlLZEKXfNOIlQMVvfrTfU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9e2e78-94c6-439b-a1f2-08d71010b4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 08:27:03.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTA0LTI0IDIyOjE5OjEy
KQ0KPiA+IGkuTVg3VUxQIHBlcmlwaGVyYWwgY2xvY2sgT05MWSBhbGxvdyBwYXJlbnQvcmF0ZSB0
byBiZSBjaGFuZ2VkIHdpdGgNCj4gPiBjbG9jayBnYXRlZCwgaG93ZXZlciwgZHVyaW5nIGNsb2Nr
IHRyZWUgaW5pdGlhbGl6YXRpb24sIHRoZSBwZXJpcGhlcmFsDQo+ID4gY2xvY2sgY291bGQgYmUg
ZW5hYmxlZCBieSBib290bG9hZGVyLCBidXQgdGhlIHByZXBhcmUgY291bnQgaW4gY2xvY2sNCj4g
PiB0cmVlIGlzIHN0aWxsIHplcm8sIHNvIGNsb2NrIGNvcmUgZHJpdmVyIHdpbGwgYWxsb3cgcGFy
ZW50L3JhdGUNCj4gPiBjaGFuZ2VkIGV2ZW4gd2l0aCBDTEtfU0VUX1JBVEVfR0FURS9DTEtfU0VU
X1BBUkVOVF9HQVRFDQo+IA0KPiBUaGF0J3MgYSBidWcuIENhbiB5b3Ugc2VuZCBhIHBhdGNoIHRv
IGZpeCB0aGUgY29yZSBmcmFtZXdvcmsgY29kZSB0byBmYWlsIGFuDQo+IGFzc2lnbmVkIHJhdGUg
b3IgcGFyZW50IGNoYW5nZSBpZiB0aG9zZSBmbGFncyBhcmUgc2V0PyBPciBpcyB0aGF0IGJlY2F1
c2UgdGhlDQo+IGNvcmUgZG9lc24ndCByZXNwZWN0IHRoZXNlIGZsYWdzIHdoZW4gdGhleSdyZSBi
dXJpZWQgaW4gdGhlIG1pZGRsZSBvZiB0aGUgY2xrDQo+IHRyZWUgYW5kIHNvbWUgcmF0ZSBvciBw
YXJlbnQgY2hhbmdlIGNvbWVzIGluIGFuZCBhZmZlY3RzIHRoZSBtaWRkbGUgb2YgdGhlDQo+IHRy
ZWUgdGhhdCBoYXMgdGhlIGZsYWcgc2V0IG9uIGl0Pw0KDQpJZiBjaGFuZ2luZyB0aGUgY29yZSBm
cmFtZXdvcmsgY29kZSB0byByZXR1cm4gZmFpbCBmb3IgY2xrIHBhcmVudC9yYXRlIGFzc2lnbm1l
bnQsDQp0aGF0IG1lYW5zIGNsayBhc3NpZ25tZW50IGluIERUIHdpbGwgTk9UIHdvcmsgZm9yIGku
TVg3VUxQLCB0aGVuIGFsbCB0aGUgY2xrDQpyYXRlL3BhcmVudCBzZXR0aW5ncyB3aWxsIGJlIGRv
bmUgaW4gZHJpdmVyPyBUaGF0IHdpbGwgbGVhZCB0byBtb3JlIGlzc3Vlcy9jaGFuZ2VzLg0KDQpJ
dCBpcyBqdXN0IGJlY2F1c2UgY29yZSBmcmFtZXdvcmsgT05MWSBjaGVja3MgdGhlIHByZXBhcmVf
Y291bnQgYW5kIENMS19TRVRfUEFSRU5UX0dBVEUNCmZsYWcgdG8gZGV0ZXJtaW5lIGlmIHRoZSBw
YXJlbnQgc3dpdGNoIGlzIGFsbG93ZWQsIGhvd2V2ZXIsIGR1cmluZyBjbG9jayB0cmVlIGluaXRp
YWxpemF0aW9uLA0KdGhlIHByZXBhcmVfY291bnQgaXMgYWx3YXlzIDAgYnV0IHRoZSBIVyBzdGF0
dXMgY291bGQgYmUgZW5hYmxlZCBhY3R1YWxseSwgc28gdGhlIGNvcmUgZnJhbWV3b3JrDQp3aWxs
IGFsbG93IHRoZSBwYXJlbnQgc3dpdGNoIHdoaWxlIEhXIHN0YXR1cyBkb2VzIE5PVCBhbGxvdyB0
aGUgcGFyZW50IHN3aXRjaCwgc28gY29yZSBmcmFtZXdvcmsNCndpbGwgdHJlYXQgdGhlIHBhcmVu
dCBzd2l0Y2ggc3VjY2Vzc2Z1bGx5IGJ1dCBIVyBpcyBhY3R1YWxseSBOT1QuIA0KDQpJIHRoaW5r
IHdlIGNhbiB0cmVhdCBpdCBhcyBwbGF0Zm9ybSBzcGVjaWZpYyBpc3N1ZSwgaWYgYm9vdGxvYWRl
ciBjYW4gZ3VhcmFudGVlIGFsbCBwZXJpcGhlcmFsIGNsb2Nrcw0KYXJlIGRpc2FibGVkIGJlZm9y
ZSBqdW1waW5nIHRvIGtlcm5lbCwgdGhlbiB0aGVyZSB3aWxsIGJlIG5vIGlzc3VlLCBidXQgd2Ug
Y2FuIE5PVCBhc3N1bWUgdGhhdCwgc28NCkkgaGF2ZSB0byBmaW5kIHNvbWUgcGxhY2UgaW4gZWFy
bHkga2VybmVsIHBoYXNlIHRvIGRpc2FibGUgdGhvc2UgcGVyaXBoZXJhbCBjbG9ja3MuDQoNCj4g
DQo+ID4gc2V0LCBidXQgdGhlIGNoYW5nZSB3aWxsIGZhaWwgZHVlIHRvIEhXIE5PVCBhbGxvdyBw
YXJlbnQvcmF0ZSBjaGFuZ2UNCj4gPiB3aXRoIGNsb2NrIGVuYWJsZWQuIEl0IHdpbGwgY2F1c2Ug
Y2xvY2sgSFcgc3RhdHVzIG1pc21hdGNoIHdpdGggY2xvY2sNCj4gPiB0cmVlIGluZm8gYW5kIGxl
YWQgdG8gZnVuY3Rpb24gaXNzdWUuIEJlbG93IGlzIGFuIGV4YW1wbGU6DQo+ID4NCj4gPiB1c2Ro
YzAncyBwY2MgY2xvY2sgdmFsdWUgaXMgMHhDNTAwMDAwMCBkdXJpbmcga2VybmVsIGJvb3QgdXAs
IGl0IG1lYW5zDQo+ID4gdXNkaGMwIGNsb2NrIGlzIGVuYWJsZWQsIGl0cyBwYXJlbnQgaXMgQVBM
TF9QRkQxLiBJbiBEVCBmaWxlLCB0aGUNCj4gPiB1c2RoYzAgY2xvY2sgc2V0dGluZ3MgYXJlIGFz
IGJlbG93Og0KPiA+DQo+ID4gYXNzaWduZWQtY2xvY2tzID0gPCZwY2MyIElNWDdVTFBfQ0xLX1VT
REhDMD47IGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPQ0KPiA+IDwmc2NnMSBJTVg3VUxQX0NMS19O
SUMxX0RJVj47DQo+ID4NCj4gPiB3aGVuIGtlcm5lbCBib290IHVwLCB0aGUgY2xvY2sgdHJlZSBp
bmZvIGlzIGFzIGJlbG93LCBidXQgdGhlIHVzZGhjMA0KPiA+IFBDQyByZWdpc3RlciBpcyBzdGls
bCAweEM1MDAwMDAwLCB3aGljaCBtZWFucyBpdHMgcGFyZW50IGlzIHN0aWxsIGZyb20NCj4gPiBB
UExMX1BGRDEsIHdoaWNoIGlzIGluY29ycmVjdCBhbmQgY2F1c2UgdXNkaGMwIE5PVCB3b3JrLg0K
PiA+DQo+ID4gbmljMV9jbGsgICAgICAgMiAgICAgICAgMiAgICAgICAgMCAgIDE3NjAwMDAwMCAg
ICAgICAgICAwICAgICAwICA1MDAwMA0KPiA+ICAgICB1c2RoYzAgICAgICAgMCAgICAgICAgMCAg
ICAgICAgMCAgIDE3NjAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KPiA+DQo+ID4gQWZ0
ZXIgbWFraW5nIHN1cmUgdGhlIHBlcmlwaGVyYWwgY2xvY2sgaXMgZGlzYWJsZWQgZHVyaW5nIGNs
b2NrIHRyZWUNCj4gPiBpbml0aWFsaXphdGlvbiwgdGhlIHVzZGhjMCBpcyB3b3JraW5nLCBhbmQg
dGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5DQo+ID4gZm9yIGFsbCBpLk1YN1VMUCBwZXJpcGhlcmFs
IGNsb2Nrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS03
dWxwLmMgfCAxMyArKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3Np
dGUtN3VscC5jDQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS03dWxwLmMNCj4g
PiBpbmRleCAwNjBmODYwLi4xYTA1NDExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lt
eC9jbGstY29tcG9zaXRlLTd1bHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstY29t
cG9zaXRlLTd1bHAuYw0KPiA+IEBAIC0zMiw2ICszMiw3IEBAIHN0cnVjdCBjbGtfaHcgKmlteDd1
bHBfY2xrX2NvbXBvc2l0ZShjb25zdCBjaGFyDQo+ICpuYW1lLA0KPiA+ICAgICAgICAgc3RydWN0
IGNsa19nYXRlICpnYXRlID0gTlVMTDsNCj4gPiAgICAgICAgIHN0cnVjdCBjbGtfbXV4ICptdXgg
PSBOVUxMOw0KPiA+ICAgICAgICAgc3RydWN0IGNsa19odyAqaHc7DQo+ID4gKyAgICAgICB1MzIg
dmFsOw0KPiA+DQo+ID4gICAgICAgICBpZiAobXV4X3ByZXNlbnQpIHsNCj4gPiAgICAgICAgICAg
ICAgICAgbXV4ID0ga3phbGxvYyhzaXplb2YoKm11eCksIEdGUF9LRVJORUwpOyBAQCAtNzAsNg0K
PiA+ICs3MSwxOCBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3dWxwX2Nsa19jb21wb3NpdGUoY29uc3Qg
Y2hhciAqbmFtZSwNCj4gPiAgICAgICAgICAgICAgICAgZ2F0ZV9odyA9ICZnYXRlLT5odzsNCj4g
PiAgICAgICAgICAgICAgICAgZ2F0ZS0+cmVnID0gcmVnOw0KPiA+ICAgICAgICAgICAgICAgICBn
YXRlLT5iaXRfaWR4ID0gUENHX0NHQ19TSElGVDsNCj4gPiArICAgICAgICAgICAgICAgLyoNCj4g
PiArICAgICAgICAgICAgICAgICogbWFrZSBzdXJlIGNsb2NrIGlzIGdhdGVkIGR1cmluZyBjbG9j
ayB0cmVlIGluaXRpYWxpemF0aW9uLA0KPiA+ICsgICAgICAgICAgICAgICAgKiB0aGUgSFcgT05M
WSBhbGxvdyBjbG9jayBwYXJlbnQvcmF0ZSBjaGFuZ2VkIHdpdGggY2xvY2sgZ2F0ZWQsDQo+ID4g
KyAgICAgICAgICAgICAgICAqIGR1cmluZyBjbG9jayB0cmVlIGluaXRpYWxpemF0aW9uLCBjbG9j
a3MgY291bGQgYmUgZW5hYmxlZA0KPiA+ICsgICAgICAgICAgICAgICAgKiBieSBib290bG9hZGVy
LCBzbyB0aGUgSFcgc3RhdHVzIHdpbGwgbWlzbWF0Y2ggd2l0aCBjbG9jayB0cmVlDQo+ID4gKyAg
ICAgICAgICAgICAgICAqIHByZXBhcmUgY291bnQsIHRoZW4gY2xvY2sgY29yZSBkcml2ZXIgd2ls
bCBhbGxvdyBwYXJlbnQvcmF0ZQ0KPiA+ICsgICAgICAgICAgICAgICAgKiBjaGFuZ2Ugc2luY2Ug
dGhlIHByZXBhcmUgY291bnQgaXMgemVybywgYnV0IEhXIGFjdHVhbGx5DQo+ID4gKyAgICAgICAg
ICAgICAgICAqIHByZXZlbnQgdGhlIHBhcmVudC9yYXRlIGNoYW5nZSBkdWUgdG8gdGhlIGNsb2Nr
IGlzIGVuYWJsZWQuDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiANCj4gSXMgaXQgT0sgdG8g
Zm9yY2libHkgZ2F0ZSB0aGUgY2xrIGxpa2UgdGhpcyBhdCBpbml0IHRpbWU/IElmIHNvLCB3aHkg
Y2FuJ3Qgd2UgZm9yY2UNCj4gdGhlIGNsayBvZmYgd2hlbiB3ZSBjaGFuZ2UgdGhlIHJhdGUgYW5k
IHRoZW4gcmVzdG9yZSB0aGUgb24gc3RhdGUgYWZ0ZXINCj4gY2hhbmdpbmcgdGhlIHJhdGU/IFRo
YXQgd291bGQgYmUgbW9yZSAicm9idXN0IiB0aGFuIGRvaW5nIGl0IG9uY2UgaGVyZS4gUGx1cw0K
PiB0aGVuIHdlIGNvdWxkIHJlbW92ZSB0aGUgQ0xLX1NFVF9SQVRFX0dBVEUgZmxhZy4NCg0KWWVz
LCBpdCBpcyBPTkxZIGZvciBjb21wb3NpdGUgY2xvY2tzIHdoaWNoIGFyZSBmb3IgcGVyaXBoZXJh
bCBjbG9ja3MsIE9OTFkgZWFybHljb24NCmNvdWxkIGJlIGltcGFjdGVkIGJ1dCB3ZSBjYW4gYWRk
IGlteF9yZWdpc3Rlcl91YXJ0X2Nsb2NrcygpIGNhbGwgdG8gbWFrZSBlYXJseWNvbg0KYWxzbyB3
b3JrLg0KDQpGb3JjaW5nIHRoZSBjbGsgb2ZmIGFuZCByZXN0b3JlIHRoZW0gT04gZm9yIHJhdGUv
cGFyZW50IGNoYW5nZSB3aWxsIG5lZWQgdG8gY2hhbmdlDQpjb21tb24gY29tcG9zaXRlIGNsb2Nr
IG9wcywgY3VycmVudGx5IGkuTVg3VUxQIGFsbCB1c2UgY29tbW9uIG9wcywgc28gdW5sZXNzDQpp
Lk1YN1VMUCBpbXBsZW1lbnRzIGNvbXBvc2l0ZSBjbG9jayBvcHMsIGFuZCB0aGUgY2hhbmdlIHdp
bGwgYmUgdmVyeSBzaWduaWZpY2FudC4gIA0KDQpUaGFua3MsDQpBbnNvbg0KDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHJlZyk7DQo+ID4gKyAgICAgICAgICAg
ICAgIHZhbCAmPSB+KDEgPDwgUENHX0NHQ19TSElGVCk7DQo+ID4gKyAgICAgICAgICAgICAgIHdy
aXRlbF9yZWxheGVkKHZhbCwgcmVnKTsNCj4gPiAgICAgICAgIH0NCj4gPg0K
