Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F85C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F28620644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pM+0cL8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHPGCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:02:12 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:40976
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfHPGCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awckU95ee7rssFaCmja4Qb7JDHVSON5W9xl8ko/SW+YtS8G72wRcQKKHQD36l2dJ6bBlM8tNYMz5nHXxWn8NYCcTnfH8Q7OlxBlqZ+veMiovKjNsnjah8uy7gEUdvGfi/2v/miEMzstZJcEtBBSQKzh8TU41Av8bt4TrDKURXgNRb8gnZN/nYNnj2q7AVgjTuDkXfyuOlIcH4MQpiYEd/d09j+SHiDu20p8KqjUcLSG1PoK79NhjN3gL3rlUQqelAHDX/UzqylYlW8f+8GNtiPxzAt05MpA0QHT530+t0VJNR6uLyIQHp/DUGJu87iW/AqWto7Pkbt5gqmE+WNBYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDW38T5XB9YeLwCC6zjK0UPt4bTpoSnNYTHy+Acjn+Q=;
 b=DHtKuT03VjusbJ7o5x3iEhpw91OwOhn5xNyUjOTD5iAaNkGLG/CWSjwduM6/npyBwq2J/zaBB4/IssvIcyy1z40iqk0ij1dqAbMHOsRh5+34QmdNdtjQQkIMlCNM3Rnqe/tra0oWAavJbvuQi0i0Lpdim3RE/2prexJ+tBFTXslCE3uS4TxJ+nDYzb8mIEkdYTEQKWA/0tM5j9mKATl6Iahh4atZ3SaqyoQ1/c0Xxv+sayybW2bcd4RziAD9Ksw6z42p1VlxAbTUZBOMNKLY9LNNyRzbUxszLRx08rSBNw4t1h5qRe0oAun2kXxD5tAYJnRgPvAXJChG33wmD7XgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDW38T5XB9YeLwCC6zjK0UPt4bTpoSnNYTHy+Acjn+Q=;
 b=pM+0cL8FLBWNy4q0eyzQyrfDFJsQfMgomKUjP1CYN2Jn9a/Z62pCM39MY/RtXfN919qW1qGU3iKdN2alnGi1nve21jqqgsY9UPPTkRA/KsxC+JXNce+DBk/AWoOsnTMQlovX1kJCoeO+7O/NBVoB8RhBmCrzWR5HkjZBIrOH6gQ=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4544.eurprd04.prod.outlook.com (20.177.55.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 16 Aug 2019 06:02:07 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::58ad:cc43:f1f8:83ba]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::58ad:cc43:f1f8:83ba%6]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 06:02:07 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
Thread-Topic: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
Thread-Index: AQHVMa+LZwaZ/eUvGU2ZLn56tXnH7ab9Gp+AgABxEwA=
Date:   Fri, 16 Aug 2019 06:02:07 +0000
Message-ID: <VI1PR04MB5134343A13244638431C3975ECAF0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
 <1562165800-30721-2-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNQDRhocXmpA08rEBqpFBrm1ub9z3+r74GNcMs6bqUL8OA@mail.gmail.com>
In-Reply-To: <CADRPPNQDRhocXmpA08rEBqpFBrm1ub9z3+r74GNcMs6bqUL8OA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [77.71.121.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adb0d271-e8e1-421f-62be-08d7220f44f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4544;
x-ms-traffictypediagnostic: VI1PR04MB4544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4544449CE01AD336DB3557E5ECAF0@VI1PR04MB4544.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:256;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(13464003)(110136005)(74316002)(54906003)(11346002)(53546011)(81156014)(66946007)(6246003)(76116006)(33656002)(64756008)(66476007)(229853002)(66446008)(66556008)(9686003)(2906002)(44832011)(5660300002)(6436002)(316002)(476003)(486006)(71190400001)(6636002)(6506007)(8676002)(71200400001)(256004)(14454004)(186003)(14444005)(7696005)(478600001)(446003)(76176011)(26005)(81166006)(55016002)(305945005)(53936002)(86362001)(25786009)(102836004)(66066001)(7736002)(4326008)(8936002)(6116002)(52536014)(3846002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4544;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3dxrXXuEUdhJAQysXFSSWk5newl9jOP4Gc0oc33go8Cr5ije8iuBMvoyyI+u61wsSKqAThLMpofJxW5DTNczeXyuj9RrapPatqYv9lBWsG01WP6prUULZXQoGAYTYIcqdi/gUnW/K3UDgpowPCx5sTzR/InSiOzY+0XcHt9PW4cU0XFiXfKXOve0r0Qv0k9CQhesxy9zT/pX8iH6N2P24ZLQd1J8hELEhZrdWHEOPTaLixNtdFaTM7O0hLcfh6tK+L23FgXfDJyLMAvsOxVzVq1YqrW5YcV96+q9ThEOt5K1/xiPS9oI7mIfGV5L4ldihbwIwL9WW1ZDIj0Ye5IszgtS7JCUGn4n/5ls4B0qQpF9e8xmtUJ/3NTC3QkSZRUtKeJXxX2g7oG4sXGI/tZ2pgo4PxmOT0ruVaSepTGNWUQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb0d271-e8e1-421f-62be-08d7220f44f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 06:02:07.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJVYZF16UGVXUIEVd1kzjopAdqmhXuuIc6oJT2G1okz2KOAsHWynV7PVuqG/bjyD+oySmZ0dAK7n40CtrjxRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpIFlhbmcg
PGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMTkgMjox
MyBBTQ0KPiBUbzogSW9hbmEgQ2lvcm5laSA8aW9hbmEuY2lvcm5laUBueHAuY29tPg0KPiBDYzog
TGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT47IFJveSBQbGVkZ2UNCj4g
PHJveS5wbGVkZ2VAbnhwLmNvbT47IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBidXM6IGZzbC1tYzogcmVtb3ZlIGV4cGxpY2l0
IGRldmljZV9saW5rX2RlbA0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBXZWQsIEp1bCAz
LCAyMDE5IGF0IDk6NTggQU0gSW9hbmEgQ2lvcm5laSA8aW9hbmEuY2lvcm5laUBueHAuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFN0YXJ0aW5nIHdpdGggY29tbWl0IDcyMTc1ZDRlYTRjNCAoImRyaXZl
ciBjb3JlOiBNYWtlIGRyaXZlciBjb3JlIG93bg0KPiA+IHN0YXRlZnVsIGRldmljZSBsaW5rcyIp
IHN0YXRlZnVsIGRldmljZSBsaW5rcyBhcmUgb3duZWQgYnkgdGhlIGRyaXZlcg0KPiA+IGNvcmUg
YW5kIHNob3VsZCBub3QgYmUgZXhwbGljaXRseSByZW1vdmVkIG9uIGRldmljZSB1bmJpbmQuIERl
bGV0ZSBhbGwNCj4gPiBkZXZpY2VfbGlua19kZWwgYXBwZWFyYW5jZXMgZnJvbSB0aGUgZnNsLW1j
IGJ1cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElvYW5hIENpb3JuZWkgPGlvYW5hLmNpb3Ju
ZWlAbnhwLmNvbT4NCj4gDQo+IEhpIExhdXJlbnRpdSwNCj4gDQo+IFdoYXQgZG8geW91IHRoaW5r
IG9mIHRoaXMgcGF0Y2hlcz8gIEkgY2FuIHRha2UgaXQgdGhyb3VnaCBmc2wvc29jIGlmDQo+IHlv
dSBjYW4gQUNLIGl0Lg0KDQpMb29rcyBnb29kIHRvIG1lLCBzbyBmb3IgdGhlIHdob2xlIHNlcmll
czoNCg0KQWNrZWQtQnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+
DQoNCj4gUmVnYXJkcywNCj4gTGVvDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2J1cy9mc2wt
bWMvZnNsLW1jLWFsbG9jYXRvci5jIHwgMSAtDQo+ID4gIGRyaXZlcnMvYnVzL2ZzbC1tYy9tYy1p
by5jICAgICAgICAgICAgfCAxIC0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYWxsb2Nh
dG9yLmMgYi9kcml2ZXJzL2J1cy9mc2wtDQo+IG1jL2ZzbC1tYy1hbGxvY2F0b3IuYw0KPiA+IGlu
ZGV4IDhhZDc3MjQ2ZjMyMi4uY2M3YmI5MDBmNTI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
YnVzL2ZzbC1tYy9mc2wtbWMtYWxsb2NhdG9yLmMNCj4gPiArKysgYi9kcml2ZXJzL2J1cy9mc2wt
bWMvZnNsLW1jLWFsbG9jYXRvci5jDQo+ID4gQEAgLTMzMCw3ICszMzAsNiBAQCB2b2lkIGZzbF9t
Y19vYmplY3RfZnJlZShzdHJ1Y3QgZnNsX21jX2RldmljZQ0KPiAqbWNfYWRldikNCj4gPg0KPiA+
ICAgICAgICAgZnNsX21jX3Jlc291cmNlX2ZyZWUocmVzb3VyY2UpOw0KPiA+DQo+ID4gLSAgICAg
ICBkZXZpY2VfbGlua19kZWwobWNfYWRldi0+Y29uc3VtZXJfbGluayk7DQo+ID4gICAgICAgICBt
Y19hZGV2LT5jb25zdW1lcl9saW5rID0gTlVMTDsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
X0dQTChmc2xfbWNfb2JqZWN0X2ZyZWUpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9m
c2wtbWMvbWMtaW8uYyBiL2RyaXZlcnMvYnVzL2ZzbC1tYy9tYy1pby5jDQo+ID4gaW5kZXggM2Fl
NTc0YTU4Y2NlLi5kOTYyOWZjMTNhMTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9idXMvZnNs
LW1jL21jLWlvLmMNCj4gPiArKysgYi9kcml2ZXJzL2J1cy9mc2wtbWMvbWMtaW8uYw0KPiA+IEBA
IC0yNTUsNyArMjU1LDYgQEAgdm9pZCBmc2xfbWNfcG9ydGFsX2ZyZWUoc3RydWN0IGZzbF9tY19p
byAqbWNfaW8pDQo+ID4gICAgICAgICBmc2xfZGVzdHJveV9tY19pbyhtY19pbyk7DQo+ID4gICAg
ICAgICBmc2xfbWNfcmVzb3VyY2VfZnJlZShyZXNvdXJjZSk7DQo+ID4NCj4gPiAtICAgICAgIGRl
dmljZV9saW5rX2RlbChkcG1jcF9kZXYtPmNvbnN1bWVyX2xpbmspOw0KPiA+ICAgICAgICAgZHBt
Y3BfZGV2LT5jb25zdW1lcl9saW5rID0gTlVMTDsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
X0dQTChmc2xfbWNfcG9ydGFsX2ZyZWUpOw0KPiA+IC0tDQo+ID4gMS45LjENCj4gPg0K
