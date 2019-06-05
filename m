Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7783C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73ED20693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="EQGFkbIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfFEOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:41:57 -0400
Received: from mail-eopbgr20130.outbound.protection.outlook.com ([40.107.2.130]:40999
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbfFEOls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42X/GG4FYH0ApYKxAAjbvAPBsi1tRbZ5n+brgM53Gcg=;
 b=EQGFkbISrcJXsLtMFT7ZKD50rZWIm6eDgSNVKMr4bseyOuSfI3+Z/dbFNtSg5XSJ88fDAycIu648ruj3AymvQ8CrF+O0WbGCGXIpg/+IZ3WQSan2EI7icEWeGa+MFAqav1LVRef4rmTkS5F3yf5SStt5JRXvLtTUxFlBEFCup8U=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB4383.eurprd07.prod.outlook.com (20.176.7.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.9; Wed, 5 Jun 2019 14:41:45 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 14:41:45 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 2/2] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW,
 ...)
Thread-Topic: [PATCH v3 2/2] x86/vdso: implement
 clock_gettime(CLOCK_MONOTONIC_RAW, ...)
Thread-Index: AQHVG6zMH/5w102jYEqnDdPLYs62ug==
Date:   Wed, 5 Jun 2019 14:41:45 +0000
Message-ID: <20190605144116.28553-3-alexander.sverdlin@nokia.com>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ba36a13-66e6-41bf-8281-08d6e9c3eea2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4383;
x-ms-traffictypediagnostic: VI1PR07MB4383:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR07MB43834E69310319B3608E1FAF88160@VI1PR07MB4383.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(110136005)(76176011)(66556008)(476003)(3846002)(6116002)(52116002)(53936002)(102836004)(11346002)(99286004)(4326008)(68736007)(6506007)(66476007)(316002)(64756008)(66446008)(2501003)(73956011)(305945005)(386003)(5660300002)(186003)(26005)(1076003)(7736002)(25786009)(2616005)(14454004)(54906003)(486006)(66946007)(50226002)(86362001)(6436002)(71190400001)(71200400001)(36756003)(966005)(6306002)(81166006)(2906002)(6486002)(81156014)(14444005)(256004)(8936002)(6512007)(508600001)(66066001)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4383;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TPWtjGeaeF0xzOp75OAteiAON9Epz7t0Rnbm5Zc4/HQGUo2jOZyNPXTZewWrrGt7+7/B58H6T9vnOn5OFHDHhl1k8zuRxCV1kAil+hIirBA7Sub9UAPJ3BTRrU+Krvt44KAXhn95wueuUv7E0d9+YQe8R4q35ktDUgb30bPQWyzZZh+mFqgYq1UN36YoDMIKmjPGXEW4Y6Iq6OFbw+5m2UYyp/wxgjG9UkvugMXMKzGe5IFq0DDNG4ILpuiS80D5lECtKJJz3t2M61wHLHBgcxpDjG0ahMWZWpzCs7psCw8FEYq7TQ/+O6KT/OQtfR4XM18P4NJ9/0yl06CL3pZ/f+IacfprSmGABiiv7N4otTZjMgdnutZl4yIvnSxgWK73zuuhZMovOegx+eZ89p4JzOuXnKL06FVaCLbdCA3ZKzU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba36a13-66e6-41bf-8281-08d6e9c3eea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 14:41:45.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0K
DQpBZGQgQ0xPQ0tfTU9OT1RPTklDX1JBVyB0byB0aGUgZXhpc3RpbmcgY2xvY2tfZ2V0dGltZSgp
IHZEU08NCmltcGxlbWVudGF0aW9uLiBUaGlzIGlzIGJhc2VkIG9uIHRoZSBpZGVhcyBvZiBKYXNv
biBWYXMgRGlhcyBhbmQgY29tbWVudHMNCm9mIFRob21hcyBHbGVpeG5lci4NCg0KVGVzdCBwcm9n
cmFtIGZyb20gdGhlIHByZXZpb3VzIHBhdGNoIHNob3dzIHRoZSBmb2xsb3dpbmcgaW1wcm92ZW1l
bnQ6DQoNCkNsb2NrICAgICAgICAgICAgICAgICAgIEJlZm9yZSAgQWZ0ZXIgICBEaWZmDQotLS0t
LSAgICAgICAgICAgICAgICAgICAtLS0tLS0gIC0tLS0tICAgLS0tLQ0KQ0xPQ0tfTU9OT1RPTklD
X1JBVyAgICAgNDQuOU0gICAzNTkuNk0gICs3MDAlDQoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3BhdGNod29yay9wYXRjaC85MzM1ODMvDQpMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtl
cm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5ODk2MQ0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KQ2M6IEphc29uIFZhcyBEaWFzIDxqYXNvbi52YXMuZGlhc0BnbWFp
bC5jb20+DQpDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQpTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5jb20+DQot
LS0NCiBhcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9ndG9kLmMgfCA2ICsrKysrKw0K
IGFyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmggICAgICAgICAgICB8IDMgKystDQogMiBmaWxl
cyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYyBiL2FyY2gveDg2L2VudHJ5
L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYw0KaW5kZXggNjRiMWU3Yy4uNDAyYzNiMyAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYw0KKysrIGIvYXJj
aC94ODYvZW50cnkvdnN5c2NhbGwvdnN5c2NhbGxfZ3RvZC5jDQpAQCAtNjksNiArNjksMTIgQEAg
dm9pZCB1cGRhdGVfdnN5c2NhbGwoc3RydWN0IHRpbWVrZWVwZXIgKnRrKQ0KIAliYXNlLT5tdWx0
ID0gdGstPnRrcl9tb25vLm11bHQ7DQogCWJhc2UtPnNoaWZ0ID0gdGstPnRrcl9tb25vLnNoaWZ0
Ow0KIA0KKwliYXNlID0gJnZkYXRhLT5iYXNldGltZVtDTE9DS19NT05PVE9OSUNfUkFXXTsNCisJ
YmFzZS0+c2VjID0gdGstPnJhd19zZWM7DQorCWJhc2UtPm5zZWMgPSB0ay0+dGtyX3Jhdy54dGlt
ZV9uc2VjOw0KKwliYXNlLT5tdWx0ID0gdGstPnRrcl9yYXcubXVsdDsNCisJYmFzZS0+c2hpZnQg
PSB0ay0+dGtyX3Jhdy5zaGlmdDsNCisNCiAJYmFzZSA9ICZ2ZGF0YS0+YmFzZXRpbWVbQ0xPQ0tf
UkVBTFRJTUVfQ09BUlNFXTsNCiAJYmFzZS0+c2VjID0gdGstPnh0aW1lX3NlYzsNCiAJYmFzZS0+
bnNlYyA9IHRrLT50a3JfbW9uby54dGltZV9uc2VjID4+IHRrLT50a3JfbW9uby5zaGlmdDsNCmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3RvZC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vdmd0b2QuaA0KaW5kZXggYjFmNmRmMy4uMWZiNzA0OCAxMDA2NDQNCi0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9k
LmgNCkBAIC0zMCw3ICszMCw4IEBAIHN0cnVjdCB2Z3RvZF90cyB7DQogfTsNCiANCiAjZGVmaW5l
IFZHVE9EX0JBU0VTCShDTE9DS19UQUkgKyAxKQ0KLSNkZWZpbmUgVkdUT0RfSFJFUwkoQklUKENM
T0NLX1JFQUxUSU1FKSB8IEJJVChDTE9DS19NT05PVE9OSUMpIHwgQklUKENMT0NLX1RBSSkpDQor
I2RlZmluZSBWR1RPRF9IUkVTCShCSVQoQ0xPQ0tfUkVBTFRJTUUpIHwgQklUKENMT0NLX01PTk9U
T05JQykgfCBcDQorCQkJIEJJVChDTE9DS19NT05PVE9OSUNfUkFXKSB8IEJJVChDTE9DS19UQUkp
KQ0KICNkZWZpbmUgVkdUT0RfQ09BUlNFCShCSVQoQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFKSB8IEJJ
VChDTE9DS19NT05PVE9OSUNfQ09BUlNFKSkNCiANCiAvKg0KLS0gDQoyLjQuNg0KDQo=
