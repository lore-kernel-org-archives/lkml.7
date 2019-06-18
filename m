Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA6C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80D42084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ehAXysoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFRBt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:49:56 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:8000
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRBt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49+6IRBFxa48QHdrFsjuqMuiUXLhopLRBZ7q8vl5CF4=;
 b=ehAXysoVVU7SQuHD4UmESgsTbGfwEv/mTeFKGYgH8/fMA2NQPGqhpQaqdjStBwrdVMv7B+bxhouZauNTxjr7saHZ4lV9DcUzawcMpxRiLYufkQ4zZgxMHGonYMHmF39hscG740XMj3IPqtNk7VjyQ5DARF5OCc4AbhLwb3Zic74=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 01:49:13 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 01:49:13 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for
 early encryption
Thread-Topic: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for
 early encryption
Thread-Index: AQHVIvZFyxh/3O5jxUuQLlnW4iiwNqafsnCAgAD3rgA=
Date:   Tue, 18 Jun 2019 01:49:13 +0000
Message-ID: <9e7e1757-2f2f-ae34-5b31-cca5e164a6a9@amd.com>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <cdb1fab3558ae11a50c922d8f373c2125c862e10.1560546537.git.thomas.lendacky@amd.com>
 <20190617110241.GH27127@zn.tnic>
In-Reply-To: <20190617110241.GH27127@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:5:100::23) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a860549-b553-45ce-c108-08d6f38f29df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2969;
x-ms-traffictypediagnostic: DM6PR12MB2969:
x-microsoft-antispam-prvs: <DM6PR12MB2969E44EE3F1015DEC1D2642ECEA0@DM6PR12MB2969.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53546011)(25786009)(305945005)(2906002)(72206003)(7736002)(31696002)(229853002)(6916009)(86362001)(99286004)(2616005)(7416002)(486006)(53936002)(26005)(6512007)(76176011)(6486002)(31686004)(71190400001)(4326008)(14454004)(6246003)(256004)(6436002)(478600001)(102836004)(8936002)(36756003)(5660300002)(54906003)(316002)(66066001)(386003)(6116002)(81166006)(3846002)(81156014)(71200400001)(6506007)(66946007)(186003)(66476007)(446003)(66446008)(64756008)(66556008)(52116002)(8676002)(68736007)(73956011)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2969;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RYL3kCg00gtCiPTKDy+yYCYQGDfM7GfPYMgJO20kKgx3JALNPwnQ4TZfjy2IP2m8CzUhnpaJW0QRY4qgcgRv33aFIEhC+tP2iQinKxweNxteAAKCqmzuZr6NVYl1qYiF6Pi9P0UptZBSLwUmhXRloVRW+p1O/7MkhhKmY3bVBo0eshArXSGmD0vdP+TXC1ZRQUjEYPKEIpcCu4W+VL2tKGQaxjZqQagJtxxlVTfq2GJS6O21jkydlcZRKQxlT702GmnlVzmbB3tlssZ/UIn37NVzpbsMvZxKetLSX4GQRl/BfOTch8t3irwSpmzJPk5w55oGIoTXTwy6xKS/Bqb4NPR0FReJE1Yt+wnGwfI1Fnu+51S1oJZUK32EpPGXGjXITetJClRxdgtq02ZV0k/wslJrYapMMOrwbplO0Xckgbk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEE2FF6326684247AD0DE6EE9ABC2BC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a860549-b553-45ce-c108-08d6f38f29df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 01:49:13.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNy8xOSA2OjAyIEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIEZyaSwgSnVu
IDE0LCAyMDE5IGF0IDA5OjE1OjE5UE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgYi9hcmNoL3g4Ni9r
ZXJuZWwvdm1saW51eC5sZHMuUw0KPj4gaW5kZXggY2EyMjUyY2E2YWQ3Li5hN2FhNjViNDRjNzEg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUw0KPj4gKysrIGIv
YXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMNCj4+IEBAIC0zODcsNiArMzg3LDMwIEBAIFNF
Q1RJT05TDQo+PiAgCS4gPSBBTElHTihQQUdFX1NJWkUpOwkJLyoga2VlcCBWT19JTklUX1NJWkUg
cGFnZSBhbGlnbmVkICovDQo+PiAgCV9lbmQgPSAuOw0KPj4gIA0KPj4gKyNpZmRlZiBDT05GSUdf
QU1EX01FTV9FTkNSWVBUDQo+PiArCS8qDQo+PiArCSAqIFNNRSB3b3JrYXJlYSBzZWN0aW9uOiBM
aXZlcyBvdXRzaWRlIG9mIHRoZSBrZXJuZWwgcHJvcGVyIChfdGV4dCAtDQo+PiArCSAqIF9lbmQp
IGZvciBwZXJmb3JtaW5nIGluLXBsYWNlIGVuY3J5cHRpb24gb2YgdGhlIGtlcm5lbCBkdXJpbmcg
Ym9vdC4NCj4+ICsJICoNCj4+ICsJICogUmVzaWRlcyBhZnRlciBfZW5kIGJlY2F1c2UgZXZlbiB0
aG91Z2ggdGhlIC5icmsgc2VjdGlvbiBpcyBhZnRlcg0KPj4gKwkgKiBfX2VuZF9vZl9rZXJuZWxf
cmVzZXJ2ZSwgdGhlIC5icmsgc2VjdGlvbiBpcyBsYXRlciByZXNlcnZlZCBhcyBhDQo+PiArCSAq
IHBhcnQgb2YgdGhlIGtlcm5lbC4gSXQgaXMgdXNlZCBpbiB2ZXJ5IGVhcmx5IGJvb3QgY29kZSBh
bmQgbm90DQo+PiArCSAqIG5lZWRlZCBhZnRlciB0aGF0LCBzbyBpdCBpcyBsb2NhdGVkIGFmdGVy
IF9fZW5kX29mX2tlcm5lbF9yZXNlcnZlDQo+PiArCSAqIHNvIHRoYXQgaXQgd2lsbCBiZSBkaXNj
YXJkZWQgYW5kIGJlY29tZSBwYXJ0IG9mIHRoZSBhdmFpbGFibGUNCj4+ICsJICogbWVtb3J5Lg0K
Pj4gKwkgKg0KPj4gKwkgKiBSZXNpZGVzIG9uIGEgMk1CIGJvdW5kYXJ5IHRvIHNpbXBsaWZ5IHRo
ZSBwYWdldGFibGUgc2V0dXAgdXNlZCBmb3INCj4+ICsJICogdGhlIGVuY3J5cHRpb24uDQo+PiAr
CSAqLw0KPj4gKwkuID0gQUxJR04oSFBBR0VfU0laRSk7DQo+PiArCS5zbWUgOiBBVChBRERSKC5z
bWUpIC0gTE9BRF9PRkZTRVQpIHsNCj4gDQo+IFNob3VsZCB3ZSBjYWxsIHRoYXQgc2VjdGlvbiBz
b21ldGhpbmcgbW9yZSBnZW5lcmljIGFzDQo+IA0KPiAJLmVhcmx5X3NjcmF0Y2gNCj4gDQo+IG9y
IHNvPw0KPiANCj4gU29tZW9uZSBlbHNlIG1pZ2h0IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhhdCB0
b28sIGluIHRoZSBmdXR1cmUuLi4NCg0KV2hvZXZlciB1c2VzIGl0IGluIHRoZSBmdXR1cmUgY291
bGQgcmVuYW1lIGl0IGlmIGRlc2lyZWQuICBCdXQgSSBjYW4gZG8NCnRoYXQgbm93LiBJcyB0aGVy
ZSBhIHByZWZlcnJlZCBuYW1lPyAgSSBjYW4gbGVhdmUgaXQgYXMgLmVhcmx5X3NjcmF0Y2gNCm9y
IC5lYXJseV93b3JrYXJlYS4NCg0KPiANCj4gQWxzbywgdGhlIERJU0NBUkRTIHNlY3Rpb25zIGRv
IGdldCBmcmVlZCBhdCBydW50aW1lIHNvIHdoeSBub3QgbWFrZSBpdA0KPiBwYXJ0IG9mIHRoZSBE
SVNDQVJEIHNlY3Rpb24uLi4/DQoNCkkgdGhpbmsgaXQncyBlYXNpZXIgdG8gc2hvdyB0aGUgYWxp
Z25tZW50IHJlcXVpcmVtZW50cyB0aGF0IFNNRSBoYXMgZm9yDQp0aGlzIHNlY3Rpb24gYnkgaGF2
aW5nIGl0IGJlIGl0cyBvd24gc2VjdGlvbi4NCg0KPiANCj4+ICsJCV9fc21lX2JlZ2luID0gLjsN
Cj4+ICsJCSooLnNtZSkNCj4+ICsJCS4gPSBBTElHTihIUEFHRV9TSVpFKTsNCj4+ICsJCV9fc21l
X2VuZCA9IC47DQo+PiArCX0NCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICAJU1RBQlNfREVCVUcNCj4+
ICAJRFdBUkZfREVCVUcNCj4+ICANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9tZW1fZW5j
cnlwdF9pZGVudGl0eS5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYw0KPj4g
aW5kZXggNGFhOWIxNDgwODY2Li5jNTVjMmVjOGZiMTIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jDQo+PiArKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5j
cnlwdF9pZGVudGl0eS5jDQo+PiBAQCAtNzMsNiArNzMsMTkgQEAgc3RydWN0IHNtZV9wb3B1bGF0
ZV9wZ2RfZGF0YSB7DQo+PiAgCXVuc2lnbmVkIGxvbmcgdmFkZHJfZW5kOw0KPj4gIH07DQo+PiAg
DQo+PiArLyoNCj4+ICsgKiBUaGlzIHdvcmsgYXJlYSBsaXZlcyBpbiB0aGUgLnNtZSBzZWN0aW9u
LCB3aGljaCBsaXZlcyBvdXRzaWRlIG9mDQo+PiArICogdGhlIGtlcm5lbCBwcm9wZXIuIEl0IGlz
IHNpemVkIHRvIGhvbGQgdGhlIGludGVybWVkaWF0ZSBjb3B5IGJ1ZmZlcg0KPj4gKyAqIGFuZCBt
b3JlIHRoYW4gZW5vdWdoIHBhZ2V0YWJsZSBwYWdlcy4NCj4+ICsgKg0KPj4gKyAqIEJ5IHVzaW5n
IHRoaXMgc2VjdGlvbiwgdGhlIGtlcm5lbCBjYW4gYmUgZW5jcnlwdGVkIGluIHBsYWNlIGFuZCB3
ZQ0KPiANCj4gcmVwbGFjZSB0aGF0ICJ3ZSIgd2l0aCBhbiBpbXBhcnRpYWwgcGFzc2l2ZSBmb3Jt
dWxhdGlvbi4NCg0KT2suDQoNCj4gDQo+IE90aGVyIHRoYW4gdGhhdCwgSSBsaWtlIHRoZSBjb21t
ZW50aW5nLCB2ZXJ5IGhlbHBmdWwhDQoNCkknbGwgc2VuZCBvdXQgYSBWMyB3aXRoIHRoZSBjb21t
ZW50cyBhZGRyZXNzZWQgKGFmdGVyIGdpdmluZyBhIGJpdCBvZiB0aW1lDQpmb3IgbmFtZSBzdWdn
ZXN0aW9ucykuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaHguDQo+IA0K
