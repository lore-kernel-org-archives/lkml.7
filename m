Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C39C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E817220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="MJyhjfoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbfJPGjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:39:14 -0400
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:50913
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388357AbfJPGjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkVaNNcTwrC2m/jt0I8TAzbrnQLROIqv1S0et2c41MlKyZ9fnioWXVU+XHiKazuwmFQTHn9Cjqjw4pHJLKQepwHZqNya8axdQVYgNmxUPl0DmAAUePktSz4l8OS7yTzf0Kpo3UVnJyWlRVRV72xy2WnnXymEODyhQoOrEQ2hiVvDgLUfMXYwBnfSd4lPIaCx6P5E24feWc/wpX95gVUNFk+r81m6jT5p8WT6FgXDEDyzT0pQlRBr0IIkworDA5qjN98oGoEF/1S3mYplSENihNuyD62K/NGzzK09BTvEwgC65vBdtpsfRkCizVgJoNXmOhVJUiIBd9mOBVDYZf11sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Me+yI609mYsg9WbQZMBF7dnvMkdAfv5UnReQTytYA=;
 b=bd0Iqd1ig1PAlLEtiKDzqRKPSqzeoNH4Om70WnQs5i9msLuwXr5cmF55WhzRL1l88PgmpFTE6cbQr5Ez+mMQ4fw3lmJshyDDsZQziBmGFumb28ZC4c+2lPcNoT1TSV3oqYE1qQFYUa3j2sekznbhAB7DH2JHjIykZ7azADoZfLyElsSvl0a9JsREKiFALe2FvDkL5+WsT18xc2zdDcwhFtkXxcSDL4jw9ein8NpM5ewX9ovIwUG2pFajmh18DknnnshTNkLZeo9iaC6FKLrVvjGRE5A7O8nU2rS9hv2ks5J7rlmVyMbwWpTpG8GyLpUQoLq876aRs0gqkGIB32T7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Me+yI609mYsg9WbQZMBF7dnvMkdAfv5UnReQTytYA=;
 b=MJyhjfoExSClzNDXOXnd0SyWtkLU+iQHLtTpl5WsYYWGy8Jk6X58tlKY92W/nVPwGTYUFrCXnzwlZXpnt6px5SYv7+Id8bhP3V2+maUMC7Jb1MehwQbQURX5g8pubj0BjqwzkRlih0pEeO85NCgnTjbvMZ8K59ZvDVzJMXFC+v8=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB3447.jpnprd01.prod.outlook.com (20.178.98.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 06:39:10 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::dc33:9b1f:4522:550e]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::dc33:9b1f:4522:550e%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 06:39:10 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     maowenan <maowenan@huawei.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Thread-Topic: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Thread-Index: AQHVfkOKloVrfMGidkOyU5GyOdNjm6dcfByAgABfdUA=
Date:   Wed, 16 Oct 2019 06:39:09 +0000
Message-ID: <OSBPR01MB2103364C0A4E7150C10DC624B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <20191009014707.38716-1-maowenan@huawei.com>
 <ff1837bd-d6eb-a296-f7d9-f2988d5d2256@huawei.com>
In-Reply-To: <ff1837bd-d6eb-a296-f7d9-f2988d5d2256@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601c99b7-7fc7-4f94-e7f8-08d752038d1c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: OSBPR01MB3447:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB3447A7F919AF66294BBED2F6B8920@OSBPR01MB3447.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(11346002)(81156014)(8676002)(486006)(256004)(186003)(476003)(26005)(8936002)(66066001)(2501003)(86362001)(44832011)(66556008)(229853002)(66476007)(6436002)(64756008)(76116006)(66946007)(66446008)(74316002)(7736002)(305945005)(2201001)(81166006)(446003)(99286004)(966005)(478600001)(33656002)(9686003)(4326008)(102836004)(7696005)(6246003)(55016002)(6306002)(76176011)(14454004)(6506007)(25786009)(71200400001)(71190400001)(110136005)(2906002)(316002)(3846002)(54906003)(6116002)(5660300002)(52536014)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3447;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mr0ZQBk4L590AHlWyg75kp6To0Nc9U2mxn/zuklH2rHmBIzLHPz7Gc40DYVD1z4W3D0f1DJyityu40K4T6XwpdhQRV1mQxj+l+Bv4aq93MznFHzecUfSFU/FvYtsOnkAJPf+GwSV+/Z+dn/93fMwlD4bGxDKjbSt5Y7ORn87czgmCCvLce0Kj/QCRRFNwL6ORHfrLjVwwC8++iGNxxO5OeIuHYa1eH9VwlM0EUMSPbXIWofRsX7hlgwXewji6jSQ452USwG1GR8WFhADbyndrxt+aOHtxGwwBq3ssvzxytOuKe49DiB+jtugChANoJLNTj+cZethEktDBywA7cqk9zrN4o0KJ1Cen4J2dUBSBSDJg1V70YOGLWlMppHsZwpq/cVDX5SZKdhYLWZYwmn9h2C98G83wbNGhyImITwi20lKWx5axwLVdjnpAHDcUcHpJhSGFfkjMH47NwOEXFzGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601c99b7-7fc7-4f94-e7f8-08d752038d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 06:39:09.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwVw3/RzFvD1gm014ZEF3Eyj42YG4jzRpOtG+1HPv/PWNPsiIDMYvU2nVgFauHOi+kBOZhmvyXPZQCP8nihsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogVGhpcyBwYXRjaCBpcyBwcmVzZW50IGluIGJvdGggdXNiLW5leHQgYW5kIExpbnV4LW5leHQu
DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdr
aC91c2IuZ2l0L2NvbW1pdC8/aD11c2ItbmV4dCZpZD1kYTRiNWQxOGRkOTQ5YWJkZGE3YzhlYTc2
Yzk0ODNiNWVkZDQ5NjE2DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9oPW5leHQtMjAxOTEwMTYmaWQ9
ZGE0YjVkMThkZDk0OWFiZGRhN2M4ZWE3NmM5NDgzYjVlZGQ0OTYxNg0KDQpDaGVlcnMsDQpCaWp1
DQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIC1uZXh0XSB1c2I6IHR5cGVjOiBhZGQgZGVwZW5k
ZW5jeSBmb3INCj4gVFlQRUNfSEQzU1MzMjIwDQo+IA0KPiBraW5kbHkgcGluZy4NCj4gDQo+IE9u
IDIwMTkvMTAvOSA5OjQ3LCBNYW8gV2VuYW4gd3JvdGU6DQo+ID4gSWYgQ09ORklHX1RZUEVDX0hE
M1NTMzIyMD15LCBDT05GSUdfVVNCX1JPTEVfU1dJVENIPW0sIGJlbG93DQo+IGVycm9ycw0KPiA+
IGNhbiBiZSBmb3VuZDoNCj4gPiBkcml2ZXJzL3VzYi90eXBlYy9oZDNzczMyMjAubzogSW4gZnVu
Y3Rpb24gYGhkM3NzMzIyMF9yZW1vdmUnOg0KPiA+IGhkM3NzMzIyMC5jOigudGV4dCsweDY0KTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdXNiX3JvbGVfc3dpdGNoX3B1dCcNCj4gPiBkcml2ZXJz
L3VzYi90eXBlYy9oZDNzczMyMjAubzogSW4gZnVuY3Rpb24gYGhkM3NzMzIyMF9kcl9zZXQnOg0K
PiA+IGhkM3NzMzIyMC5jOigudGV4dCsweDE1NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4g
YHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZScNCj4gPiBkcml2ZXJzL3VzYi90eXBlYy9oZDNzczMy
MjAubzogSW4gZnVuY3Rpb24gYGhkM3NzMzIyMF9zZXRfcm9sZSc6DQo+ID4gaGQzc3MzMjIwLmM6
KC50ZXh0KzB4Mjk0KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgdXNiX3JvbGVfc3dpdGNo
X3NldF9yb2xlJw0KPiA+IGhkM3NzMzIyMC5jOigudGV4dCsweDJmNCk6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gYHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZScNCj4gPiBoZDNzczMyMjAuYzoo
LnRleHQrMHgzNDgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGB1c2Jfcm9sZV9zd2l0Y2hf
c2V0X3JvbGUnDQo+ID4gaGQzc3MzMjIwLmM6KC50ZXh0KzB4MzkwKTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0bw0KPiBgdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlJw0KPiA+IGRyaXZlcnMvdXNiL3R5
cGVjL2hkM3NzMzIyMC5vOiBJbiBmdW5jdGlvbiBgaGQzc3MzMjIwX3Byb2JlJzoNCj4gPiBoZDNz
czMyMjAuYzooLnRleHQrMHg1ZTgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGBmd25vZGVf
dXNiX3JvbGVfc3dpdGNoX2dldCcNCj4gPiBoZDNzczMyMjAuYzooLnRleHQrMHg4YTQpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGB1c2Jfcm9sZV9zd2l0Y2hfcHV0Jw0KPiA+IG1ha2U6ICoqKiBb
dm1saW51eF0gRXJyb3IgMQ0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGQgZGVwZW5kZW5jeSBVU0Jf
Uk9MRV9TV0lUQ0ggZm9yIFRZUEVDX0hEM1NTMzIyMC4NCj4gPg0KPiA+IEZpeGVzOiAxYzQ4Yzc1
OWVmNGIgKCJ1c2I6IHR5cGVjOiBkcml2ZXIgZm9yIFRJIEhEM1NTMzIyMCBVU0IgVHlwZS1DDQo+
ID4gRFJQIHBvcnQgY29udHJvbGxlciIpDQo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1
bGtjaUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbyBXZW5hbiA8bWFvd2VuYW5A
aHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvdHlwZWMvS2NvbmZpZyB8IDEg
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi90eXBlYy9LY29uZmlnIGIvZHJpdmVycy91c2IvdHlwZWMvS2NvbmZp
Zw0KPiA+IGluZGV4IGFjZWIyYWYuLmI0ZjJhYWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91
c2IvdHlwZWMvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL3R5cGVjL0tjb25maWcNCj4g
PiBAQCAtNTMsNiArNTMsNyBAQCBzb3VyY2UgImRyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvS2NvbmZp
ZyINCj4gPiAgY29uZmlnIFRZUEVDX0hEM1NTMzIyMA0KPiA+ICAJdHJpc3RhdGUgIlRJIEhEM1NT
MzIyMCBUeXBlLUMgRFJQIFBvcnQgY29udHJvbGxlciBkcml2ZXIiDQo+ID4gIAlkZXBlbmRzIG9u
IEkyQw0KPiA+ICsJZGVwZW5kcyBvbiBVU0JfUk9MRV9TV0lUQ0gNCj4gPiAgCWhlbHANCj4gPiAg
CSAgU2F5IFkgb3IgTSBoZXJlIGlmIHlvdXIgc3lzdGVtIGhhcyBUSSBIRDNTUzMyMjAgVHlwZS1D
IERSUCBQb3J0DQo+ID4gIAkgIGNvbnRyb2xsZXIgZHJpdmVyLg0KPiA+DQoNCg==
