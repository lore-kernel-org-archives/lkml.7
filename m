Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E6C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC9206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qic8k++m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfFSSlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:41:40 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:44149
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfFSSlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brOq88wRe9/B8N8MgVQvMhUdBKE/310vcjZI5iMKWvg=;
 b=Qic8k++mzLaeSp19dxg0Ygz5kAf655oOCTLDpa7cg9uKnoh6+c5azvpwu2iQfrFs3P4Zf3u3OEtiuFre85fJ1OTO7g/jybXvY2uIy3cIg+GkL07u6DvrQ0WzjbNoRj6VjtA3MGJuE6foLhZolpfqDclAvJTf3BNSi4busu3nKxc=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 18:40:58 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 18:40:58 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Topic: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Index: AQHVJs6IFoBxSDUkSE2s22ASPkl26Q==
Date:   Wed, 19 Jun 2019 18:40:57 +0000
Message-ID: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
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
x-ms-office365-filtering-correlation-id: 42cf5072-a613-4912-7f22-08d6f4e5aa91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274791248DA399364670860ECE50@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(66556008)(118296001)(2906002)(53936002)(99286004)(3846002)(52116002)(6116002)(386003)(6506007)(2501003)(68736007)(66946007)(76176011)(73956011)(66476007)(64756008)(81156014)(478600001)(8676002)(81166006)(72206003)(8936002)(86362001)(50226002)(66066001)(25786009)(4326008)(14454004)(6486002)(66446008)(6436002)(7736002)(36756003)(305945005)(102836004)(5660300002)(6512007)(256004)(476003)(486006)(2616005)(11346002)(54906003)(110136005)(316002)(186003)(71190400001)(71200400001)(446003)(26005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mbheTclXD4BvkEW3oddNcq7ST5HhzBcy7uadzq0wTauKNoRWrNnPg1lFm4XH2px1pGdLiGypHLJ5VSJ1zx5TfplA9HaqZXyI+mjVlezNM8hCbXRv8WPPGzkKD1aHoOCUJHq7GKmcs9iuH1VVzGMfyUnSYBvCrR868xOVucEfFL10ZGzZA35jVLfkU8HUqi3N4sd5Kw5Fym4GodMkopw+13saqDFh5A1pZEBYEJ+PjAzq12n9kA3jRy/tw+RFjGKYBMfb8mGhLQ3IuThNT9sf8hjb6BGS0f54xgIsS8ISqQ0frsQAxrRNCAf/ktIBtqBfk8jy/YeOpXjBBl5DODN7Wcp6cQCaQOZoN1RHahuV1BYoQ4due0xtqy0PsgucykJNV/7RitTcX98uiGoTKJsdJwjNdEQYbNQ+WHmDw7NgQMs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cf5072-a613-4912-7f22-08d6f4e5aa91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 18:40:57.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1lbW9yeSBvY2N1cGllZCBieSB0aGUga2VybmVsIGlzIHJlc2VydmVkIHVzaW5nIG1lbWJs
b2NrX3Jlc2VydmUoKQ0KaW4gc2V0dXBfYXJjaCgpLiBDdXJyZW50bHksIHRoZSBhcmVhIGlzIGZy
b20gc3ltYm9scyBfdGV4dCB0byBfX2Jzc19zdG9wLg0KRXZlcnl0aGluZyBhZnRlciBfX2Jzc19z
dG9wIG11c3QgYmUgc3BlY2lmaWNhbGx5IHJlc2VydmVkIG90aGVyd2lzZSBpdA0KaXMgZGlzY2Fy
ZGVkLiBUaGlzIGlzIG5vdCBjbGVhcmx5IGRvY3VtZW50ZWQuDQoNCkFkZCBhIG5ldyBzeW1ib2ws
IF9fZW5kX29mX2tlcm5lbF9yZXNlcnZlLCB0aGF0IG1vcmUgcmVhZGlseSBpZGVudGlmaWVzDQp3
aGF0IGlzIHJlc2VydmVkLCBhbG9uZyB3aXRoIGNvbW1lbnRzIHRoYXQgaW5kaWNhdGUgd2hhdCBp
cyByZXNlcnZlZCwNCndoYXQgaXMgZGlzY2FyZGVkIGFuZCB3aGF0IG5lZWRzIHRvIGJlIGRvbmUg
dG8gcHJldmVudCBhIHNlY3Rpb24gZnJvbQ0KYmVpbmcgZGlzY2FyZGVkLg0KDQpUZXN0ZWQtYnk6
IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IEJhb3F1YW4g
SGUgPGJoZUByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNr
eUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vc2VjdGlvbnMuaCB8IDIgKysN
CiBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYyAgICAgICAgIHwgOCArKysrKysrLQ0KIGFyY2gveDg2
L2tlcm5lbC92bWxpbnV4Lmxkcy5TICAgfCA5ICsrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWN0aW9ucy5o
DQppbmRleCA4ZWExY2ZkYmVhYmMuLjcxYjMyZjI1NzBhYiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NlY3Rp
b25zLmgNCkBAIC0xMyw0ICsxMyw2IEBAIGV4dGVybiBjaGFyIF9fZW5kX3JvZGF0YV9hbGlnbmVk
W107DQogZXh0ZXJuIGNoYXIgX19lbmRfcm9kYXRhX2hwYWdlX2FsaWduW107DQogI2VuZGlmDQog
DQorZXh0ZXJuIGNoYXIgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmVbXTsNCisNCiAjZW5kaWYJLyog
X0FTTV9YODZfU0VDVElPTlNfSCAqLw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zZXR1
cC5jIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCmluZGV4IDA4YTVmNGExMzFmNS4uZmUwZjZl
YmVmZWI3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCisrKyBiL2FyY2gv
eDg2L2tlcm5lbC9zZXR1cC5jDQpAQCAtODI3LDggKzgyNywxNCBAQCBkdW1wX2tlcm5lbF9vZmZz
ZXQoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpzZWxmLCB1bnNpZ25lZCBsb25nIHYsIHZvaWQgKnAp
DQogDQogdm9pZCBfX2luaXQgc2V0dXBfYXJjaChjaGFyICoqY21kbGluZV9wKQ0KIHsNCisJLyoN
CisJICogUmVzZXJ2ZSB0aGUgbWVtb3J5IG9jY3VwaWVkIGJ5IHRoZSBrZXJuZWwgYmV0d2VlbiBf
dGV4dCBhbmQNCisJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9scy4gQW55IGtlcm5l
bCBzZWN0aW9ucyBhZnRlciB0aGUNCisJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9s
IG11c3QgYmUgZXhwbGljaXR5IHJlc2VydmVkIHdpdGggYQ0KKwkgKiBzZXBhcmF0ZSBtZW1ibG9j
a19yZXNlcnZlKCkgb3IgdGhleSB3aWxsIGJlIGRpc2NhcmRlZC4NCisJICovDQogCW1lbWJsb2Nr
X3Jlc2VydmUoX19wYV9zeW1ib2woX3RleHQpLA0KLQkJCSAodW5zaWduZWQgbG9uZylfX2Jzc19z
dG9wIC0gKHVuc2lnbmVkIGxvbmcpX3RleHQpOw0KKwkJCSAodW5zaWduZWQgbG9uZylfX2VuZF9v
Zl9rZXJuZWxfcmVzZXJ2ZSAtICh1bnNpZ25lZCBsb25nKV90ZXh0KTsNCiANCiAJLyoNCiAJICog
TWFrZSBzdXJlIHBhZ2UgMCBpcyBhbHdheXMgcmVzZXJ2ZWQgYmVjYXVzZSBvbiBzeXN0ZW1zIHdp
dGgNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUyBiL2FyY2gveDg2
L2tlcm5lbC92bWxpbnV4Lmxkcy5TDQppbmRleCAwODUwYjUxNDkzNDUuLmNhMjI1MmNhNmFkNyAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TDQorKysgYi9hcmNoL3g4
Ni9rZXJuZWwvdm1saW51eC5sZHMuUw0KQEAgLTM2OCw2ICszNjgsMTQgQEAgU0VDVElPTlMNCiAJ
CV9fYnNzX3N0b3AgPSAuOw0KIAl9DQogDQorCS8qDQorCSAqIFRoZSBtZW1vcnkgb2NjdXBpZWQg
ZnJvbSBfdGV4dCB0byBoZXJlLCBfX2VuZF9vZl9rZXJuZWxfcmVzZXJ2ZSwgaXMNCisJICogYXV0
b21hdGljYWxseSByZXNlcnZlZCBpbiBzZXR1cF9hcmNoKCkuIEFueXRoaW5nIGFmdGVyIGhlcmUg
bXVzdCBiZQ0KKwkgKiBleHBsaWNpdGx5IHJlc2VydmVkIHVzaW5nIG1lbWJsb2NrX3Jlc2VydmUo
KSBvciBpdCB3aWxsIGJlIGRpc2NhcmRlZA0KKwkgKiBhbmQgdHJlYXRlZCBhcyBhdmFpbGFibGUg
bWVtb3J5Lg0KKwkgKi8NCisJX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgPSAuOw0KKw0KIAkuID0g
QUxJR04oUEFHRV9TSVpFKTsNCiAJLmJyayA6IEFUKEFERFIoLmJyaykgLSBMT0FEX09GRlNFVCkg
ew0KIAkJX19icmtfYmFzZSA9IC47DQpAQCAtMzgyLDcgKzM5MCw2IEBAIFNFQ1RJT05TDQogCVNU
QUJTX0RFQlVHDQogCURXQVJGX0RFQlVHDQogDQotCS8qIFNlY3Rpb25zIHRvIGJlIGRpc2NhcmRl
ZCAqLw0KIAlESVNDQVJEUw0KIAkvRElTQ0FSRC8gOiB7DQogCQkqKC5laF9mcmFtZSkNCi0tIA0K
Mi4xNy4xDQoNCg==
