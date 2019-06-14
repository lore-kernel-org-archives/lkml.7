Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF322C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8EA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P8SneDQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfFNVP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:15:26 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:64064
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfFNVPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJf6EpByYEBBGtgIhhLkyDbzmczRPspnbGz+/iTIzY4=;
 b=P8SneDQQx+ffzHFikdpsZj6vvWJBoYoBBeRaeJ/DKKPM5bCYMygPA6R8SxLx2jCcpyGtYsU14j2RHlhYn0iXonf8Eu5EKS5tDtGwX3wczqZ2SIoam3AQtNMH1J+VnkrkK8w08Fe5N3tLJn/BjUcMoeik2x7gG79+Vft3zp6bT0U=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3724.namprd12.prod.outlook.com (10.255.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 21:15:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 21:15:19 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Topic: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for
 early encryption
Thread-Index: AQHVIvZFyxh/3O5jxUuQLlnW4iiwNg==
Date:   Fri, 14 Jun 2019 21:15:19 +0000
Message-ID: <cdb1fab3558ae11a50c922d8f373c2125c862e10.1560546537.git.thomas.lendacky@amd.com>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1560546537.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c6cdcc-4b50-421b-5903-08d6f10d678c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3724;
x-ms-traffictypediagnostic: DM6PR12MB3724:
x-microsoft-antispam-prvs: <DM6PR12MB3724E7FCD1A245EFF424E8D1ECEE0@DM6PR12MB3724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(446003)(66446008)(54906003)(71190400001)(71200400001)(110136005)(76176011)(3846002)(2906002)(7736002)(66946007)(53936002)(305945005)(52116002)(6116002)(66556008)(66476007)(73956011)(25786009)(256004)(36756003)(64756008)(102836004)(14444005)(8676002)(81156014)(316002)(66066001)(6506007)(386003)(2616005)(186003)(6512007)(26005)(2501003)(81166006)(99286004)(6486002)(8936002)(486006)(476003)(68736007)(14454004)(86362001)(72206003)(478600001)(11346002)(5660300002)(7416002)(118296001)(50226002)(4326008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3724;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3XxZ3ornjFvqeEg6uebVdYKtRafh6Ext5946fNSGmNwRRlsR2jCRg7VEol7o5XYZvo+Fnb16hY66JgaW9CpBYrpqIGTPRS8QlnNRtjmyqqCvQI1dWSQZSmDzmmKhHEQZzJ5mkg1fnQIGkX0FrWSlUJyvJqCMCK7lzQGTGFYDn7iDeBhjvByxyPoz3AXIvKRNR+i75OZubY4g+GrThXUMrfm6LLWpoTUYghT6NH1kYZAt/r0LgebxbwkIIMW03GdIPJMAh3TJ6pH932LA5/BGx5yX6GtlTPnM+tYxB9gY5WwsFuE03rhjA7Wo2Nhwf4i5YAHgM0zEBC5b6zIConH/GUoX62JAatWsyxPHkYmn+5UdT4CFt6T3EEhn8d3Dfq49/H6dAktF4Xlidthh/8SjuIYPpNRVY2NWYg7b7QvHPZ0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c6cdcc-4b50-421b-5903-08d6f10d678c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 21:15:19.7211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gb3JkZXIgZm9yIHRoZSBrZXJuZWwgdG8gYmUgZW5jcnlwdGVkICJpbiBwbGFjZSIgZHVyaW5n
IGJvb3QsIGEgd29ya2FyZWENCm91dHNpZGUgb2YgdGhlIGtlcm5lbCBtdXN0IGJlIHVzZWQuIFRo
aXMgU01FIHdvcmthcmVhIHVzZWQgZHVyaW5nIGVhcmx5DQplbmNyeXB0aW9uIG9mIHRoZSBrZXJu
ZWwgaXMgc2l0dWF0ZWQgb24gYSAyTUIgYm91bmRhcnkgYWZ0ZXIgdGhlIGVuZCBvZg0KdGhlIGtl
cm5lbCB0ZXh0LCBkYXRhLCBldGMuIHNlY3Rpb25zIChfZW5kKS4gIFRoaXMgd29ya3Mgd2VsbCBk
dXJpbmcNCmluaXRpYWwgYm9vdCBvZiBhIGNvbXByZXNzZWQga2VybmVsIGJlY2F1c2Ugb2YgdGhl
IHJlbG9jYXRpb24gdXNlZCBmb3INCmRlY29tcHJlc3Npb24gb2YgdGhlIGtlcm5lbC4gQnV0IHdo
ZW4gcGVyZm9ybWluZyBhIGtleGVjIGJvb3QsIHRoZXJlJ3MgYQ0KY2hhbmNlIHRoYXQgdGhlIFNN
RSB3b3JrYXJlYSBtYXkgbm90IGJlIG1hcHBlZCBieSB0aGUga2V4ZWMgcGFnZXRhYmxlcyBvcg0K
dGhhdCBzb21lIG9mIHRoZSBvdGhlciBkYXRhIHVzZWQgYnkga2V4ZWMgY291bGQgZXhpc3QgaW4g
dGhpcyByYW5nZS4NCg0KQ3JlYXRlIGEgc2VjdGlvbiBmb3IgU01FIGluIHZtbGludXgubGRzLlMu
IFBvc2l0aW9uIGl0IGFmdGVyICJfZW5kIiwgd2hpY2gNCmlzIGFmdGVyICJfX2VuZF9vZl9rZXJu
ZWxfcmVzZXJ2ZSIsIHNvIHRoYXQgdGhlIG1lbW9yeSB3aWxsIGJlIHJlY2xhaW1lZA0KZHVyaW5n
IGJvb3QgYW5kIHNpbmNlIHRoaXMgYXJlYSBpcyBhbGwgemVyb2VzLCBpdCBjb21wcmVzc2VzIHdl
bGwuIFRoaXMNCm5ldyBzZWN0aW9uIHdpbGwgYmUgcGFydCBvZiB0aGUga2VybmVsIGltYWdlLCBz
byBrZXhlYyB3aWxsIGFjY291bnQgZm9yIGl0DQppbiBwYWdldGFibGUgbWFwcGluZ3MgYW5kIHBs
YWNlbWVudCBvZiBkYXRhIGFmdGVyIHRoZSBrZXJuZWwuDQoNCkhlcmUncyBhbiBleGFtcGxlIG9m
IGEga2VybmVsIHNpemUgd2l0aG91dCBhbmQgd2l0aCB0aGUgU01FIHNlY3Rpb246DQoJd2l0aG91
dDoNCgkJdm1saW51eDoJMzYsNTAxLDYxNg0KCQliekltYWdlOgkgNiw0OTcsMzQ0DQoNCgkJMTAw
MDAwMDAwLTQ3ZjM3ZmZmZiA6IFN5c3RlbSBSQU0NCgkJICAxZTQwMDAwMDAtMWU0NzY3N2Q0IDog
S2VybmVsIGNvZGUJKDB4NzY3N2Q0KQ0KCQkgIDFlNDc2NzdkNS0xZTRlMmUwYmYgOiBLZXJuZWwg
ZGF0YQkoMHg2YzY4ZWEpDQoJCSAgMWU1MDc0MDAwLTFlNTM3MmZmZiA6IEtlcm5lbCBic3MJKDB4
MmZlZmZmKQ0KDQoJd2l0aDoNCgkJdm1saW51eDoJNDQsNDE5LDQwOA0KCQliekltYWdlOgkgNiw1
MDMsMTM2DQoNCgkJODgwMDAwMDAwLWM3ZmY3ZmZmZiA6IFN5c3RlbSBSQU0NCgkJICA4Y2YwMDAw
MDAtOGNmNzY3N2Q0IDogS2VybmVsIGNvZGUJKDB4NzY3N2Q0KQ0KCQkgIDhjZjc2NzdkNS04Y2Zl
MmUwYmYgOiBLZXJuZWwgZGF0YQkoMHg2YzY4ZWEpDQoJCSAgOGQwMDc0MDAwLThkMDM3MmZmZiA6
IEtlcm5lbCBic3MJKDB4MmZlZmZmKQ0KDQpDYzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+
DQpDYzogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBU
b20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYva2Vy
bmVsL3ZtbGludXgubGRzLlMgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KIGFy
Y2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMgfCAyMiArKysrKysrKysrKysrKysrKysr
Ky0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgYi9hcmNoL3g4Ni9r
ZXJuZWwvdm1saW51eC5sZHMuUw0KaW5kZXggY2EyMjUyY2E2YWQ3Li5hN2FhNjViNDRjNzEgMTAw
NjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUw0KKysrIGIvYXJjaC94ODYv
a2VybmVsL3ZtbGludXgubGRzLlMNCkBAIC0zODcsNiArMzg3LDMwIEBAIFNFQ1RJT05TDQogCS4g
PSBBTElHTihQQUdFX1NJWkUpOwkJLyoga2VlcCBWT19JTklUX1NJWkUgcGFnZSBhbGlnbmVkICov
DQogCV9lbmQgPSAuOw0KIA0KKyNpZmRlZiBDT05GSUdfQU1EX01FTV9FTkNSWVBUDQorCS8qDQor
CSAqIFNNRSB3b3JrYXJlYSBzZWN0aW9uOiBMaXZlcyBvdXRzaWRlIG9mIHRoZSBrZXJuZWwgcHJv
cGVyIChfdGV4dCAtDQorCSAqIF9lbmQpIGZvciBwZXJmb3JtaW5nIGluLXBsYWNlIGVuY3J5cHRp
b24gb2YgdGhlIGtlcm5lbCBkdXJpbmcgYm9vdC4NCisJICoNCisJICogUmVzaWRlcyBhZnRlciBf
ZW5kIGJlY2F1c2UgZXZlbiB0aG91Z2ggdGhlIC5icmsgc2VjdGlvbiBpcyBhZnRlcg0KKwkgKiBf
X2VuZF9vZl9rZXJuZWxfcmVzZXJ2ZSwgdGhlIC5icmsgc2VjdGlvbiBpcyBsYXRlciByZXNlcnZl
ZCBhcyBhDQorCSAqIHBhcnQgb2YgdGhlIGtlcm5lbC4gSXQgaXMgdXNlZCBpbiB2ZXJ5IGVhcmx5
IGJvb3QgY29kZSBhbmQgbm90DQorCSAqIG5lZWRlZCBhZnRlciB0aGF0LCBzbyBpdCBpcyBsb2Nh
dGVkIGFmdGVyIF9fZW5kX29mX2tlcm5lbF9yZXNlcnZlDQorCSAqIHNvIHRoYXQgaXQgd2lsbCBi
ZSBkaXNjYXJkZWQgYW5kIGJlY29tZSBwYXJ0IG9mIHRoZSBhdmFpbGFibGUNCisJICogbWVtb3J5
Lg0KKwkgKg0KKwkgKiBSZXNpZGVzIG9uIGEgMk1CIGJvdW5kYXJ5IHRvIHNpbXBsaWZ5IHRoZSBw
YWdldGFibGUgc2V0dXAgdXNlZCBmb3INCisJICogdGhlIGVuY3J5cHRpb24uDQorCSAqLw0KKwku
ID0gQUxJR04oSFBBR0VfU0laRSk7DQorCS5zbWUgOiBBVChBRERSKC5zbWUpIC0gTE9BRF9PRkZT
RVQpIHsNCisJCV9fc21lX2JlZ2luID0gLjsNCisJCSooLnNtZSkNCisJCS4gPSBBTElHTihIUEFH
RV9TSVpFKTsNCisJCV9fc21lX2VuZCA9IC47DQorCX0NCisjZW5kaWYNCisNCiAJU1RBQlNfREVC
VUcNCiAJRFdBUkZfREVCVUcNCiANCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlw
dF9pZGVudGl0eS5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYw0KaW5kZXgg
NGFhOWIxNDgwODY2Li5jNTVjMmVjOGZiMTIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9tbS9tZW1f
ZW5jcnlwdF9pZGVudGl0eS5jDQorKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0
eS5jDQpAQCAtNzMsNiArNzMsMTkgQEAgc3RydWN0IHNtZV9wb3B1bGF0ZV9wZ2RfZGF0YSB7DQog
CXVuc2lnbmVkIGxvbmcgdmFkZHJfZW5kOw0KIH07DQogDQorLyoNCisgKiBUaGlzIHdvcmsgYXJl
YSBsaXZlcyBpbiB0aGUgLnNtZSBzZWN0aW9uLCB3aGljaCBsaXZlcyBvdXRzaWRlIG9mDQorICog
dGhlIGtlcm5lbCBwcm9wZXIuIEl0IGlzIHNpemVkIHRvIGhvbGQgdGhlIGludGVybWVkaWF0ZSBj
b3B5IGJ1ZmZlcg0KKyAqIGFuZCBtb3JlIHRoYW4gZW5vdWdoIHBhZ2V0YWJsZSBwYWdlcy4NCisg
Kg0KKyAqIEJ5IHVzaW5nIHRoaXMgc2VjdGlvbiwgdGhlIGtlcm5lbCBjYW4gYmUgZW5jcnlwdGVk
IGluIHBsYWNlIGFuZCB3ZQ0KKyAqIGF2b2lkIGFueSBwb3NzaWJpbGl0eSBvZiBib290IHBhcmFt
ZXRlcnMgb3IgaW5pdHJhbWZzIGltYWdlcyBiZWluZw0KKyAqIHBsYWNlZCBzdWNoIHRoYXQgdGhl
IGluLXBsYWNlIGVuY3J5cHRpb24gbG9naWMgb3ZlcndyaXRlcyB0aGVtLiAgVGhpcw0KKyAqIHNl
Y3Rpb24gaXMgMk1CIGFsaWduZWQgdG8gYWxsb3cgZm9yIHNpbXBsZSBwYWdldGFibGUgc2V0dXAg
dXNpbmcgb25seQ0KKyAqIFBNRCBlbnRyaWVzIChzZWUgdm1saW51eC5sZHMuUykuDQorICovDQor
c3RhdGljIGNoYXIgc21lX3dvcmthcmVhWzIgKiBQTURfUEFHRV9TSVpFXSBfX3NlY3Rpb24oLnNt
ZSk7DQorDQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfYXJnW10gX19pbml0ZGF0YSA9ICJtZW1f
ZW5jcnlwdCI7DQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfb25bXSAgX19pbml0ZGF0YSA9ICJv
biI7DQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfb2ZmW10gX19pbml0ZGF0YSA9ICJvZmYiOw0K
QEAgLTMxNCw4ICszMjcsMTMgQEAgdm9pZCBfX2luaXQgc21lX2VuY3J5cHRfa2VybmVsKHN0cnVj
dCBib290X3BhcmFtcyAqYnApDQogCX0NCiAjZW5kaWYNCiANCi0JLyogU2V0IHRoZSBlbmNyeXB0
aW9uIHdvcmthcmVhIHRvIGJlIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBrZXJuZWwgKi8NCi0Jd29y
a2FyZWFfc3RhcnQgPSBrZXJuZWxfZW5kOw0KKwkvKg0KKwkgKiBXZSdyZSBydW5uaW5nIGlkZW50
aXR5IG1hcHBlZCwgc28gd2UgbXVzdCBvYnRhaW4gdGhlIGFkZHJlc3MgdG8gdGhlDQorCSAqIFNN
RSBlbmNyeXB0aW9uIHdvcmthcmVhIHVzaW5nIHJpcC1yZWxhdGl2ZSBhZGRyZXNzaW5nLg0KKwkg
Ki8NCisJYXNtICgibGVhIHNtZV93b3JrYXJlYSglJXJpcCksICUwIg0KKwkgICAgIDogIj1yIiAo
d29ya2FyZWFfc3RhcnQpDQorCSAgICAgOiAicCIgKHNtZV93b3JrYXJlYSkpOw0KIA0KIAkvKg0K
IAkgKiBDYWxjdWxhdGUgcmVxdWlyZWQgbnVtYmVyIG9mIHdvcmthcmVhIGJ5dGVzIG5lZWRlZDoN
Ci0tIA0KMi4xNy4xDQoNCg==
