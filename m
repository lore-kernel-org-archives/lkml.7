Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA21C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237A2206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I6/JWkEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfDOIFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:05:16 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:26755
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfDOIFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtVlN5CxwAOyoyGnWzPohL/yKmk+7FHx9A2h7QT0f4Y=;
 b=I6/JWkEUKX0TPbtKacd+35C9lZ4HkuKd9qoZRMRDLrVbNDF/R9ua+pa3fPCrkMEbzI4CF44B2eEcpU4D7+hc0g7y0dMfz/+kG9lfKR3DzKLfOU0lzwxUSbhd2hpaCfV9LY4pU8381H7QegjzXFBN+ZfdOzdxQCROoSsJ8Zx/P1w=
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) by
 AM4PR0802MB2258.eurprd08.prod.outlook.com (10.172.219.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 08:04:33 +0000
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::9976:7f2:5daa:7c48]) by AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::9976:7f2:5daa:7c48%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 08:04:33 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
Subject: Re: [PATCH] perf: Fix AUX record suppression
Thread-Topic: [PATCH] perf: Fix AUX record suppression
Thread-Index: AQHU5g+6aN4kfufsHEqs3keeIahjE6Y895cA
Date:   Mon, 15 Apr 2019 08:04:33 +0000
Message-ID: <7b073941dd6abfc81773f26573b103adf077bfed.camel@arm.com>
References: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
In-Reply-To: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Gainey@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f5f42c-2bbe-4d07-5121-08d6c178feb3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR0802MB2258;
x-ms-traffictypediagnostic: AM4PR0802MB2258:
x-microsoft-antispam-prvs: <AM4PR0802MB22585EC71AFD8C4CF08077B2912B0@AM4PR0802MB2258.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(136003)(366004)(40434004)(189003)(199004)(6486002)(106356001)(478600001)(14444005)(5024004)(256004)(6506007)(81156014)(81166006)(118296001)(8936002)(6512007)(105586002)(99286004)(72206003)(14454004)(71190400001)(71200400001)(68736007)(316002)(58126008)(229853002)(8676002)(102836004)(305945005)(76176011)(54906003)(110136005)(6116002)(66066001)(3846002)(2906002)(97736004)(86362001)(26005)(2616005)(5660300002)(186003)(476003)(6436002)(486006)(446003)(11346002)(6246003)(4326008)(7736002)(53936002)(25786009)(2501003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2258;H:AM4PR0802MB2211.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t6VT/fzmfAGvvWB+9e9V4/Htsun3DVvO4s+SZJ8/HcPe6enNMAq3EUfLLxAOr5EkzKNRY78ntVHXpKi8M8k15Uf8rSANqF3bE/d8NqtRt2NBb2pefJaESORhH07h4h6l3SNMinUrpW5kRJC9UMIwKqPCh4Yi6sBNr5GpAAr6xVDWy2eenq8/dmAXuA6fw0NDGOjG2Q60KjUI4z7HM+j7I7DBBLMYAK8b55y/06PsbXslJmyyEUMBZ311dwUjy0naODELVXjVf3wyMFUnPFlDyHM9gUelN7C1A0gSj+RS8N2j2oT+WaTLA0w7pXp8CRHwfpviMRUFONGFlCbHeU3vBWY2TtceeGXcTclZBPVCaXI4WfYwy+307jgECIjNC5CHrELkmUu3AkkRTOGcLRhOj5DjATm7qRfu2faBMR0SQuE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7025727739E49640A8E8CFDBE6D9EEE3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f5f42c-2bbe-4d07-5121-08d6c178feb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 08:04:33.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleA0KDQpJIHdhcyBqdXN0IHdvbmRlcmluZyBpZiB0aGlzIHdhcyBleHBlY3RlZCB0byBt
YWtlIDUuMT8gKEkgY291bGQgbm90IHNlZQ0KaXQgaW4gUkM1KT8NCg0KVGhhbmtzDQpCZW4NCg0K
DQoNCk9uIEZyaSwgMjAxOS0wMy0yOSBhdCAxMToxMyArMDIwMCwgQWxleGFuZGVyIFNoaXNoa2lu
IHdyb3RlOg0KPiBDb21taXQgMTYyNzMxNGZiNTRhMzNlICgicGVyZjogU3VwcHJlc3MgQVVYL09W
RVJXUklURSByZWNvcmRzIikgaGFzDQo+IGFuDQo+IHVuaW50ZW5kZWQgc2lkZS1lZmZlY3Qgb2Yg
YWxzbyBzdXBwcmVzc2luZyBhbGwgQVVYIHJlY29yZHMgd2l0aCBubw0KPiBmbGFncw0KPiBhbmQg
bm9uLXplcm8gc2l6ZSwgc28gYWxsIHRoZSByZWd1bGFyIHJlY29yZHMgaW4gdGhlIGZ1bGwgdHJh
Y2UgbW9kZS4NCj4gVGhpcyBicmVha3Mgc29tZSB1c2UgY2FzZXMgZm9yIHBlb3BsZS4NCj4NCj4g
Rml4IHRoaXMgYnkgcmVzdG9yaW5nICJyZWd1bGFyIiBBVVggcmVjb3Jkcy4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50
ZWwuY29tDQo+ID4NCj4gRml4ZXM6IDE2MjczMTRmYjU0YTMzZSAoInBlcmY6IFN1cHByZXNzIEFV
WC9PVkVSV1JJVEUgcmVjb3JkcyIpDQo+IFJlcG9ydGVkLWJ5OiBCZW4gR2FpbmV5IDxCZW4uR2Fp
bmV5QGFybS5jb20+DQo+IFRlc3RlZC1ieTogQmVuIEdhaW5leSA8QmVuLkdhaW5leUBhcm0uY29t
Pg0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY0LjIwKw0KPiAtLS0NCj4gIGtlcm5l
bC9ldmVudHMvcmluZ19idWZmZXIuYyB8IDMzICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50cy9yaW5nX2J1ZmZlci5jDQo+IGIva2Vy
bmVsL2V2ZW50cy9yaW5nX2J1ZmZlci5jDQo+IGluZGV4IDY3OGNjZWM2MGQ4Zi4uNjI2MjU2ZGMy
NmMxIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZXZlbnRzL3JpbmdfYnVmZmVyLmMNCj4gKysrIGIv
a2VybmVsL2V2ZW50cy9yaW5nX2J1ZmZlci5jDQo+IEBAIC00NTUsMjQgKzQ1NSwyMSBAQCB2b2lk
IHBlcmZfYXV4X291dHB1dF9lbmQoc3RydWN0DQo+IHBlcmZfb3V0cHV0X2hhbmRsZSAqaGFuZGxl
LCB1bnNpZ25lZCBsb25nIHNpemUpDQo+ICByYi0+YXV4X2hlYWQgKz0gc2l6ZTsNCj4gIH0NCj4N
Cj4gLWlmIChzaXplIHx8IGhhbmRsZS0+YXV4X2ZsYWdzKSB7DQo+IC0vKg0KPiAtICogT25seSBz
ZW5kIFJFQ09SRF9BVVggaWYgd2UgaGF2ZSBzb21ldGhpbmcgdXNlZnVsIHRvDQo+IGNvbW11bmlj
YXRlDQo+IC0gKg0KPiAtICogTm90ZTogdGhlIE9WRVJXUklURSByZWNvcmRzIGJ5IHRoZW1zZWx2
ZXMgYXJlIG5vdA0KPiBjb25zaWRlcmVkDQo+IC0gKiB1c2VmdWwsIGFzIHRoZXkgZG9uJ3QgY29t
bXVuaWNhdGUgYW55ICpuZXcqDQo+IGluZm9ybWF0aW9uLA0KPiAtICogYXNpZGUgZnJvbSB0aGUg
c2hvcnQtbGl2ZWQgb2Zmc2V0LCB0aGF0IGJlY29tZXMNCj4gaGlzdG9yeSBhdA0KPiAtICogdGhl
IG5leHQgZXZlbnQgc2NoZWQtaW4gYW5kIHRoZXJlZm9yZSBpc24ndCB1c2VmdWwuDQo+IC0gKiBU
aGUgdXNlcnNwYWNlIHRoYXQgbmVlZHMgdG8gY29weSBvdXQgQVVYIGRhdGEgaW4NCj4gb3Zlcndy
aXRlDQo+IC0gKiBtb2RlIHNob3VsZCBrbm93IHRvIHVzZSB1c2VyX3BhZ2U6OmF1eF9oZWFkIGZv
ciB0aGUNCj4gYWN0dWFsDQo+IC0gKiBvZmZzZXQuIFNvLCBmcm9tIG5vdyBvbiB3ZSBkb24ndCBv
dXRwdXQgQVVYIHJlY29yZHMNCj4gdGhhdA0KPiAtICogaGF2ZSAqb25seSogT1ZFUldSSVRFIGZs
YWcgc2V0Lg0KPiAtICovDQo+IC0NCj4gLWlmIChoYW5kbGUtPmF1eF9mbGFncyAmIH4odTY0KVBF
UkZfQVVYX0ZMQUdfT1ZFUldSSVRFKQ0KPiAtcGVyZl9ldmVudF9hdXhfZXZlbnQoaGFuZGxlLT5l
dmVudCwgYXV4X2hlYWQsDQo+IHNpemUsDQo+IC0gICAgICAgICAgICAgICAgICAgICBoYW5kbGUt
PmF1eF9mbGFncyk7DQo+IC19DQo+ICsvKg0KPiArICogT25seSBzZW5kIFJFQ09SRF9BVVggaWYg
d2UgaGF2ZSBzb21ldGhpbmcgdXNlZnVsIHRvDQo+IGNvbW11bmljYXRlDQo+ICsgKg0KPiArICog
Tm90ZTogdGhlIE9WRVJXUklURSByZWNvcmRzIGJ5IHRoZW1zZWx2ZXMgYXJlIG5vdCBjb25zaWRl
cmVkDQo+ICsgKiB1c2VmdWwsIGFzIHRoZXkgZG9uJ3QgY29tbXVuaWNhdGUgYW55ICpuZXcqIGlu
Zm9ybWF0aW9uLA0KPiArICogYXNpZGUgZnJvbSB0aGUgc2hvcnQtbGl2ZWQgb2Zmc2V0LCB0aGF0
IGJlY29tZXMgaGlzdG9yeSBhdA0KPiArICogdGhlIG5leHQgZXZlbnQgc2NoZWQtaW4gYW5kIHRo
ZXJlZm9yZSBpc24ndCB1c2VmdWwuDQo+ICsgKiBUaGUgdXNlcnNwYWNlIHRoYXQgbmVlZHMgdG8g
Y29weSBvdXQgQVVYIGRhdGEgaW4gb3ZlcndyaXRlDQo+ICsgKiBtb2RlIHNob3VsZCBrbm93IHRv
IHVzZSB1c2VyX3BhZ2U6OmF1eF9oZWFkIGZvciB0aGUgYWN0dWFsDQo+ICsgKiBvZmZzZXQuIFNv
LCBmcm9tIG5vdyBvbiB3ZSBkb24ndCBvdXRwdXQgQVVYIHJlY29yZHMgdGhhdA0KPiArICogaGF2
ZSAqb25seSogT1ZFUldSSVRFIGZsYWcgc2V0Lg0KPiArICovDQo+ICtpZiAoc2l6ZSB8fCAoaGFu
ZGxlLT5hdXhfZmxhZ3MgJg0KPiB+KHU2NClQRVJGX0FVWF9GTEFHX09WRVJXUklURSkpDQo+ICtw
ZXJmX2V2ZW50X2F1eF9ldmVudChoYW5kbGUtPmV2ZW50LCBhdXhfaGVhZCwgc2l6ZSwNCj4gKyAg
ICAgaGFuZGxlLT5hdXhfZmxhZ3MpOw0KPg0KPiAgcmItPnVzZXJfcGFnZS0+YXV4X2hlYWQgPSBy
Yi0+YXV4X2hlYWQ7DQo+ICBpZiAocmJfbmVlZF9hdXhfd2FrZXVwKHJiKSkNCklNUE9SVEFOVCBO
T1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
