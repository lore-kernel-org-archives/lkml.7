Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2137CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D330921473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WZ66dHHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDHOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:16:15 -0400
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:42970
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfDHOQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk6sl97N7h7z1cviVFn0KVyIDAOrirc5RdWoGI/zcZk=;
 b=WZ66dHHkYmj8DDBNS9sFk7ZODs4qwhIRIrgMW+VqPTS68hjJXvclh86J5YqfUcrLvR9SrRahJj9JmkOlfdej059rY24aGcAHqILfoxz6VBNSZ31Pj/SPWzr98efMzSzksoI1HOZ2ezzhwm2zmw9LdBw3cLt5XFs/HzZO0rlWiIA=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 14:16:10 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::d119:23e5:be33:4ac6]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::d119:23e5:be33:4ac6%2]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 14:16:10 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH] Revert "svm: Fix AVIC incomplete IPI emulation"
Thread-Topic: [PATCH] Revert "svm: Fix AVIC incomplete IPI emulation"
Thread-Index: AQHU3vSoF/6SczcFzECLQBUaeLu7KqYybU4A
Date:   Mon, 8 Apr 2019 14:16:10 +0000
Message-ID: <cb0d43f4-9699-4d55-2c0d-eaab0b00126b@amd.com>
References: <20190320081158.2442-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190320081158.2442-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
x-originating-ip: [165.204.78.1]
x-clientproxiedby: SN6PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:805:2a::18) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4887ffd-7da8-497d-4459-08d6bc2cbf99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2603;
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB2603A5774EC4A23BB9E77F88F32C0@DM6PR12MB2603.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(476003)(6512007)(102836004)(4326008)(966005)(6306002)(316002)(53936002)(66574012)(54906003)(58126008)(110136005)(25786009)(71190400001)(386003)(6246003)(2501003)(64126003)(97736004)(478600001)(105586002)(31686004)(106356001)(76176011)(186003)(99286004)(256004)(81166006)(68736007)(486006)(11346002)(7736002)(26005)(71200400001)(65806001)(52116002)(72206003)(14444005)(65956001)(446003)(6436002)(8936002)(6506007)(53546011)(31696002)(6116002)(65826007)(2906002)(86362001)(305945005)(81156014)(36756003)(3846002)(2616005)(6486002)(14454004)(5660300002)(8676002)(229853002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2603;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0v8Zmqurc6CPxrOqasUWOesBDKfXK1eIUX0yXCSbJW0NXNWcHqHDF4WiMeK7BZPFwTWXp9JORxLfzgZcA3aVBjGE+vlcMDLgUP5eDlgLOAlEbaz4c4VrHl8CZByYrb3AUGPppqfF7Fi7lUwf5bAV3Y6RUDdCgktFvnrgQnJFGMZS9aVVqvGbDB1byDebpGb1XwE+Dw8soCmCLJnJVIGCOvSgpG+6oxeULA7FZLzPNCnDK2PWEyx27cZNmHeE+y2OTKC4vw3Ar8Qeja/u0Fxwq3k5gCkmW8ec9y110bLqhTw6LkhrJ/f65LKV8Wasa2KAh3qb2bFYRQv/OznGWmInMzjeYD2glWXkWf5+8sEfY8LpErMrUUu4PpDXyyPi1NgIA4kHoB9SzxT9AqrJtPv9t7VVy43HBw/SESOC8ooe1Go=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D70963F32B5F74E9D3EA8A7CD851D45@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4887ffd-7da8-497d-4459-08d6bc2cbf99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:16:10.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQpPbiAzLzIwLzE5IDM6MTIgUE0sIFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgd3JvdGU6
DQo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYmIyMThmYmNmYWFhM2IxMTVkNGNkN2E0M2MwY2ExNjRm
M2E5NmU1Ny4NCj4gDQo+IEFzIE9yZW4gVHdhaWcgcG9pbnRlZCBvdXQgdGhlIG9sZCBkaXNjdXNz
aW9uOg0KPiANCj4gICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC84MjkyMjMx
Lw0KPiANCj4gdGhhdCB0aGUgY2hhbmdlIGNvdWQgcG90ZW50aWFsbHkgY2F1c2UgYW4gZXh0cmEg
SVBJIHRvIGJlIHNlbnQgdG8NCj4gdGhlIGRlc3RpbmF0aW9uIHZjcHUgYmVjYXVzZSB0aGUgQVZJ
QyBoYXJkd2FyZSBhbHJlYWR5IHNldCB0aGUgSVJSIGJpdA0KPiBiZWZvcmUgdGhlIGluY29tcGxl
dGUgSVBJICNWTUVYSVQgd2l0aCBpZD0xICh0YXJnZXQgdmNwdSBpcyBub3QgcnVubmluZykuDQo+
IFNpbmNlIHdyaXR0aW5nIHRvIElDUiBhbmQgSUNSMiB3aWxsIGFsc28gc2V0IHRoZSBJUlIuIElm
IHNvbWV0aGluZyB0cmlnZ2Vycw0KPiB0aGUgZGVzdGluYXRpb24gdmNwdSB0byBnZXQgc2NoZWR1
bGVkIGJlZm9yZSB0aGUgZW11bGF0aW9uIGZpbmlzaGVzLCB0aGVuDQo+IHRoaXMgY291bGQgcmVz
dWx0IGluIGFuIGFkZGl0aW9uYWwgSVBJLg0KPiANCj4gQWxzbywgdGhlIGlzc3VlIG1lbnRpb25l
ZCBpbiB0aGUgY29tbWl0IGJiMjE4ZmJjZmFhYSB3YXMgbWlzZGlhZ25vc2VkLg0KPiANCj4gQ2M6
IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KPiBDYzogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gUmVwb3J0ZWQtYnk6IE9yZW4gVHdhaWcgPG9yZW5A
c2NhbGVtcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8c3Vy
YXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L2t2bS9zdm0u
YyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
c3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4gaW5kZXggZjEzYTNhMjRkMzYwLi40N2M0OTkz
NDQ4YzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS9zdm0uYw0KPiArKysgYi9hcmNoL3g4
Ni9rdm0vc3ZtLmMNCj4gQEAgLTQ1MTIsMTQgKzQ1MTIsMjUgQEAgc3RhdGljIGludCBhdmljX2lu
Y29tcGxldGVfaXBpX2ludGVyY2VwdGlvbihzdHJ1Y3QgdmNwdV9zdm0gKnN2bSkNCj4gICAJCWt2
bV9sYXBpY19yZWdfd3JpdGUoYXBpYywgQVBJQ19JQ1IsIGljcmwpOw0KPiAgIAkJYnJlYWs7DQo+
ICAgCWNhc2UgQVZJQ19JUElfRkFJTFVSRV9UQVJHRVRfTk9UX1JVTk5JTkc6IHsNCj4gKwkJaW50
IGk7DQo+ICsJCXN0cnVjdCBrdm1fdmNwdSAqdmNwdTsNCj4gKwkJc3RydWN0IGt2bSAqa3ZtID0g
c3ZtLT52Y3B1Lmt2bTsNCj4gICAJCXN0cnVjdCBrdm1fbGFwaWMgKmFwaWMgPSBzdm0tPnZjcHUu
YXJjaC5hcGljOw0KPiAgIA0KPiAgIAkJLyoNCj4gLQkJICogVXBkYXRlIElDUiBoaWdoIGFuZCBs
b3csIHRoZW4gZW11bGF0ZSBzZW5kaW5nIElQSSwNCj4gLQkJICogd2hpY2ggaXMgaGFuZGxlZCB3
aGVuIHdyaXRpbmcgQVBJQ19JQ1IuDQo+ICsJCSAqIEF0IHRoaXMgcG9pbnQsIHdlIGV4cGVjdCB0
aGF0IHRoZSBBVklDIEhXIGhhcyBhbHJlYWR5DQo+ICsJCSAqIHNldCB0aGUgYXBwcm9wcmlhdGUg
SVJSIGJpdHMgb24gdGhlIHZhbGlkIHRhcmdldA0KPiArCQkgKiB2Y3B1cy4gU28sIHdlIGp1c3Qg
bmVlZCB0byBraWNrIHRoZSBhcHByb3ByaWF0ZSB2Y3B1Lg0KPiAgIAkJICovDQo+IC0JCWt2bV9s
YXBpY19yZWdfd3JpdGUoYXBpYywgQVBJQ19JQ1IyLCBpY3JoKTsNCj4gLQkJa3ZtX2xhcGljX3Jl
Z193cml0ZShhcGljLCBBUElDX0lDUiwgaWNybCk7DQo+ICsJCWt2bV9mb3JfZWFjaF92Y3B1KGks
IHZjcHUsIGt2bSkgew0KPiArCQkJYm9vbCBtID0ga3ZtX2FwaWNfbWF0Y2hfZGVzdCh2Y3B1LCBh
cGljLA0KPiArCQkJCQkJICAgICBpY3JsICYgS1ZNX0FQSUNfU0hPUlRfTUFTSywNCj4gKwkJCQkJ
CSAgICAgR0VUX0FQSUNfREVTVF9GSUVMRChpY3JoKSwNCj4gKwkJCQkJCSAgICAgaWNybCAmIEtW
TV9BUElDX0RFU1RfTUFTSyk7DQo+ICsNCj4gKwkJCWlmIChtICYmICFhdmljX3ZjcHVfaXNfcnVu
bmluZyh2Y3B1KSkNCj4gKwkJCQlrdm1fdmNwdV93YWtlX3VwKHZjcHUpOw0KPiArCQl9DQo+ICAg
CQlicmVhazsNCj4gICAJfQ0KPiAgIAljYXNlIEFWSUNfSVBJX0ZBSUxVUkVfSU5WQUxJRF9UQVJH
RVQ6DQo+IA0K
