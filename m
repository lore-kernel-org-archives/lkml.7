Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ACC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FEA2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pjJ78PJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfLDQIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:08:37 -0500
Received: from mail-eopbgr740040.outbound.protection.outlook.com ([40.107.74.40]:54448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbfLDQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:08:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdl82coXhRlB7EEf0JrX6i+uLTJZUkwlrG/2H2+rr0nlP+Wg1x6GNGPT44EX7VEPT6AFE37LqGQrhigEOyayGVSiaqQunVd91eWrnYUwvd+WO85Q/ozI3Ym/gQMLLNvjQAdRcXAtgEbAbds7a5IUHNaW4Vykt7cnKZbypmU/FX1z+4hjOfZWROgsqLbJl776hA2HD68ObQjNdCxyeu/Ty2wy6OGPZuggvgx+5T6LXFkntUi/6gVPUq5+IeTwTuRByDNuTXM8ztPPmrIiTwMqcZxpBjKx80NgjgDy19eDX2QoepDhxNNKDYkuseKEWocR3wVBLoraDYj8QxEPF0QH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmNgH8lC6OtF278NaFUurKPVVtI0rLNLbs/Po+U6yXs=;
 b=lGzUINm9wapccfgfEG2R8WjXtVo+aGVLfzwynDMRBl+qd+Ms2BjQV/rr/2i+8cLYP2QJrd0Dm3hcToarvSVQmJ0ysF+Ch1UZ0330CxVlUWEBvtjs4YMgp/eh24aLFKIWFRDn7Qy+ggNKD6shF550ftBRqsNM1jUaCxPc2LF8RbRbYq9+JP93Y6zEn3ySpaV3wowDHFIieKSdGKmKxGM38IPF2k8kOuEiJCQTR7XR4O38/Dahbyx42ts8Pr8kdDm7chmK6S9qO27HiUC7iq1tAx/oCqeIgi8T04eRyBi7xNJUVs4uj1wi8HdpR0b3GAUXjx7jutc8Pyfj82lG9Y11/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmNgH8lC6OtF278NaFUurKPVVtI0rLNLbs/Po+U6yXs=;
 b=pjJ78PJMCgAnyLQZxvDJP6vMgTyaf/eVrW3kwED6C7Y3FPaxB+zg5UfQbk++Jn+tj1/TZV0dLu91ySvOanB2k4x1hK/L85FMZpunIqHnRj6r4+FB7cpGj0iTrfjN/pGWbFvC8gyWqJa+SRzcO5c7hEh+o9PmsumTVOaz9smhHTA=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1823.namprd12.prod.outlook.com (10.175.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 16:08:30 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 16:08:30 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Lucas Stach <dev@lynxeye.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVpsBguKm4D8iWWkiQt39oc44V0aelPBeAgAHRwGCAAx4xYA==
Date:   Wed, 4 Dec 2019 16:08:30 +0000
Message-ID: <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
 <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81a79a65-7d2d-48c3-1966-08d778d4347d
x-ms-traffictypediagnostic: MWHPR12MB1823:|MWHPR12MB1823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB18238431C93C6C3827154F69F75D0@MWHPR12MB1823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(13464003)(189003)(199004)(186003)(6636002)(52536014)(2501003)(45080400002)(6116002)(6506007)(53546011)(498600001)(25786009)(26005)(102836004)(14454004)(4326008)(966005)(99286004)(64756008)(6246003)(110136005)(86362001)(54906003)(66476007)(66556008)(66946007)(76116006)(66446008)(81166006)(81156014)(8676002)(8936002)(11346002)(5660300002)(305945005)(6306002)(9686003)(7736002)(71190400001)(3846002)(229853002)(55016002)(33656002)(71200400001)(6436002)(74316002)(7696005)(14444005)(2906002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1823;H:MWHPR12MB1358.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcZgiAlnLXvSDZJdiG6U8Y9RmhdGgbmyQp/5FBEoDe6nWYnRZW7QE9vSs4xGp5YtH4rBn8e4vsmYM90R/w6oTOrFoGnBEbWaG5cJZpnbV7ka/7bYXKDLBAyCMrisAMCmBZBvdPPVVBj/GJRTdnHD05kB/dE2xEHQfeCmoRdAgLsUwERmq0zCKpGFmyUiw6Y1V/b0GLVYVHTg9tpkpkkt9QGVMhx1rsnei2wKTvcQ4CwF8BF2hqyyUwQbkKKjqRdJWAgt1dadvRM9egYYJT+yQ5TVgZHWOEB4UBOEMu1BFqknCqNzpAI0xL8Hj9R9QXOWdE2Yeyu4ihKKmxCt3WJq1yscWc4j8rBnLnZbckl39AQa71gXrdIKFdsVbiZfdCf1+sEcadkX6TyWs/GH3ou79xduttTkHdtBXNkLVMBCSRKWNYYUnnHgERQ7fyfIx6tsGuDmBOIkH2FJJ9e9j+LdEgcIH49PzyBGHfn989bl72ZKaGLHGw2udq5dO+7oQefGYwyhNSgq2/r3xHJe0gLAZjXmp7aXFquU8vbf2P0R4Yg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a79a65-7d2d-48c3-1966-08d778d4347d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 16:08:30.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSDg7NAOxAT2/o/PzawoIo8wLl4wUwT9mlHOumoitwDIFrBapwL1EOIF4O2IJK9SSBOqrpNOxYkxsme5iawZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDE5IDExOjM3IEFNDQo+IFRvOiBMdWNhcyBT
dGFjaCA8ZGV2QGx5bnhleWUuZGU+OyBLYWktSGVuZyBGZW5nDQo+IDxrYWkuaGVuZy5mZW5nQGNh
bm9uaWNhbC5jb20+OyBqb3JvQDhieXRlcy5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuDQo+IChDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20pIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IENjOiBp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBpb21tdS9hbWQ6IERpc2FibGUgSU9NTVUg
b24gU3RvbmV5IFJpZGdlDQo+IHN5c3RlbXMNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBMdWNhcyBTdGFjaCA8ZGV2QGx5bnhleWUuZGU+DQo+ID4gU2VudDog
U3VuZGF5LCBEZWNlbWJlciAxLCAyMDE5IDc6NDMgQU0NCj4gPiBUbzogS2FpLUhlbmcgRmVuZyA8
a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPjsgam9yb0A4Ynl0ZXMub3JnDQo+ID4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47DQo+ID4gaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBpb21tdS9hbWQ6IERpc2FibGUgSU9NTVUgb24g
U3RvbmV5IFJpZGdlDQo+ID4gc3lzdGVtcw0KPiA+DQo+ID4gQW0gRnJlaXRhZywgZGVuIDI5LjEx
LjIwMTksIDIyOjIxICswODAwIHNjaHJpZWIgS2FpLUhlbmcgRmVuZzoNCj4gPiA+IFNlcmlvdXMg
c2NyZWVuIGZsaWNrZXJpbmcgd2hlbiBTdG9uZXkgUmlkZ2Ugb3V0cHV0cyB0byBhIDRLIG1vbml0
b3IuDQo+ID4gPg0KPiA+ID4gQWNjb3JkaW5nIHRvIEFsZXggRGV1Y2hlciwgSU9NTVUgaXNuJ3Qg
ZW5hYmxlZCBvbiBXaW5kb3dzLCBzbyBsZXQncw0KPiA+ID4gZG8gdGhlIHNhbWUgaGVyZSB0byBh
dm9pZCBzY3JlZW4gZmxpY2tlcmluZyBvbiA0SyBtb25pdG9yLg0KPiA+DQo+ID4gVGhpcyBkb2Vz
bid0IHNlZW0gbGlrZSBhIGdvb2Qgc29sdXRpb24sIGVzcGVjaWFsbHkgaWYgdGhlcmUgaXNuJ3Qg
YQ0KPiA+IG1ldGhvZCBmb3IgdGhlIHVzZXIgdG8gb3B0LW91dC4gIFNvbWUgdXNlcnMgbWlnaHQg
cHJlZmVyIGhhdmluZyB0aGUNCj4gPiBJT01NVSBzdXBwb3J0IHRvIDRLIGRpc3BsYXkgb3V0cHV0
Lg0KPiA+DQo+ID4gQnV0IGJlZm9yZSB1c2luZyB0aGUgYmlnIGhhbW1lciBvZiBkaXNhYmxpbmcg
b3IgYnJlYWtpbmcgb25lIG9mIHRob3NlDQo+ID4gZmVhdHVyZXMsIHdlIHNob3VsZCB0YWtlIGEg
bG9vayBhdCB3aGF0J3MgdGhlIGlzc3VlIGhlcmUuIFNjcmVlbg0KPiA+IGZsaWNrZXJpbmcgY2F1
c2VkIGJ5IHRoZSBJT01NVSBiZWluZyBhY3RpdmUgaGludHMgdG8gdGhlIElPTU1VIG5vdA0KPiA+
IGJlaW5nIGFibGUgdG8gc3VzdGFpbiB0aGUgdHJhbnNsYXRpb24gYmFuZHdpZHRoIHJlcXVpcmVk
IGJ5IHRoZSBoaWdoLQ0KPiA+IGJhbmR3aWR0aCBpc29jaHJvbm91cyB0cmFuc2ZlcnMgY2F1c2Vk
IGJ5IDRLIHNjYW5vdXQsIG1vc3QgbGlrZWx5IGR1ZQ0KPiA+IHRvIGluc3VmZmljaWVudCBUTEIg
c3BhY2UuDQo+ID4NCj4gPiBBcyBmYXIgYXMgSSBrbm93IHRoZSBmcmFtZWJ1ZmZlciBtZW1vcnkg
Zm9yIHRoZSBkaXNwbGF5IGJ1ZmZlcnMgaXMNCj4gPiBsb2NhdGVkIGluIHN0b2xlbiBSQU0sIGFu
ZCB0aHVzIGNvbnRpZ291cyBpbiBtZW1vcnkuIEkgZG9uJ3Qga25vdyB0aGUNCj4gPiBkZXRhaWxz
IG9mIHRoZSBHUFUgaW50ZWdyYXRpb24gb24gdGhvc2UgQVBVcywgYnV0IG1heWJlIHRoZXJlIGV2
ZW4gaXMNCj4gPiBhIHdheSB0byBieXBhc3MgdGhlIElPTU1VIGZvciB0aGUgc3RvbGVuIFZSQU0g
cmVnaW9ucz8NCj4gPg0KPiA+IElmIHRoZXJlIGlzbid0IGFuZCBhbGwgR1BVIHRyYWZmaWMgcGFz
c2VzIHRocm91Z2ggdGhlIElPTU1VIHdoZW4NCj4gPiBhY3RpdmUsIHdlIHNob3VsZCBjaGVjayBp
ZiB0aGUgc3RvbGVuIFJBTSBpcyBtYXBwZWQgd2l0aCBodWdlcGFnZXMgb24NCj4gPiB0aGUgSU9N
TVUgc2lkZS4gQWxsIHRoZSBzdG9sZW4gUkFNIGNhbiBtb3N0IGxpa2VseSBiZSBtYXBwZWQgd2l0
aCBhDQo+ID4gZmV3IGh1Z2VwYWdlIG1hcHBpbmdzLCB3aGljaCBzaG91bGQgcmVkdWNlIElPTU1V
IFRMQiBkZW1hbmQgYnkgYQ0KPiBsYXJnZSBtYXJnaW4uDQo+IA0KPiBUaGUgaXMgbm8gaXNzdWUg
d2hlbiB3ZSBzY2FuIG91dCBvZiB0aGUgY2FydmUgb3V0IHJlZ2lvbi4gIFRoZSBpc3N1ZSBvY2N1
cnMNCj4gd2hlbiB3ZSBzY2FuIG91dCBvZiByZWd1bGFyIHN5c3RlbSBtZW1vcnkgKHNjYXR0ZXIv
Z2F0aGVyKS4gIE1hbnkgbmV3ZXINCj4gbGFwdG9wcyBoYXZlIHZlcnkgc21hbGwgY2FydmUgb3V0
IHJlZ2lvbnMgKGUuZy4sIDMyIE1CKSwgc28gd2UgaGF2ZSB0byB1c2UNCj4gcmVndWxhciBzeXN0
ZW0gcGFnZXMgdG8gc3VwcG9ydCBtdWx0aXBsZSBoaWdoIHJlc29sdXRpb24gZGlzcGxheXMuICBU
aGUNCj4gcHJvYmxlbSBpcywgdGhlIGxhdGVuY3kgZ2V0cyB0b28gaGlnaCBhdCBzb21lIHBvaW50
IHdoZW4gdGhlIElPTU1VIGlzDQo+IGludm9sdmVkLiAgSHVnZSBwYWdlcyB3b3VsZCBwcm9iYWJs
eSBoZWxwIGluIHRoaXMgY2FzZSwgYnV0IEknbSBub3Qgc3VyZSBpZg0KPiB0aGVyZSBpcyBhbnkg
d2F5IHRvIGd1YXJhbnRlZSB0aGF0IHdlIGdldCBodWdlIHBhZ2VzIGZvciBzeXN0ZW0gbWVtb3J5
LiAgSQ0KPiBndWVzcyB3ZSBjb3VsZCB1c2UgQ01BIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQoN
ClRob21hcyByZWNlbnRseSBzZW50IG91dCBhIHBhdGNoIHNldCB0byBhZGQgaHVnZSBwYWdlIHN1
cHBvcnQgdG8gdHRtOg0KaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy83
MDA5MC8NCldlJ2Qgc3RpbGwgbmVlZCBhIHdheSB0byBndWFyYW50ZWUgaHVnZSBwYWdlcyBmb3Ig
dGhlIGRpc3BsYXkgYnVmZmVyLg0KDQpBbGV4DQoNCj4gDQo+IEFsZXgNCj4gDQo+ID4NCj4gPiBS
ZWdhcmRzLA0KPiA+IEx1Y2FzDQo+ID4NCj4gPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiBCdWc6DQo+ID4gPg0KPiBodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaQ0KPiA+
ID4gdGwNCj4gPiA+DQo+ID4NCj4gYWIuZnJlZWRlc2t0b3Aub3JnJTJGZHJtJTJGYW1kJTJGaXNz
dWVzJTJGOTYxJmFtcDtkYXRhPTAyJTdDMDElDQo+ID4gN0NhbGV4YQ0KPiA+ID4NCj4gPg0KPiBu
ZGVyLmRldWNoZXIlNDBhbWQuY29tJTdDMzA1NDBiMmJmMmJlNDE3YzRkOTUwOGQ3NzY1YmYwN2Yl
N0MzZGQNCj4gPiA4OTYxZmU0DQo+ID4gPg0KPiA+DQo+IDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzEwODAxMDA3NTQ2MzI2NiZhbXA7c2RhdGE9MQ0KPiA+IFpJWlVXb3MNCj4g
PiA+IGNQaUI0YXVPWTEwamxHem9GZVdzellNREJRRzBDdHJyT084JTNEJmFtcDtyZXNlcnZlZD0w
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9u
aWNhbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHYyOg0KPiA+ID4gLSBGaW5kIFN0b25leSBncmFw
aGljcyBpbnN0ZWFkIG9mIGhvc3QgYnJpZGdlLg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL2lvbW11
L2FtZF9pb21tdV9pbml0LmMgfCAxMyArKysrKysrKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+ID4gPiBiL2RyaXZlcnMvaW9t
bXUvYW1kX2lvbW11X2luaXQuYyBpbmRleCA1NjhjNTIzMTc3NTcuLjEzOWFhNmZkYWRkYQ0KPiA+
ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYw0KPiA+ID4gQEAgLTI1MTYs
NiArMjUxNiw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X2FtZF9pb21tdV9pbml0KHZvaWQp
DQo+ID4gPiAgCXN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAqaXZyc19iYXNlOw0KPiA+ID4gIAlh
Y3BpX3N0YXR1cyBzdGF0dXM7DQo+ID4gPiAgCWludCBpLCByZW1hcF9jYWNoZV9zeiwgcmV0ID0g
MDsNCj4gPiA+ICsJdTMyIHBjaV9pZDsNCj4gPiA+DQo+ID4gPiAgCWlmICghYW1kX2lvbW11X2Rl
dGVjdGVkKQ0KPiA+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gPiBAQCAtMjYwMyw2ICsyNjA0
LDE2IEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X2FtZF9pb21tdV9pbml0KHZvaWQpDQo+ID4g
PiAgCWlmIChyZXQpDQo+ID4gPiAgCQlnb3RvIG91dDsNCj4gPiA+DQo+ID4gPiArCS8qIERpc2Fi
bGUgSU9NTVUgaWYgdGhlcmUncyBTdG9uZXkgUmlkZ2UgZ3JhcGhpY3MgKi8NCj4gPiA+ICsJZm9y
IChpID0gMDsgaSA8IDMyOyBpKyspIHsNCj4gPiA+ICsJCXBjaV9pZCA9IHJlYWRfcGNpX2NvbmZp
ZygwLCBpLCAwLCAwKTsNCj4gPiA+ICsJCWlmICgocGNpX2lkICYgMHhmZmZmKSA9PSAweDEwMDIg
JiYgKHBjaV9pZCA+PiAxNikgPT0gMHg5OGU0KSB7DQo+ID4gPiArCQkJcHJfaW5mbygiRGlzYWJs
ZSBJT01NVSBvbiBTdG9uZXkgUmlkZ2VcbiIpOw0KPiA+ID4gKwkJCWFtZF9pb21tdV9kaXNhYmxl
ZCA9IHRydWU7DQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0NCj4gPiA+
ICsNCj4gPiA+ICAJLyogRGlzYWJsZSBhbnkgcHJldmlvdXNseSBlbmFibGVkIElPTU1VcyAqLw0K
PiA+ID4gIAlpZiAoIWlzX2tkdW1wX2tlcm5lbCgpIHx8IGFtZF9pb21tdV9kaXNhYmxlZCkNCj4g
PiA+ICAJCWRpc2FibGVfaW9tbXVzKCk7DQo+ID4gPiBAQCAtMjcxMSw3ICsyNzIyLDcgQEAgc3Rh
dGljIGludCBfX2luaXQgc3RhdGVfbmV4dCh2b2lkKQ0KPiA+ID4gIAkJcmV0ID0gZWFybHlfYW1k
X2lvbW11X2luaXQoKTsNCj4gPiA+ICAJCWluaXRfc3RhdGUgPSByZXQgPyBJT01NVV9JTklUX0VS
Uk9SIDoNCj4gPiBJT01NVV9BQ1BJX0ZJTklTSEVEOw0KPiA+ID4gIAkJaWYgKGluaXRfc3RhdGUg
PT0gSU9NTVVfQUNQSV9GSU5JU0hFRCAmJg0KPiA+IGFtZF9pb21tdV9kaXNhYmxlZCkgew0KPiA+
ID4gLQkJCXByX2luZm8oIkFNRCBJT01NVSBkaXNhYmxlZCBvbiBrZXJuZWwgY29tbWFuZC0NCj4g
PiBsaW5lXG4iKTsNCj4gPiA+ICsJCQlwcl9pbmZvKCJBTUQgSU9NTVUgZGlzYWJsZWRcbiIpOw0K
PiA+ID4gIAkJCWluaXRfc3RhdGUgPSBJT01NVV9DTURMSU5FX0RJU0FCTEVEOw0KPiA+ID4gIAkJ
CXJldCA9IC1FSU5WQUw7DQo+ID4gPiAgCQl9DQoNCg==
