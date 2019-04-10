Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9639C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D00222AE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y3UFi/o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfDJLLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:11:17 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:60869
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728160AbfDJLLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU5INC+Th56X+Pim2OP8dM5obkhyXF4qg6HPq5D/Vic=;
 b=Y3UFi/o2MG3UyFNVFa1c1+HjZkacN76VGJdFnIasmvq2zumykkSXGECMpXZTrexSIoXcfsUr2EZaotFv7buCkbKvNIgAKMsqUzg+8lhoXfZ2h9kz36IfbxdUwgvxl6rpa5IgNPvhv6YdtH3/BsTKjRb7mZNcbeBgcBh/UzKSlUA=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1856.eurprd08.prod.outlook.com (10.168.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 10 Apr 2019 11:11:11 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011%9]) with mapi id 15.20.1771.014; Wed, 10 Apr 2019
 11:11:11 +0000
From:   Ben Davis <Ben.Davis@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Davis <Ben.Davis@arm.com>
Subject: [PATCH 1/2] drm: Add writeback_w,h properties
Thread-Topic: [PATCH 1/2] drm: Add writeback_w,h properties
Thread-Index: AQHU744alEhKdJspbka0D7reOUQ11g==
Date:   Wed, 10 Apr 2019 11:11:11 +0000
Message-ID: <4509c625676508caf2b3f5035d901d8fe862fa76.1554891327.git.ben.davis@arm.com>
References: <cover.1554891327.git.ben.davis@arm.com>
In-Reply-To: <cover.1554891327.git.ben.davis@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::30) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d88aedf7-fd46-4703-07cf-08d6bda53cdb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0801MB1856;
x-ms-traffictypediagnostic: VI1PR0801MB1856:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1856ED2562C686CAC73F6AA9E52E0@VI1PR0801MB1856.eurprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(4326008)(99286004)(81156014)(54906003)(6486002)(7736002)(305945005)(118296001)(66066001)(446003)(81166006)(71190400001)(86362001)(2501003)(53936002)(186003)(71200400001)(476003)(486006)(6512007)(316002)(478600001)(2616005)(36756003)(8676002)(52116002)(11346002)(14444005)(2906002)(3846002)(6116002)(105586002)(5660300002)(68736007)(5024004)(106356001)(8936002)(26005)(25786009)(50226002)(102836004)(14454004)(44832011)(6436002)(2351001)(256004)(5640700003)(97736004)(6916009)(72206003)(386003)(76176011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1856;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GxTJBOdnWvu7LutnlvS2cA77ZdpV+cxvPA3Zxz+d8rcQxY4IAzJr+693JVKVobuYRWQcPMuQ8mfbOIENhumTXnFZ00V7DBmXuPuZZhmCbf5MIhxOvkMzf0mDqEn6m6VUEw6xLDpv5gS9brkcrwLVctzGd6rzEwZYSJiz3eoFpF+cZw3bONizxRa8BMQAGeVozjsJYmGcmPS6Zq9UsShyqiAEo+HIDpMTf3mtR/m/tmy0P8xZnZuqpOiKjiOj/Ekcsm7hee1gQFkWsDcwDqDk203ddUWGH+hF7oGR7saFXdNfxR6peyj9e4PG7SxLB1anFDSZuLMdkCX3kUTKY047ET07gQCdzRCBk+5oS1eFIu1XuVa9wkxyA1PQ2RlRYDDUnxPzCkJYhWBEFwZl/FOkYjF+URRPXUS7yCtiJ8ZCp6Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88aedf7-fd46-4703-07cf-08d6bda53cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:11:11.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyBwcm9wZXJ0aWVzIHRvIHNwZWNpZnkgd2lkdGggYW5kIGhlaWdodCBmb3Igd3JpdGVi
YWNrLg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW4gRGF2aXMgPGJlbi5kYXZpc0Bhcm0uY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfdWFwaS5jIHwgIDggKysrKysrKysNCiBkcml2
ZXJzL2dwdS9kcm0vZHJtX3dyaXRlYmFjay5jICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQogaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oICAgICAgIHwgIDQgKysrKw0KIGlu
Y2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oICAgICB8IDEwICsrKysrKysrKysNCiA0IGZpbGVz
IGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fYXRvbWljX3VhcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX3VhcGkuYw0K
aW5kZXggZDUyMGEwNC4uMWY2OGRjZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1f
YXRvbWljX3VhcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfdWFwaS5jDQpA
QCAtNzY1LDYgKzc2NSwxMCBAQCBzdGF0aWMgaW50IGRybV9hdG9taWNfY29ubmVjdG9yX3NldF9w
cm9wZXJ0eShzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLA0KIAkJCXJldHVybiAtRUlO
VkFMOw0KIAkJfQ0KIAkJc3RhdGUtPmNvbnRlbnRfcHJvdGVjdGlvbiA9IHZhbDsNCisJfSBlbHNl
IGlmIChwcm9wZXJ0eSA9PSBjb25maWctPnByb3Bfd3JpdGViYWNrX3cpIHsNCisJCXN0YXRlLT53
cml0ZWJhY2tfdyA9IHZhbDsNCisJfSBlbHNlIGlmIChwcm9wZXJ0eSA9PSBjb25maWctPnByb3Bf
d3JpdGViYWNrX2gpIHsNCisJCXN0YXRlLT53cml0ZWJhY2tfaCA9IHZhbDsNCiAJfSBlbHNlIGlm
IChwcm9wZXJ0eSA9PSBjb25maWctPndyaXRlYmFja19mYl9pZF9wcm9wZXJ0eSkgew0KIAkJc3Ry
dWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIgPSBkcm1fZnJhbWVidWZmZXJfbG9va3VwKGRldiwgTlVM
TCwgdmFsKTsNCiAJCWludCByZXQgPSBkcm1fYXRvbWljX3NldF93cml0ZWJhY2tfZmJfZm9yX2Nv
bm5lY3RvcihzdGF0ZSwgZmIpOw0KQEAgLTgzNyw2ICs4NDEsMTAgQEAgZHJtX2F0b21pY19jb25u
ZWN0b3JfZ2V0X3Byb3BlcnR5KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsDQogCQkq
dmFsID0gc3RhdGUtPnNjYWxpbmdfbW9kZTsNCiAJfSBlbHNlIGlmIChwcm9wZXJ0eSA9PSBjb25u
ZWN0b3ItPmNvbnRlbnRfcHJvdGVjdGlvbl9wcm9wZXJ0eSkgew0KIAkJKnZhbCA9IHN0YXRlLT5j
b250ZW50X3Byb3RlY3Rpb247DQorCX0gZWxzZSBpZiAocHJvcGVydHkgPT0gY29uZmlnLT5wcm9w
X3dyaXRlYmFja193KSB7DQorCQkqdmFsID0gc3RhdGUtPndyaXRlYmFja193Ow0KKwl9IGVsc2Ug
aWYgKHByb3BlcnR5ID09IGNvbmZpZy0+cHJvcF93cml0ZWJhY2tfaCkgew0KKwkJKnZhbCA9IHN0
YXRlLT53cml0ZWJhY2tfaDsNCiAJfSBlbHNlIGlmIChwcm9wZXJ0eSA9PSBjb25maWctPndyaXRl
YmFja19mYl9pZF9wcm9wZXJ0eSkgew0KIAkJLyogV3JpdGViYWNrIGZyYW1lYnVmZmVyIGlzIG9u
ZS1zaG90LCB3cml0ZSBhbmQgZm9yZ2V0ICovDQogCQkqdmFsID0gMDsNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX3dyaXRlYmFjay5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV93cml0
ZWJhY2suYw0KaW5kZXggYzIwZTZmZS4uYmU0MjA3MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9kcm1fd3JpdGViYWNrLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fd3JpdGViYWNr
LmMNCkBAIC03NCw2ICs3NCwxMiBAQA0KICAqCWFwcGxpY2F0aW9ucyBtYWtpbmcgdXNlIG9mIHdy
aXRlYmFjayBjb25uZWN0b3JzICphbHdheXMqIHJldHJpZXZlIGFuDQogICoJb3V0LWZlbmNlIGZv
ciB0aGUgY29tbWl0IGFuZCB1c2UgaXQgYXBwcm9wcmlhdGVseS4NCiAgKglGcm9tIHVzZXJzcGFj
ZSwgdGhpcyBwcm9wZXJ0eSB3aWxsIGFsd2F5cyByZWFkIGFzIHplcm8uDQorICoNCisgKiAgIldS
SVRFQkFDS19XIjoNCisgKglUaGUgd2lkdGggb2YgdGhlIHdyaXRlYmFjayBidWZmZXIgdG8gd3Jp
dGUgYmFjay4NCisgKg0KKyAqICAiV1JJVEVCQUNLX0giOg0KKyAqCVRoZSBoZWlnaHQgb2YgdGhl
IHdyaXRlYmFjayBidWZmZXIgdG8gd3JpdGUgYmFjay4NCiAgKi8NCiANCiAjZGVmaW5lIGZlbmNl
X3RvX3diX2Nvbm5lY3Rvcih4KSBjb250YWluZXJfb2YoeC0+bG9jaywgXA0KQEAgLTE0MSw2ICsx
NDcsMjIgQEAgc3RhdGljIGludCBjcmVhdGVfd3JpdGViYWNrX3Byb3BlcnRpZXMoc3RydWN0IGRy
bV9kZXZpY2UgKmRldikNCiAJCWRldi0+bW9kZV9jb25maWcud3JpdGViYWNrX291dF9mZW5jZV9w
dHJfcHJvcGVydHkgPSBwcm9wOw0KIAl9DQogDQorCWlmICghZGV2LT5tb2RlX2NvbmZpZy5wcm9w
X3dyaXRlYmFja193KSB7DQorCQlwcm9wID0gZHJtX3Byb3BlcnR5X2NyZWF0ZV9yYW5nZShkZXYs
IERSTV9NT0RFX1BST1BfQVRPTUlDLA0KKwkJCQkJCSAiV1JJVEVCQUNLX1ciLCAwLCBJTlRfTUFY
KTsNCisJCWlmICghcHJvcCkNCisJCQlyZXR1cm4gLUVOT01FTTsNCisJCWRldi0+bW9kZV9jb25m
aWcucHJvcF93cml0ZWJhY2tfdyA9IHByb3A7DQorCX0NCisNCisJaWYgKCFkZXYtPm1vZGVfY29u
ZmlnLnByb3Bfd3JpdGViYWNrX2gpIHsNCisJCXByb3AgPSBkcm1fcHJvcGVydHlfY3JlYXRlX3Jh
bmdlKGRldiwgRFJNX01PREVfUFJPUF9BVE9NSUMsDQorCQkJCQkJICJXUklURUJBQ0tfSCIsIDAs
IElOVF9NQVgpOw0KKwkJaWYgKCFwcm9wKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KKwkJZGV2LT5t
b2RlX2NvbmZpZy5wcm9wX3dyaXRlYmFja19oID0gcHJvcDsNCisJfQ0KKw0KIAlyZXR1cm4gMDsN
CiB9DQogDQpAQCAtMjI1LDYgKzI0NywxMiBAQCBpbnQgZHJtX3dyaXRlYmFja19jb25uZWN0b3Jf
aW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KIAlkcm1fb2JqZWN0X2F0dGFjaF9wcm9wZXJ0
eSgmY29ubmVjdG9yLT5iYXNlLA0KIAkJCQkgICBjb25maWctPndyaXRlYmFja19waXhlbF9mb3Jt
YXRzX3Byb3BlcnR5LA0KIAkJCQkgICBibG9iLT5iYXNlLmlkKTsNCisNCisJZHJtX29iamVjdF9h
dHRhY2hfcHJvcGVydHkoJmNvbm5lY3Rvci0+YmFzZSwNCisJCQkJICAgY29uZmlnLT5wcm9wX3dy
aXRlYmFja193LCAwKTsNCisJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoJmNvbm5lY3Rvci0+
YmFzZSwNCisJCQkJICAgY29uZmlnLT5wcm9wX3dyaXRlYmFja19oLCAwKTsNCisNCiAJd2JfY29u
bmVjdG9yLT5waXhlbF9mb3JtYXRzX2Jsb2JfcHRyID0gYmxvYjsNCiANCiAJcmV0dXJuIDA7DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oIGIvaW5jbHVkZS9kcm0vZHJt
X2Nvbm5lY3Rvci5oDQppbmRleCA4ZmUyMmFiLi41MWM0Y2IyIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9kcm0vZHJtX2Nvbm5lY3Rvci5oDQorKysgYi9pbmNsdWRlL2RybS9kcm1fY29ubmVjdG9yLmgN
CkBAIC01MTUsNiArNTE1LDEwIEBAIHN0cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlIHsNCiAJICov
DQogCXN0cnVjdCBkcm1fd3JpdGViYWNrX2pvYiAqd3JpdGViYWNrX2pvYjsNCiANCisJLyoqIEB3
cml0ZWJhY2tfdzogd2lkdGggb2YgcGxhbmUgdG8gd3JpdGUgdG8gd2IgYnVmZmVyICovDQorCS8q
KiBAd3JpdGViYWNrX2g6IGhlaWdodCBvZiBwbGFuZSB0byB3cml0ZSB0byB3YiBidWZmZXIgKi8N
CisJdWludDMyX3Qgd3JpdGViYWNrX3csIHdyaXRlYmFja19oOw0KKw0KIAkvKioNCiAJICogQG1h
eF9yZXF1ZXN0ZWRfYnBjOiBDb25uZWN0b3IgcHJvcGVydHkgdG8gbGltaXQgdGhlIG1heGltdW0g
Yml0DQogCSAqIGRlcHRoIG9mIHRoZSBwaXhlbHMuDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0v
ZHJtX21vZGVfY29uZmlnLmggYi9pbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaA0KaW5kZXgg
N2Y2MGU4ZS4uYTBjMjEzMyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZp
Zy5oDQorKysgYi9pbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaA0KQEAgLTYyMiw2ICs2MjIs
MTYgQEAgc3RydWN0IGRybV9tb2RlX2NvbmZpZyB7DQogCSAqLw0KIAlzdHJ1Y3QgZHJtX3Byb3Bl
cnR5ICpwcm9wX2NydGNfaDsNCiAJLyoqDQorCSAqIEBwcm9wX3dyaXRlYmFja193OiBXcml0ZWJh
Y2sgY29ubmVjdG9yIHByb3BlcnR5IGZvciB0aGUgcGxhbmUNCisJICogZGVzdGluYXRpb24gcG9z
aXRpb24gaW4gdGhlIHdyaXRlYmFjayBidWZmZXIuDQorCSAqLw0KKwlzdHJ1Y3QgZHJtX3Byb3Bl
cnR5ICpwcm9wX3dyaXRlYmFja193Ow0KKwkvKioNCisJICogQHByb3Bfd3JpdGViYWNrX2g6IFdy
aXRlYmFjayBjb25uZWN0b3IgcHJvcGVydHkgZm9yIHRoZSBwbGFuZQ0KKwkgKiBkZXN0aW5hdGlv
biBwb3NpdGlvbiBpbiB0aGUgd3JpdGViYWNrIGJ1ZmZlci4NCisJICovDQorCXN0cnVjdCBkcm1f
cHJvcGVydHkgKnByb3Bfd3JpdGViYWNrX2g7DQorCS8qKg0KIAkgKiBAcHJvcF9mYl9pZDogRGVm
YXVsdCBhdG9taWMgcGxhbmUgcHJvcGVydHkgdG8gc3BlY2lmeSB0aGUNCiAJICogJmRybV9mcmFt
ZWJ1ZmZlci4NCiAJICovDQotLSANCjIuNy40DQoNCg==
