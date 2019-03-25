Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C34EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9DA20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FQJbu9rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfCYNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:14:00 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:55273
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730545AbfCYNOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFFEIRDslJefBAyiiBheYGVFXi907zaXFDPE99IdjZM=;
 b=FQJbu9rWeR7VigS0oAbvDi3rdyJ3cYhNVvBg2qXZqjG0qmY6v2xnu3OmE1YQORgCXC+tvngoixHGxDR6vhYMKg3hgMBPGpyiJdFbws9HdnVq6rnGdadhxxAhDQsvhFPZJ3XYF7eO6AKtKwqKCZob1hIJ2F9vXegfww9SMbRwV6Q=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2399.eurprd08.prod.outlook.com (10.175.25.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 13:13:55 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::24ef:2725:26cc:ae35]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::24ef:2725:26cc:ae35%8]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 13:13:55 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Nick Terrell <terrelln@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: Kernel LZO compressor
Thread-Topic: Kernel LZO compressor
Thread-Index: AQHU3pByWt4yBWNOP0ewGbmZjuuI6KYcXA+A
Date:   Mon, 25 Mar 2019 13:13:55 +0000
Message-ID: <3996dd23-75ab-1619-8ef4-3025436ed4f8@arm.com>
References: <31D143C0-D64F-4905-B25F-5C3630D38913@fb.com>
In-Reply-To: <31D143C0-D64F-4905-B25F-5C3630D38913@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0c59c11-bc68-445e-2c68-08d6b123bbaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2399;
x-ms-traffictypediagnostic: VI1PR0802MB2399:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0802MB2399CE032B17A0CC3AC188928F5E0@VI1PR0802MB2399.eurprd08.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(40434004)(99286004)(14454004)(6486002)(6246003)(7116003)(6306002)(53936002)(966005)(2501003)(6436002)(52116002)(316002)(110136005)(2906002)(6512007)(26005)(86362001)(229853002)(25786009)(76176011)(102836004)(53546011)(386003)(6506007)(31696002)(446003)(11346002)(97736004)(476003)(2616005)(71200400001)(66066001)(31686004)(486006)(8676002)(81166006)(71190400001)(44832011)(106356001)(105586002)(256004)(14444005)(5024004)(68736007)(8936002)(478600001)(7736002)(3480700005)(305945005)(5660300002)(3846002)(6116002)(36756003)(81156014)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2399;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wpxMakyPmRaqPmFyOOlicP2C0loVI+qYkXC6JR6tNpgnuWylVKKu1RuZbJrpOJLKZHtpxW/kgQA2TGWNEv/gCmpOgtK0MP1XgV+M9lPvsFAV/apiR34ICtKiLh/DQ3imFluinOI2llT34pz6rWXIZFnZ4Hfqn23GBIfc1xPJCLQCKRn93zs4JXQOi8Z7zzVzb3N06WMozXbd8IufLpooIc0JtX96+z08MGZzZe17NQaUB2FObeuGFLqPNbMbKgUq2Pujl9KwmKmzYuecTdvvelWwRYk/qIK67KSewHs8Q5qe8g92SftyH5RfjSGpbdmbbFKBjPbGkmV11gvcQP+zk3xSEf0py95XTSSwaUyvD/9uHL5BeDsaVeduliKJ6vxV662kF9arPUnBO+RqyHe8EnbUnxx0yUadGhYHYRzQO+c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6043B300CE5B65439B3D3AEF5A767FD0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c59c11-bc68-445e-2c68-08d6b123bbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 13:13:55.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDMvMjAxOSA4OjE1IHBtLCBOaWNrIFRlcnJlbGwgd3JvdGU6DQo+IEhpIERhdmUsDQo+
DQo+IEkganVzdCBzYXcgeW91IHBhdGNoZXMgYWRkaW5nIExaTy1STEUsIHNvIEkgZGVjaWRlZCB0
byBmdXp6IHRoZSBMWk8NCj4gY29tcHJlc3NvciBhbmQgZGVjb21wcmVzc29yLiBJIGRpZG4ndCBm
aW5kIGFueSBjcmFzaGVzLCBidXQgSSBmb3VuZCBzb21lIGVkZ2UNCj4gY2FzZXMgaW4gdGhlIGRl
Y29tcHJlc3Nvci4NCg0KSGkgTmljaywNCg0KVGhhbmtzIC0gSSB3aWxsIHRha2UgYSBsb29rIGF0
IHRoaXMuIFRoZXNlIGNhc2VzIHdvbid0IGFmZmVjdCB6cmFtLCB3aGljaCBpcw0KY3VycmVudGx5
IHRoZSBvbmx5IHBsYWNlIGx6by1ybGUgaXMgdXNlZCwgYmVjYXVzZSB6cmFtIG9wZXJhdGVzIG92
ZXIgY29tcGxldGUNCnBhZ2VzLCBidXQgSSB3b3VsZCBwcmVmZXIgbm90IHRvIGhhdmUgdGhpcyBr
aW5kIG9mIGVkZ2UgY2FzZSBsdXJraW5nLg0KDQpQcmVzdW1hYmx5IHRoZSBmdXp6ZXIgZ2VuZXJh
dGVzIGlucHV0cyBvZiB2YXJpb3VzIHNpemVzIC0gaG93IGxhcmdlIGRpZCB5b3UNCnRlc3QgdXAg
dG8/DQoNCnRoYW5rcw0KDQpEYXZlDQoNCj4NCj4gQWZ0ZXIgY29tcHJlc3NpbmcgdGhlIGVtcHR5
IGlucHV0IHdpdGggbHpvMXhfMV9jb21wcmVzcygpIEkgZ2V0DQo+IFsweDExLCAweDAwLCAweDAw
XSB3aGljaCBpcyByZWplY3RlZCBieSBsem8xeF9kZWNvbXByZXNzX3NhZmUoKSBvbiBsaW5lIDYw
DQo+IGJlY2F1c2UgKmlwID09IDE3IGFuZCBpbl9sZW4gPCA1IHdpdGggZXJyb3IgTFpPX0VfSU5Q
VVRfT1ZFUlJVTi4NCj4NCj4gQWZ0ZXIgY29tcHJlc3NpbmcgdGhlIGlucHV0IFsweDAwXSB3aXRo
IGx6b3JsZTF4XzFfY29tcHJlc3MoKSBJIGdldA0KPiBbMHgxMSwgMHgwMSwgMHgwMCwgMHgxMSwg
MHgwMCwgMHgwMF0gd2hpY2ggaXMgcmVqZWN0ZWQgYnkNCj4gbHpvMXhfZGVjb21wcmVzc19zYWZl
KCkgd2l0aCBlcnJvciBMWk9fRV9PVVRQVVRfT1ZFUlJVTi4NCj4NCj4gSSBwb3J0ZWQgTFpPIHRv
IHVzZXJzcGFjZSBieSBjb3B5aW5nIHRoZSBoZWFkZXJzIGZyb20gdGhlIGtlcm5lbCB0bw0KPiB1
c2Vyc3BhY2UgYW5kL29yIHJld3JpdGluZyB0aGVtLiBUaGUgZnV6emVycyBhbmQgcG9ydGVkIExa
TyBhcmUgaW4NCj4gYSBHaXRIdWIgcmVwbyBzbyBpdCBjYW4gYmUgZWFzaWx5IHJlcHJvZHVjZWQg
WzFdLiBUaGUgY29tcHJlc3Npb24NCj4gZnV6emVyIGlzIGFsc28gaW5jbHVkZWQgaW5saW5lIGJl
bG93Lg0KPg0KPiBgYGANCj4gI3VuZGVmIE5ERUJVRw0KPiAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+
ICNpbmNsdWRlIDxzdGRpbnQuaD4NCj4gI2luY2x1ZGUgPHN0ZGRlZi5oPg0KPiAjaW5jbHVkZSA8
c3RkbGliLmg+DQo+ICNpbmNsdWRlIDxhc3NlcnQuaD4NCj4gI2luY2x1ZGUgPHN0ZGlvLmg+DQo+
DQo+ICNpbmNsdWRlICJsem8uaCINCj4NCj4gY2hhciB3cmttZW1bTFpPMVhfTUVNX0NPTVBSRVNT
XTsNCj4NCj4gI2RlZmluZSBSTEUgMQ0KPg0KPiBleHRlcm4gIkMiIGludCBMTFZNRnV6emVyVGVz
dE9uZUlucHV0KGNvbnN0IHVpbnQ4X3QgKmRhdGEsIHNpemVfdCBzaXplKSB7DQo+ICAgc2l6ZV90
IG91dFNpemUgPSBsem8xeF93b3JzdF9jb21wcmVzcyhzaXplKTsNCj4gICB1aW50OF90KiBjb25z
dCBvdXQgPSAodWludDhfdCopbWFsbG9jKG91dFNpemUpOw0KPiAgIGFzc2VydChvdXQpOw0KPiAj
aWYgUkxFDQo+ICAgYXNzZXJ0KExaT19FX09LID09IGx6b3JsZTF4XzFfY29tcHJlc3MoZGF0YSwg
c2l6ZSwgb3V0LCAmb3V0U2l6ZSwgd3JrbWVtKSk7DQo+ICNlbHNlDQo+ICAgYXNzZXJ0KExaT19F
X09LID09IGx6bzF4XzFfY29tcHJlc3MoZGF0YSwgc2l6ZSwgb3V0LCAmb3V0U2l6ZSwgd3JrbWVt
KSk7DQo+ICNlbmRpZg0KPiAgIHVpbnQ4X3QqIGNvbnN0IHJ0ID0gKHVpbnQ4X3QqKW1hbGxvYyhz
aXplKTsNCj4gICBhc3NlcnQocnQpOw0KPiAgIHNpemVfdCBydHNpemUgPSBzaXplOw0KPiAgIGlu
dCBjb25zdCByZXQgPSBsem8xeF9kZWNvbXByZXNzX3NhZmUob3V0LCBvdXRTaXplLCBydCwgJnJ0
c2l6ZSk7DQo+ICAgaWYgKHJldCAhPSBMWk9fRV9PSykgew0KPiAgICAgYXNzZXJ0KHNpemUgPCA0
KTsNCj4gICAgIGZwcmludGYoc3RkZXJyLCAiSU5QVVQ6ICIpOw0KPiAgICAgZm9yIChzaXplX3Qg
aSA9IDA7IGkgPCBzaXplOyArK2kpDQo+ICAgICAgIGZwcmludGYoc3RkZXJyLCAiJXUgIiwgKHVu
c2lnbmVkKWRhdGFbaV0pOw0KPiAgICAgZnByaW50ZihzdGRlcnIsICJcbk9VVFBVVDogIik7DQo+
ICAgICBmb3IgKHNpemVfdCBpID0gMDsgaSA8IG91dFNpemU7ICsraSkNCj4gICAgICAgZnByaW50
ZihzdGRlcnIsICIldSAiLCAodW5zaWduZWQpb3V0W2ldKTsNCj4gICAgIGZwcmludGYoc3RkZXJy
LCAiXG5yZXQgPSAlZFxuIiwgcmV0KTsNCj4gICB9DQo+ICAgYXNzZXJ0KHJldCA9PSBMWk9fRV9P
Syk7DQo+ICAgYXNzZXJ0KHJ0c2l6ZSA9PSBzaXplKTsNCj4gICBhc3NlcnQobWVtY21wKGRhdGEs
IHJ0LCBzaXplKSA9PSAwKTsNCj4gICBmcmVlKG91dCk7DQo+ICAgZnJlZShydCk7DQo+ICAgcmV0
dXJuIDA7DQo+IH0NCj4gYGBgDQo+DQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vdGVycmVsbG4v
bHpvLXVzZXJzcGFjZS1mdXp6DQo+DQo+IEJlc3QsDQo+IE5pY2sgVGVycmVsbA0KPg0KDQpJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIg
cGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZv
cm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
