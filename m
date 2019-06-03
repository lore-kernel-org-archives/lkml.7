Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3958CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2B327BF6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SyW4QGIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFCGbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:31:48 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:40769
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfFCGbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVbwNCjmJNAeS5DN5bmSiIMIAzOaLakKuTeKq+/U1Ec=;
 b=SyW4QGIqVse5FPi+ZHWkf18p23l1HMnrv5kmglPDJqtBGU0/NPEHKydSoZW5PVCeQ9D1xxZEeqfqZT0Ri8TQ0f6c8OuRnOP1YLFknJYks/2NhIpukUT31cUAq9QsPQy4Kx4sOasHLwHYCM7o8JCvhqXb+3kXOX47WnnnBhzGAzY=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB4605.eurprd08.prod.outlook.com (20.178.13.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 06:31:44 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::ada6:12ed:65d0:4629]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::ada6:12ed:65d0:4629%4]) with mapi id 15.20.1922.025; Mon, 3 Jun 2019
 06:31:43 +0000
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
Subject: [PATCH v1 0/2] Adds slave pipeline support
Thread-Topic: [PATCH v1 0/2] Adds slave pipeline support
Thread-Index: AQHVGdYCpc4vBivG4Ea/75SfePoIAw==
Date:   Mon, 3 Jun 2019 06:31:43 +0000
Message-ID: <1559543462-32264-1-git-send-email-lowry.li@arm.com>
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
x-ms-office365-filtering-correlation-id: 80d73fd4-b321-496f-eb1d-08d6e7ed24e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB4605;
x-ms-traffictypediagnostic: VI1PR08MB4605:
x-ms-exchange-purlcount: 10
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB460547F567DF486B5A7B81929F140@VI1PR08MB4605.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(102836004)(6512007)(6306002)(36756003)(110136005)(26005)(54906003)(486006)(256004)(386003)(186003)(6506007)(99286004)(55236004)(52116002)(66446008)(66476007)(53936002)(66946007)(64756008)(68736007)(4326008)(6636002)(2616005)(476003)(73956011)(66556008)(86362001)(72206003)(14454004)(478600001)(966005)(25786009)(6486002)(5660300002)(50226002)(2906002)(8936002)(316002)(2501003)(81156014)(81166006)(66066001)(8676002)(7736002)(6436002)(6116002)(71200400001)(71190400001)(3846002)(305945005)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4605;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2k0wYwVlr15SmWT+RBAAChqnphJeevQeCdnU+DRtY1JcobZDSyxR6o0Erz75fMTghabD4WxMapN3LXI/OyVGmUlqI7GG91psfBkTiQvMulhMiWScQVM8maMttWahPzlKdFtvyMJzWb1Wob3fYPVu29xWiYRl/1e2N2npAZdUA6lObx3+y5YFQDHCsIbwkjuRLbpDbK0PymyBXEc2GAuqRBELDFDWn8PutyEjcj8B/f3UCyaWwfH4QagmsCF6p4ZJzhskTnrg6HTBrvyqQaSUq7BUgEqD6Ig6a8DU6T0O0LMOLQbSMT0UQOnnEQcyIuBPnVxtOd9prxM0olpvebAKAa70Tl2pHv0bmFksqjLY9M/t+ySKfx4f3v2cjBWz4vbRL532Zo1TG9pkGKnPfzNiFKWWT/HynPI+BpL7YCJ5tH4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d73fd4-b321-496f-eb1d-08d6e7ed24e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 06:31:43.7227
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

SGksDQoNClRoaXMgc2VyaWUgYWltcyBhdCBhZGRpbmcgdGhlIHN1cHBvcnQgZm9yIHNsYXZlIHBp
cGVsaW5lIG9uIEtvbWVkYQ0KZHJpdmVyLiBBbHNvIGFkZHMgZHJvcF9tYXN0ZXIgdG8gc2h1dGRv
d24gdGhlIGRldmljZSBhbmQgbWFrZSBzdXJlDQphbGwgdGhlIGtvbWVkYSByZXNvdXJjZXMgc2hh
cmVkIGJldHdlZW4gY3J0Y3MgaGF2ZSBiZWVuIHJlbGVhc2VkLg0KDQpUaGlzIHBhdGNoIHNlcmll
cyBkZXBlbmRzIG9uOg0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVz
LzU4NzEwLw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAw
Lw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAyLw0KLSBo
dHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5NzQ3Lw0KLSBodHRwczov
L3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5OTE1Lw0KLSBodHRwczovL3BhdGNo
d29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzYwMDgzLw0KLSBodHRwczovL3BhdGNod29yay5m
cmVlZGVza3RvcC5vcmcvc2VyaWVzLzYwNjk4Lw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVz
a3RvcC5vcmcvc2VyaWVzLzYwODU2Lw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5v
cmcvc2VyaWVzLzYwODkzLw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2Vy
aWVzLzYxMzcwLw0KDQpSZWdhcmRzLA0KTG93cnkNCg0KTG93cnkgTGkgKEFybSBUZWNobm9sb2d5
IENoaW5hKSAoMik6DQogIGRybS9rb21lZGE6IEFkZCBzbGF2ZSBwaXBlbGluZSBzdXBwb3J0DQog
IGRybS9rb21lZGE6IEFkZHMga29tZWRhX2ttc19kcm9wX21hc3Rlcg0KDQogZHJpdmVycy9ncHUv
ZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfY3J0Yy5jICAgfCA0MSArKysrKysrKysrKysr
KysrKysrKy0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfa21z
LmMgICAgfCAyMyArKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29t
ZWRhL2tvbWVkYV9rbXMuaCAgICB8ICA5ICsrKysrDQogLi4uL2dwdS9kcm0vYXJtL2Rpc3BsYXkv
a29tZWRhL2tvbWVkYV9waXBlbGluZS5jICAgfCAyMiArKysrKysrKysrKysNCiAuLi4vZ3B1L2Ry
bS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lLmggICB8ICAyICsrDQogLi4uL2Ry
bS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0YXRlLmMgfCAxNSArKysrKysr
Kw0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BsYW5lLmMgIHwg
MzIgKysrKysrKysrKysrKysrKy0NCiA3IGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KDQotLSANCjEuOS4xDQoNCg==
