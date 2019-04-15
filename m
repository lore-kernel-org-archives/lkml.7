Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37FFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629E020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IeEtsaw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfDOWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:35:53 -0400
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:11542
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727186AbfDOWfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvfT7H7pGMbQW/txS8MHmhqJWaD5ERTZkTf/7PJbrn0=;
 b=IeEtsaw/j3O+9+wvNFrXosF6C/FW9lYcq41dbFz54GOkrtnFW9mYfEvdaiW8zoJLdOnywWDN6nv9RdbNfJwaPKUB+y4+zXIfgyxXPsUDaWEDY/luFd6xNTUSXQaa/qOgdydIh2UHkBz+l0Ma9nHU7X7e7DLyu0e5rYEV9fCYvsQ=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2798.namprd12.prod.outlook.com (52.135.107.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 15 Apr 2019 22:35:49 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 22:35:48 +0000
From:   Janakarajan Natarajan <jnataraj@amd.com>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Topic: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Index: AQHU6yz1dnTlH1WoLEy8yDNVtzL7aaY94MgA
Date:   Mon, 15 Apr 2019 22:35:48 +0000
Message-ID: <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49)
 To SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca768ec1-d82e-4940-cfe3-08d6c1f2b506
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2798;
x-ms-traffictypediagnostic: SN6PR12MB2798:
x-microsoft-antispam-prvs: <SN6PR12MB2798C04B8259E820DBC164F0E72B0@SN6PR12MB2798.namprd12.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(31686004)(6512007)(36756003)(305945005)(53936002)(6246003)(478600001)(71200400001)(71190400001)(7736002)(110136005)(8676002)(81156014)(81166006)(72206003)(68736007)(316002)(54906003)(14454004)(99286004)(66066001)(97736004)(256004)(52116002)(8936002)(4326008)(14444005)(76176011)(25786009)(2906002)(105586002)(6116002)(106356001)(102836004)(6436002)(6486002)(3846002)(186003)(31696002)(11346002)(53546011)(6506007)(2616005)(229853002)(446003)(5660300002)(476003)(2501003)(2201001)(26005)(386003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2798;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jNYYfRVawuyJ5/s7Sq56C4aKZZnopGcnK2o8lSW0iCqaWs8GeWWbqaEyOpAZraV7CRenE2KrEnsAjfMb55YRtPzB6OmGTLl44QyfOawrqDhXDoCESzOIBEcRE/SzdejC+nWXwomRJ2N7P3f09qi2uAsS2sUmfI+OcEZtcqRuQH1JBIMP20FYH2Ed53Pc2aMpFV/Kllwjn1b+wRdGyHBhiO8Bd8BliJOwRAaAuk1G6p88C6btc8Kz+df80KziUz1Q/8izWRFuzPXvw3ifUXDasXLHV1DUy5JdG0HgUhwxxy6D5WY2+mzAgJ7bTXOGrfb2DnCb2KXfvTG7umdySJQA9a1FQ3a03LZ4Mb1BwyDHvOXHVp+c/uPU4Upj19uQkA81JKWiD7XWA7/e359quzw3U/5eITe8hazA79M99QjrlAc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4C29D8A2FA3B345ADAA26B77C37F46D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca768ec1-d82e-4940-cfe3-08d6c1f2b506
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 22:35:48.7896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC80LzE5IDQ6MjUgUE0sIE5hdGFyYWphbiwgSmFuYWthcmFqYW4gd3JvdGU6DQo+IENQUEMg
KENvbGxhYm9yYXRpdmUgUHJvY2Vzc29yIFBlcmZvcm1hbmNlIENvbnRyb2wpIG9mZmVycyBvcHRp
b25hbA0KPiByZWdpc3RlcnMgd2hpY2ggY2FuIGJlIHVzZWQgdG8gdHVuZSB0aGUgc3lzdGVtIGJh
c2VkIG9uIGVuZXJneSBhbmQvb3INCj4gcGVyZm9ybWFuY2UgcmVxdWlyZW1lbnRzLg0KPg0KPiBO
ZXdlciBBTUQgcHJvY2Vzc29ycyBhZGQgc3VwcG9ydCBmb3IgYSBzdWJzZXQgb2YgdGhlc2Ugb3B0
aW9uYWwgQ1BQQw0KPiByZWdpc3RlcnMsIGJhc2VkIG9uIEFDUEkgdjYuMS4NCj4NCj4gVGhlIGZv
bGxvd2luZyBhcmUgdGhlIHN1cHBvcnRlZCBDUFBDIHJlZ2lzdGVycyBmb3Igd2hpY2ggc3lzZnMg
ZW50cmllcw0KPiBhcmUgY3JlYXRlZDoNCj4gKiBlbmFibGUgICAgICAgICAgICAgICAgKE5FVykN
Cj4gKiBtYXhfcGVyZiAgICAgICAgICAgICAgKE5FVykNCj4gKiBtaW5fcGVyZiAgICAgICAgICAg
ICAgKE5FVykNCj4gKiBlbmVyZ3lfcGVyZg0KPiAqIGxvd2VzdF9wZXJmDQo+ICogbm9taW5hbF9w
ZXJmDQo+ICogZGVzaXJlZF9wZXJmICAgICAgICAgIChORVcpDQo+ICogZmVlZGJhY2tfY3Rycw0K
PiAqIGF1dG9fc2VsX2VuYWJsZSAgICAgICAoTkVXKQ0KPiAqIGxvd2VzdF9ub25saW5lYXJfcGVy
Zg0KPg0KPiBUaGUgQ1BQQyBkcml2ZXIgaXMgdXBkYXRlZCB0byBlbmFibGUgdGhlIE9TUE0gYW5k
IHRoZSB1c2Vyc3BhY2UgdG8NCj4gYWNjZXNzDQo+IHRoZSBuZXdseSBzdXBwb3J0ZWQgcmVnaXN0
ZXJzLg0KPg0KPiBUaGUgcHVycG9zZSBvZiBleHBvc2luZyB0aGUgcmVnaXN0ZXJzIHZpYSB0aGUg
c3lzZnMgZW50cmllcyBpcyB0byBhbGxvdw0KPiB0aGUgdXNlcnNwYWNlIHRvOg0KPiAqIFR3ZWFr
IHRoZSB2YWx1ZXMgdG8gZml0IGl0cyB3b3JrbG9hZC4NCj4gKiBBcHBseSBhIHByb2ZpbGUgZnJv
bSBBTUQncyBvcHRpbWl6YXRpb24gZ3VpZGVzLg0KPg0KPiBQcm9maWxlcyB3aWxsIGJlIGRvY3Vt
ZW50ZWQgaW4gdGhlIHBlcmZvcm1hbmNlL29wdGltaXphdGlvbiBndWlkZXMuDQo+DQo+IE5vdGU6
DQo+ICogQU1EIHN5c3RlbXMgd2lsbCBub3QgaGF2ZSBhIHBvbGljeSBhcHBsaWVkIGluIHRoZSBr
ZXJuZWwgYXQgdGhpcyB0aW1lLg0KPiAqIEJ5IGRlZmF1bHQsIGFjcGlfY3B1ZnJlcSB3aWxsIHN0
aWxsIGJlIHVzZWQuDQo+DQo+IFRPRE86DQo+ICogQ3JlYXRlIGEgbGludXggdXNlcnNwYWNlIHRv
b2wgdGhhdCB3aWxsIGhlbHAgdXNlcnMgZ2VuZXJhdGUgYSBDUFBDDQo+ICogcHJvZmlsZQ0KPiAg
ICBmb3IgdGhlaXIgdGFyZ2V0IHdvcmtsb2FkLg0KPiAqIENyZWF0ZSBvciB1cGRhdGUgYSBkcml2
ZXIgdG8gYXBwbHkgYSBnZW5lcmFsIENQUEMgcG9saWN5IGluIHRoZQ0KPiAqIGtlcm5lbC4NCj4N
Cj4gdjEtPnYyOg0KPiAqIEFkZCBtYWNybyB0byBlbnN1cmUgQlVGRkVSIG9ubHkgcmVnaXN0ZXJz
IGhhdmUgQlVGRkVSIHR5cGUuDQo+ICogQWRkIHN1cHBvcnQgbWFjcm8gdG8gbWFrZSB0aGUgcmln
aHQgY2hlY2sgYmFzZWQgb24gcmVnaXN0ZXIgdHlwZS4NCj4gKiBSZW1vdmUgc3VwcG9ydCBjaGVj
a3MgZm9yIHJlZ2lzdGVycyB3aGljaCBhcmUgbWFuZGF0b3J5Lg0KDQoNCkFyZSB0aGVyZSBhbnkg
Y29uY2VybnMgcmVnYXJkaW5nIHRoaXMgcGF0Y2hzZXQ/DQoNCg0KVGhhbmtzLg0KDQoNCj4NCj4g
SmFuYWthcmFqYW4gTmF0YXJhamFuICgyKToNCj4gICAgYWNwaS9jcHBjOiBBZGQgbWFjcm8gZm9y
IENQUEMgcmVnaXN0ZXIgQlVGRkVSIG9ubHkgY2hlY2sNCj4gICAgYWNwaS9jcHBjOiBFbnN1cmUg
b25seSBzdXBwb3J0ZWQgQ1BQQyBzeXNmcyBlbnRyaWVzIGFyZSBjcmVhdGVkDQo+DQo+IFlhemVu
IEdoYW5uYW0gKDUpOg0KPiAgICBhY3BpL2NwcGM6IE1vZGlmeSBzaG93X2NwcGNfZGF0YSBtYWNy
bw0KPiAgICBhY3BpL2NwcGM6IFJld29yayBjcHBjX3NldF9wZXJmKCkgdG8gdXNlIGNwcGNfcmVn
cyBpbmRleA0KPiAgICBhY3BpL2NwcGM6IEFkZCBtYWNyb3MgdG8gZGVmaW5lIGEgUi9XIHN5c2Zz
IGVudHJ5IGZvciBDUFBDIHJlZ2lzdGVycw0KPiAgICBhY3BpL2NwcGM6IEFkZCBzdXBwb3J0IGZv
ciBvcHRpb25hbCBDUFBDIHJlZ2lzdGVycw0KPiAgICBhY3BpL2NwcGM6IEFkZCBzdXBwb3J0IGZv
ciBDUFBDIEVuYWJsZSByZWdpc3Rlcg0KPg0KPiAgIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyAg
ICAgICB8IDQwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gICBkcml2ZXJz
L2NwdWZyZXEvY3BwY19jcHVmcmVxLmMgfCAgIDYgKy0NCj4gICBpbmNsdWRlL2FjcGkvY3BwY19h
Y3BpLmggICAgICAgfCAgIDYgKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDM3MiBpbnNlcnRpb25z
KCspLCA0MiBkZWxldGlvbnMoLSkNCj4NCg==
