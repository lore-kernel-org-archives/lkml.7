Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E897DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83E924884
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="boK7M0DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEaQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:18:11 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:18913
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbfEaQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL3mTv7on0vWJQmZeXTTaRg1qiThV8bAQV+TvMGhRd8=;
 b=boK7M0DOYZ3qMIgiwyGchNtGUjMh6D8NVNRWnW9RQisvfGi8cAShGfAoOP9zbqRNjUnOCE0ECLQ7R4esT1L1dlqc8Yg9KdJMzA8YbCc2Be6btFr7lhw9eA5oNzq/yq1jFxgW2jmiXkJe9nyIwnincLN1cZo1Vhfc9UBxhMzEpg4=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1800.namprd12.prod.outlook.com (10.175.63.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 16:17:34 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44%9]) with mapi id 15.20.1943.016; Fri, 31 May 2019
 16:17:34 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Phillips, Kim" <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>, Pu Wen <puwen@hygon.cn>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 2/2 RESEND] perf/x86/amd/uncore: set the thread mask for F17h
 L3 PMCs
Thread-Topic: [PATCH 2/2 RESEND] perf/x86/amd/uncore: set the thread mask for
 F17h L3 PMCs
Thread-Index: AQHVF8xbJG2ME1VNM0CpT4iWpzWsOA==
Date:   Fri, 31 May 2019 16:17:34 +0000
Message-ID: <20190531161708.25658-2-kim.phillips@amd.com>
References: <20190531161708.25658-1-kim.phillips@amd.com>
In-Reply-To: <20190531161708.25658-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0008.namprd08.prod.outlook.com
 (2603:10b6:803:29::18) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29b1747a-ce29-428f-90ac-08d6e5e37d6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR12MB1800;
x-ms-traffictypediagnostic: CY4PR12MB1800:
x-microsoft-antispam-prvs: <CY4PR12MB180079B8D8F5E4250DD972C287190@CY4PR12MB1800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(68736007)(71190400001)(2501003)(7416002)(305945005)(81156014)(256004)(8676002)(81166006)(71200400001)(478600001)(7736002)(8936002)(186003)(5660300002)(1076003)(6116002)(25786009)(6512007)(386003)(52116002)(6506007)(6436002)(102836004)(76176011)(36756003)(110136005)(50226002)(486006)(66556008)(66446008)(66476007)(66946007)(64756008)(73956011)(66066001)(316002)(446003)(54906003)(476003)(2616005)(11346002)(99286004)(14454004)(53936002)(3846002)(26005)(86362001)(2906002)(6486002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1800;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dluR4bZVnQgPKGLSuM2Ym9Ydvo4lFT8JVj7Tcyerg9EWKsmhUGPFYwbMA3fWdTQvoRHSfGLKd6wgwhnoch48R8zx0iZv6bjefR84rxzuetzu7fWsad3YI7ybgZKJFIi7oArzih0RP6C9L7Naxq+ajsArw0oNH9iPqrsBTtmrO2pdqRAJebD7yWhg1EI/Q0WnjlaRczV+yJ+u3FktSiHBGTyG2l1OHkl/sPvUFIJ/9bzNKJQcESvgCnT3YQT4RexfTJejSwqNZQsNrXU6LbhFTDxAWfWEPFX/RvYWw6M5Ml6cf2apn+8twrAoscjijSbu2hDpqWOw8OSsZfuMjjMMfL4tk0yBHGOtgmP0ymmhy1k6qKYX/OZAD/stIT+pA5NuHpZOJtyf8PzKs1wQlm6Xzq4M8VUx5V/XFjzdqd86OF4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C13DF550B6C554F9AAE8BDA4AE1F01B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1747a-ce29-428f-90ac-08d6e5e37d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 16:17:34.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1800
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
aW4iIDxocGFAenl0b3IuY29tPg0KQ2M6IE1hcnRpbiBMacWha2EgPG1saXNrYUBzdXNlLmN6Pg0K
Q2M6IFN1cmF2ZWUgU3V0aGlrdWxwYW5pdCA8U3VyYXZlZS5TdXRoaWt1bHBhbml0QGFtZC5jb20+
DQpDYzogSmFuYWthcmFqYW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNv
bT4NCkNjOiBHYXJ5IEhvb2sgPEdhcnkuSG9va0BhbWQuY29tPg0KQ2M6IFB1IFdlbiA8cHV3ZW5A
aHlnb24uY24+DQpDYzogU3RlcGhhbmUgRXJhbmlhbiA8ZXJhbmlhbkBnb29nbGUuY29tPg0KQ2M6
IFZpbmNlIFdlYXZlciA8dmluY2VudC53ZWF2ZXJAbWFpbmUuZWR1Pg0KQ2M6IHg4NkBrZXJuZWwu
b3JnDQotLS0NCiBhcmNoL3g4Ni9ldmVudHMvYW1kL3VuY29yZS5jIHwgMTUgKysrKysrKysrKyst
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvYW1kL3VuY29yZS5jIGIvYXJjaC94ODYvZXZl
bnRzL2FtZC91bmNvcmUuYw0KaW5kZXggYThkYzI2MzVhNzE5Li43NzFlOWIzYjYyZWIgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9ldmVudHMvYW1kL3VuY29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVu
dHMvYW1kL3VuY29yZS5jDQpAQCAtMjA1LDE1ICsyMDUsMjIgQEAgc3RhdGljIGludCBhbWRfdW5j
b3JlX2V2ZW50X2luaXQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KIAlod2MtPmNvbmZpZyA9
IGV2ZW50LT5hdHRyLmNvbmZpZyAmIEFNRDY0X1JBV19FVkVOVF9NQVNLX05COw0KIAlod2MtPmlk
eCA9IC0xOw0KIA0KKwlpZiAoZXZlbnQtPmNwdSA8IDApDQorCQlyZXR1cm4gLUVJTlZBTDsNCisN
CiAJLyoNCiAJICogU2xpY2VNYXNrIGFuZCBUaHJlYWRNYXNrIG5lZWQgdG8gYmUgc2V0IGZvciBj
ZXJ0YWluIEwzIGV2ZW50cyBpbg0KIAkgKiBGYW1pbHkgMTdoLiBGb3Igb3RoZXIgZXZlbnRzLCB0
aGUgdHdvIGZpZWxkcyBkbyBub3QgYWZmZWN0IHRoZSBjb3VudC4NCiAJICovDQotCWlmIChsM19t
YXNrICYmIGlzX2xsY19ldmVudChldmVudCkpDQotCQlod2MtPmNvbmZpZyB8PSAoQU1ENjRfTDNf
U0xJQ0VfTUFTSyB8IEFNRDY0X0wzX1RIUkVBRF9NQVNLKTsNCisJaWYgKGwzX21hc2sgJiYgaXNf
bGxjX2V2ZW50KGV2ZW50KSkgew0KKwkJaW50IHRocmVhZCA9IDIgKiAoY3B1X2RhdGEoZXZlbnQt
PmNwdSkuY3B1X2NvcmVfaWQgJSA0KTsNCiANCi0JaWYgKGV2ZW50LT5jcHUgPCAwKQ0KLQkJcmV0
dXJuIC1FSU5WQUw7DQorCQlpZiAoc21wX251bV9zaWJsaW5ncyA+IDEpDQorCQkJdGhyZWFkICs9
IGNwdV9kYXRhKGV2ZW50LT5jcHUpLmFwaWNpZCAmIDE7DQorDQorCQlod2MtPmNvbmZpZyB8PSAo
MVVMTCA8PCAoQU1ENjRfTDNfVEhSRUFEX1NISUZUICsgdGhyZWFkKSAmDQorCQkJCUFNRDY0X0wz
X1RIUkVBRF9NQVNLKSB8IEFNRDY0X0wzX1NMSUNFX01BU0s7DQorCX0NCiANCiAJdW5jb3JlID0g
ZXZlbnRfdG9fYW1kX3VuY29yZShldmVudCk7DQogCWlmICghdW5jb3JlKQ0KLS0gDQoyLjIxLjAN
Cg0K
