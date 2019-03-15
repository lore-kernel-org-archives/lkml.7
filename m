Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F922186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oN6ifim4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCOUlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:41:06 -0400
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:22059
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfCOUlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF0ZIUfXzdo7oWVQsMDOHg2rjM5bF22nsYWS943NAlY=;
 b=oN6ifim4Pu6hfUx1yqK2W6LDN36SuL0xm6h+hOxoLOAZFvPBRzMuSHy/c8HJFjPVWjVCR+ZQs4wLQN7OSan4I2kzo9FGffMM7hHBrQvPyyfwyTOLZyRVsJ23+2dbbaU8T1V1I4y6EoNbQblhUegnu9gAFFVX1ufye7l/VDYwfyE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3545.namprd12.prod.outlook.com (20.179.106.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 20:41:00 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 20:41:00 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH v2 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Topic: [RFC PATCH v2 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Index: AQHU229mIvha5pwXckCqUIpBYzaKPw==
Date:   Fri, 15 Mar 2019 20:41:00 +0000
Message-ID: <155268245818.14761.10443012194152751116.stgit@tlendack-t1.amdoffice.net>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0019.prod.exchangelabs.com (2603:10b6:804:2::29)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c765de-c03b-46d8-5658-08d6a9868883
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3545;
x-ms-traffictypediagnostic: DM6PR12MB3545:
x-microsoft-antispam-prvs: <DM6PR12MB35459DCCF04F509B95139F5FEC440@DM6PR12MB3545.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(256004)(9686003)(305945005)(6506007)(486006)(86362001)(316002)(5660300002)(476003)(6436002)(76176011)(81166006)(6116002)(102836004)(81156014)(7416002)(52116002)(6486002)(66066001)(3846002)(103116003)(71200400001)(72206003)(71190400001)(2906002)(2501003)(68736007)(105586002)(186003)(26005)(8676002)(386003)(7736002)(14454004)(11346002)(478600001)(25786009)(446003)(99286004)(53936002)(110136005)(8936002)(54906003)(106356001)(97736004)(14444005)(4326008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3545;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PxqZ+PaBgARsUw9xDa473I/GfYGotBfkLt/sdUfSQThaKURV3cH+Z3OpniqWJqCWU6cZhFx/8E7pDT4mPkzbJYvV+ZAxmWZ15BczF0sJXYw3e766gSoQtX4B+HO70Y2BKhNEq/3lDAYj6ldIqLLXw52M4W1r+/4cN3LHxFK2U7lwCOp0/bPs8uF2xoVxNTvv0GpojVp4lX57toz3HH0CxAk909s82PUC+zPlhKkQg7tkZtooLaTSJYUOfTCGXloqnHSO8UdWFZG5wuIi93ghuzRjtrUEUBNQJILwNph3Urhu5LLfBItXhmZRPC3Vt9ToV5BlAkw6Ug2VEDC5mBBosHOjBN7RL+BhTDW7FnJ0LM49OHSoEGgTYjpCx8PN0RsmPg37Iawb6B8uOW0CoMAAPILU/37g+cnDctzpM4Ade48=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2045F1CF8A54941A526441392BAC3EB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c765de-c03b-46d8-5658-08d6a9868883
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 20:41:00.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQU1EIHByb2Nlc3NvcnMsIHRoZSBkZXRlY3Rpb24gb2YgYW4gb3ZlcmZsb3dlZCBQTUMgY291
bnRlciBpbiB0aGUgTk1JDQpoYW5kbGVyIHJlbGllcyBvbiB0aGUgY3VycmVudCB2YWx1ZSBvZiB0
aGUgUE1DLiBTbywgZm9yIGV4YW1wbGUsIHRvIGNoZWNrDQpmb3Igb3ZlcmZsb3cgb24gYSA0OC1i
aXQgY291bnRlciwgYml0IDQ3IGlzIGNoZWNrZWQgdG8gc2VlIGlmIGl0IGlzIDEgKG5vdA0Kb3Zl
cmZsb3dlZCkgb3IgMCAob3ZlcmZsb3dlZCkuDQoNCldoZW4gdGhlIHBlcmYgTk1JIGhhbmRsZXIg
ZXhlY3V0ZXMgaXQgZG9lcyBub3Qga25vdyBpbiBhZHZhbmNlIHdoaWNoIFBNQw0KY291bnRlcnMg
aGF2ZSBvdmVyZmxvd2VkLiBBcyBzdWNoLCB0aGUgTk1JIGhhbmRsZXIgd2lsbCBwcm9jZXNzIGFs
bCBhY3RpdmUNClBNQyBjb3VudGVycyB0aGF0IGhhdmUgb3ZlcmZsb3dlZC4gTk1JIGxhdGVuY3kg
aW4gbmV3ZXIgQU1EIHByb2Nlc3NvcnMgY2FuDQpyZXN1bHQgaW4gbXVsdGlwbGUgb3ZlcmZsb3dl
ZCBQTUMgY291bnRlcnMgYmVpbmcgcHJvY2Vzc2VkIGluIG9uZSBOTUkgYW5kDQp0aGVuIGEgc3Vi
c2VxdWVudCBOTUksIHRoYXQgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGEgYmFjay10by1iYWNrIE5N
SSwgbm90DQpmaW5kaW5nIGFueSBQTUMgY291bnRlcnMgdGhhdCBoYXZlIG92ZXJmbG93ZWQuIFRo
aXMgbWF5IGFwcGVhciB0byBiZSBhbg0KdW5oYW5kbGVkIE5NSSByZXN1bHRpbmcgaW4gZWl0aGVy
IGEgcGFuaWMgb3IgYSBzZXJpZXMgb2YgbWVzc2FnZXMsDQpkZXBlbmRpbmcgb24gaG93IHRoZSBr
ZXJuZWwgd2FzIGNvbmZpZ3VyZWQuDQoNClRvIG1pdGlnYXRlIHRoaXMgaXNzdWUsIGFkZCBhbiBB
TUQgaGFuZGxlX2lycSBjYWxsYmFjayBmdW5jdGlvbiwNCmFtZF9wbXVfaGFuZGxlX2lycSgpLCB0
aGF0IHdpbGwgaW52b2tlIHRoZSBjb21tb24geDg2X3BtdV9oYW5kbGVfaXJxKCkNCmZ1bmN0aW9u
IGFuZCB1cG9uIHJldHVybiBwZXJmb3JtIHNvbWUgYWRkaXRpb25hbCBwcm9jZXNzaW5nIHRoYXQg
d2lsbA0KaW5kaWNhdGUgaWYgdGhlIE5NSSBoYXMgYmVlbiBoYW5kbGVkIG9yIHdvdWxkIGhhdmUg
YmVlbiBoYW5kbGVkIGhhZCBhbg0KZWFybGllciBOTUkgbm90IGhhbmRsZWQgdGhlIG92ZXJmbG93
ZWQgUE1DLiBVc2luZyBhIHBlci1DUFUgdmFyaWFibGUsIGENCm1pbmltdW0gdmFsdWUgb2YgdGhl
IG51bWJlciBvZiBhY3RpdmUgUE1DcyBvciAyIHdpbGwgYmUgc2V0IHdoZW5ldmVyIGENClBNQyBp
cyBhY3RpdmUuIFRoaXMgaXMgdXNlZCB0byBpbmRpY2F0ZSB0aGUgcG9zc2libGUgbnVtYmVyIG9m
IE5NSXMgdGhhdA0KY2FuIHN0aWxsIG9jY3VyLiBUaGUgdmFsdWUgb2YgMiBpcyB1c2VkIGZvciB3
aGVuIGFuIE5NSSBkb2VzIG5vdCBhcnJpdmUNCmF0IHRoZSBMQVBJQyBpbiB0aW1lIHRvIGJlIGNv
bGxhcHNlZCBpbnRvIGFuIGFscmVhZHkgcGVuZGluZyBOTUkuIEVhY2gNCnRpbWUgdGhlIGZ1bmN0
aW9uIGlzIGNhbGxlZCB3aXRob3V0IGhhdmluZyBoYW5kbGVkIGFuIG92ZXJmbG93ZWQgY291bnRl
ciwNCnRoZSBwZXItQ1BVIHZhbHVlIGlzIGNoZWNrZWQuIElmIHRoZSB2YWx1ZSBpcyBub24temVy
bywgaXQgaXMgZGVjcmVtZW50ZWQNCmFuZCB0aGUgTk1JIGluZGljYXRlcyB0aGF0IGl0IGhhbmRs
ZWQgdGhlIE5NSS4gSWYgdGhlIHZhbHVlIGlzIHplcm8sIHRoZW4NCnRoZSBOTUkgaW5kaWNhdGVz
IHRoYXQgaXQgZGlkIG5vdCBoYW5kbGUgdGhlIE5NSS4NCg0KVGhpcyBpc3N1ZSBpcyBkaWZmZXJl
bnQgZnJvbSBhIHByZXZpb3VzIGlzc3VlIHJlbGF0ZWQgdG8gcGVyZiBOTUlzIHRoYXQNCndhcyBm
aXhlZCBpbiBjb21taXQ6DQogIDYzZTZiZTZkOThlMSAoInBlcmYsIHg4NjogQ2F0Y2ggc3B1cmlv
dXMgaW50ZXJydXB0cyBhZnRlciBkaXNhYmxpbmcgY291bnRlcnMiKQ0KDQpUaGUgZGlmZmVyZW5j
ZSBoZXJlIGlzIHRoYXQgdGhlIE5NSSBsYXRlbmN5IGNhbiBjb250cmlidXRlIHRvIHdoYXQgYXBw
ZWFyDQp0byBiZSBzcHVyaW91cyBOTUlzIGR1cmluZyB0aGUgaGFuZGxpbmcgb2YgUE1DIGNvdW50
ZXIgb3ZlcmZsb3cgd2hpbGUgdGhlDQpjb3VudGVyIGlzIGFjdGl2ZSBhcyBvcHBvc2VkIHRvIHdo
ZW4gdGhlIGNvdW50ZXIgaXMgYmVpbmcgZGlzYWJsZWQuDQoNCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4gIyA0LjE0LngtDQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5s
ZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgfCAgIDU4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNo
YW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2V2ZW50cy9hbWQvY29yZS5jIGIvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMNCmlu
ZGV4IDczMjQwMmRjZmZkYy4uM2JjN2E5MmRlOGFmIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvZXZl
bnRzL2FtZC9jb3JlLmMNCisrKyBiL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQpAQCAtNSw5
ICs1LDEyIEBADQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvZGVs
YXkuaD4NCiAjaW5jbHVkZSA8YXNtL2FwaWNkZWYuaD4NCisjaW5jbHVkZSA8YXNtL25taS5oPg0K
IA0KICNpbmNsdWRlICIuLi9wZXJmX2V2ZW50LmgiDQogDQorc3RhdGljIERFRklORV9QRVJfQ1BV
KHVuc2lnbmVkIGludCwgcGVyZl9ubWlfY291bnRlcik7DQorDQogc3RhdGljIF9faW5pdGNvbnN0
IGNvbnN0IHU2NCBhbWRfaHdfY2FjaGVfZXZlbnRfaWRzDQogCQkJCVtQRVJGX0NPVU5UX0hXX0NB
Q0hFX01BWF0NCiAJCQkJW1BFUkZfQ09VTlRfSFdfQ0FDSEVfT1BfTUFYXQ0KQEAgLTUwOCw2ICs1
MTEsNTkgQEAgdm9pZCBhbWRfcG11X2Rpc2FibGVfYWxsKHZvaWQpDQogCX0NCiB9DQogDQorLyoN
CisgKiBCZWNhdXNlIG9mIE5NSSBsYXRlbmN5LCBpZiBtdWx0aXBsZSBQTUMgY291bnRlcnMgYXJl
IGFjdGl2ZSBvciBvdGhlciBzb3VyY2VzDQorICogb2YgTk1JcyBhcmUgcmVjZWl2ZWQsIHRoZSBw
ZXJmIE5NSSBoYW5kbGVyIGNhbiBoYW5kbGUgb25lIG9yIG1vcmUgb3ZlcmZsb3dlZA0KKyAqIFBN
QyBjb3VudGVycyBvdXRzaWRlIG9mIHRoZSBOTUkgYXNzb2NpYXRlZCB3aXRoIHRoZSBQTUMgb3Zl
cmZsb3cuIElmIHRoZSBOTUkNCisgKiBkb2Vzbid0IGFycml2ZSBhdCB0aGUgTEFQSUMgaW4gdGlt
ZSB0byBiZWNvbWUgYSBwZW5kaW5nIE5NSSwgdGhlbiB0aGUga2VybmVsDQorICogYmFjay10by1i
YWNrIE5NSSBzdXBwb3J0IHdvbid0IGJlIGFjdGl2ZS4gVGhpcyBQTUMgaGFuZGxlciBuZWVkcyB0
byB0YWtlIGludG8NCisgKiBhY2NvdW50IHRoYXQgdGhpcyBjYW4gb2NjdXIsIG90aGVyd2lzZSB0
aGlzIGNvdWxkIHJlc3VsdCBpbiB1bmtub3duIE5NSQ0KKyAqIG1lc3NhZ2VzIGJlaW5nIGlzc3Vl
ZC4gRXhhbXBsZXMgb2YgdGhpcyBpcyBQTUMgb3ZlcmZsb3cgd2hpbGUgaW4gdGhlIE5NSQ0KKyAq
IGhhbmRsZXIgd2hlbiBtdWx0aXBsZSBQTUNzIGFyZSBhY3RpdmUgb3IgUE1DIG92ZXJmbG93IHdo
aWxlIGhhbmRsaW5nIHNvbWUNCisgKiBvdGhlciBzb3VyY2Ugb2YgYW4gTk1JLg0KKyAqDQorICog
QXR0ZW1wdCB0byBtaXRpZ2F0ZSB0aGlzIGJ5IHVzaW5nIHRoZSBudW1iZXIgb2YgYWN0aXZlIFBN
Q3MgdG8gZGV0ZXJtaW5lDQorICogd2hldGhlciB0byByZXR1cm4gTk1JX0hBTkRMRUQgaWYgdGhl
IHBlcmYgTk1JIGhhbmRsZXIgZGlkIG5vdCBoYW5kbGUvcmVzZXQNCisgKiBhbnkgUE1Dcy4gVGhl
IHBlci1DUFUgcGVyZl9ubWlfY291bnRlciB2YXJpYWJsZSBpcyBzZXQgdG8gYSBtaW5pbXVtIG9m
IHRoZQ0KKyAqIG51bWJlciBvZiBhY3RpdmUgUE1DcyBvciAyLiBUaGUgdmFsdWUgb2YgMiBpcyB1
c2VkIGluIGNhc2UgYW4gTk1JIGRvZXMgbm90DQorICogYXJyaXZlIGF0IHRoZSBMQVBJQyBpbiB0
aW1lIHRvIGJlIGNvbGxhcHNlZCBpbnRvIGFuIGFscmVhZHkgcGVuZGluZyBOTUkuDQorICovDQor
c3RhdGljIGludCBhbWRfcG11X2hhbmRsZV9pcnEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQorew0K
KwlzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YyA9IHRoaXNfY3B1X3B0cigmY3B1X2h3X2V2ZW50
cyk7DQorCWludCBhY3RpdmUsIGhhbmRsZWQ7DQorDQorCWFjdGl2ZSA9IF9fYml0bWFwX3dlaWdo
dChjcHVjLT5hY3RpdmVfbWFzaywgWDg2X1BNQ19JRFhfTUFYKTsNCisJaGFuZGxlZCA9IHg4Nl9w
bXVfaGFuZGxlX2lycShyZWdzKTsNCisNCisJLyoNCisJICogSWYgbm8gY291bnRlcnMgYXJlIGFj
dGl2ZSwgcmVzZXQgcGVyZl9ubWlfY291bnRlciBhbmQgcmV0dXJuDQorCSAqIE5NSV9ET05FDQor
CSAqLw0KKwlpZiAoIWFjdGl2ZSkgew0KKwkJdGhpc19jcHVfd3JpdGUocGVyZl9ubWlfY291bnRl
ciwgMCk7DQorCQlyZXR1cm4gTk1JX0RPTkU7DQorCX0NCisNCisJLyoNCisJICogSWYgYSBjb3Vu
dGVyIHdhcyBoYW5kbGVkLCByZWNvcmQgdGhlIG51bWJlciBvZiBwb3NzaWJsZSByZW1haW5pbmcN
CisJICogTk1JcyB0aGF0IGNhbiBvY2N1ci4NCisJICovDQorCWlmIChoYW5kbGVkKSB7DQorCQl0
aGlzX2NwdV93cml0ZShwZXJmX25taV9jb3VudGVyLA0KKwkJCSAgICAgICBtaW5fdCh1bnNpZ25l
ZCBpbnQsIDIsIGFjdGl2ZSkpOw0KKw0KKwkJcmV0dXJuIGhhbmRsZWQ7DQorCX0NCisNCisJaWYg
KCF0aGlzX2NwdV9yZWFkKHBlcmZfbm1pX2NvdW50ZXIpKQ0KKwkJcmV0dXJuIE5NSV9ET05FOw0K
Kw0KKwl0aGlzX2NwdV9kZWMocGVyZl9ubWlfY291bnRlcik7DQorDQorCXJldHVybiBOTUlfSEFO
RExFRDsNCit9DQorDQogc3RhdGljIHN0cnVjdCBldmVudF9jb25zdHJhaW50ICoNCiBhbWRfZ2V0
X2V2ZW50X2NvbnN0cmFpbnRzKHN0cnVjdCBjcHVfaHdfZXZlbnRzICpjcHVjLCBpbnQgaWR4LA0K
IAkJCSAgc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KQEAgLTcwMCw3ICs3NTYsNyBAQCBzdGF0
aWMgc3NpemVfdCBhbWRfZXZlbnRfc3lzZnNfc2hvdyhjaGFyICpwYWdlLCB1NjQgY29uZmlnKQ0K
IA0KIHN0YXRpYyBfX2luaXRjb25zdCBjb25zdCBzdHJ1Y3QgeDg2X3BtdSBhbWRfcG11ID0gew0K
IAkubmFtZQkJCT0gIkFNRCIsDQotCS5oYW5kbGVfaXJxCQk9IHg4Nl9wbXVfaGFuZGxlX2lycSwN
CisJLmhhbmRsZV9pcnEJCT0gYW1kX3BtdV9oYW5kbGVfaXJxLA0KIAkuZGlzYWJsZV9hbGwJCT0g
YW1kX3BtdV9kaXNhYmxlX2FsbCwNCiAJLmVuYWJsZV9hbGwJCT0geDg2X3BtdV9lbmFibGVfYWxs
LA0KIAkuZW5hYmxlCQkJPSB4ODZfcG11X2VuYWJsZV9ldmVudCwNCg0K
