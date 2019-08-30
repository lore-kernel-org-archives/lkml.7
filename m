Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C04C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971D20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sdes/EKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfH3G2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:28:32 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:19521
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfH3G2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crRTbwKf6VMRvJ56G8HmMB4wCVmo6+OROkFwp+tDX1dTrzLPLxnPOmy99Fln43ZnQgfCTGSGhUy8CBx40aeWQbCZhH0J27h5l4vXOYVETTlxbbQY1vghRkmdSE1BQEQEA36yoL1eLuAJU93EK+nLCL0TF1ydLtkco/mx9Ffu6GY4+t+2mJwHHKwjc43P//Pfc5WY5zgPsa6EAD6XT4oppsIgZy4Ww9oQ6o2xHoW74+6oCG5+pyDjaK1wYlboRQA1wBSQYemDQpccP88cHDuXn0sTXwqpCF+8S/h13rn04gWld25V/IwvnEDiW15j/l6bO1ZyMDmB0OawbLGdRLC75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM2/nADU/eEWs6VGIYxw/PM9devWjm3BYg0tNV5LgFM=;
 b=XPgZp/qnpfXr97WM1MfdUNd4N4HexYzj9Mo7B8ys+lpFyZuLwDoa3eeSmKNeXisrhmvG/b0mLWF8OS+iN4U3a+ZE6HEsbQwp7JEdIaQfe+01DyATNDx8Zw9Tw3Cf9eBdrfnfl1NBeUJsVEoYM3J6ZHl0iuwFtbZqCQkQGjsDviiDIy1YACW+ZgjDATsiKycKXD3syjWo967D3UkKTk88lwqrDRnGsGFDc+DqEJ5YUB34QYDyJNvfbwnLwn8AvR57dyllDNCil/qfsRWG1f7DibJ/+AkSfzEVaLpP21YqfhSgtxuzTyS+SK3qEbg468hrhODI/AG/2Wvvd3e/wftJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM2/nADU/eEWs6VGIYxw/PM9devWjm3BYg0tNV5LgFM=;
 b=Sdes/EKiBwDmrSZWJioJelG+degJykwOg+jBwfAQpVTCPl42/Jdp7iNSi6FGjmnp6FSa/DZPlGJT80Zwzt1dGdCF3Y3UY8IYnylvMmLYYHFkirf8xf2uEhuXrLa61leMKiJLBhscmJBxsqqefiTmh3nRGwiDfgs86cecSgL2prY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4882.eurprd04.prod.outlook.com (20.176.215.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 06:28:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 06:28:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
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
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+A=
Date:   Fri, 30 Aug 2019 06:28:25 +0000
Message-ID: <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
In-Reply-To: <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5535e4-d9d5-4c39-8438-08d72d13433b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4882;
x-ms-traffictypediagnostic: AM0PR04MB4882:|AM0PR04MB4882:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB488226DE775FD793E684BE5488BD0@AM0PR04MB4882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(66446008)(66556008)(66476007)(8936002)(66066001)(6246003)(64756008)(25786009)(4326008)(6436002)(44832011)(54906003)(7736002)(316002)(305945005)(74316002)(6916009)(8676002)(53936002)(99286004)(76116006)(33656002)(81156014)(81166006)(66946007)(55016002)(9686003)(256004)(14444005)(53546011)(5660300002)(6306002)(6506007)(86362001)(6116002)(14454004)(102836004)(71190400001)(71200400001)(26005)(52536014)(45080400002)(7696005)(478600001)(76176011)(486006)(2906002)(229853002)(11346002)(446003)(1411001)(476003)(3846002)(15650500001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4882;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PQJECaHtk6s+CeWgIF5ziLDXPgE2IVUodyzG2jFuE0E1STFEY/k39YeW/pn0FO03K70ucYRLGL1ilNCyORxvGyObYQxTMAmGd5w382ldcF+YnD/hRTQytI4bknt1RXswj3vxldCPdjfD9kwjx/fGnv7lqTjSaRp0clU/Mni6sGRxAKRU1rSVbuGASdN8WJd6Red7cpFYN2yLJBd1XMV10n0oOuN2Ci7x2YZWOsA56dwL/l8qJ5wFrp0nb7VBzh1CZlbYmrNmPZ90fTM4HgtVEYcjlDY2AmA/mYkpMSyLl55mNGu8v5E9mEvsDncfoaKaq/6kv0BdJx+MPfgKDeYNBEUATfkYuUdSX5QBNrtCmc2m1wXSNfBDcHctuquZbwKR2J4YdSAXODIVI9jK3xsuljphn0BLSQjGJpjuoeNJNs4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5535e4-d9d5-4c39-8438-08d72d13433b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 06:28:25.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UH+7YmU+qJLq8aqGQT8g8UwGChRni3BQf+YAyyv/j0cm5d7KNhdH8S84FF5k5jbLk1rTbwzAgrpIkb63gdLRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkhpIEphc3NpLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5n
czogbWFpbGJveDogYWRkIGJpbmRpbmcgZG9jIGZvciB0aGUgQVJNDQo+IFNNQy9IVkMgbWFpbGJv
eA0KPiANCj4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMTA6MDIgUE0gUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4NCj4gPiBUaGUgQVJNIFNNQy9IVkMgbWFpbGJveCBiaW5kaW5nIGRlc2NyaWJl
cyBhIGZpcm13YXJlIGludGVyZmFjZSB0bw0KPiA+IHRyaWdnZXIgYWN0aW9ucyBpbiBzb2Z0d2Fy
ZSBsYXllcnMgcnVubmluZyBpbiB0aGUgRUwyIG9yIEVMMyBleGNlcHRpb24gbGV2ZWxzLg0KPiA+
IFRoZSB0ZXJtICJBUk0iIGhlcmUgcmVsYXRlcyB0byB0aGUgU01DIGluc3RydWN0aW9uIGFzIHBh
cnQgb2YgdGhlIEFSTQ0KPiA+IGluc3RydWN0aW9uIHNldCwgbm90IGFzIGEgc3RhbmRhcmQgZW5k
b3JzZWQgYnkgQVJNIEx0ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L2FybS1zbWMueWFtbCAgICAgICB8IDEyNQ0KPiArKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FybS1z
bWMueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L2FybS1zbWMueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY4ZWIyOGQ1ZTMwNw0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9h
cm0tc21jLnlhbWwNCj4gPiBAQCAtMCwwICsxLDEyNSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0N
Cj4gPiArJGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRnNjaGVt
YXMlMkZtYWlsYm94JTJGYXJtLXNtYy55YW1sJTIzJmFtcDtkYXRhPTAyJTcNCj4gQzAxJTdDcA0K
PiA+DQo+ICtlbmcuZmFuJTQwbnhwLmNvbSU3QzhhYTY3MWRmYTRkMDRiYTAwM2I1MDhkNzJkMGYy
OTdmJTdDNjg2ZWExZA0KPiAzYmMyYjRjDQo+ID4NCj4gKzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MxJTdDNjM3MDI3NDE1NDQ4MTk2MTQ1JmFtcDtzZGF0YT14ZA0KPiBuVU9iTnFsUkYNCj4gPiAr
bHU4TmlYU3VjMzVmWXJISXpSJTJGeWFrNkl6VzA1UTNuQSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+
ICskc2NoZW1hOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRm1ldGEt
c2NoZW1hcyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0YT0wMiU3QzAxJTdDcGUNCj4gbmcuZmFuJQ0K
PiA+DQo+ICs0MG54cC5jb20lN0M4YWE2NzFkZmE0ZDA0YmEwMDNiNTA4ZDcyZDBmMjk3ZiU3QzY4
NmVhMWQzYmMyYjRjNg0KPiBmYTkyY2Q5DQo+ID4NCj4gKzljNWMzMDE2MzUlN0MwJTdDMSU3QzYz
NzAyNzQxNTQ0ODE5NjE0NSZhbXA7c2RhdGE9d2wlMkZkZzA5DQo+IFFNUyUyRm9IZ0kNCj4gPiAr
eUQ3WkJOcG9JR1hZeGZGRFJXaHlZSG9nRmQ2QSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4g
PiArdGl0bGU6IEFSTSBTTUMgTWFpbGJveCBJbnRlcmZhY2UNCj4gPiArDQo+ID4gK21haW50YWlu
ZXJzOg0KPiA+ICsgIC0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gKw0KPiA+ICtk
ZXNjcmlwdGlvbjogfA0KPiA+ICsgIFRoaXMgbWFpbGJveCB1c2VzIHRoZSBBUk0gc21jIChzZWN1
cmUgbW9uaXRvciBjYWxsKSBhbmQgaHZjDQo+ID4gKyhoeXBlcnZpc29yDQo+ID4gKyAgY2FsbCkg
aW5zdHJ1Y3Rpb24gdG8gdHJpZ2dlciBhIG1haWxib3gtY29ubmVjdGVkIGFjdGl2aXR5IGluDQo+
ID4gK2Zpcm13YXJlLA0KPiA+ICsgIGV4ZWN1dGluZyBvbiB0aGUgdmVyeSBzYW1lIGNvcmUgYXMg
dGhlIGNhbGxlci4gQnkgbmF0dXJlIHRoaXMNCj4gPiArb3BlcmF0aW9uDQo+ID4gKyAgaXMgc3lu
Y2hyb25vdXMgYW5kIHRoaXMgbWFpbGJveCBwcm92aWRlcyBubyB3YXkgZm9yIGFzeW5jaHJvbm91
cw0KPiA+ICttZXNzYWdlcw0KPiA+ICsgIHRvIGJlIGRlbGl2ZXJlZCB0aGUgb3RoZXIgd2F5IHJv
dW5kLCBmcm9tIGZpcm13YXJlIHRvIHRoZSBPUywgYnV0DQo+ID4gKyAgYXN5bmNocm9ub3VzIG5v
dGlmaWNhdGlvbiBjb3VsZCBhbHNvIGJlIHN1cHBvcnRlZC4gSG93ZXZlciB0aGUNCj4gPiArdmFs
dWUgb2YNCj4gPiArICByMC93MC94MCB0aGUgZmlybXdhcmUgcmV0dXJucyBhZnRlciB0aGUgc21j
IGNhbGwgaXMgZGVsaXZlcmVkIGFzIGENCj4gPiArcmVjZWl2ZWQNCj4gPiArICBtZXNzYWdlIHRv
IHRoZSBtYWlsYm94IGZyYW1ld29yaywgc28gYSBzeW5jaHJvbm91cyBjb21tdW5pY2F0aW9uDQo+
ID4gK2NhbiBiZQ0KPiA+ICsgIGVzdGFibGlzaGVkLCBmb3IgYSBhc3luY2hyb25vdXMgbm90aWZp
Y2F0aW9uLCBubyB2YWx1ZSB3aWxsIGJlIHJldHVybmVkLg0KPiA+ICsgIFRoZSBleGFjdCBtZWFu
aW5nIG9mIGJvdGggdGhlIGFjdGlvbiB0aGUgbWFpbGJveCB0cmlnZ2VycyBhcyB3ZWxsDQo+ID4g
K2FzIHRoZQ0KPiA+ICsgIHJldHVybiB2YWx1ZSBpcyBkZWZpbmVkIGJ5IHRoZWlyIHVzZXJzIGFu
ZCBpcyBub3Qgc3ViamVjdCB0byB0aGlzIGJpbmRpbmcuDQo+ID4gKw0KPiA+ICsgIE9uZSB1c2Ug
Y2FzZSBvZiB0aGlzIG1haWxib3ggaXMgdGhlIFNDTUkgaW50ZXJmYWNlLCB3aGljaCB1c2VzDQo+
ID4gKyBzaGFyZWQgbWVtb3J5ICB0byB0cmFuc2ZlciBjb21tYW5kcyBhbmQgcGFyYW1ldGVycywg
YW5kIGEgbWFpbGJveA0KPiB0bw0KPiA+ICsgdHJpZ2dlciBhIGZ1bmN0aW9uICBjYWxsLiBUaGlz
IGFsbG93cyBTb0NzIHdpdGhvdXQgYSBzZXBhcmF0ZQ0KPiA+ICsgbWFuYWdlbWVudCBwcm9jZXNz
b3IgKG9yIHdoZW4gIHN1Y2ggYSBwcm9jZXNzb3IgaXMgbm90IGF2YWlsYWJsZSBvcg0KPiA+ICsg
dXNlZCkgdG8gdXNlIHRoaXMgc3RhbmRhcmRpemVkICBpbnRlcmZhY2UgYW55d2F5Lg0KPiA+ICsN
Cj4gPiArICBUaGlzIGJpbmRpbmcgZGVzY3JpYmVzIG5vIGhhcmR3YXJlLCBidXQgZXN0YWJsaXNo
ZXMgYSBmaXJtd2FyZQ0KPiBpbnRlcmZhY2UuDQo+ID4gKyAgVXBvbiByZWNlaXZpbmcgYW4gU01D
IHVzaW5nIG9uZSBvZiB0aGUgZGVzY3JpYmVkIFNNQyBmdW5jdGlvbg0KPiA+ICsgaWRlbnRpZmll
cnMsICB0aGUgZmlybXdhcmUgaXMgZXhwZWN0ZWQgdG8gdHJpZ2dlciBzb21lIG1haWxib3ggY29u
bmVjdGVkDQo+IGZ1bmN0aW9uYWxpdHkuDQo+ID4gKyAgVGhlIGNvbW11bmljYXRpb24gZm9sbG93
cyB0aGUgQVJNIFNNQyBjYWxsaW5nIGNvbnZlbnRpb24uDQo+ID4gKyAgRmlybXdhcmUgZXhwZWN0
cyBhbiBTTUMgZnVuY3Rpb24gaWRlbnRpZmllciBpbiByMCBvciB3MC4gVGhlDQo+ID4gKyBzdXBw
b3J0ZWQgIGlkZW50aWZpZXJzIGFyZSBwYXNzZWQgZnJvbSBjb25zdW1lcnMsIG9yIGxpc3RlZCBp
biB0aGUNCj4gPiArIHRoZSBhcm0sZnVuYy1pZHMgIHByb3BlcnRpZXMgYXMgZGVzY3JpYmVkIGJl
bG93LiBUaGUgZmlybXdhcmUgY2FuDQo+ID4gKyByZXR1cm4gb25lIHZhbHVlIGluICB0aGUgZmly
c3QgU01DIHJlc3VsdCByZWdpc3RlciwgaXQgaXMgZXhwZWN0ZWQNCj4gPiArIHRvIGJlIGFuIGVy
cm9yIHZhbHVlLCAgd2hpY2ggc2hhbGwgYmUgcHJvcGFnYXRlZCB0byB0aGUgbWFpbGJveCBjbGll
bnQuDQo+ID4gKw0KPiA+ICsgIEFueSBjb3JlIHdoaWNoIHN1cHBvcnRzIHRoZSBTTUMgb3IgSFZD
IGluc3RydWN0aW9uIGNhbiBiZSB1c2VkLCBhcw0KPiA+ICsgbG9uZyBhcyAgYSBmaXJtd2FyZSBj
b21wb25lbnQgcnVubmluZyBpbiBFTDMgb3IgRUwyIGlzIGhhbmRsaW5nIHRoZXNlDQo+IGNhbGxz
Lg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
Y29uc3Q6IGFybSxzbWMtbWJveA0KPiA+ICsNCj4gPiArICAiI21ib3gtY2VsbHMiOg0KPiA+ICsg
ICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgYXJtLG51bS1jaGFuczoNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOiBUaGUgbnVtYmVyIG9mIGNoYW5uZWxzIHN1cHBvcnRlZC4NCj4gPiArICAgIGl0ZW1z
Og0KPiA+ICsgICAgICBtaW5pbXVtOiAxDQo+ID4gKyAgICAgIG1heGltdW06IDQwOTYgIyBTaG91
bGQgYmUgZW5vdWdoPw0KPiA+ICsNCj4gPiArICBtZXRob2Q6DQo+ID4gKyAgICAtIGVudW06DQo+
ID4gKyAgICAgICAgLSBzbWMNCj4gPiArICAgICAgICAtIGh2Yw0KPiA+ICsNCj4gPiArICB0cmFu
c3BvcnRzOg0KPiA+ICsgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgIC0gbWVtDQo+ID4gKyAgICAg
ICAgLSByZWcNCj4gPiArDQo+ID4gKyAgYXJtLGZ1bmMtaWRzOg0KPiA+ICsgICAgZGVzY3JpcHRp
b246IHwNCj4gPiArICAgICAgQW4gYXJyYXkgb2YgMzItYml0IHZhbHVlcyBzcGVjaWZ5aW5nIHRo
ZSBmdW5jdGlvbiBJRHMgdXNlZCBieSBlYWNoDQo+ID4gKyAgICAgIG1haWxib3ggY2hhbm5lbC4g
VGhvc2UgZnVuY3Rpb24gSURzIGZvbGxvdyB0aGUgQVJNIFNNQyBjYWxsaW5nDQo+ID4gKyAgICAg
IGNvbnZlbnRpb24gc3RhbmRhcmQgWzFdLg0KPiA+ICsNCj4gPiArICAgICAgVGhlcmUgaXMgb25l
IGlkZW50aWZpZXIgcGVyIGNoYW5uZWwgYW5kIHRoZSBudW1iZXIgb2Ygc3VwcG9ydGVkDQo+ID4g
KyAgICAgIGNoYW5uZWxzIGlzIGRldGVybWluZWQgYnkgdGhlIGxlbmd0aCBvZiB0aGlzIGFycmF5
Lg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMy
LWFycmF5DQo+ID4gKyAgICBtaW5JdGVtczogMA0KPiA+ICsgICAgbWF4SXRlbXM6IDQwOTYgICAj
IFNob3VsZCBiZSBlbm91Z2g/DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtICIjbWJveC1jZWxscyINCj4gPiArICAtIGFybSxudW0tY2hhbnMNCj4g
PiArICAtIHRyYW5zcG9ydHMNCj4gPiArICAtIG1ldGhvZA0KPiA+ICsNCj4gPiArZXhhbXBsZXM6
DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzcmFtQDkxMDAwMCB7DQo+ID4gKyAgICAgIGNvbXBhdGli
bGUgPSAibW1pby1zcmFtIjsNCj4gPiArICAgICAgcmVnID0gPDB4MCAweDkzZjAwMCAweDAgMHgx
MDAwPjsNCj4gPiArICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICNzaXpl
LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICByYW5nZXMgPSA8MCAweDAgMHg5M2YwMDAgMHgxMDAw
PjsNCj4gPiArDQo+ID4gKyAgICAgIGNwdV9zY3BfbHByaTogc2NwLXNobWVtQDAgew0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNjbWktc2htZW0iOw0KPiA+ICsgICAgICAgIHJlZyA9
IDwweDAgMHgyMDA+Ow0KPiA+ICsgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgY3B1X3NjcF9o
cHJpOiBzY3Atc2htZW1AMjAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gImFybSxzY21p
LXNobWVtIjsNCj4gPiArICAgICAgICByZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiA+ICsgICAgICB9
Ow0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKyAgICBmaXJtd2FyZSB7DQo+ID4gKyAgICAgIHNt
Y19tYm94OiBtYWlsYm94IHsNCj4gPiArICAgICAgICAjbWJveC1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgICBjb21wYXRpYmxlID0gImFybSxzbWMtbWJveCI7DQo+ID4gKyAgICAgICAgbWV0aG9k
ID0gInNtYyI7DQo+ID4gKyAgICAgICAgYXJtLG51bS1jaGFucyA9IDwweDI+Ow0KPiA+ICsgICAg
ICAgIHRyYW5zcG9ydHMgPSAibWVtIjsNCj4gPiArICAgICAgICAvKiBPcHRpb25hbCAqLw0KPiA+
ICsgICAgICAgIGFybSxmdW5jLWlkcyA9IDwweGMyMDAwMGZlPiwgPDB4YzIwMDAwZmY+Ow0KPiA+
DQo+IFNNQy9IVkMgaXMgc3luY2hyb25vdXNseShibG9jaykgcnVubmluZyBpbiAic2VjdXJlIG1v
ZGUiLCBpLmUsIHRoZXJlIGNhbg0KPiBvbmx5IGJlIG9uZSBpbnN0YW5jZSBydW5uaW5nIHBsYXRm
b3JtIHdpZGUuIFJpZ2h0Pw0KDQpJIHRoaW5rIHRoZXJlIGNvdWxkIGJlIGNoYW5uZWwgZm9yIFRF
RSwgYW5kIGNoYW5uZWwgZm9yIExpbnV4Lg0KRm9yIHZpcnR1YWxpemF0aW9uIGNhc2UsIHRoZXJl
IGNvdWxkIGJlIGRlZGljYXRlZCBjaGFubmVsIGZvciBlYWNoIFZNLg0KDQogIFRoYXQgaW1wbGll
cyB0aGVyZSBpcyBvbmx5DQo+IG9uZSBwaHlzaWNhbCBjaGFubmVsIGluIHRoZSBwbGF0Zm9ybS4N
Cg0KSSBkb24ndCB0aGluayBzbywgVEVFL0xpbnV4IHNob3VsZCB1c2UgZGlmZmVyZW50IHBoeXNp
Y2FsIGNoYW5uZWxzLA0KaS5lLCBTUkFNIG1lbW9yeSBwYXJ0aXRpb25lZCB1c2luZyBUWkFTQy4N
Cg0KIFNvIGlmIHlvdSBuZWVkIHRvIGluaXRpYXRlIGRpZmZlcmVudA0KPiBmdW5jdGlvbnMgKHR4
LCByeCksIHlvdSBjYWxsIHRoZW0gc2VxdWVudGlhbGx5IGJ5IGNoYW5naW5nIHRoZSBmdW5jLWlk
IGZvciBlYWNoDQo+IHJlcXVlc3QuIFdoeSBub3Q/DQoNCkkgY291bGQgbm90IGZvbGxvdyB5b3Ug
Y2xlYXJseS4gQ291bGQgeW91IHBsZWFzZSBzaGFyZSBtb3JlIGRldGFpbHM/DQoNClRoYW5rcywN
ClBlbmcuDQo+IA0KPiAtSmFzc2kNCg==
