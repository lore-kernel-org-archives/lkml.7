Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA9320643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="saHUvFep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCKQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:48:55 -0400
Received: from mail-eopbgr720074.outbound.protection.outlook.com ([40.107.72.74]:17046
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLsGENjE4BEMJa0J60nEPeYQG7Yv7xYnIpkuihp0U1I=;
 b=saHUvFepLX7YBiKYpCYgoNogrBZvrhmnXJe1gcGSbgIBQ5UZUSzfOIXuUtVpEanDIlD5NA3/ODKRrmSUtC/mgdO/ASnM/AZqsAW3UA4FGe/NiuWrAoCUoen6+Ed+wlAXFWWlYPFCOuRJw40VNh+h20JVdak8U4+tEOQry61d9W0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 16:48:51 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:48:51 +0000
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
Subject: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Topic: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Thread-Index: AQHU2CpOuC8N+vFHqESTwWx3yJMr4Q==
Date:   Mon, 11 Mar 2019 16:48:51 +0000
Message-ID: <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:805:2a::27) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0260891-d20f-4fd6-2e0f-08d6a64170da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2891;
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2891;20:LRbt0leofw+1Yi/JhnHG0B9uLQPGC2DFMouOeuolbaJOsYzXSwZVW1Yj4DNc238es7Wp3b6I0y0/+rGFytl5LEK1eFBJXwoCsZ4N2JorzX5kuWOtlzA6QkHYehKZ3Br289xLyPRS86WFQGTCqY1NloTDC9ZjIwk9Iwt0G+UFM+PSrQd5v3vHy3wF/64Qv6HaL1coGXkJ6zHPKpDI/py7hLzFjJ5aIQY0zPlX55vYe7wnIhzBGqowA/neh6pHGTNe
x-microsoft-antispam-prvs: <DM6PR12MB28912DBD40FEB2E7ECA547F7EC480@DM6PR12MB2891.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(4326008)(25786009)(6116002)(72206003)(103116003)(9686003)(102836004)(66066001)(68736007)(186003)(476003)(11346002)(446003)(256004)(478600001)(8676002)(71200400001)(6436002)(97736004)(6486002)(81156014)(81166006)(71190400001)(14444005)(6512007)(86362001)(316002)(110136005)(54906003)(2906002)(106356001)(7416002)(105586002)(2501003)(53936002)(5660300002)(3846002)(14454004)(486006)(26005)(8936002)(7736002)(305945005)(52116002)(76176011)(6506007)(386003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2891;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5ESY49nxEtU35K9o5XGfeQgT8Bb+QC81q/hFtMWun3JjHktHVZL1ndUw9TUM4KbVWpz222FlnAxRyxpr7LcvuRR7e+eqk+GnQW2yg+fVchGP5wNFi3Jo8B/m06o2mXF7v5DNnbGS5PoH/WcGS+So6CB/2ca0OI5tADm67d6F2Br78AffPdB/uCoulx/P0yPeH6yjGk64Cs/Ytk5demMs3nzKuCiy8FNSoR6GGxfMkB+VshdrKtdxjlGUucQLl8QyhgiJ33qiUzLgoTIMZfJkKRQcmuIPublkhIUZEIEqQt21VY3bUJsclhPKNjPN0NUsswkaoFOJ+7p11qF3INAdOB70xKbOn5uOW3p08LXZz2fumB6P3tYBptSKtXY4HgNi7AjabiT3ShmUrNmMW0mLJCZzWugtAWXewmyHryi/Eo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <820C40B8383BBD4291C7966538B1BDB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0260891-d20f-4fd6-2e0f-08d6a64170da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:48:51.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
ZXJuZWwgd2FzIGNvbmZpZ3VyZWQuDQoNClRvIG1pdGlnYXRlIHRoaXMgaXNzdWUsIGEgbmV3LCBv
cHRpb25hbCwgY2FsbGFibGUgZnVuY3Rpb24gaXMgaW50cm9kdWNlZA0KdGhhdCBpcyBjYWxsZWQg
YmVmb3JlIHJldHVybmluZyBmcm9tIHg4Nl9wbXVfaGFuZGxlX2lycSgpLiBUaGUgQU1EIHBlcmYN
CnN1cHBvcnQgd2lsbCB1c2UgdGhpcyBmdW5jdGlvbiB0byBpbmRpY2F0ZSBpZiB0aGUgTk1JIGhh
cyBiZWVuIGhhbmRsZWQgb3INCndvdWxkIGhhdmUgYmVlbiBoYW5kbGVkIGhhZCBhbiBlYXJsaWVy
IE5NSSBub3QgaGFuZGxlZCB0aGUgb3ZlcmZsb3dlZCBQTUMuDQpVc2luZyBhIHBlci1DUFUgdmFy
aWFibGUsIGEgbWluaW11bSB2YWx1ZSBvZiBvbmUgbGVzcyB0aGFuIHRoZSBudW1iZXIgb2YNCmFj
dGl2ZSBQTUNzIG9yIDIgd2lsbCBiZSBzZXQgd2hlbiBhbnkgUE1DIG92ZXJmbG93IGhhcyBiZWVu
IGhhbmRsZWQgYW5kDQptb3JlIHRoYW4gb25lIFBNQyBpcyBhY3RpdmUuIFRoaXMgaXMgdXNlZCB0
byBpbmRpY2F0ZSB0aGUgcG9zc2libGUgbnVtYmVyDQpvZiBOTUlzIHRoYXQgY2FuIHN0aWxsIG9j
Y3VyLiBUaGUgdmFsdWUgb2YgMiBpcyB1c2VkIGZvciB3aGVuIGFuIE5NSSBkb2VzDQpub3QgYXJy
aXZlIGF0IHRoZSBBUElDIGluIHRpbWUgdG8gYmUgY29sbGFwc2VkIGludG8gYW4gYWxyZWFkeSBw
ZW5kaW5nDQpOTUkuIEVhY2ggdGltZSB0aGUgZnVuY3Rpb24gaXMgY2FsbGVkIHdpdGhvdXQgaGF2
aW5nIGhhbmRsZWQgYW4gb3ZlcmZsb3dlZA0KY291bnRlciwgdGhlIHBlci1DUFUgdmFsdWUgaXMg
Y2hlY2tlZC4gSWYgdGhlIHZhbHVlIGlzIG5vbi16ZXJvLCBpdCBpcw0KZGVjcmVtZW50ZWQgYW5k
IHRoZSBOTUkgaW5kaWNhdGVzIHRoYXQgaXQgaGFuZGxlZCB0aGUgTk1JLiBJZiB0aGUgdmFsdWUg
aXMNCnplcm8sIHRoZW4gdGhlIE5NSSBpbmRpY2F0ZXMgdGhhdCBpdCBkaWQgbm90IGhhbmRsZSB0
aGUgTk1JLg0KDQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNC4xNC54LQ0KU2lnbmVk
LW9mZi1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCi0tLQ0KIGFy
Y2gveDg2L2V2ZW50cy9hbWQvY29yZS5jICAgfCAgIDQzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIGFyY2gveDg2L2V2ZW50cy9jb3JlLmMgICAgICAgfCAgICA2
ICsrKysrKw0KIGFyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50LmggfCAgICAyICsrDQogMyBmaWxl
cyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVu
dHMvYW1kL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQppbmRleCBkOTg5NjQw
ZmE4N2QuLjMwNDU3YjUxMWU2ZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29y
ZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0KQEAgLTUsOSArNSwxMiBAQA0K
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQogI2lu
Y2x1ZGUgPGFzbS9hcGljZGVmLmg+DQorI2luY2x1ZGUgPGFzbS9ubWkuaD4NCiANCiAjaW5jbHVk
ZSAiLi4vcGVyZl9ldmVudC5oIg0KIA0KK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBp
bnQsIHBlcmZfbm1pX2NvdW50ZXIpOw0KKw0KIHN0YXRpYyBfX2luaXRjb25zdCBjb25zdCB1NjQg
YW1kX2h3X2NhY2hlX2V2ZW50X2lkcw0KIAkJCQlbUEVSRl9DT1VOVF9IV19DQUNIRV9NQVhdDQog
CQkJCVtQRVJGX0NPVU5UX0hXX0NBQ0hFX09QX01BWF0NCkBAIC00NjcsNiArNDcwLDQ1IEBAIHN0
YXRpYyB2b2lkIGFtZF9wbXVfd2FpdF9vbl9vdmVyZmxvdyhpbnQgaWR4LCB1NjQgY29uZmlnKQ0K
IAl9DQogfQ0KIA0KKy8qDQorICogQmVjYXVzZSBvZiBOTUkgbGF0ZW5jeSwgaWYgbXVsdGlwbGUg
UE1DIGNvdW50ZXJzIGFyZSBhY3RpdmUgd2UgbmVlZCB0byB0YWtlDQorICogaW50byBhY2NvdW50
IHRoYXQgbXVsdGlwbGUgUE1DIG92ZXJmbG93cyBjYW4gZ2VuZXJhdGUgbXVsdGlwbGUgTk1JcyBi
dXQgYmUNCisgKiBoYW5kbGVkIGJ5IGEgc2luZ2xlIGludm9jYXRpb24gb2YgdGhlIE5NSSBoYW5k
bGVyICh0aGluayBQTUMgb3ZlcmZsb3cgd2hpbGUNCisgKiBpbiB0aGUgTk1JIGhhbmRsZXIpLiBU
aGlzIGNvdWxkIHJlc3VsdCBpbiBzdWJzZXF1ZW50IHVua25vd24gTk1JIG1lc3NhZ2VzDQorICog
YmVpbmcgaXNzdWVkLg0KKyAqDQorICogQXR0ZW1wdCB0byBtaXRpZ2F0ZSB0aGlzIGJ5IHVzaW5n
IHRoZSBudW1iZXIgb2YgYWN0aXZlIFBNQ3MgdG8gZGV0ZXJtaW5lDQorICogd2hldGhlciB0byBy
ZXR1cm4gTk1JX0hBTkRMRUQgaWYgdGhlIHBlcmYgTk1JIGhhbmRsZXIgZGlkIG5vdCBoYW5kbGUv
cmVzZXQNCisgKiBhbnkgUE1Dcy4gVGhlIHBlci1DUFUgcGVyZl9ubWlfY291bnRlciB2YXJpYWJs
ZSBpcyBzZXQgdG8gYSBtaW5pbXVtIG9mIG9uZQ0KKyAqIGxlc3MgdGhhbiB0aGUgbnVtYmVyIG9m
IGFjdGl2ZSBQTUNzIG9yIDIuIFRoZSB2YWx1ZSBvZiAyIGlzIHVzZWQgaW4gY2FzZSB0aGUNCisg
KiBOTUkgZG9lcyBub3QgYXJyaXZlIGF0IHRoZSBBUElDIGluIHRpbWUgdG8gYmUgY29sbGFwc2Vk
IGludG8gYW4gYWxyZWFkeQ0KKyAqIHBlbmRpbmcgTk1JLg0KKyAqLw0KK3N0YXRpYyBpbnQgYW1k
X3BtdV9taXRpZ2F0ZV9ubWlfbGF0ZW5jeSh1bnNpZ25lZCBpbnQgYWN0aXZlLCBpbnQgaGFuZGxl
ZCkNCit7DQorCS8qIElmIG11bHRpcGxlIGNvdW50ZXJzIGFyZSBub3QgYWN0aXZlIHJldHVybiBv
cmlnaW5hbCBoYW5kbGVkIGNvdW50ICovDQorCWlmIChhY3RpdmUgPD0gMSkNCisJCXJldHVybiBo
YW5kbGVkOw0KKw0KKwkvKg0KKwkgKiBJZiBhIGNvdW50ZXIgd2FzIGhhbmRsZWQsIHJlY29yZCB0
aGUgbnVtYmVyIG9mIHBvc3NpYmxlIHJlbWFpbmluZw0KKwkgKiBOTUlzIHRoYXQgY2FuIG9jY3Vy
Lg0KKwkgKi8NCisJaWYgKGhhbmRsZWQpIHsNCisJCXRoaXNfY3B1X3dyaXRlKHBlcmZfbm1pX2Nv
dW50ZXIsDQorCQkJICAgICAgIG1pbl90KHVuc2lnbmVkIGludCwgMiwgYWN0aXZlIC0gMSkpOw0K
Kw0KKwkJcmV0dXJuIGhhbmRsZWQ7DQorCX0NCisNCisJaWYgKCF0aGlzX2NwdV9yZWFkKHBlcmZf
bm1pX2NvdW50ZXIpKQ0KKwkJcmV0dXJuIE5NSV9ET05FOw0KKw0KKwl0aGlzX2NwdV9kZWMocGVy
Zl9ubWlfY291bnRlcik7DQorDQorCXJldHVybiBOTUlfSEFORExFRDsNCit9DQorDQogc3RhdGlj
IHN0cnVjdCBldmVudF9jb25zdHJhaW50ICoNCiBhbWRfZ2V0X2V2ZW50X2NvbnN0cmFpbnRzKHN0
cnVjdCBjcHVfaHdfZXZlbnRzICpjcHVjLCBpbnQgaWR4LA0KIAkJCSAgc3RydWN0IHBlcmZfZXZl
bnQgKmV2ZW50KQ0KQEAgLTY4OSw2ICs3MzEsNyBAQCBzdGF0aWMgX19pbml0Y29uc3QgY29uc3Qg
c3RydWN0IHg4Nl9wbXUgYW1kX3BtdSA9IHsNCiANCiAJLmFtZF9uYl9jb25zdHJhaW50cwk9IDEs
DQogCS53YWl0X29uX292ZXJmbG93CT0gYW1kX3BtdV93YWl0X29uX292ZXJmbG93LA0KKwkubWl0
aWdhdGVfbm1pX2xhdGVuY3kJPSBhbWRfcG11X21pdGlnYXRlX25taV9sYXRlbmN5LA0KIH07DQog
DQogc3RhdGljIGludCBfX2luaXQgYW1kX2NvcmVfcG11X2luaXQodm9pZCkNCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jIGIvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KaW5kZXgg
ZjFkMmY3MDAwMGNkLi5hNTljM2ZjYmFlNmEgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9ldmVudHMv
Y29yZS5jDQorKysgYi9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQpAQCAtMTQzNCw2ICsxNDM0LDcg
QEAgaW50IHg4Nl9wbXVfaGFuZGxlX2lycShzdHJ1Y3QgcHRfcmVncyAqcmVncykNCiAJc3RydWN0
IHBlcmZfc2FtcGxlX2RhdGEgZGF0YTsNCiAJc3RydWN0IGNwdV9od19ldmVudHMgKmNwdWM7DQog
CXN0cnVjdCBwZXJmX2V2ZW50ICpldmVudDsNCisJdW5zaWduZWQgaW50IGFjdGl2ZSA9IDA7DQog
CWludCBpZHgsIGhhbmRsZWQgPSAwOw0KIAl1NjQgdmFsOw0KIA0KQEAgLTE0NjEsNiArMTQ2Miw4
IEBAIGludCB4ODZfcG11X2hhbmRsZV9pcnEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQogCQkJY29u
dGludWU7DQogCQl9DQogDQorCQlhY3RpdmUrKzsNCisNCiAJCWV2ZW50ID0gY3B1Yy0+ZXZlbnRz
W2lkeF07DQogDQogCQl2YWwgPSB4ODZfcGVyZl9ldmVudF91cGRhdGUoZXZlbnQpOw0KQEAgLTE0
ODMsNiArMTQ4Niw5IEBAIGludCB4ODZfcG11X2hhbmRsZV9pcnEoc3RydWN0IHB0X3JlZ3MgKnJl
Z3MpDQogCWlmIChoYW5kbGVkKQ0KIAkJaW5jX2lycV9zdGF0KGFwaWNfcGVyZl9pcnFzKTsNCiAN
CisJaWYgKHg4Nl9wbXUubWl0aWdhdGVfbm1pX2xhdGVuY3kpDQorCQloYW5kbGVkID0geDg2X3Bt
dS5taXRpZ2F0ZV9ubWlfbGF0ZW5jeShhY3RpdmUsIGhhbmRsZWQpOw0KKw0KIAlyZXR1cm4gaGFu
ZGxlZDsNCiB9DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaCBi
L2FyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50LmgNCmluZGV4IGEzNzQ5MGEyNmEwOS4uNjE5MjE0
YmRhOTJlIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KKysrIGIv
YXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KQEAgLTYzNyw2ICs2MzcsOCBAQCBzdHJ1Y3Qg
eDg2X3BtdSB7DQogCSAqLw0KIAl1bnNpZ25lZCBpbnQJYW1kX25iX2NvbnN0cmFpbnRzIDogMTsN
CiAJdm9pZAkJKCp3YWl0X29uX292ZXJmbG93KShpbnQgaWR4LCB1NjQgY29uZmlnKTsNCisJaW50
CQkoKm1pdGlnYXRlX25taV9sYXRlbmN5KSh1bnNpZ25lZCBpbnQgYWN0aXZlLA0KKwkJCQkJCWlu
dCBoYW5kbGVkKTsNCiANCiAJLyoNCiAJICogRXh0cmEgcmVnaXN0ZXJzIGZvciBldmVudHMNCg0K
