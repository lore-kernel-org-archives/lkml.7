Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D117AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8352084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="27EjAoJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfDAVrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:47:00 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:31677
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPBRXZu24BJtAVte9vb10wQ/hIMyZ7+eDTVThXsAjBk=;
 b=27EjAoJlm1qyR9KHkfhtcYUsp6Syq1rj2+5TGK/FZriRWO5P06dT25H8JNxXQV5UhveNwI93lJgBw8kD6nix4+gUgnshmdkbM9qQdRXxCovCorwlg11+IZaK+wCVH0xJ5DklKYd2gZlKo73f7eACfaLs3Nda+pbh4oe/NpEo0go=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2970.namprd12.prod.outlook.com (20.178.29.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 21:46:55 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 21:46:55 +0000
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
Subject: [RFC PATCH v3 3/3] x86/perf/amd: Remove need to check "running" bit
 in NMI handler
Thread-Topic: [RFC PATCH v3 3/3] x86/perf/amd: Remove need to check "running"
 bit in NMI handler
Thread-Index: AQHU6NRsGGzwCXGrrEa55lzD9WvHCA==
Date:   Mon, 1 Apr 2019 21:46:55 +0000
Message-ID: <155415521330.24457.17682624895095754774.stgit@tlendack-t1.amdoffice.net>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:805:f2::41) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 325979a9-cfe8-45b4-e35c-08d6b6eb8ebf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2970;
x-ms-traffictypediagnostic: DM6PR12MB2970:
x-microsoft-antispam-prvs: <DM6PR12MB2970BFE74554DAEF652C441DEC550@DM6PR12MB2970.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(43544003)(4326008)(8676002)(71190400001)(66066001)(102836004)(53936002)(6116002)(26005)(54906003)(103116003)(81166006)(86362001)(110136005)(25786009)(97736004)(81156014)(316002)(186003)(106356001)(105586002)(76176011)(7736002)(99286004)(14444005)(486006)(7416002)(305945005)(8936002)(71200400001)(2906002)(256004)(6436002)(2501003)(14454004)(446003)(478600001)(52116002)(6506007)(386003)(72206003)(6512007)(5660300002)(3846002)(11346002)(9686003)(68736007)(476003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2970;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x8Hbb7GZrqLvKtgkzOnQeXMVXdWPCOwAF4sTp2Qtwlr9iycR3priFM/HkWvln0zPha12RcMF++7JSMxM1cR4DKzKdtVDwE5ZkZnHqtM2+6jLeQ2dsw2fk3tJWR5GilkBhtETLw813ID6uFtIpzpi0km9IGtsWapc4orFJtoSpLeaWCMAlvd3UHI5XrZUW3fB6qCCMPNAhUnW1PgyEWJabm9v9oqEYb6Lehp1YFuBhhhMoLbet0Fq5MPtjbtgVK5nMIkSdz6xRIrdp0jdcb+SWHEbcamtgQAWnQEC4JAnTPwFhLElBOuKkxgnXtEKYsYmVtf7VMfyjKys4SG4ZHhInjUis3JMqoNoGJOFDkBhHrannTIO5tp/hSHCqMeKvqlUjicvWsAbMRsHKpFv91W3OScb4D/dTw2HcRtBRu/sppM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A5D6227EC7F5643A70C79971B409B8E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325979a9-cfe8-45b4-e35c-08d6b6eb8ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:46:55.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3B1cmlvdXMgaW50ZXJydXB0IHN1cHBvcnQgd2FzIGFkZGluZyB0byBwZXJmIGluIGNvbW1pdDoN
CjYzZTZiZTZkOThlMSAoInBlcmYsIHg4NjogQ2F0Y2ggc3B1cmlvdXMgaW50ZXJydXB0cyBhZnRl
ciBkaXNhYmxpbmcgY291bnRlcnMiKQ0KDQpUaGUgdHdvIHByZXZpb3VzIHBhdGNoZXMgKHJlc29s
dmluZyB0aGUgcmFjZSBjb25kaXRpb24gd2hlbiBkaXNhYmxpbmcgYQ0KUE1DIGFuZCBOTUkgbGF0
ZW5jeSBtaXRpZ2F0aW9uKSBhbGxvdyBmb3IgdGhlIHJlbW92YWwgb2YgdGhpcyBvbGRlcg0Kc3B1
cmlvdXMgaW50ZXJydXB0IHN1cHBvcnQuDQoNCkN1cnJlbnRseSBpbiB4ODZfcG11X3N0b3AoKSwg
dGhlIGJpdCBmb3IgdGhlIFBNQyBpbiB0aGUgYWN0aXZlX21hc2sgYml0bWFwDQppcyBjbGVhcmVk
IGJlZm9yZSBkaXNhYmxpbmcgdGhlIFBNQywgd2hpY2ggc2V0cyB1cCBhIHJhY2UgY29uZGl0aW9u
LiBUaGlzDQpyYWNlIGNvbmRpdGlvbiB3YXMgbWl0aWdhdGVkIGJ5IGludHJvZHVjaW5nIHRoZSBy
dW5uaW5nIGJpdG1hcC4gVGhhdCByYWNlDQpjb25kaXRpb24gY2FuIGJlIGVsaW1pbmF0ZWQgYnkg
Zmlyc3QgZGlzYWJsaW5nIHRoZSBQTUMsIHdhaXRpbmcgZm9yIFBNQw0KcmVzZXQgb24gb3ZlcmZs
b3cgYW5kIHRoZW4gY2xlYXJpbmcgdGhlIGJpdCBmb3IgdGhlIFBNQyBpbiB0aGUgYWN0aXZlX21h
c2sNCmJpdG1hcC4gVGhlIE5NSSBoYW5kbGVyIHdpbGwgbm90IHJlLWVuYWJsZSBhIGRpc2FibGVk
IGNvdW50ZXIuDQoNCklmIHg4Nl9wbXVfc3RvcCgpIGlzIGNhbGxlZCBmcm9tIHRoZSBwZXJmIE5N
SSBoYW5kbGVyLCB0aGUgTk1JIGxhdGVuY3kNCm1pdGlnYXRpb24gc3VwcG9ydCB3aWxsIGd1YXJk
IGFnYWluc3QgYW55IHVuaGFuZGxlZCBOTUkgbWVzc2FnZXMuDQoNCkNjOiA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4gIyA0LjE0LngtDQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21h
cy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgfCAg
IDE5ICsrKysrKysrKysrKysrKysrKy0NCiBhcmNoL3g4Ni9ldmVudHMvY29yZS5jICAgICB8ICAg
MTMgKysrLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYyBi
L2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQppbmRleCA5M2VmNTM3MTMzNTkuLmE1ZTMzZGIy
ZjE3YSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQorKysgYi9hcmNo
L3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0KQEAgLTQ5MCw2ICs0OTAsMjMgQEAgc3RhdGljIHZvaWQg
YW1kX3BtdV9kaXNhYmxlX2FsbCh2b2lkKQ0KIAl9DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGFtZF9w
bXVfZGlzYWJsZV9ldmVudChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQpDQorew0KKwl4ODZfcG11
X2Rpc2FibGVfZXZlbnQoZXZlbnQpOw0KKw0KKwkvKg0KKwkgKiBUaGlzIGNhbiBiZSBjYWxsZWQg
ZnJvbSBOTUkgY29udGV4dCAodmlhIHg4Nl9wbXVfc3RvcCkuIFRoZSBjb3VudGVyDQorCSAqIG1h
eSBoYXZlIG92ZXJmbG93ZWQsIGJ1dCBlaXRoZXIgd2F5LCB3ZSdsbCBuZXZlciBzZWUgaXQgZ2V0
IHJlc2V0DQorCSAqIGJ5IHRoZSBOTUkgaWYgd2UncmUgYWxyZWFkeSBpbiB0aGUgTk1JLiBBbmQg
dGhlIE5NSSBsYXRlbmN5IHN1cHBvcnQNCisJICogYmVsb3cgd2lsbCB0YWtlIGNhcmUgb2YgYW55
IHBlbmRpbmcgTk1JIHRoYXQgbWlnaHQgaGF2ZSBiZWVuDQorCSAqIGdlbmVyYXRlZCBieSB0aGUg
b3ZlcmZsb3cuDQorCSAqLw0KKwlpZiAoaW5fbm1pKCkpDQorCQlyZXR1cm47DQorDQorCWFtZF9w
bXVfd2FpdF9vbl9vdmVyZmxvdyhldmVudC0+aHcuaWR4KTsNCit9DQorDQogLyoNCiAgKiBCZWNh
dXNlIG9mIE5NSSBsYXRlbmN5LCBpZiBtdWx0aXBsZSBQTUMgY291bnRlcnMgYXJlIGFjdGl2ZSBv
ciBvdGhlciBzb3VyY2VzDQogICogb2YgTk1JcyBhcmUgcmVjZWl2ZWQsIHRoZSBwZXJmIE5NSSBo
YW5kbGVyIGNhbiBoYW5kbGUgb25lIG9yIG1vcmUgb3ZlcmZsb3dlZA0KQEAgLTczNyw3ICs3NTQs
NyBAQCBzdGF0aWMgX19pbml0Y29uc3QgY29uc3Qgc3RydWN0IHg4Nl9wbXUgYW1kX3BtdSA9IHsN
CiAJLmRpc2FibGVfYWxsCQk9IGFtZF9wbXVfZGlzYWJsZV9hbGwsDQogCS5lbmFibGVfYWxsCQk9
IHg4Nl9wbXVfZW5hYmxlX2FsbCwNCiAJLmVuYWJsZQkJCT0geDg2X3BtdV9lbmFibGVfZXZlbnQs
DQotCS5kaXNhYmxlCQk9IHg4Nl9wbXVfZGlzYWJsZV9ldmVudCwNCisJLmRpc2FibGUJCT0gYW1k
X3BtdV9kaXNhYmxlX2V2ZW50LA0KIAkuaHdfY29uZmlnCQk9IGFtZF9wbXVfaHdfY29uZmlnLA0K
IAkuc2NoZWR1bGVfZXZlbnRzCT0geDg2X3NjaGVkdWxlX2V2ZW50cywNCiAJLmV2ZW50c2VsCQk9
IE1TUl9LN19FVk5UU0VMMCwNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jIGIv
YXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KaW5kZXggZTJiMTQ0NzE5MmE4Li44MTkxMWUxMWExNWQg
MTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVu
dHMvY29yZS5jDQpAQCAtMTM0OSw4ICsxMzQ5LDkgQEAgdm9pZCB4ODZfcG11X3N0b3Aoc3RydWN0
IHBlcmZfZXZlbnQgKmV2ZW50LCBpbnQgZmxhZ3MpDQogCXN0cnVjdCBjcHVfaHdfZXZlbnRzICpj
cHVjID0gdGhpc19jcHVfcHRyKCZjcHVfaHdfZXZlbnRzKTsNCiAJc3RydWN0IGh3X3BlcmZfZXZl
bnQgKmh3YyA9ICZldmVudC0+aHc7DQogDQotCWlmIChfX3Rlc3RfYW5kX2NsZWFyX2JpdChod2Mt
PmlkeCwgY3B1Yy0+YWN0aXZlX21hc2spKSB7DQorCWlmICh0ZXN0X2JpdChod2MtPmlkeCwgY3B1
Yy0+YWN0aXZlX21hc2spKSB7DQogCQl4ODZfcG11LmRpc2FibGUoZXZlbnQpOw0KKwkJX19jbGVh
cl9iaXQoaHdjLT5pZHgsIGNwdWMtPmFjdGl2ZV9tYXNrKTsNCiAJCWNwdWMtPmV2ZW50c1tod2Mt
PmlkeF0gPSBOVUxMOw0KIAkJV0FSTl9PTl9PTkNFKGh3Yy0+c3RhdGUgJiBQRVJGX0hFU19TVE9Q
UEVEKTsNCiAJCWh3Yy0+c3RhdGUgfD0gUEVSRl9IRVNfU1RPUFBFRDsNCkBAIC0xNDQ3LDE2ICsx
NDQ4LDggQEAgaW50IHg4Nl9wbXVfaGFuZGxlX2lycShzdHJ1Y3QgcHRfcmVncyAqcmVncykNCiAJ
YXBpY193cml0ZShBUElDX0xWVFBDLCBBUElDX0RNX05NSSk7DQogDQogCWZvciAoaWR4ID0gMDsg
aWR4IDwgeDg2X3BtdS5udW1fY291bnRlcnM7IGlkeCsrKSB7DQotCQlpZiAoIXRlc3RfYml0KGlk
eCwgY3B1Yy0+YWN0aXZlX21hc2spKSB7DQotCQkJLyoNCi0JCQkgKiBUaG91Z2ggd2UgZGVhY3Rp
dmF0ZWQgdGhlIGNvdW50ZXIgc29tZSBjcHVzDQotCQkJICogbWlnaHQgc3RpbGwgZGVsaXZlciBz
cHVyaW91cyBpbnRlcnJ1cHRzIHN0aWxsDQotCQkJICogaW4gZmxpZ2h0LiBDYXRjaCB0aGVtOg0K
LQkJCSAqLw0KLQkJCWlmIChfX3Rlc3RfYW5kX2NsZWFyX2JpdChpZHgsIGNwdWMtPnJ1bm5pbmcp
KQ0KLQkJCQloYW5kbGVkKys7DQorCQlpZiAoIXRlc3RfYml0KGlkeCwgY3B1Yy0+YWN0aXZlX21h
c2spKQ0KIAkJCWNvbnRpbnVlOw0KLQkJfQ0KIA0KIAkJZXZlbnQgPSBjcHVjLT5ldmVudHNbaWR4
XTsNCiANCg0K
