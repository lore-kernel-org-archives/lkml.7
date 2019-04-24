Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B74DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5940A20684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UlIc1AUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfDXJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:26:23 -0400
Received: from mail-eopbgr810054.outbound.protection.outlook.com ([40.107.81.54]:15392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfDXJ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuKsvDUqrJn1FbzANfeXXPzAE1V91NrSkla1OnD0kyw=;
 b=UlIc1AULZON8h3BgdruV357GJWCv3jOklAK2d5+db/g9AabIXYMbCgUYihCZMgkHgUK3BgPkeHL6X8Rs+TtXZoq1labYeQ5k8hHwdaEIpMupm97EyTUnL7+2J0v9NO+UNi2WpCt148miMg5aJvRBA3lmxf+PgWiH+pBU1diS6mQ=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6031.namprd05.prod.outlook.com (20.178.243.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 09:26:15 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 09:26:15 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Deepak Singh Rawat <drawat@vmware.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] drm/vmwgfx: Implement an infrastructure for
 read-coherent resources
Thread-Topic: [PATCH 8/9] drm/vmwgfx: Implement an infrastructure for
 read-coherent resources
Thread-Index: AQHU8UlpMpAuzkwq50Wm+jUUUgLkeaZIrMQAgAJwLwA=
Date:   Wed, 24 Apr 2019 09:26:15 +0000
Message-ID: <24023a79de1acee5147dd9b1e061d6df008047ab.camel@vmware.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
         <20190412160338.64994-9-thellstrom@vmware.com>
         <9181c812a226eaeff5efd96f9f8936bdf37b23e1.camel@vmware.com>
In-Reply-To: <9181c812a226eaeff5efd96f9f8936bdf37b23e1.camel@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e9b03b-ae5a-429f-7b03-08d6c896e644
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6031;
x-ms-traffictypediagnostic: MN2PR05MB6031:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB603137D258D1EA964047B1C5A13C0@MN2PR05MB6031.namprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(186003)(229853002)(2906002)(73956011)(5660300002)(3846002)(6116002)(66556008)(66476007)(36756003)(64756008)(4744005)(66446008)(76116006)(316002)(97736004)(6486002)(68736007)(91956017)(99286004)(66946007)(66066001)(26005)(102836004)(6506007)(256004)(118296001)(54906003)(76176011)(6862004)(6512007)(486006)(6636002)(6246003)(446003)(7736002)(37006003)(11346002)(14454004)(305945005)(4326008)(476003)(8676002)(53936002)(71200400001)(6436002)(81166006)(8936002)(71190400001)(478600001)(81156014)(2616005)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6031;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TzPKsWG/iFglpu8cFJVofgvzVEPYhr7EDl+XFCSYxKPNJLC+SGa4diGU0vi/OuXk0kVr8Dq4Vu5jnD2jHArJuEt5jk3CC1gaugv1WgORJDhUEa39Ug/IG7PXfFhQKvrJ7qSu97YpiP19Ka/E/XCx/+svcfbugnhXIpLtHnO9f1NBj9HGxU2Le0Ckt1Gk98uEBxjmJRuYY/kl48E8PXw1cNyPk0+R/L/S7aMDzAiGK366tyJD5fJKxC/a/IKpxu2LVXrPmgfd8EuRBixXuyMZFGo5OwgyoY1BfhvSJPZJwM4XFJCyP0PlCpOU4koqcx3ubwvh3TtKqjtW8W0j1/KNQ6S0e6eJoblrCX+mF9Jm99psStzGfeR/SBQtU6fdHFGqALeoG302K+0FQmcqPxSZZjcD6BZvHYU46fp8hMznk8U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C04C32762B8762479747102E38325C4F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e9b03b-ae5a-429f-7b03-08d6c896e644
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 09:26:15.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDIwOjEyICswMDAwLCBEZWVwYWsgU2luZ2ggUmF3YXQgd3Jv
dGU6DQo+IE1pbm9yIG5pdHMgYmVsb3csIG90aGVyd2lzZQ0KPiANCj4gUmV2aWV3ZWQtYnk6IERl
ZXBhayBSYXdhdCA8ZHJhd2F0QHZtd2FyZS5jb20+DQo+IA0KPiBPbiBGcmksIDIwMTktMDQtMTIg
YXQgMDk6MDQgLTA3MDAsIFRob21hcyBIZWxsc3Ryb20gd3JvdGU6DQo+ID4gU2ltaWxhciB0byB3
cml0ZS1jb2hlcmVudCByZXNvdXJjZXMsIG1ha2Ugc3VyZSB0aGF0IGZyb20gdGhlIHVzZXItDQo+
ID4gc3BhY2UNCj4gPiBwb2ludCBvZiB2aWV3LCBHUFUgcmVuZGVyZWQgY29udGVudHMgaXMgYXV0
b21hdGljYWxseSBhdmFpbGFibGUgZm9yDQo+ID4gcmVhZGluZyBieSB0aGUgQ1BVLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNv
bT4NCj4gPiAtLS0NCj4gPiANCj4gPiArCXdoaWxlIChjdXIpIHsNCj4gPiArCQlzdHJ1Y3Qgdm13
X3Jlc291cmNlICpjdXJfcmVzID0NCj4gPiArCQkJY29udGFpbmVyX29mKGN1ciwgc3RydWN0IHZt
d19yZXNvdXJjZSwNCj4gPiBtb2Jfbm9kZSk7DQo+ID4gKw0KPiA+ICsJCWlmIChjdXJfcmVzLT5i
YWNrdXBfb2Zmc2V0ID49IHJlc19lbmQpIHsNCj4gPiArCQkJY3VyID0gY3VyLT5yYl9sZWZ0Ow0K
PiA+ICsJCX0gZWxzZSBpZiAoY3VyX3Jlcy0+YmFja3VwX29mZnNldCArIGN1cl9yZXMtDQo+ID4g
PiBiYWNrdXBfc2l6ZSA8PQ0KPiA+ICsJCQkgICByZXNfc3RhcnQpIHsNCj4gPiArCQkJY3VyID0g
Y3VyLT5yYl9yaWdodDsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlmb3VuZCA9IGN1cl9yZXM7
DQo+IA0KPiBJIGRpZG4ndCBsb29rZWQgaW50byBob3cgUkIgdHJlZSB3b3JrcyBidXQgZG8geW91
IG5lZWQgdG8gYnJlYWsgdGhlDQo+IGxvb3Agd2hlbiByZXNvdXJjZSBpcyBmb3VuZD8NCg0KDQpO
bywgaGVyZSB3ZSB3aWxsIGNvbnRpbnVlIGxvb2tpbmcgZm9yIGEgcmVzb3VyY2Ugd2l0aCBldmVu
IGxvd2VyDQpzdGFydGluZyBvZmZzZXQuIEknbGwgYWRkIGEgY29tbWVudCBhYm91dCB0aGF0Lg0K
DQpUaGFua3MsDQpUaG9tYXMNCg0K
