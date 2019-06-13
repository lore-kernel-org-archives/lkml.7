Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099EAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27620645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oeR709O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFMR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:59:20 -0400
Received: from mail-eopbgr810077.outbound.protection.outlook.com ([40.107.81.77]:10432
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbfFMR7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rv5mAxLEAsMqHUsT3TDIV11CepCUERP702baz12Ec=;
 b=oeR709O9lEtIjX3/8RUaOIRJ7AYp/IbRNItKPxtIXdstwhl5Dbvc4LYn3w2TI8vbebmiKttPYI08Q2enRxjiGfd76Qsw2auDKLXzYCIQG1qDRu/1VArGPB5aBYwVr+Wd5Rur1NhEc9sj/pjmoiybq/f8fhMhmYajMo5Fy84IsJE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2956.namprd12.prod.outlook.com (20.179.104.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 17:59:04 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 17:59:04 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Topic: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Index: AQHVISNEIgHKCEThME+IPHE9yhs80KaYHOiAgAAuPICAAZLcgIAAAxWA
Date:   Thu, 13 Jun 2019 17:59:03 +0000
Message-ID: <49a73751-9ede-234e-3432-74cfa62af0e3@amd.com>
References: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
 <053ded24-eb70-0e88-5e0c-312ea93a6fd0@intel.com>
 <42f8b183-caae-9147-4021-3dee3462c0db@amd.com>
 <a4bdf881-50f2-78eb-066a-816e532af149@intel.com>
In-Reply-To: <a4bdf881-50f2-78eb-066a-816e532af149@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:805:3e::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc6c619-0f12-4c3a-bd9c-08d6f028d207
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2956;
x-ms-traffictypediagnostic: DM6PR12MB2956:
x-microsoft-antispam-prvs: <DM6PR12MB2956D901E60C8DD8BCFE3B5CECEF0@DM6PR12MB2956.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(54094003)(199004)(189003)(6512007)(6246003)(2501003)(76176011)(14454004)(8936002)(81166006)(2906002)(68736007)(72206003)(66556008)(66946007)(73956011)(7416002)(6116002)(316002)(71190400001)(186003)(5660300002)(4326008)(53936002)(53546011)(386003)(86362001)(2201001)(71200400001)(102836004)(6506007)(478600001)(31696002)(25786009)(52116002)(6436002)(476003)(99286004)(446003)(305945005)(2616005)(66066001)(110136005)(6486002)(256004)(54906003)(36756003)(31686004)(26005)(3846002)(486006)(7736002)(66476007)(64756008)(8676002)(11346002)(229853002)(66446008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2956;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UdwxQW5jiD7xG7A1JGShaQ9xAEmBOIrzML8qiCO75KgbDDmbKT7jlMnueMMRQyVqC6Be9N2RQjMuFdvqSV6tJua9bDgHPRqwLBR+FvABhXH2hVfWb2x3eNKowbA39HxQoVgqNEA0DFrlvEHUK+TKEXIBrorlrLvFpeiRQgE4CXpqG8XysuusSVjaE5bem6CJyEKYFt2hDIKbnsMMS6qWbvwNFFzvFwWvGid96CSTn1jOtPkwyGDeQUzEDRGfNiKi4iuF1MmvCxa1RMpNu2ZuZSpJvcYPXnFBdw211twoPo9v4jUmVi4OjBcLHF02UYY1Y9A1mPKZ7pHUrNDySe8dKPD5999KH3PqhOSJXk9Q74I4FW3w36AyczXiXp6UCWwzzgROZeKfkG2TOp82ifDnRxvyOTzyzxW0OshvmbKa08U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C60BC644C706E4099571EB675C81EA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc6c619-0f12-4c3a-bd9c-08d6f028d207
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 17:59:03.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMy8xOSAxMjo0NyBQTSwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDYvMTIvMTkgMTA6
NDYgQU0sIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+PiBPbiA2LzEyLzE5IDEwOjAwIEFNLCBE
YXZlIEhhbnNlbiB3cm90ZToNCj4+PiBPbiA2LzEyLzE5IDY6MzIgQU0sIExlbmRhY2t5LCBUaG9t
YXMgd3JvdGU6DQo+Pj4+IENyZWF0ZSBhIHNlY3Rpb24gZm9yIFNNRSBpbiB0aGUgdm1saW51eC5s
ZHMuUy4gIFBvc2l0aW9uIGl0IGFmdGVyICJfZW5kIg0KPj4+PiBzbyB0aGF0IHRoZSBtZW1vcnkg
d2lsbCBiZSByZWNsYWltZWQgZHVyaW5nIGJvb3QgYW5kLCBzaW5jZSBpdCBpcyBhbGwNCj4+Pj4g
emVyb2VzLCBpdCBjb21wcmVzc2VzIHdlbGwuIA0KPj4+DQo+Pj4gSSBkb24ndCB0aGluayBJIHJl
YWxpemVkIHRoYXQgdGhpbmdzIGFmdGVyIF9lbmQgZ2V0IHJlY2xhaW1lZC4gIERvIHdlIGRvDQo+
Pj4gdGhhdCBhdCB0aGUgc2FtZSBzcG90IHRoYXQgd2UgZG8gaW5pdCBkYXRhIG9yIHNvbWV3aGVy
ZSBlbHNlPw0KPj4NCj4+IEkgd2FzIGxvb2tpbmcgYXQgdGhlIHN0YXJ0IG9mIHNldHVwX2FyY2go
KSBpbiBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYywNCj4+IHdoZXJlIHRoZXJlJ3MgYSBtZW1ibG9j
a19yZXNlcnZlKCkgZG9uZSBmb3IgdGhlIGtlcm5lbCAoaXQgcmVzZXJ2ZXMgZnJvbQ0KPj4gX3Rl
eHQgdG8gX19ic3Nfc3RvcCwgbm90IGFsbCB0aGUgd2F5IHRvIF9lbmQsIGFuZCBsYXRlciB0aGUg
YnJrIGFyZWENCj4+IGlzIHJlc2VydmVkKS4gQXQgdGhhdCBwb2ludCwgbXkgdGFrZSB3YXMgdGhh
dCB0aGUgbWVtb3J5IG91dHNpZGUgdGhlDQo+PiByZXNlcnZlZCBhcmVhIGlzIG5vdyBhdmFpbGFi
bGUgKGFuZCB0aGVyZSdzIGEgY29tbWVudCBiZWxvdyB0aGF0IHRvIHRoYXQNCj4+IGVmZmVjdCwg
YWxzbyksIHNvIHRoZSAuc21lIHNlY3Rpb24gd291bGQgYmFzaWNhbGx5IGJlIGRpc2NhcmRlZCBh
bmQNCj4+IHJlLWNsYWltZWQgZm9yIGdlbmVyYWwgcGFnZSB1c2FnZS4NCj4gDQo+IFRoaXMgc2Vl
bXMgYXdmdWxseSBzdWJ0bGUuICBUaGlzIHdvdWxkIGJlIHRoZSBvbmx5IHNlY3Rpb24gdHJlYXRl
ZCB0aGlzDQo+IHdheSBiZWNhdXNlLCBhcyB5b3Ugbm90ZSwgZXZlbiB0aGUgJy5icmsnIGFyZWEg
ZW5kcyB1cCBnZXR0aW5nDQo+IG1lbWJsb2NrX3Jlc2VydmUoKSdkLiAgQWxzbywgdGhpcyBvZGQg
cHJvcGVydHkgaXMgbm90IGNvbW1lbnRlZCBvbiBhdCBhbGwuDQo+IA0KPiBUaGF0J3Mgbm90IHRo
ZSBlbmQgb2YgdGhlIHdvcmxkLiAgQnV0LCBpZiB3ZSdyZSBnb2luZyB0byBkbyB0aGlzLCBpdA0K
PiBzZWVtcyBsaWtlIHdlIG5lZWQgdG8gbW92ZSB0aGU6DQo+IA0KPiAJLyogU2VjdGlvbnMgdG8g
YmUgZGlzY2FyZGVkIC8qDQo+IA0KPiBjb21tZW50IHRvIHVwIGFib3ZlIHlvdXIgbmV3IGFyZWEu
ICBJdCBhbHNvIHNlZW1zIGxpa2Ugd2UgbmVlZCBzb21ldGhpbmcNCj4gZXhwbGljaXQgaW4gdGhl
cmUgbmVhciBfX2Jzc19zdG9wIHNheWluZzoNCj4gDQo+IAkvKg0KPiAgICAJICogRXZlcnl0aGlu
ZyBiZXR3ZWVuIF90ZXh0IGFuZCBoZXJlIGlzIGF1dG9tYXRpY2FsbHkgcmVzZXJ2ZWQNCj4gCSAq
IGluIHNldHVwX2FyY2goKS4gIEV2ZXJ5dGhpbmcgYWZ0ZXIgaGVyZSBtdXN0IGVpdGhlciBoYXZl
IGl0cw0KPiAJICogb3duIG1lbWJsb2NrX3Jlc2VydmUoKSwgb3IgaXQgd2lsbCBiZSB0cmVhdGVk
IGFzIGF2YWlsYWJsZQ0KPiAJICogbWVtb3J5IGFuZCBmcmVlZCBhdCBib290Lg0KPiAJICovDQoN
ClRoYXQgYWxsIG1ha2VzIHNlbnNlLg0KDQo+IA0KPiBBY3R1YWxseSwgSSB3b25kZXIgaWYgd2Ug
c2hvdWxkIGFkZCBhIHN5bWJvbCBjYWxsZWQNCj4gJ19fZW5kX29mX2tlcm5lbF9yZXNlcnZlJyBh
bmQgdXNlICp0aGF0KiBpbnN0ZWFkIG9mIF9fYnNzX3N0b3AgaW4NCj4gc2V0dXBfYXJjaCgpLg0K
DQpJZiBldmVyeW9uZSB0aGlua3MgdGhhdCdzIGJlc3QsIEkgY2FuIGRvIHRoYXQuIFByb2JhYmx5
IGJlc3QgYXMgYQ0KcHJlLXBhdGNoIGFuZCBtYWtlIHRoaXMgaW50byBhIDItcGF0Y2ggc2VyaWVz
LCB0aGVuLg0KDQo+IA0KPiBBZnRlciBJIHNheSBhbGwgdGhhdC4uLiAgV2h5IGNhbid0IHlvdSBq
dXN0IHN0aWNrIHlvdXIgZGF0YSBpbiBhIG5vcm1hbCwNCj4gdmFuaWxsYSBfX2luaXQgdmFyaWFi
bGU/ICBXb3VsZG4ndCB0aGF0IGJlIGEgbG90IGxlc3Mgc3VidGxlPw0KDQpUaGUgYXJlYSBuZWVk
cyB0byBiZSBvdXRzaWRlIG9mIHRoZSBrZXJuZWwgcHJvcGVyIGFzIHRoZSBrZXJuZWwgaXMNCmVu
Y3J5cHRlZCAiaW4gcGxhY2UuIiBTbyBhbiBfX2luaXQgdmFyaWFibGUgd29uJ3Qgd29yayBoZXJl
Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCg==
