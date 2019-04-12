Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEEB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cpr96zJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDLOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:08:33 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:64089
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLOId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chu1KIf3ZqwBsXpBZT5ABnsn4F8iLo5kGbNCIA70Txo=;
 b=Cpr96zJJYlaceKPM74pvPkUNatFGFhno3ejEjOCBJHIUYHPyXjWgtaeN5YY9pGM61ReXpsnsT73HV+E73tjFisNo69vQ+QG1Hc7FGkG9ZtNOHVhSgsHKljydnWrEA9zTNmlIs2bV1cWFh638+2BALodjUv6Kd/NS29dRm3l1LJs=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1789.eurprd08.prod.outlook.com (10.168.67.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Fri, 12 Apr 2019 14:08:29 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4%7]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 14:08:29 +0000
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
Subject: [PATCH v2 1/2] drm: Add writeback_w,h properties
Thread-Topic: [PATCH v2 1/2] drm: Add writeback_w,h properties
Thread-Index: AQHU8Tk0HfmvuvxK9EqsisCXdPpy7g==
Date:   Fri, 12 Apr 2019 14:08:28 +0000
Message-ID: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
References: <1555078094-6587-1-git-send-email-ben.davis@arm.com>
In-Reply-To: <1555078094-6587-1-git-send-email-ben.davis@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0478.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::34) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3c62601-ef2a-42ed-64e3-08d6bf50564f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0801MB1789;
x-ms-traffictypediagnostic: VI1PR0801MB1789:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1789D52131913ABF2336B4C3E5280@VI1PR0801MB1789.eurprd08.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(97736004)(4326008)(36756003)(14454004)(86362001)(6512007)(99286004)(53936002)(256004)(44832011)(2501003)(7736002)(305945005)(14444005)(5024004)(6916009)(71200400001)(478600001)(71190400001)(54906003)(81156014)(3846002)(2616005)(25786009)(476003)(68736007)(11346002)(105586002)(486006)(50226002)(6486002)(446003)(5640700003)(72206003)(106356001)(2906002)(6506007)(6436002)(316002)(76176011)(102836004)(26005)(2351001)(8676002)(8936002)(66066001)(5660300002)(186003)(52116002)(386003)(81166006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1789;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +kC06EKvHPY0Joxjj14NKlchNOl54rWhMrHzQePGPkOa+MB3GQj0ZEhb1rvZKHOnlx089jJNiI1YHF5X8HWMYcOMiyaPdZxriAUwYhQsSYS+4oMeM81ORCMFLM6DE+2n4BtYp/PCJPWTWR06G6JGR9YNrA38oMpIyPysPVdQzX00OYpFZA6LJk0ECHa8ywvn6UMj64JdbdsTqsrV8YeA2anB6zN6j6o5XzMk1GfSqUd0I4vd4clWZRrWzc2ZJEeK74holW+FRMNQTxI1HtoWuL0qiawifoKv5hDNYC4nFfu/FlpEZnc9Q76PJE04Ens7Z8yCZzdJofQVFG7Ta/RlHzmvbM5y35jA36JAFdY9uxqt5WSAntG2JL0CqSVMHVcVt5KQ31Cp+em6zMEwlmAVgqS4UVOQ9upTmr3svn1gt6o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c62601-ef2a-42ed-64e3-08d6bf50564f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 14:08:28.9129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1789
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
ZWJhY2suYw0KaW5kZXggYzIwZTZmZS4uM2QwNDUzZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9kcm1fd3JpdGViYWNrLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fd3JpdGViYWNr
LmMNCkBAIC03NCw2ICs3NCwxMiBAQA0KICAqCWFwcGxpY2F0aW9ucyBtYWtpbmcgdXNlIG9mIHdy
aXRlYmFjayBjb25uZWN0b3JzICphbHdheXMqIHJldHJpZXZlIGFuDQogICoJb3V0LWZlbmNlIGZv
ciB0aGUgY29tbWl0IGFuZCB1c2UgaXQgYXBwcm9wcmlhdGVseS4NCiAgKglGcm9tIHVzZXJzcGFj
ZSwgdGhpcyBwcm9wZXJ0eSB3aWxsIGFsd2F5cyByZWFkIGFzIHplcm8uDQorICoNCisgKiAgIldS
SVRFQkFDS19XIjoNCisgKglUaGUgd2lkdGggb2YgdGhlIHdyaXRlYmFjayBidWZmZXIgdG8gd3Jp
dGUgYmFjay4gMCBhY3RzIGFzIGRlZmF1bHQuDQorICoNCisgKiAgIldSSVRFQkFDS19IIjoNCisg
KglUaGUgaGVpZ2h0IG9mIHRoZSB3cml0ZWJhY2sgYnVmZmVyIHRvIHdyaXRlIGJhY2suIDAgYWN0
cyBhcyBkZWZhdWx0Lg0KICAqLw0KIA0KICNkZWZpbmUgZmVuY2VfdG9fd2JfY29ubmVjdG9yKHgp
IGNvbnRhaW5lcl9vZih4LT5sb2NrLCBcDQpAQCAtMTQxLDYgKzE0NywyMiBAQCBzdGF0aWMgaW50
IGNyZWF0ZV93cml0ZWJhY2tfcHJvcGVydGllcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KIAkJ
ZGV2LT5tb2RlX2NvbmZpZy53cml0ZWJhY2tfb3V0X2ZlbmNlX3B0cl9wcm9wZXJ0eSA9IHByb3A7
DQogCX0NCiANCisJaWYgKCFkZXYtPm1vZGVfY29uZmlnLnByb3Bfd3JpdGViYWNrX3cpIHsNCisJ
CXByb3AgPSBkcm1fcHJvcGVydHlfY3JlYXRlX3JhbmdlKGRldiwgRFJNX01PREVfUFJPUF9BVE9N
SUMsDQorCQkJCQkJICJXUklURUJBQ0tfVyIsIDEsIFVJTlRfTUFYKTsNCisJCWlmICghcHJvcCkN
CisJCQlyZXR1cm4gLUVOT01FTTsNCisJCWRldi0+bW9kZV9jb25maWcucHJvcF93cml0ZWJhY2tf
dyA9IHByb3A7DQorCX0NCisNCisJaWYgKCFkZXYtPm1vZGVfY29uZmlnLnByb3Bfd3JpdGViYWNr
X2gpIHsNCisJCXByb3AgPSBkcm1fcHJvcGVydHlfY3JlYXRlX3JhbmdlKGRldiwgRFJNX01PREVf
UFJPUF9BVE9NSUMsDQorCQkJCQkJICJXUklURUJBQ0tfSCIsIDEsIFVJTlRfTUFYKTsNCisJCWlm
ICghcHJvcCkNCisJCQlyZXR1cm4gLUVOT01FTTsNCisJCWRldi0+bW9kZV9jb25maWcucHJvcF93
cml0ZWJhY2tfaCA9IHByb3A7DQorCX0NCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTIyNSw2
ICsyNDcsMTIgQEAgaW50IGRybV93cml0ZWJhY2tfY29ubmVjdG9yX2luaXQoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwNCiAJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoJmNvbm5lY3Rvci0+YmFz
ZSwNCiAJCQkJICAgY29uZmlnLT53cml0ZWJhY2tfcGl4ZWxfZm9ybWF0c19wcm9wZXJ0eSwNCiAJ
CQkJICAgYmxvYi0+YmFzZS5pZCk7DQorDQorCWRybV9vYmplY3RfYXR0YWNoX3Byb3BlcnR5KCZj
b25uZWN0b3ItPmJhc2UsDQorCQkJCSAgIGNvbmZpZy0+cHJvcF93cml0ZWJhY2tfdywgMCk7DQor
CWRybV9vYmplY3RfYXR0YWNoX3Byb3BlcnR5KCZjb25uZWN0b3ItPmJhc2UsDQorCQkJCSAgIGNv
bmZpZy0+cHJvcF93cml0ZWJhY2tfaCwgMCk7DQorDQogCXdiX2Nvbm5lY3Rvci0+cGl4ZWxfZm9y
bWF0c19ibG9iX3B0ciA9IGJsb2I7DQogDQogCXJldHVybiAwOw0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZHJtL2RybV9jb25uZWN0b3IuaCBiL2luY2x1ZGUvZHJtL2RybV9jb25uZWN0b3IuaA0KaW5k
ZXggOGZlMjJhYi4uNTFjNGNiMiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9jb25uZWN0
b3IuaA0KKysrIGIvaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oDQpAQCAtNTE1LDYgKzUxNSwx
MCBAQCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSB7DQogCSAqLw0KIAlzdHJ1Y3QgZHJtX3dy
aXRlYmFja19qb2IgKndyaXRlYmFja19qb2I7DQogDQorCS8qKiBAd3JpdGViYWNrX3c6IHdpZHRo
IG9mIHBsYW5lIHRvIHdyaXRlIHRvIHdiIGJ1ZmZlciAqLw0KKwkvKiogQHdyaXRlYmFja19oOiBo
ZWlnaHQgb2YgcGxhbmUgdG8gd3JpdGUgdG8gd2IgYnVmZmVyICovDQorCXVpbnQzMl90IHdyaXRl
YmFja193LCB3cml0ZWJhY2tfaDsNCisNCiAJLyoqDQogCSAqIEBtYXhfcmVxdWVzdGVkX2JwYzog
Q29ubmVjdG9yIHByb3BlcnR5IHRvIGxpbWl0IHRoZSBtYXhpbXVtIGJpdA0KIAkgKiBkZXB0aCBv
ZiB0aGUgcGl4ZWxzLg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5o
IGIvaW5jbHVkZS9kcm0vZHJtX21vZGVfY29uZmlnLmgNCmluZGV4IDdmNjBlOGUuLmEwYzIxMzMg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaA0KKysrIGIvaW5jbHVk
ZS9kcm0vZHJtX21vZGVfY29uZmlnLmgNCkBAIC02MjIsNiArNjIyLDE2IEBAIHN0cnVjdCBkcm1f
bW9kZV9jb25maWcgew0KIAkgKi8NCiAJc3RydWN0IGRybV9wcm9wZXJ0eSAqcHJvcF9jcnRjX2g7
DQogCS8qKg0KKwkgKiBAcHJvcF93cml0ZWJhY2tfdzogV3JpdGViYWNrIGNvbm5lY3RvciBwcm9w
ZXJ0eSBmb3IgdGhlIHBsYW5lDQorCSAqIGRlc3RpbmF0aW9uIHBvc2l0aW9uIGluIHRoZSB3cml0
ZWJhY2sgYnVmZmVyLg0KKwkgKi8NCisJc3RydWN0IGRybV9wcm9wZXJ0eSAqcHJvcF93cml0ZWJh
Y2tfdzsNCisJLyoqDQorCSAqIEBwcm9wX3dyaXRlYmFja19oOiBXcml0ZWJhY2sgY29ubmVjdG9y
IHByb3BlcnR5IGZvciB0aGUgcGxhbmUNCisJICogZGVzdGluYXRpb24gcG9zaXRpb24gaW4gdGhl
IHdyaXRlYmFjayBidWZmZXIuDQorCSAqLw0KKwlzdHJ1Y3QgZHJtX3Byb3BlcnR5ICpwcm9wX3dy
aXRlYmFja19oOw0KKwkvKioNCiAJICogQHByb3BfZmJfaWQ6IERlZmF1bHQgYXRvbWljIHBsYW5l
IHByb3BlcnR5IHRvIHNwZWNpZnkgdGhlDQogCSAqICZkcm1fZnJhbWVidWZmZXIuDQogCSAqLw0K
LS0gDQoyLjcuNA0KDQo=
