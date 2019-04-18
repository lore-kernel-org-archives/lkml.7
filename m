Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D188C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9620869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UJJBKKEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbfDRPeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:34:00 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:31207
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388277AbfDRPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFz3jyAEM2LkXnZ5xCKQKhvNkgUyrEK1xo73LRYbJPw=;
 b=UJJBKKEqUF1pjTscE5PjLvId5hXu61SY35T5E26h0tNTd6cVmOW7hZfwJZqDtgDMmLabrZ6v7m+QKBoWTYbMohVMagM9Q+F6cm9WXbBf67gm5LasytYz8rpzqJlfeNrJwICTDHWF/b69LjuHJB/OtYpNAKzavO55bJXdWgx4XQk=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4448.eurprd08.prod.outlook.com (20.179.24.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 18 Apr 2019 15:33:13 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 15:33:13 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>
CC:     nd <nd@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v8)
Thread-Topic: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and
 thread creation (v8)
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IA=
Date:   Thu, 18 Apr 2019 15:33:13 +0000
Message-ID: <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <20190416173216.9028-2-mathieu.desnoyers@efficios.com>
 <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
 <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
In-Reply-To: <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::15) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ec162ab-aaf2-4387-65c8-08d6c4132b37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4448;
x-ms-traffictypediagnostic: VI1PR08MB4448:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB4448EB448C2F40F0B5AD4E75ED260@VI1PR08MB4448.eurprd08.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(97736004)(31696002)(14454004)(86362001)(65826007)(6246003)(3846002)(53936002)(6636002)(305945005)(6486002)(6116002)(2906002)(31686004)(72206003)(478600001)(64126003)(5660300002)(26005)(386003)(53546011)(6506007)(476003)(68736007)(6512007)(6436002)(7736002)(446003)(2616005)(4326008)(11346002)(486006)(186003)(25786009)(102836004)(52116002)(99286004)(66066001)(229853002)(76176011)(14444005)(93886005)(256004)(8676002)(81166006)(81156014)(8936002)(44832011)(54906003)(110136005)(65956001)(316002)(65806001)(58126008)(7416002)(71190400001)(71200400001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4448;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cBGAPBBl9WvMN5c+3jVNHQkSYXJmy0JfJXbfVJSmQzvVl+xDZ4wPeDwFjmLyCBr3AhPxx11V6v/86G7E7THhTxGdlaPauXQdEAlf+DiUnC/szcQS8bIhy0RHDQoEwCDurI7Jm+nDE7QMNcz3AOb/yrdIiW2ESv4JjzptBxjd7KSoZlYMx5cr3/mGaMUbuIAObzk4dckX0ElueYqA9y5Vf8qpLKQAzvs0n39ARDDngclnN/zeptMbinnaFue2IklkQ6ve9T0867ZprTCNhFyYTTmJUvmOnX6h18zOQifKAJPF4kMizgyaZeoc1vFiilwZIOFis1GzpxUWPNJSwdCrliay70GQWAfLlbRHpXYGJWbd13oLV9M5M/GVCByblIK0uDlC5UQqCujnXmvTNUQ7z/TNzilK9De2PlDo+iZ2lH4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F9D6381DCE1B42B91EE635199CCA43@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec162ab-aaf2-4387-65c8-08d6c4132b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 15:33:13.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDQvMjAxOSAxNDoxNywgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IC0tLS0tIE9u
IEFwciAxNywgMjAxOSwgYXQgMzo1NiBQTSwgTWF0aGlldSBEZXNub3llcnMgbWF0aGlldS5kZXNu
b3llcnNAZWZmaWNpb3MuY29tIHdyb3RlOg0KPj4gLS0tLS0gT24gQXByIDE3LCAyMDE5LCBhdCAx
MjoxNyBQTSwgSm9zZXBoIE15ZXJzIGpvc2VwaEBjb2Rlc291cmNlcnkuY29tIHdyb3RlOg0KPj4+
IE9uIFdlZCwgMTcgQXByIDIwMTksIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPj4+DQo+Pj4+
PiArLyogUlNFUV9TSUcgaXMgYSBzaWduYXR1cmUgcmVxdWlyZWQgYmVmb3JlIGVhY2ggYWJvcnQg
aGFuZGxlciBjb2RlLg0KPj4+Pj4gKw0KPj4+Pj4gKyAgIEl0IGlzIGEgMzItYml0IHZhbHVlIHRo
YXQgbWFwcyB0byBhY3R1YWwgYXJjaGl0ZWN0dXJlIGNvZGUgY29tcGlsZWQNCj4+Pj4+ICsgICBp
bnRvIGFwcGxpY2F0aW9ucyBhbmQgbGlicmFyaWVzLiBJdCBuZWVkcyB0byBiZSBkZWZpbmVkIGZv
ciBlYWNoDQo+Pj4+PiArICAgYXJjaGl0ZWN0dXJlLiBXaGVuIGNob29zaW5nIHRoaXMgdmFsdWUs
IGl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8NCj4+Pj4+ICsgICBhY2NvdW50IHRoYXQgZ2VuZXJh
dGluZyBpbnZhbGlkIGluc3RydWN0aW9ucyBtYXkgaGF2ZSBpbGwgZWZmZWN0cyBvbg0KPj4+Pj4g
KyAgIHRvb2xzIGxpa2Ugb2JqZHVtcCwgYW5kIG1heSBhbHNvIGhhdmUgaW1wYWN0IG9uIHRoZSBD
UFUgc3BlY3VsYXRpdmUNCj4+Pj4+ICsgICBleGVjdXRpb24gZWZmaWNpZW5jeSBpbiBzb21lIGNh
c2VzLiAgKi8NCj4+Pj4+ICsNCj4+Pj4+ICsjZGVmaW5lIFJTRVFfU0lHIDB4ZDQyOGJjMDAJLyog
QlJLICMweDQ1RTAuICAqLw0KPj4+Pg0KPj4+PiBBZnRlciBmdXJ0aGVyIGludmVzdGlnYXRpb24s
IHdlIHNob3VsZCBwcm9iYWJseSBkbyB0aGUgZm9sbG93aW5nDQo+Pj4+IHRvIGhhbmRsZSBjb21w
aWxpbmcgd2l0aCAtbWJpZy1lbmRpYW4gb24gYWFyY2g2NCwgd2hpY2ggZ2VuZXJhdGVzDQo+Pj4+
IGJpbmFyaWVzIHdpdGggbWl4ZWQgY29kZSB2cyBkYXRhIGVuZGlhbm5lc3MgKGxpdHRsZSBlbmRp
YW4gY29kZSwNCj4+Pj4gYmlnIGVuZGlhbiBkYXRhKToNCj4+Pg0KPj4+IEZpcnN0LCB0aGUgY29t
bWVudCBvbiBSU0VRX1NJRyBzaG91bGQgc3BlY2lmeSB3aGV0aGVyIGl0IGlzIHRvIGJlDQo+Pj4g
aW50ZXJwcmV0ZWQgaW4gdGhlIGNvZGUgb3IgdGhlIGRhdGEgZW5kaWFubmVzcy4NCj4+DQo+PiBS
aWdodC4gVGhlIHNpZ25hdHVyZSBwYXNzZWQgYXMgYXJndW1lbnQgdG8gdGhlIHJzZXEgcmVnaXN0
cmF0aW9uDQo+PiBzeXN0ZW0gY2FsbCBuZWVkcyB0byBiZSBpbiBkYXRhIGVuZGlhbm5lc3MgKGN1
cnJlbnRseSBleHBvc2VkIGtlcm5lbA0KPj4gQUJJKS4NCj4+DQo+PiBJZGVhbGx5IGZvciB1c2Vy
c3BhY2UsIHdlIHdhbnQgdG8gZGVmaW5lIGEgc2lnbmF0dXJlIGluIGNvZGUgZW5kaWFubmVzcw0K
Pj4gdGhhdCBoYXBwZW5zIHRvIG5pY2VseSBtYXRjaCBzcGVjaWZpYyBjb2RlIHBhdHRlcm5zLg0K
Li4uDQo+IEZvciBhYXJjaDY0LCBJIHRoaW5rIHdlIGNhbiBzaW1wbHkgZG86DQo+IA0KPiAvKg0K
PiAgKiBhYXJjaDY0IC1tYmlnLWVuZGlhbiBnZW5lcmF0ZXMgbWl4ZWQgZW5kaWFubmVzcyBjb2Rl
IHZzIGRhdGE6DQo+ICAqIGxpdHRsZS1lbmRpYW4gY29kZSBhbmQgYmlnLWVuZGlhbiBkYXRhLiBF
bnN1cmUgdGhlIFJTRVFfU0lHIHNpZ25hdHVyZQ0KPiAgKiBtYXRjaGVzIGNvZGUgZW5kaWFubmVz
cy4NCj4gICovDQo+ICNkZWZpbmUgUlNFUV9TSUdfQ09ERSAgIDB4ZDQyOGJjMDAgICAgICAvKiBC
UksgIzB4NDVFMC4gICovDQo+IA0KPiAjaWZkZWYgX19BUk1fQklHX0VORElBTg0KPiAjZGVmaW5l
IFJTRVFfU0lHX0RBVEEgICAweDAwYmMyOGQ0ICAgICAgLyogQlJLICMweDQ1RTAuICAqLw0KPiAj
ZWxzZQ0KPiAjZGVmaW5lIFJTRVFfU0lHX0RBVEEgICBSU0VRX1NJR19DT0RFDQo+ICNlbmRpZg0K
PiANCj4gI2RlZmluZSBSU0VRX1NJRyAgICAgICAgUlNFUV9TSUdfREFUQQ0KPiANCj4gRmVlZGJh
Y2sgaXMgbW9zdCB3ZWxjb21lLA0KDQpzbyB0aGUgUlNFUV9TSUcgdmFsdWUgaXMgc3VwcG9zZWQg
dG8gYmUgdXNlZCB3aXRoIC53b3JkDQppbiBhc20gaW5zdGVhZCBvZiAuaW5zdD8NCg0KaSBkb24n
dCB0aGluayB3ZSB1c2UgX19BUk1fKiBpbiBwdWJsaWMgaGVhZGVycyBjdXJyZW50bHksDQpidXQg
aG9wZWZ1bGx5IGFhcmNoNjRfYmUgY29tcGlsZXJzIGltcGxlbWVudCBpdC4NCg0Kb3RoZXJ3aXNl
IHRoaXMgbG9va3Mgb2sgdG8gbWUuDQoNCihpIHRoaW5rIGEgcmFyZSBwYWxpbmRyb21lIGluc3Ry
dWN0aW9uIHdvdWxkIHdvcmsgdG9vLCBlLmcuDQowYTVmNWYwYSAJYW5kCXcxMCwgdzI0LCB3enIs
IGxzciAjMjMgLy8gc2hpZnRlZCAwDQoyYTVmNWYyYSAJb3JyCXcxMCwgdzI1LCB3enIsIGxzciAj
MjMNCmViOWY5ZmViIAluZWdzCXgxMSwgeHpyLCBhc3IgIzM5DQpjODNmM2ZjOCAJc3R4cAl3enIs
IHg4LCB4MTUsIFt4MzBdICAvLyBzdG9yZSB0byBMUiBpZ25vcmluZyBzdWNjZXNzDQpkOWZmZmZk
OSAJc3R6MmcJeDI1LCBbeDMwLCAjLTE2XSEgICAgLy8gdjguNSB0YWcremVybyAyIGdyYW51bGVz
IGFyb3VuZCBMUg0KZXRjLiBpdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGEgZ3VhcmFudGVlZCB0cmFw
KQ0K
