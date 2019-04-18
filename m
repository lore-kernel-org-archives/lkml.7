Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F854C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF042064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wxnJHb2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbfDRQks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:40:48 -0400
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:51845
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731317AbfDRQks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VhXRfv4HBYs8vljFILdL2qGLEfzsTLWeEMw9f7Qw1g=;
 b=wxnJHb2u5C6NcAFj+u6vgFJEDKXSkk0mJaBwI3usMcYOP8XTsSn/Iy5eAkZ3KPCaKqx136gWba4MqzhYHAvx1cbId8hx9yV5bJuA9PX1V/EDYrGF+Rm7nixPB3X9mcRSsHwR/Pdl6bkUAtUrBO8o1ArU/EqD7WY55xKxLUlP+BM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2623.namprd12.prod.outlook.com (52.135.103.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 16:40:44 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 16:40:44 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: RE: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Topic: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Index: AQHU6yz1dnTlH1WoLEy8yDNVtzL7aaY94MgAgAC38YCAAhQMIIAAUcCAgAEj9oA=
Date:   Thu, 18 Apr 2019 16:40:44 +0000
Message-ID: <SN6PR12MB26398F6D82DA91A7D56E007BF8260@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
 <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com>
 <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
 <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
 <CAJZ5v0hJpYROLJup0mvCp2G8ekeDyBrp+hdhHdsd+vhBq5RxVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hJpYROLJup0mvCp2G8ekeDyBrp+hdhHdsd+vhBq5RxVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [75.66.99.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158f2c5d-3273-41c4-d4a8-08d6c41c9a5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2623;
x-ms-traffictypediagnostic: SN6PR12MB2623:
x-microsoft-antispam-prvs: <SN6PR12MB2623794BF7E5DB9C0A36348CF8260@SN6PR12MB2623.namprd12.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(13464003)(6436002)(66066001)(8936002)(14444005)(26005)(99286004)(186003)(53546011)(7696005)(486006)(316002)(102836004)(81156014)(6506007)(476003)(3846002)(8676002)(446003)(86362001)(81166006)(71190400001)(71200400001)(76176011)(256004)(6116002)(11346002)(2906002)(97736004)(52536014)(4326008)(74316002)(6246003)(305945005)(93886005)(229853002)(7416002)(33656002)(478600001)(6916009)(7736002)(55016002)(68736007)(9686003)(72206003)(5660300002)(14454004)(53936002)(25786009)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2623;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i6wiBNTlfeQCbNI82tdet86V4sE+hxNa1cNAU/PKl0jS7iSkYnwQm19f1E9tZKvjJby73ff4ZWZLVlE0rpNKI/cz34qxPumGeg+TiKMjQ/EwDB9lX534m/Ftoli1HAxbuCbulyoQg5nSHZ6LzqHS/pnDtkk4VePT+Jm4VS8Tt/MeLb3msooMztookFzb8qGQ87clNNBkwgDBgAsu9kUNayXJq0I37ZsK76hAmd0pE/GQTmFNgLbGN2qar8klz+VfYzp9JlAqMiUZtiqQI9WQuINDSBh/J2sRP1b8mN9+yxZcbHQSKfYm9ZftynkAKFRsE6k1+eVV1aUV6S9HScN/4q1SoAcXoJIQv4u4IL6JRIqRenqLZamL4dEt+QRpL/9ygeYtDST0qw6WK15fqTaeHgwfQMb4jYDMIglOFlvqEhg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158f2c5d-3273-41c4-d4a8-08d6c41c9a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 16:40:44.5544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTcsIDIwMTkgNTox
MSBQTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IE5hdGFyYWphbiwgSmFuYWth
cmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBhbWQuY29tPjsgbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7IFJhZmFlbCBKIC4gV3lzb2NraSA8cmp3QHJq
d3lzb2NraS5uZXQ+OyBMZW4gQnJvd24NCj4gPGxlbmJAa2VybmVsLm9yZz47IFZpcmVzaCBLdW1h
ciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBSb2JlcnQgTW9vcmUgPHJvYmVydC5tb29yZUBp
bnRlbC5jb20+OyBFcmlrIFNjaG1hdXNzDQo+IDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIENQUEMgb3B0aW9uYWwgcmVnaXN0ZXJzIEFNRCBz
dXBwb3J0DQo+IA0KPiBPbiBXZWQsIEFwciAxNywgMjAxOSBhdCA3OjI4IFBNIEdoYW5uYW0sIFlh
emVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBr
ZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTYsIDIwMTkgNDozNCBBTQ0K
PiA+ID4gVG86IE5hdGFyYWphbiwgSmFuYWthcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBh
bWQuY29tPg0KPiA+ID4gQ2M6IE5hdGFyYWphbiwgSmFuYWthcmFqYW4gPEphbmFrYXJhamFuLk5h
dGFyYWphbkBhbWQuY29tPjsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4gcG1Admdlci5rZXJuZWwub3JnOyBkZXZl
bEBhY3BpY2Eub3JnOyBSYWZhZWwgSiAuIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PjsgTGVu
IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBWaXJlc2ggS3VtYXINCj4gPiA+IDx2aXJlc2gua3Vt
YXJAbGluYXJvLm9yZz47IFJvYmVydCBNb29yZSA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IEVy
aWsgU2NobWF1c3MgPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPjsgR2hhbm5hbSwgWWF6ZW4NCj4g
PiA+IDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDAvN10gQ1BQQyBvcHRpb25hbCByZWdpc3RlcnMgQU1EIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBP
biBUdWUsIEFwciAxNiwgMjAxOSBhdCAxMjozNSBBTSBKYW5ha2FyYWphbiBOYXRhcmFqYW4gPGpu
YXRhcmFqQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiA0LzQvMTkgNDoyNSBQ
TSwgTmF0YXJhamFuLCBKYW5ha2FyYWphbiB3cm90ZToNCj4gPiA+ID4gPiBDUFBDIChDb2xsYWJv
cmF0aXZlIFByb2Nlc3NvciBQZXJmb3JtYW5jZSBDb250cm9sKSBvZmZlcnMgb3B0aW9uYWwNCj4g
PiA+ID4gPiByZWdpc3RlcnMgd2hpY2ggY2FuIGJlIHVzZWQgdG8gdHVuZSB0aGUgc3lzdGVtIGJh
c2VkIG9uIGVuZXJneSBhbmQvb3INCj4gPiA+ID4gPiBwZXJmb3JtYW5jZSByZXF1aXJlbWVudHMu
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOZXdlciBBTUQgcHJvY2Vzc29ycyBhZGQgc3VwcG9ydCBm
b3IgYSBzdWJzZXQgb2YgdGhlc2Ugb3B0aW9uYWwgQ1BQQw0KPiA+ID4gPiA+IHJlZ2lzdGVycywg
YmFzZWQgb24gQUNQSSB2Ni4xLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGZvbGxvd2luZyBh
cmUgdGhlIHN1cHBvcnRlZCBDUFBDIHJlZ2lzdGVycyBmb3Igd2hpY2ggc3lzZnMgZW50cmllcw0K
PiA+ID4gPiA+IGFyZSBjcmVhdGVkOg0KPiA+ID4gPiA+ICogZW5hYmxlICAgICAgICAgICAgICAg
IChORVcpDQo+ID4gPiA+ID4gKiBtYXhfcGVyZiAgICAgICAgICAgICAgKE5FVykNCj4gPiA+ID4g
PiAqIG1pbl9wZXJmICAgICAgICAgICAgICAoTkVXKQ0KPiA+ID4gPiA+ICogZW5lcmd5X3BlcmYN
Cj4gPiA+ID4gPiAqIGxvd2VzdF9wZXJmDQo+ID4gPiA+ID4gKiBub21pbmFsX3BlcmYNCj4gPiA+
ID4gPiAqIGRlc2lyZWRfcGVyZiAgICAgICAgICAoTkVXKQ0KPiA+ID4gPiA+ICogZmVlZGJhY2tf
Y3Rycw0KPiA+ID4gPiA+ICogYXV0b19zZWxfZW5hYmxlICAgICAgIChORVcpDQo+ID4gPiA+ID4g
KiBsb3dlc3Rfbm9ubGluZWFyX3BlcmYNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBDUFBDIGRy
aXZlciBpcyB1cGRhdGVkIHRvIGVuYWJsZSB0aGUgT1NQTSBhbmQgdGhlIHVzZXJzcGFjZSB0bw0K
PiA+ID4gPiA+IGFjY2Vzcw0KPiA+ID4gPiA+IHRoZSBuZXdseSBzdXBwb3J0ZWQgcmVnaXN0ZXJz
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHB1cnBvc2Ugb2YgZXhwb3NpbmcgdGhlIHJlZ2lz
dGVycyB2aWEgdGhlIHN5c2ZzIGVudHJpZXMgaXMgdG8gYWxsb3cNCj4gPiA+ID4gPiB0aGUgdXNl
cnNwYWNlIHRvOg0KPiA+ID4gPiA+ICogVHdlYWsgdGhlIHZhbHVlcyB0byBmaXQgaXRzIHdvcmts
b2FkLg0KPiA+ID4gPiA+ICogQXBwbHkgYSBwcm9maWxlIGZyb20gQU1EJ3Mgb3B0aW1pemF0aW9u
IGd1aWRlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFByb2ZpbGVzIHdpbGwgYmUgZG9jdW1lbnRl
ZCBpbiB0aGUgcGVyZm9ybWFuY2Uvb3B0aW1pemF0aW9uIGd1aWRlcy4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IE5vdGU6DQo+ID4gPiA+ID4gKiBBTUQgc3lzdGVtcyB3aWxsIG5vdCBoYXZlIGEgcG9s
aWN5IGFwcGxpZWQgaW4gdGhlIGtlcm5lbCBhdCB0aGlzIHRpbWUuDQo+ID4gPiA+ID4gKiBCeSBk
ZWZhdWx0LCBhY3BpX2NwdWZyZXEgd2lsbCBzdGlsbCBiZSB1c2VkLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVE9ETzoNCj4gPiA+ID4gPiAqIENyZWF0ZSBhIGxpbnV4IHVzZXJzcGFjZSB0b29sIHRo
YXQgd2lsbCBoZWxwIHVzZXJzIGdlbmVyYXRlIGEgQ1BQQw0KPiA+ID4gPiA+ICogcHJvZmlsZQ0K
PiA+ID4gPiA+ICAgIGZvciB0aGVpciB0YXJnZXQgd29ya2xvYWQuDQo+ID4gPiA+ID4gKiBDcmVh
dGUgb3IgdXBkYXRlIGEgZHJpdmVyIHRvIGFwcGx5IGEgZ2VuZXJhbCBDUFBDIHBvbGljeSBpbiB0
aGUNCj4gPiA+ID4gPiAqIGtlcm5lbC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHYxLT52MjoNCj4g
PiA+ID4gPiAqIEFkZCBtYWNybyB0byBlbnN1cmUgQlVGRkVSIG9ubHkgcmVnaXN0ZXJzIGhhdmUg
QlVGRkVSIHR5cGUuDQo+ID4gPiA+ID4gKiBBZGQgc3VwcG9ydCBtYWNybyB0byBtYWtlIHRoZSBy
aWdodCBjaGVjayBiYXNlZCBvbiByZWdpc3RlciB0eXBlLg0KPiA+ID4gPiA+ICogUmVtb3ZlIHN1
cHBvcnQgY2hlY2tzIGZvciByZWdpc3RlcnMgd2hpY2ggYXJlIG1hbmRhdG9yeS4NCj4gPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gQXJlIHRoZXJlIGFueSBjb25jZXJucyByZWdhcmRpbmcgdGhpcyBw
YXRjaHNldD8NCj4gPiA+DQo+ID4gPiBZZXMsIHRoZXJlIGFyZS4NCj4gPiA+DQo+ID4gPiBVbmZv
cnR1bmF0ZWx5LCBpdCBpcyBnZW5lcmFsbHkgcHJvYmxlbWF0aWMuDQo+ID4gPg0KPiA+ID4gRmly
c3Qgb2ZmLCB0aGUgYmVoYXZpb3Igb2YgZXhpc3Rpbmcgc3lzZnMgZmlsZXMgY2Fubm90IGJlIGNo
YW5nZWQgYXQNCj4gPiA+IHdpbGwsIGFzIHRoZXJlIG1heSBiZSB1c2VycyBvZiB0aGVtIG91dCB0
aGVyZSBhbHJlYWR5IGRlcGVuZGluZyBvbiB0aGUNCj4gPiA+IGN1cnJlbnQgYmVoYXZpb3IuDQo+
ID4gPg0KPiA+DQo+ID4gVGhlIGludGVudCBpcyB0byBhZGQgbmV3IHN5c2ZzIGZpbGVzIHdpdGhv
dXQgY2hhbmdpbmcgdGhlIGV4aXN0aW5nIGZpbGVzLiBJcyB0aGF0IG9rYXk/DQo+ID4NCj4gPiBP
ciBpcyB0aGUgYWRkaXRpb24gb2YgbmV3IGZpbGVzIGFsc28gbm90IGFjY2VwdGFibGU/DQo+ID4N
Cj4gPiA+IFNlY29uZCwgYXQgbGVhc3Qgc29tZSBDUFBDIGNvbnRyb2wgcmVnaXN0ZXJzIGFyZSB1
c2VkIGJ5IGNwdWZyZXENCj4gPiA+IGRyaXZlcnMgKGNwcGNfY3B1ZnJlcSBhbmQgaW50ZWxfcHN0
YXRlKSwgc28gbW9kaWZ5aW5nIHRoZW0gYmVoaW5kIHRoZQ0KPiA+ID4gZHJpdmVycycgYmFja3Mg
aXMgbm90IGEgZ29vZCBpZGVhIGluIGdlbmVyYWwuICBGb3IgdGhpcyByZWFzb24sIGFkZGluZw0K
PiA+ID4gbmV3IHN5c2ZzIGF0dHJpYnV0ZXMgdG8gYWxsb3cgdXNlciBzcGFjZSB0byBkbyB0aGF0
IGlzIHF1aXRlDQo+ID4gPiBxdWVzdGlvbmFibGUuDQo+ID4gPg0KPiA+DQo+ID4gWWVzLCBnb29k
IHBvaW50Lg0KPiA+DQo+ID4gV2hhdCBpZiBhIGNoZWNrIGlzIGFkZGVkIHNvIHRoYXQgd3JpdGVz
IG9ubHkgc3VjY2VlZCBpZiB0aGUgQ1BVRlJFUSBnb3Zlcm5vciBpcyBzZXQgdG8gdXNlcnNwYWNl
Pw0KPiANCj4gVGhhdCB3b3VsZG4ndCBiZSBwYXJ0aWN1bGFybHkgc3RyYWlnaHRmb3J3YXJkIElN
Ty4NCj4gDQo+IFdoYXQgYWJvdXQgaGFuZGxpbmcgdGhpcyBsaWtlIHRoZSBvdGhlcnMgZG8sIHRo
cm91Z2ggYSBwcm9wZXIgY3B1ZnJlcSBkcml2ZXI/DQoNClRoYXQgc2VlbWVkIHVubmVjZXNzYXJ5
LiBXZSB3YW50IHRvIGV4cG9zZSB0aGUgQ1BQQyBpbnRlcmZhY2UgZGlyZWN0bHkgc28gdGhhdCBh
ZHZhbmNlZCB1c2VycyBjYW4gaW50ZXJhY3Qgd2l0aCB0aGUgUGxhdGZvcm0gd2l0aG91dCBDUFVG
UkVRLiBJdCBzZWVtZWQgbGlrZSB0aGUgc2ltcGxlc3Qgd2F5IHRvIGRvIHRoaXMgaXMgdG8gZXh0
ZW5kIHRoZSBleGlzdGluZyBDUFBDIHN5c2ZzIGludGVyZmFjZS4gQWxzbywgZG9pbmcgaXQgdGhp
cyB3YXkgd291bGQga2VlcCB0aGUgaW50ZXJmYWNlIGRyaXZlci92ZW5kb3ItbmV1dHJhbCwgc28g
dXNlcnMgb24gYW55IENQUEMtZW5hYmxlZCBwbGF0Zm9ybSBjb3VsZCB1c2UgaXQuDQoNCkhvd2V2
ZXIsIEkgdW5kZXJzdGFuZCBpZiB0aGF0J3MgdG9vIGJpZyBvZiBhIGNoYW5nZS4NCg0KSW4gdGhp
cyBjYXNlLCB3b3VsZCB5b3UgcHJlZmVyIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc/DQox
KSBNb3ZlIHRoZSBuZXcgaW50ZXJmYWNlIHNvbWV3aGVyZSBlbHNlIChhbm90aGVyIHBhdGgsIGRl
YnVnZnMsIGV0Yy4/KSBhbmQgbWFyayBpdCBhcyAidGVzdGluZyIuIFRoaXMgY291bGQgcmVpbmZv
cmNlIHRoYXQgdGhlIG5ldyBpbnRlcmZhY2UgaXMgZm9yIGFkdmFuY2VkIHVzZXJzLCB0ZXN0aW5n
LCBkZWJ1Z2dpbmcsIGV0Yy4gSG93ZXZlciwgdGhlIGludGVyZmFjZSB3b3VsZCBzdGlsbCBiZSBw
b3B1bGF0ZWQgYnkgY3BwY19saWIgYW5kIHdvdWxkIHJlbWFpbiBkcml2ZXIvdmVuZG9yLW5ldXRy
YWwuIEFuZCB3ZSBjb3VsZCByZXN0cmljdCB0aGUgaW50ZXJmYWNlIHRvIHByZXZlbnQgaW50ZXJh
Y3Rpb25zIHdpdGggdGhlIENQVUZSRVEgZHJpdmVycy4NCjIpIE9yLCBjcmVhdGUgYSBuZXcgQ1BV
RlJFUSBkcml2ZXIuIFRoZSBjcHBjX2xpYiBjb2RlIGNvdWxkIHN0aWxsIGJlIHVwZGF0ZWQgdG8g
c3VwcG9ydCB0aGUgbmV3IENQUEMgcmVnaXN0ZXJzLCBidXQgdGhlIGRyaXZlciB3b3VsZCBlbmFi
bGUgdGhlIHN5c2ZzIGludGVyZmFjZS4gVGhpcyB3b3VsZCBwcmV2ZW50IGFueSBpbnRlcmFjdGlv
bnMgd2l0aCBleGlzdGluZyBDUFVGUkVRIGRyaXZlcnMsIGJ1dCB1c2VycyB3aWxsIG5lZWQgdG8g
ZG8gbW9yZSB0byBlbmFibGUgdGhlIGludGVyZmFjZS4gV2UgY2FuIHN0aWxsIGtlZXAgdGhpcyBk
cml2ZXIgdmVuZG9yLW5ldXRyYWwgKGNwcGNfdXNlcnNwYWNlX2NwdWZyZXE/KS4NCg0KVGhhbmtz
LA0KWWF6ZW4NCg==
