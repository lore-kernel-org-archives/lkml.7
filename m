Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F940206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Rfs7LSye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfDYTVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:21:10 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com ([40.107.7.133]:35685
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbfDYTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omuLiKrqQ25/6hoL9e469KLFYROxLRrWo4mHGLtbuK8=;
 b=Rfs7LSye9DhKv6m9W/QkXgGOy/WZ0gS/5gj2mS5AK1ghGhBWKrgxOGQciuLs52IUt46BJNXJybJW2Onnn1YTXnvCeY6vGN5nQJg74KPI0gXUTzV1O00H1qt+FbLKsg1d49UQPtJs6WITfaFKW73Yk3q4jX+hWrL3wvlOyesOq9E=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4510.eurprd02.prod.outlook.com (20.178.12.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Thu, 25 Apr 2019 19:21:02 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 19:21:02 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Thread-Topic: [PATCH 0/5] i2c-mux-gpio: Split plat- and dt-specific code up
Thread-Index: AQHU+poRmIG7i+VM8k2RvIFkUpub7qZL0zQAgAEgioCAAE8UgA==
Date:   Thu, 25 Apr 2019 19:21:02 +0000
Message-ID: <04133a9c-8c79-9143-5f5a-563124cb9524@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <93214e50-6f69-0e7a-c725-5e95c1bbdb45@axentia.se>
 <20190425143755.vmz3l52hrxtqu43z@mobilestation>
In-Reply-To: <20190425143755.vmz3l52hrxtqu43z@mobilestation>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0175.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::23) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec167864-889b-452d-13c6-08d6c9b327c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4510;
x-ms-traffictypediagnostic: VI1PR02MB4510:
x-microsoft-antispam-prvs: <VI1PR02MB4510F1EA0CCC76E04DD45DB7BC3D0@VI1PR02MB4510.eurprd02.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39830400003)(346002)(189003)(199004)(64756008)(4326008)(66556008)(73956011)(65806001)(66946007)(25786009)(65956001)(66066001)(66476007)(508600001)(68736007)(97736004)(256004)(36756003)(6246003)(14444005)(6486002)(31696002)(6436002)(65826007)(66446008)(229853002)(386003)(86362001)(476003)(53546011)(486006)(446003)(316002)(52116002)(2616005)(99286004)(8936002)(31686004)(76176011)(81156014)(8676002)(53936002)(64126003)(2906002)(71190400001)(74482002)(7736002)(5660300002)(6512007)(81166006)(58126008)(54906003)(11346002)(6116002)(186003)(102836004)(26005)(14454004)(6916009)(71200400001)(305945005)(3846002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4510;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hL0iRk40PKmUFVTSalrdrSZSxjnPuwJN4KcB6BKax9+0WQG/8bNQUSrJAR7ILHsYjSaUsVeJDEsZYVnwWz4b0m9k67pXvDObyXb9aCiGd/cKMVD74XQLkMdg9zM+ZzSzypjLEXSgC8MXsdOD2sbqyBg42MjEV4ofpF2evdrq/mvcAa6sDm9jvHddt0aGl8bgwgTJi0lsur6V6rXM30CH/j2D4ttSL7Bsg6xbhlJ7i/AECBX7gPW3PhKeeVmOfys+Y7LCKLaKwDn5HJAi7VyohGFU3StlEs8miCW8LYAi5I57j1ivvXsWxslfAg7xvvtp1GMOarMSqoaedonHUn/18gCP4L/FkGxJbUzLrgljg9ii5rNGTFTBmTyc+mCmmcnDl4IZ/rImaJexm8gO8ovbVIBbJLVtPuuOPjcRZUFhZVU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42C8E88529D6E8468B8D60D5A03395EB@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ec167864-889b-452d-13c6-08d6c9b327c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 19:21:02.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNSAxNjozNywgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXByIDI0
LCAyMDE5IGF0IDA5OjI1OjI0UE0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPiANCj4gSGVs
bG8gUGV0ZXIsDQo+IA0KPj4gT24gMjAxOS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6
DQo+Pj4gVGhlIG1haW4gaWRlYSBvZiB0aGlzIHBhdGNoc2V0IHdhcyB0byBhZGQgdGhlIGR0LWJh
c2VkIEdQSU9zIHN1cHBvcnQNCj4+PiBpbiBpMmMtbXV4LWdwaW8gZHJpdmVyLiBJbiBwYXJ0aWN1
bGFyIHdlIG5lZWRlZCB0byBoYXZlIHRoZSBmdWxsIEdQSU9zDQo+Pj4gc3BlY2lmaWVyIGJlaW5n
IGhhbmRsZWQgaW5jbHVkaW5nIHRoZSBkdC1mbGFncyBsaWtlIEdQSU9fQUNUSVZFX0hJR0gsDQo+
Pj4gR1BJT19BQ1RJVkVfTE9XLCBldGMuIER1ZSB0byB1c2luZyBhIGxlZ2FjeSBHUElPIGludGVy
ZmFjZSB0aGUgZm9ybWVyDQo+Pj4gZHJpdmVyIGltcGxlbWVudGF0aW9uIGRpZG4ndCBwcm92aWRl
IHRoaXMgYWJpbGl0eS4NCj4+DQo+PiBJJ20gY3VyaW91cyB3aHkgYWN0aXZlIGxvdy9oaWdoIGlz
IG9mIGFueSBpbXBvcnRhbmNlPyBUaGF0IHdpbGwgb25seSBhZmZlY3QNCj4+IHRoZSBzdGF0ZSBu
dW1iZXJpbmcsIGJ1dCBJIGZhaWwgdG8gc2VlIGFueSByZWxldmFuY2UgaW4gdGhhdCBudW1iZXJp
bmcuIEl0J3MNCj4+IGp1c3QgbnVtYmVycywgbm8/DQo+Pg0KPj4gSWYgYWxsIHRoZSBwaW5zIGFy
ZSBpbnZlcnRlZCAoYW55dGhpbmcgZWxzZSBzZWVtcyB2ZXJ5IHN0cmFuZ2UpLCBqdXN0DQo+PiBy
ZXZlcnNlIHRoZSBvcmRlci4gSS5lLiBmb3IgYSA0LXdheSBtdXgsIHVzZSAzLCAyLCAxLCAwIGlu
c3RlYWQgb2YNCj4+IDAsIDEsIDIsIDMuDQo+Pg0KPj4gV2h5IG5vdD8NCj4gDQo+IEkgbWF5IG1p
c3VuZGVyc3Rvb2QgeW91LCBidXQgYWN0aXZlIGxvdy9oaWdoIGZsYWcgaGFzIG5vdGhpbmcgdG8g
ZG8gd2l0aA0KPiBwaW5zIG9yZGVyaW5nLiBJdCBpcyByZWxldmFudCB0byBhbiBpbmRpdmlkdWFs
IHBpbiBzZXR0aW5nLCBtb3N0IGxpa2VseQ0KPiByZWxhdGVkIHdpdGggaGFyZHdhcmUgc2V0dXAu
DQoNCkkgd2FzIG5vdCB0YWxraW5nIGFib3V0IHBpbiBvcmRlci4gSSB3YXMgb2J2aW91c2x5IHJl
ZmVycmluZyB0byB0aGUNCnN0YXRlIG9yZGVyLg0KDQo+IEhlcmUgaXMgYSBzaW1wbGUgZXhhbXBs
ZToNCj4gaTJjbXV4IHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaTJjLW11eC1n
cGlvIjsNCj4gICAgICAgICAgICAgICAgIG11eC1ncGlvcyA9IDwmZ3Bpb2EgMCBHUElPX0FDVElW
RV9MT1cNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY29udHJvbCAyIEdQSU9fQUNU
SVZFX0hJR0gNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbGFzdCA1IEdQSU9fQUNU
SVZFX0xPVz47DQo+IH07DQoNClNvLCB3aXRoIHRoaXMsIGluc3RlYWQgb2YgaGF2aW5nIHR3byBw
aW5zIGFjdGl2ZS1sb3cgYW5kIHVzaW5nIHN0YXRlIDMsDQp5b3UgY291bGQgdXNlIHN0YXRlIDYg
d2l0aCBhbGwgcGlucyBhY3RpdmUtaGlnaC4gU2FtZSB0aGluZy4gSS5lLiwgdXNlDQoic3RhdGUg
XiA1IiBpbnN0ZWFkIG9mIHRoZSAiZGlyZWN0IiBzdGF0ZSAod2hhdGV2ZXIgdGhhdCBpcywgdGhl
IHN0YXRlDQpudW1iZXJzIGhhdmUgbm8gcmVhbCBtZWFuaW5nLCB0aGV5IGFyZSBqdXN0IG51bWJl
cnMpLg0KDQo+IEluIHRoaXMgc2V0dXAgd2UndmUgZ290IHNvbWUgaTJjLW11eCB3aXRoIEdQSU9z
LWRyaXZlbiBjaGFubmVsIHNlbGVjdG9yLg0KPiBGaXJzdCBjaGFubmVsIGlzIHNlbGVjdGVkIGJ5
IEdQSU8jMCBvZiBjb250cm9sbGVyICZncGlvYSwgc2Vjb25kIG9uZSAtDQo+IGJ5IEdQSU8jMiBv
ZiBjb250cm9sbGVyICZjb250cm9sIGFuZCB0aGlyZCAtIGJ5IEdQSU8jMyBvZiBjb250cm9sbGVy
DQo+ICZsYXN0LiBJbiBhY2NvcmRhbmNlIHdpdGggdGhlIGkyY19tdXhfZ3Bpb19zZXQoKSBtZXRo
b2Qgb2YgaTJjLW11eC1ncGlvDQo+IGRyaXZlciBhIEdQSU8gZnJvbSB0aGlzIHNldCB3aWxsIGJl
IGRyaXZlbiBoaWdoIGluIGNhc2Ugb2YgYSBjb3JyZXNwb25kaW5nDQo+IG11eCBjaGFubmVsIGJl
aW5nIGVuYWJsZWQuIEJ1dCBhcyB5b3UgY2FuIHNlZSBmcm9tIHRoZSAibXV4LWdwaW9zIiBwcm9w
ZXJ0eQ0KPiB0aGVzZSBHUElPcyBhcmVuJ3QgaWRlbnRpY2FsLiBGaXJzdCBvZiBhbGwgdGhleSBi
ZWxvbmcgdG8gZGlmZmVyZW50DQo+IGNvbnRyb2xsZXIgYW5kIG1vc3QgaW1wb3J0YW50bHkgdGhl
eSd2ZSBnb3QgZGlmZmVyZW50IGFjdGl2ZS1hdHRyaWJ1dGUuDQo+IFRoaXMgYXR0cmlidXRlIGFj
dHVhbGx5IG1lYW5zIHRoZSBzdHJhaWdodCBvciBpbnZlcnRlZCBhY3RpdmF0aW9uIHBvbGljeS4N
Cj4gU28gaW4gY2FzZSBvZiBBQ1RJVkVfSElHSCBmbGFnIHlvdSBnZXQgYSBzdHJhaWdodCBwb2xp
Y3kuIElmIHlvdSBzZXQgR1BJTycNCj4gdmFsdWUgdGhlIGhhcmR3YXJlIHBpbiB3aWxsIGJlIGRy
aXZlbiBoaWdoLCBhbmQgaWYgeW91IGNsZWFyIGl0IEdQSU8nDQo+IHZhbHVlIHRoZSBoYXJkd2Fy
ZSBwaW4gd2lsbCBiZSBwdXNoZWQgdG8gZ3JvdW5kLiBJbiBjYXNlIEFDVElWRV9MT1cgZmxhZw0K
PiBpcyBzcGVjaWZpZWQsIHRoZSBHUElPIGFuZCBhY3R1YWwgaGFyZHdhcmUgcGluIHZhbHVlcyBh
cmUgaW52ZXJ0ZWQuDQo+IFNvIGlmIHlvdSBzZXQgR1BJTyB0byBvbmUsIHRoZSBoYXJkd2FyZSBw
aW4gd2lsbCBiZSBkcml2ZW4gdG8gemVybywNCj4gYW5kIHZpc2UtdmVyc2EuIEFsbCB0aGlzIGxv
Z2ljIGlzIGltcGxlbWVudGVkIGluIHRoZSBncGlvZCBzdWJzeXN0ZW0NCj4gb2YgdGhlIGtlcm5l
bCBhbmQgY2FuIGJlIGRlZmluZWQgaW4gZHRzIHNjcmlwdHMsIHdoaWxlIGxlZ2FjeSBHUElPDQo+
IHN1YnN5c3RlbSByZWxpZWQgb24gdGhlIGRyaXZlcnMgdG8gaGFuZGxlIHRoaXMuDQo+IA0KPiBZ
ZWFoLCBpdCBtaWdodCBiZSBjb25mdXNpbmcsIGJ1dCBzb21lIGhhcmR3YXJlIGlzIGRlc2lnbmVk
IHRoaXMgd2F5LCBzbw0KPiB0aGUgb3JkaW5hcnkgR1BJTyBvdXRwdXRzIGFyZSBpbnZlcnRlZCBv
biB0aGUgd2F5IHRvIHRoZSBpMmMtbXV4IGNoYW5uZWwNCj4gYWN0aXZhdG9ycy4gRm9yIGluc3Rh
bmNlIGluIGNhc2UgaWYgc29tZSBsZXZlbC1zaGlmdGVyIGlzIHVzZWQgYXMgYSBzaW5nbGUNCj4g
Y2hhbm5lbCBpMmMtbXV4IGFuZCB3ZSBkb24ndCB3YW50IGkyYy1idXMgYmVpbmcgYWx3YXlzIGNv
bm5lY3RlZCB0byBhIGJ1cw0KPiBiZWhpbmQgaXQuIFN1Y2ggbGV2ZWwtc2hpZnRlcnMgYXJlIHVz
dWFsbHkgYWN0aXZhdGVkIGJ5IEFDVElWRV9MT1cgc2lnbmFscy4NCg0KU2VlIGFib3ZlLCB5b3Ug
Y291bGQganVzdCBhZGp1c3QgdGhlIHN0YXRlIG51bWJlcnMgaW5zdGVhZC4NCg0KPiBJbiBhZGRp
dGlvbiB0aGVyZSBhcmUgb3RoZXIgdGhhbiBBQ1RJVkVfTE9XL0FDVElWRV9ISUdIIGZsYWdzIGF2
YWlsYWJsZSBmb3INCj4gR1BJT3MgaW4gZHRzLCBsaWtlIEdQSU9fUFVTSF9QVUxMLCBHUElPX09Q
RU5fRFJBSU4sIEdQSU9fT1BFTl9TT1VSQ0UsIHdoaWNoIGFyZQ0KPiBhbHNvIHNwZWNpZmljIG5v
dCBvbmx5IHRvIHRoZSBHUElPIGZ1bmN0aW9uYWxpdHkgYnV0IHRvIHRoZSB0YXJnZXQgcG9ydCBh
bmQNCj4gaGFyZHdhcmUgZGVzaWduIGluIGdlbmVyYWwuIFNvIHRoZSBzdXBwb3J0IG9mIGR0LSBH
UElPLXNwZWNpZmllcnMgaXMgdmVyeQ0KPiBpbXBvcnRhbnQgdG8gcHJvcGVybHkgZGVzY3JpYmUg
dGhlIGhhcmR3YXJlIHNldHVwLg0KDQpUaGVzZSB0aGluZ3MgYXJlIGFub3RoZXIgbWF0dGVyLiBJ
IHRob3VnaHQgdGhpcyB3YXMgc3VwcG9zZWQgdG8gYmUNCmNvbnRyb2xsZWQgd2l0aCBwaW5jdHJs
IGRyaXZlcnMsIGJ1dCBub3cgdGhhdCBJIGxvb2sgSSBzZWUgdGhhdCBncGlvDQpkcml2ZXJzIGNh
biBkbyB0aGlzIGRpcmVjdGx5IHdpdGhvdXQgaGVscCBmcm9tIHBpbmN0cmwuIFRoYXQncyBqdXN0
DQpub3QgaG93IGl0IGhhcyBiZWVuIGRvbmUgb24gdGhlIHBsYXRmb3JtcyBJIGhhdmUgYmVlbiB1
c2luZy4uLg0KDQpTbywgb2ssIGJ1dCBvcGVuLWRyYWluL29wZW4tc291cmNlL3B1c2gtcHVsbCBz
aG91bGQgcGVyaGFwcyBoYXZlIGJlZW4NCm1lbnRpb25lZCBtb3JlIHByb21pbmVudGx5LiAoSSBu
b3cgc2VlIHRoYXQgSSBtYW5hZ2VkIHRvIHJlYWQgcGFzdCBhDQptZW50aW9uIG9mIG9wZW4tZHJh
aW4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGZvciA1LzUpDQoNCkNoZWVycywNClBldGVyDQoNCj4g
LVNlcmdleQ0KPiANCj4+DQo+PiBDaGVlcnMsDQo+PiBQZXRlcg0KPj4NCj4+PiBPbiB0aGUgd2F5
IG9mIGFkZGluZyB0aGUgZnVsbCBkdC1HUElPIGZsYWdzIHN1cHBvcnQgYSBzbWFsbCBzZXQgb2YN
Cj4+PiByZWZhY3RvcmluZ3MgaGFzIGJlZW4gZG9uZSBpbiBvcmRlciB0byBrZWVwIHRoZSBwbGF0
Zm9ybV9kYXRhLWJhc2VkDQo+Pj4gc3lzdGVtcyBzdXBwb3J0LCBtYWtlIHRoZSBjb2RlIG1vcmUg
cmVhZGFibGUgYW5kIHRoZSBhbHRlcmF0aW9ucyAtIGNsZWFyZXIuDQo+Pj4gSW4gZ2VuZXJhbCB0
aGUgd2hvbGUgY2hhbmdlcyBtaWdodCBiZSBjb25zaWRlcmVkIGFzIHRoZSBwbGF0LSBhbmQgZHQt
DQo+Pj4gc3BlY2lmaWMgY29kZSBzcGxpdCB1cC4gSW4gZmlyc3QgcGF0Y2ggd2UgdW5waW5uZWQg
dGhlIHBsYXRmb3JtLXNwZWNpZmljDQo+Pj4gbWV0aG9kIG9mIEdQSU8tY2hpcCBwcm9iaW5nLiBU
aGUgc2Vjb25kIHBhdGNoIG1ha2VzIHRoZSBkcml2ZXIgdG8gcmV0dXJuDQo+Pj4gYW4gZXJyb3Ig
aWYgb2YtYmFzZWQgKGxhc3QgcmVzb3J0IHBhdGgpIGZhaWxlZCB0byByZXRyaWV2ZSB0aGUgZHJp
dmVyDQo+Pj4gcHJpdmF0ZSBkYXRhLiBUaGUgbmV4dCB0aHJlZSBwYXRjaGVzIGlzIHRoZSBzZXF1
ZW5jZSBvZiBpbml0aWFsIGNoYW5uZWwNCj4+PiBpbmZvIHJldHJpZXZhbCwgcGxhdGZvcm1fZGF0
YS1zcGVjaWZpYyBjb2RlIGlzb2xhdGlvbiBhbmQgZmluYWxseSBmdWxsDQo+Pj4gZHQtYmFzZWQg
R1BJT3MgcmVxdWVzdCBtZXRob2QgaW50cm9kdWN0aW9uLiBUaGUgbGFzdCBwYXRjaCBkb2VzIHdo
YXQNCj4+PiB3ZSBpbnRlZGVkIHRoaXMgcGF0Y2hzZXQgZm9yIGluIHRoZSBmaXJzdCBwbGFjZSAt
IGFkZHMgdGhlIGZ1bGwgZHQtR1BJTw0KPj4+IHNwZWNpZmllcnMgc3VwcG9ydC4NCj4+Pg0KPj4+
DQo+Pj4gU2VyZ2UgU2VtaW4gKDUpOg0KPj4+ICAgaTJjLW11eC1ncGlvOiBVbnBpbiBhIHBsYXRm
b3JtLWJhc2VkIGRldmljZSBpbml0aWFsaXphdGlvbg0KPj4+ICAgaTJjLW11eC1ncGlvOiBSZXR1
cm4gYW4gZXJyb3IgaWYgbm8gY29uZmlnIGRhdGEgZm91bmQNCj4+PiAgIGkyYy1tdXgtZ3Bpbzog
U2F2ZSBpbml0aWFsIGNoYW5uZWwgbnVtYmVyIHRvIHRoZSBpZGxlIGRhdGEgZmllbGQNCj4+PiAg
IGkyYy1tdXgtZ3BpbzogVW5waW4gdGhlIHBsYXRmb3JtLXNwZWNpZmljIEdQSU9zIHJlcXVlc3Qg
Y29kZQ0KPj4+ICAgaTJjLW11eC1ncGlvOiBDcmVhdGUgb2YtYmFzZWQgR1BJT3MgcmVxdWVzdCBt
ZXRob2QNCj4+Pg0KPj4+ICBkcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYyB8IDIyNCAr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNDYg
aW5zZXJ0aW9ucygrKSwgNzggZGVsZXRpb25zKC0pDQo+Pj4NCj4+DQoNCg==
