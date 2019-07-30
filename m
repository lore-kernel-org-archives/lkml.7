Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C3DC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9E52089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="gV/BbR3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfG3VAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:00:07 -0400
Received: from mail-eopbgr50106.outbound.protection.outlook.com ([40.107.5.106]:59285
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfG3VAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqA6u1cJPC/TDYcBg0hMCcGT6rn2WHsdS53w9AgPbzpJcbmES5/OSze4hnZWP+bpKN9luD66SLNEbSV+uHDFhO4L4K+A4wGdZ5PyKWz1pvsyJ/oxgYQAJdCkQZZntgBqfU65ahAr2ZHDR4mjP/jwMhekh5POOLfCfNd96Zm6goSx5DXpHq6AOj1gvKhZRZVSSIaoUKRSKlErrym52Un4RemOKP/YWmPfTu9Pgo57XA87sNds/rU69bF8KFloaONHxnGiMPu1Pdrr2BmjCZ6k1xVuXFlB6r+8GIWyvAm7DaxOBddjBD0mAgebZgfqbRpp/bNp1rTMGZ4yX0teJdc8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryBKCu3lp28/o7o9HHqLosCViH5uTgWnLYnNVqQKgTA=;
 b=UNUdd9ltOkc+eJQ0IQNlrnrWcjddadfv1AjwW2u9U4t/MeSfynf7sTZy62ClVAG0ysET/JyMT5aTAm3ceQ87PEIQfdGRCF/VIMLMXAK/Y+wRzAG3ZlHFJiaauOJkcCdNGgpdHczDWziJLP+1L9ODgzKGY6e+8t2qhWZeuZdZHa8YmznyrmpxQWNHDK3rm4bnLdeR56iHqDux9sUVvP+QgSAlxVTjcIODP1bpgCxn7O2ubJBadOv0t0VTdzJMUq9WDUa90+jP1/B2Wt8qQ/wFpmRKurkfjpP6h+Oa8bc3Gm8v4PIDDYoozZKohseK0bXJq9btpbjCRCJhbc9kPo2PMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryBKCu3lp28/o7o9HHqLosCViH5uTgWnLYnNVqQKgTA=;
 b=gV/BbR3cLyiO53bLDwmumH0+ljMftpaO2btXb0snoioATRjUpCzV/3q5KJ9pp3Ak2lRwb3SaL738rrLDwCIh2v7L0glK3xRNxHdZyeDYVuFgWjW8UWacljnKyAAEsWXUwxjZblFCUV2HcJ+tVqXRILkZ8dsC5Sf2nTmjbyiIbRQ=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3808.eurprd05.prod.outlook.com (52.134.9.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 21:00:01 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 21:00:01 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Topic: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Index: AQHVRvxzybMyJSodXUy6lc50qr83sabjdjUAgAAvYYA=
Date:   Tue, 30 Jul 2019 21:00:01 +0000
Message-ID: <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
References: <20190730173006.15823-1-dev@pschenker.ch>
         <20190730173006.15823-2-dev@pschenker.ch>
         <20190730181038.GK4264@sirena.org.uk>
In-Reply-To: <20190730181038.GK4264@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [51.154.7.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d28dfd2a-0c41-46d1-bca4-08d71530e380
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3808;
x-ms-traffictypediagnostic: VI1PR0502MB3808:
x-microsoft-antispam-prvs: <VI1PR0502MB38087CA8C7192B7731073471F4DC0@VI1PR0502MB3808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(39850400004)(396003)(346002)(376002)(366004)(85664002)(199004)(189003)(52314003)(476003)(64756008)(66946007)(66476007)(66556008)(6116002)(81166006)(91956017)(81156014)(76116006)(8936002)(3846002)(6916009)(66066001)(54906003)(1730700003)(53936002)(256004)(8676002)(66446008)(305945005)(2351001)(316002)(7736002)(5660300002)(76176011)(6512007)(478600001)(26005)(486006)(6436002)(229853002)(4326008)(446003)(6486002)(102836004)(561944003)(2906002)(25786009)(14454004)(186003)(86362001)(68736007)(44832011)(2501003)(2616005)(6246003)(11346002)(36756003)(71200400001)(6506007)(118296001)(99286004)(71190400001)(5640700003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3808;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEM8dzDC+bXv8Ro7xLCM9nm90AUC/jkr+idt93os4l9tMfuaEoFWeceqeUayJHqxYjwwIkYWWalT7LjGQti8cnX6Tg3fop7wZUQI9ZDv8XufOZ6WPzqZQhWLmhvBqdLHELDai4qm2KNiZlxMA3x8Nm8W0xzXu3yqGCWI55LBjcGS1UwTvJT6lw5wKmexFEoL4vzIWB60+5zCUM75vmhRzYswwtJUxPrYvy4VXDvQgShyIjFs/T2a1bU6+5CckCY0S3KFC2MihK3tz4IxGDZ9tFDGbLLpoe9cQwUmHajO9z9qxGHP69u8p/LergefQerm+mCZdBdZYXNQqnjTKMphA/1vm/ofTTH8EBNLH472acac4ue/zstfWgihTpEchkWL3a/lFmHqGxsYuaBj1Whkd/5nc2TBThkI6r+KbmjMFTI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C53F86CBB6780148B48E9A6B5159F11C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28dfd2a-0c41-46d1-bca4-08d71530e380
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 21:00:01.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDE5OjEwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEp1bCAzMCwgMjAxOSBhdCAwNzozMDowNFBNICswMjAwLCBQaGlsaXBwZSBTY2hlbmtl
ciB3cm90ZToNCj4gPiBGcm9tOiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJA
dG9yYWRleC5jb20+DQo+ID4gDQo+ID4gVGhpcyBhZGRzIHRoZSBwb3NzaWJpbGl0eSB0byBlbmFi
bGUgYSBmaXhlZC1yZWd1bGF0b3Igd2l0aCBhIGNsb2NrLg0KPiANCj4gV2h5PyAgV2hhdCBkb2Vz
IHRoZSBoYXJkd2FyZSB3aGljaCBtYWtlcyB0aGlzIG1ha2Ugc2Vuc2UgbG9vayBsaWtlPw0KDQpU
b21vcnJvdyBJIGNhbiBwcm92aWRlIHNvbWUgc2NoZW1hdGljcyBpZiBuZWVkZWQuIEJ1dCBpdHMg
anVzdCBhIHNpbXBsZQ0Kc3dpdGNoIHRoYXQgaXMgc3dpdGNoZWQgYnkgYSBjbG9jayAob24gd2hl
biBjbG9jayBpcyBvbiBhbmQgb2ZmIHdoZW4NCmNsb2NrIGlzIG9mZikuIFRoaXMgY2xvY2sgaXMg
dGhlIFJHTUlJIDUwTUh6IGNsb2NrIGZvciB0aGUgZXRoZXJuZXQNClBIWS4NCg0KVGhhdCBzd2l0
Y2ggc3dpdGNoZXMgcG93ZXIgcmFpbCBvZiBhIEtTWjgwNDEgZXRoZXJuZXQgUEhZLiBTbyB0aGUg
cG93ZXINCnJhaWwgb2YgdGhlIEtTWjgwNDEgUEhZIGlzIHN3aXRjaGVkIGJ5IGl0cyBvd24gY2xv
Y2suDQoNCj4gWW91ciBjb3ZlciBsZXR0ZXIgZGlkbid0IGV4cGxhaW4gYXQgYWxsIGNsZWFybHks
IGl0IGp1c3Qgc2FpZCB0aGF0DQo+IHRoZXJlJ3MgYSBjaXJjdWl0IHRoYXQgaXMgY29ubmVjdGVk
IHRvIGEgY2xvY2sgd2hpY2ggc29tZWhvdyBzd2l0Y2hlcw0KPiBzb21ldGhpbmcgYnV0IGl0J3Mg
bm90IGNsZWFyLiAgSXQncyBjZXJ0YWlubHkgbm90IGNsZWFyIHRoYXQgdGhpcw0KPiBzaG91bGQN
Cj4gYmUgaW4gdGhlIGNvcmUsIHRoZSBjaXJjdWl0IGRvZXNuJ3Qgc291bmQgbGlrZSBhIGdvb2Qg
aWRlYSBhdCBhbGwuDQoNClNvcnJ5IGlmIEkgZGlkbid0IGV4cGxhaW4gaXQgY2xlYXIgZW5vdWdo
LiBJIGhvcGUgdGhlIGhhcmR3YXJlIHBhcnQgaXMNCmNsZWFyIG5vdyBmcm9tIHRoZSBleHBsYW5h
dGlvbiBhYm92ZS4gT3RoZXJ3aXNlIGxldCBtZSBrbm93IEkgd2lsbA0KcHJvdmlkZSBmdXJ0aGVy
IGV4cGxhbmF0aW9ucy9zY2hlbWF0aWNzLg0KDQpUbyB5b3VyIG90aGVyIHF1ZXN0aW9ucywgSSB3
aWxsIHNwbGl0IHRob3NlIGZvciBiZXR0ZXIgdW5kZXJzdGFuZGluZzoNCg0KV2h5IGlzIGEgcmVn
dWxhdG9yIGV2ZW4gbmVlZGVkPw0KLSBPbiBwb3dlciB1cCBvZiB0aGUgUEhZIHRoZXJlIGlzIGEg
aHVnZSB0aW1lIEkgaGF2ZSB0byB3YWl0IGZvcg0Kdm9sdGFnZSByYWlsIHRvIHNldHRsZS4gSW4g
dGhlIHJhbmdlIG9mIDEwMG1zLg0KLSBCZWNhdXNlIHRoZXJlIGlzIGEgc3dpdGNoIGluIHRoZSBj
aXJjdWl0IEkgYWJzdHJhY3QgaXQgd2l0aCBhDQpyZWd1bGF0b3ItZml4ZWQgaW4gZGV2aWNldHJl
ZSB0byBtYWtlIHVzZSBvZiB0aGUgc3RhcnR1cC1kZWxheS4NCi0gVGhpcyByZWd1bGF0b3Ivc3dp
dGNoIGlzIGVuYWJsZWQgd2l0aCBhIGNsb2NrLiBTbyB0byBiZSBhYmxlIHRvIHVzZQ0KdGhlIHN0
YXJ0dXAgZGVsYXkgSSBuZWVkIGFuIGVuYWJsZS1ieS1jbG9jayBvbiByZWd1bGF0b3ItZml4ZWQu
DQoNCldoeSBkbyBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGluIGNvcmU/DQotIE5vcm1hbGx5IHRo
aXMgdGFzayBpcyBkb25lIHdpdGggZ3BpbyB0aGF0IGlzIGFscmVhZHkgaW4gcmVndWxhdG9yLQ0K
Y29yZS4NCi0gQmVjYXVzZSB0aGF0IGlzIGFscmVhZHkgdGhlcmUgSSBhZGRlZCB0aGUgZnVuY3Rp
b25hbGl0eSBmb3IgZW5hYmxlZC0NCmJ5LWNsb2NrLWZ1bmN0aW9uYWxpdHkuDQotIEkgdGhvdWdo
dCBvZiBjcmVhdGluZyBhIG5ldyByZWd1bGF0b3ItY2xvY2sgZHJpdmVyIGJ1dCB0aGF0IHdvdWxk
DQpob2xkIGEgbG90IG9mIGNvZGUgZHVwbGljYXRpb24gZnJvbSByZWd1bGF0b3ItZml4ZWQuDQoN
CldoeSBpcyB0aGlzIGEgZ29vZCBJZGVhIGF0IGFsbD8NCi0gV2VsbCBJJ20gaGVyZSBmb3IgdGhl
IHNvZnR3YXJlIHBhcnQgYW5kIHNob3VsZCBqdXN0IHN1cHBvcnQgb3VyDQpoYXJkd2FyZS4gSWYg
dGhhdCBpcyBhIGdvb2QgSWRlYSBhdCBhbGwgSSBkb24ndCBrbm93LCBmb3Igc3VyZSBpdCBpcw0K
bm90IGEgc29sdXRpb24gdGhhdCBpcyBmcm9tIHNvbWUgc2Nob29sLWJvb2suIEJ1dCBJIHRyaWVk
IGl0IGFuZA0KbWVhc3VyZWQgaXQgb3V0IGFuZCBpdCBzZWVtcyB0byB3b3JrIHByZXR0eSBmaW5l
Lg0KLSBUaGUgcmVhc29uIGJlaGluZCBhbGwgb2YgdGhhdCBpcyBsaW1pdGVkIEdQSU8gYXZhaWxh
YmlsaXR5IGZyb20gdGhlDQppTVg2VUxMLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IDxwaGls
aXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBT
Y2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IA0KPiBUaGlzIG5lZWRz
IGEgY2xlYW51cC4NCg0KT2YgY291cnNlLCBzb3JyeSBJIGRpZG4ndCBzYXcgdGhhdCBiZWZvcmVo
YW5kLiBTb21lIG1lc3MgY3JlYXRlZCB3aXRoDQpjaGVycnktcGlja2luZy4uLg0KDQo+IA0KPiA+
ICANCj4gPiAgCS8qIGNhcmVzIGFib3V0IGxhc3Rfb2ZmX2ppZmZ5IG9ubHkgaWYgb2ZmX29uX2Rl
bGF5IGlzIHJlcXVpcmVkDQo+ID4gYnkNCj4gPiBAQCAtMjc5Niw2ICsyODA1LDkgQEAgc3RhdGlj
IGludCBfcmVndWxhdG9yX2lzX2VuYWJsZWQoc3RydWN0DQo+ID4gcmVndWxhdG9yX2RldiAqcmRl
dikNCj4gPiAgCWlmIChyZGV2LT5lbmFfcGluKQ0KPiA+ICAJCXJldHVybiByZGV2LT5lbmFfZ3Bp
b19zdGF0ZTsNCj4gPiAgDQo+ID4gKwlpZiAocmRldi0+ZW5hX2NsaykNCj4gPiArCQlyZXR1cm4g
KHJkZXYtPmVuYV9jbGtfc3RhdGUgPiAwKSA/IDEgOiAwOw0KPiA+ICsNCj4gDQo+IFBsZWFzZSB3
cml0ZSBub3JtYWwgY29uZGl0aW9uYWwgc3RhdGVtZW50cywgdGhpcyBpc24ndCBoZWxwaW5nDQo+
IGxlZ2liaWxpdHkuICBUaG91Z2ggaW4gdGhpcyBjYXNlIHRoZSB0ZXJuZXJ5IG9wZXJhdG9yIGlz
IHRvdGFsbHkNCj4gcmVkdW5kYW50IGFueXdheS4uLg0KDQpZZWFoIG5vdyB0aGF0IEkgbG9vayBh
dCBpdCB5b3UncmUgcmlnaHQuIEkgaGF2ZSBpbiBtaW5kIHRoYXQgSSBjb3BpZWQNCnRoYXQgZnJv
bSBzb21ld2hlcmUgdG8gZ2V0IHRoZSBzYW1lIGNvZGluZyBzdHlsZS4gSSBkZXZlbG9wZWQgdGhh
dCBpbg0KYW4gb2xkIGtlcm5lbCBzbyBjb3VsZCBiZSB0aGF0IGl0J3MgZnJvbSB0aGVyZS4NCkFu
eXdheSwgdGhpcyBpcyBqdXN0IGEgY29uY2VwdCBmb3Igbm93IGFuZCB3b3VsZCBuZWVkIHNvbWUg
bW9yZQ0KdGhpbmtpbmcuLi4NCldpdGggdGhpcyBwYXRjaCBJIHdhbnQgdG8gcHV0IG9mZiBhIGRp
c2N1c3Npb24sIGhvdyB3ZSBjYW4gc3VwcG9ydCBvdXINCmhhcmR3YXJlIGluIG1haW5saW5lIExp
bnV4LiBUaGlzIGlzIG15IGZpcnN0IHByb3Bvc2FsIGZvciB0aGF0Lg0KDQpQaGlsaXBwZQ0K
