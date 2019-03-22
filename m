Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JjnkDAiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCVVfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:35:48 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:35713
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfCVVfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85y0ZVXA7vnp5LXjToFxGZ+7kALRkrESS3re6WElPr8=;
 b=JjnkDAiSjEEqqO20E/BJZPJutpQT8aww2o8BaSQnhezIF3MoY3AYReWPK55m160XcNJ2D32VCcbeZgwV9jVcOD6pe+2sNWK8Rd4D6Ax24/DWuhY48gZGCkMLpyeO0qGCi8eZbbwmKRCauYTsJvOA8uTDO5Bmpw298Ur24+/HKQM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 21:35:41 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 21:35:41 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: RE: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Topic: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4O3hzDnJGF9VdEO+XYSvilmDRqYYHCmAgAAFAgCAAAssoA==
Date:   Fri, 22 Mar 2019 21:35:41 +0000
Message-ID: <SN6PR12MB26390B3260E0AE715DC5B279F8430@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
 <20190322202848.20749-2-Yazen.Ghannam@amd.com>
 <bbcce693-496e-0ab9-f01e-66bc67347715@amd.com>
 <20190322205500.GP12472@zn.tnic>
In-Reply-To: <20190322205500.GP12472@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a43ba5-07d6-4339-d5e2-08d6af0e5585
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2845;
x-ms-traffictypediagnostic: SN6PR12MB2845:
x-microsoft-antispam-prvs: <SN6PR12MB2845AB23F1D2E2967A6AA6F9F8430@SN6PR12MB2845.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(13464003)(199004)(189003)(25786009)(316002)(8936002)(2906002)(305945005)(7736002)(99286004)(106356001)(186003)(54906003)(229853002)(74316002)(102836004)(6506007)(76176011)(256004)(86362001)(14454004)(71190400001)(71200400001)(26005)(478600001)(7696005)(8676002)(97736004)(6116002)(81156014)(81166006)(53546011)(68736007)(476003)(3846002)(93886005)(486006)(66066001)(446003)(52536014)(105586002)(72206003)(6436002)(6246003)(55016002)(5660300002)(53936002)(33656002)(6916009)(4326008)(9686003)(11346002)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2845;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UpFAmbcCNBypPXhHGRpQiamBDtLQf3dQAOneW4sSiGiQyG2MMQ6QkekSyJdvUaBmrrr+KVxnR7LOnMBQcnhh1XqOPzqNBP+ZQ578uFGTIrNOc/dwXu8lKc9j5NQB9+YJI32fAtAuM4Qx1/7+sOhJS5JdUTcIzN9dw3sE0HPMqUK0trPUEKx8liELvzpFw/QW9Q9T0pndkrrQn3fEewGeRITHydCAu0UNjRSp8KqmW6+QO7RsK33XwfRrGh3pF+/gWOwwTugnOnLIFtKN6c6A88uvf4HgCppMWjs9101cie9Mf+Ikf/Jo5MZvQJjM6ZfqWGBG2xogRXc0h5ltMcpl2uvSw+0NLql5+cGLdlVehjJA+fr1oDfOkslA1RdBX9bOJUrCAO2mTX8P41yTYeA00kqlCOMytO9lR8kLIGzhsP8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a43ba5-07d6-4339-d5e2-08d6af0e5585
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 21:35:41.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyMiwgMjAxOSAzOjU1
IFBNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IHRvbnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyByYWZhbEBtaWxlY2tpLnBsOw0K
PiBjbGVtZWpAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSB4ODYvTUNF
L0FNRDogRG9uJ3QgcmVwb3J0IEwxIEJUQiBNQ0EgZXJyb3JzIG9uIHNvbWUgRmFtaWx5IDE3aCBt
b2RlbHMNCj4gDQo+IE9uIEZyaSwgTWFyIDIyLCAyMDE5IGF0IDA4OjM3OjA4UE0gKzAwMDAsIEdo
YW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IFNvcnJ5LCBJIGZvcmdvdCB0byBtZW50aW9uIHRoaXMu
IEkgd2VudCB3aXRoICJmaWx0ZXJfbWNlX2FtZCIgYmVjYXVzZQ0KPiA+IGFtZF9maWx0ZXJfbWNl
KCkgaXMgYWxyZWFkeSBkZWZpbmVkIGluIGVkYWMvbWNlX2FtZC5jIGFuZCB0aGVyZSB3YXMNCj4g
PiBhIGNvbmZsaWN0IHdoZW4gYnVpbGRpbmcuIElzIHRoZXJlIGFub3RoZXIgd2F5IHRvIGF2b2lk
IHRoZXNlIG5hbWluZw0KPiA+IGNvbmZsaWN0cz8NCj4gDQo+IFl1Y2ssIHdlJ3JlIGNsZWFybHkg
ZmlsdGVyaW5nIHRvbyBtdWNoLiA6KQ0KPiANCj4gU28gbGV0J3MgcmVuYW1lIHRoYXQgYW1kX2Zp
bHRlcl9tY2UoKSB0byBzb21ldGhpbmcgZWxzZSBzaW5jZSBpdCBpcw0KPiBzdGF0aWMgYW5kIG9u
bHkgdXNlZCBpbiB0aGF0IGZpbGUuIE1heWJlIHNvbWV0aGluZyBsaWtlDQo+IA0KPiAgICAgICAg
IGlmIChpZ25vcmVfbWNlKG0pKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5PVElGWV9TVE9Q
Ow0KPiANCj4gc28gdGhhdCB3ZSBjYW4ga2VlcCB0aGUgImZpbHRlciIgbm90aW9uIGFsbCByZXNl
cnZlZCB0byB0aGUgY29yZSBNQ0ENCj4gY29kZSBhbmQgdGhlcmUncyBubyBjb25mdXNpb24uDQo+
IA0KPiBBbmQgdGhlbiBhbWRfZmlsdGVyX21jZSgpIGlzIGZyZWUgdG8gYmUgdXNlZCBpbiB0aGUg
Y29yZSBjb2RlLg0KPiANCg0KT2theSwgd2lsbCBkby4NCg0KU2hvdWxkIHRoaXMgYmUgYSBwcmUt
cGF0Y2gsIG9yIGp1c3QgaW5jbHVkZSBpdCBoZXJlPw0KDQpUaGFua3MsDQpZYXplbg0K
