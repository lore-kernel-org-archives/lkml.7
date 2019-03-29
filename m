Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27919C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DCC218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oL+vego7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfC2USI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:18:08 -0400
Received: from mail-eopbgr760044.outbound.protection.outlook.com ([40.107.76.44]:8069
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730092AbfC2USI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owcq/3w/jznydyfqwBrasq7yBcBFAVKqPuyfWdqhqrk=;
 b=oL+vego7ysR2S4tg5ML8OTpuBBprZT30/P0Vm1pHh97RnCl4/SxYbLm5QDt8ihVkwXII4IFsQBqsITOFpr9W/XglbfmWY1eTfcxssHjQlHoYzKXC+lnzCsUsu3uyjCd+pzYJdpBbl8CuXFNTO8go/cy/qYtRfTtIDOTHMHKAGuU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 20:18:04 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 20:18:04 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Topic: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Index: AQHU4O2BoYVHUSyDFUS3Ma8HXurpGqYfpwyAgANurKA=
Date:   Fri, 29 Mar 2019 20:18:04 +0000
Message-ID: <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
         <d16e973c3fa4343134f6d246cc424f29ff5d7dc9.1553285718.git.Janakarajan.Natarajan@amd.com>
 <f3a749646c66a84e17383204385d8c73750d4813.camel@intel.com>
In-Reply-To: <f3a749646c66a84e17383204385d8c73750d4813.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71ac305-b5c8-4dd9-27ea-08d6b483a67a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-microsoft-antispam-prvs: <SN6PR12MB2815E2C141CEA03AFB2D4048F85A0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(13464003)(4326008)(305945005)(86362001)(99286004)(7736002)(102836004)(25786009)(256004)(74316002)(97736004)(14444005)(106356001)(68736007)(3846002)(26005)(66066001)(72206003)(81166006)(81156014)(2906002)(8676002)(53546011)(316002)(478600001)(8936002)(71200400001)(71190400001)(7696005)(486006)(6436002)(6506007)(7416002)(9686003)(76176011)(6116002)(2201001)(14454004)(33656002)(446003)(11346002)(186003)(52536014)(476003)(5660300002)(53936002)(6246003)(105586002)(2501003)(229853002)(54906003)(55016002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r7dT3OJkGdAL5US0SCI4RaZbpnqgwWObT88MnftARaY099OvT2c7YtZnz1JI7+UoC7uo/QrtFgJdWNx3LgN0/Jh6IvlJkG3e4gB8yd9xgC/d4wGiGaGj6q1xg0D9Xz/QGtLK/bUQrG6jHYaxfVh3zrmMpFsRrdZ8GsHQZjCV2Zp3kW61KYvT85cmUu/PFnCSTxvEhic5PU17oxa5NkXsyeW9qWQCD5Y165tjsk3KK84DAo7WSZ0yEz2UXbaQ2jrpC2iqvt3zA2OcyYtNqk10J6qQWKgIPGbnNclM9+NXdLLLKCHZFzTxgd55L0Hl3z4WW95jYi3EN1Qv9eSjts+0zFr4VyZH3p7fBqsI+Z+UtgW4regBQhKc7jzKkNIdFDVHM7pzE2+KMYQZHa9/DY9DYwwjCsbYMqjh/fTlIOX1Ee4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71ac305-b5c8-4dd9-27ea-08d6b483a67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 20:18:04.5312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1hY3BpLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtYWNwaS1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBQYW5kcnV2YWRhLCBTcmluaXZhcw0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI3LCAy
MDE5IDEwOjQ4IEFNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBh
Y3BpY2Eub3JnOyBOYXRhcmFqYW4sIEphbmFrYXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5A
YW1kLmNvbT47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5r
ZXJuZWwub3JnDQo+IENjOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPjsg
bGVuYkBrZXJuZWwub3JnOyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgTW9vcmUsIFJvYmVydA0K
PiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFNjaG1hdXNzLCBFcmlrIDxlcmlrLnNjaG1hdXNz
QGludGVsLmNvbT47IHJqd0Byand5c29ja2kubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82
XSBhY3BpL2NwcGM6IEFkZCBzdXBwb3J0IGZvciBvcHRpb25hbCBDUFBDIHJlZ2lzdGVycw0KPiAN
Cj4gT24gRnJpLCAyMDE5LTAzLTIyIGF0IDIwOjI2ICswMDAwLCBOYXRhcmFqYW4sIEphbmFrYXJh
amFuIHdyb3RlOg0KPiA+IEZyb206IFlhemVuIEdoYW5uYW0gPFlhemVuLkdoYW5uYW1AYW1kLmNv
bT4NCj4gPg0KPiA+IE5ld2VyIEFNRCBwcm9jZXNzb3JzIHN1cHBvcnQgYSBzdWJzZXQgb2YgdGhl
IG9wdGlvbmFsIENQUEMgcmVnaXN0ZXJzLg0KPiA+IENyZWF0ZSBzaG93LCBzdG9yZSBhbmQgaGVs
cGVyIHJvdXRpbmVzIGZvciBzdXBwb3J0ZWQgQ1BQQyByZWdpc3RlcnMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+ID4gWyBj
YXJ2ZWQgb3V0IGludG8gYSBwYXRjaCwgY2xlYW5lZCB1cCwgcHJvZHVjdGl6ZWQgXQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IEphbmFrYXJhamFuIE5hdGFyYWphbiA8SmFuYWthcmFqYW4uTmF0YXJhamFu
QGFtZC5jb20+DQo+ID4NCj4gDQo+IFsuLl0NCj4gDQo+ID4gKwkvKiBkZXNpcmVkX3BlcmYgaXMg
dGhlIG9ubHkgbWFuZGF0b3J5IHZhbHVlIGluIHBlcmZfY3RybHMgKi8NCj4gPiArCWlmIChjcGNf
cmVhZChjcHUsIGRlc2lyZWRfcmVnLCAmZGVzaXJlZCkpDQo+ID4gKwkJcmV0ID0gLUVGQVVMVDsN
Cj4gPiArDQo+ID4gKwlpZiAoQ1BDX1NVUFBPUlRFRChtYXhfcmVnKSAmJiBjcGNfcmVhZChjcHUs
IG1heF9yZWcsICZtYXgpKQ0KPiA+ICsJCXJldCA9IC1FRkFVTFQ7DQo+ID4gKw0KPiBXZSBzaG91
bGQgY3JlYXRlIGFuZCB1c2UgZGlmZmVyZW50IG1hY3JvIG90aGVyIHRoYW4gQ1BQQ19TVVBQT1JU
RUQuDQo+IENQQ19TVVBQT1JURUQgZG9lc24ndCB2YWxpZGF0ZSB0aGUgY29ycmVjdG5lc3Mgb2Yg
b2JqZWN0IHR5cGUgZm9yIGENCj4gZmllbGQuIEZvciBleGFtcGxlICJNYXhpbXVtIFBlcmZvcm1h
bmNlIFJlZ2lzdGVyIiBjYW4gb25seSBiZSBidWZmZXINCj4gbm90IGludGVnZXIuIEluIHRoaXMg
d2F5IGludmFsaWQgZmllbGQgZGVmaW5pdGlvbnMgY2FuIGJlIGlnbm9yZWQuDQo+IA0KDQpTbyBj
cmVhdGUgc29tZXRoaW5nIGxpa2UgIkNQUENfU1VQUE9SVEVEX0JVRkZFUiIgZm9yIGJ1ZmZlci1v
bmx5IHJlZ2lzdGVycz8NCg0KQW5kIHRoZW4gYnVmZmVyL2ludGVnZXIgcmVnaXN0ZXJzIHdpbGwg
Y29udGludWUgdG8gdXNlICJDUFBDX1NVUFBPUlRFRCIuDQoNClRoZXNlIHNlZW0gdG8gYmUgdGhl
IG9ubHkgdHdvIGNhc2VzIGF0IHRoaXMgdGltZS4gSXMgdGhpcyBva2F5Pw0KDQpUaGFua3MsDQpZ
YXplbg0KDQo+IA0KPiA+ICsJaWYgKENQQ19TVVBQT1JURUQobWluX3JlZykgJiYgY3BjX3JlYWQo
Y3B1LCBtaW5fcmVnLCAmbWluKSkNCj4gPiArCQlyZXQgPSAtRUZBVUxUOw0KPiA+ICsNCj4gPiAr
CWlmIChDUENfU1VQUE9SVEVEKGVuZXJneV9yZWcpICYmIGNwY19yZWFkKGNwdSwgZW5lcmd5X3Jl
ZywNCj4gPiAmZW5lcmd5KSkNCj4gPiArCQlyZXQgPSAtRUZBVUxUOw0KPiA+ICsNCj4gPiArCWlm
IChDUENfU1VQUE9SVEVEKGF1dG9fc2VsX2VuYWJsZV9yZWcpICYmDQo+ID4gKwkgICAgY3BjX3Jl
YWQoY3B1LCBhdXRvX3NlbF9lbmFibGVfcmVnLCAmYXV0b19zZWxfZW5hYmxlKSkNCj4gPiArCQly
ZXQgPSAtRUZBVUxUOw0KPiA+ICsNCj4gSGVyZSBpdCBpcyBmaW5lIHRvIHVzZSBDUENfU1VQUE9S
VEVEIGFzIHRoZSAiQXV0b25vbW91cyBTZWxlY3Rpb24NCj4gRW5hYmxlIiBjYW4gYmUgYm90aCBp
bnRlZ2VyIGFuZCBidWZmZXIuDQo+IA0KPiBUaGFua3MsDQo+IFNyaW5pdmFzDQoNCg==
