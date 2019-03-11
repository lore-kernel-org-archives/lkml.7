Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78196C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jtZoQk+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCKQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:48:48 -0400
Received: from mail-eopbgr720077.outbound.protection.outlook.com ([40.107.72.77]:27444
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKQss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha/AkOvp6lBvpUzy4kIEr4RqIU4kdZWrra9R2jiwPWE=;
 b=jtZoQk+e4jSnSFRCJxZQm5OBVU9zLtk1VO8nFIYpseIv2iHPTR2z9pGAv4iekbohNiTK/iqslSzO9HNXSDQI/FnIsb4cCvj2yQcqjhv+BLzJ37Va72+1pLLQod1JluKryox52yBE9LQwjMT5zMM5qLw/MHRyz2dfkN3dVP68LAc=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 16:48:44 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:48:44 +0000
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
Subject: [RFC PATCH 1/2] x86/perf/amd: Resolve race condition when disabling
 PMC
Thread-Topic: [RFC PATCH 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU2CpKo7pHNnmOoEW3d1kfA2Kibg==
Date:   Mon, 11 Mar 2019 16:48:44 +0000
Message-ID: <155232292270.21417.18139649076000959940.stgit@tlendack-t1.amdoffice.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb3e4a7-ac52-418e-3624-08d6a6416c7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2891;
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2891;20:0kyTGNsLP2v36YDGsBwRKk+6QQIEPtitFCP8wQL3ZRRgT3TOEjMtouKcYpcOoYV6qlWNcAMbtcoBVKdM1j3NiDxlxpd6aPrJD4iIORxIeJuJMXdXUMtkenzBepzTTeTEL+edet2X2jxhMkhRw0DIoABz0nLlMXPGB5lcNQJX2ifxcAA/6geg3yNDHYPGd8w7UAgsgbmNA93yDprT5dPr3MdSAy/aQEEfH2icoIBe07emDHWzCFFD4fAKDnBs9dlD
x-microsoft-antispam-prvs: <DM6PR12MB2891E52654837830BC1E9EABEC480@DM6PR12MB2891.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(4326008)(25786009)(6116002)(72206003)(103116003)(9686003)(102836004)(66066001)(68736007)(186003)(476003)(11346002)(446003)(256004)(478600001)(8676002)(71200400001)(6436002)(97736004)(6486002)(81156014)(81166006)(71190400001)(14444005)(6512007)(86362001)(316002)(110136005)(54906003)(2906002)(106356001)(7416002)(105586002)(2501003)(53936002)(5660300002)(3846002)(14454004)(486006)(26005)(8936002)(7736002)(305945005)(52116002)(76176011)(6506007)(386003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2891;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WVrs+cQLae7XRdILpNOyWRxo52kyxXz6XDJwLt9IKqDVDyeTa3K6Y3wIAHS6V2hSac1ZkIR3Aovav48U46qsPlK/aMlr28uPeawbvNUJsDA+gGC3fYdA8JExpplOzNnla2AvytNOuYsslDu1o9Av2p8Wpjrh0MtAsCpkYhZlRLZD2bgey3KGToSmmujc43FJHj0Bz70QDj8cnjlECkkg9lNrubhc0IXIIupWp9v8tovfSeedGXmHy7I2SMD39RKY7+f+jkfu0VTRd+cpw7nrORQi14/GuYbFt3fdMxf5X0H9b82DQ1+0YVqOmvSFikZHYAGXU1HG71+VPEI6Wa+lX0ZOlTpiMPblWppCc1IGMXjh4J9yWuWEYN4yYUJWbJunJeZlNXUaXvfKGlL/ZfTLiLiXrrguSVDu748tf1V/kk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97B576A56419FB4FB26C53C19AEC493B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb3e4a7-ac52-418e-3624-08d6a6416c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:48:44.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
bHVlIG11c3QgYmUgY2hlY2tlZCBhZnRlcg0KZGlzYWJsaW5nIHRoZSBjb3VudGVyIGluIHg4Nl9w
bXVfZGlzYWJsZV9hbGwoKSwgYW5kLCBpZiBvdmVyZmxvd2VkLCBtdXN0DQp3YWl0IGZvciB0aGUg
Tk1JIGhhbmRsZXIgdG8gcmVzZXQgdGhlIHZhbHVlIGJlZm9yZSBjb250aW51aW5nLiBBZGQgYSBu
ZXcsDQpvcHRpb25hbCwgY2FsbGFibGUgZnVuY3Rpb24gdGhhdCBjYW4gYmUgdXNlZCB0byB0ZXN0
IGZvciBhbmQgcmVzb2x2ZSB0aGlzDQpjb25kaXRpb24uDQoNCkNjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4gIyA0LjE0LngtDQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5s
ZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgICB8ICAg
MzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogYXJjaC94ODYvZXZl
bnRzL2NvcmUuYyAgICAgICB8ICAgIDMgKysrDQogYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQu
aCB8ICAgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2Nv
cmUuYw0KaW5kZXggN2QyZDdjODAxZGJhLi5kOTg5NjQwZmE4N2QgMTAwNjQ0DQotLS0gYS9hcmNo
L3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0KKysrIGIvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMN
CkBAIC0zLDYgKzMsNyBAQA0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KICNpbmNsdWRlIDxs
aW51eC9pbml0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCisjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4NCiAjaW5jbHVkZSA8YXNtL2FwaWNkZWYuaD4NCiANCiAjaW5jbHVkZSAiLi4vcGVy
Zl9ldmVudC5oIg0KQEAgLTQyOSw2ICs0MzAsNDMgQEAgc3RhdGljIHZvaWQgYW1kX3BtdV9jcHVf
ZGVhZChpbnQgY3B1KQ0KIAl9DQogfQ0KIA0KKyNkZWZpbmUgT1ZFUkZMT1dfV0FJVF9DT1VOVAk1
MA0KKw0KK3N0YXRpYyB2b2lkIGFtZF9wbXVfd2FpdF9vbl9vdmVyZmxvdyhpbnQgaWR4LCB1NjQg
Y29uZmlnKQ0KK3sNCisJdW5zaWduZWQgaW50IGk7DQorCXU2NCBjb3VudGVyOw0KKw0KKwkvKg0K
KwkgKiBXZSBzaG91bGRuJ3QgYmUgY2FsbGluZyB0aGlzIGZyb20gTk1JIGNvbnRleHQsIGJ1dCBh
ZGQgYSBzYWZlZ3VhcmQNCisJICogaGVyZSB0byByZXR1cm4sIHNpbmNlIGlmIHdlJ3JlIGluIE5N
SSBjb250ZXh0IHdlIGNhbid0IHdhaXQgZm9yIGFuDQorCSAqIE5NSSB0byByZXNldCBhbiBvdmVy
Zmxvd2VkIGNvdW50ZXIgdmFsdWUuDQorCSAqLw0KKwlpZiAoaW5fbm1pKCkpDQorCQlyZXR1cm47
DQorDQorCS8qDQorCSAqIElmIHRoZSBpbnRlcnJ1cHQgaXNuJ3QgZW5hYmxlZCB0aGVuIHdlIHdv
bid0IGdldCB0aGUgTk1JIHRoYXQgd2lsbA0KKwkgKiByZXNldCB0aGUgb3ZlcmZsb3cgY29uZGl0
aW9uLCBzbyByZXR1cm4uDQorCSAqLw0KKwlpZiAoIShjb25maWcgJiBBUkNIX1BFUkZNT05fRVZF
TlRTRUxfSU5UKSkNCisJCXJldHVybjsNCisNCisJLyoNCisJICogV2FpdCBmb3IgdGhlIGNvdW50
ZXIgdG8gYmUgcmVzZXQgaWYgaXQgaGFzIG92ZXJmbG93ZWQuIFRoaXMgbG9vcA0KKwkgKiBzaG91
bGQgZXhpdCB2ZXJ5LCB2ZXJ5IHF1aWNrbHksIGJ1dCBqdXN0IGluIGNhc2UsIGRvbid0IHdhaXQN
CisJICogZm9yZXZlci4uLg0KKwkgKi8NCisJZm9yIChpID0gMDsgaSA8IE9WRVJGTE9XX1dBSVRf
Q09VTlQ7IGkrKykgew0KKwkJcmRtc3JsKHg4Nl9wbXVfZXZlbnRfYWRkcihpZHgpLCBjb3VudGVy
KTsNCisJCWlmIChjb3VudGVyICYgKDFVTEwgPDwgKHg4Nl9wbXUuY250dmFsX2JpdHMgLSAxKSkp
DQorCQkJYnJlYWs7DQorDQorCQkvKiBNaWdodCBiZSBpbiBJUlEgY29udGV4dCwgc28gY2FuJ3Qg
c2xlZXAgKi8NCisJCXVkZWxheSgxKTsNCisJfQ0KK30NCisNCiBzdGF0aWMgc3RydWN0IGV2ZW50
X2NvbnN0cmFpbnQgKg0KIGFtZF9nZXRfZXZlbnRfY29uc3RyYWludHMoc3RydWN0IGNwdV9od19l
dmVudHMgKmNwdWMsIGludCBpZHgsDQogCQkJICBzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQpDQpA
QCAtNjUwLDYgKzY4OCw3IEBAIHN0YXRpYyBfX2luaXRjb25zdCBjb25zdCBzdHJ1Y3QgeDg2X3Bt
dSBhbWRfcG11ID0gew0KIAkuY3B1X2RlYWQJCT0gYW1kX3BtdV9jcHVfZGVhZCwNCiANCiAJLmFt
ZF9uYl9jb25zdHJhaW50cwk9IDEsDQorCS53YWl0X29uX292ZXJmbG93CT0gYW1kX3BtdV93YWl0
X29uX292ZXJmbG93LA0KIH07DQogDQogc3RhdGljIGludCBfX2luaXQgYW1kX2NvcmVfcG11X2lu
aXQodm9pZCkNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jIGIvYXJjaC94ODYv
ZXZlbnRzL2NvcmUuYw0KaW5kZXggYjY4NGYwMjk0ZjM1Li5mMWQyZjcwMDAwY2QgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVudHMvY29yZS5j
DQpAQCAtNjA2LDYgKzYwNiw5IEBAIHZvaWQgeDg2X3BtdV9kaXNhYmxlX2FsbCh2b2lkKQ0KIAkJ
CWNvbnRpbnVlOw0KIAkJdmFsICY9IH5BUkNIX1BFUkZNT05fRVZFTlRTRUxfRU5BQkxFOw0KIAkJ
d3Jtc3JsKHg4Nl9wbXVfY29uZmlnX2FkZHIoaWR4KSwgdmFsKTsNCisNCisJCWlmICh4ODZfcG11
LndhaXRfb25fb3ZlcmZsb3cpDQorCQkJeDg2X3BtdS53YWl0X29uX292ZXJmbG93KGlkeCwgdmFs
KTsNCiAJfQ0KIH0NCiANCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5o
IGIvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KaW5kZXggN2U3NWY0NzRiMDc2Li5hMzc0
OTBhMjZhMDkgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5oDQorKysg
Yi9hcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5oDQpAQCAtNjM2LDYgKzYzNiw3IEBAIHN0cnVj
dCB4ODZfcG11IHsNCiAJICogQU1EIGJpdHMNCiAJICovDQogCXVuc2lnbmVkIGludAlhbWRfbmJf
Y29uc3RyYWludHMgOiAxOw0KKwl2b2lkCQkoKndhaXRfb25fb3ZlcmZsb3cpKGludCBpZHgsIHU2
NCBjb25maWcpOw0KIA0KIAkvKg0KIAkgKiBFeHRyYSByZWdpc3RlcnMgZm9yIGV2ZW50cw0KDQo=
