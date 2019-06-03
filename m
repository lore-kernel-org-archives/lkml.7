Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DEFC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5127C02
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZV8pK5q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFCGb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:31:59 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:46215
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbfFCGb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9tozB7RgQ21imy9KivQaH+Savx9XekgE6jkQuEEJGk=;
 b=ZV8pK5q8Yairm7Oi9Nuek8pU4cUrji/dWCsyCF08u2pdlip326NwqJ0fUHlo/X96XA1auFXVAHw8v/Jb5tdvX0TJgiidPQJQeL5LAjStsidQWtAKpNoDgKiSRPivotzmu5ZkDEBHwyWaxCzaFB3fsoV94hWVe8NJ3DfprRspmP0=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB4605.eurprd08.prod.outlook.com (20.178.13.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 06:31:54 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::ada6:12ed:65d0:4629]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::ada6:12ed:65d0:4629%4]) with mapi id 15.20.1922.025; Mon, 3 Jun 2019
 06:31:54 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH v1 2/2] drm/komeda: Adds komeda_kms_drop_master
Thread-Topic: [PATCH v1 2/2] drm/komeda: Adds komeda_kms_drop_master
Thread-Index: AQHVGdYIJROjMKA2IkGllIHYR3H/0A==
Date:   Mon, 3 Jun 2019 06:31:54 +0000
Message-ID: <1559543462-32264-3-git-send-email-lowry.li@arm.com>
References: <1559543462-32264-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1559543462-32264-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce025073-05f2-4da8-7caa-08d6e7ed2b28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB4605;
x-ms-traffictypediagnostic: VI1PR08MB4605:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB4605B0EDFDD1DA465F3431399F140@VI1PR08MB4605.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:67;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(102836004)(6512007)(36756003)(110136005)(26005)(54906003)(486006)(256004)(386003)(186003)(14444005)(6506007)(99286004)(446003)(11346002)(55236004)(52116002)(66446008)(66476007)(53936002)(66946007)(64756008)(68736007)(4326008)(6636002)(2616005)(476003)(76176011)(73956011)(66556008)(86362001)(72206003)(14454004)(478600001)(25786009)(6486002)(5660300002)(50226002)(2906002)(8936002)(316002)(2501003)(81156014)(81166006)(66066001)(8676002)(7736002)(6436002)(6116002)(71200400001)(71190400001)(3846002)(305945005)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4605;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O714nvBvVGfxVKj9xGJOtSM24yBtik+2Dv0SxCPWFlLEV8XwAmk1fFNz13evzm7z6D+B95OvEKDsC2BQC4TbFfjOzbbyUMGvjxw5bWg7n0JjmMXMAZERYzd2tgnKGniNt+SU6K3bN2aFDUoMcGAn2iiUg9hrQdFwuOxPEvbs2PDw9+PwjPnnSQtVk2KEQoiC0HIF+JLVM1Yt2aRxmfTB9Dm3qkX9HvOWFnPUIq1202zQMexba7hhQVSd6tIREVifSr/Idb9n5m3ljUY4dGkOK7QXHBemZ537rVcEW3Ff6ldcxph9yQPbWNRWnucFzq9hut0qRArwzddfIdMZH7so/q2XcYTeT6Ch2kTIRb0OPIytgRHbQMmmQaeuzGn6+TR3kNKmYuRZsNdGwJ7KGWJurhTn9TkbXhhkVEvCghYTA80=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce025073-05f2-4da8-7caa-08d6e7ed2b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 06:31:54.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lowry.Li@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGtvbWVkYSBpbnRlcm5hbCByZXNvdXJjZXMgKHBpcGVsaW5lcykgYXJlIHNoYXJlZCBiZXR3
ZWVuIGNydGNzLA0KYW5kIHJlc291cmNlcyByZWxlYXNlIGJ5IGRpc2FibGVfY3J0Yy4gVGhpcyBj
b21taXQgaXMgd29ya2luZyBmb3Igb25jZQ0KdXNlciBmb3Jnb3QgZGlzYWJsaW5nIGNydGMgbGlr
ZSBhcHAgcXVpdCBhYm5vbWFsbHksIGFuZCB0aGVuIHRoZQ0KcmVzb3VyY2VzIGNhbiBub3QgYmUg
dXNlZCBieSBhbm90aGVyIGNydGMuIEFkZHMgZHJvcF9tYXN0ZXIgdG8NCnNodXRkb3duIHRoZSBk
ZXZpY2UgYW5kIG1ha2Ugc3VyZSBhbGwgdGhlIGtvbWVkYSByZXNvdXJjZXMgaGF2ZSBiZWVuDQpy
ZWxlYXNlZCBhbmQgY2FuIGJlIHVzZWQgZm9yIHRoZSBuZXh0IHVzYWdlLg0KDQpTaWduZWQtb2Zm
LWJ5OiBMb3dyeSBMaSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxsb3dyeS5saUBhcm0uY29tPg0K
LS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfa21zLmMgfCAx
MyArKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2ttcy5j
IGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfa21zLmMNCmluZGV4
IDg1NDM4NjAuLjY0N2JjZTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3Bs
YXkva29tZWRhL2tvbWVkYV9rbXMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5
L2tvbWVkYS9rb21lZGFfa21zLmMNCkBAIC01NCwxMSArNTQsMjQgQEAgc3RhdGljIGlycXJldHVy
bl90IGtvbWVkYV9rbXNfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkNCiAJcmV0dXJu
IHN0YXR1czsNCiB9DQogDQorLyogS29tZWRhIGludGVybmFsIHJlc291cmNlcyAocGlwZWxpbmVz
KSBhcmUgc2hhcmVkIGJldHdlZW4gY3J0Y3MsIGFuZCByZXNvdXJjZXMNCisgKiBhcmUgcmVsZWFz
ZWQgYnkgZGlzYWJsZV9jcnRjLiBCdXQgaWYgdXNlciBmb3JnZXQgZGlzYWJsaW5nIGNydGMgbGlr
ZSBhcHAgcXVpdA0KKyAqIGFibm9ybWFsbHksIHRoZSByZXNvdXJjZXMgY2FuIG5vdCBiZSB1c2Vk
IGJ5IGFub3RoZXIgY3J0Yy4NCisgKiBVc2UgZHJvcF9tYXN0ZXIgdG8gc2h1dGRvd24gdGhlIGRl
dmljZSBhbmQgbWFrZSBzdXJlIGFsbCB0aGUga29tZWRhIHJlc291cmNlcw0KKyAqIGhhdmUgYmVl
biByZWxlYXNlZCwgYW5kIGNhbiBiZSB1c2VkIGZvciB0aGUgbmV4dCB1c2FnZS4NCisgKi8NCitz
dGF0aWMgdm9pZCBrb21lZGFfa21zX2Ryb3BfbWFzdGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
DQorCQkJCSAgIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2KQ0KK3sNCisJZHJtX2F0b21pY19o
ZWxwZXJfc2h1dGRvd24oZGV2KTsNCit9DQorDQogc3RhdGljIHN0cnVjdCBkcm1fZHJpdmVyIGtv
bWVkYV9rbXNfZHJpdmVyID0gew0KIAkuZHJpdmVyX2ZlYXR1cmVzID0gRFJJVkVSX0dFTSB8IERS
SVZFUl9NT0RFU0VUIHwgRFJJVkVSX0FUT01JQyB8DQogCQkJICAgRFJJVkVSX1BSSU1FIHwgRFJJ
VkVSX0hBVkVfSVJRLA0KIAkubGFzdGNsb3NlCQkJPSBkcm1fZmJfaGVscGVyX2xhc3RjbG9zZSwN
CiAJLmlycV9oYW5kbGVyCQkJPSBrb21lZGFfa21zX2lycV9oYW5kbGVyLA0KKwkubWFzdGVyX2Ry
b3AJCQk9IGtvbWVkYV9rbXNfZHJvcF9tYXN0ZXIsDQogCS5nZW1fZnJlZV9vYmplY3RfdW5sb2Nr
ZWQJPSBkcm1fZ2VtX2NtYV9mcmVlX29iamVjdCwNCiAJLmdlbV92bV9vcHMJCQk9ICZkcm1fZ2Vt
X2NtYV92bV9vcHMsDQogCS5kdW1iX2NyZWF0ZQkJCT0ga29tZWRhX2dlbV9jbWFfZHVtYl9jcmVh
dGUsDQotLSANCjEuOS4xDQoNCg==
