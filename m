Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C183C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6270F206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NCxEzde7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439373AbfFLNcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:32:32 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:27910
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbfFLNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SOFNSFj2twm4+B7LXL/o1af3auk7qxMHhBkVjNqjOU=;
 b=NCxEzde7pMas1K8RUiHQbRGXVmDBdym0PyqHDzNrsDZkNpfMYnrd3Tp25k8nJCCwEQUlM9Q4kLU9Rf8qK4BhVf3uPzsDcailR8b6dJCGlAGnZB+w+F3nWaYR5wOimQNhdmsr4i2smu74Fc93tIk5XDpvDxKkCCQ4TmuAETddNJ8=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3052.namprd12.prod.outlook.com (20.178.30.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Wed, 12 Jun 2019 13:32:24 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 13:32:24 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Topic: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
Thread-Index: AQHVISNEIgHKCEThME+IPHE9yhs80A==
Date:   Wed, 12 Jun 2019 13:32:23 +0000
Message-ID: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:805:16::25) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db8d44ef-78ba-4369-3ce7-08d6ef3a6729
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3052;
x-ms-traffictypediagnostic: DM6PR12MB3052:
x-microsoft-antispam-prvs: <DM6PR12MB305203BCD12C8706CA9CE174ECEC0@DM6PR12MB3052.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(71190400001)(14454004)(8676002)(5660300002)(86362001)(81156014)(2906002)(7416002)(25786009)(99286004)(6512007)(81166006)(50226002)(66066001)(186003)(54906003)(71200400001)(118296001)(478600001)(110136005)(486006)(476003)(2616005)(68736007)(4326008)(52116002)(8936002)(72206003)(316002)(36756003)(2501003)(305945005)(66556008)(26005)(6116002)(7736002)(14444005)(256004)(66446008)(66946007)(53936002)(64756008)(73956011)(6486002)(6506007)(102836004)(66476007)(6436002)(3846002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3052;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k92XB8TtTh3jKmYwHbAg7yw7Ic8sZUZFEqjMoOeuynHuCUsoRDPRgdqcRKhwdgYX+9ORxgJVIfqj5+zhZjhJioK8/HCnJcvWznV/9PWikD9L1GovOkfdva2yt5FVBiWVZmjk7evD+B32/YH9zZAu+VS4EdZeqyG46hr0rsyeA0FcyC2WRf0XW/6cYXqTfyw15cs9e6b2FRaAYRwHeRQLYvmq/JrPMHnlhKXInx5RsPmsPsGFhBP9ssKK6Rd1ylfSgtgL1aJwT81QTRoK0M1BzZa4bBbkId00ByadIk9g3egrb51xEx1Q7NBjYMisZ9FZdvxjKqF50EwwSPoMK0l0sJPMLxLc6sdlCfxkg1Q8mkBxjuERGawYC90PcqhB7k5awVkVrIMmW69oFhECyLiyZ2h23yETRzFc4soh/wVPhCs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8d44ef-78ba-4369-3ce7-08d6ef3a6729
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 13:32:23.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFNNRSB3b3JrYXJlYSB1c2VkIGR1cmluZyBlYXJseSBlbmNyeXB0aW9uIG9mIHRoZSBrZXJu
ZWwgZHVyaW5nIGJvb3QNCmlzIHNpdHVhdGVkIG9uIGEgMk1CIGJvdW5kYXJ5IGFmdGVyIHRoZSBl
bmQgb2YgdGhlIGtlcm5lbCB0ZXh0LCBkYXRhLA0KZXRjLiBzZWN0aW9ucyAoX2VuZCkuICBUaGlz
IHdvcmtzIHdlbGwgZHVyaW5nIGluaXRpYWwgYm9vdCBvZiBhIGNvbXByZXNzZWQNCmtlcm5lbCBi
ZWNhdXNlIG9mIHRoZSByZWxvY2F0aW9uIHVzZWQgZm9yIGRlY29tcHJlc3Npb24gb2YgdGhlIGtl
cm5lbC4NCkJ1dCB3aGVuIHBlcmZvcm1pbmcgYSBrZXhlYyBib290LCB0aGVyZSdzIGEgY2hhbmNl
IHRoYXQgdGhlIFNNRSB3b3JrYXJlYQ0KbWF5IG5vdCBiZSBtYXBwZWQgYnkgdGhlIGtleGVjIHBh
Z2V0YWJsZXMgb3IgdGhhdCBzb21lIG9mIHRoZSBvdGhlciBkYXRhDQp1c2VkIGJ5IGtleGVjIGNv
dWxkIGV4aXN0IGluIHRoaXMgcmFuZ2UuDQoNCkNyZWF0ZSBhIHNlY3Rpb24gZm9yIFNNRSBpbiB0
aGUgdm1saW51eC5sZHMuUy4gIFBvc2l0aW9uIGl0IGFmdGVyICJfZW5kIg0Kc28gdGhhdCB0aGUg
bWVtb3J5IHdpbGwgYmUgcmVjbGFpbWVkIGR1cmluZyBib290IGFuZCwgc2luY2UgaXQgaXMgYWxs
DQp6ZXJvZXMsIGl0IGNvbXByZXNzZXMgd2VsbC4gIFNpbmNlIHRoaXMgbmV3IHNlY3Rpb24gd2ls
bCBiZSBwYXJ0IG9mIHRoZQ0Ka2VybmVsLCBrZXhlYyB3aWxsIGFjY291bnQgZm9yIGl0IGluIHBh
Z2V0YWJsZSBtYXBwaW5ncyBhbmQgcGxhY2VtZW50IG9mDQpkYXRhIGFmdGVyIHRoZSBrZXJuZWwu
DQoNCkhlcmUncyBhbiBleGFtcGxlIG9mIGEga2VybmVsIHNpemUgd2l0aG91dCBhbmQgd2l0aCB0
aGUgU01FIHNlY3Rpb246DQoJd2l0aG91dDoNCgkJdm1saW51eDoJMzYsNTAxLDYxNg0KCQlieklt
YWdlOgkgNiw0OTcsMzQ0DQoNCgkJMTAwMDAwMDAwLTQ3ZjM3ZmZmZiA6IFN5c3RlbSBSQU0NCgkJ
ICAxZTQwMDAwMDAtMWU0NzY3N2Q0IDogS2VybmVsIGNvZGUJKDB4NzY3N2Q0KQ0KCQkgIDFlNDc2
NzdkNS0xZTRlMmUwYmYgOiBLZXJuZWwgZGF0YQkoMHg2YzY4ZWEpDQoJCSAgMWU1MDc0MDAwLTFl
NTM3MmZmZiA6IEtlcm5lbCBic3MJKDB4MmZlZmZmKQ0KDQoJd2l0aDoNCgkJdm1saW51eDoJNDQs
NDE5LDQwOA0KCQliekltYWdlOgkgNiw1MDMsMTM2DQoNCgkJODgwMDAwMDAwLWM3ZmY3ZmZmZiA6
IFN5c3RlbSBSQU0NCgkJICA4Y2YwMDAwMDAtOGNmNzY3N2Q0IDogS2VybmVsIGNvZGUJKDB4NzY3
N2Q0KQ0KCQkgIDhjZjc2NzdkNS04Y2ZlMmUwYmYgOiBLZXJuZWwgZGF0YQkoMHg2YzY4ZWEpDQoJ
CSAgOGQwMDc0MDAwLThkMDM3MmZmZiA6IEtlcm5lbCBic3MJKDB4MmZlZmZmKQ0KDQpDYzogQmFv
cXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQpDYzogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhh
dC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQu
Y29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgICAgICB8IDE2ICsrKysr
KysrKysrKysrKysNCiBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIHwgMjIgKysr
KysrKysrKysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxk
cy5TIGIvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMNCmluZGV4IDA4NTBiNTE0OTM0NS4u
OGM0Mzc3OTgzZTU0IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMN
CisrKyBiL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TDQpAQCAtMzc5LDYgKzM3OSwyMiBA
QCBTRUNUSU9OUw0KIAkuID0gQUxJR04oUEFHRV9TSVpFKTsJCS8qIGtlZXAgVk9fSU5JVF9TSVpF
IHBhZ2UgYWxpZ25lZCAqLw0KIAlfZW5kID0gLjsNCiANCisjaWZkZWYgQ09ORklHX0FNRF9NRU1f
RU5DUllQVA0KKwkvKg0KKwkgKiBTTUUgd29ya2FyZWEgc2VjdGlvbjogTGl2ZXMgb3V0c2lkZSBv
ZiB0aGUga2VybmVsIHByb3Blcg0KKwkgKiAoX3RleHQgLSBfZW5kKSBmb3IgcGVyZm9ybWluZyBp
bi1wbGFjZSBlbmNyeXB0aW9uLiBSZXNpZGVzDQorCSAqIG9uIGEgMk1CIGJvdW5kYXJ5IHRvIHNp
bXBsaWZ5IHRoZSBwYWdldGFibGUgc2V0dXAgdXNlZCBmb3INCisJICogdGhlIGVuY3J5cHRpb24u
DQorCSAqLw0KKwkuID0gQUxJR04oSFBBR0VfU0laRSk7DQorCS5zbWUgOiBBVChBRERSKC5zbWUp
IC0gTE9BRF9PRkZTRVQpIHsNCisJCV9fc21lX2JlZ2luID0gLjsNCisJCSooLnNtZSkNCisJCS4g
PSBBTElHTihIUEFHRV9TSVpFKTsNCisJCV9fc21lX2VuZCA9IC47DQorCX0NCisjZW5kaWYNCisN
CiAJU1RBQlNfREVCVUcNCiAJRFdBUkZfREVCVUcNCiANCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9t
bS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRp
dHkuYw0KaW5kZXggNGFhOWIxNDgwODY2Li5jNTVjMmVjOGZiMTIgMTAwNjQ0DQotLS0gYS9hcmNo
L3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jDQorKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5j
cnlwdF9pZGVudGl0eS5jDQpAQCAtNzMsNiArNzMsMTkgQEAgc3RydWN0IHNtZV9wb3B1bGF0ZV9w
Z2RfZGF0YSB7DQogCXVuc2lnbmVkIGxvbmcgdmFkZHJfZW5kOw0KIH07DQogDQorLyoNCisgKiBU
aGlzIHdvcmsgYXJlYSBsaXZlcyBpbiB0aGUgLnNtZSBzZWN0aW9uLCB3aGljaCBsaXZlcyBvdXRz
aWRlIG9mDQorICogdGhlIGtlcm5lbCBwcm9wZXIuIEl0IGlzIHNpemVkIHRvIGhvbGQgdGhlIGlu
dGVybWVkaWF0ZSBjb3B5IGJ1ZmZlcg0KKyAqIGFuZCBtb3JlIHRoYW4gZW5vdWdoIHBhZ2V0YWJs
ZSBwYWdlcy4NCisgKg0KKyAqIEJ5IHVzaW5nIHRoaXMgc2VjdGlvbiwgdGhlIGtlcm5lbCBjYW4g
YmUgZW5jcnlwdGVkIGluIHBsYWNlIGFuZCB3ZQ0KKyAqIGF2b2lkIGFueSBwb3NzaWJpbGl0eSBv
ZiBib290IHBhcmFtZXRlcnMgb3IgaW5pdHJhbWZzIGltYWdlcyBiZWluZw0KKyAqIHBsYWNlZCBz
dWNoIHRoYXQgdGhlIGluLXBsYWNlIGVuY3J5cHRpb24gbG9naWMgb3ZlcndyaXRlcyB0aGVtLiAg
VGhpcw0KKyAqIHNlY3Rpb24gaXMgMk1CIGFsaWduZWQgdG8gYWxsb3cgZm9yIHNpbXBsZSBwYWdl
dGFibGUgc2V0dXAgdXNpbmcgb25seQ0KKyAqIFBNRCBlbnRyaWVzIChzZWUgdm1saW51eC5sZHMu
UykuDQorICovDQorc3RhdGljIGNoYXIgc21lX3dvcmthcmVhWzIgKiBQTURfUEFHRV9TSVpFXSBf
X3NlY3Rpb24oLnNtZSk7DQorDQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfYXJnW10gX19pbml0
ZGF0YSA9ICJtZW1fZW5jcnlwdCI7DQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfb25bXSAgX19p
bml0ZGF0YSA9ICJvbiI7DQogc3RhdGljIGNoYXIgc21lX2NtZGxpbmVfb2ZmW10gX19pbml0ZGF0
YSA9ICJvZmYiOw0KQEAgLTMxNCw4ICszMjcsMTMgQEAgdm9pZCBfX2luaXQgc21lX2VuY3J5cHRf
a2VybmVsKHN0cnVjdCBib290X3BhcmFtcyAqYnApDQogCX0NCiAjZW5kaWYNCiANCi0JLyogU2V0
IHRoZSBlbmNyeXB0aW9uIHdvcmthcmVhIHRvIGJlIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBrZXJu
ZWwgKi8NCi0Jd29ya2FyZWFfc3RhcnQgPSBrZXJuZWxfZW5kOw0KKwkvKg0KKwkgKiBXZSdyZSBy
dW5uaW5nIGlkZW50aXR5IG1hcHBlZCwgc28gd2UgbXVzdCBvYnRhaW4gdGhlIGFkZHJlc3MgdG8g
dGhlDQorCSAqIFNNRSBlbmNyeXB0aW9uIHdvcmthcmVhIHVzaW5nIHJpcC1yZWxhdGl2ZSBhZGRy
ZXNzaW5nLg0KKwkgKi8NCisJYXNtICgibGVhIHNtZV93b3JrYXJlYSglJXJpcCksICUwIg0KKwkg
ICAgIDogIj1yIiAod29ya2FyZWFfc3RhcnQpDQorCSAgICAgOiAicCIgKHNtZV93b3JrYXJlYSkp
Ow0KIA0KIAkvKg0KIAkgKiBDYWxjdWxhdGUgcmVxdWlyZWQgbnVtYmVyIG9mIHdvcmthcmVhIGJ5
dGVzIG5lZWRlZDoNCi0tIA0KMi4xNy4xDQoNCg==
