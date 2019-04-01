Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE58DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B2F2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KSYroZTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDAVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:46:54 -0400
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:18816
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvR3m5StbCWOzSdxUFwnReePxWEHJx6DqQivFRaJA9k=;
 b=KSYroZTaWftbB6qlhOpfk9Ntq2svMA7YQCy8KRiYam7YitNXXgz6p3uFQ+GSD1/AstIxWsvLsg1pUy0H5XoZJHO31EJ6QXKRYLbM6sfKt04E1kllBUGQrQFaTpoMLbohilPQxf25MMrLt4gdGJu3yMjS3LC5aVs8XCY5FgPcfzo=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2970.namprd12.prod.outlook.com (20.178.29.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 21:46:48 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 21:46:48 +0000
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
Subject: [RFC PATCH v3 2/3] x86/perf/amd: Resolve NMI latency issues for
 active PMCs
Thread-Topic: [RFC PATCH v3 2/3] x86/perf/amd: Resolve NMI latency issues for
 active PMCs
Thread-Index: AQHU6NRoeD0w1xdRr0el3BF0VPvTVw==
Date:   Mon, 1 Apr 2019 21:46:48 +0000
Message-ID: <155415520605.24457.6333449518914408376.stgit@tlendack-t1.amdoffice.net>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:805:f2::14) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77835705-8ace-4d14-d48d-08d6b6eb8a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2970;
x-ms-traffictypediagnostic: DM6PR12MB2970:
x-microsoft-antispam-prvs: <DM6PR12MB297082DAC2D288D51C85966CEC550@DM6PR12MB2970.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(4326008)(8676002)(71190400001)(66066001)(102836004)(53936002)(6116002)(26005)(54906003)(103116003)(81166006)(86362001)(110136005)(25786009)(97736004)(81156014)(316002)(186003)(106356001)(105586002)(76176011)(7736002)(99286004)(14444005)(486006)(7416002)(305945005)(8936002)(71200400001)(2906002)(256004)(6436002)(2501003)(14454004)(446003)(478600001)(52116002)(6506007)(386003)(72206003)(6512007)(5660300002)(3846002)(11346002)(9686003)(68736007)(476003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2970;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zgtMSRqWUZLi8a+UVJm2u8tWrT2wnd7EKikzdSVDVdOyse0le/l5vyZEuIk3jVzenjeHMniTT4/bRvt7flcpVdMLu9EYqiRMDTCqi0ekBXSeaCffRiXNY8KFczkagyuQiDPoAPPuPN0Ee4jWu3M3Oa13AXsSC987A5it9IMzUfUX06WeTDbF5DZrmcZCBGh4bVVpJ4qFRMGrDGlu9q3HGQSSDweIjVCC3Z+XcOWUO2x0yjvBsDTM7SYrgrqEFm6lQ3yCuCNJeoRu/4hN2lgN+UAi5QgDzfmA1pcgbtZu49Q/dFh8001QsLhyZ09LlHuYFU3IENEpM2RKvP23DR1AAYGVxQwxLMM6nENNWZoYQ/s+WsBR0Ydj0xtiGea3IyllC8cb6VpVeWpdieCA6yDIyDt3oSebOLoFxExL4xl4mgc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA0DEC127041344BA7661F7173E85242@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77835705-8ace-4d14-d48d-08d6b6eb8a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:46:48.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
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
IHRoYXQgaXQgZGlkIG5vdCBoYW5kbGUgdGhlIE5NSS4NCg0KQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPiAjIDQuMTQueC0NClNpZ25lZC1vZmYtYnk6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxl
bmRhY2t5QGFtZC5jb20+DQotLS0NCiBhcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYyB8ICAgNTYg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0KaW5k
ZXggYmViMTMyNTkzNjIyLi45M2VmNTM3MTMzNTkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9ldmVu
dHMvYW1kL2NvcmUuYw0KKysrIGIvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMNCkBAIC01LDkg
KzUsMTIgQEANCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9kZWxh
eS5oPg0KICNpbmNsdWRlIDxhc20vYXBpY2RlZi5oPg0KKyNpbmNsdWRlIDxhc20vbm1pLmg+DQog
DQogI2luY2x1ZGUgIi4uL3BlcmZfZXZlbnQuaCINCiANCitzdGF0aWMgREVGSU5FX1BFUl9DUFUo
dW5zaWduZWQgaW50LCBwZXJmX25taV9jb3VudGVyKTsNCisNCiBzdGF0aWMgX19pbml0Y29uc3Qg
Y29uc3QgdTY0IGFtZF9od19jYWNoZV9ldmVudF9pZHMNCiAJCQkJW1BFUkZfQ09VTlRfSFdfQ0FD
SEVfTUFYXQ0KIAkJCQlbUEVSRl9DT1VOVF9IV19DQUNIRV9PUF9NQVhdDQpAQCAtNDg3LDYgKzQ5
MCw1NyBAQCBzdGF0aWMgdm9pZCBhbWRfcG11X2Rpc2FibGVfYWxsKHZvaWQpDQogCX0NCiB9DQog
DQorLyoNCisgKiBCZWNhdXNlIG9mIE5NSSBsYXRlbmN5LCBpZiBtdWx0aXBsZSBQTUMgY291bnRl
cnMgYXJlIGFjdGl2ZSBvciBvdGhlciBzb3VyY2VzDQorICogb2YgTk1JcyBhcmUgcmVjZWl2ZWQs
IHRoZSBwZXJmIE5NSSBoYW5kbGVyIGNhbiBoYW5kbGUgb25lIG9yIG1vcmUgb3ZlcmZsb3dlZA0K
KyAqIFBNQyBjb3VudGVycyBvdXRzaWRlIG9mIHRoZSBOTUkgYXNzb2NpYXRlZCB3aXRoIHRoZSBQ
TUMgb3ZlcmZsb3cuIElmIHRoZSBOTUkNCisgKiBkb2Vzbid0IGFycml2ZSBhdCB0aGUgTEFQSUMg
aW4gdGltZSB0byBiZWNvbWUgYSBwZW5kaW5nIE5NSSwgdGhlbiB0aGUga2VybmVsDQorICogYmFj
ay10by1iYWNrIE5NSSBzdXBwb3J0IHdvbid0IGJlIGFjdGl2ZS4gVGhpcyBQTUMgaGFuZGxlciBu
ZWVkcyB0byB0YWtlIGludG8NCisgKiBhY2NvdW50IHRoYXQgdGhpcyBjYW4gb2NjdXIsIG90aGVy
d2lzZSB0aGlzIGNvdWxkIHJlc3VsdCBpbiB1bmtub3duIE5NSQ0KKyAqIG1lc3NhZ2VzIGJlaW5n
IGlzc3VlZC4gRXhhbXBsZXMgb2YgdGhpcyBpcyBQTUMgb3ZlcmZsb3cgd2hpbGUgaW4gdGhlIE5N
SQ0KKyAqIGhhbmRsZXIgd2hlbiBtdWx0aXBsZSBQTUNzIGFyZSBhY3RpdmUgb3IgUE1DIG92ZXJm
bG93IHdoaWxlIGhhbmRsaW5nIHNvbWUNCisgKiBvdGhlciBzb3VyY2Ugb2YgYW4gTk1JLg0KKyAq
DQorICogQXR0ZW1wdCB0byBtaXRpZ2F0ZSB0aGlzIGJ5IHVzaW5nIHRoZSBudW1iZXIgb2YgYWN0
aXZlIFBNQ3MgdG8gZGV0ZXJtaW5lDQorICogd2hldGhlciB0byByZXR1cm4gTk1JX0hBTkRMRUQg
aWYgdGhlIHBlcmYgTk1JIGhhbmRsZXIgZGlkIG5vdCBoYW5kbGUvcmVzZXQNCisgKiBhbnkgUE1D
cy4gVGhlIHBlci1DUFUgcGVyZl9ubWlfY291bnRlciB2YXJpYWJsZSBpcyBzZXQgdG8gYSBtaW5p
bXVtIG9mIHRoZQ0KKyAqIG51bWJlciBvZiBhY3RpdmUgUE1DcyBvciAyLiBUaGUgdmFsdWUgb2Yg
MiBpcyB1c2VkIGluIGNhc2UgYW4gTk1JIGRvZXMgbm90DQorICogYXJyaXZlIGF0IHRoZSBMQVBJ
QyBpbiB0aW1lIHRvIGJlIGNvbGxhcHNlZCBpbnRvIGFuIGFscmVhZHkgcGVuZGluZyBOTUkuDQor
ICovDQorc3RhdGljIGludCBhbWRfcG11X2hhbmRsZV9pcnEoc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
DQorew0KKwlzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YyA9IHRoaXNfY3B1X3B0cigmY3B1X2h3
X2V2ZW50cyk7DQorCWludCBhY3RpdmUsIGhhbmRsZWQ7DQorDQorCS8qDQorCSAqIE9idGFpbiB0
aGUgYWN0aXZlIGNvdW50IGJlZm9yZSBjYWxsaW5nIHg4Nl9wbXVfaGFuZGxlX2lycSgpIHNpbmNl
DQorCSAqIGl0IGlzIHBvc3NpYmxlIHRoYXQgeDg2X3BtdV9oYW5kbGVfaXJxKCkgbWF5IG1ha2Ug
YSBjb3VudGVyDQorCSAqIGluYWN0aXZlICh0aHJvdWdoIHg4Nl9wbXVfc3RvcCkuDQorCSAqLw0K
KwlhY3RpdmUgPSBfX2JpdG1hcF93ZWlnaHQoY3B1Yy0+YWN0aXZlX21hc2ssIFg4Nl9QTUNfSURY
X01BWCk7DQorDQorCS8qIFByb2Nlc3MgYW55IGNvdW50ZXIgb3ZlcmZsb3dzICovDQorCWhhbmRs
ZWQgPSB4ODZfcG11X2hhbmRsZV9pcnEocmVncyk7DQorDQorCS8qDQorCSAqIElmIGEgY291bnRl
ciB3YXMgaGFuZGxlZCwgcmVjb3JkIHRoZSBudW1iZXIgb2YgcG9zc2libGUgcmVtYWluaW5nDQor
CSAqIE5NSXMgdGhhdCBjYW4gb2NjdXIuDQorCSAqLw0KKwlpZiAoaGFuZGxlZCkgew0KKwkJdGhp
c19jcHVfd3JpdGUocGVyZl9ubWlfY291bnRlciwNCisJCQkgICAgICAgbWluX3QodW5zaWduZWQg
aW50LCAyLCBhY3RpdmUpKTsNCisNCisJCXJldHVybiBoYW5kbGVkOw0KKwl9DQorDQorCWlmICgh
dGhpc19jcHVfcmVhZChwZXJmX25taV9jb3VudGVyKSkNCisJCXJldHVybiBOTUlfRE9ORTsNCisN
CisJdGhpc19jcHVfZGVjKHBlcmZfbm1pX2NvdW50ZXIpOw0KKw0KKwlyZXR1cm4gTk1JX0hBTkRM
RUQ7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3QgZXZlbnRfY29uc3RyYWludCAqDQogYW1kX2dldF9l
dmVudF9jb25zdHJhaW50cyhzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YywgaW50IGlkeCwNCiAJ
CQkgIHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCkBAIC02NzksNyArNzMzLDcgQEAgc3RhdGlj
IHNzaXplX3QgYW1kX2V2ZW50X3N5c2ZzX3Nob3coY2hhciAqcGFnZSwgdTY0IGNvbmZpZykNCiAN
CiBzdGF0aWMgX19pbml0Y29uc3QgY29uc3Qgc3RydWN0IHg4Nl9wbXUgYW1kX3BtdSA9IHsNCiAJ
Lm5hbWUJCQk9ICJBTUQiLA0KLQkuaGFuZGxlX2lycQkJPSB4ODZfcG11X2hhbmRsZV9pcnEsDQor
CS5oYW5kbGVfaXJxCQk9IGFtZF9wbXVfaGFuZGxlX2lycSwNCiAJLmRpc2FibGVfYWxsCQk9IGFt
ZF9wbXVfZGlzYWJsZV9hbGwsDQogCS5lbmFibGVfYWxsCQk9IHg4Nl9wbXVfZW5hYmxlX2FsbCwN
CiAJLmVuYWJsZQkJCT0geDg2X3BtdV9lbmFibGVfZXZlbnQsDQoNCg==
