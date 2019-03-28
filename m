Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F700C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E7217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mTtqX4kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfC1OxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:53:02 -0400
Received: from mail-eopbgr810089.outbound.protection.outlook.com ([40.107.81.89]:59589
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfC1OxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXs+cavSCFZMolSUa+6Dae/99rGXCsod3fm9oBU3nC4=;
 b=mTtqX4khY6+1kgxM2CRxvutM+4VvraICTDon3cG0G2+yjR54Ds79DlPYy9HnxUiyiEkF0zSMzENTPW8afuEkHmu5+Dhd01SIRgndmtLOEVf1XmqLxwfO8zkZ3HM3SQ5pTMA14zmp9EDXqOQ92j3494ghDd//0kRP2uVBDRQ1N8U=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1419.namprd12.prod.outlook.com (10.168.238.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 14:52:19 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1%4]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 14:52:19 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <jroedel@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Thread-Topic: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Thread-Index: AQHU5VNRZt3XbAojqUi3B+DRJlpqRKYhIQOA
Date:   Thu, 28 Mar 2019 14:52:19 +0000
Message-ID: <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
References: <20190328104459.18589-1-joro@8bytes.org>
In-Reply-To: <20190328104459.18589-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7234e16-0f26-4c34-ad51-08d6b38cfa21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1419;
x-ms-traffictypediagnostic: DM5PR12MB1419:
x-microsoft-antispam-prvs: <DM5PR12MB1419A05EDF0B95FE2C67AD6DFD590@DM5PR12MB1419.namprd12.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(66066001)(26005)(3846002)(2906002)(6116002)(2616005)(6436002)(186003)(102836004)(386003)(6506007)(53546011)(5660300002)(6486002)(229853002)(31696002)(54906003)(11346002)(72206003)(446003)(6512007)(476003)(110136005)(486006)(316002)(478600001)(97736004)(14454004)(8936002)(7736002)(52116002)(68736007)(8676002)(81166006)(305945005)(2501003)(36756003)(106356001)(53936002)(6246003)(31686004)(71190400001)(25786009)(256004)(81156014)(99286004)(4326008)(71200400001)(76176011)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1419;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lkw34V3mvg3kFEMqggC6kRqae1qpcwz0jx3J8Lv2WivF2kha8aCaSXuVKz+jX3biDVybwsZN9A0DXERuJVNJPBmT6G2ZJocGkIlyywQIwPv3HUD15Z8mKdiFtwuW19qjyxhh1mof2FXd4YNbQN3x4LX9R96eeVp34ZKJP4dxyGwxclS9Ld7u//61I+ZbFMddwx0vj8xEYP6lf+eZ19lC+FfFLJo4Tlfclc2UkA1vylMKi9JSDAUx0JHREFWL79VCFj1HkFZesANMgYIMacSJ2fNGwFrjxeexY6k0qU/UcKYK25xwkSl9jemJ6YESEzVGey1Pxm3oR7Py5RjVNZcs15NbVYx3XgenaZSV4FNG5hh1g4xpGEimE8SVpMRMQNFpnpDz3DM+gv1UYeAavxzKxhi7nTfofNppx6KkUnsHChk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3B4F7566688114BA14F07BD9F5697E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7234e16-0f26-4c34-ad51-08d6b38cfa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 14:52:19.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOC8xOSA1OjQ0IEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+IEZyb206IEpvZXJnIFJv
ZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gSWYgYSBkZXZpY2UgaGFzIGFuIGV4Y2x1c2lv
biByYW5nZSBzcGVjaWZpZWQgaW4gdGhlIElWUlMNCj4gdGFibGUsIHRoaXMgcmVnaW9uIG5lZWRz
IHRvIGJlIHJlc2VydmVkIGluIHRoZSBpb3ZhLWRvbWFpbg0KPiBvZiB0aGF0IGRldmljZS4gVGhp
cyBoYXNuJ3QgaGFwcGVuZWQgdW50aWwgbm93IGFuZCBjYW4gY2F1c2UNCj4gZGF0YSBjb3JydXB0
aW9uIG9uIGRhdGEgdHJhbnNmZXJlZCB3aXRoIHRoZXNlIGRldmljZXMuDQo+IA0KPiBUcmVhdCBl
eGNsdXNpb24gcmFuZ2VzIGFzIHJlc2VydmVkIHJlZ2lvbnMgaW4gdGhlIGlvbW11LWNvcmUNCj4g
dG8gZml4IHRoZSBwcm9ibGVtLg0KPiANCj4gRml4ZXM6IGJlMmEwMjJjMGRkMCAoJ3g4NiwgQU1E
IElPTU1VOiBhZGQgZnVuY3Rpb25zIHRvIHBhcnNlIElPTU1VIG1lbW9yeSBtYXBwaW5nIHJlcXVp
cmVtZW50cyBmb3IgZGV2aWNlcycpDQo+IFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJv
ZWRlbEBzdXNlLmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jICAgICAg
fCA5ICsrKysrKy0tLQ0KPiAgIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYyB8IDcgKysr
Ky0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9hbWRfaW9tbXUuYw0KPiBpbmRleCAyMWNiMDg4ZDY2ODcuLjJhOGQyODA2ZDViOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJz
L2lvbW11L2FtZF9pb21tdS5jDQo+IEBAIC0zMTY5LDIxICszMTY5LDI0IEBAIHN0YXRpYyB2b2lk
IGFtZF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gICAJCXJl
dHVybjsNCj4gICANCj4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJmFtZF9pb21tdV91
bml0eV9tYXAsIGxpc3QpIHsNCj4gKwkJaW50IHR5cGUsIHByb3QgPSAwOw0KPiAgIAkJc2l6ZV90
IGxlbmd0aDsNCj4gLQkJaW50IHByb3QgPSAwOw0KPiAgIA0KPiAgIAkJaWYgKGRldmlkIDwgZW50
cnktPmRldmlkX3N0YXJ0IHx8IGRldmlkID4gZW50cnktPmRldmlkX2VuZCkNCj4gICAJCQljb250
aW51ZTsNCj4gICANCj4gKwkJdHlwZSAgID0gSU9NTVVfUkVTVl9ESVJFQ1Q7DQo+ICAgCQlsZW5n
dGggPSBlbnRyeS0+YWRkcmVzc19lbmQgLSBlbnRyeS0+YWRkcmVzc19zdGFydDsNCj4gICAJCWlm
IChlbnRyeS0+cHJvdCAmIElPTU1VX1BST1RfSVIpDQo+ICAgCQkJcHJvdCB8PSBJT01NVV9SRUFE
Ow0KPiAgIAkJaWYgKGVudHJ5LT5wcm90ICYgSU9NTVVfUFJPVF9JVykNCj4gICAJCQlwcm90IHw9
IElPTU1VX1dSSVRFOw0KPiArCQlpZiAoZW50cnktPnByb3QgJiAoMSA8PCAyKSkNCg0KQ291bGQg
d2UgYWRkDQojZGVmaW5lIElPTU1VX1dSSVRFX0VYQ0wgKDEgPDwgMikNCnRvIGFtZF9pb21tdV90
eXBlcy5oPw0KDQpUaGUgYml0IGlzIGRvY3VtZW50ZWQgaW4gdGhlIEFNRCBJT01NVSBzcGVjLCBz
byB0aGlzIHNlZW1zIHNhZmUuLi4NCg0KPiArCQkJLyogRXhjbHVzaW9uIHJhbmdlICovDQo+ICsJ
CQl0eXBlID0gSU9NTVVfUkVTVl9SRVNFUlZFRDsNCj4gICANCj4gICAJCXJlZ2lvbiA9IGlvbW11
X2FsbG9jX3Jlc3ZfcmVnaW9uKGVudHJ5LT5hZGRyZXNzX3N0YXJ0LA0KPiAtCQkJCQkJIGxlbmd0
aCwgcHJvdCwNCj4gLQkJCQkJCSBJT01NVV9SRVNWX0RJUkVDVCk7DQo+ICsJCQkJCQkgbGVuZ3Ro
LCBwcm90LCB0eXBlKTsNCj4gICAJCWlmICghcmVnaW9uKSB7DQo+ICAgCQkJZGV2X2VycihkZXYs
ICJPdXQgb2YgbWVtb3J5IGFsbG9jYXRpbmcgZG0tcmVnaW9uc1xuIik7DQo+ICAgCQkJcmV0dXJu
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jIGIvZHJpdmVy
cy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+IGluZGV4IGY3NzM3OTJkNzdmZC4uMWIxMzc4NjE5
ZmM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMNCj4gKysr
IGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+IEBAIC0yMDEzLDYgKzIwMTMsOSBA
QCBzdGF0aWMgaW50IF9faW5pdCBpbml0X3VuaXR5X21hcF9yYW5nZShzdHJ1Y3QgaXZtZF9oZWFk
ZXIgKm0pDQo+ICAgCWlmIChlID09IE5VTEwpDQo+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gICAN
Cj4gKwlpZiAobS0+ZmxhZ3MgJiBJVk1EX0ZMQUdfRVhDTF9SQU5HRSkNCj4gKwkJaW5pdF9leGNs
dXNpb25fcmFuZ2UobSk7DQo+ICsNCj4gICAJc3dpdGNoIChtLT50eXBlKSB7DQo+ICAgCWRlZmF1
bHQ6DQo+ICAgCQlrZnJlZShlKTsNCj4gQEAgLTIwNTksOSArMjA2Miw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IGluaXRfbWVtb3J5X2RlZmluaXRpb25zKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAq
dGFibGUpDQo+ICAgDQo+ICAgCXdoaWxlIChwIDwgZW5kKSB7DQo+ICAgCQltID0gKHN0cnVjdCBp
dm1kX2hlYWRlciAqKXA7DQo+IC0JCWlmIChtLT5mbGFncyAmIElWTURfRkxBR19FWENMX1JBTkdF
KQ0KPiAtCQkJaW5pdF9leGNsdXNpb25fcmFuZ2UobSk7DQo+IC0JCWVsc2UgaWYgKG0tPmZsYWdz
ICYgSVZNRF9GTEFHX1VOSVRZX01BUCkNCj4gKwkJaWYgKG0tPmZsYWdzICYgKElWTURfRkxBR19V
TklUWV9NQVAgfCBJVk1EX0ZMQUdfRVhDTF9SQU5HRSkpDQo+ICAgCQkJaW5pdF91bml0eV9tYXBf
cmFuZ2UobSk7DQo+ICAgDQo+ICAgCQlwICs9IG0tPmxlbmd0aDsNCj4gDQoNClRoZSBwcm9ibGVt
IEkgc2VlIGhlcmUgaXMgdGhhdCBpZiwgZm9yIHNvbWUgdW50b2xkIHJlYXNvbiwgdGhlcmUgaXMg
bW9yZSANCnRoYW4gb25lIGV4Y2x1c2lvbiByYW5nZSBlbWl0dGVkLCB3aGVyZSBvbmx5IHRoZSBs
YXN0IG9uZSB3aW5zIGluIHRoZSANCmhhcmR3YXJlLCB3ZSdkIHN0aWxsIGVuZCB1cCB3aXRoIG1v
cmUgdGhhbiBvbmUgcmFuZ2UgcmVzZXJ2ZWQgaW4gdGhlIA0KSU9WQSB0cmVlLiBDbGVhcmx5LCB0
aGlzIGlzIGV4dHJlbWVseSB1bmxpa2VseSwgYnV0IHdvdWxkbid0IHdlIHdhbnQgdG8gDQpwcm90
ZWN0IGFnYWluc3QgdGhhdCBzb3J0IG9mIG1pc3VzZS9taXN0YWtlPw0KDQpJIGNvdWxkIGJlIG1p
c3Npbmcgc29tZXRoaW5nLg0K
