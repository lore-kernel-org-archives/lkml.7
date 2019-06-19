Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B6C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5415214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tod2TCZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfFSSlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:41:04 -0400
Received: from mail-eopbgr780042.outbound.protection.outlook.com ([40.107.78.42]:21728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730029AbfFSSlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmTYR7+1lC51ayTwTjFdf8Nf6P1Fh/610uZ5+f2EmmY=;
 b=tod2TCZ+xjMSHGBoO97sn9e2mXENfah10/VncK/4KXUwrEdRcMgmkKDf+XuYf4UegAiTR6sWO7aBu5dXs4OI6kJbwQQ4GGF7AYVTFamnQAwbx4B9rtPjCQarzc6qWftQWJDNtQXbWGV5X6ZkUnTgVhs8zoZvt3gXpCGrmAtyn0E=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3961.namprd12.prod.outlook.com (10.255.174.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 18:41:01 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 18:41:00 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/2] x86/mm: Create a workarea in the kernel for SME early
 encryption
Thread-Topic: [PATCH v3 2/2] x86/mm: Create a workarea in the kernel for SME
 early encryption
Thread-Index: AQHVJs6JBj3917IVD0i3CrtO2X4SYA==
Date:   Wed, 19 Jun 2019 18:40:59 +0000
Message-ID: <3c483262eb4077b1654b2052bd14a8d011bffde3.1560969363.git.thomas.lendacky@amd.com>
References: <cover.1560969363.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1560969363.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: DM5PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:4:15::25) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5f1204d-c6a0-4973-fa03-08d6f4e5abe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3961;
x-ms-traffictypediagnostic: DM6PR12MB3961:
x-microsoft-antispam-prvs: <DM6PR12MB3961E95A5F0B6983C5A4160BECE50@DM6PR12MB3961.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(199004)(14444005)(66066001)(68736007)(2616005)(71190400001)(478600001)(3846002)(6116002)(72206003)(5660300002)(71200400001)(86362001)(486006)(4326008)(7736002)(446003)(476003)(6506007)(54906003)(386003)(102836004)(2906002)(76176011)(118296001)(66556008)(6436002)(186003)(53936002)(66476007)(26005)(50226002)(64756008)(66946007)(11346002)(7416002)(305945005)(14454004)(110136005)(8936002)(66446008)(73956011)(25786009)(36756003)(81156014)(2501003)(6486002)(6512007)(8676002)(81166006)(256004)(316002)(52116002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3961;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /QPVzqDh5RfCnPQ8XHCZFUStFxvfcfjeETQbCulwCbT530DxzGmgcQL9UgP6QxiGMPLVcOoxr3Zqz9UwZwUnii/S99YOvf+J3PLw8Rq59rbCFXFQqHg4CbMIPNRdBG3iOHKmXRIG4ye2gSUV1tsqrocCSIu8zz6xwG7lOpa6d3xFY3kzsVfsMm7goszozvmodtSCItI3kEMFcM4il/0y+NE51TDM8D1S9SuYIFDdvi3756i2okXtnzBAc99GvAWyZtCJMXwrLpHP4Ct4jgkZPb26FViMsVZLwbHc6G2nLrM85sHkG+45ErtFR1g2oB/Kgk65Dywzpv2ZXQAFOrDzg/2GZ42LHkPf5TsYx0ODfCqydnRY3WYCiYbqlfqgmglFQd0iCHr7RaLk7g912MjfSolgAiFES2AEjksngQ4rzzg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f1204d-c6a0-4973-fa03-08d6f4e5abe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 18:41:00.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3961
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
IEtlcm5lbCBic3MJKDB4MmZlZmZmKQ0KDQpUZXN0ZWQtYnk6IExpYW5ibyBKaWFuZyA8bGlqaWFu
Z0ByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0K
UmV2aWV3ZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJj
aC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysr
KysrKysNCiBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jIHwgMjIgKysrKysrKysr
KysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIv
YXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMNCmluZGV4IGNhMjI1MmNhNmFkNy4uMTQ3Y2Qw
MjA1MTZhIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMNCisrKyBi
L2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TDQpAQCAtMzg3LDYgKzM4NywzMSBAQCBTRUNU
SU9OUw0KIAkuID0gQUxJR04oUEFHRV9TSVpFKTsJCS8qIGtlZXAgVk9fSU5JVF9TSVpFIHBhZ2Ug
YWxpZ25lZCAqLw0KIAlfZW5kID0gLjsNCiANCisjaWZkZWYgQ09ORklHX0FNRF9NRU1fRU5DUllQ
VA0KKwkvKg0KKwkgKiBFYXJseSBzY3JhdGNoL3dvcmthcmVhIHNlY3Rpb246IExpdmVzIG91dHNp
ZGUgb2YgdGhlIGtlcm5lbCBwcm9wZXINCisJICogKF90ZXh0IC0gX2VuZCkuDQorCSAqDQorCSAq
IFJlc2lkZXMgYWZ0ZXIgX2VuZCBiZWNhdXNlIGV2ZW4gdGhvdWdoIHRoZSAuYnJrIHNlY3Rpb24g
aXMgYWZ0ZXINCisJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUsIHRoZSAuYnJrIHNlY3Rpb24g
aXMgbGF0ZXIgcmVzZXJ2ZWQgYXMgYQ0KKwkgKiBwYXJ0IG9mIHRoZSBrZXJuZWwuIFNpbmNlIGl0
IGlzIGxvY2F0ZWQgYWZ0ZXIgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUNCisJICogaXQgd2lsbCBi
ZSBkaXNjYXJkZWQgYW5kIGJlY29tZSBwYXJ0IG9mIHRoZSBhdmFpbGFibGUgbWVtb3J5LiBBcw0K
KwkgKiBzdWNoLCBpdCBjYW4gb25seSBiZSB1c2VkIGJ5IHZlcnkgZWFybHkgYm9vdCBjb2RlIGFu
ZCBtdXN0IG5vdCBiZQ0KKwkgKiBuZWVkZWQgYWZ0ZXJ3YXJkcy4NCisJICoNCisJICogQ3VycmVu
dGx5IHVzZWQgYnkgU01FIGZvciBwZXJmb3JtaW5nIGluLXBsYWNlIGVuY3J5cHRpb24gb2YgdGhl
DQorCSAqIGtlcm5lbCBkdXJpbmcgYm9vdC4gUmVzaWRlcyBvbiBhIDJNQiBib3VuZGFyeSB0byBz
aW1wbGlmeSB0aGUNCisJICogcGFnZXRhYmxlIHNldHVwIHVzZWQgZm9yIFNNRSBpbi1wbGFjZSBl
bmNyeXB0aW9uLg0KKwkgKi8NCisJLiA9IEFMSUdOKEhQQUdFX1NJWkUpOw0KKwkuaW5pdC5zY3Jh
dGNoIDogQVQoQUREUiguaW5pdC5zY3JhdGNoKSAtIExPQURfT0ZGU0VUKSB7DQorCQlfX2luaXRf
c2NyYXRjaF9iZWdpbiA9IC47DQorCQkqKC5pbml0LnNjcmF0Y2gpDQorCQkuID0gQUxJR04oSFBB
R0VfU0laRSk7DQorCQlfX2luaXRfc2NyYXRjaF9lbmQgPSAuOw0KKwl9DQorI2VuZGlmDQorDQog
CVNUQUJTX0RFQlVHDQogCURXQVJGX0RFQlVHDQogDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0v
bWVtX2VuY3J5cHRfaWRlbnRpdHkuYyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5
LmMNCmluZGV4IDRhYTliMTQ4MDg2Ni4uNmE4ZGQ0ODNmN2Q5IDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYw0KKysrIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5
cHRfaWRlbnRpdHkuYw0KQEAgLTczLDYgKzczLDE5IEBAIHN0cnVjdCBzbWVfcG9wdWxhdGVfcGdk
X2RhdGEgew0KIAl1bnNpZ25lZCBsb25nIHZhZGRyX2VuZDsNCiB9Ow0KIA0KKy8qDQorICogVGhp
cyB3b3JrIGFyZWEgbGl2ZXMgaW4gdGhlIC5pbml0LnNjcmF0Y2ggc2VjdGlvbiwgd2hpY2ggbGl2
ZXMgb3V0c2lkZSBvZg0KKyAqIHRoZSBrZXJuZWwgcHJvcGVyLiBJdCBpcyBzaXplZCB0byBob2xk
IHRoZSBpbnRlcm1lZGlhdGUgY29weSBidWZmZXIgYW5kDQorICogbW9yZSB0aGFuIGVub3VnaCBw
YWdldGFibGUgcGFnZXMuDQorICoNCisgKiBCeSB1c2luZyB0aGlzIHNlY3Rpb24sIHRoZSBrZXJu
ZWwgY2FuIGJlIGVuY3J5cHRlZCBpbiBwbGFjZSBhbmQgaXQNCisgKiBhdm9pZHMgYW55IHBvc3Np
YmlsaXR5IG9mIGJvb3QgcGFyYW1ldGVycyBvciBpbml0cmFtZnMgaW1hZ2VzIGJlaW5nDQorICog
cGxhY2VkIHN1Y2ggdGhhdCB0aGUgaW4tcGxhY2UgZW5jcnlwdGlvbiBsb2dpYyBvdmVyd3JpdGVz
IHRoZW0uICBUaGlzDQorICogc2VjdGlvbiBpcyAyTUIgYWxpZ25lZCB0byBhbGxvdyBmb3Igc2lt
cGxlIHBhZ2V0YWJsZSBzZXR1cCB1c2luZyBvbmx5DQorICogUE1EIGVudHJpZXMgKHNlZSB2bWxp
bnV4Lmxkcy5TKS4NCisgKi8NCitzdGF0aWMgY2hhciBzbWVfd29ya2FyZWFbMiAqIFBNRF9QQUdF
X1NJWkVdIF9fc2VjdGlvbiguaW5pdC5zY3JhdGNoKTsNCisNCiBzdGF0aWMgY2hhciBzbWVfY21k
bGluZV9hcmdbXSBfX2luaXRkYXRhID0gIm1lbV9lbmNyeXB0IjsNCiBzdGF0aWMgY2hhciBzbWVf
Y21kbGluZV9vbltdICBfX2luaXRkYXRhID0gIm9uIjsNCiBzdGF0aWMgY2hhciBzbWVfY21kbGlu
ZV9vZmZbXSBfX2luaXRkYXRhID0gIm9mZiI7DQpAQCAtMzE0LDggKzMyNywxMyBAQCB2b2lkIF9f
aW5pdCBzbWVfZW5jcnlwdF9rZXJuZWwoc3RydWN0IGJvb3RfcGFyYW1zICpicCkNCiAJfQ0KICNl
bmRpZg0KIA0KLQkvKiBTZXQgdGhlIGVuY3J5cHRpb24gd29ya2FyZWEgdG8gYmUgaW1tZWRpYXRl
bHkgYWZ0ZXIgdGhlIGtlcm5lbCAqLw0KLQl3b3JrYXJlYV9zdGFydCA9IGtlcm5lbF9lbmQ7DQor
CS8qDQorCSAqIFdlJ3JlIHJ1bm5pbmcgaWRlbnRpdHkgbWFwcGVkLCBzbyB3ZSBtdXN0IG9idGFp
biB0aGUgYWRkcmVzcyB0byB0aGUNCisJICogU01FIGVuY3J5cHRpb24gd29ya2FyZWEgdXNpbmcg
cmlwLXJlbGF0aXZlIGFkZHJlc3NpbmcuDQorCSAqLw0KKwlhc20gKCJsZWEgc21lX3dvcmthcmVh
KCUlcmlwKSwgJTAiDQorCSAgICAgOiAiPXIiICh3b3JrYXJlYV9zdGFydCkNCisJICAgICA6ICJw
IiAoc21lX3dvcmthcmVhKSk7DQogDQogCS8qDQogCSAqIENhbGN1bGF0ZSByZXF1aXJlZCBudW1i
ZXIgb2Ygd29ya2FyZWEgYnl0ZXMgbmVlZGVkOg0KLS0gDQoyLjE3LjENCg0K
