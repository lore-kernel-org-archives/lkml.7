Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF52C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415E021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="e3ncVsU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfEUJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:34:59 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:12642
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbfEUJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qV0roNmTwpwgroy2o/AQZJOeVJlEDtdG3BBuNMaOmc=;
 b=e3ncVsU6wR9pj7IZO8wvNK5QrbORdcVRv/tzpoDiYYcJ9Rn5VJWqr/6epOQxvb+UTxYYcTsWHP7oqpT/NaK3yIvGGSIhAltM1gwnvw0LJvBRmYfAMSb2+1PuSwMX+eulBYrtm37kLn8PZ+jumNQrlLq+/1erlFMMAXvYX5AnH0U=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (20.179.30.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 09:34:54 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 09:34:54 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "uma.shankar@intel.com" <uma.shankar@intel.com>
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
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 3/4] drm: Increase DRM_OBJECT_MAX_PROPERTY to 32
Thread-Topic: [PATCH 3/4] drm: Increase DRM_OBJECT_MAX_PROPERTY to 32
Thread-Index: AQHVD7hy7EdUOk8BnUKtLgMnvm5h8w==
Date:   Tue, 21 May 2019 09:34:54 +0000
Message-ID: <20190521093411.26609-4-james.qian.wang@arm.com>
References: <20190521093411.26609-1-james.qian.wang@arm.com>
In-Reply-To: <20190521093411.26609-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:203:2e::14) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef6a8606-0122-4150-93ad-08d6ddcf9491
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5134;
x-ms-traffictypediagnostic: VE1PR08MB5134:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5134CB6D2E8425F7AF3BA9B2B3070@VE1PR08MB5134.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(54906003)(486006)(68736007)(110136005)(4326008)(4744005)(103116003)(2501003)(66446008)(64756008)(66066001)(73956011)(66946007)(50226002)(11346002)(66556008)(66476007)(36756003)(8676002)(2906002)(81156014)(25786009)(8936002)(186003)(26005)(446003)(81166006)(476003)(86362001)(3846002)(99286004)(256004)(14444005)(478600001)(76176011)(52116002)(5660300002)(2616005)(6116002)(305945005)(7736002)(53936002)(6512007)(2201001)(71190400001)(6486002)(316002)(6436002)(71200400001)(55236004)(14454004)(1076003)(6506007)(102836004)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 70IdTuFvZHJ9v1KDhnzcQxYm/z2u8vLt30x+SG+n99nveW2Nhl96W07R9d1bqCrd1WuPfpHRl6JWwX8l4DuUi6gd+WK9osu80q9DK7lhuvNVpHA3eNlgoqGVP7grof/H6LWrWIiknuMeCvDe5fqRZX/2A+8X8M4Zo7j1KfnmugcTwhIdp20zSnaYtMBGu/vpEKwaeIPTrQlugEAguFXV7UrUhz9VJsts5FESqz0qxF6J8lGIvGbwYCQnD0xcIs3sBmRe/cjQBRqw5j74F5IE8Pp9lAbfj7phPZPmOMbR5/TfBKLGlS5rp0Z3k3gpKyWb1W3uWNz9z61mWL8yTb/DEkzZgaEsN2u4Ga34cUJ4ohkFDwIejZ7exDUkpYMUvPOqjeCOTmAt/MZnRvKm2b6R0WUnzJVOY+AX9CpddN2BQP8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6a8606-0122-4150-93ad-08d6ddcf9491
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:34:54.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFJNX09CSkVDVF9NQVhfUFJPUEVSVFkgbnVtYmVyIDI0IGlzIG5vdCBlbm91Z2ggZm9yIGtvbWVk
YSB1c2FnZSwgaW5jcmVhc2UNCml0IHRvIDMyIHRvIGZpdCBrb21lZGEncyByZXF1aXJlbWVudC4N
Cg0KU2lnbmVkLW9mZi1ieTogSmFtZXMgUWlhbiBXYW5nIChBcm0gVGVjaG5vbG9neSBDaGluYSkg
PGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KLS0tDQogaW5jbHVkZS9kcm0vZHJtX21vZGVfb2Jq
ZWN0LmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fbW9kZV9vYmplY3QuaCBiL2luY2x1
ZGUvZHJtL2RybV9tb2RlX29iamVjdC5oDQppbmRleCBjMzRhM2U4MDMwZTEuLmZkNzY2NjA0ODE5
NyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHJtL2RybV9tb2RlX29iamVjdC5oDQorKysgYi9pbmNs
dWRlL2RybS9kcm1fbW9kZV9vYmplY3QuaA0KQEAgLTYwLDcgKzYwLDcgQEAgc3RydWN0IGRybV9t
b2RlX29iamVjdCB7DQogCXZvaWQgKCpmcmVlX2NiKShzdHJ1Y3Qga3JlZiAqa3JlZik7DQogfTsN
Cg0KLSNkZWZpbmUgRFJNX09CSkVDVF9NQVhfUFJPUEVSVFkgMjQNCisjZGVmaW5lIERSTV9PQkpF
Q1RfTUFYX1BST1BFUlRZIDMyDQogLyoqDQogICogc3RydWN0IGRybV9vYmplY3RfcHJvcGVydGll
cyAtIHByb3BlcnR5IHRyYWNraW5nIGZvciAmZHJtX21vZGVfb2JqZWN0DQogICovDQotLQ0KMi4x
Ny4xDQo=
