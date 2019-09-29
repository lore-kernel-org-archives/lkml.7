Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A2CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C73214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RX2e/mgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfI2CfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:35:10 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:33942
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728802AbfI2CfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIVSmjWO3jfNLcjRfunXiAv5kocMKP8VEWwuuCbqr/uzeLpruCiS3nzfeNfw8nLGjQQXAMaLdBJ1Kt7Z2Elio/RVumyMRqbPy+hBYsYibgbbvnZaQ+I50rRDKFhFMLX3EX6GCPdnJQiaSCdD4uDCpy/G+ttmdJdifBF7rd5+q4jedztedrZX4lfrOBqOVGjporNj3Kqax8jyotQZ5PPXE4DdYwzuGsIu7QcUCEv1H5mB2fBH1H/blu307bi887Fo0laZTCLVo8HYEs8w2rRP/S2nbJ56AdzG9puLiw3flhxbvA1A0B2hxwWsScAMsoC8/hwh+t1u4MhOyL17viMcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXHJwvN3Q2L4ia7NVAyC0itDCDoKuEnIOGcPG3qGzvM=;
 b=RPMAZE/j0CM6vz5EF2E7YarSWHZmbuiYDJgu3Cfy850r3w0GJyG085T0Ru7nptQTMgixgyGSEJCukWFbngagqUJs7UBvUeUaHWbcrJcvnXvYW2fGwNGRI1ZhsrDiRgQBSQ49qppdX56/y27MNi9nFZFrmh9Cf6I5Up/xA5OJcOG8qmAMwtKwY+b6P1TJcuiC48FdWyODsYKESrAB590fwwIsTPSsgL0DAMd78wM5DjLzhR80FAt+1aCWlfdhHMXNKSDiBFS1wmxAzzhHHyaALnjQDjnoBqPfK8jMr9D93jISzP8Kv/tClI5vfrxPKylyB8RtNivc2wUvACeuvLg9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXHJwvN3Q2L4ia7NVAyC0itDCDoKuEnIOGcPG3qGzvM=;
 b=RX2e/mgGvqhzN50QJaV+hRFWlWIOm0meYOiy3Muuw5wpDcGcUKFMjQaMV0ZgXojYrBIYnI8btrTFeTSl90eN55klFycGO1hNGGZDUhp8FEOtjzQw4Hc2hJ/my1AZS7j7T44ZYq2kt6HnSuVcth+hBK5sdg1TQYUH/4QjE5Mksl4=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB6876.eurprd04.prod.outlook.com (52.133.241.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Sun, 29 Sep 2019 02:35:05 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::3d0b:c71f:fa1a:e856%2]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 02:35:05 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Topic: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Index: AQHVcfycJPrHn/IcK0qf/xic1GWPZ6c5GiAAgAEI5+CABaVFgIACLFEQ
Date:   Sun, 29 Sep 2019 02:35:05 +0000
Message-ID: <DB8PR04MB6826763082AF84812426CC53F1830@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aa78707-7a20-4ef3-49bf-08d74485a34d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB8PR04MB6876:
x-microsoft-antispam-prvs: <DB8PR04MB68763C571BC388EDD342AA8AF1830@DB8PR04MB6876.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(102836004)(5660300002)(3846002)(6116002)(54906003)(99286004)(4326008)(229853002)(55016002)(2906002)(9686003)(7696005)(52536014)(6506007)(53546011)(186003)(33656002)(66066001)(76176011)(6436002)(76116006)(6916009)(8936002)(66476007)(66446008)(66946007)(66556008)(64756008)(86362001)(256004)(71200400001)(81166006)(8676002)(5024004)(6246003)(14444005)(305945005)(14454004)(316002)(11346002)(2171002)(81156014)(74316002)(71190400001)(478600001)(486006)(7736002)(25786009)(446003)(476003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6876;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psl0TX/iIkrl+YT/v/wooDhaNR1TmiqUC+6OFE5Phxor6sGYmF1KTc1+6zT2E22i5CUylrQipmEMIpWixjKIBkyPkaLTPKML64okABDC6lO4p5Pv3eK5h2nvw6ROZSm3VmPWuBvBy6kPAXSS3I0T6xIt8KWRxaaAnahZvcRBWjiXraAi2YSi0PjLCnC5Ga4jDN1FGyRdjpUN2nzQ1w8HFjlTsQrknIutqbSaVhlessyaeAt+oUfE7P4BEx4vJbk0tmQSVFflScW53cFYgdDARKQuE7NsIuYd6wHjNrGya4XdU1v23ZS5LJ1mnvN3DfweNYe+SBvbWAFhizuR4Hf1f6SwKnGN03xB0vuZ7tQLA24iyVJOI2/eyDArMHqvYGua3c5Fwzbh+iSkTQlS+fMzemCh78Gabe/T0hJXWV4Nlbo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa78707-7a20-4ef3-49bf-08d74485a34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 02:35:05.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xHdDjJ4IaengG9Dkkrtk/1RrBSNI2QYs+U2FHqYnKrWMGSjiTaSBYzsAedbf2842WylyhWzrkOVOpD+iSip7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KT24gU2F0dXJkYXksIFNlcHRlbWJlciAyOCwgMjAxOSAwMTowOCwgQWxhbiBT
dGVybiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjQgU2VwIDIwMTksIFJhbiBXYW5nIHdyb3RlOg0K
PiANCj4gPiBIaSBHcmVnLA0KPiA+DQo+ID4gT24gTW9uZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMTkg
MTk6MDcsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBNb24sIFNl
cCAyMywgMjAxOSBhdCAwNjo1MTowMlBNICswODAwLCBSYW4gV2FuZyB3cm90ZToNCj4gPiA+ID4g
VVNCIDIuMCBFbWJlZGRlZCBIb3N0IFBFVCBBdXRvbWF0ZWQgVGVzdCAoQ0g2KSA2LjcuMjMgQS1V
VVQNCj4gPiA+ID4gIlVuc3VwcG9ydGVkIERldmljZSIgTWVzc2FnZSByZXF1aXJlIHRvIHN0b3Ag
ZW51bWVyYXRpbmcgZGV2aWNlDQo+ID4gPiA+IHdpdGggVklEPTB4MWEwYSBQSUQ9MHgwMjAxIGFu
ZCBwb3AgbWVzc2FnZSB0byBkZWNsYXJlIHRoaXMgZGV2aWNlDQo+ID4gPiA+IGlzIG5vdA0KPiA+
ID4gc3VwcG9ydGVkLg0KPiA+ID4NCj4gPiA+IFdoeSBpcyB0aGlzIGEgcmVxdWlyZW1lbnQ/DQo+
ID4NCj4gPiBUaGlzIGNvbWVzIGZyb20gPFVTQiBPbi1UaGUtR28gYW5kIEVtYmVkZGVkIEhvc3Qg
QXV0b21hdGVkIENvbXBsaWFuY2UNCj4gPiBQbGFuIGZvciB0aGUgT24tVGhlLUdvJiBFbWJlZGRl
ZCBIb3N0IFN1cHBsZW1lbnQgUmV2aXNpb24yLjA+DQo+IA0KPiBIb3cgbXVjaCBkbyB3ZSBjYXJl
IGFib3V0IG91ciBzdXBwb3J0IGZvciBVU0IgT1RHPyAgSXNuJ3QgaXQgZHlpbmcgb2ZmPw0KDQpB
cyBJIGtub3csIHNvbWUgdmVuZG9ycyBzdGlsbCB3YW50IHRvIHBhc3MgdGhpcyBFbWJlZGRlZCBI
b3N0IGNvbXBsaWFuY2UgdGVzdA0KdG8gbWFrZSBzdXJlIHRoZWlyIHByb2R1Y3QncyBxdWFsaXR5
LiBBbmQgYWJvdmUgdGVzdCBjYXNlIGlzIGluY2x1ZGVkLg0KDQo+ID4gQmVsb3cgaXMgcmVsYXRl
ZCBkZXNjcmlwdGlvbiBJIHF1b3RlIGZyb20gaXQ6DQo+ID4gNi43LjIzIEEtVVVUICJVbnN1cHBv
cnRlZCBEZXZpY2UiIE1lc3NhZ2UNCj4gPiBQdXJwb3NlOiBUaGlzIHRlc3QgdmVyaWZpZXMgdGhh
dCBhbiBBLVVVVCBwcm9kdWNlcyBhIGRldmljZSBub24tc3VwcG9ydGVkDQo+IGVycm9yIG1lc3Nh
Z2UNCj4gPiAJd2hlbiBhIGRldmljZSBpdCBkb2Vzbid0IHJlY29nbml6ZSwgYW5kIGRvZXMgbm90
IHN1cHBvcnQgSE5QLCBjb25uZWN0cw0KPiB0byBpdC4NCj4gPiBBcHBsaWVzIHRvOiBBbGwgVGFy
Z2V0ZWQgSG9zdHMNCj4gPiBEZXNjcmlwdGlvbjogR2V0IFZCVVMgdHVybmVkIG9uLCBhbmQgY29u
bmVjdCB0byB0aGUgQS1VVVQuIEdldCBlbnVtZXJhdGVkDQo+IGFuZCByZXNwb25kDQo+ID4gCWFz
IGFuIHVua25vd24gZGV2aWNlIG5vdCBzdXBwb3J0aW5nIEhOUC4gQ2hlY2sgdGhhdCBhIHN1aXRh
YmxlIGVycm9yDQo+IG1lc3NhZ2UgaXMgZ2VuZXJhdGVkLg0KPiA+IFBhc3MgQ3JpdGVyaWE6IE1l
c3NhZ2UgIlVuc3VwcG9ydGVkIERldmljZSJvciBzaW1pbGFyIGlzIGRpc3BsYXllZCBvbg0KPiA+
IFVVVA0KPiA+DQo+ID4gNi43LjIzLjEgVGVzdCBQcm9jZWR1cmUNCj4gPiAxLiBTdGFydCB3aXRo
IGNhYmxlIHN0aWxsIGF0dGFjaGVkLCBQRVQgYXBwbHlpbmcgMTAgRiBjYXBhY2l0YW5jZSBhbmQg
MTBrICBwdWxsLQ0KPiBkb3duDQo+ID4gICAgIHJlc2lzdGFuY2UgYmV0d2VlbiBWQlVTIGFuZCBn
cm91bmQsIGRhdGEgbGluZXMgbm90IHB1bGxlZCB1cC4NCj4gPiAyLiBHZXQgVkJVUyB0dXJuZWQg
b24sIHVzaW5nIHRoZSBtZXRob2QgZGVzY3JpYmVkIGluIFNlY3Rpb242LjcuMS4NCj4gPiAzLiBX
YWl0IGZvciBhbG1vc3QgVEJfU1ZMRF9CQ09OIG1heCAoMXMgLSAwLjFzID0gMC45cykgZnJvbSBW
QlVTIHJlYWNoaW5nDQo+IFZPVEdfU0VTU19WTEQgbWF4Lg0KPiA+IDQuIENvbm5lY3QgUEVUIHVz
aW5nIEQrIHB1bGwtdXAuDQo+ID4gNS4gQWxsb3cgQS1VVVQgdG8gZW51bWVyYXRlIFBFVCwgcmVz
cG9uZGluZyB3aXRoIGEgVklEIC8gUElEIGNvbWJpbmF0aW9uDQo+IG5vdCBvbiB0aGUgVFBMDQo+
ID4gICAgIG9mIHRoZSBVVVQgYW5kIGFsc28gd2l0aCB0aGUgT1RHIGRlc2NyaXB0b3Igc3RhdGlu
ZyB0aGF0IGl0IGRvZXMgbm90IHN1cHBvcnQNCj4gSE5QLg0KPiA+IDYuIFN0YXJ0IDMwcyB0aW1l
ciB3aGVuIERldmljZSBEZXNjcmlwdG9yIGlzIHJlYWQuDQo+ID4gNy4gRGlzcGxheSBNZXNzYWdl
ICJDbGljayBPSyBpZiAnVW5zdXBwb3J0ZWQgRGV2aWNlJyBpbmRpY2F0aW9uIGRpc3BsYXllZCBv
bg0KPiBVVVQiLg0KPiA+IDguIElmIG9wZXJhdG9yIGNsaWNrcyBPSyBiZWZvcmUgMzBzIHRpbWVy
IGV4cGlyZXMsIHRoZW4gVVVUIHBhc3NlcyB0ZXN0Lg0KPiA+IDkuIElmIDMwc2VsYXBzZXMgZmly
c3QsIHRoZW4gVVVUIGZhaWxzIHRlc3QuDQo+ID4gMTAuIFBFVCBkaXNjb25uZWN0cyBieSByZW1v
dmluZyBhbnkgdGVybWluYXRpb24gb24gdGhlIGRhdGEgbGluZXMsIGJ1dCBsZWF2ZXMNCj4gYSBj
YXBhY2l0YW5jZSBvZg0KPiA+ICAgICAxMCBGIGFuZCBhIHB1bGwtZG93biByZXNpc3RhbmNlIG9m
IDEwayAgY29ubmVjdGVkIGFjcm9zcyBWQlVTLg0KPiA+IDExLiBXYWl0IDJzIHRvIGFsbG93IGRp
c2Nvbm5lY3Rpb24gdG8gYmUgZGV0ZWN0ZWQuDQo+ID4gRW5kIG9mIFRlc3QuDQo+IA0KPiBJbiBm
YWN0LCB0aGUgc3lzdGVtIHNob3VsZCByZXNwb25kIHRoZSBzYW1lIHdheSB0byBhbnkgdW5yZWNv
Z25pemVkIGRldmljZQ0KPiB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBITlAsIHJpZ2h0PyAgVGhlcmUn
cyBub3RoaW5nIHNwZWNpYWwgYWJvdXQgdGhlc2UgVklEL1BJRA0KPiB2YWx1ZXMuDQoNClllcywg
YnV0IEkgc2F3IHRoZXJlIGFyZSBhbHJlYWR5IHNvbWUgaW1wbGVtZW50YXRpb24gaW4gdXBzdHJl
YW0ga2VybmVsIGZvciB0aGlzIHB1cnBvc2UsDQpqdXN0IFBJRCBkaWZmZXJlbnQ6IGRyaXZlcnMv
dXNiL2NvcmUvb3RnX3doaXRlbGlzdC5oIGZ1bmN0aW9uIGlzX3RhcmdldGVkKCkNCg0KPiA+ID4g
QW5kIHdoeSB0aG9zZSBzcGVjaWZpYyB2aWQvcGlkIHZhbHVlcz8gIFdoYXQgZG8gdGhleSByZWZl
ciB0bz8NCj4gPg0KPiA+IEZvciBzdGVwIDUsIHdlIGdvdCB0aGUgVklEIC8gUElEIG51bWJlciBm
cm9tIFVTQiBJRiBjZXJ0aWZpZWQNCj4gPiBsYWIoQWxsaW9uLmluYyBhdCBUYWl3YW5nKS4gTG9v
a3MgbGlrZSB0aGlzIGlzIGEgcmVzZXJ2ZWQgSUQgcGFpciBhbmQNCj4gPiB3aWxsIG5vdCBiZSBh
bGxvY2F0ZWQgdG8gYW55IHZlbmRvciBmb3IgdGhlaXIgcHJvZHVjdHMuIFNvIGl0J3MgaGVuY2Ug
dXNlZCBmb3INCj4gdGhpcyBjYXNlIHRlc3QgKGxpa2Ugc2F5aW5nOiB5b3Ugc2hvdWxkIGJlIGFi
bGUgdG8gcG9wIGEgbm90LXN1cHBvcnQgbWVzc2FnZSBmb3INCj4gdGhpcyByZXNlcnZlZCBWSUQm
UElEKS4NCj4gDQo+IERvbid0IHdlIGRvIHRoaXMgYWxyZWFkeT8NCg0KWWVzLCBidXQgaW4gZnVu
Y3Rpb24gaXNfc3RhcmdldGVkKCksIEkgZm91bmQgaXQncyBhIGxpdHRsZSBiZSBkaWZmZXJlbnQ6
DQpDdXJyZW50IHVwc3RyZWFtOiAgICAgICAgICAgICAgICAgICAgIFZJRCA9IDB4MWEwYSwgUElE
ID0gMHgwMjAwDQpJbmZvIGZyb20gVVNCLUlGIGNlcnRpZmllZCBsYWI6IFZJRCA9IDB4MWEwYSwg
UElEID0gMHgwMjAxDQoNClJlZ2FyZHMsDQpSYW4NCg0KPiBBbGFuIFN0ZXJuDQoNCg==
