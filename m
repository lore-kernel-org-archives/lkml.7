Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F1AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EF920989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="yCVXMLJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfHSJDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:03:45 -0400
Received: from mail-eopbgr740078.outbound.protection.outlook.com ([40.107.74.78]:23296
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfHSJDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPCs+T9otYQFGUVoqmQqZNAD3jvjlc8zVE4B8EBYNooIEu5cUeMBnbKqFVwWLtyB/c7z3gFK9n5VuA/caImh37ROFSMvBgGZG7EgkM36HM7u9mgwZ6+N+BoHcTUraJsDrmxLcmAdSJEjb+o9BDpBPEeI43k9ASAvZdRkV4mCLdEj4gxLl0NiMbOmzoCe4ay/3Rx8qUz+oAMA0o5LSRGy1QCvtnrfNmZRx9xKzrIR/YxRaBSXmtrVWiEG7KdGnAGTzy0VdNbOD32CfHmgsuxpQyKw2+VXUEgrs02G344kqt6PjiaANO7bFd2ZhponCWhrcS7fsZVYLN5PNagd/slRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1Ft4Zy0iBMIVFI5orXrXYoh/Lr/0l+bONqa0HC4NbA=;
 b=TsMWxl1clYrAWOPokUQOAbMXk6mjxWt6YllvWUmPGeeE9PazYz3V3tiREKh6dKIgl7IKPgkJlPZwuCWR5xCbTygYxMbv5U8gOp+KwwECWaLFHQqD7ury19jGleQUbEVbJhjNgXVEfGrAbxZg4caa6bsAw58MAqUHcPnNdRwqOdYfqEXt5C8mURIpZc+omdNzhzp/1RPEwSgiTesWQIGk8hvNkDVQmsVkXsMWyc3kJfuAxzQNb1hy0itsqsIVqTwfdZ4vHNMMAmxYsoLHn9ADpp684xBys4IXIq19qokC7WdsVH9CpWE2WWDwQAPHrxJl6vt49i9OCYfXnA3m6bQX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1Ft4Zy0iBMIVFI5orXrXYoh/Lr/0l+bONqa0HC4NbA=;
 b=yCVXMLJuHH9jON4ZTz1i9YQlJa1B0bbl34slDlM0KDyvsDmpxZi1T3fddvxiGFo0XUTHzbVYKtxKTQGLwhurKFoMHC+nyUP5MNq/xP5yrT1tpk1g86qkGxPMSPiL5PBTL5u1jy4KDSz/vrRdeVNazWJvEKa3LZtrDrljoZdwf4o=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB6272.namprd08.prod.outlook.com (52.132.169.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 09:03:38 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252%6]) with mapi id 15.20.2178.016; Mon, 19 Aug 2019
 09:03:38 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: RE: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Thread-Topic: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Thread-Index: AQHVTQd5zjmLJBbahk2JUzVOEzo15qcCPhuw
Date:   Mon, 19 Aug 2019 09:03:38 +0000
Message-ID: <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-7-sshivamurthy@micron.com>
 <20190807120408.031b8d1b@xps13>
In-Reply-To: <20190807120408.031b8d1b@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.80.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17fce51f-d931-4779-9530-08d724841fcd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB6272;
x-ms-traffictypediagnostic: MN2PR08MB6272:|MN2PR08MB6272:|MN2PR08MB6272:
x-microsoft-antispam-prvs: <MN2PR08MB62727F0D2091E534CB1F69D6B8A80@MN2PR08MB6272.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(2906002)(86362001)(52536014)(7736002)(7416002)(66446008)(8936002)(55016002)(66574012)(66946007)(64756008)(66476007)(6916009)(316002)(6436002)(66556008)(54906003)(81156014)(229853002)(8676002)(81166006)(6506007)(55236004)(102836004)(71200400001)(446003)(66066001)(476003)(5660300002)(9686003)(6116002)(71190400001)(3846002)(25786009)(99286004)(74316002)(76116006)(53936002)(76176011)(305945005)(6246003)(256004)(14444005)(186003)(478600001)(11346002)(26005)(486006)(7696005)(33656002)(4326008)(14454004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6272;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VFB+CHo5U39WBVZ2dzfRmqFFWNDE4qNzmQS5JOqr8YC3xgjDPYcz3wiNebXYBh5TIl/vFv5I9a6PBCvkuefv4WM0Usc/UTb2qX4RgSgHrAonWurOZf78413jTg1BwHlkPsKYxXP/T7M8LsI4BBlq/yim6KyoKn9fMY02UDofdksfos3ORNK9jLTv+tEKJ0JQCb09DqqdHbzidcYQGiJQgDcmdMJrAGR3Y0c1S+xTrTs+4LFPvQGu+jQfmf25Lap+mx7IfN2J/X24KWrt3OWxnNpHkNQglNq5QjNR4YaFD+jXXuheFOZv+tpM80HMNQpaw/f/RQL1i/BYN0BQu651fPBA2ZcJLitsB1L1gd/y66lhd7ksWgpEgAqCqSU0eb3nQGWYj4U5Z1DfWfJVsJoWM6qmkNi02nqYugUfWREzKWU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fce51f-d931-4779-9530-08d724841fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:03:38.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oIiyCpELHGGQ19B7tGaeE303bIG282SLK59obylBv0ztWPCC3m0L3611AlbXnF/MXTAXxsgqCO7Fi+EZ8ddTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IA0KPiBIaSBTaGl2YSwNCj4gDQo+IHNoaXZhLmxpbnV4d29ya3NAZ21h
aWwuY29tIHdyb3RlIG9uIE1vbiwgMjIgSnVsIDIwMTkgMDc6NTY6MTkgKzAyMDA6DQo+IA0KPiA+
IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+
DQo+IA0KPiBJIGFtIG5vdCBzdXJlIHRoZSAidHVybiBpbXBsZW1lbmF0YXRpb24gZ2VuZXJpYyIg
dGl0bGUgZGVzY3JpYmVzIHdoYXQNCj4geW91IGRvLg0KPiANCj4gPiBEcml2ZXIgaXMgcmVkZXNp
Z25lZCB1c2luZyBwYXJhbWV0ZXIgcGFnZSB0byBzdXBwb3J0IE1pY3JvbiBTUEkgTkFORA0KPiA+
IGZsYXNoZXMuDQo+IA0KPiBSZWRlc2lnbmVkIGlzIHBlcmhhcHMgYSBiaXQgdG9vIG11Y2guDQo+
IA0KPiAiDQo+ID4gVGhlIHJlYXNvbiB3aHkgc3BpbmFuZF9zZWxlY3Rfb3BfdmFyaWFudCBnbG9i
YWxpemVkIGlzIHRoYXQgdGhlIE1pY3Jvbg0KPiA+IGRyaXZlciBubyBsb25nZXIgY2FsbGluZyBz
cGluYW5kX21hdGNoX2FuZF9pbml0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpdmFtdXJ0
aHkgU2hhc3RyaSA8c3NoaXZhbXVydGh5QG1pY3Jvbi5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbXRkL25hbmQvc3BpL2NvcmUuYyAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9z
cGkvbWljcm9uLmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLS0N
Cj4gPiAgaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oICAgfCAgNCArKysNCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMgYi9kcml2ZXJzL210ZC9uYW5k
L3NwaS9jb3JlLmMNCj4gPiBpbmRleCA3YWU3NmRhYjkxNDEuLmFhZTcxNWQzODhiNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJz
L210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gPiBAQCAtOTIwLDcgKzkyMCw3IEBAIHN0YXRpYyB2b2lk
IHNwaW5hbmRfbWFudWZhY3R1cmVyX2NsZWFudXAoc3RydWN0DQo+IHNwaW5hbmRfZGV2aWNlICpz
cGluYW5kKQ0KPiA+ICAJCXJldHVybiBzcGluYW5kLT5tYW51ZmFjdHVyZXItPm9wcy0+Y2xlYW51
cChzcGluYW5kKTsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX21l
bV9vcCAqDQo+ID4gK2NvbnN0IHN0cnVjdCBzcGlfbWVtX29wICoNCj4gPiAgc3BpbmFuZF9zZWxl
Y3Rfb3BfdmFyaWFudChzdHJ1Y3Qgc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQsDQo+ID4gIAkJCSAg
Y29uc3Qgc3RydWN0IHNwaW5hbmRfb3BfdmFyaWFudHMgKnZhcmlhbnRzKQ0KPiA+ICB7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL21pY3Jvbi5jDQo+IGIvZHJpdmVycy9t
dGQvbmFuZC9zcGkvbWljcm9uLmMNCj4gPiBpbmRleCA5NWJjNTI2NGViYzEuLjZmZGU5M2VjMjNh
MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9taWNyb24uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL21pY3Jvbi5jDQo+ID4gQEAgLTkwLDIyICs5MCwxMCBA
QCBzdGF0aWMgaW50IG1pY3Jvbl9lY2NfZ2V0X3N0YXR1cyhzdHJ1Y3QNCj4gc3BpbmFuZF9kZXZp
Y2UgKnNwaW5hbmQsDQo+ID4gIAlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpbmFuZF9pbmZvIG1pY3Jvbl9zcGluYW5kX3RhYmxlW10gPSB7
DQo+ID4gLQlTUElOQU5EX0lORk8oIk1UMjlGMkcwMUFCQUdEIiwgMHgyNCwNCj4gPiAtCQkgICAg
IE5BTkRfTUVNT1JHKDEsIDIwNDgsIDEyOCwgNjQsIDIwNDgsIDQwLCAyLCAxLCAxKSwNCj4gPiAt
CQkgICAgIE5BTkRfRUNDUkVRKDgsIDUxMiksDQo+ID4gLQkJICAgICBTUElOQU5EX0lORk9fT1Bf
VkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHMsDQo+ID4gLQkJCQkJICAgICAgJndyaXRlX2Nh
Y2hlX3ZhcmlhbnRzLA0KPiA+IC0JCQkJCSAgICAgICZ1cGRhdGVfY2FjaGVfdmFyaWFudHMpLA0K
PiA+IC0JCSAgICAgMCwNCj4gPiAtCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmbWljcm9uX29vYmxh
eW91dF9vcHMsDQo+ID4gLQkJCQkgICAgIG1pY3Jvbl9lY2NfZ2V0X3N0YXR1cykpLA0KPiA+IC19
Ow0KPiA+IC0NCj4gDQo+IEkgZG9uJ3Qga25vdyBpZiBpdCBpcyB3aXNlIHRvIGRyb3AgdGhpcyBz
dHJ1Y3R1cmUuDQo+IA0KPiA+ICBzdGF0aWMgaW50IG1pY3Jvbl9zcGluYW5kX2RldGVjdChzdHJ1
Y3Qgc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQpDQo+ID4gIHsNCj4gPiArCWNvbnN0IHN0cnVjdCBz
cGlfbWVtX29wICpvcDsNCj4gPiAgCXU4ICppZCA9IHNwaW5hbmQtPmlkLmRhdGE7DQo+ID4gLQlp
bnQgcmV0Ow0KPiA+DQo+ID4gIAkvKg0KPiA+ICAJICogTWljcm9uIFNQSSBOQU5EIHJlYWQgSUQg
bmVlZCBhIGR1bW15IGJ5dGUsDQo+ID4gQEAgLTExNCwxNiArMTAyLDU1IEBAIHN0YXRpYyBpbnQg
bWljcm9uX3NwaW5hbmRfZGV0ZWN0KHN0cnVjdA0KPiBzcGluYW5kX2RldmljZSAqc3BpbmFuZCkN
Cj4gPiAgCWlmIChpZFsxXSAhPSBTUElOQU5EX01GUl9NSUNST04pDQo+ID4gIAkJcmV0dXJuIDA7
DQo+ID4NCj4gPiAtCXJldCA9IHNwaW5hbmRfbWF0Y2hfYW5kX2luaXQoc3BpbmFuZCwgbWljcm9u
X3NwaW5hbmRfdGFibGUsDQo+ID4gLQkJCQkgICAgIEFSUkFZX1NJWkUobWljcm9uX3NwaW5hbmRf
dGFibGUpLA0KPiBpZFsyXSk7DQo+IA0KPiBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgdGhlIHJpZ2h0
IHNvbHV0aW9uLiBJIHdvdWxkIGtlZXAgdGhpcyBjYWxsIGFuZA0KPiBvdmVyd3JpdGUgd2hhdCB5
b3UgbmVlZCB0byBvdmVyd3JpdGUgd2l0aCB0aGUgZml4dXAgaG9vay4NCj4gDQoNClRoZW4sIEkg
d2lsbCBoYXZlIGR1bW15IHN0cnVjdHVyZSBsaWtlIGJlbG93Lg0KDQpzdGF0aWMgY29uc3Qgc3Ry
dWN0IHNwaW5hbmRfaW5mbyBtaWNyb25fc3BpbmFuZF90YWJsZVtdID0geyAgICAgICAgICAgICAg
ICAgICAgICANCiAgICAgICAgU1BJTkFORF9JTkZPKE5VTEwsIDAsICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAg
ICAgICAgICAgICAgICAgIE5BTkRfTUVNT1JHKDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAsIDApLCAg
ICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICBOQU5EX0VDQ1JFUSgwLCAwKSwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgU1BJTkFORF9JTkZPX09QX1ZBUklBTlRTKCZy
ZWFkX2NhY2hlX3ZhcmlhbnRzLCAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJndyaXRlX2NhY2hlX3ZhcmlhbnRzLCAgICAgICAgICAg
ICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdXBkYXRl
X2NhY2hlX3ZhcmlhbnRzKSwgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgMCwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgU1BJTkFO
RF9FQ0NJTkZPKCZtaWNyb25fb29ibGF5b3V0X29wcywgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWljcm9uX2VjY19nZXRfc3RhdHVz
KSksICAgICAgICAgICAgICAgICAgICANCn07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQoNCkxldCBtZSBrbm93IGlmIHlvdSBhcmUgdGhpbmtpbmcgZm9yIGRpZmZlcmVudCBh
cHByb2FjaC4NCg0KPiA+IC0JaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+ICsJc3Bp
bmFuZC0+ZmxhZ3MgPSAwOw0KPiA+ICsJc3BpbmFuZC0+ZWNjaW5mby5nZXRfc3RhdHVzID0gbWlj
cm9uX2VjY19nZXRfc3RhdHVzOw0KPiA+ICsJc3BpbmFuZC0+ZWNjaW5mby5vb2JsYXlvdXQgPSAm
bWljcm9uX29vYmxheW91dF9vcHM7DQo+ID4gKw0KPiA+ICsJb3AgPSBzcGluYW5kX3NlbGVjdF9v
cF92YXJpYW50KHNwaW5hbmQsDQo+ID4gKwkJCQkgICAgICAgJnJlYWRfY2FjaGVfdmFyaWFudHMp
Ow0KPiA+ICsJaWYgKCFvcCkNCj4gPiArCQlyZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICsNCj4gPiAr
CXNwaW5hbmQtPm9wX3RlbXBsYXRlcy5yZWFkX2NhY2hlID0gb3A7DQo+ID4gKw0KPiA+ICsJb3Ag
PSBzcGluYW5kX3NlbGVjdF9vcF92YXJpYW50KHNwaW5hbmQsDQo+ID4gKwkJCQkgICAgICAgJndy
aXRlX2NhY2hlX3ZhcmlhbnRzKTsNCj4gPiArCWlmICghb3ApDQo+ID4gKwkJcmV0dXJuIC1FTk9U
U1VQUDsNCj4gPiArDQo+ID4gKwlzcGluYW5kLT5vcF90ZW1wbGF0ZXMud3JpdGVfY2FjaGUgPSBv
cDsNCj4gPiArDQo+ID4gKwlvcCA9IHNwaW5hbmRfc2VsZWN0X29wX3ZhcmlhbnQoc3BpbmFuZCwN
Cj4gPiArCQkJCSAgICAgICAmdXBkYXRlX2NhY2hlX3ZhcmlhbnRzKTsNCj4gPiArCXNwaW5hbmQt
Pm9wX3RlbXBsYXRlcy51cGRhdGVfY2FjaGUgPSBvcDsNCj4gPg0KPiA+ICAJcmV0dXJuIDE7DQo+
ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBtaWNyb25fZml4dXBfcGFyYW1fcGFnZShzdHJ1
Y3Qgc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQsDQo+ID4gKwkJCQkgICAgc3RydWN0IG5hbmRfb25m
aV9wYXJhbXMgKnApDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBBcyBwZXIgTWljcm9uIGRh
dGFzaGVldHMgdmVuZG9yWzgzXSBpcyBkZWZpbmVkIGFzDQo+ID4gKwkgKiBkaWVfc2VsZWN0X2Zl
YXR1cmUNCj4gPiArCSAqLw0KPiA+ICsJaWYgKHAtPnZlbmRvcls4M10gJiYgIXAtPmludGVybGVh
dmVkX2JpdHMpDQo+ID4gKwkJc3BpbmFuZC0+YmFzZS5tZW1vcmcucGxhbmVzX3Blcl9sdW4gPSAx
IDw8IHAtDQo+ID52ZW5kb3JbMF07DQo+ID4gKw0KPiA+ICsJc3BpbmFuZC0+YmFzZS5tZW1vcmcu
bnRhcmdldHMgPSBwLT5sdW5fY291bnQ7DQo+ID4gKwlzcGluYW5kLT5iYXNlLm1lbW9yZy5sdW5z
X3Blcl90YXJnZXQgPSAxOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBBcyBwZXIgTWljcm9u
IGRhdGFzaGVldHMsDQo+ID4gKwkgKiB2ZW5kb3JbODJdIGlzIEVDQyBtYXhpbXVtIGNvcnJlY3Rh
YmlsaXR5DQo+ID4gKwkgKi8NCj4gPiArCXNwaW5hbmQtPmJhc2UuZWNjcmVxLnN0cmVuZ3RoID0g
cC0+dmVuZG9yWzgyXTsNCj4gPiArCXNwaW5hbmQtPmJhc2UuZWNjcmVxLnN0ZXBfc2l6ZSA9IDUx
MjsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGluYW5kX21hbnVm
YWN0dXJlcl9vcHMNCj4gbWljcm9uX3NwaW5hbmRfbWFudWZfb3BzID0gew0KPiA+ICAJLmRldGVj
dCA9IG1pY3Jvbl9zcGluYW5kX2RldGVjdCwNCj4gPiArCS5maXh1cF9wYXJhbV9wYWdlID0gbWlj
cm9uX2ZpeHVwX3BhcmFtX3BhZ2UsDQo+ID4gIH07DQo+ID4NCj4gPiAgY29uc3Qgc3RydWN0IHNw
aW5hbmRfbWFudWZhY3R1cmVyIG1pY3Jvbl9zcGluYW5kX21hbnVmYWN0dXJlciA9IHsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oIGIvaW5jbHVkZS9saW51eC9t
dGQvc3BpbmFuZC5oDQo+ID4gaW5kZXggZmVhODIwYTIwYmM5Li5kZGIyMTk0MjczYTggMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9tdGQvc3BpbmFuZC5oDQo+ID4gQEAgLTQ2MSw0ICs0NjEsOCBAQCBpbnQgc3BpbmFu
ZF9tYXRjaF9hbmRfaW5pdChzdHJ1Y3Qgc3BpbmFuZF9kZXZpY2UNCj4gKmRldiwNCj4gPiAgaW50
IHNwaW5hbmRfdXBkX2NmZyhzdHJ1Y3Qgc3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQsIHU4IG1hc2ss
IHU4IHZhbCk7DQo+ID4gIGludCBzcGluYW5kX3NlbGVjdF90YXJnZXQoc3RydWN0IHNwaW5hbmRf
ZGV2aWNlICpzcGluYW5kLCB1bnNpZ25lZCBpbnQNCj4gdGFyZ2V0KTsNCj4gPg0KPiA+ICtjb25z
dCBzdHJ1Y3Qgc3BpX21lbV9vcCAqDQo+ID4gK3NwaW5hbmRfc2VsZWN0X29wX3ZhcmlhbnQoc3Ry
dWN0IHNwaW5hbmRfZGV2aWNlICpzcGluYW5kLA0KPiA+ICsJCQkgIGNvbnN0IHN0cnVjdCBzcGlu
YW5kX29wX3ZhcmlhbnRzICp2YXJpYW50cyk7DQo+ID4gKw0KPiA+ICAjZW5kaWYgLyogX19MSU5V
WF9NVERfU1BJTkFORF9IICovDQo+IA0KPiANCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwN
Cg==
