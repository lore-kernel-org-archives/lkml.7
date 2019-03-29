Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F22218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mt8A1GWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfC2QAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:00:49 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:50912
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbfC2QAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiRaGKQsmIYiAkwKcNKwBReplw7cmxrFPwMgb8uA3zk=;
 b=mt8A1GWB/sY0qDJzbhrp+bzKz0zox4irSwF29+hwOwUjpuHc6zJfhgpUgFbmKLyMedTnnDEMW151JpFJHAZB2C+ZY1ieM6vlWpkvEk7bItlfSAcWJIa9j3AnvilUs4lFu/2h5eMKO7HZ6qA1uTP/A7iN79JcuyQ1MjCoxSPTkco=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1706.namprd12.prod.outlook.com (10.175.89.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 16:00:43 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1%4]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 16:00:43 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] iommu/amd: Reserve exclusion range in iova-domain
Thread-Topic: [PATCH v2] iommu/amd: Reserve exclusion range in iova-domain
Thread-Index: AQHU5kGVsYf/PKxuaUqq7M0YRzMbIKYixJqA
Date:   Fri, 29 Mar 2019 16:00:43 +0000
Message-ID: <f45932fe-a431-dfc3-95cd-6342214ec43e@amd.com>
References: <20190329151037.19112-1-joro@8bytes.org>
In-Reply-To: <20190329151037.19112-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:805:8e::35) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 286ca184-3a33-4606-a063-08d6b45fb292
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1706;
x-ms-traffictypediagnostic: DM5PR12MB1706:
x-microsoft-antispam-prvs: <DM5PR12MB17067696C65063DF919ECF2CFD5A0@DM5PR12MB1706.namprd12.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(99286004)(36756003)(6436002)(26005)(11346002)(14454004)(7736002)(229853002)(5660300002)(31686004)(8936002)(186003)(6486002)(31696002)(81156014)(81166006)(305945005)(71190400001)(106356001)(105586002)(8676002)(478600001)(2501003)(71200400001)(52116002)(6512007)(386003)(3846002)(25786009)(6506007)(476003)(72206003)(68736007)(6116002)(76176011)(256004)(446003)(6246003)(4326008)(53936002)(486006)(316002)(102836004)(97736004)(53546011)(2906002)(110136005)(54906003)(66066001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1706;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RVBfyUng1rfzOKXhJ91wDchwL0oBMHOIlQ6lwCZ0Fkywwqowl2NtVzGIGzQLi2z6AgcshkpNCkRUJWQM938TMnNn2Zt6l1jBwlXvZcy79ZBCUEwEU4FEgOBwZp+2EptiBJoHt661pfRFhSDxOZB/2lrtiEKWJbmvYlvs+2StUN2EChM79B2H3R1MZhhA9FGSNkjZzZEjS7KkZqEI2lsWLWIzJNtplWVQWUH343wjaAJ7enNTWJS+6gWYCq7VqF1JR5YZN9nlYrSpd64o3avut48rYJQmeZnYu3kwel5pUNP6UEUd9rOkR7+1mfRPs11s2OC34TWOxaa8A8pzWOjbioCq720OfsAkhq6na16tJ00gXdVkFAbYehNUPDLVWWAMl0UWEbcMEkKeK+NZiACyDmcvZMrhOlqV/5FYJr2GPKc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2067C1A2C8870243B1AD1EE849546986@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286ca184-3a33-4606-a063-08d6b45fb292
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:00:43.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8xOSAxMDoxMCBBTSwgSm9lcmcgUm9lZGVsIHdyb3RlOg0KPiBGcm9tOiBKb2VyZyBS
b2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gDQo+IElmIGEgZGV2aWNlIGhhcyBhbiBleGNsdXNp
b24gcmFuZ2Ugc3BlY2lmaWVkIGluIHRoZSBJVlJTDQo+IHRhYmxlLCB0aGlzIHJlZ2lvbiBuZWVk
cyB0byBiZSByZXNlcnZlZCBpbiB0aGUgaW92YS1kb21haW4NCj4gb2YgdGhhdCBkZXZpY2UuIFRo
aXMgaGFzbid0IGhhcHBlbmVkIHVudGlsIG5vdyBhbmQgY2FuIGNhdXNlDQo+IGRhdGEgY29ycnVw
dGlvbiBvbiBkYXRhIHRyYW5zZmVyZWQgd2l0aCB0aGVzZSBkZXZpY2VzLg0KPiANCj4gVHJlYXQg
ZXhjbHVzaW9uIHJhbmdlcyBhcyByZXNlcnZlZCByZWdpb25zIGluIHRoZSBpb21tdS1jb3JlDQo+
IHRvIGZpeCB0aGUgcHJvYmxlbS4NCg0KUmV2aWV3ZWQtYnk6IEdhcnkgUiBIb29rIDxnYXJ5Lmhv
b2tAYW1kLmNvbT4NCg0KPiANCj4gRml4ZXM6IGJlMmEwMjJjMGRkMCAoJ3g4NiwgQU1EIElPTU1V
OiBhZGQgZnVuY3Rpb25zIHRvIHBhcnNlIElPTU1VIG1lbW9yeSBtYXBwaW5nIHJlcXVpcmVtZW50
cyBmb3IgZGV2aWNlcycpDQo+IFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBz
dXNlLmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jICAgICAgIHwgOSAr
KysrKystLS0NCj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMgIHwgNyArKysrLS0t
DQo+ICAgZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfdHlwZXMuaCB8IDIgKysNCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11
LmMNCj4gaW5kZXggMjFjYjA4OGQ2Njg3Li5mN2NkZDJhYjdmMTEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvYW1kX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUu
Yw0KPiBAQCAtMzE2OSwyMSArMzE2OSwyNCBAQCBzdGF0aWMgdm9pZCBhbWRfaW9tbXVfZ2V0X3Jl
c3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+ICAg
CWxpc3RfZm9yX2VhY2hfZW50cnkoZW50cnksICZhbWRfaW9tbXVfdW5pdHlfbWFwLCBsaXN0KSB7
DQo+ICsJCWludCB0eXBlLCBwcm90ID0gMDsNCj4gICAJCXNpemVfdCBsZW5ndGg7DQo+IC0JCWlu
dCBwcm90ID0gMDsNCj4gICANCj4gICAJCWlmIChkZXZpZCA8IGVudHJ5LT5kZXZpZF9zdGFydCB8
fCBkZXZpZCA+IGVudHJ5LT5kZXZpZF9lbmQpDQo+ICAgCQkJY29udGludWU7DQo+ICAgDQo+ICsJ
CXR5cGUgICA9IElPTU1VX1JFU1ZfRElSRUNUOw0KPiAgIAkJbGVuZ3RoID0gZW50cnktPmFkZHJl
c3NfZW5kIC0gZW50cnktPmFkZHJlc3Nfc3RhcnQ7DQo+ICAgCQlpZiAoZW50cnktPnByb3QgJiBJ
T01NVV9QUk9UX0lSKQ0KPiAgIAkJCXByb3QgfD0gSU9NTVVfUkVBRDsNCj4gICAJCWlmIChlbnRy
eS0+cHJvdCAmIElPTU1VX1BST1RfSVcpDQo+ICAgCQkJcHJvdCB8PSBJT01NVV9XUklURTsNCj4g
KwkJaWYgKGVudHJ5LT5wcm90ICYgSU9NTVVfVU5JVFlfTUFQX0ZMQUdfRVhDTF9SQU5HRSkNCj4g
KwkJCS8qIEV4Y2x1c2lvbiByYW5nZSAqLw0KPiArCQkJdHlwZSA9IElPTU1VX1JFU1ZfUkVTRVJW
RUQ7DQo+ICAgDQo+ICAgCQlyZWdpb24gPSBpb21tdV9hbGxvY19yZXN2X3JlZ2lvbihlbnRyeS0+
YWRkcmVzc19zdGFydCwNCj4gLQkJCQkJCSBsZW5ndGgsIHByb3QsDQo+IC0JCQkJCQkgSU9NTVVf
UkVTVl9ESVJFQ1QpOw0KPiArCQkJCQkJIGxlbmd0aCwgcHJvdCwgdHlwZSk7DQo+ICAgCQlpZiAo
IXJlZ2lvbikgew0KPiAgIAkJCWRldl9lcnIoZGV2LCAiT3V0IG9mIG1lbW9yeSBhbGxvY2F0aW5n
IGRtLXJlZ2lvbnNcbiIpOw0KPiAgIAkJCXJldHVybjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYW1kX2lvbW11X2luaXQuYyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYw0K
PiBpbmRleCBmNzczNzkyZDc3ZmQuLjFiMTM3ODYxOWZjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11
X2luaXQuYw0KPiBAQCAtMjAxMyw2ICsyMDEzLDkgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdF91
bml0eV9tYXBfcmFuZ2Uoc3RydWN0IGl2bWRfaGVhZGVyICptKQ0KPiAgIAlpZiAoZSA9PSBOVUxM
KQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+ICsJaWYgKG0tPmZsYWdzICYgSVZNRF9G
TEFHX0VYQ0xfUkFOR0UpDQo+ICsJCWluaXRfZXhjbHVzaW9uX3JhbmdlKG0pOw0KPiArDQo+ICAg
CXN3aXRjaCAobS0+dHlwZSkgew0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJa2ZyZWUoZSk7DQo+IEBA
IC0yMDU5LDkgKzIwNjIsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBpbml0X21lbW9yeV9kZWZpbml0
aW9ucyhzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKnRhYmxlKQ0KPiAgIA0KPiAgIAl3aGlsZSAo
cCA8IGVuZCkgew0KPiAgIAkJbSA9IChzdHJ1Y3QgaXZtZF9oZWFkZXIgKilwOw0KPiAtCQlpZiAo
bS0+ZmxhZ3MgJiBJVk1EX0ZMQUdfRVhDTF9SQU5HRSkNCj4gLQkJCWluaXRfZXhjbHVzaW9uX3Jh
bmdlKG0pOw0KPiAtCQllbHNlIGlmIChtLT5mbGFncyAmIElWTURfRkxBR19VTklUWV9NQVApDQo+
ICsJCWlmIChtLT5mbGFncyAmIChJVk1EX0ZMQUdfVU5JVFlfTUFQIHwgSVZNRF9GTEFHX0VYQ0xf
UkFOR0UpKQ0KPiAgIAkJCWluaXRfdW5pdHlfbWFwX3JhbmdlKG0pOw0KPiAgIA0KPiAgIAkJcCAr
PSBtLT5sZW5ndGg7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV90eXBl
cy5oIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfdHlwZXMuaA0KPiBpbmRleCBlYWUwNzQxZjcy
ZGMuLjg3OTY1ZTRkOTY0NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVf
dHlwZXMuaA0KPiArKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV90eXBlcy5oDQo+IEBAIC0z
NzQsNiArMzc0LDggQEANCj4gICAjZGVmaW5lIElPTU1VX1BST1RfSVIgMHgwMQ0KPiAgICNkZWZp
bmUgSU9NTVVfUFJPVF9JVyAweDAyDQo+ICAgDQo+ICsjZGVmaW5lIElPTU1VX1VOSVRZX01BUF9G
TEFHX0VYQ0xfUkFOR0UJKDEgPDwgMikNCj4gKw0KPiAgIC8qIElPTU1VIGNhcGFiaWxpdGllcyAq
Lw0KPiAgICNkZWZpbmUgSU9NTVVfQ0FQX0lPVExCICAgMjQNCj4gICAjZGVmaW5lIElPTU1VX0NB
UF9OUENBQ0hFIDI2DQo+IA0KDQo=
