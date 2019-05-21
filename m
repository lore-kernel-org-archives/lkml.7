Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1754AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DBC2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RdtbMpQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfEUJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:34:41 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:28293
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfEUJel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaGaJUFxCrYbmmLXLSebmjWLmVN2jJwQT4ta/UEH/RY=;
 b=RdtbMpQ513K3REpL9MuVudJBfvNcA/vBRJu2whnOV+j/f48NjV1X/qXBm4jmLmAVpMNRF8gXc34eVbSLSQDZ3p6oOnMiHif45V7+isLvNBtOtrZ2SHTpuOGYU0gZ0xQZHj1TrQsVIXb8EDg/8DymmzEgJMaaRAT37mfl+xeiBOM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5134.eurprd08.prod.outlook.com (20.179.30.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 09:34:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 09:34:35 +0000
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
Subject: [PATCH 0/4] drm/komeda: Enable layer/plane color mgmt
Thread-Topic: [PATCH 0/4] drm/komeda: Enable layer/plane color mgmt
Thread-Index: AQHVD7hnGE4Sag0zPkevUVALb5b04Q==
Date:   Tue, 21 May 2019 09:34:35 +0000
Message-ID: <20190521093411.26609-1-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: d47c10ad-90c8-4443-4356-08d6ddcf8970
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5134;
x-ms-traffictypediagnostic: VE1PR08MB5134:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5134B04F6133C9600FE8C93BB3070@VE1PR08MB5134.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(54906003)(486006)(68736007)(110136005)(4326008)(103116003)(2501003)(66446008)(64756008)(66066001)(73956011)(66946007)(50226002)(66556008)(66476007)(36756003)(8676002)(2906002)(81156014)(25786009)(8936002)(186003)(26005)(81166006)(476003)(86362001)(3846002)(99286004)(256004)(478600001)(52116002)(6306002)(5660300002)(2616005)(6116002)(305945005)(7736002)(53936002)(6512007)(2201001)(71190400001)(6486002)(316002)(6436002)(71200400001)(55236004)(14454004)(1076003)(6506007)(102836004)(966005)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5134;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wXfdHbEJwM9qOlU2PZWOD07Wac9LnOrUFq5xXPHX0AIveR/D32NIs+dYQMwfLePLyG/nQaxv7YP0RLw/Sc3CyD7rvtbrieMnwmsBt5Ssi2uwxi5znMMzf9JEOpzjuzRjUTHf91pGNjUzV0slr0iwH0vIUC4euH4Wbhh9EUh9jZAnn6w8E5nsHzVz29YDa1d/MNCLDAdBgFIw0ykIYRa+cKeyZz7hnkTjqtUvWo/5h7fHunz9kb7BM3puZf9VElC2ytl+vGbd6wgYvX/GLR5VX/q+34oAmOuZDc9obhSalClNhsFnMCrdyfCw9ZUJ6pRzx6fhCGL6Amf9/u7V+rj+jQOFm6yqPpuxlTnHB3Yha2A6FCK63J0tJ/4mZWD0RVcqrWnIMGvVsmf9mv/XYSig2EUqPAaefe7ZXiMJFD9uBpw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c10ad-90c8-4443-4356-08d6ddcf8970
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:34:35.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgZW5hYmxlZCBsYXllci9wbGFuZSBjb2xvciBtYW5hZ2VtZW50IGZv
ciBrb21lZGEgZHJpdmVyDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZHMgb246DQotIGh0dHBz
Oi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMzA4NzYvDQotIGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNjA4NTYvDQoNCkphbWVzIFFpYW4gV2FuZyAo
QXJtIFRlY2hub2xvZ3kgQ2hpbmEpICg0KToNCiAgZHJtL2tvbWVkYTogSW50cm9kdWNlIGtvbWVk
YV9jb2VmZnNfdGFibGUvbWFuYWdlcg0KICBkcm0va29tZWRhOiBJbnRyb2R1Y2Uga29tZWRhX2Nv
bG9yX21hbmFnZXIvc3RhdGUNCiAgZHJtOiBJbmNyZWFzZSBEUk1fT0JKRUNUX01BWF9QUk9QRVJU
WSB0byAzMg0KICBkcm0va29tZWRhOiBFbmFibGUgTGF5ZXIgY29sb3IgbWFuYWdlbWVudCBmb3Ig
a29tZWRhDQoNCiBkcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL01ha2VmaWxlICAg
fCAgIDEgKw0KIC4uLi9hcm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYyAgICB8
ICA2NCArKysrKysrKysNCiAuLi4vZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9k
ZXYuYyAgfCAgIDUgKy0NCiAuLi4vZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9k
ZXYuaCAgfCAgIDIgKw0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9jb2VmZnMu
YyAgICB8IDExOSArKysrKysrKysrKysrKysrKw0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRh
L2tvbWVkYV9jb2VmZnMuaCAgICB8ICA3NCArKysrKysrKysrDQogLi4uL2FybS9kaXNwbGF5L2tv
bWVkYS9rb21lZGFfY29sb3JfbWdtdC5jICAgIHwgMTI2ICsrKysrKysrKysrKysrKysrKw0KIC4u
Li9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2NvbG9yX21nbXQuaCAgICB8ICAzMiArKysrLQ0K
IC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZS5oICB8ICAgNCArLQ0K
IC4uLi9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmVfc3RhdGUuYyAgICB8ICA1MSArKysr
KystDQogLi4uL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jIHwgIDEy
ICsrDQogLi4uL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcHJpdmF0ZV9vYmouYyAgIHwgICA0
ICsNCiBpbmNsdWRlL2RybS9kcm1fbW9kZV9vYmplY3QuaCAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0NCiAxMyBmaWxlcyBjaGFuZ2VkLCA0ODggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9r
b21lZGFfY29lZmZzLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FybS9k
aXNwbGF5L2tvbWVkYS9rb21lZGFfY29lZmZzLmgNCg0KLS0NCjIuMTcuMQ0K
