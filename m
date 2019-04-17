Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B638D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ygYue7zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfDQR2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:28:43 -0400
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:58328
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729641AbfDQR2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGQnt6zOelIHqW7eHJv7HYCG3O+QBV5Mrq2tK+hkmXs=;
 b=ygYue7zocWBIxgYuB798D0wKmBiWeV5NOJr0xNpqZ++vhle9cFwIQbLmUSmhidiK0+HiOaPFvJ5Y5cD6QAqWeCl7TF/VGfzpG3LMuwEoi4tpgG00C+C55Zru1uMRasHqTAzmnoqy2EgbBja+HriqyCPDGMfavYbIdlZfTYZIBuc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2606.namprd12.prod.outlook.com (52.135.102.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 17:28:33 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 17:28:33 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
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
Thread-Index: AQHU6yz1dnTlH1WoLEy8yDNVtzL7aaY94MgAgAC38YCAAhQMIA==
Date:   Wed, 17 Apr 2019 17:28:32 +0000
Message-ID: <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
 <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com>
 <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [75.66.99.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2977176b-2eb4-4e2f-01b8-08d6c35a1da3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2606;
x-ms-traffictypediagnostic: SN6PR12MB2606:
x-microsoft-antispam-prvs: <SN6PR12MB26069EFE3E28234F2A5E18F3F8250@SN6PR12MB2606.namprd12.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(13464003)(189003)(199004)(99286004)(7696005)(76176011)(316002)(110136005)(54906003)(6116002)(3846002)(6636002)(4326008)(74316002)(305945005)(71200400001)(7416002)(68736007)(86362001)(71190400001)(7736002)(25786009)(53936002)(55016002)(256004)(14444005)(97736004)(81156014)(33656002)(6246003)(81166006)(8676002)(9686003)(186003)(53546011)(106356001)(6506007)(102836004)(8936002)(26005)(6436002)(229853002)(2906002)(66066001)(14454004)(72206003)(478600001)(11346002)(476003)(105586002)(446003)(5660300002)(486006)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2606;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YSEeQ+jgMRml7Y9BAw2wa/dC6br4Za4sF3sVcQ87LHLLOcywIj6LoucDJegvX5Wh8SmDM2JM99pg/93GHNVEsYfch1oufQ40uOhYNPHSejNn2abhzvKJPVamZ3qWmgTvtyFs0Z5vUPRnDZGlg+ewibXJs5AHwSj3FkhUNl3YnuRM1OWN12E9Zo7rIDgEGcgtd1soNiRNS20t60YkZClIazgyt/NQuows+lhpNRuxBJwoyBf1GdkKLDxKypARp9siLqnHXy1FB0GiGNzwDtwdupo328eRoa/unDRuo2OIysw7U4hzImz9dgDg+aCOLFh53NWE5vevedOBWahFYJ3p1mBelA2DdUj4wVx/Swway6tJ/8opwsIYDuumA6e6RvRCMKQYqJAzn5qnxDWvnnx8FY+5sypXwE4DkbrQPCQVvR4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2977176b-2eb4-4e2f-01b8-08d6c35a1da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 17:28:33.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE2LCAyMDE5IDQ6MzQg
QU0NCj4gVG86IE5hdGFyYWphbiwgSmFuYWthcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBh
bWQuY29tPg0KPiBDYzogTmF0YXJhamFuLCBKYW5ha2FyYWphbiA8SmFuYWthcmFqYW4uTmF0YXJh
amFuQGFtZC5jb20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHBtQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNh
Lm9yZzsgUmFmYWVsIEogLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IExlbiBCcm93biA8
bGVuYkBrZXJuZWwub3JnPjsgVmlyZXNoIEt1bWFyDQo+IDx2aXJlc2gua3VtYXJAbGluYXJvLm9y
Zz47IFJvYmVydCBNb29yZSA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IEVyaWsgU2NobWF1c3Mg
PGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPjsgR2hhbm5hbSwgWWF6ZW4NCj4gPFlhemVuLkdoYW5u
YW1AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIENQUEMgb3B0aW9uYWwg
cmVnaXN0ZXJzIEFNRCBzdXBwb3J0DQo+IA0KPiBPbiBUdWUsIEFwciAxNiwgMjAxOSBhdCAxMjoz
NSBBTSBKYW5ha2FyYWphbiBOYXRhcmFqYW4gPGpuYXRhcmFqQGFtZC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gT24gNC80LzE5IDQ6MjUgUE0sIE5hdGFyYWphbiwgSmFuYWthcmFqYW4gd3JvdGU6DQo+
ID4gPiBDUFBDIChDb2xsYWJvcmF0aXZlIFByb2Nlc3NvciBQZXJmb3JtYW5jZSBDb250cm9sKSBv
ZmZlcnMgb3B0aW9uYWwNCj4gPiA+IHJlZ2lzdGVycyB3aGljaCBjYW4gYmUgdXNlZCB0byB0dW5l
IHRoZSBzeXN0ZW0gYmFzZWQgb24gZW5lcmd5IGFuZC9vcg0KPiA+ID4gcGVyZm9ybWFuY2UgcmVx
dWlyZW1lbnRzLg0KPiA+ID4NCj4gPiA+IE5ld2VyIEFNRCBwcm9jZXNzb3JzIGFkZCBzdXBwb3J0
IGZvciBhIHN1YnNldCBvZiB0aGVzZSBvcHRpb25hbCBDUFBDDQo+ID4gPiByZWdpc3RlcnMsIGJh
c2VkIG9uIEFDUEkgdjYuMS4NCj4gPiA+DQo+ID4gPiBUaGUgZm9sbG93aW5nIGFyZSB0aGUgc3Vw
cG9ydGVkIENQUEMgcmVnaXN0ZXJzIGZvciB3aGljaCBzeXNmcyBlbnRyaWVzDQo+ID4gPiBhcmUg
Y3JlYXRlZDoNCj4gPiA+ICogZW5hYmxlICAgICAgICAgICAgICAgIChORVcpDQo+ID4gPiAqIG1h
eF9wZXJmICAgICAgICAgICAgICAoTkVXKQ0KPiA+ID4gKiBtaW5fcGVyZiAgICAgICAgICAgICAg
KE5FVykNCj4gPiA+ICogZW5lcmd5X3BlcmYNCj4gPiA+ICogbG93ZXN0X3BlcmYNCj4gPiA+ICog
bm9taW5hbF9wZXJmDQo+ID4gPiAqIGRlc2lyZWRfcGVyZiAgICAgICAgICAoTkVXKQ0KPiA+ID4g
KiBmZWVkYmFja19jdHJzDQo+ID4gPiAqIGF1dG9fc2VsX2VuYWJsZSAgICAgICAoTkVXKQ0KPiA+
ID4gKiBsb3dlc3Rfbm9ubGluZWFyX3BlcmYNCj4gPiA+DQo+ID4gPiBUaGUgQ1BQQyBkcml2ZXIg
aXMgdXBkYXRlZCB0byBlbmFibGUgdGhlIE9TUE0gYW5kIHRoZSB1c2Vyc3BhY2UgdG8NCj4gPiA+
IGFjY2Vzcw0KPiA+ID4gdGhlIG5ld2x5IHN1cHBvcnRlZCByZWdpc3RlcnMuDQo+ID4gPg0KPiA+
ID4gVGhlIHB1cnBvc2Ugb2YgZXhwb3NpbmcgdGhlIHJlZ2lzdGVycyB2aWEgdGhlIHN5c2ZzIGVu
dHJpZXMgaXMgdG8gYWxsb3cNCj4gPiA+IHRoZSB1c2Vyc3BhY2UgdG86DQo+ID4gPiAqIFR3ZWFr
IHRoZSB2YWx1ZXMgdG8gZml0IGl0cyB3b3JrbG9hZC4NCj4gPiA+ICogQXBwbHkgYSBwcm9maWxl
IGZyb20gQU1EJ3Mgb3B0aW1pemF0aW9uIGd1aWRlcy4NCj4gPiA+DQo+ID4gPiBQcm9maWxlcyB3
aWxsIGJlIGRvY3VtZW50ZWQgaW4gdGhlIHBlcmZvcm1hbmNlL29wdGltaXphdGlvbiBndWlkZXMu
DQo+ID4gPg0KPiA+ID4gTm90ZToNCj4gPiA+ICogQU1EIHN5c3RlbXMgd2lsbCBub3QgaGF2ZSBh
IHBvbGljeSBhcHBsaWVkIGluIHRoZSBrZXJuZWwgYXQgdGhpcyB0aW1lLg0KPiA+ID4gKiBCeSBk
ZWZhdWx0LCBhY3BpX2NwdWZyZXEgd2lsbCBzdGlsbCBiZSB1c2VkLg0KPiA+ID4NCj4gPiA+IFRP
RE86DQo+ID4gPiAqIENyZWF0ZSBhIGxpbnV4IHVzZXJzcGFjZSB0b29sIHRoYXQgd2lsbCBoZWxw
IHVzZXJzIGdlbmVyYXRlIGEgQ1BQQw0KPiA+ID4gKiBwcm9maWxlDQo+ID4gPiAgICBmb3IgdGhl
aXIgdGFyZ2V0IHdvcmtsb2FkLg0KPiA+ID4gKiBDcmVhdGUgb3IgdXBkYXRlIGEgZHJpdmVyIHRv
IGFwcGx5IGEgZ2VuZXJhbCBDUFBDIHBvbGljeSBpbiB0aGUNCj4gPiA+ICoga2VybmVsLg0KPiA+
ID4NCj4gPiA+IHYxLT52MjoNCj4gPiA+ICogQWRkIG1hY3JvIHRvIGVuc3VyZSBCVUZGRVIgb25s
eSByZWdpc3RlcnMgaGF2ZSBCVUZGRVIgdHlwZS4NCj4gPiA+ICogQWRkIHN1cHBvcnQgbWFjcm8g
dG8gbWFrZSB0aGUgcmlnaHQgY2hlY2sgYmFzZWQgb24gcmVnaXN0ZXIgdHlwZS4NCj4gPiA+ICog
UmVtb3ZlIHN1cHBvcnQgY2hlY2tzIGZvciByZWdpc3RlcnMgd2hpY2ggYXJlIG1hbmRhdG9yeS4N
Cj4gPg0KPiA+DQo+ID4gQXJlIHRoZXJlIGFueSBjb25jZXJucyByZWdhcmRpbmcgdGhpcyBwYXRj
aHNldD8NCj4gDQo+IFllcywgdGhlcmUgYXJlLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgaXQgaXMg
Z2VuZXJhbGx5IHByb2JsZW1hdGljLg0KPiANCj4gRmlyc3Qgb2ZmLCB0aGUgYmVoYXZpb3Igb2Yg
ZXhpc3Rpbmcgc3lzZnMgZmlsZXMgY2Fubm90IGJlIGNoYW5nZWQgYXQNCj4gd2lsbCwgYXMgdGhl
cmUgbWF5IGJlIHVzZXJzIG9mIHRoZW0gb3V0IHRoZXJlIGFscmVhZHkgZGVwZW5kaW5nIG9uIHRo
ZQ0KPiBjdXJyZW50IGJlaGF2aW9yLg0KPiANCg0KVGhlIGludGVudCBpcyB0byBhZGQgbmV3IHN5
c2ZzIGZpbGVzIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGV4aXN0aW5nIGZpbGVzLiBJcyB0aGF0IG9r
YXk/DQoNCk9yIGlzIHRoZSBhZGRpdGlvbiBvZiBuZXcgZmlsZXMgYWxzbyBub3QgYWNjZXB0YWJs
ZT8NCg0KPiBTZWNvbmQsIGF0IGxlYXN0IHNvbWUgQ1BQQyBjb250cm9sIHJlZ2lzdGVycyBhcmUg
dXNlZCBieSBjcHVmcmVxDQo+IGRyaXZlcnMgKGNwcGNfY3B1ZnJlcSBhbmQgaW50ZWxfcHN0YXRl
KSwgc28gbW9kaWZ5aW5nIHRoZW0gYmVoaW5kIHRoZQ0KPiBkcml2ZXJzJyBiYWNrcyBpcyBub3Qg
YSBnb29kIGlkZWEgaW4gZ2VuZXJhbC4gIEZvciB0aGlzIHJlYXNvbiwgYWRkaW5nDQo+IG5ldyBz
eXNmcyBhdHRyaWJ1dGVzIHRvIGFsbG93IHVzZXIgc3BhY2UgdG8gZG8gdGhhdCBpcyBxdWl0ZQ0K
PiBxdWVzdGlvbmFibGUuDQo+IA0KDQpZZXMsIGdvb2QgcG9pbnQuDQoNCldoYXQgaWYgYSBjaGVj
ayBpcyBhZGRlZCBzbyB0aGF0IHdyaXRlcyBvbmx5IHN1Y2NlZWQgaWYgdGhlIENQVUZSRVEgZ292
ZXJub3IgaXMgc2V0IHRvIHVzZXJzcGFjZT8NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
