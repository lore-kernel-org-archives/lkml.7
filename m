Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF70020693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AUS94+Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfDRQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:07:48 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:11609
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDRQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yc54pDoRCrGIub/QSipjSahCcYSwsqJzyVyI+YTphE=;
 b=AUS94+AoUZfNNuULOyh7KUHch8olnqy+lYzG7+ew+WIh8MYW9Dw9y8rpiTeJaQgmX9UfxQUJvfHUblqIbyTtnRRa1eaCb/Cc5t2fRcNoJhxnHqXfVR1ViBq+0JPTDkp4bgAvZ+iUVYDGZJEwH2wlIG3fQ9B2EfC9GCNLFsCpY1I=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3872.eurprd08.prod.outlook.com (20.178.80.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 18 Apr 2019 16:07:39 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 16:07:39 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     nd <nd@arm.com>, Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, carlos <carlos@redhat.com>,
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
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IBuJwpORvyO0U2A
Date:   Thu, 18 Apr 2019 16:07:39 +0000
Message-ID: <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <20190416173216.9028-2-mathieu.desnoyers@efficios.com>
 <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
 <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
 <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
 <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
In-Reply-To: <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00d600c5-002a-4b09-7dd9-08d6c417fb0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3872;
x-ms-traffictypediagnostic: VI1PR08MB3872:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3872FD3289F0F8ED0EC1915CED260@VI1PR08MB3872.eurprd08.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(6512007)(44832011)(14444005)(8936002)(256004)(2616005)(99286004)(446003)(81166006)(14454004)(97736004)(486006)(8676002)(81156014)(72206003)(4326008)(64126003)(476003)(5660300002)(31696002)(478600001)(3846002)(186003)(25786009)(229853002)(26005)(71190400001)(71200400001)(68736007)(6246003)(11346002)(52116002)(7416002)(65806001)(76176011)(58126008)(31686004)(65826007)(6436002)(54906003)(102836004)(305945005)(36756003)(7736002)(2906002)(53936002)(65956001)(66066001)(86362001)(6116002)(386003)(6506007)(53546011)(93886005)(6916009)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3872;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3/PvwsmPYOSS3l0ZO+UN6tWt9/JUuRSWDVZ+2wIyte/+pTDEb2zftk2tCAQQVGxY00hKqSmxAEM3LblJsD2x8WF86KYT5Pbha4PMDszNyydH+FzMNTk2i4r76BB+dLE3TIdYD/7DqJ644XsprrmPiSLPVwbzQ0qb1nUQ9NyCBKLL9g1bIeXLDHqUT54U/PdUgadjS0BSfMcap9DsmyTl3X3t/APkamKF98yb+tOeK8evokZBAWBjnDF9BjhY6y0Un9kuXui73pukjgHIdR0kybIO7RsoAwY23jzbenBHepcCclM7dVRMDGfmGu4aQ5FUJY+x/TbzEnXPpWoOKYjd2hiRjccbsYoxCocf9XoeTrQET3Hj/N5cbyU8FhyXSXJvw9aeI0CK1hdQ+sP7U43dcCuCJAF0c7ijfI4Br4EGBn8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8265BF5BDF73294FB3CC91041CC751B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d600c5-002a-4b09-7dd9-08d6c417fb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 16:07:39.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDQvMjAxOSAxNjo0MSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IC0tLS0tIE9u
IEFwciAxOCwgMjAxOSwgYXQgMTE6MzMgQU0sIFN6YWJvbGNzIE5hZ3kgU3phYm9sY3MuTmFneUBh
cm0uY29tIHdyb3RlOg0KPiANCj4+IE9uIDE4LzA0LzIwMTkgMTQ6MTcsIE1hdGhpZXUgRGVzbm95
ZXJzIHdyb3RlOg0KPj4+IC0tLS0tIE9uIEFwciAxNywgMjAxOSwgYXQgMzo1NiBQTSwgTWF0aGll
dSBEZXNub3llcnMNCj4+PiBtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20gd3JvdGU6DQo+
Pj4+IC0tLS0tIE9uIEFwciAxNywgMjAxOSwgYXQgMTI6MTcgUE0sIEpvc2VwaCBNeWVycyBqb3Nl
cGhAY29kZXNvdXJjZXJ5LmNvbSB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgMTcgQXByIDIwMTksIE1h
dGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+Pj4gKy8qIFJTRVFfU0lHIGlzIGEg
c2lnbmF0dXJlIHJlcXVpcmVkIGJlZm9yZSBlYWNoIGFib3J0IGhhbmRsZXIgY29kZS4NCj4+Pj4+
Pj4gKw0KPj4+Pj4+PiArICAgSXQgaXMgYSAzMi1iaXQgdmFsdWUgdGhhdCBtYXBzIHRvIGFjdHVh
bCBhcmNoaXRlY3R1cmUgY29kZSBjb21waWxlZA0KPj4+Pj4+PiArICAgaW50byBhcHBsaWNhdGlv
bnMgYW5kIGxpYnJhcmllcy4gSXQgbmVlZHMgdG8gYmUgZGVmaW5lZCBmb3IgZWFjaA0KPj4+Pj4+
PiArICAgYXJjaGl0ZWN0dXJlLiBXaGVuIGNob29zaW5nIHRoaXMgdmFsdWUsIGl0IG5lZWRzIHRv
IGJlIHRha2VuIGludG8NCj4+Pj4+Pj4gKyAgIGFjY291bnQgdGhhdCBnZW5lcmF0aW5nIGludmFs
aWQgaW5zdHJ1Y3Rpb25zIG1heSBoYXZlIGlsbCBlZmZlY3RzIG9uDQo+Pj4+Pj4+ICsgICB0b29s
cyBsaWtlIG9iamR1bXAsIGFuZCBtYXkgYWxzbyBoYXZlIGltcGFjdCBvbiB0aGUgQ1BVIHNwZWN1
bGF0aXZlDQo+Pj4+Pj4+ICsgICBleGVjdXRpb24gZWZmaWNpZW5jeSBpbiBzb21lIGNhc2VzLiAg
Ki8NCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArI2RlZmluZSBSU0VRX1NJRyAweGQ0MjhiYzAwCS8qIEJS
SyAjMHg0NUUwLiAgKi8NCj4+Pj4+Pg0KPj4+Pj4+IEFmdGVyIGZ1cnRoZXIgaW52ZXN0aWdhdGlv
biwgd2Ugc2hvdWxkIHByb2JhYmx5IGRvIHRoZSBmb2xsb3dpbmcNCj4+Pj4+PiB0byBoYW5kbGUg
Y29tcGlsaW5nIHdpdGggLW1iaWctZW5kaWFuIG9uIGFhcmNoNjQsIHdoaWNoIGdlbmVyYXRlcw0K
Pj4+Pj4+IGJpbmFyaWVzIHdpdGggbWl4ZWQgY29kZSB2cyBkYXRhIGVuZGlhbm5lc3MgKGxpdHRs
ZSBlbmRpYW4gY29kZSwNCj4+Pj4+PiBiaWcgZW5kaWFuIGRhdGEpOg0KPj4+Pj4NCj4+Pj4+IEZp
cnN0LCB0aGUgY29tbWVudCBvbiBSU0VRX1NJRyBzaG91bGQgc3BlY2lmeSB3aGV0aGVyIGl0IGlz
IHRvIGJlDQo+Pj4+PiBpbnRlcnByZXRlZCBpbiB0aGUgY29kZSBvciB0aGUgZGF0YSBlbmRpYW5u
ZXNzLg0KPj4+Pg0KPj4+PiBSaWdodC4gVGhlIHNpZ25hdHVyZSBwYXNzZWQgYXMgYXJndW1lbnQg
dG8gdGhlIHJzZXEgcmVnaXN0cmF0aW9uDQo+Pj4+IHN5c3RlbSBjYWxsIG5lZWRzIHRvIGJlIGlu
IGRhdGEgZW5kaWFubmVzcyAoY3VycmVudGx5IGV4cG9zZWQga2VybmVsDQo+Pj4+IEFCSSkuDQo+
Pj4+DQo+Pj4+IElkZWFsbHkgZm9yIHVzZXJzcGFjZSwgd2Ugd2FudCB0byBkZWZpbmUgYSBzaWdu
YXR1cmUgaW4gY29kZSBlbmRpYW5uZXNzDQo+Pj4+IHRoYXQgaGFwcGVucyB0byBuaWNlbHkgbWF0
Y2ggc3BlY2lmaWMgY29kZSBwYXR0ZXJucy4NCj4+IC4uLg0KPj4+IEZvciBhYXJjaDY0LCBJIHRo
aW5rIHdlIGNhbiBzaW1wbHkgZG86DQo+Pj4NCj4+PiAvKg0KPj4+ICAqIGFhcmNoNjQgLW1iaWct
ZW5kaWFuIGdlbmVyYXRlcyBtaXhlZCBlbmRpYW5uZXNzIGNvZGUgdnMgZGF0YToNCj4+PiAgKiBs
aXR0bGUtZW5kaWFuIGNvZGUgYW5kIGJpZy1lbmRpYW4gZGF0YS4gRW5zdXJlIHRoZSBSU0VRX1NJ
RyBzaWduYXR1cmUNCj4+PiAgKiBtYXRjaGVzIGNvZGUgZW5kaWFubmVzcy4NCj4+PiAgKi8NCj4+
PiAjZGVmaW5lIFJTRVFfU0lHX0NPREUgICAweGQ0MjhiYzAwICAgICAgLyogQlJLICMweDQ1RTAu
ICAqLw0KPj4+DQo+Pj4gI2lmZGVmIF9fQVJNX0JJR19FTkRJQU4NCj4+PiAjZGVmaW5lIFJTRVFf
U0lHX0RBVEEgICAweDAwYmMyOGQ0ICAgICAgLyogQlJLICMweDQ1RTAuICAqLw0KPj4+ICNlbHNl
DQo+Pj4gI2RlZmluZSBSU0VRX1NJR19EQVRBICAgUlNFUV9TSUdfQ09ERQ0KPj4+ICNlbmRpZg0K
Pj4+DQo+Pj4gI2RlZmluZSBSU0VRX1NJRyAgICAgICAgUlNFUV9TSUdfREFUQQ0KPj4+DQo+Pj4g
RmVlZGJhY2sgaXMgbW9zdCB3ZWxjb21lLA0KPj4NCj4+IHNvIHRoZSBSU0VRX1NJRyB2YWx1ZSBp
cyBzdXBwb3NlZCB0byBiZSB1c2VkIHdpdGggLndvcmQNCj4+IGluIGFzbSBpbnN0ZWFkIG9mIC5p
bnN0Pw0KPiANCj4gV2Ugd2FudCBhIC5pbnN0IHNvIGl0IHRyYW5zbGF0ZXMgaW50byBhIHZhbGlk
IHRyYXAgaW5zdHJ1Y3Rpb24uDQo+IEl0J3MgYmV0dGVyIHRvIHRyYXAgaW4gY2FzZSBwcm9ncmFt
IGV4ZWN1dGlvbiByZWFjaGVzIHRoaXMNCj4gYnkgbWlzdGFrZSAobWFrZXMgZGVidWdnaW5nIGVh
c2llcikuDQoNCnRoYXQgZG9lcyBub3QgbWFrZSBzZW5zZSB0byBtZS4NCg0KIi5pbnN0IiBpcyBh
biBhc20gZGlyZWN0aXZlIHRoYXQgcmVxdWlyZXMgYSB0aGUgdmFsdWUgdG8NCmJlIHRoZSBzYW1l
IG9uIEJFIGFuZCBMRSAobm9ybWFsIGluc24gZW5jb2RpbmcpLg0KDQoiLndvcmQiIGlzIGFuIGFz
bSBkaXJlY3RpdmUgdGhhdCByZXF1aXJlcyB0aGUgdmFsdWUgdG8NCnVzZSBzd2FwcGVkIGVuY29k
aW5nIG9uIEJFIChpZiBpdCdzIHVzZWQgaW4gdGhlIGluc3RydWN0aW9uDQpzdHJlYW0gaXQgd2ls
bCBjcmVhdGUgYSBkYXRhIG1hcHBpbmcgc3ltYm9sIGFuZCBkaXNhc20gdG8NCi53b3JkIHZhbHVl
IGluc3RlYWQgb2YgdGhlIGluc3RydWN0aW9uIG1uZW1vbmljcykuDQoNCnNvIHdoaWNoIG9uZSBp
cyBpdD8NCg0KPj4gaSBkb24ndCB0aGluayB3ZSB1c2UgX19BUk1fKiBpbiBwdWJsaWMgaGVhZGVy
cyBjdXJyZW50bHksDQo+PiBidXQgaG9wZWZ1bGx5IGFhcmNoNjRfYmUgY29tcGlsZXJzIGltcGxl
bWVudCBpdC4NCj4gDQo+IENhbiBJIHVzZSAjaWYgX19CWVRFX09SREVSX18gPT0gX19PUkRFUl9C
SUdfRU5ESUFOX18gIHRoZW4gPw0KDQpobSwgaSdkIGVpdGhlciB1c2UgI2lmZGVmIF9fQUFSQ0g2
NEVCX18gKHNpbmNlIHdlIGFscmVhZHkgdXNlIGl0KQ0Kb3IgdGhlIHBvcnRhYmxlICNpbmNsdWRl
IGVuZGlhbi5oIGFuZCBfX0JZVEVfT1JERVIgPT0gX19CSUdfRU5ESUFODQo=
