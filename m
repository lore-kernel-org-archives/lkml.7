Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7BB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qidB+d8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfDWKs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:48:29 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:36062
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfDWKs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP2vdu6YlagTAUm7FGpkkzvhgilN3AOFNdXf9aQmiwg=;
 b=qidB+d8uczpAQYfOyB+CXEAn9IIUf8XMzOwgljpn1giY6DUoHUvhmJXgjXpZVvuugOrqZn6ZhuX7DMwgGfUTuX+Lg4FXzRgJ9Wmnrif15TULTnpzQR0HvhXc8OtBAlqcv8SdoAL2GPLOON7k7iZnpMsUiy5Z8nVIuIQ5OmhQl7k=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1870.eurprd08.prod.outlook.com (10.173.73.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:48:24 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4%7]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:48:24 +0000
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
Subject: [PATCH v3 0/2] Add writeback scaling
Thread-Topic: [PATCH v3 0/2] Add writeback scaling
Thread-Index: AQHU+cITynPvsx5E+k6y7jgRbuGrFg==
Date:   Tue, 23 Apr 2019 10:48:24 +0000
Message-ID: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
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
x-ms-office365-filtering-correlation-id: 2800f25b-508b-45a7-aed5-08d6c7d935c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0801MB1870;
x-ms-traffictypediagnostic: VI1PR0801MB1870:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1870B1E5E6BC53A0668421FDE5230@VI1PR0801MB1870.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(54906003)(386003)(6506007)(53936002)(71200400001)(71190400001)(6512007)(2906002)(6116002)(3846002)(5640700003)(305945005)(7736002)(66556008)(64756008)(66476007)(66946007)(316002)(6436002)(73956011)(6916009)(36756003)(6486002)(2351001)(66446008)(86362001)(256004)(14454004)(8936002)(97736004)(52116002)(186003)(44832011)(478600001)(102836004)(99286004)(81166006)(81156014)(8676002)(72206003)(26005)(68736007)(66066001)(2501003)(14444005)(486006)(4326008)(476003)(5660300002)(2616005)(25786009)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1870;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M3SxFqwAK6kcIckMTIZQp8YbMCQOOvk/+gvE9BNaGDCnW6+nvqP3nX1PwqaQAzYAghxlqBchiM4ZigbKDV3P4SbliL5ohos+0Chqo8PJp8yE24W7AAFYoRtGQowaUNrHW69Ieh2VsuDcy9ydMxIb1hhb0Dq459G7fuZyI4L9M18RbH9mNr/0shqAEs4b0/htV4OBrKxAzQK2RuD/64prSY5BoFkdrApF/jVC8bGpFXUaeQXOebUjU/2viTVv5NfZvOtsff6uMVHApl+z5WV5DukZ8tL0g1SXrwW666CP9V/qbAhuWHVKjGBTZEHzkX9BO3eQyld10AC05xrIm7YSjaq5Tx+qnEjuo77enTeVY0FzbNaD1tz+O1MJUNcBdFKbXtpjwm3KBGDE62QGmk/4RAoV3fouWkSpm++zNV/nkBk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2800f25b-508b-45a7-aed5-08d6c7d935c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:48:24.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIHNjYWxpbmcgb24gd3JpdGViYWNrLiBUbyBkbyB0aGlzIGFkZCB3cml0
ZWJhY2tfZGVzdF93DQphbmQgd3JpdGViYWNrX2Rlc3RfaCBhcyB3cml0ZWJhY2sgY29ubmVjdG9y
IHByb3BlcnRpZXMgdG8gc3BlY2lmeSB0aGUNCmRlc2lyZWQgb3V0cHV0IGRpbWVuc2lvbnMuDQpU
aGVuIGltcGxlbWVudCBkb3duc2NhbGluZyBvbiB3cml0ZWJhY2sgZm9yIE1hbGlkcC01NTAgYW5k
IE1hbGlkcC02NTANCih1cHNjYWxpbmcgb24gd3JpdGViYWNrIGlzIG5vdCBzdXBwb3J0ZWQgb24g
dGhlc2UgZGV2aWNlcykuDQoNCnYyOiBVc2UgMCBhcyBkZWZhdWx0IGZvciB3cml0ZWJhY2tfdyxo
IGFuZCBzbyB1cGRhdGUgcmFuZ2UgdG8gdXNlIDEgYXMNCiAgICBtaW5pbXVtLg0KDQp2MzogUmVu
YW1lIHByb3BlcnRpZXMgdG8gc3BlY2lmeSB0aGV5IGFyZSBkZXN0aW5hdGlvbiB3aWR0aC9oZWln
aHQuDQogICAgTWFrZSBzdXJlIHRoZSB2YWx1ZXMgZnJvbSB0aGUgcHJvcGVydGllcyBhcmUgcGFz
c2VkIHRvDQogICAgZW5hYmxlX21lbXdyaXRlIHJhdGhlciB0aGFuIHRoZSBmcmFtZWJ1ZmZlciBk
aW1lbnNpb25zDQoNCkJlbiBEYXZpcyAoMik6DQogIGRybTogQWRkIHdyaXRlYmFja19kZXN0X3cs
aCBwcm9wZXJ0aWVzDQogIGRybS9tYWxpZHA6IEVuYWJsZSB3cml0ZWJhY2sgc2NhbGluZw0KDQog
ZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfY3J0Yy5jIHwgNDkgKysrKysrKysrKystLS0tLS0t
LS0NCiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmggfCAxMiArKysrKw0KIGRyaXZl
cnMvZ3B1L2RybS9hcm0vbWFsaWRwX2Rydi5jICB8IDEwICsrKy0tDQogZHJpdmVycy9ncHUvZHJt
L2FybS9tYWxpZHBfaHcuYyAgIHwgNDUgKysrKysrKysrKysrKy0tLS0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hcm0vbWFsaWRwX2h3LmggICB8IDE5ICsrKysrKy0tDQogZHJpdmVycy9ncHUvZHJtL2Fy
bS9tYWxpZHBfbXcuYyAgIHwgOTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfcmVncy5oIHwgIDEgKw0KIGRyaXZlcnMv
Z3B1L2RybS9kcm1fYXRvbWljX3VhcGkuYyB8ICA4ICsrKysNCiBkcml2ZXJzL2dwdS9kcm0vZHJt
X3dyaXRlYmFjay5jICAgfCAzMCArKysrKysrKysrKysrDQogaW5jbHVkZS9kcm0vZHJtX2Nvbm5l
Y3Rvci5oICAgICAgIHwgIDQgKysNCiBpbmNsdWRlL2RybS9kcm1fbW9kZV9jb25maWcuaCAgICAg
fCAxMCArKysrKw0KIDExIGZpbGVzIGNoYW5nZWQsIDIyMCBpbnNlcnRpb25zKCspLCA2MiBkZWxl
dGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBf
Y3J0Yy5oDQoNCi0tIA0KMi43LjQNCg0K
