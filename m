Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208D1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38AF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NCSKFiNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:37:18 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:51427
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfDKIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEixj299WRidBZgsJUoh/YW7uGGHLQPcR4mRUy3cCNg=;
 b=NCSKFiNB/+Qpmm1MK+1N3PZ8yr2jKfR7nwDsIE9m2zo7bAtE9CbimPx0DQYVFes7ULCLrl9KiV8s9Hj8KVqIgUqhBwwsrQz+WnjnpiL/5cHZovT6JPaM8UhqT9/tMgw32ZirFzbWJAqwcTFUpk2BAn/nzb2+S7G0n9D1dQNRrco=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB4618.eurprd08.prod.outlook.com (20.178.85.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Thu, 11 Apr 2019 08:37:13 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 08:37:13 +0000
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
Subject: [PATCH v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Topic: [PATCH v2] drm/komeda: fixing of DMA mapping sg segment warning
Thread-Index: AQHU8EHC/9vJCCcYc0eF1Oqu3HFhoA==
Date:   Thu, 11 Apr 2019 08:37:13 +0000
Message-ID: <1554971813-22049-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::31) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b512d693-7b4a-4abb-41d9-08d6be58e4c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB4618;
x-ms-traffictypediagnostic: DB7PR08MB4618:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB4618E5DCC6ECA966E75244579F2F0@DB7PR08MB4618.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(86362001)(50226002)(68736007)(5660300002)(71190400001)(26005)(25786009)(476003)(2616005)(256004)(4326008)(36756003)(6636002)(71200400001)(7736002)(2906002)(486006)(186003)(54906003)(97736004)(110136005)(305945005)(14444005)(2201001)(478600001)(99286004)(53936002)(316002)(14454004)(66066001)(72206003)(386003)(6436002)(966005)(6506007)(55236004)(52116002)(2501003)(102836004)(8936002)(6306002)(106356001)(81156014)(105586002)(6486002)(6512007)(8676002)(6116002)(3846002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB4618;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WFhJa+6M8cJmdcLXrMbbKEgaCrSsotrlBB083wSg6p1uHGpDkfkuz46DHGivtauVEqnhx5Np0RNE00dOc2iO0kS7pCPQ3p1u0c+s5D8JNZDWfHk41lKo5xaQjFLln/ik/LYyRn8zgLHhatDz+2vKvDD4F/FVl4n038QjGPWbY7/r/Zbu5HOdCw7A99TjfGV91RHciLPnkltrqyjR9TEZIcEIpmRafgxmCIVUkicc6deCihbNV8W4ra1awR4tirov4WIDIu1zsv7dI8ivk6YzLJxVnjKNd9vTLo9MwZGvlFZSG92umX9PJwF70GZxskPY+qNwKdZp1VwKWjfD+ZEBlADN/FIZs6EC9M+nESic73laByYaiI4dkb0OpswFUbz+uPflZRcZHeoQuGw1yM+She+0HbXl5Hw6naPf9LLWfGs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b512d693-7b4a-4abb-41d9-08d6be58e4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 08:37:13.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4aW5nIHRoZSBETUEgbWFwcGluZyBzZyBzZWdtZW50IHdhcm5pbmcsIHdoaWNoIHNob3dzICJE
TUEtQVBJOiBtYXBwaW5nDQpzZyBzZWdtZW50IGxvbmdlciB0aGFuIGRldmljZSBjbGFpbXMgdG8g
c3VwcG9ydCBbbGVuPTkyMTYwMF0gW21heD02NTUzNl0iLg0KRml4ZWQgYnkgc2V0dGluZyB0aGUg
bWF4IHNlZ21lbnQgc2l6ZSBhdCBLb21lZGEgZHJpdmVyLg0KDQpUaGlzIHBhdGNoIGRlcGVuZHMg
b246DQotIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NDgvDQot
IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NDkvDQotIGh0dHBz
Oi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NTAvDQotIGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTg5NzYvDQoNCkNoYW5nZXMgc2luY2UgdjE6
DQotIEFkZHMgbWVtYmVyIGRlc2NyaXB0aW9uDQotIEFkZHMgcGF0Y2ggZGVucGVuZGVuY3kgaW4g
dGhlIGNvbW1lbnQNCg0KU2lnbmVkLW9mZi1ieTogTG93cnkgTGkgKEFybSBUZWNobm9sb2d5IENo
aW5hKSA8bG93cnkubGlAYXJtLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxh
eS9rb21lZGEva29tZWRhX2Rldi5jIHwgNCArKysrDQogZHJpdmVycy9ncHUvZHJtL2FybS9kaXNw
bGF5L2tvbWVkYS9rb21lZGFfZGV2LmggfCAyICsrDQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21l
ZGEva29tZWRhX2Rldi5jIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfZGV2LmMNCmluZGV4IDdmMjVlNmEuLmI0OTAyYWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9kZXYuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZGV2LmMNCkBAIC04LDYgKzgsNyBAQA0KICNp
bmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4N
CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Rt
YS1pb21tdS5oPg0KICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCiAjaW5jbHVkZSA8bGludXgvZGVi
dWdmcy5oPg0KICNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPg0KQEAgLTI0NSw2ICsyNDYsOSBA
QCBzdHJ1Y3Qga29tZWRhX2RldiAqa29tZWRhX2Rldl9jcmVhdGUoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAkJZ290byBlcnJfY2xlYW51cDsNCiAJfQ0KIA0KKwlkZXYtPmRtYV9wYXJtcyA9ICZtZGV2
LT5kbWFfcGFybXM7DQorCWRtYV9zZXRfbWF4X3NlZ19zaXplKGRldiwgRE1BX0JJVF9NQVNLKDMy
KSk7DQorDQogCWVyciA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmZGV2LT5rb2JqLCAma29tZWRhX3N5
c2ZzX2F0dHJfZ3JvdXApOw0KIAlpZiAoZXJyKSB7DQogCQlEUk1fRVJST1IoImNyZWF0ZSBzeXNm
cyBncm91cCBmYWlsZWQuXG4iKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rp
c3BsYXkva29tZWRhL2tvbWVkYV9kZXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9r
b21lZGEva29tZWRhX2Rldi5oDQppbmRleCAyOWUwM2M0Li44M2FjZTcxIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZGV2LmgNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oDQpAQCAtMTQ5LDYg
KzE0OSw4IEBAIHN0cnVjdCBrb21lZGFfZGV2IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAkv
KiogQHJlZ19iYXNlOiB0aGUgYmFzZSBhZGRyZXNzIG9mIGtvbWVkYSBpbyBzcGFjZSAqLw0KIAl1
MzIgX19pb21lbSAgICpyZWdfYmFzZTsNCisJLyoqIEBkbWFfcGFybXM6IHRoZSBkbWEgcGFyYW1l
dGVycyBvZiBrb21lZGEgKi8NCisJc3RydWN0IGRldmljZV9kbWFfcGFyYW1ldGVycyBkbWFfcGFy
bXM7DQogDQogCS8qKiBAY2hpcDogdGhlIGJhc2ljIGNoaXAgaW5mb3JtYXRpb24gKi8NCiAJc3Ry
dWN0IGtvbWVkYV9jaGlwX2luZm8gY2hpcDsNCi0tIA0KMS45LjENCg0K
