Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C003FC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8520693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ChyBFdyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfD0RPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:15:11 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:38658
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfD0RPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyxFaF53jMJjJShLW2ps8KIbbZ482FRAZMNxH65by0g=;
 b=ChyBFdySC4MnrgUDKNImBXUctSfTAvasBO6vmSfK6AQMDMWMeTAVqoZ5ym9iELLP0m/To5fB/Fkj136/51J51T+Q/s+Lwhbm133eIS3fQ57BvE1IFdKt+H1EPNx5T1yyDoFQbsPQW/4t2NfXHsO5M4MYPX17o+mzhu/PUn2WRcE=
Received: from AM5PR0501MB2546.eurprd05.prod.outlook.com (10.169.150.142) by
 AM5PR0501MB2516.eurprd05.prod.outlook.com (10.169.153.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Sat, 27 Apr 2019 17:15:07 +0000
Received: from AM5PR0501MB2546.eurprd05.prod.outlook.com
 ([fe80::7492:a69b:3c2:8d2a]) by AM5PR0501MB2546.eurprd05.prod.outlook.com
 ([fe80::7492:a69b:3c2:8d2a%2]) with mapi id 15.20.1835.015; Sat, 27 Apr 2019
 17:15:07 +0000
From:   Moshe Shemesh <moshe@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Saeed Mahameed <saeedm@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Topic: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Index: AQHU+1XYqC6+wlZl5E+t2wQM3bIiOqZNZ9uAgABEHACAAA9igIAA4WuAgAAEQYCAAaHMAA==
Date:   Sat, 27 Apr 2019 17:15:06 +0000
Message-ID: <43faf9b6-9202-9f4e-18b4-64c195c02b1a@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
 <20190425143847.417033ab@cakuba.netronome.com>
 <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
 <20190425193737.131be39f@cakuba.netronome.com>
 <8bb8a789-c189-df07-5d90-fd8f2fa172ca@mellanox.com>
 <CAJpBn1wN67rTM2Gn-nsh0hTjq6OM2m6DS+BGU-HhSQ5ehn95Cw@mail.gmail.com>
In-Reply-To: <CAJpBn1wN67rTM2Gn-nsh0hTjq6OM2m6DS+BGU-HhSQ5ehn95Cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [84.109.177.105]
x-clientproxiedby: AM0PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::49) To AM5PR0501MB2546.eurprd05.prod.outlook.com
 (2603:10a6:203:c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=moshe@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b4f688-0993-4c2a-e830-08d6cb33e3a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0501MB2516;
x-ms-traffictypediagnostic: AM5PR0501MB2516:
x-microsoft-antispam-prvs: <AM5PR0501MB2516F93985C34194D66993AED93F0@AM5PR0501MB2516.eurprd05.prod.outlook.com>
x-forefront-prvs: 0020414413
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39850400004)(136003)(199004)(189003)(3846002)(58126008)(6116002)(66066001)(65956001)(36756003)(316002)(65806001)(2906002)(54906003)(93886005)(14444005)(66476007)(66556008)(64756008)(66446008)(256004)(66946007)(64126003)(31686004)(53936002)(6916009)(73956011)(6246003)(6512007)(68736007)(8676002)(31696002)(81156014)(81166006)(6506007)(86362001)(4326008)(229853002)(25786009)(65826007)(6436002)(486006)(2616005)(71190400001)(71200400001)(53546011)(102836004)(7736002)(26005)(99286004)(305945005)(5660300002)(478600001)(14454004)(76176011)(97736004)(386003)(52116002)(6486002)(186003)(11346002)(446003)(8936002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB2516;H:AM5PR0501MB2546.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mot+Z/HXnwXLjvL38MwRY9RaNALuDzU4YZc/wPuQlZ8Utmc9LT6M0VQ/6hEyrNYP3si4I12mJ2rjfi6zDCNAjyKjkC6QNKsUUOi+P4Fq+HFhLLgDivtxxMzG2PDCR/B0/+KjQgUXvcTMFj8jGEN4Gp8LtPjo77C2/2+AVCCqCQcciTbffbr1YOYGBHScn3fsntnHo007EKaZ+4hrn3sWLljmQYS2z0MMxNlQk9e1zbI13i7lkDm+IeMmhOowGLTYZ1tpPvD5+vLsdW+3Cd7lqeCTTadWfZqC4YVBJVcnSOAYKV4ydEPZNy94ZI8rMNP328BXuCkAoG5ddEZSkmxAREHhvpog3L2Z/izvc2lB+KziBlN+IDYYtjvG42hhNgpvWbMCgMjTIGPx/yGo9tFn7VruUnbJw1BpWtrtoYE2dUI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5653C37F2C17364284437706E3E2E3BA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b4f688-0993-4c2a-e830-08d6cb33e3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2019 17:15:07.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB2516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjYvMjAxOSA3OjE5IFBNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gT24gRnJp
LCBBcHIgMjYsIDIwMTkgYXQgNjowNCBBTSBNb3NoZSBTaGVtZXNoIDxtb3NoZUBtZWxsYW5veC5j
b20+IHdyb3RlOg0KPj4gT24gNC8yNi8yMDE5IDU6MzcgQU0sIEpha3ViIEtpY2luc2tpIHdyb3Rl
Og0KPj4+IE9uIEZyaSwgMjYgQXByIDIwMTkgMDE6NDI6MzQgKzAwMDAsIFNhZWVkIE1haGFtZWVk
IHdyb3RlOg0KPj4+Pj4+IEBAIC00ODEzLDcgKzQ4MzEsMTEgQEAgc3RhdGljIGludA0KPj4+Pj4+
IGRldmxpbmtfbmxfY21kX2hlYWx0aF9yZXBvcnRlcl9yZWNvdmVyX2RvaXQoc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCj4+Pj4+PiAgICAgaWYgKCFyZXBvcnRlcikNCj4+Pj4+PiAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4+Pj4+Pg0KPj4+Pj4+IC0gIHJldHVybiBkZXZsaW5rX2hlYWx0aF9y
ZXBvcnRlcl9yZWNvdmVyKHJlcG9ydGVyLCBOVUxMKTsNCj4+Pj4+PiArICBpZiAoIXJlcG9ydGVy
LT5vcHMtPnJlY292ZXIpDQo+Pj4+Pj4gKyAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+
Pj4+Pj4gKw0KPj4+Pj4+ICsgIHF1ZXVlX3dvcmsoZGV2bGluay0+cmVwb3J0ZXJzX3dxLCAmcmVw
b3J0ZXItPnJlY292ZXJfd29yayk7DQo+Pj4+Pj4gKyAgcmV0dXJuIDA7DQo+Pj4+Pj4gICAgfQ0K
Pj4+Pj4NCj4+Pj4+IFNvIHRoZSByZWNvdmVyIHVzZXIgc3BhY2UgcmVxdWVzdCB3aWxsIG5vIGxv
bmdlciByZXR1cm4gdGhlIHN0YXR1cywNCj4+Pj4+IGFuZA0KPj4+Pj4gaXQgd2lsbCBub3QgYWN0
dWFsbHkgd2FpdCBmb3IgdGhlIHJlY292ZXIgdG8gaGFwcGVuLiAgTGVhdmluZyB1c2VyDQo+Pj4+
PiBwb25kZXJpbmcgLSBkaWQgdGhlIHJlY292ZXIgcnVuIGFuZCBmYWlsLCBvciBkaWQgaXQgbm9y
IGdldCBydW4NCj4+Pj4+IHlldC4uLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gd2FpdF9mb3JfY29tcGxl
dGlvbl9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQgaXMgbWlzc2luZyBmcm9tIHRoZSBkZXNpZ24gPw0K
Pj4+DQo+Pj4gUGVyaGFwcywgYnV0IEkgdGhpbmsgaXRzIGJldHRlciB0byBhdm9pZCB0aGUgYXN5
bmMgZXhlY3V0aW9uIG9mDQo+Pj4gdGhlIHJlY292ZXIgYWxsIHRvZ2V0aGVyLiAgUGVyaGFwcyBp
dHMgYmV0dGVyIHRvIHJlZmNvdW50IHRoZQ0KPj4+IHJlcG9ydGVycyBvbiB0aGUgY2FsbCB0byBy
ZWNvdmVyX2RvaXQ/ICBPciBzb21lIHN1Y2guLiA6KQ0KPj4+DQo+Pg0KPj4gSSB0cmllZCB1c2lu
ZyByZWZjb3VudCBpbnN0ZWFkIG9mIGRldmxpbmsgbG9jayBoZXJlLiBCdXQgb25jZSBJIGdldCB0
bw0KPj4gcmVwb3J0ZXIgZGVzdHJveSBJIHdhaXQgZm9yIHRoZSByZWZjb3VudCBhbmQgbm90IHN1
cmUgaWYgSSBzaG91bGQNCj4+IHJlbGVhc2UgdGhlIHJlcG9ydGVyIGFmdGVyIHNvbWUgdGltZW91
dCBvciBoYXZlIGVuZGxlc3Mgd2FpdCBmb3INCj4+IHJlZmNvdW50LiBCb3RoIG9wdGlvbnMgc2Vl
bSBub3QgZ29vZC4NCj4gDQo+IFdlbGwgeW91IHNob3VsZCAiZW5kbGVzc2x5IiB3YWl0LiAgV2h5
IHdvdWxkIHRoZSByZWZjb3VudCBub3QgZHJvcCwNCj4geW91IGhhdmUgdG8gcmVtb3ZlIGl0IGZy
b20gdGhlIGxpc3QgZmlyc3QsIHNvIG5vIG5ldyBvcGVyYXRpb25zIGNhbg0KPiBzdGFydCwgcmln
aHQ/DQo+IEluIHByaW5jaXBsZSB0aGVyZSBpcyBubyBkaWZmZXJlbmNlIGJldHdlZW4gd2FpdGlu
ZyBmb3IgcmVmY291bnQgdG8NCj4gZHJvcCwgZmx1c2hpbmcgdGhlIHdvcmssIG9yIHdhaXRpbmcg
Zm9yIHRoZSBkZXZsaW5rIGxvY2sgaWYgcmVwb3J0ZXINCj4gaG9sZHMgaXQ/DQo+IA0KTWFrZXMg
c2Vuc2UsIEkgd2lsbCByZXdyaXRlIHRoaXMgcGF0Y2gsIHRoYW5rcy4NCg==
