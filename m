Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F53C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12A9213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sOS+7hER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfFYO5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:57:09 -0400
Received: from mail-eopbgr790089.outbound.protection.outlook.com ([40.107.79.89]:44800
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731374AbfFYO5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bah/gnGyT+SogncEuUHCk7tdgTcOJhK+xOijbbL5m/g=;
 b=sOS+7hERxwrD7ZEhbu3jChANrozAmSJGwQQ0FGMSAQoasnxr/M7NIh0rEzRBCgdVMBfthjb3fRp2SUbVdk9P0UojFq1qLogEijDhd9Z7Qy98J/aSLwYHn9oJQ7z19VkHTj/hiHoasqfdhnj9Oz96VLjANkXkfRZX/9QVafsUqa4=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1832.namprd12.prod.outlook.com (10.175.61.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:56:41 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44%9]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 14:56:41 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Liska <mliska@suse.cz>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>, Pu Wen <puwen@hygon.cn>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 2/2 RESEND2] perf/x86/amd/uncore: set the thread mask for F17h
 L3 PMCs
Thread-Topic: [PATCH 2/2 RESEND2] perf/x86/amd/uncore: set the thread mask for
 F17h L3 PMCs
Thread-Index: AQHVK2YypUpPP1BiK0yXrLb5W3ff0A==
Date:   Tue, 25 Jun 2019 14:56:41 +0000
Message-ID: <20190625145548.11600-2-kim.phillips@amd.com>
References: <20190625145548.11600-1-kim.phillips@amd.com>
In-Reply-To: <20190625145548.11600-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:805:a2::33) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19dfc5b-aa15-4004-8217-08d6f97d54b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1832;
x-ms-traffictypediagnostic: CY4PR12MB1832:
x-microsoft-antispam-prvs: <CY4PR12MB183202D2851E8F38A114D1C787E30@CY4PR12MB1832.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(53936002)(2906002)(50226002)(66066001)(14454004)(4326008)(54906003)(305945005)(6486002)(71190400001)(5660300002)(7416002)(256004)(1076003)(110136005)(6116002)(478600001)(3846002)(6512007)(386003)(6506007)(102836004)(36756003)(68736007)(66446008)(73956011)(76176011)(52116002)(86362001)(81166006)(186003)(446003)(66946007)(11346002)(81156014)(486006)(2616005)(6436002)(476003)(8676002)(7736002)(316002)(8936002)(26005)(99286004)(64756008)(66556008)(66476007)(71200400001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1832;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QygOINnYH58SSWQv9j6pW3AD3M+LO2BFlUmSO2hMGwZ6cmwIXseRjjHu1vAoEoprfDTDkMquny+XzMoWWc9vwdyLO+ZO/AajXQCQxeWqoCTYxnF8Ko/KTEWB62TYVzDcJc5BdqyXHVFkUBD4FsI8XnZqt9CP7YQW3m7Uf+CZg3R1lYIagAtkbUeT1Xrb52BEaINfFmszwWu3ixXlbfS0fZiPzAGGSXSTizb/KOiwkPd/n/W5Abkv4tI+73h7xAkxmQSmLJG+5kbgakdOAMAiNZwixcwpKMa01njfE03aOgPPVqd/9bZeHJ/USsTtOa+VnRIWxshwDM7vdRTh3e0w/0GsiQTZ4QEkLgzEPRyL0Fgad2irZbLoMyEamcGCTL7VAknreyVB0sLf/CpSjB5rnZpfPV0qYGtKyUbd4uO/coI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19dfc5b-aa15-4004-8217-08d6f97d54b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:56:41.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYW1kLmNvbT4NCg0KRmlsbCBpbiB0aGUg
TDMgcGVyZm9ybWFuY2UgZXZlbnQgc2VsZWN0IHJlZ2lzdGVyIFRocmVhZE1hc2sNCmJpdGZpZWxk
LCB0byBlbmFibGUgcGVyIGhhcmR3YXJlIHRocmVhZCBhY2NvdW50aW5nLg0KDQpTaWduZWQtb2Zm
LWJ5OiBLaW0gUGhpbGxpcHMgPGtpbS5waGlsbGlwc0BhbWQuY29tPg0KQ2M6IFBldGVyIFppamxz
dHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT4NCkNjOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz4NCkNj
OiBBbGV4YW5kZXIgU2hpc2hraW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+
DQpDYzogSmlyaSBPbHNhIDxqb2xzYUByZWRoYXQuY29tPg0KQ2M6IE5hbWh5dW5nIEtpbSA8bmFt
aHl1bmdAa2VybmVsLm9yZz4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4NCkNjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCkNjOiAiSC4gUGV0ZXIgQW52
aW4iIDxocGFAenl0b3IuY29tPg0KQ2M6IE1hcnRpbiBMaXNrYSA8bWxpc2thQHN1c2UuY3o+DQpD
YzogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT4N
CkNjOiBKYW5ha2FyYWphbiBOYXRhcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBhbWQuY29t
Pg0KQ2M6IEdhcnkgSG9vayA8R2FyeS5Ib29rQGFtZC5jb20+DQpDYzogUHUgV2VuIDxwdXdlbkBo
eWdvbi5jbj4NCkNjOiBTdGVwaGFuZSBFcmFuaWFuIDxlcmFuaWFuQGdvb2dsZS5jb20+DQpDYzog
VmluY2UgV2VhdmVyIDx2aW5jZW50LndlYXZlckBtYWluZS5lZHU+DQpDYzogeDg2QGtlcm5lbC5v
cmcNCi0tLQ0KUkVTRU5EOiAzcmQgYXR0ZW1wdCwgdGhpcyB0aW1lIHdpdGggLS10cmFuc2Zlci1l
bmNvZGluZz03Yml0IHRvIHRyeSB0byBwYXNzDQogICAgICAgIFBldGVyIFouJ3Mgc2NyaXB0cyBu
b3QgbGlraW5nIGJhc2U2NCBlbmNvZGVkIGVtYWlscy4NCg0KIGFyY2gveDg2L2V2ZW50cy9hbWQv
dW5jb3JlLmMgfCAxNSArKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9h
bWQvdW5jb3JlLmMgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL3VuY29yZS5jDQppbmRleCBjMmM0YWU1
ZmJiZmMuLmE2ZWEwN2YyYWE4NCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2V2ZW50cy9hbWQvdW5j
b3JlLmMNCisrKyBiL2FyY2gveDg2L2V2ZW50cy9hbWQvdW5jb3JlLmMNCkBAIC0yMDIsMTUgKzIw
MiwyMiBAQCBzdGF0aWMgaW50IGFtZF91bmNvcmVfZXZlbnRfaW5pdChzdHJ1Y3QgcGVyZl9ldmVu
dCAqZXZlbnQpDQogCWh3Yy0+Y29uZmlnID0gZXZlbnQtPmF0dHIuY29uZmlnICYgQU1ENjRfUkFX
X0VWRU5UX01BU0tfTkI7DQogCWh3Yy0+aWR4ID0gLTE7DQogDQorCWlmIChldmVudC0+Y3B1IDwg
MCkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KIAkvKg0KIAkgKiBTbGljZU1hc2sgYW5kIFRocmVh
ZE1hc2sgbmVlZCB0byBiZSBzZXQgZm9yIGNlcnRhaW4gTDMgZXZlbnRzIGluDQogCSAqIEZhbWls
eSAxN2guIEZvciBvdGhlciBldmVudHMsIHRoZSB0d28gZmllbGRzIGRvIG5vdCBhZmZlY3QgdGhl
IGNvdW50Lg0KIAkgKi8NCi0JaWYgKGwzX21hc2sgJiYgaXNfbGxjX2V2ZW50KGV2ZW50KSkNCi0J
CWh3Yy0+Y29uZmlnIHw9IChBTUQ2NF9MM19TTElDRV9NQVNLIHwgQU1ENjRfTDNfVEhSRUFEX01B
U0spOw0KKwlpZiAobDNfbWFzayAmJiBpc19sbGNfZXZlbnQoZXZlbnQpKSB7DQorCQlpbnQgdGhy
ZWFkID0gMiAqIChjcHVfZGF0YShldmVudC0+Y3B1KS5jcHVfY29yZV9pZCAlIDQpOw0KIA0KLQlp
ZiAoZXZlbnQtPmNwdSA8IDApDQotCQlyZXR1cm4gLUVJTlZBTDsNCisJCWlmIChzbXBfbnVtX3Np
YmxpbmdzID4gMSkNCisJCQl0aHJlYWQgKz0gY3B1X2RhdGEoZXZlbnQtPmNwdSkuYXBpY2lkICYg
MTsNCisNCisJCWh3Yy0+Y29uZmlnIHw9ICgxVUxMIDw8IChBTUQ2NF9MM19USFJFQURfU0hJRlQg
KyB0aHJlYWQpICYNCisJCQkJQU1ENjRfTDNfVEhSRUFEX01BU0spIHwgQU1ENjRfTDNfU0xJQ0Vf
TUFTSzsNCisJfQ0KIA0KIAl1bmNvcmUgPSBldmVudF90b19hbWRfdW5jb3JlKGV2ZW50KTsNCiAJ
aWYgKCF1bmNvcmUpDQotLSANCjIuMjIuMA0KDQo=
