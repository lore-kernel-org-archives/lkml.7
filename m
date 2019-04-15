Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A62C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F48206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gZZ58Sqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDOHJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:09:08 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:6942
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdO1jXCt8pMlZLgiQ1fU6agKEaJh+48odQxyBGK8qYk=;
 b=gZZ58SqjV6u+IvDI/1Gg3kujcj91qIo1qtLp/AB6zttS+FJJky+FtMxQ+XnIcJbW4kOO9gKVWQFpSE7Mo+TBOp7oJsoE+E36i2mdG6DT35Mg+PZJ2mFH9IeIKUglahdd8uNT01f8Xh3R8ZxET17QHIvdphVrEKtkm2ibdOKhHOM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4765.eurprd08.prod.outlook.com (10.255.113.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 07:09:04 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 07:09:04 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 1/6] drm/komeda: Attach scaler to drm as private object
Thread-Topic: [PATCH v1 1/6] drm/komeda: Attach scaler to drm as private
 object
Thread-Index: AQHU81ocfDJ0fbJ8LU2n0DClmIk0YA==
Date:   Mon, 15 Apr 2019 07:09:04 +0000
Message-ID: <20190415070828.24075-2-james.qian.wang@arm.com>
References: <20190415070828.24075-1-james.qian.wang@arm.com>
In-Reply-To: <20190415070828.24075-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6783ece-5f58-42b0-14a0-08d6c1713e59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4765;
x-ms-traffictypediagnostic: VE1PR08MB4765:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB476589810F420551FBFE068BB32B0@VE1PR08MB4765.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(186003)(14454004)(5024004)(446003)(81156014)(486006)(66066001)(8676002)(26005)(5660300002)(6436002)(1076003)(103116003)(6512007)(76176011)(36756003)(476003)(2616005)(7736002)(4326008)(81166006)(11346002)(305945005)(2906002)(25786009)(71200400001)(71190400001)(68736007)(86362001)(2201001)(50226002)(102836004)(110136005)(97736004)(386003)(6506007)(55236004)(54906003)(256004)(8936002)(52116002)(106356001)(105586002)(2501003)(6486002)(53936002)(3846002)(478600001)(99286004)(316002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4765;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zmqcqUWuW0HPKFYjHnoMxyrdiwgGEs7phMEwWszYiRPYYxR7FDKkDjno7wncGpm7kD9AzHyIseYqkmsaJOG0wXUAybLo1V6+FY8/HBJzr5lbjQ1s1A4hBDrebmA54823JJEoa9bGwXW0cTUe6Jz4cEhBjRqtn+jscOrFtJjWIyZyb8QryfdJ+yZoZU3XMkgN8w7SS5iOu0TML9bD8qEAV/tkXlPZ3sm8fnUWiLYpcMlEMXclYTmH84w3kjVzSnU3FKwPUF0ZfiTnURPfLa2K0sRwM1gzVLiZmd1nVJB8x6v4nt6lBFrSlU1TPcxDCBOMi497ZSaCGDNtUsOFCQz4sfrw2HNrHA+hXoUMdSlYFDq1O3mT3DTJO2eAYE7Cqb/oCEx+pKIUpKyiVamNvPMzKkNYV4qZg5uKyBS44sNe1Kg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6783ece-5f58-42b0-14a0-08d6c1713e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 07:09:04.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIHRvIHRoZSBrb21lZGEgcGlwZWxpbmUgY29uZmlndXJhdGlvbiwgYXR0YWNoIHNj
YWxlciB0byBkcm0gYXMNCnByaXZhdGUgb2JqZWN0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBR
aWFuIFdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5hKSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+
DQotLS0NCiAuLi4vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wcml2YXRlX29iai5jICAgfCA0
OSArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRh
X3ByaXZhdGVfb2JqLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVk
YV9wcml2YXRlX29iai5jDQppbmRleCBkNTNiZDZjMjNjNWQuLmJhYzkwYWI4ZmRjOSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3ByaXZhdGVf
b2JqLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3By
aXZhdGVfb2JqLmMNCkBAIC02MCw2ICs2MCw0OSBAQCBzdGF0aWMgaW50IGtvbWVkYV9sYXllcl9v
YmpfYWRkKHN0cnVjdCBrb21lZGFfa21zX2RldiAqa21zLA0KIAlyZXR1cm4gMDsNCiB9DQogDQor
c3RhdGljIHN0cnVjdCBkcm1fcHJpdmF0ZV9zdGF0ZSAqDQora29tZWRhX3NjYWxlcl9hdG9taWNf
ZHVwbGljYXRlX3N0YXRlKHN0cnVjdCBkcm1fcHJpdmF0ZV9vYmogKm9iaikNCit7DQorCXN0cnVj
dCBrb21lZGFfc2NhbGVyX3N0YXRlICpzdDsNCisNCisJc3QgPSBrbWVtZHVwKG9iai0+c3RhdGUs
IHNpemVvZigqc3QpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFzdCkNCisJCXJldHVybiBOVUxMOw0K
Kw0KKwlrb21lZGFfY29tcG9uZW50X3N0YXRlX3Jlc2V0KCZzdC0+YmFzZSk7DQorCV9fZHJtX2F0
b21pY19oZWxwZXJfcHJpdmF0ZV9vYmpfZHVwbGljYXRlX3N0YXRlKG9iaiwgJnN0LT5iYXNlLm9i
aik7DQorDQorCXJldHVybiAmc3QtPmJhc2Uub2JqOw0KK30NCisNCitzdGF0aWMgdm9pZA0KK2tv
bWVkYV9zY2FsZXJfYXRvbWljX2Rlc3Ryb3lfc3RhdGUoc3RydWN0IGRybV9wcml2YXRlX29iaiAq
b2JqLA0KKwkJCQkgICBzdHJ1Y3QgZHJtX3ByaXZhdGVfc3RhdGUgKnN0YXRlKQ0KK3sNCisJa2Zy
ZWUodG9fc2NhbGVyX3N0KHByaXZfdG9fY29tcF9zdChzdGF0ZSkpKTsNCit9DQorDQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBkcm1fcHJpdmF0ZV9zdGF0ZV9mdW5jcyBrb21lZGFfc2NhbGVyX29ial9m
dW5jcyA9IHsNCisJLmF0b21pY19kdXBsaWNhdGVfc3RhdGUJPSBrb21lZGFfc2NhbGVyX2F0b21p
Y19kdXBsaWNhdGVfc3RhdGUsDQorCS5hdG9taWNfZGVzdHJveV9zdGF0ZQk9IGtvbWVkYV9zY2Fs
ZXJfYXRvbWljX2Rlc3Ryb3lfc3RhdGUsDQorfTsNCisNCitzdGF0aWMgaW50IGtvbWVkYV9zY2Fs
ZXJfb2JqX2FkZChzdHJ1Y3Qga29tZWRhX2ttc19kZXYgKmttcywNCisJCQkJIHN0cnVjdCBrb21l
ZGFfc2NhbGVyICpzY2FsZXIpDQorew0KKwlzdHJ1Y3Qga29tZWRhX3NjYWxlcl9zdGF0ZSAqc3Q7
DQorDQorCXN0ID0ga3phbGxvYyhzaXplb2YoKnN0KSwgR0ZQX0tFUk5FTCk7DQorCWlmICghc3Qp
DQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJc3QtPmJhc2UuY29tcG9uZW50ID0gJnNjYWxlci0+
YmFzZTsNCisJZHJtX2F0b21pY19wcml2YXRlX29ial9pbml0KCZrbXMtPmJhc2UsDQorCQkJCSAg
ICAmc2NhbGVyLT5iYXNlLm9iaiwgJnN0LT5iYXNlLm9iaiwNCisJCQkJICAgICZrb21lZGFfc2Nh
bGVyX29ial9mdW5jcyk7DQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgc3RydWN0IGRybV9w
cml2YXRlX3N0YXRlICoNCiBrb21lZGFfY29tcGl6X2F0b21pY19kdXBsaWNhdGVfc3RhdGUoc3Ry
dWN0IGRybV9wcml2YXRlX29iaiAqb2JqKQ0KIHsNCkBAIC0yNTgsNiArMzAxLDEyIEBAIGludCBr
b21lZGFfa21zX2FkZF9wcml2YXRlX29ianMoc3RydWN0IGtvbWVkYV9rbXNfZGV2ICprbXMsDQog
CQkJCXJldHVybiBlcnI7DQogCQl9DQogDQorCQlmb3IgKGogPSAwOyBqIDwgcGlwZS0+bl9zY2Fs
ZXJzOyBqKyspIHsNCisJCQllcnIgPSBrb21lZGFfc2NhbGVyX29ial9hZGQoa21zLCBwaXBlLT5z
Y2FsZXJzW2pdKTsNCisJCQlpZiAoZXJyKQ0KKwkJCQlyZXR1cm4gZXJyOw0KKwkJfQ0KKw0KIAkJ
ZXJyID0ga29tZWRhX2NvbXBpel9vYmpfYWRkKGttcywgcGlwZS0+Y29tcGl6KTsNCiAJCWlmIChl
cnIpDQogCQkJcmV0dXJuIGVycjsNCi0tIA0KMi4xNy4xDQoNCg==
