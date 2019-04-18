Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F52214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="B0+DlkQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbfDRRh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:37:29 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:45702
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388579AbfDRRh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA0C18o1xuFVNDDq7XzxlHRWR/76qyZvv7rGYbfC38k=;
 b=B0+DlkQZa0YDhIhSfHm5pmv7xg1Bp59N7ur7Ly1seiOSXYHAljImpRS7xRH0sb8jyOi5LW01lFQaIFGJBS2Be9agqE5klK3ST3KkpSvnn9Mwki+b1LjIzATEtEjaWBIM9Dn9pXnnbMNMWxuubmbIOZsLAOMN+D1WnkaZkP166K4=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4528.eurprd08.prod.outlook.com (20.179.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Thu, 18 Apr 2019 17:37:23 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::11b9:f687:dc3e:68cc%3]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 17:37:23 +0000
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
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IBuJwpORvyO4hCAgAAA5YCAAAdqgA==
Date:   Thu, 18 Apr 2019 17:37:23 +0000
Message-ID: <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com>
 <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
 <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
 <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
 <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
 <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com>
 <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com>
In-Reply-To: <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe404431-413f-4d0b-86a5-08d6c42483e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB4528;
x-ms-traffictypediagnostic: VI1PR08MB4528:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB45288FEE196AF7D8AA60CA02ED260@VI1PR08MB4528.eurprd08.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(8676002)(64126003)(53546011)(6506007)(36756003)(4326008)(6916009)(11346002)(8936002)(71190400001)(76176011)(6246003)(386003)(486006)(26005)(81166006)(86362001)(476003)(102836004)(186003)(81156014)(25786009)(2616005)(66066001)(229853002)(446003)(71200400001)(58126008)(6116002)(3846002)(6486002)(54906003)(6436002)(316002)(5660300002)(65806001)(65956001)(68736007)(2906002)(52116002)(93886005)(31696002)(31686004)(72206003)(97736004)(305945005)(53936002)(99286004)(65826007)(14454004)(7736002)(44832011)(478600001)(256004)(14444005)(6512007)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4528;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t2h7DWCjZkK8wdL1asLWaYZUNCrc/bTZJkeeWIHbAj89UGHzD3CE2EA6rxCeiD4ZfRZX0GKFtW5u20zFaK+GThXqs2VsVQYRdUzlgJYsRyDISV4Ic9cR0dDlKFGp3ObU5MZqMMgIHklVP+Hybm1aehWznn1KSf42RjOUJ8E4yKRLCaOsLHEfApIXLHz6vDXDUfIcMoToqDNkkCR/z5nrsSzplGL1As8R19Z+lEmORh/8VFMcMJcM1Fz+FW7Z05q9D7sxZ5Myu50CzHe7I50DQjeO320bHKZoE2TMnvgWl/KoDARt1QsvvkvNiv2KzOyGu1VXL6fQqyXV+LPCAeCTDcKk9SKQuQYgAe2x29hCaEmYfssSkcfpWDBhMuh90Nj8EcV12JsI+Fvvgzv4XPXmV1PvsFzSFNdAgDUPIE8HhxQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1534BFA2B210749AC977DE102C7AA9B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe404431-413f-4d0b-86a5-08d6c42483e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 17:37:23.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDQvMjAxOSAxODoxMCwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+IA0KPiAtLS0t
LSBPbiBBcHIgMTgsIDIwMTksIGF0IDEyOjA3IFBNLCBTemFib2xjcyBOYWd5IFN6YWJvbGNzLk5h
Z3lAYXJtLmNvbSB3cm90ZToNCj4gDQo+PiBPbiAxOC8wNC8yMDE5IDE2OjQxLCBNYXRoaWV1IERl
c25veWVycyB3cm90ZToNCj4+PiAtLS0tLSBPbiBBcHIgMTgsIDIwMTksIGF0IDExOjMzIEFNLCBT
emFib2xjcyBOYWd5IFN6YWJvbGNzLk5hZ3lAYXJtLmNvbSB3cm90ZToNCj4+Pg0KPj4+PiBPbiAx
OC8wNC8yMDE5IDE0OjE3LCBNYXRoaWV1IERlc25veWVycyB3cm90ZToNCj4+Pj4+IC0tLS0tIE9u
IEFwciAxNywgMjAxOSwgYXQgMzo1NiBQTSwgTWF0aGlldSBEZXNub3llcnMNCj4+Pj4+IG1hdGhp
ZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbSB3cm90ZToNCj4+Pj4+PiAtLS0tLSBPbiBBcHIgMTcs
IDIwMTksIGF0IDEyOjE3IFBNLCBKb3NlcGggTXllcnMgam9zZXBoQGNvZGVzb3VyY2VyeS5jb20g
d3JvdGU6DQo+Pj4+Pj4+IE9uIFdlZCwgMTcgQXByIDIwMTksIE1hdGhpZXUgRGVzbm95ZXJzIHdy
b3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4+ICsvKiBSU0VRX1NJRyBpcyBhIHNpZ25hdHVyZSByZXF1
aXJlZCBiZWZvcmUgZWFjaCBhYm9ydCBoYW5kbGVyIGNvZGUuDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+
Pj4+ICsgICBJdCBpcyBhIDMyLWJpdCB2YWx1ZSB0aGF0IG1hcHMgdG8gYWN0dWFsIGFyY2hpdGVj
dHVyZSBjb2RlIGNvbXBpbGVkDQo+Pj4+Pj4+Pj4gKyAgIGludG8gYXBwbGljYXRpb25zIGFuZCBs
aWJyYXJpZXMuIEl0IG5lZWRzIHRvIGJlIGRlZmluZWQgZm9yIGVhY2gNCj4+Pj4+Pj4+PiArICAg
YXJjaGl0ZWN0dXJlLiBXaGVuIGNob29zaW5nIHRoaXMgdmFsdWUsIGl0IG5lZWRzIHRvIGJlIHRh
a2VuIGludG8NCj4+Pj4+Pj4+PiArICAgYWNjb3VudCB0aGF0IGdlbmVyYXRpbmcgaW52YWxpZCBp
bnN0cnVjdGlvbnMgbWF5IGhhdmUgaWxsIGVmZmVjdHMgb24NCj4+Pj4+Pj4+PiArICAgdG9vbHMg
bGlrZSBvYmpkdW1wLCBhbmQgbWF5IGFsc28gaGF2ZSBpbXBhY3Qgb24gdGhlIENQVSBzcGVjdWxh
dGl2ZQ0KPj4+Pj4+Pj4+ICsgICBleGVjdXRpb24gZWZmaWNpZW5jeSBpbiBzb21lIGNhc2VzLiAg
Ki8NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gKyNkZWZpbmUgUlNFUV9TSUcgMHhkNDI4YmMwMAkv
KiBCUksgIzB4NDVFMC4gICovDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQWZ0ZXIgZnVydGhlciBpbnZl
c3RpZ2F0aW9uLCB3ZSBzaG91bGQgcHJvYmFibHkgZG8gdGhlIGZvbGxvd2luZw0KPj4+Pj4+Pj4g
dG8gaGFuZGxlIGNvbXBpbGluZyB3aXRoIC1tYmlnLWVuZGlhbiBvbiBhYXJjaDY0LCB3aGljaCBn
ZW5lcmF0ZXMNCj4+Pj4+Pj4+IGJpbmFyaWVzIHdpdGggbWl4ZWQgY29kZSB2cyBkYXRhIGVuZGlh
bm5lc3MgKGxpdHRsZSBlbmRpYW4gY29kZSwNCj4+Pj4+Pj4+IGJpZyBlbmRpYW4gZGF0YSk6DQo+
Pj4+Pj4+DQo+Pj4+Pj4+IEZpcnN0LCB0aGUgY29tbWVudCBvbiBSU0VRX1NJRyBzaG91bGQgc3Bl
Y2lmeSB3aGV0aGVyIGl0IGlzIHRvIGJlDQo+Pj4+Pj4+IGludGVycHJldGVkIGluIHRoZSBjb2Rl
IG9yIHRoZSBkYXRhIGVuZGlhbm5lc3MuDQo+Pj4+Pj4NCj4+Pj4+PiBSaWdodC4gVGhlIHNpZ25h
dHVyZSBwYXNzZWQgYXMgYXJndW1lbnQgdG8gdGhlIHJzZXEgcmVnaXN0cmF0aW9uDQo+Pj4+Pj4g
c3lzdGVtIGNhbGwgbmVlZHMgdG8gYmUgaW4gZGF0YSBlbmRpYW5uZXNzIChjdXJyZW50bHkgZXhw
b3NlZCBrZXJuZWwNCj4+Pj4+PiBBQkkpLg0KPj4+Pj4+DQo+Pj4+Pj4gSWRlYWxseSBmb3IgdXNl
cnNwYWNlLCB3ZSB3YW50IHRvIGRlZmluZSBhIHNpZ25hdHVyZSBpbiBjb2RlIGVuZGlhbm5lc3MN
Cj4+Pj4+PiB0aGF0IGhhcHBlbnMgdG8gbmljZWx5IG1hdGNoIHNwZWNpZmljIGNvZGUgcGF0dGVy
bnMuDQo+Pj4+IC4uLg0KPj4+Pj4gRm9yIGFhcmNoNjQsIEkgdGhpbmsgd2UgY2FuIHNpbXBseSBk
bzoNCj4+Pj4+DQo+Pj4+PiAvKg0KPj4+Pj4gICogYWFyY2g2NCAtbWJpZy1lbmRpYW4gZ2VuZXJh
dGVzIG1peGVkIGVuZGlhbm5lc3MgY29kZSB2cyBkYXRhOg0KPj4+Pj4gICogbGl0dGxlLWVuZGlh
biBjb2RlIGFuZCBiaWctZW5kaWFuIGRhdGEuIEVuc3VyZSB0aGUgUlNFUV9TSUcgc2lnbmF0dXJl
DQo+Pj4+PiAgKiBtYXRjaGVzIGNvZGUgZW5kaWFubmVzcy4NCj4+Pj4+ICAqLw0KPj4+Pj4gI2Rl
ZmluZSBSU0VRX1NJR19DT0RFICAgMHhkNDI4YmMwMCAgICAgIC8qIEJSSyAjMHg0NUUwLiAgKi8N
Cj4+Pj4+DQo+Pj4+PiAjaWZkZWYgX19BUk1fQklHX0VORElBTg0KPj4+Pj4gI2RlZmluZSBSU0VR
X1NJR19EQVRBICAgMHgwMGJjMjhkNCAgICAgIC8qIEJSSyAjMHg0NUUwLiAgKi8NCj4+Pj4+ICNl
bHNlDQo+Pj4+PiAjZGVmaW5lIFJTRVFfU0lHX0RBVEEgICBSU0VRX1NJR19DT0RFDQo+Pj4+PiAj
ZW5kaWYNCj4+Pj4+DQo+Pj4+PiAjZGVmaW5lIFJTRVFfU0lHICAgICAgICBSU0VRX1NJR19EQVRB
DQo+Pj4+Pg0KPj4+Pj4gRmVlZGJhY2sgaXMgbW9zdCB3ZWxjb21lLA0KPj4+Pg0KPj4+PiBzbyB0
aGUgUlNFUV9TSUcgdmFsdWUgaXMgc3VwcG9zZWQgdG8gYmUgdXNlZCB3aXRoIC53b3JkDQo+Pj4+
IGluIGFzbSBpbnN0ZWFkIG9mIC5pbnN0Pw0KPj4+DQo+Pj4gV2Ugd2FudCBhIC5pbnN0IHNvIGl0
IHRyYW5zbGF0ZXMgaW50byBhIHZhbGlkIHRyYXAgaW5zdHJ1Y3Rpb24uDQo+Pj4gSXQncyBiZXR0
ZXIgdG8gdHJhcCBpbiBjYXNlIHByb2dyYW0gZXhlY3V0aW9uIHJlYWNoZXMgdGhpcw0KPj4+IGJ5
IG1pc3Rha2UgKG1ha2VzIGRlYnVnZ2luZyBlYXNpZXIpLg0KPj4NCj4+IHRoYXQgZG9lcyBub3Qg
bWFrZSBzZW5zZSB0byBtZS4NCj4+DQo+PiAiLmluc3QiIGlzIGFuIGFzbSBkaXJlY3RpdmUgdGhh
dCByZXF1aXJlcyBhIHRoZSB2YWx1ZSB0bw0KPj4gYmUgdGhlIHNhbWUgb24gQkUgYW5kIExFIChu
b3JtYWwgaW5zbiBlbmNvZGluZykuDQo+Pg0KPj4gIi53b3JkIiBpcyBhbiBhc20gZGlyZWN0aXZl
IHRoYXQgcmVxdWlyZXMgdGhlIHZhbHVlIHRvDQo+PiB1c2Ugc3dhcHBlZCBlbmNvZGluZyBvbiBC
RSAoaWYgaXQncyB1c2VkIGluIHRoZSBpbnN0cnVjdGlvbg0KPj4gc3RyZWFtIGl0IHdpbGwgY3Jl
YXRlIGEgZGF0YSBtYXBwaW5nIHN5bWJvbCBhbmQgZGlzYXNtIHRvDQo+PiAud29yZCB2YWx1ZSBp
bnN0ZWFkIG9mIHRoZSBpbnN0cnVjdGlvbiBtbmVtb25pY3MpLg0KPj4NCj4+IHNvIHdoaWNoIG9u
ZSBpcyBpdD8NCj4gDQo+IFdlIGRlY2xhcmUgdGhlIHNpZ25hdHVyZSB3aXRoICIuaW5zdCIgaW4g
YXNzZW1ibGVyLg0KPiANCj4gSG93ZXZlciwgd2UgYWxzbyBuZWVkIHRvIHBhc3MgdGhhdCAzMi1i
aXQgc2lnbmF0dXJlIHZhbHVlIGFzDQo+IGFyZ3VtZW50IHRvIHRoZSByc2VxIHN5c3RlbSBjYWxs
IHdoZW4gcmVnaXN0ZXJpbmcgcnNlcS4NCj4gDQo+IFRoZSBzaWduYXR1cmUgY29tcGFyaXNvbiBp
cyBwZXJmb3JtZWQgYnkgdGhlIGtlcm5lbCBiZWZvcmUNCj4gbW92aW5nIHRoZSBpbnN0cnVjdGlv
biBwb2ludGVyIHRvIHRoZSBhYm9ydCBoYW5kbGVyLiBJdCBjb21wYXJlcw0KPiB0aGUgc2lnbmF0
dXJlIHJlY2VpdmVkIGFzIHBhcmFtZXRlciBieSBzeXNfcnNlcSAoZGF0YSkgdG8gdGhlDQo+IDQt
Ynl0ZSBzaWduYXR1cmUgcHJlY2VkaW5nIHRoZSBhYm9ydCBJUC4NCj4gDQo+IE9uIGFhcmNoNjQg
YmlnIGVuZGlhbiwgQUZBSVUgdGhlIHNpZ25hdHVyZSBpbiB0aGUgY29kZSBpcyBpbg0KPiBsaXR0
bGUgZW5kaWFuLCBhbmQgdGhlIHNpZ25hdHVyZSB2YWx1ZSBwYXNzZWQgYXMgYXJndW1lbnQgdG8N
Cj4gdGhlIHJzZXEgc3lzdGVtIGNhbGwgaXMgaW4gYmlnIGVuZGlhbi4gT25lIHdheSB0byBoYW5k
bGUgdGhpcw0KPiBpcyB0byBzd2FwIHRoZSBieXRlIG9yZGVyIG9mIHRoZSBzaWduYXR1cmUgImRh
dGEiIHJlcHJlc2VudGF0aW9uDQo+IHBhc3NlZCBhcyBhcmd1bWVudCB0byBzeXNfcnNlcS4NCg0K
eW91IGhhdmUgdG8gYWRkIGEgZG9jdW1lbnRhdGlvbiBjb21tZW50IHNvbWV3aGVyZQ0KZXhwbGFp
bmluZyBpZiBSU0VRX1NJRyBpcyB0aGUgdmFsdWUgdGhhdCdzIHBhc3NlZCB0bw0KdGhlIGtlcm5l
bCBhbmQgdGhlbiBhYXJjaDY0IGFzbSBjb2RlIGhhcyB0byB1c2UNCg0KIC5pbnN0IGVuZGlhbmZp
eHVwKFJTRVFfU0lHKSAvLyBvcg0KIC53b3JkIFJTRVFfU0lHDQoNCm9yIGlmIFJTRVFfU0lHIGlz
IHVzZWQgYXMNCg0KIC5pbnN0IFJTRVFfU0lHDQoNCmluIGFhcmNoNjQgYXNtIGFuZCB0aGVuIGVu
ZGlhbmZpeHVwKFJTRVFfU0lHKSBzaG91bGQNCmJlIHBhc3NlZCB0byB0aGUgc3lzY2FsbC4NCg0K
ZWl0aGVyIHdheSBpdCBjYW4gYmUgYSBicmsgMHg0NWUwIG9uIGJvdGggTEUgYW5kIEJFLA0KYnV0
IGluIHRoZSBsYXR0ZXIgY2FzZSB5b3UgaGF2ZSB0byBkb2N1bWVudCB0aGlzIGluDQphcmNoIGlu
ZGVwZW5kZW50IHdheSwgc2luY2UgdGhlIHN5c2NhbGwgYXBpIG11c3QgYmUNCnBvcnRhYmxlIChp
IGFzc3VtZSAiUlNFUV9TSUciIGlzIHBhcnQgb2YgdGhlIGFwaSkuDQo=
