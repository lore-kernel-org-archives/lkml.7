Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CFC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="E8Be1q65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDIORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:17:50 -0400
Received: from mail-eopbgr730077.outbound.protection.outlook.com ([40.107.73.77]:21114
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIORq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvyflkmnKfvlccwSogOs65ZBTrmmtvji8K0vGJVWLng=;
 b=E8Be1q65FxPI1ryqOw0KDfaneUYYa/WWGQN8S4sP5g20Ke0aYKax+2cVvjXYFxynILROXGOuTDswdgujX8PWkypbXbxzCMgrZ34GQudVQ/3gWkOyl5LM51e6oEt7nfsbKdZR1UQXGV4rVVEq9onNJDLIWT7mylKEYVI5jKkdyRU=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6575.namprd05.prod.outlook.com (20.178.248.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.7; Tue, 9 Apr 2019 14:17:40 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 14:17:40 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgA=
Date:   Tue, 9 Apr 2019 14:17:40 +0000
Message-ID: <466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
         <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
         <20190409095740.GE6827@lst.de>
         <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
         <20190409133157.GA10876@lst.de>
In-Reply-To: <20190409133157.GA10876@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4a54a59-b8ca-4004-05d5-08d6bcf62033
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6575;
x-ms-traffictypediagnostic: MN2PR05MB6575:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR05MB6575D36135F1EA356410271CA12D0@MN2PR05MB6575.namprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(54534003)(6246003)(305945005)(186003)(11346002)(81156014)(2501003)(105586002)(53936002)(446003)(486006)(2616005)(476003)(1730700003)(2351001)(5640700003)(6116002)(2906002)(3846002)(8676002)(6512007)(8936002)(7736002)(6916009)(102836004)(81166006)(106356001)(26005)(6306002)(6506007)(76176011)(71200400001)(71190400001)(118296001)(229853002)(5660300002)(256004)(45080400002)(68736007)(14444005)(966005)(6486002)(316002)(54906003)(86362001)(36756003)(25786009)(97736004)(99286004)(14454004)(93886005)(66066001)(6436002)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6575;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iI6DhIXeC0WlDD1UjTUb/d9fnUJFFW8Va8y0HUDGa5IfwMXpLlsV6rtoNdU3LMzchLuxuk7W2GapEJ3nxbdu+2ht/Km0c+M3r53byfU+IQrL3DnupRv5JwPKtR3YszKEaYaSsWePSAZ5WxzTqZ6FL9TMIdgpNEW4K571W2V2gL7v/dzFYJNHdxRHqIvaBEKa8MWifK37cIzpVFiTsAmMoU6gQy1IL0mZESzOx7wFKZKER2tf5BA+7UDf6qSvGQ9o0aaW6gV/LWbir4/mzJMy+gVrm4C5xvrY3BdyXkXLyRTQWN0WkS4kUlVybU6rDVS1bgbYnMJ4EV3mKCYuMaPsNCcZAK/foWlKML/eRuVCtb7oRdqzLXE9nzlA6VVRncPJgcOiTMaDr1hTdRsq5ZjcnRBU6Xqg8LrR7CZGAraM1V0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF776B10FD27C4D84FB452D0A206EF9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a54a59-b8ca-4004-05d5-08d6bcf62033
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 14:17:40.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA0LTA5IGF0IDE1OjMxICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUdWUsIEFwciAwOSwgMjAxOSBhdCAwMTowNDo1MVBNICswMDAwLCBUaG9tYXMgSGVsbHN0cm9t
IHdyb3RlOg0KPiA+IE9uIHRoZSBWTXdhcmUgcGxhdGZvcm0gd2UgaGF2ZSB0d28gcG9zc2libGUg
dklPTU1VUywgdGhlIEFNRCBpb21tdQ0KPiA+IGFuZA0KPiA+IEludGVsIFZURCwgR2l2ZW4gdGhv
c2UgY29uZGl0aW9ucyBJIGJlbGl2ZSB0aGUgcGF0Y2ggaXMNCj4gPiBmdW5jdGlvbmFsbHkNCj4g
PiBjb3JyZWN0LiBXZSBjYW4ndCBjb3ZlciB0aGUgQU1EIGNhc2Ugd2l0aCBpbnRlbF9pb21tdV9l
bmFibGVkLg0KPiA+IEZ1cnRoZXJtb3JlIHRoZSBvbmx5IGZvcm0gb2YgaW5jb2hlcmVuY3kgdGhh
dCBjYW4gYWZmZWN0IG91cg0KPiA+IGdyYXBoaWNzDQo+ID4gZGV2aWNlIGlzIHNvbWVvbmUgZm9y
Y2luZyBTV0lPVExCIGluIHdoaWNoIGNhc2UgdGhhdCBwZXJzb24gd291bGQNCj4gPiBiZQ0KPiA+
IGhhcHBpZXIgd2l0aCBzb2Z0d2FyZSByZW5kZXJpbmcuIEluIGFueSBjYXNlLCBvYnNlcnZpbmcg
dGhlIGZhY3QNCj4gPiB0aGF0DQo+ID4gdGhlIGRpcmVjdF9vcHMgYXJlIG5vdCB1c2VkIG1ha2Vz
IHN1cmUgdGhhdCBTV0lPVExCIGlzIG5vdCB1c2VkLg0KPiA+IEtub3dpbmcgdGhhdCB3ZSdyZSBv
biB0aGUgVk13YXJlIHBsYXRmb3JtLCB3ZSdyZSBjb2hlcmVudCBhbmQgY2FuDQo+ID4gc2FmZWx5
IGhhdmUgdGhlIGRtYSBsYXllciBkbyBkbWEgYWRkcmVzcyB0cmFuc2xhdGlvbiBmb3IgdXMuIEFs
bA0KPiA+IHRoaXMNCj4gPiBpbmZvcm1hdGlvbiB3YXMgbm90IGV4cGxpY2lsdHkgd3JpdHRlbiBp
biB0aGUgY2hhbmdlbG9nLCBuby4NCj4gDQo+IFdlIGhhdmUgYSBzZXJpZXMgcGVuZGluZyB0aGF0
IG1pZ2h0IGJvdW5jZSB5b3VyIGJ1ZmZlcnMgZXZlbiB3aGVuDQo+IHVzaW5nIHRoZSBJbnRlbCBJ
T01NVSwgd2hpY2ggc2hvdWxkIGV2ZW50dWFsbHkgYWxzbyBmaW5kIGl0cyB3YXkNCj4gdG8gb3Ro
ZXIgSU9NTVVzOg0KPiANCj4gICAgIA0KPiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5saW51eGZvdW5kYXRpb24u
b3JnJTJGcGlwZXJtYWlsJTJGaW9tbXUlMkYyMDE5LU1hcmNoJTJGMDM0MDkwLmh0bWwmYW1wO2Rh
dGE9MDIlN0MwMSU3Q3RoZWxsc3Ryb20lNDB2bXdhcmUuY29tJTdDOTkzM2VlN2I4MDU4NDI2MDdl
YTkwOGQ2YmNlZmM1MDUlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0Mw
JTdDNjM2OTA0MTM1MzQ1MDEwNjg3JmFtcDtzZGF0YT1QeDUwMCUyQjFGakwlMkZaTGVkVWRiQVh6
NGElMkJUNURhWkJGZjZ3bmVzVHlGdlpZJTNEJmFtcDtyZXNlcnZlZD0wDQoNCklmIHRoYXQncyB0
aGUgY2FzZSwgSSB0aGluayBtb3N0IG9mIHRoZSBncmFwaGljcyBkcml2ZXJzIHdpbGwgc3RvcA0K
ZnVuY3Rpb25pbmcuIEkgZG9uJ3QgdGhpbmsgcGVvcGxlIHdvdWxkIHdhbnQgdGhhdCwgYW5kIGV2
ZW4gaWYgdGhlDQpncmFwaGljcyBkcml2ZXJzIGFyZSAidG8gYmxhbWUiIGR1ZSB0byBub3QgaW1w
bGVtZW50aW5nIHRoZSBzeW5jIGNhbGxzLA0KSSB0aGluayB0aGUgd29yayBpbnZvbHZlZCB0byBn
ZXQgdGhpbmdzIHJpZ2h0IGlzIGltcHJlc3NpdmUgaWYgYXQgYWxsDQpwb3NzaWJsZS4NCg0KPiAN
Cj4gPiBJbiBhbnkgY2FzZSwgYXNzdW1pbmcgdGhhdCB0aGF0IHBhdGNoIGlzIHJldmVydGVkIGR1
ZSB0byB0aGUNCj4gPiBsYXllcmluZw0KPiA+IHZpb2xhdGlvbiwgQXJlIHlvdSB3aWxsaW5nIHRv
IGhlbHAgb3V0IHdpdGggYSBzbWFsbCBBUEkgdG8gZGV0ZWN0DQo+ID4gdGhlDQo+ID4gc2l0dWF0
aW9uIHdoZXJlIHN0cmVhbWluZyBETUEgaXMgaW5jb2hlcmVudD8NCj4gDQo+IFRoZSBzaG9ydCBi
dXQgc2FkIGFuc3dlciBpcyB0aGF0IHdlIGNhbid0IGV2ZXIgZ3VhcmFudGVlIHRoYXQgeW91DQo+
IGNhbiBza2lwIHRoZSBkbWFfKnN5bmNfKiBjYWxscy4gIFRoZXJlIGFyZSB0b28gbWFueSBmYWN0
b3JzIGluIHBsYXkNCj4gdGhhdCBtaWdodCByZXF1aXJlIGl0IGF0IGFueSB0aW1lIC0gd29ya2lu
ZyBhcm91bmQgdW5hbGlnbmVkDQo+IGFkZHJlc3Nlcw0KPiBpbiBpb21tdXMsIENQVXMgdGhhdCBh
cmUgY29oZXJlbnQgZm9yIHNvbWUgZGV2aWNlIGFuZCBub3Qgc29tZSwNCj4gYWRkcmVzc2luZw0K
PiBsaW1pdGF0aW9ucyBib3RoIGluIHBoeXNpY2FsIENQVXMgYW5kIFZNcyAoc2VlIHRoZSB2YXJp
b3VzICJzZWN1cmUNCj4gVk0iDQo+IGNvbmNlcHRzIGZsb2F0aW5nIGFyb3VuZCBhdCB0aGUgbW9t
ZW50KS4NCj4gDQo+IElmIHlvdSB3YW50IHRvIGF2b2lkIHRoZSBkbWFfKnN5bmNfKiBjYWxscyB5
b3UgbXVzdCB1c2UNCj4gZG1hX2FsbG9jX2NvaGVyZW50IHRvIGFsbG9jYXRlIHRoZSBtZW1vcnku
ICBOb3RlIHRoYXQgdGhlIG1lbW9yeSBmb3INCj4gZG1hX2FsbG9jX2NvaGVyZW50IGFjdHVhbGx5
IGNvbWVzIGZyb20gdGhlIG5vcm1hbCBwYWdlIHBvb2wgbW9zdCBvZg0KPiB0aGUgdGltZSwgYW5k
IGZvciBjZXJ0YWluIG9uIHg4Niwgd2hpY2ggc2VlbXMgdG8gYmUgd2hhdCB5b3UgY2FyZQ0KPiBh
Ym91dC4gIFRoZSB0aW1lcyBvZiBpdCBkaXBwaW5nIGludG8gdGhlIHRpbnkgc3dpb3RsYiBwb29s
IGFyZSBsb25nDQo+IGdvbmUuICBTbyBhdCBsZWFzdCBmb3IgeW91IEkgc2VlIGFic29sdXRlbHkg
bm8gcmVhc29uIHRvIG5vdCBzaW1wbHkNCj4gYWx3YXlzIHVzZSBkbWFfYWxsb2NfY29oZXJlbnQg
dG8gc3RhcnQgd2l0aC4gIEZvciBvdGhlciB1c2VzIHRoYXQNCj4gaW52b2x2ZSBwbGF0Zm9ybXMg
d2l0aG91dCBETUEgY29oZXJlbnQgZGV2aWNlcyBsaWtlIGFybSB0aGUgdHJhZGVvZmZzDQo+IG1p
Z2h0IGJlIGEgbGl0dGxlIGRpZmZlcmVudC4NCg0KVGhlcmUgYXJlIHR3byB0aGluZ3MgdGhhdCBj
b25jZXJucyBtZSB3aXRoIGRtYV9hbGxvY19jb2hlcmVudDoNCg0KMSkgSXQgc2VlbXMgdG8gd2Fu
dCBwYWdlcyBtYXBwZWQgZWl0aGVyIGluIHRoZSBrZXJuZWwgbWFwIG9yIHZtYXBwZWQuDQpHcmFw
aGljcyBkcml2ZXJzIGFsbG9jYXRlIGh1Z2UgYW1vdW50cyBvZiBtZW1vcnksIFR5cGljYWxseSB1
cCB0byA1MCUNCm9mIHN5c3RlbSBtZW1vcnkgb3IgbW9yZS4gSW4gYSAzMiBiaXQgUEFFIHN5c3Rl
bSBJJ20gYWZyYWlkIG9mIHJ1bm5pbmcNCm91dCBvZiB2bWFwIHNwYWNlIGFzIHdlbGwgYXMgbm90
IGJlaW5nIGFibGUgdG8gYWxsb2NhdGUgYXMgbXVjaCBtZW1vcnkNCmFzIEkgd2FudC4gUGVyaGFw
cyBhIGRtYV9hbGxvY19jb2hlcmVudCgpIGludGVyZmFjZSB0aGF0IHJldHVybnMgYSBwYWdlDQpy
YXRoZXIgdGhhbiBhIHZpcnR1YWwgYWRkcmVzcyB3b3VsZCBkbyB0aGUgdHJpY2suDQoNCjIpIEV4
cG9ydGluZyB1c2luZyBkbWEtYnVmLiBBIHBhZ2UgYWxsb2NhdGVkIHVzaW5nIGRtYV9hbGxvY19j
b2hlcmVudCgpDQpmb3Igb25lIGRldmljZSBtaWdodCBub3QgYmUgY29oZXJlbnQgZm9yIGFub3Ro
ZXIgZGV2aWNlLiBXaGF0IGhhcHBlbnMNCmlmIEkgYWxsb2NhdGUgYSBwYWdlIHVzaW5nIGRtYV9h
bGxvY19jb2hlcmVudCgpIGZvciBkZXZpY2UgMSBhbmQgdGhlbg0Kd2FudCB0byBtYXAgaXQgdXNp
bmcgZG1hX21hcF9wYWdlKCkgZm9yIGRldmljZSAyPw0KDQpUaGFua3MsDQpUaG9tYXMNCg0KDQoN
Cg==
