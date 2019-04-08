Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D052520879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uq3JOd1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDHTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:11:25 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:23040
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfDHTLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDG+Pc08UbPvEsWxpd63p7S2FUmISiwnOiYREtbken4=;
 b=uq3JOd1vVtL7EL5XzzJRUFkgulqsbV8Dk1Hy6hduHOcKjxac7/3g1CVDf1y4a18PF6vc3n2Htpg3XLvsbzczXWHcAH5MrfJEUtTdsvqcrFHb/Jhmmfe+ehKc5N3jyOG0c0gVufaFC38VeSJKMgm69nQm5tiCf5Cmc69WA/oVRtw=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3114.namprd12.prod.outlook.com (20.178.31.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 19:11:21 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 19:11:21 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting the
 large page
Thread-Topic: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Index: AQHU7j7arjEUvuxvBUmbKwd7TTUF0A==
Date:   Mon, 8 Apr 2019 19:11:21 +0000
Message-ID: <20190408191103.13501-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:805:3e::28) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90418c2-e46a-4825-eeba-08d6bc55fc65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3114;
x-ms-traffictypediagnostic: DM6PR12MB3114:
x-microsoft-antispam-prvs: <DM6PR12MB31141AA75578191D991F1253E52C0@DM6PR12MB3114.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(486006)(86362001)(4326008)(26005)(7736002)(305945005)(6486002)(36756003)(2501003)(25786009)(7416002)(2906002)(6506007)(81166006)(99286004)(386003)(5660300002)(478600001)(102836004)(52116002)(6512007)(71190400001)(53936002)(71200400001)(81156014)(14454004)(6436002)(68736007)(8676002)(14444005)(256004)(97736004)(1076003)(106356001)(110136005)(54906003)(186003)(6116002)(316002)(2616005)(105586002)(66066001)(8936002)(476003)(50226002)(3846002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3114;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m356sCPDzwn8cn/az0nVcHH7WKQft63+/sMLc6v7AXs1BtM8gdIPQXw7nP/8HkF00e6J1bfUyFUlJCVFbhO0cRHzw2cpvTl27azbjlDUrQAE1oRZpC7HPfk21Ha0q6yDksw8KneCW9WX08DgNz50hR6w8eQW0tXgY9xCYxGh6JrQmuV7DmbrOGGe7Q5AcOI3G2FdFnLxTxz7YBTeZQuNXBP5PpkaZTp3A0TljMu+d9ze7esHmf13kZw0lN9CE/Y0FqfrTrxh9lkJ+rkAv6VuiRExJRVcXnTI2otUX+XifK9rJnp9CbApcxUsn7m21QnxqDtolh1C/D/38t5oBYAkSbEar+azO8H5AxCeSqB/JD7ht4ch9uu8RHjiSIsmqI9rCpF61yYXm/Zjo7D8ue3UKv0La70Y1ITDwRW++0VQoRw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90418c2-e46a-4825-eeba-08d6bc55fc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 19:11:21.6667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBjb21taXQgMGE5ZmU4Y2E4NDRkICgieDg2L21tOiBWYWxpZGF0ZSBrZXJu
ZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KCkNClBURSBwb3B1bGF0aW9uIikgdHJpZ2dlcnMgdGhl
IGJlbG93IHdhcm5pbmcgaW4gdGhlIFNFViBndWVzdC4NCg0KV0FSTklORzogQ1BVOiAwIFBJRDog
MCBhdCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ2FsbG9jLmg6ODcgcGh5c19wbWRfaW5pdCsweDMw
ZC8weDM4Ng0KQ2FsbCBUcmFjZToNCiBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KzB4Y2Uv
MHgyNTkNCiBlYXJseV9zZXRfbWVtb3J5X2VuY19kZWMrMHgxMGYvMHgxNjANCiBrdm1fc21wX3By
ZXBhcmVfYm9vdF9jcHUrMHg3MS8weDlkDQogc3RhcnRfa2VybmVsKzB4MWM5LzB4NTBiDQogc2Vj
b25kYXJ5X3N0YXJ0dXBfNjQrMHhhNC8weGIwDQoNClRoZSBTRVYgZ3Vlc3QgY2FsbHMga2VybmVs
X3BoeXNpY2FsX21hcHBpbmdfaW5pdCgpIHRvIGNsZWFyIHRoZSBlbmNyeXB0aW9uDQptYXNrIGZy
b20gYW4gZXhpc3RpbmcgbWFwcGluZy4gV2hpbGUgY2xlYXJpbmcgdGhlIGVuY3J5cHRpb24gbWFz
aw0Ka2VybmVsX3BoeXNpY2FsX21hcHBpbmdfaW5pdCgpIHNwbGl0cyB0aGUgbGFyZ2UgcGFnZXMg
aW50byB0aGUgc21hbGxlci4NClRvIHNwbGl0IHRoZSBwYWdlLCB0aGUga2VybmVsX3BoeXNpY2Fs
X21hcHBpbmdfaW5pdCgpIGFsbG9jYXRlcyBhIG5ldyBwYWdlDQphbmQgdXBkYXRlcyB0aGUgZXhp
c3RpbmcgZW50cnkuIFRoZSBzZXRfe3B1ZCxwbWR9X3NhZmUgdHJpZ2dlcnMgd2FybmluZw0Kd2hl
biB1cGRhdGluZyB0aGUgZW50cnkgd2l0aCBwYWdlIGluIHRoZSBwcmVzZW50IHN0YXRlLiBXZSBz
aG91bGQgdXNlIHRoZQ0Kc2V0X3twdWQscG1kfSB3aGVuIHVwZGF0aW5nIGFuIGV4aXN0aW5nIGVu
dHJ5IHdpdGggdGhlIG5ldyBlbnRyeS4NCg0KVXBkYXRpbmcgYW4gZW50cnkgd2lsbCBhbHNvIHJl
cXVpcmVzIGEgVExCIGZsdXNoLiBDdXJyZW50bHkgdGhlIGNhbGxlcg0KKGVhcmx5X3NldF9tZW1v
cnlfZW5jX2RlYygpKSBpcyB0YWtpbmcgY2FyZSBvZiBpc3N1aW5nIHRoZSBUTEIgZmx1c2hlcy4N
Cg0KU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0K
Rml4ZXM6IDBhOWZlOGNhODQ0ZCAoeDg2L21tOiBWYWxpZGF0ZSBrZXJuZWxfcGh5c2ljYWxfbWFw
cGluZ19pbml0KCkgLi4uKQ0KQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9y
Zz4NCkNjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KQ2M6IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KQ2M6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8
a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCkNjOiBQZXRlciBaaWpsc3RyYSAoSW50
ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4NCkNjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCkNjOiBILiBQZXRl
ciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT4NCkNjOiBUb20gTGVuZGFja3kgPFRob21hcy5MZW5kYWNreUBhbWQuY29tPg0KLS0t
DQogYXJjaC94ODYvbW0vaW5pdF82NC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2lu
aXRfNjQuYyBiL2FyY2gveDg2L21tL2luaXRfNjQuYw0KaW5kZXggYmNjZmY2OGUzMjY3Li4wYTI2
YjY0YTk5YjkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9tbS9pbml0XzY0LmMNCisrKyBiL2FyY2gv
eDg2L21tL2luaXRfNjQuYw0KQEAgLTUzNiw3ICs1MzYsNyBAQCBwaHlzX3BtZF9pbml0KHBtZF90
ICpwbWRfcGFnZSwgdW5zaWduZWQgbG9uZyBwYWRkciwgdW5zaWduZWQgbG9uZyBwYWRkcl9lbmQs
DQogCQlwYWRkcl9sYXN0ID0gcGh5c19wdGVfaW5pdChwdGUsIHBhZGRyLCBwYWRkcl9lbmQsIG5l
d19wcm90KTsNCiANCiAJCXNwaW5fbG9jaygmaW5pdF9tbS5wYWdlX3RhYmxlX2xvY2spOw0KLQkJ
cG1kX3BvcHVsYXRlX2tlcm5lbF9zYWZlKCZpbml0X21tLCBwbWQsIHB0ZSk7DQorCQlwbWRfcG9w
dWxhdGVfa2VybmVsKCZpbml0X21tLCBwbWQsIHB0ZSk7DQogCQlzcGluX3VubG9jaygmaW5pdF9t
bS5wYWdlX3RhYmxlX2xvY2spOw0KIAl9DQogCXVwZGF0ZV9wYWdlX2NvdW50KFBHX0xFVkVMXzJN
LCBwYWdlcyk7DQpAQCAtNjIzLDcgKzYyMyw3IEBAIHBoeXNfcHVkX2luaXQocHVkX3QgKnB1ZF9w
YWdlLCB1bnNpZ25lZCBsb25nIHBhZGRyLCB1bnNpZ25lZCBsb25nIHBhZGRyX2VuZCwNCiAJCQkJ
CSAgIHBhZ2Vfc2l6ZV9tYXNrLCBwcm90KTsNCiANCiAJCXNwaW5fbG9jaygmaW5pdF9tbS5wYWdl
X3RhYmxlX2xvY2spOw0KLQkJcHVkX3BvcHVsYXRlX3NhZmUoJmluaXRfbW0sIHB1ZCwgcG1kKTsN
CisJCXB1ZF9wb3B1bGF0ZSgmaW5pdF9tbSwgcHVkLCBwbWQpOw0KIAkJc3Bpbl91bmxvY2soJmlu
aXRfbW0ucGFnZV90YWJsZV9sb2NrKTsNCiAJfQ0KIA0KLS0gDQoyLjE3LjENCg0K
