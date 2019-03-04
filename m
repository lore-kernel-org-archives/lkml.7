Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD23C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DE9206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mlpguih9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCDPq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:46:56 -0500
Received: from mail-eopbgr780058.outbound.protection.outlook.com ([40.107.78.58]:59104
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfCDPq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t707/K0tEtZu6MjXs/YZg4seBE3LDTuAQJmUFhTAUog=;
 b=mlpguih9rxwf1ay9gjhEcgoVI6VNyU6UyXfbBulVz0UliYQlpWG1lwUB+s+I6FnUd5kqEhvztGKEoa8eWliG+9UdY95aZ+6dA8MoWhf6urs71c2lD8q0Fgl9WMsOVhPocALJXNArlTNxn875oyBtQWLOHCVQS8y9222xjVu2sHg=
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2615.namprd12.prod.outlook.com (20.176.255.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 15:46:49 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::a92d:c93:ed77:b0a9]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::a92d:c93:ed77:b0a9%4]) with mapi id 15.20.1643.022; Mon, 4 Mar 2019
 15:46:49 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Helen Koike <helen.koike@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?utf-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu@google.com>
Subject: Re: [PATCH 1/5] drm: don't block fb changes for async plane updates
Thread-Topic: [PATCH 1/5] drm: don't block fb changes for async plane updates
Thread-Index: AQHU0pl6uFOGyweEhkyfL14Zz/HLu6X7nb2A
Date:   Mon, 4 Mar 2019 15:46:49 +0000
Message-ID: <e2eb91f5-25e3-d030-74d8-de2348de5600@amd.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
 <20190304144909.6267-2-helen.koike@collabora.com>
In-Reply-To: <20190304144909.6267-2-helen.koike@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c20b35-e765-4842-109e-08d6a0b89d5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2615;
x-ms-traffictypediagnostic: BYAPR12MB2615:
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2615;20:zh+mIQMUVCIyrNZbLQn2jL2gC99fSwP1uhiqzsZenGutLmtqPI35PlXviSfPz9gQwZl/R31Rdj/FgJlxjEFiChk4/2wra+7ItWph7N0ii2m4t8X8XzfQ2kbcPxKQZH0FATVteLcEtMzEil3LN110MGqAjywyJnzueNjgK3RYKfC87W1LpYWOLPUH8lPTNPo7F+8B65KVjBYnc/V3t86wpy90gDcazIgkvDxh8+n0Sgh2ZuQU52B9P1WYZC7mULKt
x-microsoft-antispam-prvs: <BYAPR12MB2615AAD2490F4DF74189DB73EC710@BYAPR12MB2615.namprd12.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(81156014)(4326008)(66066001)(229853002)(316002)(86362001)(8676002)(3846002)(36756003)(26005)(2906002)(186003)(81166006)(106356001)(53546011)(6506007)(386003)(105586002)(478600001)(14454004)(72206003)(54906003)(6486002)(110136005)(6436002)(99286004)(6246003)(68736007)(102836004)(15650500001)(97736004)(31696002)(31686004)(76176011)(6116002)(52116002)(486006)(476003)(305945005)(7416002)(446003)(53936002)(71190400001)(71200400001)(8936002)(7736002)(6512007)(2501003)(25786009)(5660300002)(11346002)(2616005)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2615;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BzcY8FJ3HoUnH23ICAxtkdc/I/Y5AiDbw6dqsktRX4vW/6pRYW3r62fUt9MjthEC4GTzEdHWQjvpJxw5t3ILKHIuPpiklXmFYCPnktEPPGRkHa7A8MAxFJBoeduZtWc2a3Fqe8863JHZPRFEHnY7ooOD05lIV/43TaEiJX+t0lTOddON6oRsWNSC4aHqINKSOvb4aO3OUEqlwq1BXirDDfzqvyDPAxW/QYsvZ9yZl87Z8j+mtSj/KJ/dtzNYopGYWVsvY8tg3qhoIsDdGxBXPIHQtw+5R/ukw0GvQ0yORVXeZCkfyS5rdNoZ9yGwlNt8o+X8zrcwGADiWTrMjy9WQ8vBelgVrEkrBOpj1TaiExknxhKo4mLTjLavAOAM1EZwfGC3VKmbSjTYOU4snkSHiO+KqcHE9r4qrRw3XU4wRgw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1AB145319E0EB45B3A9B23B30E83617@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c20b35-e765-4842-109e-08d6a0b89d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 15:46:48.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzE5IDk6NDkgQU0sIEhlbGVuIEtvaWtlIHdyb3RlOg0KPiBJbiB0aGUgY2FzZSBvZiBh
IG5vcm1hbCBzeW5jIHVwZGF0ZSwgdGhlIHByZXBhcmF0aW9uIG9mIGZyYW1lYnVmZmVycyAoYmUN
Cj4gaXQgY2FsbGluZyBkcm1fYXRvbWljX2hlbHBlcl9wcmVwYXJlX3BsYW5lcygpIG9yIGRvaW5n
IHNldHVwcyB3aXRoDQo+IGRybV9mcmFtZWJ1ZmZlcl9nZXQoKSkgYXJlIHBlcmZvcm1lZCBpbiB0
aGUgbmV3X3N0YXRlIGFuZCB0aGUgcmVzcGVjdGl2ZQ0KPiBjbGVhbnVwcyBhcmUgcGVyZm9ybWVk
IGluIHRoZSBvbGRfc3RhdGUuDQo+IA0KPiBJbiB0aGUgY2FzZSBvZiBhc3luYyB1cGRhdGVzLCB0
aGUgcHJlcGFyYXRpb24gaXMgYWxzbyBkb25lIGluIHRoZQ0KPiBuZXdfc3RhdGUgYnV0IHRoZSBj
bGVhbnVwcyBhcmUgZG9uZSBpbiB0aGUgbmV3X3N0YXRlIChiZWNhdXNlIHVwZGF0ZXMNCj4gYXJl
IHBlcmZvcm1lZCBpbiBwbGFjZSwgaS5lLiBpbiB0aGUgY3VycmVudCBzdGF0ZSkuDQo+IA0KPiBU
aGUgY3VycmVudCBjb2RlIGJsb2NrcyBhc3luYyB1ZHBhdGVzIHdoZW4gdGhlIGZiIGlzIGNoYW5n
ZWQsIHR1cm5pbmcNCj4gYXN5bmMgdXBkYXRlcyBpbnRvIHN5bmMgdXBkYXRlcywgc2xvd2luZyBk
b3duIGN1cnNvciB1cGRhdGVzIGFuZA0KPiBpbnRyb2R1Y2luZyByZWdyZXNzaW9ucyBpbiBpZ3Qg
dGVzdHMgd2l0aCBlcnJvcnMgb2YgdHlwZToNCj4gDQo+ICJDUklUSUNBTDogY29tcGxldGVkIDk3
IGN1cnNvciB1cGRhdGVkIGluIGEgcGVyaW9kIG9mIDMwIGZsaXBzLCB3ZQ0KPiBleHBlY3QgdG8g
Y29tcGxldGUgYXBwcm94aW1hdGVseSAxNTM2MCB1cGRhdGVzLCB3aXRoIHRoZSB0aHJlc2hvbGQg
c2V0DQo+IGF0IDc2ODAiDQo+IA0KPiBGYiBjaGFuZ2VzIGluIGFzeW5jIHVwZGF0ZXMgd2VyZSBw
cmV2ZW50ZWQgdG8gYXZvaWQgdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCj4gDQo+IC0gQXN5bmMg
dXBkYXRlLCBvbGRmYiA9IE5VTEwsIG5ld2ZiID0gZmIxLCBwcmVwYXJlIGZiMSwgY2xlYW51cCBm
YjENCj4gLSBBc3luYyB1cGRhdGUsIG9sZGZiID0gZmIxLCBuZXdmYiA9IGZiMiwgcHJlcGFyZSBm
YjIsIGNsZWFudXAgZmIyDQo+IC0gTm9uLWFzeW5jIGNvbW1pdCwgb2xkZmIgPSBmYjIsIG5ld2Zi
ID0gZmIxLCBwcmVwYXJlIGZiMSwgY2xlYW51cCBmYjIgKHdyb25nKQ0KPiBXaGVyZSB3ZSBoYXZl
IGEgc2luZ2xlIGNhbGwgdG8gcHJlcGFyZSBmYjIgYnV0IGRvdWJsZSBjbGVhbnVwIGNhbGwgdG8g
ZmIyLg0KPiANCj4gVG8gc29sdmUgdGhlIGFib3ZlIHByb2JsZW1zLCBpbnN0ZWFkIG9mIGJsb2Nr
aW5nIGFzeW5jIGZiIGNoYW5nZXMsIHdlDQo+IHBsYWNlIHRoZSBvbGQgZnJhbWVidWZmZXIgaW4g
dGhlIG5ld19zdGF0ZSBvYmplY3QsIHNvIHdoZW4gdGhlIGNvZGUNCj4gcGVyZm9ybXMgY2xlYW51
cHMgaW4gdGhlIG5ld19zdGF0ZSBpdCB3aWxsIGNsZWFudXAgdGhlIG9sZF9mYiBhbmQgd2UNCj4g
d2lsbCBoYXZlIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8gaW5zdGVhZDoNCj4gDQo+IC0gQXN5bmMg
dXBkYXRlLCBvbGRmYiA9IE5VTEwsIG5ld2ZiID0gZmIxLCBwcmVwYXJlIGZiMSwgbm8gY2xlYW51
cA0KPiAtIEFzeW5jIHVwZGF0ZSwgb2xkZmIgPSBmYjEsIG5ld2ZiID0gZmIyLCBwcmVwYXJlIGZi
MiwgY2xlYW51cCBmYjENCj4gLSBOb24tYXN5bmMgY29tbWl0LCBvbGRmYiA9IGZiMiwgbmV3ZmIg
PSBmYjEsIHByZXBhcmUgZmIxLCBjbGVhbnVwIGZiMg0KPiANCj4gV2hlcmUgY2FsbHMgdG8gcHJl
cGFyZS9jbGVhbnVwIGFyZSBiYWxsYW5jZWQuDQo+IA0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+ICMgdjQuMTQrOiAyNWRjMTk0YjM0ZGQ6IGRybTogQmxvY2sgZmIgY2hhbmdlcyBmb3Ig
YXN5bmMgcGxhbmUgdXBkYXRlcw0KPiBGaXhlczogMjVkYzE5NGIzNGRkICgiZHJtOiBCbG9jayBm
YiBjaGFuZ2VzIGZvciBhc3luYyBwbGFuZSB1cGRhdGVzIikNCj4gU3VnZ2VzdGVkLWJ5OiBCb3Jp
cyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBIZWxlbiBLb2lrZSA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT4NCj4gDQo+IC0tLQ0K
PiBIZWxsbywNCj4gDQo+IEFzIG1lbnRpb25lZCBpbiB0aGUgY292ZXIgbGV0dGVyLA0KPiBJIHRl
c3RlZCBvbiB0aGUgcm9ja2NoaXAgYW5kIG9uIGk5MTUgKHdpdGggYSBwYXRjaCBJIGFtIHN0aWxs
IHdvcmtpbmcgb24gZm9yDQo+IHJlcGxhY2luZyBjdXJzb3JzIGJ5IGFzeW5jIHVwZGF0ZSksIHdp
dGggaWd0IHBsYW5lX2N1cnNvcl9sZWdhY3kgYW5kDQo+IGttc19jdXJzb3JfbGVnYWN5IGFuZCBJ
IGRpZG4ndCBzZWUgYW55IHJlZ3Jlc3Npb25zLg0KPiBJIGNvdWxkbid0IHRlc3Qgb24gTVNNIGFu
ZCBBTUQgYmVjYXVzZSBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIChhbmQgSSBhbQ0KPiBoYXZp
bmcgc29tZSBpc3N1ZXMgdGVzdGluZyBvbiB2YzQpIGFuZCBJIHdvdWxkIGFwcHJlY2lhdGUgaWYg
YW55b25lIGNvdWxkIGhlbHANCj4gbWUgdGVzdGluZyB0aG9zZS4NCj4gDQo+IEkgYWxzbyB0aGlu
ayBpdCB3b3VsZCBiZSBhIGJldHRlciBzb2x1dGlvbiBpZiwgaW5zdGVhZCBvZiBoYXZpbmcgYXN5
bmMNCj4gdG8gZG8gaW4tcGxhY2UgdXBkYXRlcyBpbiB0aGUgY3VycmVudCBzdGF0ZSwgdGhlIGFz
eW5jIHBhdGggc2hvdWxkIGJlDQo+IGVxdWl2YWxlbnQgdG8gYSBzeW5jcm9ub3VzIHVwZGF0ZSwg
aS5lLiwgbW9kaWZ5aW5nIG5ld19zdGF0ZSBhbmQNCj4gcGVyZm9ybWluZyBhIGZsaXANCj4gSU1I
TywgdGhlIG9ubHkgZGlmZmVyZW5jZSBiZXR3ZWVuIHN5bmMgYW5kIGFzeW5jIHNob3VsZCBiZSB0
aGF0IGFzeW5jIHVwZGF0ZQ0KPiBkb2Vzbid0IHdhaXQgZm9yIHZibGFuayBhbmQgYXBwbGllcyB0
aGUgY2hhbmdlcyBpbW1lZGl0YWxseSB0byB0aGUgaHcsDQo+IGJ1dCB0aGUgY29kZSBwYXRoIGNv
dWxkIGJlIGFsbW9zdCB0aGUgc2FtZS4NCj4gQnV0IGZvciBub3cgSSB0aGluayB0aGlzIHNvbHV0
aW9uIGlzIG9rIChzd2FwaW5nIG5ld19mYi9vbGRfZmIpLCBhbmQNCj4gdGhlbiB3ZSBjYW4gYWRq
dXN0IHRoaW5ncyBsaXR0bGUgYnkgbGl0dGxlLCB3aGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IFRo
YW5rcyENCj4gSGVsZW4NCj4gDQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVy
LmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hl
bHBlci5jDQo+IGluZGV4IDU0MGE3N2EyYWRlOS4uZTdlYjk2ZjFlZmMyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYw0KPiBAQCAtMTYwOCwxNSArMTYwOCw2IEBAIGludCBk
cm1fYXRvbWljX2hlbHBlcl9hc3luY19jaGVjayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAg
IAkgICAgb2xkX3BsYW5lX3N0YXRlLT5jcnRjICE9IG5ld19wbGFuZV9zdGF0ZS0+Y3J0YykNCj4g
ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgIA0KPiAtCS8qDQo+IC0JICogRklYTUU6IFNpbmNlIHBy
ZXBhcmVfZmIgYW5kIGNsZWFudXBfZmIgYXJlIGFsd2F5cyBjYWxsZWQgb24NCj4gLQkgKiB0aGUg
bmV3X3BsYW5lX3N0YXRlIGZvciBhc3luYyB1cGRhdGVzIHdlIG5lZWQgdG8gYmxvY2sgZnJhbWVi
dWZmZXINCj4gLQkgKiBjaGFuZ2VzLiBUaGlzIHByZXZlbnRzIHVzZSBvZiBhIGZiIHRoYXQncyBi
ZWVuIGNsZWFuZWQgdXAgYW5kDQo+IC0JICogZG91YmxlIGNsZWFudXBzIGZyb20gb2NjdXJpbmcu
DQo+IC0JICovDQo+IC0JaWYgKG9sZF9wbGFuZV9zdGF0ZS0+ZmIgIT0gbmV3X3BsYW5lX3N0YXRl
LT5mYikNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gICAJZnVuY3MgPSBwbGFuZS0+aGVs
cGVyX3ByaXZhdGU7DQo+ICAgCWlmICghZnVuY3MtPmF0b21pY19hc3luY191cGRhdGUpDQo+ICAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTE2NTcsNiArMTY0OCw5IEBAIHZvaWQgZHJtX2F0b21p
Y19oZWxwZXJfYXN5bmNfY29tbWl0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+ICAgCWludCBp
Ow0KPiAgIA0KPiAgIAlmb3JfZWFjaF9uZXdfcGxhbmVfaW5fc3RhdGUoc3RhdGUsIHBsYW5lLCBw
bGFuZV9zdGF0ZSwgaSkgew0KPiArCQlzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpuZXdfZmIgPSBw
bGFuZV9zdGF0ZS0+ZmI7DQo+ICsJCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKm9sZF9mYiA9IHBs
YW5lLT5zdGF0ZS0+ZmI7DQo+ICsNCj4gICAJCWZ1bmNzID0gcGxhbmUtPmhlbHBlcl9wcml2YXRl
Ow0KPiAgIAkJZnVuY3MtPmF0b21pY19hc3luY191cGRhdGUocGxhbmUsIHBsYW5lX3N0YXRlKTsN
Cj4gICANCj4gQEAgLTE2NjUsMTEgKzE2NTksMTcgQEAgdm9pZCBkcm1fYXRvbWljX2hlbHBlcl9h
c3luY19jb21taXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gICAJCSAqIHBsYW5lLT5zdGF0
ZSBpbi1wbGFjZSwgbWFrZSBzdXJlIGF0IGxlYXN0IGNvbW1vbg0KPiAgIAkJICogcHJvcGVydGll
cyBoYXZlIGJlZW4gcHJvcGVybHkgdXBkYXRlZC4NCj4gICAJCSAqLw0KPiAtCQlXQVJOX09OX09O
Q0UocGxhbmUtPnN0YXRlLT5mYiAhPSBwbGFuZV9zdGF0ZS0+ZmIpOw0KPiArCQlXQVJOX09OX09O
Q0UocGxhbmUtPnN0YXRlLT5mYiAhPSBuZXdfZmIpOw0KPiAgIAkJV0FSTl9PTl9PTkNFKHBsYW5l
LT5zdGF0ZS0+Y3J0Y194ICE9IHBsYW5lX3N0YXRlLT5jcnRjX3gpOw0KPiAgIAkJV0FSTl9PTl9P
TkNFKHBsYW5lLT5zdGF0ZS0+Y3J0Y195ICE9IHBsYW5lX3N0YXRlLT5jcnRjX3kpOw0KPiAgIAkJ
V0FSTl9PTl9PTkNFKHBsYW5lLT5zdGF0ZS0+c3JjX3ggIT0gcGxhbmVfc3RhdGUtPnNyY194KTsN
Cj4gICAJCVdBUk5fT05fT05DRShwbGFuZS0+c3RhdGUtPnNyY195ICE9IHBsYW5lX3N0YXRlLT5z
cmNfeSk7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogTWFrZSBzdXJlIHRoZSBGQnMgaGF2ZSBiZWVu
IHN3YXBwZWQgc28gdGhhdCBjbGVhbnVwcyBpbiB0aGUNCj4gKwkJICogbmV3X3N0YXRlIHBlcmZv
cm1zIGEgY2xlYW51cCBpbiB0aGUgb2xkIEZCLg0KPiArCQkgKi8NCj4gKwkJV0FSTl9PTl9PTkNF
KHBsYW5lX3N0YXRlLT5mYiAhPSBvbGRfZmIpOw0KDQpJIHBlcnNvbmFsbHkgdGhpbmsgdGhpcyBh
cHByb2FjaCBpcyBmaW5lIGFuZCB0aGUgV0FSTl9PTiBzIGFyZSBnb29kIGZvciANCmNhdGNoaW5n
IGRyaXZlcnMgdGhhdCB3YW50IHRvIHVzZSB0aGVzZSBpbiB0aGUgZnV0dXJlLg0KDQpJIGRvIHRo
aW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gYWRkIHNvbWV0aGluZyB0byB0aGUgZnVuY3Rpb24gZG9j
cyB0aGF0IA0KZXhwbGFpbnMgdGhpcyByZXF1aXJlbWVudCBhbmQgdGhlIGlzc3VlIHRoYXQgaXQg
YWRkcmVzc2VzLiBJdCdzIGEgbGl0dGxlIA0KdW5pbnR1aXRpdmUgdG8gcmVxdWlyZSB0aGF0IHRo
ZSBvbGQgZmIgaXMgcGxhY2VkIGludG8gdGhlIG5ldyBzdGF0ZSwgYnV0IA0KaXQgbWFrZXMgc2Vu
c2UgYXMgYSB3b3JrYXJvdW5kIHRvIHRoaXMgcHJvYmxlbS4NCg0KTmljaG9sYXMgS2F6bGF1c2th
cw0KDQo+ICAgCX0NCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTChkcm1fYXRvbWljX2hlbHBlcl9h
c3luY19jb21taXQpOw0KPiANCg0K
