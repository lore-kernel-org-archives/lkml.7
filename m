Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC34C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B783520872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F82aCn2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfFFJxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:53:05 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:20694
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727943AbfFFJxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BlUUR467QU0Um19zY9or5dzMn6PhaXniwlTMECDHqY=;
 b=F82aCn2Y/iPQ3aN+Ei1H5UxA2tlVZ1r7aPaAVD78Wre4/k4p15BXkf5GjQpUzpHMEzXetfo0hMmVv76Rxrb0VT2GIWPCwDczxsZkWVZH6aYz1D7lNlrb+DhPiJPRIfVSxDlClWxI5ZokUMdAu+Ku4rq6IW4SWu8d7W8m2iJcULo=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB2797.eurprd08.prod.outlook.com (10.170.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 09:53:00 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e9f4:59c8:9be1:910b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e9f4:59c8:9be1:910b%4]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 09:53:00 +0000
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
Subject: [PATCH v2 0/2] drm/komeda: Add SMMU support on Komeda driver
Thread-Topic: [PATCH v2 0/2] drm/komeda: Add SMMU support on Komeda driver
Thread-Index: AQHVHE2gd4fnb9TRqkKGfLapzK/iFg==
Date:   Thu, 6 Jun 2019 09:53:00 +0000
Message-ID: <1559814765-18455-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d76ae04d-6428-4f6e-d7ef-08d6ea64c2a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2797;
x-ms-traffictypediagnostic: VI1PR08MB2797:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB2797EDF391BF08A70A59B9F09F170@VI1PR08MB2797.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(136003)(376002)(189003)(199004)(102836004)(55236004)(386003)(6506007)(14444005)(316002)(256004)(186003)(6486002)(71190400001)(2616005)(476003)(486006)(26005)(71200400001)(66946007)(73956011)(305945005)(25786009)(7736002)(14454004)(53936002)(4326008)(72206003)(478600001)(966005)(66066001)(66476007)(64756008)(2201001)(68736007)(66446008)(66556008)(2501003)(8936002)(81166006)(86362001)(81156014)(8676002)(36756003)(99286004)(52116002)(54906003)(110136005)(2906002)(5660300002)(6306002)(6512007)(6436002)(50226002)(3846002)(6116002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2797;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QYlUIdDo7rm6Oqquay59kosJlqhfj6K7BW9Mki80WPCEArI49kuGE6iWZIiqMLuqOyDG7j18M4FsNTdEC9XV6KP91PU02SCdCI74wljSyi5iO5dfXIkrrx/7NT5rq3GFQwhoyr9WI4YZKzxfphN8WbjWGgRcPDH74cWRZP9lRCyLVYgyub/p06LNkM+tyjfUJWtkYWqaoTZbdUs16m1fIKrkFEMCy1GAYcC0u0WFX58snQXjZRyNQb+NaevGMpemrW97cYgWyzpTHO9dBlpQakF7b3dxzkiICpsrQaskWb934lixXB7L2qrVPeKg+wSWMSP5W8TYIw8Vb+cvsoQTBMq17HeGqHnU6GFyf/U7xFisaojq/wcL24YMxHoy1V0nSsfMVbsxCM6zBP+Y3lr1eKvx5J/YoDKGa542Uh1Ajvo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76ae04d-6428-4f6e-d7ef-08d6ea64c2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 09:53:00.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lowry.Li@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgc2VyaWUgYWltcyBhdCBhZGRpbmcgdGhlIHN1cHBvcnQgZm9yIFNNTVUgb24g
S29tZWRhIGRyaXZlci4NCkFsc28gdXBkYXRlcyB0aGUgZGV2aWNlLXRyZWUgZG9jIGFib3V0IGhv
dyB0byBlbmFibGUgU01NVSBieSBkZXZpY2V0cmVlLg0KDQpUaGlzIHBhdGNoIHNlcmllcyBkZXBl
bmRzIG9uOg0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU4NzEw
Lw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAwLw0KLSBo
dHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAyLw0KLSBodHRwczov
L3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzYxNjUwLw0KDQpDaGFuZ2VzIHNpbmNl
IHYxOg0KLSBSZWJhc2UgdG8gdGhlIHBhdGNoIGluIHdoaWNoIGNvbnZlcnQgZHBfd2FpdF9jb25k
KCkgd2FzIGNoYW5nZWQgdG8NCnJldHVybiAtRVRJTUVET1VUIGFuZCB1cGRhdGUgZDcxX2Rpc2Nv
bm5lY3RfaW9tbXUoKSB0byBiZSBjb25zaXN0ZW50Lg0KLSBJZiBjb25uZWN0ZWQgSU9NTVUgZmFp
bGVkLCBzZXQgbWRldi0+aW9tbXUgYXMgTlVMTC4NCg0KVGhhbmtzLA0KTG93cnkNCg0KTG93cnkg
TGkgKEFybSBUZWNobm9sb2d5IENoaW5hKSAoMik6DQogIGRybS9rb21lZGE6IEFkZHMgU01NVSBz
dXBwb3J0DQogIGR0L2JpbmRpbmdzOiBkcm0va29tZWRhOiBBZGRzIFNNTVUgc3VwcG9ydCBmb3Ig
RDcxIGRldmljZXRyZWUNCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYXJtLGtv
bWVkYS50eHQgICAgIHwgIDcgKysrKw0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9k
NzEvZDcxX2NvbXBvbmVudC5jIHwgIDUgKysrDQogZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5
L2tvbWVkYS9kNzEvZDcxX2Rldi5jICAgfCA0OSArKysrKysrKysrKysrKysrKysrKysrDQogZHJp
dmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZGV2LmMgICAgfCAxOCArKysr
KysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oICAg
IHwgIDcgKysrKw0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9mcmFtZWJ1ZmZl
ci5jICAgIHwgIDIgKw0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9mcmFtZWJ1
ZmZlci5oICAgIHwgIDIgKw0KIDcgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KDQot
LSANCjEuOS4xDQoNCg==
