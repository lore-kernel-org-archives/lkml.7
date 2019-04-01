Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927B32084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yn0T0j3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfDAVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:46:45 -0400
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:3819
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAVqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjkKRK8h+MlN8iUIypokgDPUe6oTw2TnHgLcFBwvZD4=;
 b=Yn0T0j3gS+j4LgtIUUCpS9dhh7JuS4BZzgTRz8MO+Sx9QAkCx2LcAvq3YGJ2kWaDtN8JeP7HI09qhHBknRwgvddOKpL1XCvCOXJcVQt4MqjQRv9QI37hY6aBbZa2dqvAEHbP78SxloMysNz9Hl6yVs5gKei76xrWbKs5gfq01eE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2970.namprd12.prod.outlook.com (20.178.29.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 21:46:41 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 21:46:41 +0000
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
Subject: [RFC PATCH v3 1/3] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Topic: [RFC PATCH v3 1/3] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU6NRjKCg+mm4JrEK+PhIB9aVkEg==
Date:   Mon, 1 Apr 2019 21:46:40 +0000
Message-ID: <155415519893.24457.12466192794247670430.stgit@tlendack-t1.amdoffice.net>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0089.namprd05.prod.outlook.com
 (2603:10b6:803:22::27) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0da5f49a-0af0-4587-ba39-08d6b6eb8640
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2970;
x-ms-traffictypediagnostic: DM6PR12MB2970:
x-microsoft-antispam-prvs: <DM6PR12MB29702B3B3B700E1167AC5AF6EC550@DM6PR12MB2970.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(4326008)(8676002)(71190400001)(66066001)(102836004)(53936002)(6116002)(26005)(54906003)(103116003)(81166006)(86362001)(110136005)(25786009)(97736004)(81156014)(316002)(186003)(106356001)(105586002)(76176011)(7736002)(99286004)(14444005)(486006)(7416002)(305945005)(8936002)(71200400001)(2906002)(256004)(6436002)(2501003)(14454004)(446003)(478600001)(52116002)(6506007)(386003)(72206003)(6512007)(5660300002)(3846002)(11346002)(9686003)(68736007)(476003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2970;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tStNqIT+QnHWwZvYVCS2bmmCcf89+xF1egLNbDGh2TD4Xk2M0CzxXCHHmegrFu+cnNk8Ml+GR/0cwHVy/NXIdKiVLq+c7mqxXlGWYr8qhiyyUFT7wpYpNxjdNTRlWrcAYSjQO6AdmihwWhLqCj2tC7pY8iYOkyyclg9V7gmF22jOXptGXX3xjLmBDoz1DHtNRDoz4NmJJeekUdMu/UBeAqgl6d6U/9Aso5RwIkUoVGzM+fVDPs+h1IFlCg/TD1aehaBesk54BH30eVv0BNGaEDe7TPnDbtFyy3XjfyXrv80D8tHBrZV7/LK3YOYa+24mhUT0sQ+F+QMCyVONhGqMvwsOpuFG0dqO67wXQ1luKDIx59gnSOOp/jm+oDWqD6oU3eTTFJdTTZo4FHzTUC+Ik+lE64PiTFTONQWgLquKjfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCFD66EE3C06D1468E5AC2FA3C71B13C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da5f49a-0af0-4587-ba39-08d6b6eb8640
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:46:40.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gQU1EIHByb2Nlc3NvcnMsIHRoZSBkZXRlY3Rpb24gb2YgYW4gb3ZlcmZsb3dlZCBjb3VudGVy
IGluIHRoZSBOTUkNCmhhbmRsZXIgcmVsaWVzIG9uIHRoZSBjdXJyZW50IHZhbHVlIG9mIHRoZSBj
b3VudGVyLiBTbywgZm9yIGV4YW1wbGUsIHRvDQpjaGVjayBmb3Igb3ZlcmZsb3cgb24gYSA0OCBi
aXQgY291bnRlciwgYml0IDQ3IGlzIGNoZWNrZWQgdG8gc2VlIGlmIGl0DQppcyAxIChub3Qgb3Zl
cmZsb3dlZCkgb3IgMCAob3ZlcmZsb3dlZCkuDQoNClRoZXJlIGlzIGN1cnJlbnRseSBhIHJhY2Ug
Y29uZGl0aW9uIHByZXNlbnQgd2hlbiBkaXNhYmxpbmcgYW5kIHRoZW4NCnVwZGF0aW5nIHRoZSBQ
TUMuIEluY3JlYXNlZCBOTUkgbGF0ZW5jeSBpbiBuZXdlciBBTUQgcHJvY2Vzc29ycyBtYWtlcyB0
aGlzDQpyYWNlIGNvbmRpdGlvbiBtb3JlIHByb25vdW5jZWQuIElmIHRoZSBjb3VudGVyIHZhbHVl
IGhhcyBvdmVyZmxvd2VkLCBpdCBpcw0KcG9zc2libGUgdG8gdXBkYXRlIHRoZSBQTUMgdmFsdWUg
YmVmb3JlIHRoZSBOTUkgaGFuZGxlciBjYW4gcnVuLiBUaGUNCnVwZGF0ZWQgUE1DIHZhbHVlIGlz
IG5vdCBhbiBvdmVyZmxvd2VkIHZhbHVlLCBzbyB3aGVuIHRoZSBwZXJmIE5NSSBoYW5kbGVyDQpk
b2VzIHJ1biwgaXQgd2lsbCBub3QgZmluZCBhbiBvdmVyZmxvd2VkIGNvdW50ZXIuIFRoaXMgbWF5
IGFwcGVhciBhcyBhbg0KdW5rbm93biBOTUkgcmVzdWx0aW5nIGluIGVpdGhlciBhIHBhbmljIG9y
IGEgc2VyaWVzIG9mIG1lc3NhZ2VzLCBkZXBlbmRpbmcNCm9uIGhvdyB0aGUga2VybmVsIGlzIGNv
bmZpZ3VyZWQuDQoNClRvIGVsaW1pbmF0ZSB0aGlzIHJhY2UgY29uZGl0aW9uLCB0aGUgUE1DIHZh
bHVlIG11c3QgYmUgY2hlY2tlZCBhZnRlcg0KZGlzYWJsaW5nIHRoZSBjb3VudGVyLiBBZGQgYW4g
QU1EIGZ1bmN0aW9uLCBhbWRfcG11X2Rpc2FibGVfYWxsKCksIHRoYXQNCndpbGwgd2FpdCBmb3Ig
dGhlIE5NSSBoYW5kbGVyIHRvIHJlc2V0IGFueSBhY3RpdmUgYW5kIG92ZXJmbG93ZWQgY291bnRl
cg0KYWZ0ZXIgY2FsbGluZyB4ODZfcG11X2Rpc2FibGVfYWxsKCkuDQoNCkNjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4gIyA0LjE0LngtDQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRo
b21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMg
fCAgIDY0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBm
aWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9hbWQvY29y
ZS5jDQppbmRleCA3ZDJkN2M4MDFkYmEuLmJlYjEzMjU5MzYyMiAxMDA2NDQNCi0tLSBhL2FyY2gv
eDg2L2V2ZW50cy9hbWQvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0K
QEAgLTMsNiArMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2luaXQuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KKyNpbmNsdWRlIDxsaW51eC9k
ZWxheS5oPg0KICNpbmNsdWRlIDxhc20vYXBpY2RlZi5oPg0KIA0KICNpbmNsdWRlICIuLi9wZXJm
X2V2ZW50LmgiDQpAQCAtNDI5LDYgKzQzMCw2MyBAQCBzdGF0aWMgdm9pZCBhbWRfcG11X2NwdV9k
ZWFkKGludCBjcHUpDQogCX0NCiB9DQogDQorLyoNCisgKiBXaGVuIGEgUE1DIGNvdW50ZXIgb3Zl
cmZsb3dzLCBhbiBOTUkgaXMgdXNlZCB0byBwcm9jZXNzIHRoZSBldmVudCBhbmQNCisgKiByZXNl
dCB0aGUgY291bnRlci4gTk1JIGxhdGVuY3kgY2FuIHJlc3VsdCBpbiB0aGUgY291bnRlciBiZWlu
ZyB1cGRhdGVkDQorICogYmVmb3JlIHRoZSBOTUkgY2FuIHJ1biwgd2hpY2ggY2FuIHJlc3VsdCBp
biB3aGF0IGFwcGVhciB0byBiZSBzcHVyaW91cw0KKyAqIE5NSXMuIFRoaXMgZnVuY3Rpb24gaXMg
aW50ZW5kZWQgdG8gd2FpdCBmb3IgdGhlIE5NSSB0byBydW4gYW5kIHJlc2V0DQorICogdGhlIGNv
dW50ZXIgdG8gYXZvaWQgcG9zc2libGUgdW5oYW5kbGVkIE5NSSBtZXNzYWdlcy4NCisgKi8NCisj
ZGVmaW5lIE9WRVJGTE9XX1dBSVRfQ09VTlQJNTANCitzdGF0aWMgdm9pZCBhbWRfcG11X3dhaXRf
b25fb3ZlcmZsb3coaW50IGlkeCkNCit7DQorCXVuc2lnbmVkIGludCBpOw0KKwl1NjQgY291bnRl
cjsNCisNCisJLyoNCisJICogV2FpdCBmb3IgdGhlIGNvdW50ZXIgdG8gYmUgcmVzZXQgaWYgaXQg
aGFzIG92ZXJmbG93ZWQuIFRoaXMgbG9vcA0KKwkgKiBzaG91bGQgZXhpdCB2ZXJ5LCB2ZXJ5IHF1
aWNrbHksIGJ1dCBqdXN0IGluIGNhc2UsIGRvbid0IHdhaXQNCisJICogZm9yZXZlci4uLg0KKwkg
Ki8NCisJZm9yIChpID0gMDsgaSA8IE9WRVJGTE9XX1dBSVRfQ09VTlQ7IGkrKykgew0KKwkJcmRt
c3JsKHg4Nl9wbXVfZXZlbnRfYWRkcihpZHgpLCBjb3VudGVyKTsNCisJCWlmIChjb3VudGVyICYg
KDFVTEwgPDwgKHg4Nl9wbXUuY250dmFsX2JpdHMgLSAxKSkpDQorCQkJYnJlYWs7DQorDQorCQkv
KiBNaWdodCBiZSBpbiBJUlEgY29udGV4dCwgc28gY2FuJ3Qgc2xlZXAgKi8NCisJCXVkZWxheSgx
KTsNCisJfQ0KK30NCisNCitzdGF0aWMgdm9pZCBhbWRfcG11X2Rpc2FibGVfYWxsKHZvaWQpDQor
ew0KKwlzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YyA9IHRoaXNfY3B1X3B0cigmY3B1X2h3X2V2
ZW50cyk7DQorCWludCBpZHg7DQorDQorCXg4Nl9wbXVfZGlzYWJsZV9hbGwoKTsNCisNCisJLyoN
CisJICogVGhpcyBzaG91bGRuJ3QgYmUgY2FsbGVkIGZyb20gTk1JIGNvbnRleHQsIGJ1dCBhZGQg
YSBzYWZlZ3VhcmQgaGVyZQ0KKwkgKiB0byByZXR1cm4sIHNpbmNlIGlmIHdlJ3JlIGluIE5NSSBj
b250ZXh0IHdlIGNhbid0IHdhaXQgZm9yIGFuIE5NSQ0KKwkgKiB0byByZXNldCBhbiBvdmVyZmxv
d2VkIGNvdW50ZXIgdmFsdWUuDQorCSAqLw0KKwlpZiAoaW5fbm1pKCkpDQorCQlyZXR1cm47DQor
DQorCS8qDQorCSAqIENoZWNrIGVhY2ggY291bnRlciBmb3Igb3ZlcmZsb3cgYW5kIHdhaXQgZm9y
IGl0IHRvIGJlIHJlc2V0IGJ5IHRoZQ0KKwkgKiBOTUkgaWYgaXQgaGFzIG92ZXJmbG93ZWQuIFRo
aXMgcmVsaWVzIG9uIHRoZSBmYWN0IHRoYXQgYWxsIGFjdGl2ZQ0KKwkgKiBjb3VudGVycyBhcmUg
YWx3YXlzIGVuYWJsZWQgd2hlbiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGVkIGFuZA0KKwkgKiBBUkNI
X1BFUkZNT05fRVZFTlRTRUxfSU5UIGlzIGFsd2F5cyBzZXQuDQorCSAqLw0KKwlmb3IgKGlkeCA9
IDA7IGlkeCA8IHg4Nl9wbXUubnVtX2NvdW50ZXJzOyBpZHgrKykgew0KKwkJaWYgKCF0ZXN0X2Jp
dChpZHgsIGNwdWMtPmFjdGl2ZV9tYXNrKSkNCisJCQljb250aW51ZTsNCisNCisJCWFtZF9wbXVf
d2FpdF9vbl9vdmVyZmxvdyhpZHgpOw0KKwl9DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3QgZXZlbnRf
Y29uc3RyYWludCAqDQogYW1kX2dldF9ldmVudF9jb25zdHJhaW50cyhzdHJ1Y3QgY3B1X2h3X2V2
ZW50cyAqY3B1YywgaW50IGlkeCwNCiAJCQkgIHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCkBA
IC02MjIsNyArNjgwLDcgQEAgc3RhdGljIHNzaXplX3QgYW1kX2V2ZW50X3N5c2ZzX3Nob3coY2hh
ciAqcGFnZSwgdTY0IGNvbmZpZykNCiBzdGF0aWMgX19pbml0Y29uc3QgY29uc3Qgc3RydWN0IHg4
Nl9wbXUgYW1kX3BtdSA9IHsNCiAJLm5hbWUJCQk9ICJBTUQiLA0KIAkuaGFuZGxlX2lycQkJPSB4
ODZfcG11X2hhbmRsZV9pcnEsDQotCS5kaXNhYmxlX2FsbAkJPSB4ODZfcG11X2Rpc2FibGVfYWxs
LA0KKwkuZGlzYWJsZV9hbGwJCT0gYW1kX3BtdV9kaXNhYmxlX2FsbCwNCiAJLmVuYWJsZV9hbGwJ
CT0geDg2X3BtdV9lbmFibGVfYWxsLA0KIAkuZW5hYmxlCQkJPSB4ODZfcG11X2VuYWJsZV9ldmVu
dCwNCiAJLmRpc2FibGUJCT0geDg2X3BtdV9kaXNhYmxlX2V2ZW50LA0KQEAgLTczMiw3ICs3OTAs
NyBAQCB2b2lkIGFtZF9wbXVfZW5hYmxlX3ZpcnQodm9pZCkNCiAJY3B1Yy0+cGVyZl9jdHJfdmly
dF9tYXNrID0gMDsNCiANCiAJLyogUmVsb2FkIGFsbCBldmVudHMgKi8NCi0JeDg2X3BtdV9kaXNh
YmxlX2FsbCgpOw0KKwlhbWRfcG11X2Rpc2FibGVfYWxsKCk7DQogCXg4Nl9wbXVfZW5hYmxlX2Fs
bCgwKTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoYW1kX3BtdV9lbmFibGVfdmlydCk7DQpAQCAt
NzUwLDcgKzgwOCw3IEBAIHZvaWQgYW1kX3BtdV9kaXNhYmxlX3ZpcnQodm9pZCkNCiAJY3B1Yy0+
cGVyZl9jdHJfdmlydF9tYXNrID0gQU1ENjRfRVZFTlRTRUxfSE9TVE9OTFk7DQogDQogCS8qIFJl
bG9hZCBhbGwgZXZlbnRzICovDQotCXg4Nl9wbXVfZGlzYWJsZV9hbGwoKTsNCisJYW1kX3BtdV9k
aXNhYmxlX2FsbCgpOw0KIAl4ODZfcG11X2VuYWJsZV9hbGwoMCk7DQogfQ0KIEVYUE9SVF9TWU1C
T0xfR1BMKGFtZF9wbXVfZGlzYWJsZV92aXJ0KTsNCg0K
