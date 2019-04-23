Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D733206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fOckL1aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfDWKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:48:51 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:41541
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWKsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djzE1QQjgIY2Z5PVI1sgKUQc1HThfN/4STZI6G0Vcm4=;
 b=fOckL1aJzX6iNTbaiRkAKfhdqcurSsCoyu3N6ucYtj/XxZVfgd6VqSjOX0f+nFOrXEWDEgilLS4KiANok4EmDFCDA6/azV8NsFKKuyj3jcbCShlpQDAa9EJakCZQZ9Vn906dgKRYc+mzO8FHUJRWaZ+Kjhr5rdlimNebzGpnZJw=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1870.eurprd08.prod.outlook.com (10.173.73.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:48:45 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4%7]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:48:45 +0000
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
Subject: [PATCH v3 1/2] drm: Add writeback_dest_w,h properties
Thread-Topic: [PATCH v3 1/2] drm: Add writeback_dest_w,h properties
Thread-Index: AQHU+cIfA2NnEiSpoU6Azfz4aPpYLQ==
Date:   Tue, 23 Apr 2019 10:48:44 +0000
Message-ID: <1556016490-6906-2-git-send-email-ben.davis@arm.com>
References: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
In-Reply-To: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e848dc01-7d67-4080-ffa9-08d6c7d941e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0801MB1870;
x-ms-traffictypediagnostic: VI1PR0801MB1870:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1870AFD6387E52FEE2E61235E5230@VI1PR0801MB1870.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(54906003)(386003)(6506007)(53936002)(71200400001)(71190400001)(6512007)(2906002)(76176011)(6116002)(3846002)(5640700003)(305945005)(7736002)(66556008)(64756008)(66476007)(66946007)(316002)(6436002)(73956011)(6916009)(36756003)(6486002)(2351001)(66446008)(86362001)(256004)(14454004)(8936002)(97736004)(52116002)(5024004)(186003)(446003)(44832011)(478600001)(102836004)(99286004)(81166006)(81156014)(8676002)(72206003)(26005)(68736007)(66066001)(2501003)(14444005)(486006)(4326008)(11346002)(476003)(5660300002)(2616005)(25786009)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1870;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AX3OgGtdmUYDN9X3xYuYt8BInA5EWetGScJHcpr4rd5Em5b+N7fQdBN3tp3DeHijkYKJWx2UtmX+9p0LpVbX7GupniI7eeEv2iOmxp1oT0m4hKZG+G3mjP/bpgycYgtd1XzsKMzP/640n+AtjvP5EcpJ8WIN+/dMxF73+AJf7hQb4lMugre7GDwGqwaPfMH+ak/Yl+v5r1Wcl8k/4vkXGuGNnKPXoBIoIAlPKNIiyX15olhoGOCsIkjGignvbrVsmBdXJ3W6yModx/hlNYOXL0r6eOY1vM65yS+/9xoDhkzZpuLaud2K1dY+CD3Pv+89SwakZkFHXV+wQ3DZS0g7RbWlT4yp0oNMq6jxt48lyVMac5Kg9PFqn2xziv3GlUX1X70yuMTMZZowrcSLvuan/IcUHfl7T6hcauvwRWwuJs0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e848dc01-7d67-4080-ffa9-08d6c7d941e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:48:45.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyBwcm9wZXJ0aWVzIHRvIHNwZWNpZnkgd2lkdGggYW5kIGhlaWdodCBmb3Igd3JpdGVi
YWNrLg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW4gRGF2aXMgPGJlbi5kYXZpc0Bhcm0uY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfdWFwaS5jIHwgIDggKysrKysrKysNCiBkcml2
ZXJzL2dwdS9kcm0vZHJtX3dyaXRlYmFjay5jICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCiBpbmNsdWRlL2RybS9kcm1fY29ubmVjdG9yLmggICAgICAgfCAgNCArKysrDQog
aW5jbHVkZS9kcm0vZHJtX21vZGVfY29uZmlnLmggICAgIHwgMTAgKysrKysrKysrKw0KIDQgZmls
ZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9hdG9taWNfdWFwaS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfdWFwaS5j
DQppbmRleCBkNTIwYTA0Li4wNjRkOTg2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9hdG9taWNfdWFwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY191YXBpLmMN
CkBAIC03NjUsNiArNzY1LDEwIEBAIHN0YXRpYyBpbnQgZHJtX2F0b21pY19jb25uZWN0b3Jfc2V0
X3Byb3BlcnR5KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsDQogCQkJcmV0dXJuIC1F
SU5WQUw7DQogCQl9DQogCQlzdGF0ZS0+Y29udGVudF9wcm90ZWN0aW9uID0gdmFsOw0KKwl9IGVs
c2UgaWYgKHByb3BlcnR5ID09IGNvbmZpZy0+cHJvcF93cml0ZWJhY2tfZGVzdF93KSB7DQorCQlz
dGF0ZS0+d3JpdGViYWNrX2Rlc3RfdyA9IHZhbDsNCisJfSBlbHNlIGlmIChwcm9wZXJ0eSA9PSBj
b25maWctPnByb3Bfd3JpdGViYWNrX2Rlc3RfaCkgew0KKwkJc3RhdGUtPndyaXRlYmFja19kZXN0
X2ggPSB2YWw7DQogCX0gZWxzZSBpZiAocHJvcGVydHkgPT0gY29uZmlnLT53cml0ZWJhY2tfZmJf
aWRfcHJvcGVydHkpIHsNCiAJCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiID0gZHJtX2ZyYW1l
YnVmZmVyX2xvb2t1cChkZXYsIE5VTEwsIHZhbCk7DQogCQlpbnQgcmV0ID0gZHJtX2F0b21pY19z
ZXRfd3JpdGViYWNrX2ZiX2Zvcl9jb25uZWN0b3Ioc3RhdGUsIGZiKTsNCkBAIC04MzcsNiArODQx
LDEwIEBAIGRybV9hdG9taWNfY29ubmVjdG9yX2dldF9wcm9wZXJ0eShzdHJ1Y3QgZHJtX2Nvbm5l
Y3RvciAqY29ubmVjdG9yLA0KIAkJKnZhbCA9IHN0YXRlLT5zY2FsaW5nX21vZGU7DQogCX0gZWxz
ZSBpZiAocHJvcGVydHkgPT0gY29ubmVjdG9yLT5jb250ZW50X3Byb3RlY3Rpb25fcHJvcGVydHkp
IHsNCiAJCSp2YWwgPSBzdGF0ZS0+Y29udGVudF9wcm90ZWN0aW9uOw0KKwl9IGVsc2UgaWYgKHBy
b3BlcnR5ID09IGNvbmZpZy0+cHJvcF93cml0ZWJhY2tfZGVzdF93KSB7DQorCQkqdmFsID0gc3Rh
dGUtPndyaXRlYmFja19kZXN0X3c7DQorCX0gZWxzZSBpZiAocHJvcGVydHkgPT0gY29uZmlnLT5w
cm9wX3dyaXRlYmFja19kZXN0X2gpIHsNCisJCSp2YWwgPSBzdGF0ZS0+d3JpdGViYWNrX2Rlc3Rf
aDsNCiAJfSBlbHNlIGlmIChwcm9wZXJ0eSA9PSBjb25maWctPndyaXRlYmFja19mYl9pZF9wcm9w
ZXJ0eSkgew0KIAkJLyogV3JpdGViYWNrIGZyYW1lYnVmZmVyIGlzIG9uZS1zaG90LCB3cml0ZSBh
bmQgZm9yZ2V0ICovDQogCQkqdmFsID0gMDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX3dyaXRlYmFjay5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV93cml0ZWJhY2suYw0KaW5kZXgg
YzIwZTZmZS4uMmQ3ZWUyMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fd3JpdGVi
YWNrLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fd3JpdGViYWNrLmMNCkBAIC03NCw2ICs3
NCwxNCBAQA0KICAqCWFwcGxpY2F0aW9ucyBtYWtpbmcgdXNlIG9mIHdyaXRlYmFjayBjb25uZWN0
b3JzICphbHdheXMqIHJldHJpZXZlIGFuDQogICoJb3V0LWZlbmNlIGZvciB0aGUgY29tbWl0IGFu
ZCB1c2UgaXQgYXBwcm9wcmlhdGVseS4NCiAgKglGcm9tIHVzZXJzcGFjZSwgdGhpcyBwcm9wZXJ0
eSB3aWxsIGFsd2F5cyByZWFkIGFzIHplcm8uDQorICoNCisgKiAgIldSSVRFQkFDS19ERVNUX1ci
Og0KKyAqCVRoZSB3aWR0aCBvZiB0aGUgY29tcG9zaXRpb24gdG8gd3JpdGUgYmFjay4gMCBhY3Rz
IGFzIGRlZmF1bHQuIElmDQorICoJbm9uLXplcm8gdGhlIGNvbXBvc2l0aW9uIHdpbGwgYmUgc2Nh
bGVkIHRvIG1hdGNoIHRoZSBnaXZlbiB3aWR0aC4NCisgKg0KKyAqICAiV1JJVEVCQUNLX0RFU1Rf
SCI6DQorICoJVGhlIGhlaWdodCBvZiB0aGUgY29tcG9zaXRpb24gdG8gd3JpdGUgYmFjay4gMCBh
Y3RzIGFzIGRlZmF1bHQuIElmDQorICoJbm9uLXplcm8gdGhlIGNvbXBvc2l0aW9uIHdpbGwgYmUg
c2NhbGVkIHRvIG1hdGNoIHRoZSBnaXZlbiBoZWlnaHQuDQogICovDQogDQogI2RlZmluZSBmZW5j
ZV90b193Yl9jb25uZWN0b3IoeCkgY29udGFpbmVyX29mKHgtPmxvY2ssIFwNCkBAIC0xNDEsNiAr
MTQ5LDIyIEBAIHN0YXRpYyBpbnQgY3JlYXRlX3dyaXRlYmFja19wcm9wZXJ0aWVzKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpDQogCQlkZXYtPm1vZGVfY29uZmlnLndyaXRlYmFja19vdXRfZmVuY2Vf
cHRyX3Byb3BlcnR5ID0gcHJvcDsNCiAJfQ0KIA0KKwlpZiAoIWRldi0+bW9kZV9jb25maWcucHJv
cF93cml0ZWJhY2tfZGVzdF93KSB7DQorCQlwcm9wID0gZHJtX3Byb3BlcnR5X2NyZWF0ZV9yYW5n
ZShkZXYsIERSTV9NT0RFX1BST1BfQVRPTUlDLA0KKwkJCQkJCSAiV1JJVEVCQUNLX0RFU1RfVyIs
IDEsIFVJTlRfTUFYKTsNCisJCWlmICghcHJvcCkNCisJCQlyZXR1cm4gLUVOT01FTTsNCisJCWRl
di0+bW9kZV9jb25maWcucHJvcF93cml0ZWJhY2tfZGVzdF93ID0gcHJvcDsNCisJfQ0KKw0KKwlp
ZiAoIWRldi0+bW9kZV9jb25maWcucHJvcF93cml0ZWJhY2tfZGVzdF9oKSB7DQorCQlwcm9wID0g
ZHJtX3Byb3BlcnR5X2NyZWF0ZV9yYW5nZShkZXYsIERSTV9NT0RFX1BST1BfQVRPTUlDLA0KKwkJ
CQkJCSAiV1JJVEVCQUNLX0RFU1RfSCIsIDEsIFVJTlRfTUFYKTsNCisJCWlmICghcHJvcCkNCisJ
CQlyZXR1cm4gLUVOT01FTTsNCisJCWRldi0+bW9kZV9jb25maWcucHJvcF93cml0ZWJhY2tfZGVz
dF9oID0gcHJvcDsNCisJfQ0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAtMjI1LDYgKzI0OSwx
MiBAQCBpbnQgZHJtX3dyaXRlYmFja19jb25uZWN0b3JfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LA0KIAlkcm1fb2JqZWN0X2F0dGFjaF9wcm9wZXJ0eSgmY29ubmVjdG9yLT5iYXNlLA0KIAkJ
CQkgICBjb25maWctPndyaXRlYmFja19waXhlbF9mb3JtYXRzX3Byb3BlcnR5LA0KIAkJCQkgICBi
bG9iLT5iYXNlLmlkKTsNCisNCisJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoJmNvbm5lY3Rv
ci0+YmFzZSwNCisJCQkJICAgY29uZmlnLT5wcm9wX3dyaXRlYmFja19kZXN0X3csIDApOw0KKwlk
cm1fb2JqZWN0X2F0dGFjaF9wcm9wZXJ0eSgmY29ubmVjdG9yLT5iYXNlLA0KKwkJCQkgICBjb25m
aWctPnByb3Bfd3JpdGViYWNrX2Rlc3RfaCwgMCk7DQorDQogCXdiX2Nvbm5lY3Rvci0+cGl4ZWxf
Zm9ybWF0c19ibG9iX3B0ciA9IGJsb2I7DQogDQogCXJldHVybiAwOw0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZHJtL2RybV9jb25uZWN0b3IuaCBiL2luY2x1ZGUvZHJtL2RybV9jb25uZWN0b3IuaA0K
aW5kZXggOGZlMjJhYi4uYzk1Njk2MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9jb25u
ZWN0b3IuaA0KKysrIGIvaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oDQpAQCAtNTE1LDYgKzUx
NSwxMCBAQCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSB7DQogCSAqLw0KIAlzdHJ1Y3QgZHJt
X3dyaXRlYmFja19qb2IgKndyaXRlYmFja19qb2I7DQogDQorCS8qKiBAd3JpdGViYWNrX2Rlc3Rf
dzogd2lkdGggb2YgcGxhbmUgdG8gd3JpdGUgdG8gd2IgYnVmZmVyICovDQorCS8qKiBAd3JpdGVi
YWNrX2Rlc3RfaDogaGVpZ2h0IG9mIHBsYW5lIHRvIHdyaXRlIHRvIHdiIGJ1ZmZlciAqLw0KKwl1
aW50MzJfdCB3cml0ZWJhY2tfZGVzdF93LCB3cml0ZWJhY2tfZGVzdF9oOw0KKw0KIAkvKioNCiAJ
ICogQG1heF9yZXF1ZXN0ZWRfYnBjOiBDb25uZWN0b3IgcHJvcGVydHkgdG8gbGltaXQgdGhlIG1h
eGltdW0gYml0DQogCSAqIGRlcHRoIG9mIHRoZSBwaXhlbHMuDQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9kcm0vZHJtX21vZGVfY29uZmlnLmggYi9pbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaA0K
aW5kZXggN2Y2MGU4ZS4uNWUzMGE1OCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9tb2Rl
X2NvbmZpZy5oDQorKysgYi9pbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaA0KQEAgLTYyMiw2
ICs2MjIsMTYgQEAgc3RydWN0IGRybV9tb2RlX2NvbmZpZyB7DQogCSAqLw0KIAlzdHJ1Y3QgZHJt
X3Byb3BlcnR5ICpwcm9wX2NydGNfaDsNCiAJLyoqDQorCSAqIEBwcm9wX3dyaXRlYmFja19kZXN0
X3c6IFdyaXRlYmFjayBjb25uZWN0b3IgcHJvcGVydHkgZm9yIHRoZSBwbGFuZQ0KKwkgKiBkZXN0
aW5hdGlvbiBwb3NpdGlvbiBpbiB0aGUgd3JpdGViYWNrIGJ1ZmZlci4NCisJICovDQorCXN0cnVj
dCBkcm1fcHJvcGVydHkgKnByb3Bfd3JpdGViYWNrX2Rlc3RfdzsNCisJLyoqDQorCSAqIEBwcm9w
X3dyaXRlYmFja19kZXN0X2g6IFdyaXRlYmFjayBjb25uZWN0b3IgcHJvcGVydHkgZm9yIHRoZSBw
bGFuZQ0KKwkgKiBkZXN0aW5hdGlvbiBwb3NpdGlvbiBpbiB0aGUgd3JpdGViYWNrIGJ1ZmZlci4N
CisJICovDQorCXN0cnVjdCBkcm1fcHJvcGVydHkgKnByb3Bfd3JpdGViYWNrX2Rlc3RfaDsNCisJ
LyoqDQogCSAqIEBwcm9wX2ZiX2lkOiBEZWZhdWx0IGF0b21pYyBwbGFuZSBwcm9wZXJ0eSB0byBz
cGVjaWZ5IHRoZQ0KIAkgKiAmZHJtX2ZyYW1lYnVmZmVyLg0KIAkgKi8NCi0tIA0KMi43LjQNCg0K
