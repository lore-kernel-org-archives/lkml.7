Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB55FC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A68206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jRjyR0MG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCLMto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:49:44 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:16902
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfCLMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHENzublx1G6GI1+b2ZWAxn/4Sedj5ZoadEYOhir4T8=;
 b=jRjyR0MGcyrKUdt6Md35tomrqTDSIOQcHHqsoZVgh4kLLZ9l+bFy+4h2aB6HfeZLyAfY6sHj9MLuV64PiH6Mb+5E91NGJ91BdEE0LKgaprRDMZ4gC04ICzWTP9UolvjzyaE/EjlYqjrWkzKtOTYAhvM9p4ty1E+xqqy1b3nibaI=
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB2662.namprd12.prod.outlook.com (20.176.255.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Tue, 12 Mar 2019 12:49:31 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::8df:1157:dba2:30cb]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::8df:1157:dba2:30cb%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 12:49:31 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?utf-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu@google.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 5/5] drm: don't block fb changes for async plane
 updates
Thread-Topic: [PATCH v2 5/5] drm: don't block fb changes for async plane
 updates
Thread-Index: AQHU2Hr15b9d+jEuq021Ol7jk+IimKYHjQmAgABmDoA=
Date:   Tue, 12 Mar 2019 12:49:31 +0000
Message-ID: <8ad63c91-1158-4f52-84db-3f8b9429ebad@amd.com>
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-6-helen.koike@collabora.com>
 <20190312074411.59174024@collabora.com>
In-Reply-To: <20190312074411.59174024@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a2bbb3-9826-461a-e1a9-08d6a6e92be3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2662;
x-ms-traffictypediagnostic: BYAPR12MB2662:
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2662;20:myE/43e71+8xOAmLIKvtx32BOD3+jVRihokLBrloxpbocRnlbMPavM9r6MYVHQwmJ2BIKGCi0iqHmErft1dTFF8LwU3BSvcQxDOsvyOoHS84EFlVvY6q3Rh8NDYE6SlDSVDAKl2DUSO9RGkLcOhOffOYn/+dW7gMRlolcm2WLfeQ6NSdnF9jTd58f9SFKzuuOvDp1x3r6St4jBfa7CK4JDaLfJfAcbO1bVZVO8G4uQ57HX4K/ahonWdcWizJAqIk
x-microsoft-antispam-prvs: <BYAPR12MB26621D5C8FC9546D1E4ED996EC490@BYAPR12MB2662.namprd12.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(2906002)(68736007)(53546011)(15650500001)(71190400001)(105586002)(6436002)(106356001)(4326008)(66066001)(305945005)(71200400001)(5660300002)(54906003)(6486002)(81156014)(81166006)(8676002)(316002)(110136005)(7736002)(11346002)(52116002)(31696002)(76176011)(86362001)(99286004)(6116002)(7416002)(25786009)(53936002)(446003)(486006)(386003)(8936002)(2616005)(186003)(476003)(6512007)(26005)(31686004)(36756003)(256004)(14444005)(102836004)(229853002)(6506007)(14454004)(72206003)(3846002)(478600001)(97736004)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2662;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZNgern2soWR/gDGKNRZYGMWby5mWEM/79NnVWQBGwby3Ii4Pcu0FWysTVT9ks+wsbP1lw5m35ttPhBeM2qCznufEhsAs0qwvcpZdmKMo5GGA6EhDOCQ8OEBW6fwA/dk2YVILrpQ68dsJJ0xCe4RwXDg/izvUPV0vNy4QE7nTwBUqOh7D80Iwj4J/e456w83BpgErnDm4b442rU0r7Zx1YKpNOEwPi3eJlAMApB0unYSVWUREPOX1neSoZIHOFuBxlhVmZYx5fMF2S19VWb77dvU+TpcVPclj722ehJPIfDlQ5Pcx5I0rMrXRJeyYTeH085ntVVQo1hlWbzNMVFSWu6244ZNJFY7wNwHWK7Cd2CE/JE1DQrUjKNQSyrW1gV0TmpSgfV+euDhXe5QCwWX1/bxSm4H7Ok6QlG3czTAyfi8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60DC841580B7654BADF12E8C3D193D1B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a2bbb3-9826-461a-e1a9-08d6a6e92be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 12:49:31.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xMi8xOSAyOjQ0IEFNLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+IE9uIE1vbiwgMTEg
TWFyIDIwMTkgMjM6MjI6MDMgLTAzMDANCj4gSGVsZW4gS29pa2UgPGhlbGVuLmtvaWtlQGNvbGxh
Ym9yYS5jb20+IHdyb3RlOg0KPiANCj4+IEluIHRoZSBjYXNlIG9mIGEgbm9ybWFsIHN5bmMgdXBk
YXRlLCB0aGUgcHJlcGFyYXRpb24gb2YgZnJhbWVidWZmZXJzIChiZQ0KPj4gaXQgY2FsbGluZyBk
cm1fYXRvbWljX2hlbHBlcl9wcmVwYXJlX3BsYW5lcygpIG9yIGRvaW5nIHNldHVwcyB3aXRoDQo+
PiBkcm1fZnJhbWVidWZmZXJfZ2V0KCkpIGFyZSBwZXJmb3JtZWQgaW4gdGhlIG5ld19zdGF0ZSBh
bmQgdGhlIHJlc3BlY3RpdmUNCj4+IGNsZWFudXBzIGFyZSBwZXJmb3JtZWQgaW4gdGhlIG9sZF9z
dGF0ZS4NCj4+DQo+PiBJbiB0aGUgY2FzZSBvZiBhc3luYyB1cGRhdGVzLCB0aGUgcHJlcGFyYXRp
b24gaXMgYWxzbyBkb25lIGluIHRoZQ0KPj4gbmV3X3N0YXRlIGJ1dCB0aGUgY2xlYW51cHMgYXJl
IGRvbmUgaW4gdGhlIG5ld19zdGF0ZSAoYmVjYXVzZSB1cGRhdGVzDQo+PiBhcmUgcGVyZm9ybWVk
IGluIHBsYWNlLCBpLmUuIGluIHRoZSBjdXJyZW50IHN0YXRlKS4NCj4+DQo+PiBUaGUgY3VycmVu
dCBjb2RlIGJsb2NrcyBhc3luYyB1ZHBhdGVzIHdoZW4gdGhlIGZiIGlzIGNoYW5nZWQsIHR1cm5p
bmcNCj4+IGFzeW5jIHVwZGF0ZXMgaW50byBzeW5jIHVwZGF0ZXMsIHNsb3dpbmcgZG93biBjdXJz
b3IgdXBkYXRlcyBhbmQNCj4+IGludHJvZHVjaW5nIHJlZ3Jlc3Npb25zIGluIGlndCB0ZXN0cyB3
aXRoIGVycm9ycyBvZiB0eXBlOg0KPj4NCj4+ICJDUklUSUNBTDogY29tcGxldGVkIDk3IGN1cnNv
ciB1cGRhdGVkIGluIGEgcGVyaW9kIG9mIDMwIGZsaXBzLCB3ZQ0KPj4gZXhwZWN0IHRvIGNvbXBs
ZXRlIGFwcHJveGltYXRlbHkgMTUzNjAgdXBkYXRlcywgd2l0aCB0aGUgdGhyZXNob2xkIHNldA0K
Pj4gYXQgNzY4MCINCj4+DQo+PiBGYiBjaGFuZ2VzIGluIGFzeW5jIHVwZGF0ZXMgd2VyZSBwcmV2
ZW50ZWQgdG8gYXZvaWQgdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCj4+DQo+PiAtIEFzeW5jIHVw
ZGF0ZSwgb2xkZmIgPSBOVUxMLCBuZXdmYiA9IGZiMSwgcHJlcGFyZSBmYjEsIGNsZWFudXAgZmIx
DQo+PiAtIEFzeW5jIHVwZGF0ZSwgb2xkZmIgPSBmYjEsIG5ld2ZiID0gZmIyLCBwcmVwYXJlIGZi
MiwgY2xlYW51cCBmYjINCj4+IC0gTm9uLWFzeW5jIGNvbW1pdCwgb2xkZmIgPSBmYjIsIG5ld2Zi
ID0gZmIxLCBwcmVwYXJlIGZiMSwgY2xlYW51cCBmYjIgKHdyb25nKQ0KPj4gV2hlcmUgd2UgaGF2
ZSBhIHNpbmdsZSBjYWxsIHRvIHByZXBhcmUgZmIyIGJ1dCBkb3VibGUgY2xlYW51cCBjYWxsIHRv
IGZiMi4NCj4+DQo+PiBUbyBzb2x2ZSB0aGUgYWJvdmUgcHJvYmxlbXMsIGluc3RlYWQgb2YgYmxv
Y2tpbmcgYXN5bmMgZmIgY2hhbmdlcywgd2UNCj4+IHBsYWNlIHRoZSBvbGQgZnJhbWVidWZmZXIg
aW4gdGhlIG5ld19zdGF0ZSBvYmplY3QsIHNvIHdoZW4gdGhlIGNvZGUNCj4+IHBlcmZvcm1zIGNs
ZWFudXBzIGluIHRoZSBuZXdfc3RhdGUgaXQgd2lsbCBjbGVhbnVwIHRoZSBvbGRfZmIgYW5kIHdl
DQo+PiB3aWxsIGhhdmUgdGhlIGZvbGxvd2luZyBzY2VuYXJpbyBpbnN0ZWFkOg0KPj4NCj4+IC0g
QXN5bmMgdXBkYXRlLCBvbGRmYiA9IE5VTEwsIG5ld2ZiID0gZmIxLCBwcmVwYXJlIGZiMSwgbm8g
Y2xlYW51cA0KPj4gLSBBc3luYyB1cGRhdGUsIG9sZGZiID0gZmIxLCBuZXdmYiA9IGZiMiwgcHJl
cGFyZSBmYjIsIGNsZWFudXAgZmIxDQo+PiAtIE5vbi1hc3luYyBjb21taXQsIG9sZGZiID0gZmIy
LCBuZXdmYiA9IGZiMSwgcHJlcGFyZSBmYjEsIGNsZWFudXAgZmIyDQo+Pg0KPj4gV2hlcmUgY2Fs
bHMgdG8gcHJlcGFyZS9jbGVhbnVwIGFyZSBiYWxhbmNlZC4NCj4+DQo+PiBDYzogPHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc+ICMgdjQuMTQrDQo+PiBGaXhlczogMjVkYzE5NGIzNGRkICgiZHJtOiBC
bG9jayBmYiBjaGFuZ2VzIGZvciBhc3luYyBwbGFuZSB1cGRhdGVzIikNCj4+IFN1Z2dlc3RlZC1i
eTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IEhlbGVuIEtvaWtlIDxoZWxlbi5rb2lrZUBjb2xsYWJvcmEuY29tPg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9y
YS5jb20+DQoNClJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXps
YXVza2FzQGFtZC5jb20+DQoNCkkgd2FzIHRoaW5raW5nIHRoYXQgdGhlIGNvbW1lbnQgY291bGQg
Z28gaW4gYXN5bmNfY29tbWl0IG9yIGFzeW5jX2NoZWNrLCANCmJ1dCBJIGd1ZXNzIGl0IHdvcmtz
IHRoZXJlIHRvby4gTWF5YmUgaXQgbmVlZHMgYSBGSVhNRSBvciBhIFRPRE8gZm9yIGEgDQpmdWxs
IHN0YXRlIHN3YXAsIGJ1dCB0aGVzZSBhcmUganVzdCBuaXRwaWNrcy4NCg0KTmljaG9sYXMgS2F6
bGF1c2thcw0KDQo+IA0KPj4NCj4+IC0tLQ0KPj4gSGVsbG8sDQo+Pg0KPj4gQXMgbWVudGlvbmVk
IGluIHRoZSBjb3ZlciBsZXR0ZXIsIEkgdGVzdGVkIGluIGFsbW9zdCBhbGwgcGxhdGZvcm1zIHdp
dGgNCj4+IGlndCBwbGFuZV9jdXJzb3JfbGVnYWN5IGFuZCBrbXNfY3Vyc29yX2xlZ2FjeSBhbmQg
SSBkaWRuJ3Qgc2VlIGFueQ0KPj4gcmVncmVzc2lvbnMuIEJ1dCBJIGNvdWxkbid0IHRlc3Qgb24g
TVNNIGFuZCBBTUQgYmVjYXVzZSBJIGRvbid0IGhhdmUNCj4+IHRoZSBoYXJkd2FyZSBJIHdvdWxk
IGFwcHJlY2lhdGUgaWYgYW55b25lIGNvdWxkIGhlbHAgbWUgdGVzdGluZyB0aG9zZS4NCj4+DQo+
PiBUaGFua3MhDQo+PiBIZWxlbg0KPj4NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIENoYW5nZSB0
aGUgb3JkZXIgb2YgdGhlIHBhdGNoIGluIHRoZSBzZXJpZXMsIGFkZCB0aGlzIGFzIHRoZSBsYXN0
IG9uZS4NCj4+IC0gQWRkIGRvY3VtZW50YXRpb24NCj4+IC0gcy9iYWxsYW5jZWQvYmFsYW5jZWQN
Cj4+DQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jICAgICAgfCAyMCAr
KysrKysrKysrLS0tLS0tLS0tLQ0KPj4gICBpbmNsdWRlL2RybS9kcm1fbW9kZXNldF9oZWxwZXJf
dnRhYmxlcy5oIHwgIDUgKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2RybV9hdG9taWNfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIu
Yw0KPj4gaW5kZXggNTQwYTc3YTJhZGU5Li5lN2ViOTZmMWVmYzIgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9hdG9taWNfaGVscGVyLmMNCj4+IEBAIC0xNjA4LDE1ICsxNjA4LDYgQEAgaW50IGRy
bV9hdG9taWNfaGVscGVyX2FzeW5jX2NoZWNrKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+PiAg
IAkgICAgb2xkX3BsYW5lX3N0YXRlLT5jcnRjICE9IG5ld19wbGFuZV9zdGF0ZS0+Y3J0YykNCj4+
ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAgDQo+PiAtCS8qDQo+PiAtCSAqIEZJWE1FOiBTaW5j
ZSBwcmVwYXJlX2ZiIGFuZCBjbGVhbnVwX2ZiIGFyZSBhbHdheXMgY2FsbGVkIG9uDQo+PiAtCSAq
IHRoZSBuZXdfcGxhbmVfc3RhdGUgZm9yIGFzeW5jIHVwZGF0ZXMgd2UgbmVlZCB0byBibG9jayBm
cmFtZWJ1ZmZlcg0KPj4gLQkgKiBjaGFuZ2VzLiBUaGlzIHByZXZlbnRzIHVzZSBvZiBhIGZiIHRo
YXQncyBiZWVuIGNsZWFuZWQgdXAgYW5kDQo+PiAtCSAqIGRvdWJsZSBjbGVhbnVwcyBmcm9tIG9j
Y3VyaW5nLg0KPj4gLQkgKi8NCj4+IC0JaWYgKG9sZF9wbGFuZV9zdGF0ZS0+ZmIgIT0gbmV3X3Bs
YW5lX3N0YXRlLT5mYikNCj4+IC0JCXJldHVybiAtRUlOVkFMOw0KPj4gLQ0KPj4gICAJZnVuY3Mg
PSBwbGFuZS0+aGVscGVyX3ByaXZhdGU7DQo+PiAgIAlpZiAoIWZ1bmNzLT5hdG9taWNfYXN5bmNf
dXBkYXRlKQ0KPj4gICAJCXJldHVybiAtRUlOVkFMOw0KPj4gQEAgLTE2NTcsNiArMTY0OCw5IEBA
IHZvaWQgZHJtX2F0b21pY19oZWxwZXJfYXN5bmNfY29tbWl0KHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsDQo+PiAgIAlpbnQgaTsNCj4+ICAgDQo+PiAgIAlmb3JfZWFjaF9uZXdfcGxhbmVfaW5fc3Rh
dGUoc3RhdGUsIHBsYW5lLCBwbGFuZV9zdGF0ZSwgaSkgew0KPj4gKwkJc3RydWN0IGRybV9mcmFt
ZWJ1ZmZlciAqbmV3X2ZiID0gcGxhbmVfc3RhdGUtPmZiOw0KPj4gKwkJc3RydWN0IGRybV9mcmFt
ZWJ1ZmZlciAqb2xkX2ZiID0gcGxhbmUtPnN0YXRlLT5mYjsNCj4+ICsNCj4+ICAgCQlmdW5jcyA9
IHBsYW5lLT5oZWxwZXJfcHJpdmF0ZTsNCj4+ICAgCQlmdW5jcy0+YXRvbWljX2FzeW5jX3VwZGF0
ZShwbGFuZSwgcGxhbmVfc3RhdGUpOw0KPj4gICANCj4+IEBAIC0xNjY1LDExICsxNjU5LDE3IEBA
IHZvaWQgZHJtX2F0b21pY19oZWxwZXJfYXN5bmNfY29tbWl0KHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsDQo+PiAgIAkJICogcGxhbmUtPnN0YXRlIGluLXBsYWNlLCBtYWtlIHN1cmUgYXQgbGVhc3Qg
Y29tbW9uDQo+PiAgIAkJICogcHJvcGVydGllcyBoYXZlIGJlZW4gcHJvcGVybHkgdXBkYXRlZC4N
Cj4+ICAgCQkgKi8NCj4+IC0JCVdBUk5fT05fT05DRShwbGFuZS0+c3RhdGUtPmZiICE9IHBsYW5l
X3N0YXRlLT5mYik7DQo+PiArCQlXQVJOX09OX09OQ0UocGxhbmUtPnN0YXRlLT5mYiAhPSBuZXdf
ZmIpOw0KPj4gICAJCVdBUk5fT05fT05DRShwbGFuZS0+c3RhdGUtPmNydGNfeCAhPSBwbGFuZV9z
dGF0ZS0+Y3J0Y194KTsNCj4+ICAgCQlXQVJOX09OX09OQ0UocGxhbmUtPnN0YXRlLT5jcnRjX3kg
IT0gcGxhbmVfc3RhdGUtPmNydGNfeSk7DQo+PiAgIAkJV0FSTl9PTl9PTkNFKHBsYW5lLT5zdGF0
ZS0+c3JjX3ggIT0gcGxhbmVfc3RhdGUtPnNyY194KTsNCj4+ICAgCQlXQVJOX09OX09OQ0UocGxh
bmUtPnN0YXRlLT5zcmNfeSAhPSBwbGFuZV9zdGF0ZS0+c3JjX3kpOw0KPj4gKw0KPj4gKwkJLyoN
Cj4+ICsJCSAqIE1ha2Ugc3VyZSB0aGUgRkJzIGhhdmUgYmVlbiBzd2FwcGVkIHNvIHRoYXQgY2xl
YW51cHMgaW4gdGhlDQo+PiArCQkgKiBuZXdfc3RhdGUgcGVyZm9ybXMgYSBjbGVhbnVwIGluIHRo
ZSBvbGQgRkIuDQo+PiArCQkgKi8NCj4+ICsJCVdBUk5fT05fT05DRShwbGFuZV9zdGF0ZS0+ZmIg
IT0gb2xkX2ZiKTsNCj4+ICAgCX0NCj4+ICAgfQ0KPj4gICBFWFBPUlRfU1lNQk9MKGRybV9hdG9t
aWNfaGVscGVyX2FzeW5jX2NvbW1pdCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJt
X21vZGVzZXRfaGVscGVyX3Z0YWJsZXMuaCBiL2luY2x1ZGUvZHJtL2RybV9tb2Rlc2V0X2hlbHBl
cl92dGFibGVzLmgNCj4+IGluZGV4IGNmYjdiZTQwYmVkNy4uY2U1ODJlOGU4ZjJmIDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJtX21vZGVzZXRfaGVscGVyX3Z0YWJsZXMuaA0KPj4gKysr
IGIvaW5jbHVkZS9kcm0vZHJtX21vZGVzZXRfaGVscGVyX3Z0YWJsZXMuaA0KPj4gQEAgLTExNzQs
NiArMTE3NCwxMSBAQCBzdHJ1Y3QgZHJtX3BsYW5lX2hlbHBlcl9mdW5jcyB7DQo+PiAgIAkgKiBj
dXJyZW50IG9uZSB3aXRoIHRoZSBuZXcgcGxhbmUgY29uZmlndXJhdGlvbnMgaW4gdGhlIG5ldw0K
Pj4gICAJICogcGxhbmVfc3RhdGUuDQo+PiAgIAkgKg0KPj4gKwkgKiBEcml2ZXJzIHNob3VsZCBh
bHNvIHN3YXAgdGhlIGZyYW1lYnVmZmVycyBiZXR3ZWVuIHBsYW5lIHN0YXRlDQo+PiArCSAqIGFu
ZCBuZXdfc3RhdGUuIFRoaXMgaXMgcmVxdWlyZWQgYmVjYXVzZSBwcmVwYXJlIGFuZCBjbGVhbnVw
IGNhbGxzDQo+PiArCSAqIGFyZSBwZXJmb3JtZWQgb24gdGhlIG5ld19zdGF0ZSBvYmplY3QsIHRo
ZW4gdG8gY2xlYW51cCB0aGUgb2xkDQo+PiArCSAqIGZyYW1lYnVmZmVyLCBpdCBuZWVkcyB0byBi
ZSBwbGFjZWQgaW5zaWRlIHRoZSBuZXdfc3RhdGUgb2JqZWN0Lg0KPj4gKwkgKg0KPj4gICAJICog
RklYTUU6DQo+PiAgIAkgKiAgLSBJdCBvbmx5IHdvcmtzIGZvciBzaW5nbGUgcGxhbmUgdXBkYXRl
cw0KPj4gICAJICogIC0gQXN5bmMgUGFnZWZsaXBzIGFyZSBub3Qgc3VwcG9ydGVkIHlldA0KPiAN
Cg0K
