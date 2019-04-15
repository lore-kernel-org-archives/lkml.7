Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9800B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kNdVTcI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfDOHJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:09:03 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:22241
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP8hFlrMH/lrRBovGhrArt9vyhrcc6QInEge6YqeElE=;
 b=kNdVTcI8XOGJHqKt9515G7CSfbKGSx8kbopaIeOKHN4NHpds1m5P9YqxXbAcIXbDmGF4fYkustyAf0eTZOrNy9NyxnKnAfIDzBi/iVoN1dcVIWPMAAbfaH+EAQZ86wm2T21v8uE9k2UfBIcexzGxzblCgaZHT/A2L3XhtB897xs=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4765.eurprd08.prod.outlook.com (10.255.113.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 07:08:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 07:08:59 +0000
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
Subject: [PATCH v1 0/6] Added scaler support for komeda
Thread-Topic: [PATCH v1 0/6] Added scaler support for komeda
Thread-Index: AQHU81oYpH+/wXOnzUyxJVIdrsvqig==
Date:   Mon, 15 Apr 2019 07:08:59 +0000
Message-ID: <20190415070828.24075-1-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: 419f68c3-d648-4de1-b248-08d6c1713b27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4765;
x-ms-traffictypediagnostic: VE1PR08MB4765:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4765ABE80E6ABF87DDF061DBB32B0@VE1PR08MB4765.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(186003)(14454004)(5024004)(966005)(81156014)(486006)(66066001)(8676002)(26005)(5660300002)(6436002)(1076003)(103116003)(6512007)(36756003)(476003)(2616005)(7736002)(4326008)(81166006)(305945005)(2906002)(6306002)(25786009)(71200400001)(71190400001)(68736007)(86362001)(2201001)(50226002)(102836004)(110136005)(97736004)(386003)(6506007)(55236004)(54906003)(256004)(8936002)(52116002)(106356001)(105586002)(2501003)(6486002)(53936002)(3846002)(478600001)(99286004)(316002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4765;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 32TxEZlHe9HD1/lubAktWCEn5WwmyFwtJkdzIAqa5dbSasL3D2RJpRM6QHn+UtjlCMFVQDpK6Ylj+U5Bc3EjQWD/85CTj1lV8ciMNDp2IErlPHCWsr+88VF1Y292hqFPLkJTgUX4hjMYienRhPwVd2JpZKUpQ0aHNNDRUJA50SKAznIJYqpur0g528DwyT05nlnV6k9RHIcMQidrCORSe1Zg7w0jK77Ffp2vcmRqh1fumc0mHGkr5K+fdZWnRBMxL4wki4/1Vl6z3AiboB314BMKINZJWJbJZd4PCkDoGuD1K6XlgQ5QIVS2YoFqPN895vaXAONr511Pc4EuvJpMPX+jKLtVQ4E52nrPBELW/F+2G9K9cDnAJQWUvyzQCHbhs7tBIYgbfGW05lHgKRVesOIrEuqszk3KMIkQPuxrII4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419f68c3-d648-4de1-b248-08d6c1713b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 07:08:59.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkZWQgc2NhbGluZyBhbmQgaW1hZ2UgZW5oYW5jZW1lbnQgc3Vw
cG9ydCBmb3Iga29tZWRhDQpkcml2ZXIuDQpFbmFibGVkIHR3byBkaWZmZXJlbnQgc2NhbGluZyB1
c2FnZToNCi0gbGF5ZXIgc2NhbGluZzogc2NhbGluZyBhIGlucHV0IGltYWdlIGJlZm9yZSBjb21w
b3NpdGUgaXQgd2l0aCBvdGhlcnMNCi0gd3JpdGUtYmFjayBzY2FsaW5nOiBzY2FsaW5nIHRoZSBj
b21wb3NpdGlvbiByZXN1bHQgYW5kIHdyaXRlIGl0IHRvDQogIG1lbW9yeS4NCg0KVGhpcyBwYXRj
aHNldCBkZXBlbmRzIG9uOg0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2Vy
aWVzLzU0NDQ5Lw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU0
NDUwLw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU4OTc2Lw0K
LSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAwLw0KDQpKYW1l
cyBRaWFuIFdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5hKSAoNik6DQogIGRybS9rb21lZGE6IEF0
dGFjaCBzY2FsZXIgdG8gZHJtIGFzIHByaXZhdGUgb2JqZWN0DQogIGRybS9rb21lZGE6IEFkZCB0
aGUgaW5pdGlhbCBzY2FsZXIgc3VwcG9ydCBmb3IgQ09SRQ0KICBkcm0va29tZWRhOiBJbXBsZW1l
bnQgRDcxIHNjYWxlciBzdXBwb3J0DQogIGRybS9rb21lZGE6IEFkZCB3cml0ZWJhY2sgc2NhbGlu
ZyBzdXBwb3J0DQogIGRybS9rb21lZGE6IEFkZCBlbmdpbmUgY2xvY2sgcmVxdWlyZW1lbnQgY2hl
Y2sgZm9yIHRoZSBkb3duc2NhbGluZw0KICBkcm0va29tZWRhOiBBZGQgaW1hZ2UgZW5oYW5jZW1l
bnQgc3VwcG9ydA0KDQogLi4uL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2NvbXBvbmVudC5j
ICAgIHwgMTc3ICsrKysrKysrKysrKysrKysrLQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9kNzEvZDcxX2Rldi5jICB8ICAgMiArLQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9kNzEvZDcxX2Rldi5oICB8ICAgMiArDQogLi4uL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29t
ZWRhL2tvbWVkYV9jcnRjLmMgIHwgIDY3ICsrKysrKy0NCiAuLi4vZ3B1L2RybS9hcm0vZGlzcGxh
eS9rb21lZGEva29tZWRhX2ttcy5oICAgfCAgMTQgKy0NCiAuLi4vZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9rb21lZGFfcGlwZWxpbmUuYyAgfCAgMTQgKysNCiAuLi4vZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9rb21lZGFfcGlwZWxpbmUuaCAgfCAgMzMgKysrLQ0KIC4uLi9kaXNwbGF5L2tvbWVkYS9r
b21lZGFfcGlwZWxpbmVfc3RhdGUuYyAgICB8IDE2NCArKysrKysrKysrKysrKystDQogLi4uL2dw
dS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jIHwgIDc3ICsrKysrKystDQog
Li4uL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcHJpdmF0ZV9vYmouYyAgIHwgIDQ5ICsrKysr
DQogLi4uL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfd2JfY29ubmVjdG9yLmMgIHwgICAyICsN
CiAxMSBmaWxlcyBjaGFuZ2VkLCA1ODUgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi4xNy4xDQoNCg==
