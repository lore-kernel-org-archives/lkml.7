Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C07C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB120C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CCn1Nya/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfHFNAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:00:21 -0400
Received: from mail-eopbgr130130.outbound.protection.outlook.com ([40.107.13.130]:37852
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728560AbfHFNAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3ETUzxAJLcdYPOLYKSFtIIsb/Pp79wNI/YfHnk08krC0QtwfQBKBTytf4JH+yXGuj/5lvw4BHnDEHJnfBJYfMwDQ0DI2Oscx+xNj2K7dadeJ7tv+CkpFN3nWPwPP9U5Vd+sLi7AsnRz8wijJgS/bJ5ghQ9vfFW3j5HMb8UFrhMQC887LtB6U3z58GryC61x7+4IW6xZooodU6AmLUr2YZAnGtI8HXekJgoKO5xUgMrEHG16VfjJA03HIflLhDgAo57HAPEAwtREtBJbT29Em3NFntXTgDLfkHMtBdm7r6SEfumuedmQIVMbMFT/FUs+cYu6ya5JhCgPNtelInNTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma2Fw3r1st8/lJRKVgyhw5rBMYIAkVEPT4pizSzfNSg=;
 b=LvYHj1weRJVjtOXRAARZyOD9z/Of0z33sHzA0JcITrvd/N5cWvsa0wPvPfi0oKQLVTjYabbq9Cl0/YWHDwZESXencS/CQYWi7rRtVfAknVrJFvuh9EZMAMIHkj6B8u8EORJosOjx/EfgrUx3f65mprhptB0buZocski0q7PQXu5EKdnMxqfecPWTi0NTgVIuzoqZ4Obe7FQ1MG7MOF6SjOBhwcq+1SiS2PsDqOLgN/KkWJaXavMItE0VTpqdwcAjUNuX3xBGuoXHWGyKC7UQnVjqvI62TgjFL7JTMkRJk2Xkt5nu7uSrULrhsYD6BysekT/QH3NFUDnLHOgl7sCzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma2Fw3r1st8/lJRKVgyhw5rBMYIAkVEPT4pizSzfNSg=;
 b=CCn1Nya/no7EpdHIPpSsJSIlc9lAsbdEEwd1OuXjQIiPgsMme62NhWAcB5VCgEXWcSm0R9M+oHC7XwIJTWcFiMGqbla6WV45UrKK+/8bJUNfWFiJ7WLeAfvmWu+JrFzrFX2B1WhRmaWyiCq9KQnQWJn0lfb+sVJn98Ga9P++yVg=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4031.eurprd05.prod.outlook.com (52.134.18.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Tue, 6 Aug 2019 12:57:32 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 12:57:32 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Topic: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Index: AQHVRvxzybMyJSodXUy6lc50qr83sabjdjUAgAAvYYCAAZjcgIAHL6gAgABcCwCAAVTmgA==
Date:   Tue, 6 Aug 2019 12:57:32 +0000
Message-ID: <af076ff7e1df4c07ab659ff83efa0c85d5e5e3d6.camel@toradex.com>
References: <20190730173006.15823-1-dev@pschenker.ch>
         <20190730173006.15823-2-dev@pschenker.ch>
         <20190730181038.GK4264@sirena.org.uk>
         <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
         <20190731212335.GL4369@sirena.org.uk>
         <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
         <20190805163724.GK6432@sirena.org.uk>
In-Reply-To: <20190805163724.GK6432@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cceac635-b661-4744-0d6b-08d71a6da587
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB4031;
x-ms-traffictypediagnostic: VI1PR0502MB4031:
x-microsoft-antispam-prvs: <VI1PR0502MB4031BD07030AE2F7A883183FF4D50@VI1PR0502MB4031.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(85664002)(199004)(189003)(66556008)(11346002)(66946007)(14454004)(64756008)(2616005)(66446008)(4326008)(91956017)(229853002)(66476007)(446003)(71190400001)(76116006)(25786009)(2351001)(1730700003)(102836004)(71200400001)(81166006)(6506007)(66066001)(99286004)(6116002)(53936002)(36756003)(6246003)(6486002)(316002)(6436002)(5640700003)(186003)(76176011)(68736007)(305945005)(7736002)(14444005)(81156014)(86362001)(8676002)(54906003)(486006)(5660300002)(118296001)(2906002)(6512007)(44832011)(26005)(2501003)(476003)(6916009)(3846002)(256004)(8936002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4031;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jXCnf6wFjkhNaErit8dIvgzUr0zoQx21DLahm/aOmdHcqgaqZSjSt077krLqRUrlUYZeIBVkg6dh5rcSGMRew9C6mvBa7zX8zN0Xm6kEdl4T5iYnP8Ax5nLP9nPIUElfK1yAyIUU8gmfrjWuBjI0qd2284VDox282Yzc/gAdH/B4Bxq72zom1wY1HbMgPkYBNmq8Ba1/YvN+UmeApzZbwg9OmtrQi9JrhOj+oOdhHfBYPJ4No62j+eWPvOhcRvDXJzuHS3G7v6xKIWVsVy2GUc6wQPsrJxq3UY+qPYFmFe5+Ay/b88/Q4I18S9ki2enqOYgNxMyPb+onFoorlikGolQkS4vMktO3Tr+5PH+5B/Nz6C2cKFC2ej3zb6N+RFzJIKZyMqmUkRaRT3nm71gxEx1bzT/K5riPmdqUhJnweiE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <225EEE301485E84085B70BA6BC232AA3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cceac635-b661-4744-0d6b-08d71a6da587
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 12:57:32.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTA1IGF0IDE3OjM3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIEF1ZyAwNSwgMjAxOSBhdCAxMTowNzo1OEFNICswMDAwLCBQaGlsaXBwZSBTY2hlbmtl
ciB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMTktMDctMzEgYXQgMjI6MjMgKzAxMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+IA0KPiBQbGVhc2UgZml4IHlvdXIgbWFpbCBjbGllbnQgdG8gd29yZCB3cmFw
IHdpdGhpbiBwYXJhZ3JhcGhzIGF0IHNvbWV0aGluZw0KPiBzdWJzdGFudGlhbGx5IGxlc3MgdGhh
biA4MCBjb2x1bW5zLiAgRG9pbmcgdGhpcyBtYWtlcyB5b3VyIG1lc3NhZ2VzIG11Y2gNCj4gZWFz
aWVyIHRvIHJlYWQgYW5kIHJlcGx5IHRvLg0KDQpUaGF0IHdhcyBhIG1pc3Rha2UsIHNvcnJ5LiBJ
dCBhY3R1YWxseSBpcyBhbmQgd2FzIHNldCB0byA4MC4gTm90IHN1cmUNCndoYXQgaGFwcGVuZWQg
dGhlcmUuDQoNClNvIGl0J3Mgbm90IHN3aXRjaGluZyB3aXRoIHRoZSBjbG9jaywgdGhlIGNpcmN1
aXQgc29tZWhvdyBrZWVwcw0KdGhlDQo+ID4gPiBzd2l0Y2ggbGF0Y2hlZD8NCj4gPiBObywgaXQg
ZG9lc24ndCBrZWVwIGl0IGxhdGNoZWQuIFRvIG1ha2UgdGhpbmdzIGNsZWFyIGhlcmUgYSBzdGF0
dXMgdGFibGU6DQo+IA0KPiBTbyB0aGUgY2FwYWNpdG9yIG9uIHRoZSBpbnB1dCBvZiB0aGUgcC1G
RVQgaXMga2VlcGluZyB0aGUgc3dpdGNoIG9uPw0KPiBXaGVuIEkgc2F5IGl0J3Mgbm90IHN3aXRj
aGluZyB3aXRoIHRoZSBjbG9jayBJIG1lYW4gaXQncyBub3QgY29uc3RhbnRseQ0KPiBib3VuY2lu
ZyBvbiBhbmQgb2ZmIGF0IHdoYXRldmVyIHJhdGUgdGhlIGNsb2NrIGlzIGdvaW5nIGF0Lg0KDQpB
aCwgdGhhdCdzIHdoYXQgeW91IG1lYW4uIFllcywgdGhlIGNhcGFjaXRvciBnZXRzIHNsb3dseSBj
aGFyZ2VkIHdpdGgNCnRoZQ0KcmVzaXN0b3IgYnV0IG5lYXJseSBpbnN0YW50bHkgZGlzY2hhcmdl
ZCB3aXRoIHRoZSBuLUZFVC4gU28gdGhpcw0KY2FwYWNpdG9yDQppcyB1c2VkIGFzIGEgTG93LVBh
c3MgZmlsdGVyIHRvIGdldCB0aGUgcC1GRVQgdG8gYmUgY29uc3RhbnRseSBzd2l0Y2hlZC4NCg0K
SXQgaXMgbm90IGJvdW5jaW5nIG9uIGFuZCBvZmYgd2l0aCB0aGUgY2xvY2sgYnV0IHJhdGhlciBp
dCBpcyBzd2l0Y2hlZA0KY29uc3RhbnRseS4NCj4gDQo+ID4gPiBJdCBkb2VzIGZlZWwgbGlrZSBp
dCBtaWdodCBiZSBzaW1wbGVyIHRvIGp1c3QgaGFuZGxlIHRoaXMgYXMgYSBxdWlyayBpbg0KPiA+
ID4gdGhlIFBIWSBvciBldGhlcm5ldCBkcml2ZXIsIHRoaXMgZmVlbHMgbGlrZSBhbiBhd2Z1bCBs
b3Qgb2Ygd29yayB0bw0KPiA+ID4gYWRkIGEgc2xlZXAgb24gd2hhdCdzIHByb2JhYmx5IG9ubHkg
Z29pbmcgdG8gZXZlciBiZSBvbmUgc3lzdGVtLg0KPiA+IEkgdGhvdWdodCBvZiB0aGF0IHRvbywg
YnV0IHRoZSBwcm9ibGVtIHdpdGggdGhhdCBhcHByb2FjaCBpcyB0aGF0IEkNCj4gPiBjYW4ndCBy
ZWZsZWN0IHRoZSBhY3R1YWwgc3dpdGNoaW5nIGJlaGF2aW9yLiBXaGF0IHdvdWxkIGhhcHBlbiBp
cyBpZg0KPiA+IHlvdSB0dXJuZXRoZXJuZXQgb2ZmIHdpdGggJ2lwIGxpbmsgc2V0IGV0aDAgZG93
bicsIHRoZSBjbG9jayB3b3VsZA0KPiA+IHN0b3AgYW5kIHRoZXJlZm9yZSBubyBtb3JlIHN1cHBs
eSB2b2x0YWdlIHRvIHRoZSBQSFkuIEJ1dCB0aGUgZXRoZXJuZXQNCj4gPiBkcml2ZXJ3b3VsZCBp
biB0aGF0IGNhc2UgbGV0IHRoZSByZWd1bGF0b3IgZW5hYmxlZCBwcmV2ZW50aW5nLA0KPiA+IHN3
aXRjaGluZyBvZmYgdGhlIGNsb2NrLg0KPiANCj4gWW91IGNvdWxkIGluY2x1ZGUgdGhhdCBpbiB5
b3VyIHF1aXJrPw0KDQpZZXMsIHRoaXMgY291bGQgYmUgZG9uZSBhcyBhIHF1aXJrIGluIHRoZSBl
dGhlcm5ldCBkcml2ZXIuIEJ1dCB0aGVyZSB0aGUNCmNsb2NrIGdldHMgZW5hYmxlZC9kaXNhYmxl
ZCBpbiBkaWZmZXJlbnQgcGxhY2VzLiBTbyBJIHdvdWxkIGhhdmUgdG8gc29ydA0Kb3V0IHdoZXJl
IEkgbmVlZCBpdCBhbmQgd2hlcmUgbm90IGFuZCBiYXNpY2FsbHkgZ28gdGhyb3VnaCB0aGUgd2hv
bGUNCmRyaXZlci4gUGx1cyBpdCBnZXRzIGludGVuc2l2ZSB0byBtYWludGFpbiB0aGF0IHNvbHV0
aW9uLg0KPiANCj4gPiBBbnl3YXkgSSBmZWVsIHRoYXQgdG8gc29sdmUgdGhpcyB3aXRoIGEgcXVp
cmsgd291bGQgYmUgYSBsaXR0bGUNCj4gPiBoYWNraXNoLCBwbHVzIEknZCBhbnl3YXkgbmVlZCB0
byBtZXNzIGFyb3VuZCB3aXRoIHRoZSBFdGhlcm5ldC9QSFkNCj4gPiBkcml2ZXJzLiBTbyB3aHkg
bm90IHNvbHZlIGl0IHByb3Blcmx5IHdpdGggYSByZWd1bGF0b3IgdGhhdCBzdXBwb3J0cw0KPiA+
IGNsb2Nrcz8NCj4gDQo+IEkgdGhpbmsgeW91IGFyZSBnb2luZyB0byBlbmQgdXAgd2l0aCBhIGhh
Y2sgbm8gbWF0dGVyIHdoYXQuDQoNClRoYXQncyBleGFjdGx5IHdoYXQgSSdtIHRyeWluZyB0byBw
cmV2ZW50LiBUbyBpbnRyb2R1Y2UgYSBmaXhlZA0KcmVndWxhdG9yIHRoYXQgY2FuIGhhdmUgYSBj
bG9jayBpcyBub3QgYSBoYWNrIGZvciBtZS4NClRoYXQgdGhlIGhhcmR3YXJlIHNvbHV0aW9uIGlz
IGEgaGFjayBpcyBkZWJhdGFibGUgeWVzLCBidXQgd2h5IHNob3VsZCBJDQpub3QgdHJ5IHRvIHNv
bHZlIGl0IHByb3Blcmx5IGluIHNvZnR3YXJlPw0KPiANCj4gPiA+IEhvcGVmdWxseSBub3QgYSAq
bG90KiBvZiBkdXBsaWNhdGlvbi4gIFRoZSBHUElPcyBhcmUgaGFuZGxlZCBpbiB0aGUgY29yZQ0K
PiA+ID4gYmVjYXVzZSB0aGV5J3JlIHJlYWxseSBjb21tb24gYW5kIHVzZWQgYnkgbWFueSByZWd1
bGF0b3IgZGV2aWNlcywgdGhlDQo+ID4gPiBzYW1lIHdpbGwgSSBob3BlIG5vdCBiZSB0cnVlIGZv
ciBjbG9ja3MuDQo+ID4gSSBhZ3JlZSB0aGF0IHRoZXkgYXJlIGNvbW1vbmx5IGFuZCB3aWRlbHkg
dXNlZC4gVG8gYWRkIHN1cHBvcnQgZm9yIGNsb2NrcyBpbg0KPiA+IHJlZ3VsYXRvci1jb3JlIHdh
cyByZWFsbHkgZWFzeSB0byBkbyBhcyBJIGRpZCBpdCB0aGUgc2FtZSB3YXkgYXMgaXQgaXMgZG9u
ZQ0KPiA+IHdpdGgNCj4gPiBncGlvJ3MuIElmIEkgZG9uJ3QgbmVlZCB0byB0b3VjaCByZWd1bGF0
b3ItY29yZSBJIGRvbid0IHdhbnQgdG8uIEJ1dCBhcyBJDQo+ID4gc2FpZA0KPiA+IGl0IHdhcyBy
ZWFsbHkgZWFzeSBmb3IgbWUgdG8gaW50ZWdyYXRlIGl0IGluIHRoZXJlIGluIGEgd2F5IHdpdGhv
dXQgZXZlbg0KPiA+IHVuZGVyc3RhbmRpbmcgdGhlIHdob2xlIHJlZ3VsYXRvciBBUEkuDQo+ID4g
SWYgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBkbyBpdCBpbiBhIG5ldyBmaWxlIGxpa2UgY2xvY2st
cmVndWxhdG9yLmMgYW5kDQo+ID4gY3JlYXRpbmcgYSBuZXcgY29tcGF0aWJsZSB0aGF0IGlzIHdo
YXQgSSdtIHRyeWluZyB0byBmaW5kIG91dCBoZXJlLiBJJ2QgYmUNCj4gPiBoYXBweQ0KPiA+IHRv
IHdyaXRlIGFsc28gYSBuZXcgY2xvY2stcmVndWxhdG9yIGRyaXZlciBmb3IgdGhhdCBwdXJwb3Nl
Lg0KPiANCj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIGl0IHdhc24ndCBpbiB0aGUgY29yZSwgdGhh
dCBrZWVwcyBldmVyeXRoaW5nDQo+IHBhcnRpdGlvbmVkIG9mZiBuaWNlbHkuDQoNCkkgYWdyZWUg
dGhhdCBvdXIgaGFyZHdhcmUgZGVzaWduIGlzIHNvbWV3aGF0IHNwZWNpYWwgYW5kIGlzIG5vdCB3
aWRlbHkNCnVzZWQuIEJ1dCBJIHN0aWxsIHRoaW5rIHRoYXQgdGhpcyBpcyB2YWx1YWJsZSBhcyBh
IGdlbmVyaWMgZnVuY3Rpb24gYW5kDQpjb3VsZCBwb3NzaWJseSBiZSBvZiBiZW5lZml0IHRvIHNv
bWVvbmUgZWxzZS4NCj4gDQo+ID4gPiBJIGd1ZXNzIG15IHF1ZXN0aW9uIGhlcmUgaXMgd2hhdCB0
aGUgdHJpcCB0aHJvdWdoIHRoZSByZWd1bGF0b3IgQVBJIGJ1eXMNCj4gPiA+IHVzIC0gaXQncyBh
IGJpdCBvZiBhIHNsZWRnZWhhbW1lciB0byBjcmFjayBhIG51dCB0aGluZy4NCj4gPiBJbiBteSBv
cGluaW9uIHRoaXMgaXMgbm90IG9ubHkgYWJvdXQgdG8gc29sdmUgbXkgcHJvYmxlbSB3aXRoIHN0
YXJ0dXAtZGVsYXkuIA0KPiA+IEkNCj4gPiB0aGluayB0aGF0IHRoaXMgaXMgcmVhbGx5IGEgYmVo
YXZpb3IgdGhhdCBjYW4gYmUgZ2VuZXJpYy4gVGhhdCdzIGFsc28gd2h5DQo+ID4gSSdtDQo+ID4g
YXNraW5nIGhlcmUgaG93IHdlIHdhbnQgdG8gc29sdmUgdGhhdCBzbyBub3Qgb25seSBJIHNvbHZl
IG15IGxpdHRsZSBwcm9ibGVtDQo+ID4gd2l0aA0KPiA+IGEgYm9hcmQgcXVpcmsgYnV0IGluIGEg
YnJvYWRlciB2aWV3IGZvciBwb3NzaWJsZSBmdXR1cmUgdXNhZ2UgYnkgb3RoZXJzLg0KPiA+IEl0
IGlzIHBvc3NpYmxlIHRoYXQgYSByZWd1bGF0b3IgbmVlZHMgYSBjbG9jay4gVGhhdCBleGFjdGx5
IGlzLCB3aGF0IHdlIGhhdmUNCj4gPiBvbg0KPiA+IG91ciBib2FyZCBhbmQgd29ya3MgYmV0dGVy
IHRoYW4gZXhwZWN0ZWQgKGF0IGxlYXN0IGJ5IG15c2VsZiA6LSkpLg0KPiANCj4gVGhlIG1ham9y
aXR5IG9mIHJlZ3VsYXRvcnMgdGhhdCBuZWVkIGNsb2NrcyBhcmUgUFdNIGRldmljZXMgd2hpY2gg
aXMgYQ0KPiB3aG9sZSBvdGhlciB0aGluZyB0aGF0IHdlIGFscmVhZHkgc3VwcG9ydC4gIFRoaXMg
aXMgYSBoaWdobHkgdW51c3VhbA0KPiBoYXJkd2FyZSBkZXNpZ24sIHdlIGRvbid0IGhhdmUgdGhl
IHJlZ21hcCBzdHVmZiBpbiB0aGUgY29yZSBhbmQgdGhhdCdzIGENCj4gbG90IG1vcmUgY29tbW9u
Lg0KDQpJIGFncmVlIHdpdGggeW91LCBiZWNhdXNlIG9mIG91ciB1bnVzdWFsIGhhcmR3YXJlIGRl
c2lnbiB0aGF0IHRoaXMNCnNob3VsZG4ndCBiZSBpbiBjb3JlLiBCdXQgSSBkbyBub3QgYWdyZWUg
b24gc29sdmluZyB0aGF0IHdpdGggcXVpcmtzLg0KDQpJbiB0aGUgZW5kIEkganVzdCB3YW50IHRv
IHJlcHJlc2VudCBvdXIgaGFyZHdhcmUgaW4gc29mdHdhcmUuIFdvdWxkIHlvdQ0KYWdyZWUgdG8g
Y3JlYXRlIGEgbmV3IGNsb2NrLXJlZ3VsYXRvci5jIGRyaXZlcj8NCk9yIHdvdWxkIGl0IG1ha2Ug
bW9yZSBzZW5zZSB0byBleHRlbmQgZml4ZWQuYyB0byBzdXBwb3J0IGNsb2Nrcy1lbmFibGUNCndp
dGhvdXQgdG91Y2hpbmcgY29yZT8NCg0KDQo=
