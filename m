Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7920863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E0qMzgWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfIKN1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:27:13 -0400
Received: from mail-eopbgr820088.outbound.protection.outlook.com ([40.107.82.88]:31996
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfIKN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:27:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5JWj2oYiNrAY9yqazHLAQtzaRR/NifOIVhj2nGLMXq9Pb4olhHORW0/oVWCiJXSu8omhl1z7P5MjvdJnIKno+7N+J0yhgwASuPh6VYykl39jbNDNDJRoXbcblMrkhOXGHZ/mj93V1T4+F4iyrNLos/+BYZMxFdJ67OLwPByQS0BmrjKFb/T5TxLwT5qcVOgubweSC3HsWo/LxsJWGLENk7SlndwfPNkd941YycPtys5SxdY0t1ffKnVoScrz1q9GaluVNY5Fyowvy4iw00GGInJN9cnnk0yE5IxYz6TfLfnBvT0SdhqRVKkJOE1CCT582Ebg374cR3IgEv6GUwL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/79ZNswUC+i2Ww219YXdMTWshcX9YRU+nuVkz/h5Ug=;
 b=ZxruvTJwlc1mApyVXUbNxItca1D/6iiH/KpkKSzCji1zJRy65ffzhepwRgDbKbhdh97TsI2KuLusBhEF/DrgBIiEorOLZztCGJD7vGf20vqkt6SWEQ21jVt7tcsa9pCqBRMzvFeSPgWPXGfZenu7JsWrJLcfTjNwgFAtETfiTJu8bVJ4lmKXAEdGD8RilOwRoKyKkhh3cfJTegXHQPYcje077H+WS+72agZbBXbsMpw0opcZ6HqhCe0AlPwHVa8Du96OPaTHI4v9FHERd8Qn3Zyg+ZEKn6O38THrVwDIUfuJT3Xc/AKVpid2gTRc5RiCxos8wc4RulBmNu/nh02KOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/79ZNswUC+i2Ww219YXdMTWshcX9YRU+nuVkz/h5Ug=;
 b=E0qMzgWdYvD1JrbhAvsZa4Q/cWdCLOPif0zzGjJvpGmV3iq/Uft95ihS8+71LxUiblcpzub3ab/KDPgsIU2p+C3GPaeL/RMizy3Jp1QOLNUJ2d0953tCNmoWklY3xq+FPBrW1IwG495VPmG9pJGOpz/h2Wgvcw7nRWcd0hJhjhA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3177.namprd12.prod.outlook.com (20.179.104.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 11 Sep 2019 13:27:08 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2241.021; Wed, 11 Sep 2019
 13:27:08 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0gKFZNd2FyZSk=?= 
        <thomas_os@shipmail.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "linux-graphics-maintainer@vmware.com" 
        <linux-graphics-maintainer@vmware.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Topic: [PATCH v2 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
Thread-Index: AQHVaJ4hNPy1jEi3+E2hfyLI/LSoQ6cmd/kA
Date:   Wed, 11 Sep 2019 13:27:08 +0000
Message-ID: <b63de7ad-21e3-b825-91a4-c4317e82b6c3@amd.com>
References: <20190911124022.22423-1-thomas_os@shipmail.org>
 <20190911124022.22423-2-thomas_os@shipmail.org>
In-Reply-To: <20190911124022.22423-2-thomas_os@shipmail.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:802:21::23) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8955f750-3dd0-45f5-bc81-08d736bbbeb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3177;
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3177F3B122E38FDCE403AAD9ECB10@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(2501003)(256004)(31696002)(8936002)(305945005)(71190400001)(76176011)(71200400001)(52116002)(66446008)(66556008)(64756008)(66946007)(3846002)(6116002)(86362001)(14454004)(478600001)(99286004)(7416002)(53936002)(14444005)(5660300002)(7736002)(2906002)(81166006)(81156014)(6512007)(66574012)(66476007)(8676002)(66066001)(6486002)(31686004)(6436002)(229853002)(36756003)(486006)(6246003)(186003)(26005)(2616005)(476003)(446003)(11346002)(6506007)(110136005)(53546011)(102836004)(25786009)(4326008)(54906003)(316002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3177;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +/Y2A2LNXN70Q9XP4pDybTHDnwIvkqCPXaSUxPqIewZiGJ4UwVcIurejf48B7Q0sXO0oETRgVZrRoBtIp/4zl7Gl0K5IHCAwRLZPT6WwL8yrfq4//9dzBMXyNfE/1/o0Axc/KmGgfn6lBAkBBY1humBqUEtxv69GpJHbe+RBM70TAjRU8TFld/UQprpkaxABiwjczkBXBHo1xvWfDCKbe5QAQSc7GgA7zoPw2HAwlUAoGsHA3Ft0ZrclRED2yV1NWAiHmeMbNhz+SR2x2JBHPbBn0vj41ocr83bcmXRZXh9xmlUN2EMHR4yDkOnhKBB5mCVBaovOqtpgCaalXnGqc2ZcuIEenMySEU3565k6CNjDmBjPF+syIUnVOSPe6MMVSz1UGiPHeSUAZwsas0lkp/58RW4CSVncj6BEsQ+UsZs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2790220250E4AB43A31CE0E74F13B9F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8955f750-3dd0-45f5-bc81-08d736bbbeb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 13:27:08.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEaXuOBOdbCnwE5flbB6uyuaQqEGl87YGMtnppySt/b00ATIbwiDapF8ezSGtJBvJdIUUy1qo2X1ZvO6A3S+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMS8xOSA3OjQwIEFNLCBUaG9tYXMgSGVsbHN0csO2bSAoVk13YXJlKSB3cm90ZToNCj4g
RnJvbTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPg0KPiANCj4gV2hl
biBTRVYgb3IgU01FIGlzIGVuYWJsZWQgYW5kIGFjdGl2ZSwgdm1fZ2V0X3BhZ2VfcHJvdCgpIHR5
cGljYWxseQ0KPiByZXR1cm5zIHdpdGggdGhlIGVuY3J5cHRpb24gYml0IHNldC4gVGhpcyBtZWFu
cyB0aGF0IHVzZXJzIG9mDQo+IHBncHJvdF9tb2RpZnkoLCB2bV9nZXRfcGFnZV9wcm90KCkpICht
cHJvdGVjdF9maXh1cCwgZG9fbW1hcCkgZW5kIHVwIHdpdGgNCj4gYSB2YWx1ZSBvZiB2bWEtPnZt
X3BnX3Byb3QgdGhhdCBpcyBub3QgY29uc2lzdGVudCB3aXRoIHRoZSBpbnRlbmRlZA0KPiBwcm90
ZWN0aW9uIG9mIHRoZSBQVEVzLiBUaGlzIGlzIGFsc28gaW1wb3J0YW50IGZvciBmYXVsdCBoYW5k
bGVycyB0aGF0DQo+IHJlbHkgb24gdGhlIFZNQSB2bV9wYWdlX3Byb3QgdG8gc2V0IHRoZSBwYWdl
IHByb3RlY3Rpb24uIEZpeCB0aGlzIGJ5DQo+IG5vdCBhbGxvd2luZyBwZ3Byb3RfbW9kaWZ5KCkg
dG8gY2hhbmdlIHRoZSBlbmNyeXB0aW9uIGJpdCwgc2ltaWxhciB0bw0KPiBob3cgaXQncyBkb25l
IGZvciBQQVQgYml0cy4NCj4gDQo+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPg0KPiBDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IENj
OiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IENjOiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRo
YXQuY29tPg0KPiBDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiAiSC4g
UGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KPiBDYzogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcu
Y29tPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPg0KPiAt
LS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICB8IDcgKysrKystLQ0K
PiAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV90eXBlcy5oIHwgMiArLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vcGd0YWJsZS5oDQo+IGluZGV4IDBiYzUzMGM0ZWIxMy4uMWU2YmI0YzI1MzM0IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+IEBAIC02MjQsMTIgKzYyNCwxNSBAQCBzdGF0aWMgaW5s
aW5lIHBtZF90IHBtZF9tb2RpZnkocG1kX3QgcG1kLCBwZ3Byb3RfdCBuZXdwcm90KQ0KPiAgCXJl
dHVybiBfX3BtZCh2YWwpOw0KPiAgfQ0KPiAgDQo+IC0vKiBtcHJvdGVjdCBuZWVkcyB0byBwcmVz
ZXJ2ZSBQQVQgYml0cyB3aGVuIHVwZGF0aW5nIHZtX3BhZ2VfcHJvdCAqLw0KPiArLyoNCj4gKyAq
IG1wcm90ZWN0IG5lZWRzIHRvIHByZXNlcnZlIFBBVCBhbmQgZW5jcnlwdGlvbiBiaXRzIHdoZW4g
dXBkYXRpbmcNCj4gKyAqIHZtX3BhZ2VfcHJvdA0KPiArICovDQo+ICAjZGVmaW5lIHBncHJvdF9t
b2RpZnkgcGdwcm90X21vZGlmeQ0KPiAgc3RhdGljIGlubGluZSBwZ3Byb3RfdCBwZ3Byb3RfbW9k
aWZ5KHBncHJvdF90IG9sZHByb3QsIHBncHJvdF90IG5ld3Byb3QpDQo+ICB7DQo+ICAJcGdwcm90
dmFsX3QgcHJlc2VydmViaXRzID0gcGdwcm90X3ZhbChvbGRwcm90KSAmIF9QQUdFX0NIR19NQVNL
Ow0KPiAtCXBncHJvdHZhbF90IGFkZGJpdHMgPSBwZ3Byb3RfdmFsKG5ld3Byb3QpOw0KPiArCXBn
cHJvdHZhbF90IGFkZGJpdHMgPSBwZ3Byb3RfdmFsKG5ld3Byb3QpICYgfl9QQUdFX0NIR19NQVNL
Ow0KPiAgCXJldHVybiBfX3BncHJvdChwcmVzZXJ2ZWJpdHMgfCBhZGRiaXRzKTsNCj4gIH0NCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV90eXBlcy5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV90eXBlcy5oDQo+IGluZGV4IGI1ZTQ5ZTZiYWM2
My4uZTEzMDg0YjNkNmNiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3Rh
YmxlX3R5cGVzLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV90eXBlcy5o
DQo+IEBAIC0xMjMsNyArMTIzLDcgQEANCj4gICAqLw0KPiAgI2RlZmluZSBfUEFHRV9DSEdfTUFT
SwkoUFRFX1BGTl9NQVNLIHwgX1BBR0VfUENEIHwgX1BBR0VfUFdUIHwJCVwNCj4gIAkJCSBfUEFH
RV9TUEVDSUFMIHwgX1BBR0VfQUNDRVNTRUQgfCBfUEFHRV9ESVJUWSB8CVwNCj4gLQkJCSBfUEFH
RV9TT0ZUX0RJUlRZIHwgX1BBR0VfREVWTUFQKQ0KPiArCQkJIF9QQUdFX1NPRlRfRElSVFkgfCBf
UEFHRV9ERVZNQVAgfCBzbWVfbWVfbWFzaykNCg0KVGhlcmUgaXMgYSBfUEFHRV9FTkMgZGVmaW5p
dGlvbiB0aGF0IHlvdSBjb3VsZCB1c2UgdG8gbWFrZSB0aGlzIG1vcmUNCmNvbnNpc3RlbnQgd2l0
aCB0aGUgY3VycmVudCBkZWZpbml0aW9uLg0KDQpUaGFua3MsDQpUb20NCg0KPiAgI2RlZmluZSBf
SFBBR0VfQ0hHX01BU0sgKF9QQUdFX0NIR19NQVNLIHwgX1BBR0VfUFNFKQ0KPiAgDQo+ICAvKg0K
PiANCg==
