Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBA320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="xlwqQael"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfFGKrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:47:03 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:31989
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbfFGKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vwSFftsmnqIyChyg7ecvR/7CX3UXEeeSf5QwBkSCJg=;
 b=xlwqQael+zlaM1aysWjIY33KMUcg9MPfdVbiTtZrugIpUu9cBxL3JrzRybnkgLvmYg8CSKeZtriROKY1ZZxT9odPAb6v7pBx/4XrwbqDqGTH5LH3ks3xr5Lqv2nPU2ExKCJMYP8tkYZn9PLViuVQtr4GQiAU3x4kv9chNy4w3Ks=
Received: from AM0PR08MB4226.eurprd08.prod.outlook.com (20.179.36.17) by
 AM0PR08MB3748.eurprd08.prod.outlook.com (20.178.21.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 10:46:46 +0000
Received: from AM0PR08MB4226.eurprd08.prod.outlook.com
 ([fe80::bc0c:5148:629e:1a31]) by AM0PR08MB4226.eurprd08.prod.outlook.com
 ([fe80::bc0c:5148:629e:1a31%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 10:46:46 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Avoid using DRIVER_IRQ_SHARED
Thread-Topic: [PATCH] drm/komeda: Avoid using DRIVER_IRQ_SHARED
Thread-Index: AQHVHR5MdDQKN6RFT0aBT7A4OfORUg==
Date:   Fri, 7 Jun 2019 10:46:45 +0000
Message-ID: <20190607104629.28791-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To AM0PR08MB4226.eurprd08.prod.outlook.com
 (2603:10a6:208:147::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [217.140.106.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48e9b71b-2e03-41ca-ab9c-08d6eb356ee4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3748;
x-ms-traffictypediagnostic: AM0PR08MB3748:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB37487644A2280DAA8DD6DD91E4100@AM0PR08MB3748.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(376002)(39850400004)(199004)(189003)(81156014)(81166006)(8676002)(6512007)(4326008)(53936002)(36756003)(25786009)(8936002)(5660300002)(72206003)(6436002)(14454004)(102836004)(186003)(6486002)(26005)(2201001)(256004)(86362001)(5024004)(305945005)(7736002)(6506007)(14444005)(66066001)(386003)(66556008)(64756008)(66946007)(73956011)(66476007)(66446008)(68736007)(2906002)(44832011)(6116002)(2501003)(3846002)(316002)(486006)(110136005)(478600001)(2616005)(1076003)(476003)(71200400001)(71190400001)(50226002)(52116002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3748;H:AM0PR08MB4226.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UeVtXO5LsWjONiGucui/Lrkn/ByL12sHOWmfCNvG7UUVk2lSzJ+fb5PFExC4S+O8XQhh9akjjKnR/uc4S0fPItcyvPoEZ1wr0e3Sc7TJq2K9ttOV+oFALXJrSFt1uFE5E2sUDVi+FfNu9c4NYaKjeVcwkue6TqoR9U3Rw+tlwSwHCdunlmX8IlYnBkJKCifNabxvWOQ+sz0ZDEBk5h27EUf8PQ9hVXJzvTFaaRGrUYImeqvu/noEYxL5MHRkapcgpMrXeYKkUB6B0l75T6kFOGu79MAIWKY9avzBuUcJWKrg3Czu5BvajIW72luUyE/EnOG6JLFXn6CJA5F7bDvnpnJONDv5XP0QJ+biP7fXrR7gMwO6fJM3GLAKkGBPll/xDiCIaR4kFPkUVJueDQkL6HF5ZjfWCA5bPHGt4fhyk1E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e9b71b-2e03-41ca-ab9c-08d6eb356ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 10:46:45.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ayan.Halder@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCByZWZlcmVuY2UgdG8gbWFpbmxpbmUgY29tbWl0ICgxZmY0OTQ4MTNiYWZhMTI3ZWNiYTEx
NjAyNjJiYTM5YjJmZGRlN2JhKSwNCkRSSVZFUl9JUlFfU0hBUkVEIGlzIHRvIGJlIHVzZWQgb25s
eSBieSBsZWdhY3kgZHJpdmVycy4gRnVydGhlciwNCmRybV9pcnFfaW5zdGFsbCgpIGlnbm9yZXMg
dGhpcyBmbGFnIGFsdG9nZXRoZXIuDQpPbmUgbmVlZHMgdG8gdXNlIGRldm1fcmVxdWVzdF9pcnEo
KSBpbnN0ZWFkLCB3aXRoIElSUUZfU0hBUkVEIHRvIGNyZWF0ZSBhIHNoYXJlZA0KaW50ZXJydXB0
IGhhbmRsZXIuDQoNClNpZ25lZC1vZmYtYnk6IEF5YW4gS3VtYXIgaGFsZGVyIDxheWFuLmhhbGRl
ckBhcm0uY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfa21zLmMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29t
ZWRhL2tvbWVkYV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29t
ZWRhX2ttcy5jDQppbmRleCA4NmY2NTQyYWZiNDAuLjdiNWNkZTE0ZTNiYSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2ttcy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9rbXMuYw0KQEAgLTE5NCw3
ICsxOTQsOSBAQCBzdHJ1Y3Qga29tZWRhX2ttc19kZXYgKmtvbWVkYV9rbXNfYXR0YWNoKHN0cnVj
dCBrb21lZGFfZGV2ICptZGV2KQ0KIA0KIAlkcm1fbW9kZV9jb25maWdfcmVzZXQoZHJtKTsNCiAN
Ci0JZXJyID0gZHJtX2lycV9pbnN0YWxsKGRybSwgbWRldi0+aXJxKTsNCisJZXJyID0gZGV2bV9y
ZXF1ZXN0X2lycShkcm0tPmRldiwgbWRldi0+aXJxLA0KKwkJCSAgICAgICBrb21lZGFfa21zX2Ry
aXZlci5pcnFfaGFuZGxlciwgSVJRRl9TSEFSRUQsDQorCQkJICAgICAgIGRybS0+ZHJpdmVyLT5u
YW1lLCBkcm0pOw0KIAlpZiAoZXJyKQ0KIAkJZ290byBjbGVhbnVwX21vZGVfY29uZmlnOw0KIA0K
LS0gDQoyLjIxLjANCg0K
