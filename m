Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF73218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GzTlMbWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCOUk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:40:57 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:42268
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfCOUk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+7NF34frDnJmqBrNb51J5Q7wAuc0BleydOP7t+7vJY=;
 b=GzTlMbWcBZWhFozgZq4684yFfrwtjrkBOesW6DMvwVGR1fiO1AqMCmP8RIb4Hj8FPrxFMoC1HxGYOFgoISfBvUjUfRm0NvdH0BMeI+6x8Ft/B+7yzceIfQooMQucgjXer0ywOjG42A6Bdna14SOZl1EyM1a8W5moAJW6FnqfyJ0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3545.namprd12.prod.outlook.com (20.179.106.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 20:40:53 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 20:40:53 +0000
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
Subject: [RFC PATCH v2 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Topic: [RFC PATCH v2 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU229hNGOz+xaASEKkiW7L8jN5IA==
Date:   Fri, 15 Mar 2019 20:40:53 +0000
Message-ID: <155268245032.14761.7748666703519081877.stgit@tlendack-t1.amdoffice.net>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14828e7c-2499-40a3-90e3-08d6a986843d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3545;
x-ms-traffictypediagnostic: DM6PR12MB3545:
x-microsoft-antispam-prvs: <DM6PR12MB3545645A1286271F36AF441CEC440@DM6PR12MB3545.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(256004)(9686003)(305945005)(6506007)(486006)(86362001)(316002)(5660300002)(476003)(6436002)(76176011)(81166006)(6116002)(102836004)(81156014)(7416002)(52116002)(6486002)(66066001)(3846002)(103116003)(71200400001)(72206003)(71190400001)(2906002)(2501003)(68736007)(105586002)(186003)(26005)(8676002)(386003)(7736002)(14454004)(11346002)(478600001)(25786009)(446003)(99286004)(53936002)(110136005)(8936002)(54906003)(106356001)(97736004)(14444005)(4326008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3545;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FUUTQW158h19BHFquL+QMf/rsPYhzqwi+nBfnvsMmRoriJzPqkPYYV4+nvki0dYSidKwhFh7iL4oTtpa948ROnuwiHfwr+iFJd4WwktIZ1jhcc+4kvS1JHb+tlTHbHI6v7icTBf2vMQTe+LgMwyB6k0sCI07Y/UHV+TG2Tm4kEJLsef/Yq50ePPBaFeU3B9dkvuGFkuixPcHvQYtNUDpTxM0qz/zRi2Wd9qsBNdWJEM7Z0782nPCEG7Cv3gSfFfT52XXL0svY+bM7kn+2GDu42nah12vQuR8SsJWcyM/Ul0uIMyy3nr+Rbpyacx3LrqsnRKXd+6AIui0xGg5TkIS/+RuboEQholKVfFuyb7nWDsI0/pqIjZTo1RDNxdn6qb+dGeGu35vfRiAwYjQg2Oir+hIRVOhZaPsnkOVq1fBUP0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95B30D1A28001E4389EC7C5F754EEF26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14828e7c-2499-40a3-90e3-08d6a986843d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 20:40:53.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
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
QU1EIGZ1bmN0aW9uLCBhbWRfcG11X2Rpc2FibGVfYWxsKCksIHRvIGJlDQp1c2VkIGluIHBsYWNl
IG9mIHRoZSBjb21tb24geDg2X3BtdV9kaXNhYmxlX2FsbCgpIHRoYXQsIGFmdGVyIGRpc2FibGlu
Zw0KdGhlIGNvdW50ZXJzLCB3aWxsIHdhaXQgZm9yIHRoZSBOTUkgaGFuZGxlciB0byByZXNldCBh
bnkgYWN0aXZlIGFuZA0KZW5hYmxlZCBvdmVyZmxvd2VkIGNvdW50ZXIuDQoNCkNjOiA8c3RhYmxl
QHZnZXIua2VybmVsLm9yZz4gIyA0LjE0LngtDQpTaWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kg
PHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYvZXZlbnRzL2FtZC9jb3Jl
LmMgfCAgIDg1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQog
MSBmaWxlIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9hbWQv
Y29yZS5jDQppbmRleCA3ZDJkN2M4MDFkYmEuLjczMjQwMmRjZmZkYyAxMDA2NDQNCi0tLSBhL2Fy
Y2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUu
Yw0KQEAgLTMsNiArMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQogI2luY2x1ZGUg
PGxpbnV4L2luaXQuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KKyNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPg0KICNpbmNsdWRlIDxhc20vYXBpY2RlZi5oPg0KIA0KICNpbmNsdWRlICIuLi9w
ZXJmX2V2ZW50LmgiDQpAQCAtNDI5LDYgKzQzMCw4NCBAQCBzdGF0aWMgdm9pZCBhbWRfcG11X2Nw
dV9kZWFkKGludCBjcHUpDQogCX0NCiB9DQogDQorLyoNCisgKiBXaGVuIGEgUE1DIGNvdW50ZXIg
b3ZlcmZsb3dzLCBhbiBOTUkgaXMgdXNlZCB0byBwcm9jZXNzIHRoZSBldmVudCBhbmQNCisgKiBy
ZXNldCB0aGUgY291bnRlci4gTk1JIGxhdGVuY3kgY2FuIHJlc3VsdCBpbiB0aGUgY291bnRlciBi
ZWluZyB1cGRhdGVkDQorICogYmVmb3JlIHRoZSBOTUkgY2FuIHJ1biwgd2hpY2ggY2FuIHJlc3Vs
dCBpbiB3aGF0IGFwcGVhciB0byBiZSBzcHVyaW91cw0KKyAqIE5NSXMuIFRoaXMgZnVuY3Rpb24g
aXMgaW50ZW5kZWQgdG8gd2FpdCBmb3IgdGhlIE5NSSB0byBydW4gYW5kIHJlc2V0DQorICogdGhl
IGNvdW50ZXIgdG8gYXZvaWQgcG9zc2libGUgdW5oYW5kbGVkIE5NSSBtZXNzYWdlcy4NCisgKi8N
CisjZGVmaW5lIE9WRVJGTE9XX1dBSVRfQ09VTlQJNTANCitzdGF0aWMgdm9pZCBhbWRfcG11X3dh
aXRfb25fb3ZlcmZsb3coaW50IGlkeCkNCit7DQorCXVuc2lnbmVkIGludCBpOw0KKwl1NjQgY291
bnRlcjsNCisNCisJLyoNCisJICogV2FpdCBmb3IgdGhlIGNvdW50ZXIgdG8gYmUgcmVzZXQgaWYg
aXQgaGFzIG92ZXJmbG93ZWQuIFRoaXMgbG9vcA0KKwkgKiBzaG91bGQgZXhpdCB2ZXJ5LCB2ZXJ5
IHF1aWNrbHksIGJ1dCBqdXN0IGluIGNhc2UsIGRvbid0IHdhaXQNCisJICogZm9yZXZlci4uLg0K
KwkgKi8NCisJZm9yIChpID0gMDsgaSA8IE9WRVJGTE9XX1dBSVRfQ09VTlQ7IGkrKykgew0KKwkJ
cmRtc3JsKHg4Nl9wbXVfZXZlbnRfYWRkcihpZHgpLCBjb3VudGVyKTsNCisJCWlmIChjb3VudGVy
ICYgKDFVTEwgPDwgKHg4Nl9wbXUuY250dmFsX2JpdHMgLSAxKSkpDQorCQkJYnJlYWs7DQorDQor
CQkvKiBNaWdodCBiZSBpbiBJUlEgY29udGV4dCwgc28gY2FuJ3Qgc2xlZXAgKi8NCisJCXVkZWxh
eSgxKTsNCisJfQ0KK30NCisNCit2b2lkIGFtZF9wbXVfZGlzYWJsZV9hbGwodm9pZCkNCit7DQor
CXVuc2lnbmVkIGxvbmcgb3ZlcmZsb3dfY2hlY2tbQklUU19UT19MT05HUyhYODZfUE1DX0lEWF9N
QVgpXTsNCisJc3RydWN0IGNwdV9od19ldmVudHMgKmNwdWMgPSB0aGlzX2NwdV9wdHIoJmNwdV9o
d19ldmVudHMpOw0KKwlpbnQgaWR4Ow0KKw0KKwliaXRtYXBfemVybyhvdmVyZmxvd19jaGVjaywg
WDg2X1BNQ19JRFhfTUFYKTsNCisNCisJZm9yIChpZHggPSAwOyBpZHggPCB4ODZfcG11Lm51bV9j
b3VudGVyczsgaWR4KyspIHsNCisJCXU2NCB2YWw7DQorDQorCQlpZiAoIXRlc3RfYml0KGlkeCwg
Y3B1Yy0+YWN0aXZlX21hc2spKQ0KKwkJCWNvbnRpbnVlOw0KKw0KKwkJcmRtc3JsKHg4Nl9wbXVf
Y29uZmlnX2FkZHIoaWR4KSwgdmFsKTsNCisJCWlmICghKHZhbCAmIEFSQ0hfUEVSRk1PTl9FVkVO
VFNFTF9FTkFCTEUpKQ0KKwkJCWNvbnRpbnVlOw0KKw0KKwkJdmFsICY9IH5BUkNIX1BFUkZNT05f
RVZFTlRTRUxfRU5BQkxFOw0KKwkJd3Jtc3JsKHg4Nl9wbXVfY29uZmlnX2FkZHIoaWR4KSwgdmFs
KTsNCisNCisJCS8qDQorCQkgKiBJZiB0aGUgaW50ZXJydXB0IGlzIGVuYWJsZWQsIHRoaXMgY291
bnRlciBtdXN0IGJlIGNoZWNrZWQNCisJCSAqIGZvciBhbiBvdmVyZmxvdyBjb25kaXRpb24gdG8g
YXZvaWQgcG9zc2libHkgY2hhbmdpbmcgdGhlDQorCQkgKiBjb3VudGVyIHZhbHVlIGJlZm9yZSB0
aGUgTk1JIGhhbmRsZXIgcnVucy4NCisJCSAqLw0KKwkJaWYgKHZhbCAmIEFSQ0hfUEVSRk1PTl9F
VkVOVFNFTF9JTlQpDQorCQkJX19zZXRfYml0KGlkeCwgb3ZlcmZsb3dfY2hlY2spOw0KKwl9DQor
DQorCS8qDQorCSAqIFRoaXMgc2hvdWxkbid0IGJlIGNhbGxlZCBmcm9tIE5NSSBjb250ZXh0LCBi
dXQgYWRkIGEgc2FmZWd1YXJkIGhlcmUNCisJICogdG8gcmV0dXJuLCBzaW5jZSBpZiB3ZSdyZSBp
biBOTUkgY29udGV4dCB3ZSBjYW4ndCB3YWl0IGZvciBhbiBOTUkNCisJICogdG8gcmVzZXQgYW4g
b3ZlcmZsb3dlZCBjb3VudGVyIHZhbHVlLg0KKwkgKi8NCisJaWYgKGluX25taSgpKQ0KKwkJcmV0
dXJuOw0KKw0KKwkvKg0KKwkgKiBDaGVjayBlYWNoIGNvdW50ZXIgZm9yIG92ZXJmbG93IGFuZCB3
YWl0IGZvciBpdCB0byBiZSByZXNldCBieSB0aGUNCisJICogTk1JIGlmIGl0IGhhcyBvdmVyZmxv
d2VkLg0KKwkgKi8NCisJZm9yIChpZHggPSAwOyBpZHggPCB4ODZfcG11Lm51bV9jb3VudGVyczsg
aWR4KyspIHsNCisJCWlmICghdGVzdF9iaXQoaWR4LCBvdmVyZmxvd19jaGVjaykpDQorCQkJY29u
dGludWU7DQorDQorCQlhbWRfcG11X3dhaXRfb25fb3ZlcmZsb3coaWR4KTsNCisJfQ0KK30NCisN
CiBzdGF0aWMgc3RydWN0IGV2ZW50X2NvbnN0cmFpbnQgKg0KIGFtZF9nZXRfZXZlbnRfY29uc3Ry
YWludHMoc3RydWN0IGNwdV9od19ldmVudHMgKmNwdWMsIGludCBpZHgsDQogCQkJICBzdHJ1Y3Qg
cGVyZl9ldmVudCAqZXZlbnQpDQpAQCAtNjIyLDcgKzcwMSw3IEBAIHN0YXRpYyBzc2l6ZV90IGFt
ZF9ldmVudF9zeXNmc19zaG93KGNoYXIgKnBhZ2UsIHU2NCBjb25maWcpDQogc3RhdGljIF9faW5p
dGNvbnN0IGNvbnN0IHN0cnVjdCB4ODZfcG11IGFtZF9wbXUgPSB7DQogCS5uYW1lCQkJPSAiQU1E
IiwNCiAJLmhhbmRsZV9pcnEJCT0geDg2X3BtdV9oYW5kbGVfaXJxLA0KLQkuZGlzYWJsZV9hbGwJ
CT0geDg2X3BtdV9kaXNhYmxlX2FsbCwNCisJLmRpc2FibGVfYWxsCQk9IGFtZF9wbXVfZGlzYWJs
ZV9hbGwsDQogCS5lbmFibGVfYWxsCQk9IHg4Nl9wbXVfZW5hYmxlX2FsbCwNCiAJLmVuYWJsZQkJ
CT0geDg2X3BtdV9lbmFibGVfZXZlbnQsDQogCS5kaXNhYmxlCQk9IHg4Nl9wbXVfZGlzYWJsZV9l
dmVudCwNCkBAIC03MzIsNyArODExLDcgQEAgdm9pZCBhbWRfcG11X2VuYWJsZV92aXJ0KHZvaWQp
DQogCWNwdWMtPnBlcmZfY3RyX3ZpcnRfbWFzayA9IDA7DQogDQogCS8qIFJlbG9hZCBhbGwgZXZl
bnRzICovDQotCXg4Nl9wbXVfZGlzYWJsZV9hbGwoKTsNCisJYW1kX3BtdV9kaXNhYmxlX2FsbCgp
Ow0KIAl4ODZfcG11X2VuYWJsZV9hbGwoMCk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGFtZF9w
bXVfZW5hYmxlX3ZpcnQpOw0KQEAgLTc1MCw3ICs4MjksNyBAQCB2b2lkIGFtZF9wbXVfZGlzYWJs
ZV92aXJ0KHZvaWQpDQogCWNwdWMtPnBlcmZfY3RyX3ZpcnRfbWFzayA9IEFNRDY0X0VWRU5UU0VM
X0hPU1RPTkxZOw0KIA0KIAkvKiBSZWxvYWQgYWxsIGV2ZW50cyAqLw0KLQl4ODZfcG11X2Rpc2Fi
bGVfYWxsKCk7DQorCWFtZF9wbXVfZGlzYWJsZV9hbGwoKTsNCiAJeDg2X3BtdV9lbmFibGVfYWxs
KDApOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChhbWRfcG11X2Rpc2FibGVfdmlydCk7DQoNCg==
