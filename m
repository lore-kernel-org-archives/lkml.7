Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2020CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65B0218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Co/6SAhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCUVQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:16:05 -0400
Received: from mail-eopbgr780079.outbound.protection.outlook.com ([40.107.78.79]:62432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfCUVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9pCJwmwuShxA9IpXhcoVJiW0WmXk9Y+3ThWnIuLbho=;
 b=Co/6SAhpdnTr5BqHM4CwNX+dnoqYjrfUsLG5xu9amszdnXhL0nZASOmSy1mDlu8In3VO95Wq0KgekYrkN6M9OOVRBnOjsDsKgWPJXAEL1V0aAog06KHFmWtZOxY9fOofsh++2n0jiAgvDTu0g0buORPRNF/1gu8o+vFeldX66vw=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 21:15:22 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::5d25:2544:ed88:de0d]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::5d25:2544:ed88:de0d%12]) with mapi id 15.20.1730.013; Thu, 21 Mar
 2019 21:15:22 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH] x86/events: add event map for AMD Family 17h
Thread-Topic: [PATCH] x86/events: add event map for AMD Family 17h
Thread-Index: AQHU4Csyc2U08sJPNkagkeDfEZ+EFg==
Date:   Thu, 21 Mar 2019 21:15:22 +0000
Message-ID: <20190321211515.20756-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3fbc0f7-5be5-4bb3-fd6b-08d6ae425450
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1254;
x-ms-traffictypediagnostic: CY4PR12MB1254:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-microsoft-antispam-prvs: <CY4PR12MB1254DB06A4AB5646819EB9D787420@CY4PR12MB1254.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(81156014)(4326008)(36756003)(256004)(5660300002)(8936002)(1076003)(2906002)(7416002)(26005)(966005)(6512007)(54906003)(99286004)(102836004)(186003)(6436002)(386003)(5640700003)(316002)(71200400001)(6506007)(86362001)(478600001)(6306002)(97736004)(3846002)(81166006)(68736007)(2351001)(105586002)(305945005)(8676002)(52116002)(14454004)(25786009)(7736002)(2501003)(50226002)(66066001)(106356001)(53936002)(476003)(486006)(6916009)(2616005)(6486002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1254;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iWl669s4hA19vcPBTgW6TEeG0HmPxNVq4o0Z9SMKVWOVPMs+SGs05KDrozj0eKERGdxwv5srVRfL5QCBoyexUWaZ0pFUKkc+jDAwD3dTA6AaULdsoTtBipIp2ZbkWHOGJbVj+A4+ogfjVOagGCEnXkhjeJjAfK/abb/CWWtACueFRkVXq8y2JmcWMkxrFrLMLDyZiEnNHv9ltTUuAH0S5qyeF//8eeqKb69xougImSgJsd08E7VuS3j9TboS1WPHLxvLr22PsBbXfHQnownt9zVqnJAdTTFeORRkOLtQ2I+5xOJ6JRkljXL/tjnSPaT8pDqlcecFYlYck58itPKOCTpYeJFO89FDM8FOj+M7OkMl/hziTjAcaNqeeLXS4WnCRUvZ10w97+KHyD2l89tN9qWC1Y4MunnZjO41vnq/pHk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FCB0251AD3A5D4898D3DD1F80D09308@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fbc0f7-5be5-4bb3-fd6b-08d6ae425450
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 21:15:22.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2ltIFBoaWxsaXBzIDxraW0ucGhpbGxpcHNAYW1kLmNvbT4NCg0KRmFtaWx5IDE3aCBk
aWZmZXJzIGZyb20gcHJpb3IgZmFtaWxpZXMgYnk6DQogLSBub3Qgc3VwcG9ydGluZyBhbiBMMiBj
YWNoZSBtaXNzIGV2ZW50DQogLSBoYXZpbmcgcmUtZW51bWVyYXRlZCBQTUMgY291bnRlcnMgZm9y
Og0KICAgLSBMMiBjYWNoZSByZWZlcmVuY2VzDQogICAtIGZyb250ICYgYmFjayBlbmQgc3RhbGxl
ZCBjeWNsZXMNCg0KU28gd2UgYWRkIGEgbmV3IGFtZF9mMTdoX3BlcmZtb25fZXZlbnRfbWFwIHNv
IHRoYXQgdGhlIGdlbmVyaWMNCnBlcmYgZXZlbnQgbmFtZXMgd2lsbCByZXNvbHZlIHRvIHRoZSBj
b3JyZWN0IGgvdyBldmVudHMgb24NCmZhbWlseSAxN2ggYW5kIGFib3ZlIHByb2Nlc3NvcnMuDQoN
ClJlZmVyZW5jZSBzZWN0aW9ucyAyLjEuMTMuMy4zIChzdGFsbHMpIGFuZCAyLjEuMTMuMy42IChM
Mik6DQpodHRwczovL3d3dy5hbWQuY29tL3N5c3RlbS9maWxlcy9UZWNoRG9jcy81NDk0NV9QUFJf
RmFtaWx5XzE3aF9Nb2RlbHNfMDBoLTBGaC5wZGYNCg0KRml4ZXM6IGU0MGVkMTU0MmRkNyAoInBl
cmYveDg2OiBBZGQgcGVyZiBzdXBwb3J0IGZvciBBTUQgZmFtaWx5LTE3aCBwcm9jZXNzb3JzIikN
ClNpZ25lZC1vZmYtYnk6IEtpbSBQaGlsbGlwcyA8a2ltLnBoaWxsaXBzQGFtZC5jb20+DQpDYzog
SmFuYWthcmFqYW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNvbT4NCkNj
OiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPFN1cmF2ZWUuU3V0aGlrdWxwYW5pdEBhbWQuY29tPg0K
Q2M6IE1hcnRpbiBMacWha2EgPG1saXNrYUBzdXNlLmN6Pg0KQ2M6IFBldGVyIFppamxzdHJhIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4N
CkNjOiBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz4NCkNjOiBBbGV4
YW5kZXIgU2hpc2hraW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+DQpDYzog
SmlyaSBPbHNhIDxqb2xzYUByZWRoYXQuY29tPg0KQ2M6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdA
a2VybmVsLm9yZz4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNj
OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCkNjOiAiSC4gUGV0ZXIgQW52aW4iIDxo
cGFAenl0b3IuY29tPg0KQ2M6IFB1IFdlbiA8cHV3ZW5AaHlnb24uY24+DQpDYzogeDg2QGtlcm5l
bC5vcmcNCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQotLS0NCiBhcmNoL3g4Ni9l
dmVudHMvYW1kL2NvcmUuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29y
ZS5jIGIvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMNCmluZGV4IDdkMmQ3YzgwMWRiYS4uNzY0
ZDE4MWFmYTE4IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMNCisrKyBi
L2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQpAQCAtMTI3LDggKzEyNywyNSBAQCBzdGF0aWMg
Y29uc3QgdTY0IGFtZF9wZXJmbW9uX2V2ZW50X21hcFtQRVJGX0NPVU5UX0hXX01BWF0gPQ0KICAg
W1BFUkZfQ09VTlRfSFdfU1RBTExFRF9DWUNMRVNfQkFDS0VORF0JPSAweDAwZDEsIC8qICJEaXNw
YXRjaCBzdGFsbHMiIGV2ZW50ICovDQogfTsNCiANCisvKg0KKyAqIEFNRCBQZXJmb3JtYW5jZSBN
b25pdG9yIEZhbWlseSAxN2gNCisgKi8NCitzdGF0aWMgY29uc3QgdTY0IGFtZF9mMTdoX3BlcmZt
b25fZXZlbnRfbWFwW1BFUkZfQ09VTlRfSFdfTUFYXSA9DQorew0KKyAgW1BFUkZfQ09VTlRfSFdf
Q1BVX0NZQ0xFU10JCQk9IDB4MDA3NiwNCisgIFtQRVJGX0NPVU5UX0hXX0lOU1RSVUNUSU9OU10J
CQk9IDB4MDBjMCwNCisgIFtQRVJGX0NPVU5UX0hXX0NBQ0hFX1JFRkVSRU5DRVNdCQk9IDB4ZmY2
MCwNCisgIFtQRVJGX0NPVU5UX0hXX0JSQU5DSF9JTlNUUlVDVElPTlNdCQk9IDB4MDBjMiwNCisg
IFtQRVJGX0NPVU5UX0hXX0JSQU5DSF9NSVNTRVNdCQkJPSAweDAwYzMsDQorICBbUEVSRl9DT1VO
VF9IV19TVEFMTEVEX0NZQ0xFU19GUk9OVEVORF0JPSAweDAyODcsDQorICBbUEVSRl9DT1VOVF9I
V19TVEFMTEVEX0NZQ0xFU19CQUNLRU5EXQk9IDB4MDE4NywNCit9Ow0KKw0KIHN0YXRpYyB1NjQg
YW1kX3BtdV9ldmVudF9tYXAoaW50IGh3X2V2ZW50KQ0KIHsNCisJaWYgKGJvb3RfY3B1X2RhdGEu
eDg2ID49IDB4MTcpDQorCQlyZXR1cm4gYW1kX2YxN2hfcGVyZm1vbl9ldmVudF9tYXBbaHdfZXZl
bnRdOw0KKw0KIAlyZXR1cm4gYW1kX3BlcmZtb25fZXZlbnRfbWFwW2h3X2V2ZW50XTsNCiB9DQog
DQotLSANCjIuMjEuMA0KDQo=
