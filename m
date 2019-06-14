Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769AC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BE2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pY6A1hP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfFNVPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:15:24 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:64064
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfFNVPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJd/Dfvok+t7dvOCfPUnaAJQbonbZEog2iDOiETz3us=;
 b=pY6A1hP9EjYwG3wrinm9I640nSCKUGM2xWSPagn0389nRG8NaCTKCeznypowxTZcX7jhkNfCPUZbKLGATufXCLcXDxCe1H/zLUN3Vm4IyfqWhhTgTZE5Vv+WgzJu+haNWXk8AwnROHC/jOK4UUTsZdszHFzVYuhvDtQm5mJtxkk=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3724.namprd12.prod.outlook.com (10.255.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 21:15:18 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 21:15:18 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Topic: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Index: AQHVIvZEz1ndLb3IT0abs+80RMkH5w==
Date:   Fri, 14 Jun 2019 21:15:18 +0000
Message-ID: <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
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
x-ms-office365-filtering-correlation-id: 9da8c45c-cfe1-445b-8e6b-08d6f10d66e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3724;
x-ms-traffictypediagnostic: DM6PR12MB3724:
x-microsoft-antispam-prvs: <DM6PR12MB372411314478533ACB1BA38BECEE0@DM6PR12MB3724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(446003)(66446008)(54906003)(71190400001)(71200400001)(110136005)(76176011)(3846002)(2906002)(7736002)(66946007)(53936002)(305945005)(52116002)(6116002)(66556008)(66476007)(73956011)(25786009)(256004)(36756003)(64756008)(102836004)(8676002)(81156014)(316002)(66066001)(6506007)(386003)(2616005)(186003)(6512007)(26005)(2501003)(81166006)(99286004)(6486002)(8936002)(486006)(476003)(68736007)(14454004)(86362001)(72206003)(478600001)(11346002)(5660300002)(7416002)(118296001)(50226002)(4326008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3724;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9V6ngpirUQ/xYB1uFUWQaWLbkr63gjbo4u/T7BNlBj0s0DbZD26iQN0345TX8yYBHFqnZ/9+rD0qz5b+6frwzdPFW3CewK/4GsZHE5itxscwiEDumjdaIvFiMfyoOI9+B59lhekyC206gqGkm07C7Xgizg+QC6g0+GemUjn4opT5FsNq0JL0c5Ds5btNICRPwzoJxvwJFCKV+q244iBWWBBu04UhCF0HGVgainvwFyW41/ME9o+ok4ToufquaTlA8q5RRBuz2oMCjmMNI5IvO8KnnptS/l38DVyvsQkoCN2tACtMezXNB8K+UXdPh1WK5mGS6ltKr5+Z86+NlioW7rnxZWQVCrBRClqU8eG/SrqAX5/t8CNh2hm27aeMZOsO98NlLiUBkGY84Vzs6Haehl8Bbzv0EDp5AF5b23fFuuU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da8c45c-cfe1-445b-8e6b-08d6f10d66e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 21:15:18.5877
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

VGhlIG1lbW9yeSBvY2N1cGllZCBieSB0aGUga2VybmVsIGlzIHJlc2VydmVkIHVzaW5nIG1lbWJs
b2NrX3Jlc2VydmUoKQ0KaW4gc2V0dXBfYXJjaCgpLiBDdXJyZW50bHksIHRoZSBhcmVhIGlzIGZy
b20gc3ltYm9scyBfdGV4dCB0byBfX2Jzc19zdG9wLg0KRXZlcnl0aGluZyBhZnRlciBfX2Jzc19z
dG9wIG11c3QgYmUgc3BlY2lmaWNhbGx5IHJlc2VydmVkIG90aGVyd2lzZSBpdA0KaXMgZGlzY2Fy
ZGVkLiBUaGlzIGlzIG5vdCBjbGVhcmx5IGRvY3VtZW50ZWQuDQoNCkFkZCBhIG5ldyBzeW1ib2ws
IF9fZW5kX29mX2tlcm5lbF9yZXNlcnZlLCB0aGF0IG1vcmUgcmVhZGlseSBpZGVudGlmaWVzDQp3
aGF0IGlzIHJlc2VydmVkLCBhbG9uZyB3aXRoIGNvbW1lbnRzIHRoYXQgaW5kaWNhdGUgd2hhdCBp
cyByZXNlcnZlZCwNCndoYXQgaXMgZGlzY2FyZGVkIGFuZCB3aGF0IG5lZWRzIHRvIGJlIGRvbmUg
dG8gcHJldmVudCBhIHNlY3Rpb24gZnJvbQ0KYmVpbmcgZGlzY2FyZGVkLg0KDQpDYzogQmFvcXVh
biBIZSA8YmhlQHJlZGhhdC5jb20+DQpDYzogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhhdC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29t
Pg0KLS0tDQogYXJjaC94ODYvaW5jbHVkZS9hc20vc2VjdGlvbnMuaCB8IDIgKysNCiBhcmNoL3g4
Ni9rZXJuZWwvc2V0dXAuYyAgICAgICAgIHwgOCArKysrKysrLQ0KIGFyY2gveDg2L2tlcm5lbC92
bWxpbnV4Lmxkcy5TICAgfCA5ICsrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NlY3Rpb25zLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWN0aW9ucy5oDQppbmRleCA4
ZWExY2ZkYmVhYmMuLjcxYjMyZjI1NzBhYiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NlY3Rpb25zLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmgNCkBA
IC0xMyw0ICsxMyw2IEBAIGV4dGVybiBjaGFyIF9fZW5kX3JvZGF0YV9hbGlnbmVkW107DQogZXh0
ZXJuIGNoYXIgX19lbmRfcm9kYXRhX2hwYWdlX2FsaWduW107DQogI2VuZGlmDQogDQorZXh0ZXJu
IGNoYXIgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmVbXTsNCisNCiAjZW5kaWYJLyogX0FTTV9YODZf
U0VDVElPTlNfSCAqLw0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jIGIvYXJj
aC94ODYva2VybmVsL3NldHVwLmMNCmluZGV4IDA4YTVmNGExMzFmNS4uMzJlYjcwNjI1YjNiIDEw
MDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9zZXR1cC5jDQpAQCAtODI3LDggKzgyNywxNCBAQCBkdW1wX2tlcm5lbF9vZmZzZXQoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpzZWxmLCB1bnNpZ25lZCBsb25nIHYsIHZvaWQgKnApDQogDQogdm9p
ZCBfX2luaXQgc2V0dXBfYXJjaChjaGFyICoqY21kbGluZV9wKQ0KIHsNCisJLyoNCisJICogUmVz
ZXJ2ZSB0aGUgbWVtb3J5IG9jY3VwaWVkIGJ5IHRoZSBrZXJuZWwgYmV0d2VlbiBfdGV4dCBhbmQN
CisJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9scy4gQW55IGtlcm5lbCBzZWN0aW9u
cyBhZnRlciB0aGUNCisJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9sIG11c3QgYmUg
ZXhwbGljaXR5IHJlc2VydmVkIHdpdGggYQ0KKwkgKiBzZXBhcmF0ZSBtZW1ibG9ja19yZXNlcnZl
KCkgb3IgaXQgd2lsbCBiZSBkaXNjYXJkZWQuDQorCSAqLw0KIAltZW1ibG9ja19yZXNlcnZlKF9f
cGFfc3ltYm9sKF90ZXh0KSwNCi0JCQkgKHVuc2lnbmVkIGxvbmcpX19ic3Nfc3RvcCAtICh1bnNp
Z25lZCBsb25nKV90ZXh0KTsNCisJCQkgKHVuc2lnbmVkIGxvbmcpX19lbmRfb2Zfa2VybmVsX3Jl
c2VydmUgLSAodW5zaWduZWQgbG9uZylfdGV4dCk7DQogDQogCS8qDQogCSAqIE1ha2Ugc3VyZSBw
YWdlIDAgaXMgYWx3YXlzIHJlc2VydmVkIGJlY2F1c2Ugb24gc3lzdGVtcyB3aXRoDQpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgYi9hcmNoL3g4Ni9rZXJuZWwvdm1s
aW51eC5sZHMuUw0KaW5kZXggMDg1MGI1MTQ5MzQ1Li5jYTIyNTJjYTZhZDcgMTAwNjQ0DQotLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUw0KKysrIGIvYXJjaC94ODYva2VybmVsL3Zt
bGludXgubGRzLlMNCkBAIC0zNjgsNiArMzY4LDE0IEBAIFNFQ1RJT05TDQogCQlfX2Jzc19zdG9w
ID0gLjsNCiAJfQ0KIA0KKwkvKg0KKwkgKiBUaGUgbWVtb3J5IG9jY3VwaWVkIGZyb20gX3RleHQg
dG8gaGVyZSwgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUsIGlzDQorCSAqIGF1dG9tYXRpY2FsbHkg
cmVzZXJ2ZWQgaW4gc2V0dXBfYXJjaCgpLiBBbnl0aGluZyBhZnRlciBoZXJlIG11c3QgYmUNCisJ
ICogZXhwbGljaXRseSByZXNlcnZlZCB1c2luZyBtZW1ibG9ja19yZXNlcnZlKCkgb3IgaXQgd2ls
bCBiZSBkaXNjYXJkZWQNCisJICogYW5kIHRyZWF0ZWQgYXMgYXZhaWxhYmxlIG1lbW9yeS4NCisJ
ICovDQorCV9fZW5kX29mX2tlcm5lbF9yZXNlcnZlID0gLjsNCisNCiAJLiA9IEFMSUdOKFBBR0Vf
U0laRSk7DQogCS5icmsgOiBBVChBRERSKC5icmspIC0gTE9BRF9PRkZTRVQpIHsNCiAJCV9fYnJr
X2Jhc2UgPSAuOw0KQEAgLTM4Miw3ICszOTAsNiBAQCBTRUNUSU9OUw0KIAlTVEFCU19ERUJVRw0K
IAlEV0FSRl9ERUJVRw0KIA0KLQkvKiBTZWN0aW9ucyB0byBiZSBkaXNjYXJkZWQgKi8NCiAJRElT
Q0FSRFMNCiAJL0RJU0NBUkQvIDogew0KIAkJKiguZWhfZnJhbWUpDQotLSANCjIuMTcuMQ0KDQo=
