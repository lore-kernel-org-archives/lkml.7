Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA368C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7721925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hiQN0sR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVUhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:37:20 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:15428
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfCVUhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uObOQwqoDIwHhmbZT3uG4gViE9bpkr+PLALvRBbEn9I=;
 b=hiQN0sR9eROryXXPGSVsEk5NjLl/gtulUy+UlK/UHsyV8T7qIdN5xdoMI3Dz4I4baIP57i6JfYZFGu3DPtOWWLpByKXgB2jrIg+FtUGpEGD/SnIAQJxBOY+QtIFPJLVmjDGrVtbidub8Des4Ks/L/c1nVuC72IWXqoYf+uF9CI8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.16; Fri, 22 Mar 2019 20:37:08 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 20:37:08 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Topic: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4O3hzDnJGF9VdEO+XYSvilmDRqYYHCmA
Date:   Fri, 22 Mar 2019 20:37:08 +0000
Message-ID: <bbcce693-496e-0ab9-f01e-66bc67347715@amd.com>
References: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
 <20190322202848.20749-2-Yazen.Ghannam@amd.com>
In-Reply-To: <20190322202848.20749-2-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e7f628a-53c9-4368-9071-08d6af0626ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2831;
x-ms-traffictypediagnostic: SN6PR12MB2831:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB28311592FB482FE18E451BDAF8430@SN6PR12MB2831.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(36756003)(478600001)(6916009)(97736004)(229853002)(86362001)(8936002)(5660300002)(71190400001)(31696002)(71200400001)(72206003)(966005)(31686004)(68736007)(8676002)(2906002)(81156014)(2501003)(25786009)(6486002)(66066001)(106356001)(105586002)(2351001)(3846002)(305945005)(6116002)(186003)(81166006)(7736002)(6436002)(99286004)(256004)(14444005)(53546011)(6246003)(6506007)(52116002)(446003)(386003)(26005)(6306002)(54906003)(14454004)(5640700003)(6512007)(11346002)(53936002)(476003)(316002)(76176011)(4326008)(102836004)(2616005)(486006)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RhWXn4Tcwaf6TjF9VgW1cYxPGAuKcpgT4nsWPCPaHoTF6WsFxHGMAusz5YaqK9kFqKCMByuOVEA7Y9G3C5lampZdGmSCplcPKXflxLne+211rowouu1bqA34Ofu4aZx1JvxPLlXxHdEloHFjGwcZukBWN90S+XmZrmk015SXzX6WS+ooUFK816eExCWdc/ClLQZRBJWyhd/ghDRJixdh8fnTMiRdUpi/qnMgZvK8bY6450knBQIj9p7PIN0oeGoBHs9GS0r9Aqe511Ps2eNwEW2XcrNEputO7xPRJcI5MRr/wKuGpgkYa1xOeCrGnvi+nmG+XBE7Zu8xzQQVxg1IS07m+h/SRXQTqazXI3xlGB4FrccpoRg77Eph2Y3uJ8A8tysrm8FjXA2fsdFkaWufOm2jjwgAFEWksqOdBsmUNns=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74A40E8402430B41B3D07781E8F75B47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7f628a-53c9-4368-9071-08d6af0626ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:37:08.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMi8yMDE5IDM6MjggUE0sIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiBGcm9tOiBZYXpl
biBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IA0KPiBBTUQgRmFtaWx5IDE3aCBN
b2RlbHMgMTBoLTJGaCBtYXkgcmVwb3J0IGEgaGlnaCBudW1iZXIgb2YgTDEgQlRCIE1DQQ0KPiBl
cnJvcnMgdW5kZXIgY2VydGFpbiBjb25kaXRpb25zLiBUaGUgZXJyb3JzIGFyZSBiZW5pZ24gYW5k
IGNhbiBzYWZlbHkgYmUNCj4gaWdub3JlZC4gSG93ZXZlciwgdGhlIGhpZ2ggZXJyb3IgcmF0ZSBt
YXkgY2F1c2UgdGhlIE1DQSB0aHJlc2hvbGQNCj4gY291bnRlciB0byBvdmVyZmxvdyBjYXVzaW5n
IGEgaGlnaCByYXRlIG9mIHRocmVzaG9sZGluZyBpbnRlcnJ1cHRzLiBJbg0KPiBhZGRpdGlvbiwg
dXNlcnMgbWF5IHNlZSB0aGUgZXJyb3JzIHJlcG9ydGVkIHRocm91Z2ggdGhlIEFNRCBNQ0UgZGVj
b2Rlcg0KPiBtb2R1bGUsIGV2ZW4gd2l0aCB0aGUgaW50ZXJydXB0IGRpc2FibGVkLCBkdWUgdG8g
TUNBIHBvbGxpbmcuDQo+IA0KPiBUaGlzIGVycm9yIGlzIHJlcG9ydGVkIHRocm91Z2ggdGhlIElu
c3RydWN0aW9uIEZldGNoIGJhbmsuDQo+IA0KPiBDbGVhciB0aGUgIkNvdW50ZXIgUHJlc2VudCIg
Yml0IGluIHRoZSBJbnN0cnVjdGlvbiBGZXRjaCBiYW5rJ3MNCj4gTUNBX01JU0MwIHJlZ2lzdGVy
LiBUaGlzIHdpbGwgcHJldmVudCBlbmFibGluZyBNQ0EgdGhyZXNob2xkaW5nIG9uIHRoaXMNCj4g
YmFuayB3aGljaCB3aWxsIHByZXZlbnQgdGhlIGhpZ2ggaW50ZXJydXB0IHJhdGUgZHVlIHRvIHRo
aXMgZXJyb3IuDQo+IA0KPiBEZWZpbmUgYW4gQU1ELXNwZWNpZmljIGZ1bmN0aW9uIHRvIGZpbHRl
ciB0aGVzZSBlcnJvcnMgZnJvbSB0aGUgTUNFDQo+IGV2ZW50IHBvb2wuDQo+IA0KPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNC4xNC54OiBjOTViMzIzZGNkMzU6IHg4Ni9NQ0UvQU1E
OiBUdXJuIG9mZiBNQzRfTUlTQyB0aHJlc2hvbGRpbmcgb24gYWxsIGZhbWlseSAweDE1IG1vZGVs
cw0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNC4xNC54OiAzMGFhM2QyNmVkYjA6
IHg4Ni9NQ0UvQU1EOiBDYXJ2ZSBvdXQgdGhlIE1DNF9NSVNDIHRocmVzaG9sZGluZyBxdWlyaw0K
PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNC4xNC54DQo+IFNpZ25lZC1vZmYtYnk6
IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gLS0tDQo+IExpbms6DQo+
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTAzMjEyMDI1MDUuNTU1My0yLVlhemVuLkdo
YW5uYW1AYW1kLmNvbQ0KPiANCj4gdjItPnYzOg0KPiAqIERlZmluZSBhIHNpbXBsZSBBTUQtc3Bl
Y2lmaWMgZmlsdGVyIGZ1bmN0aW9uIHJhdGhlciB0aGFuIGENCj4gICBtb2RlbC1zcGVjaWZpYyBv
bmUuDQo+IA0KPiB2MS0+djI6DQo+ICogRmlsdGVyIG91dCB0aGUgZXJyb3IgZWFybGllciBpbiBN
Q0UgY29kZSByYXRoZXIgdGhhbiBsYXRlciBpbiBFREFDLg0KPiANCj4gIGFyY2gveDg2L2luY2x1
ZGUvYXNtL21jZS5oICAgICB8ICAyICsrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQu
YyAgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAgMyArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tY2UuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21jZS5oDQo+IGluZGV4IGVj
NWJmMWNhZDIxNy4uNTBmNzZhNzk1NmNjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9tY2UuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaA0KPiBAQCAtMzQ0
LDYgKzM0NCw3IEBAIGV4dGVybiBzdHJ1Y3Qgc21jYV9iYW5rIHNtY2FfYmFua3NbTUFYX05SX0JB
TktTXTsNCj4gIA0KPiAgZXh0ZXJuIGNvbnN0IGNoYXIgKnNtY2FfZ2V0X2xvbmdfbmFtZShlbnVt
IHNtY2FfYmFua190eXBlcyB0KTsNCj4gIGV4dGVybiBib29sIGFtZF9tY2VfaXNfbWVtb3J5X2Vy
cm9yKHN0cnVjdCBtY2UgKm0pOw0KPiArZXh0ZXJuIGJvb2wgZmlsdGVyX21jZV9hbWQoc3RydWN0
IG1jZSAqbSk7DQo+ICANCj4gIGV4dGVybiBpbnQgbWNlX3RocmVzaG9sZF9jcmVhdGVfZGV2aWNl
KHVuc2lnbmVkIGludCBjcHUpOw0KPiAgZXh0ZXJuIGludCBtY2VfdGhyZXNob2xkX3JlbW92ZV9k
ZXZpY2UodW5zaWduZWQgaW50IGNwdSk7DQo+IEBAIC0zNTMsNiArMzU0LDcgQEAgZXh0ZXJuIGlu
dCBtY2VfdGhyZXNob2xkX3JlbW92ZV9kZXZpY2UodW5zaWduZWQgaW50IGNwdSk7DQo+ICBzdGF0
aWMgaW5saW5lIGludCBtY2VfdGhyZXNob2xkX2NyZWF0ZV9kZXZpY2UodW5zaWduZWQgaW50IGNw
dSkgeyByZXR1cm4gMDsgfTsNCj4gIHN0YXRpYyBpbmxpbmUgaW50IG1jZV90aHJlc2hvbGRfcmVt
b3ZlX2RldmljZSh1bnNpZ25lZCBpbnQgY3B1KSB7IHJldHVybiAwOyB9Ow0KPiAgc3RhdGljIGlu
bGluZSBib29sIGFtZF9tY2VfaXNfbWVtb3J5X2Vycm9yKHN0cnVjdCBtY2UgKm0pIHsgcmV0dXJu
IGZhbHNlOyB9Ow0KPiArc3RhdGljIGlubGluZSBib29sIGZpbHRlcl9tY2VfYW1kKHN0cnVjdCBt
Y2UgKm0pIHsgcmV0dXJuIGZhbHNlOyB9Ow0KPiAgDQoNClNvcnJ5LCBJIGZvcmdvdCB0byBtZW50
aW9uIHRoaXMuIEkgd2VudCB3aXRoICJmaWx0ZXJfbWNlX2FtZCIgYmVjYXVzZSBhbWRfZmlsdGVy
X21jZSgpIGlzIGFscmVhZHkgZGVmaW5lZCBpbiBlZGFjL21jZV9hbWQuYyBhbmQgdGhlcmUgd2Fz
IGEgY29uZmxpY3Qgd2hlbiBidWlsZGluZy4gSXMgdGhlcmUgYW5vdGhlciB3YXkgdG8gYXZvaWQg
dGhlc2UgbmFtaW5nIGNvbmZsaWN0cz8NCg0KVGhhbmtzLA0KWWF6ZW4NCg0KPiAgI2VuZGlmDQo+
ICANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvYW1kLmMNCj4gaW5kZXggZTY0ZGU1MTQ5ZTUwLi44MTlkNWRkNDE5
MjUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQo+IEBAIC01NjMsMjIgKzU2Myw1MiBAQCBw
cmVwYXJlX3RocmVzaG9sZF9ibG9jayh1bnNpZ25lZCBpbnQgYmFuaywgdW5zaWduZWQgaW50IGJs
b2NrLCB1MzIgYWRkciwNCj4gIAlyZXR1cm4gb2Zmc2V0Ow0KPiAgfQ0KPiAgDQo+ICtib29sIGZp
bHRlcl9tY2VfYW1kKHN0cnVjdCBtY2UgKm0pDQo+ICt7DQo+ICsJZW51bSBzbWNhX2JhbmtfdHlw
ZXMgYmFua190eXBlID0gc21jYV9nZXRfYmFua190eXBlKG0tPmJhbmspOw0KPiArCXN0cnVjdCBj
cHVpbmZvX3g4NiAqYyA9ICZib290X2NwdV9kYXRhOw0KPiArCXU4IHhlYyA9IChtLT5zdGF0dXMg
Pj4gMTYpICYgMHgzRjsNCj4gKw0KPiArCS8qDQo+ICsJICogU3B1cmlvdXMgZXJyb3JzIG9mIHRo
aXMgdHlwZSBtYXkgYmUgcmVwb3J0ZWQuDQo+ICsJICogU2VlIEZhbWlseSAxN2ggTW9kZWxzIDEw
aC0yRmggRXJyYXR1bSAjMTExNC4NCj4gKwkgKi8NCj4gKwlpZiAoYy0+eDg2ID09IDB4MTcgJiYN
Cj4gKwkgICAgYy0+eDg2X21vZGVsID49IDB4MTAgJiYgYy0+eDg2X21vZGVsIDw9IDB4MkYgJiYN
Cj4gKwkgICAgYmFua190eXBlID09IFNNQ0FfSUYgJiYgeGVjID09IDEwKQ0KPiArCQlyZXR1cm4g
dHJ1ZTsNCj4gKw0KPiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiAgLyoNCj4gLSAqIFR1
cm4gb2ZmIE1DNF9NSVNDIHRocmVzaG9sZGluZyBiYW5rcyBvbiBhbGwgZmFtaWx5IDB4MTUgbW9k
ZWxzIHNpbmNlDQo+IC0gKiB0aGV5J3JlIG5vdCBzdXBwb3J0ZWQgdGhlcmUuDQo+ICsgKiBUdXJu
IG9mZiB0aHJlc2hvbGRpbmcgYmFua3MgZm9yIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCj4g
KyAqIC0gTUM0X01JU0MgdGhyZXNob2xkaW5nIGlzIG5vdCBzdXBwb3J0IG9uIEZhbWlseSAweDE1
Lg0KPiArICogLSBQcmV2ZW50IHBvc3NpYmxlIHNwdXJpb3VzIGludGVycnVwdHMgZnJvbSB0aGUg
SUYgYmFuayBvbiBGYW1pbHkgMHgxNw0KPiArICogICBNb2RlbHMgMHgxMC0weDJGIGR1ZSB0byBF
cnJhdHVtICMxMTE0Lg0KPiAgICovDQo+IC12b2lkIGRpc2FibGVfZXJyX3RocmVzaG9sZGluZyhz
dHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ICt2b2lkIGRpc2FibGVfZXJyX3RocmVzaG9sZGluZyhz
dHJ1Y3QgY3B1aW5mb194ODYgKmMsIHVuc2lnbmVkIGludCBiYW5rKQ0KPiAgew0KPiAtCWludCBp
Ow0KPiArCWludCBpLCBudW1fbXNyczsNCj4gIAl1NjQgaHdjcjsNCj4gIAlib29sIG5lZWRfdG9n
Z2xlOw0KPiAtCXUzMiBtc3JzW10gPSB7DQo+IC0JCTB4MDAwMDA0MTMsIC8qIE1DNF9NSVNDMCAq
Lw0KPiAtCQkweGMwMDAwNDA4LCAvKiBNQzRfTUlTQzEgKi8NCj4gLQl9Ow0KPiArCXUzMiBtc3Jz
W05SX0JMT0NLU107DQo+ICsNCj4gKwlpZiAoYy0+eDg2ID09IDB4MTUgJiYgYmFuayA9PSA0KSB7
DQo+ICsJCW1zcnNbMF0gPSAweDAwMDAwNDEzOyAvKiBNQzRfTUlTQzAgKi8NCj4gKwkJbXNyc1sx
XSA9IDB4YzAwMDA0MDg7IC8qIE1DNF9NSVNDMSAqLw0KPiArCQludW1fbXNycyA9IDI7DQo+ICsJ
fSBlbHNlIGlmIChjLT54ODYgPT0gMHgxNyAmJg0KPiArCQkgICAoYy0+eDg2X21vZGVsID49IDB4
MTAgJiYgYy0+eDg2X21vZGVsIDw9IDB4MkYpKSB7DQo+ICsNCj4gKwkJaWYgKHNtY2FfZ2V0X2Jh
bmtfdHlwZShiYW5rKSAhPSBTTUNBX0lGKQ0KPiArCQkJcmV0dXJuOw0KPiAgDQo+IC0JaWYgKGMt
Png4NiAhPSAweDE1KQ0KPiArCQltc3JzWzBdID0gTVNSX0FNRDY0X1NNQ0FfTUN4X01JU0MoYmFu
ayk7DQo+ICsJCW51bV9tc3JzID0gMTsNCj4gKwl9IGVsc2Ugew0KPiAgCQlyZXR1cm47DQo+ICsJ
fQ0KPiAgDQo+ICAJcmRtc3JsKE1TUl9LN19IV0NSLCBod2NyKTsNCj4gIA0KPiBAQCAtNTg5LDcg
KzYxOSw3IEBAIHZvaWQgZGlzYWJsZV9lcnJfdGhyZXNob2xkaW5nKHN0cnVjdCBjcHVpbmZvX3g4
NiAqYykNCj4gIAkJd3Jtc3JsKE1TUl9LN19IV0NSLCBod2NyIHwgQklUKDE4KSk7DQo+ICANCj4g
IAkvKiBDbGVhciBDbnRQIGJpdCBzYWZlbHkgKi8NCj4gLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRShtc3JzKTsgaSsrKQ0KPiArCWZvciAoaSA9IDA7IGkgPCBudW1fbXNyczsgaSsrKQ0KPiAg
CQltc3JfY2xlYXJfYml0KG1zcnNbaV0sIDYyKTsNCj4gIA0KPiAgCS8qIHJlc3RvcmUgb2xkIHNl
dHRpbmdzICovDQo+IEBAIC02MDQsMTIgKzYzNCwxMiBAQCB2b2lkIG1jZV9hbWRfZmVhdHVyZV9p
bml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4gIAl1bnNpZ25lZCBpbnQgYmFuaywgYmxvY2ss
IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsNCj4gIAlpbnQgb2Zmc2V0ID0gLTE7DQo+ICANCj4g
LQlkaXNhYmxlX2Vycl90aHJlc2hvbGRpbmcoYyk7DQo+IC0NCj4gIAlmb3IgKGJhbmsgPSAwOyBi
YW5rIDwgbWNhX2NmZy5iYW5rczsgKytiYW5rKSB7DQo+ICAJCWlmIChtY2VfZmxhZ3Muc21jYSkN
Cj4gIAkJCXNtY2FfY29uZmlndXJlKGJhbmssIGNwdSk7DQo+ICANCj4gKwkJZGlzYWJsZV9lcnJf
dGhyZXNob2xkaW5nKGMsIGJhbmspOw0KPiArDQo+ICAJCWZvciAoYmxvY2sgPSAwOyBibG9jayA8
IE5SX0JMT0NLUzsgKytibG9jaykgew0KPiAgCQkJYWRkcmVzcyA9IGdldF9ibG9ja19hZGRyZXNz
KGFkZHJlc3MsIGxvdywgaGlnaCwgYmFuaywgYmxvY2spOw0KPiAgCQkJaWYgKCFhZGRyZXNzKQ0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvY29yZS5jDQo+IGluZGV4IDEyZDYxYjhmODE1NC4uZWJjNjE5YTIwYzg3
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+IEBAIC0xNzczLDYgKzE3NzMsOSBAQCBz
dGF0aWMgdm9pZCBfX21jaGVja19jcHVfaW5pdF90aW1lcih2b2lkKQ0KPiAgDQo+ICBib29sIGZp
bHRlcl9tY2Uoc3RydWN0IG1jZSAqbSkNCj4gIHsNCj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZf
dmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EKQ0KPiArCQlyZXR1cm4gZmlsdGVyX21jZV9hbWQobSk7
DQo+ICsNCj4gIAlyZXR1cm4gZmFsc2U7DQo+ICB9DQo+ICANCj4gDQo=
