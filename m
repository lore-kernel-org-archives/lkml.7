Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12349C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650720652
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCKB3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:29:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:20500 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfCKB3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:29:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2019 18:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,466,1544515200"; 
   d="scan'208";a="281478558"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2019 18:29:40 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 10 Mar 2019 18:29:39 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 10 Mar 2019 18:29:39 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.158]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.26]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 09:29:15 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
CC:     Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: RE: [PATCH v3 7/8] KVM:X86: Add XSS bit 11 and 12 support for CET
 xsaves/xrstors.
Thread-Topic: [PATCH v3 7/8] KVM:X86: Add XSS bit 11 and 12 support for CET
 xsaves/xrstors.
Thread-Index: AQHUzZ0zOJhj9UImbUKmOc6EWitiSaYBF9CAgASf7tA=
Date:   Mon, 11 Mar 2019 01:29:15 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172D0CBA3@SHSMSX101.ccr.corp.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-8-weijiang.yang@intel.com>
 <8643d7bf-15dd-858e-7973-c8796d6e9a92@redhat.com>
In-Reply-To: <8643d7bf-15dd-858e-7973-c8796d6e9a92@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2NmYjYzOTEtMWQ4OC00ZGNiLTgxNmItNGU4NTk1ODQzODU2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDdQaWtsWUJvbXJ0VlF4UmRMS0xZTjVrNnkxTTBxODVJXC96Z1pjYlNqRytEVlA4eUNaKzV4dmluQm5KazAya2MifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZvciBHdWVzdCBYU1MsIHJpZ2h0IG5vdywgb25seSBiaXQgMTEodXNlciBzdGF0ZXMpIGFu
ZCBiaXQgMTINCj4gPiAoc3VwZXJ2aXNvciBzdGF0ZXMpIGFyZSBzdXBwb3J0ZWQsIGlmIG90aGVy
IGJpdHMgYXJlIGJlaW5nIHNldCwgbmVlZA0KPiA+IHRvIG1vZGlmeSBLVk1fU1VQUE9SVEVEX1hT
UyBtYWNybyB0byBoYXZlIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBZ
aSBaIDx5aS56LnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5n
IFdlaWppYW5nIDx3ZWlqaWFuZy55YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94
ODYva3ZtL3ZteC5jIHwgOCArKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXguYyBpbmRleA0KPiA+IGQzMmNlZTllZTA3OS4uNjg5
MDhlZDdiMTUxIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2t2bS92bXguYw0KPiA+ICsrKyBi
L2FyY2gveDg2L2t2bS92bXguYw0KPiA+IEBAIC00Nyw2ICs0Nyw3IEBADQo+ID4gICNpbmNsdWRl
IDxhc20vdmlydGV4dC5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL21jZS5oPg0KPiA+ICAjaW5jbHVk
ZSA8YXNtL2ZwdS9pbnRlcm5hbC5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2ZwdS90eXBlcy5oPg0K
PiA+ICAjaW5jbHVkZSA8YXNtL3BlcmZfZXZlbnQuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9kZWJ1
Z3JlZy5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL2tleGVjLmg+DQo+ID4gQEAgLTQzMzYsMTIgKzQz
MzcsMTMgQEAgc3RhdGljIGludCB2bXhfc2V0X21zcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0
cnVjdCBtc3JfZGF0YSAqbXNyX2luZm8pDQo+ID4gIAljYXNlIE1TUl9JQTMyX1hTUzoNCj4gPiAg
CQlpZiAoIXZteF94c2F2ZXNfc3VwcG9ydGVkKCkpDQo+ID4gIAkJCXJldHVybiAxOw0KPiA+ICsN
Cj4gPiAgCQkvKg0KPiA+IC0JCSAqIFRoZSBvbmx5IHN1cHBvcnRlZCBiaXQgYXMgb2YgU2t5bGFr
ZSBpcyBiaXQgOCwgYnV0DQo+ID4gLQkJICogaXQgaXMgbm90IHN1cHBvcnRlZCBvbiBLVk0uDQo+
ID4gKwkJICogQ2hlY2sgYml0cyBiZWluZyBzZXQgYXJlIHN1cHBvcnRlZCBpbiBLVk0uDQo+ID4g
IAkJICovDQo+ID4gLQkJaWYgKGRhdGEgIT0gMCkNCj4gPiArCQlpZiAoZGF0YSAmIH5rdm1fc3Vw
cG9ydGVkX3hzcygpKQ0KPiA+ICAJCQlyZXR1cm4gMTsNCj4gPiArDQo+ID4gIAkJdmNwdS0+YXJj
aC5pYTMyX3hzcyA9IGRhdGE7DQo+ID4gIAkJaWYgKHZjcHUtPmFyY2guaWEzMl94c3MgIT0gaG9z
dF94c3MpDQo+ID4gIAkJCWFkZF9hdG9taWNfc3dpdGNoX21zcih2bXgsIE1TUl9JQTMyX1hTUywN
Cj4gPg0KPiANCj4gTHV3ZWksIGNhbiB5b3Ugd29yayB3aXRoIFdlaWppYW5nIHRvIGFkZCBYU0FW
RVMgc3VwcG9ydCBmb3IgUHJvY2Vzc29yIFRyYWNpbmc/DQoNCkhpIFBhb2xvLA0KICAgIEFzIHdl
IHRhbGsgbG9uZyB0aW1lIGJlZm9yZS4gSSB3aWxsIGRvIHRoYXQuDQoNClRoYW5rcywNCkx1d2Vp
IEthbmcNCg0KPiANCj4gUGFvbG8NCg==
