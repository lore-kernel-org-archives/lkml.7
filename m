Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C748C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E426B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dqycJ7Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfDSSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:30 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:37859
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfDSSYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2uXRT7Riq0uXL41uwo5LdKVFtjRzAJZUg9uB16AMx0=;
 b=dqycJ7WqrHY2GrLfuAbeamzTn2QClk6F5G1RahzB2x4L4NlwMr+G9p1QUVHWG8EFuTaqF7pufaJ9zb0jrTpSVKJnQTjRyB/vgM/FIMU8y867vLv1scvopTH9voXRaEBMm/5CfsRURA9SRmB6V0jrA5qKh/IyZGzAxpw8hRZUNb0=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3387.eurprd08.prod.outlook.com (20.176.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Fri, 19 Apr 2019 07:58:25 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 07:58:25 +0000
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
Subject: [PATCH v1 0/2] drm/komeda: Add rotation support on Komeda driver
Thread-Topic: [PATCH v1 0/2] drm/komeda: Add rotation support on Komeda driver
Thread-Index: AQHU9oWq5RIZwPifU0uIFccZ0qbRfg==
Date:   Fri, 19 Apr 2019 07:58:25 +0000
Message-ID: <1555660675-4903-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a65546a-57dc-4313-fb89-08d6c49cccf1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3387;
x-ms-traffictypediagnostic: DB7PR08MB3387:
x-ms-exchange-purlcount: 6
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB33879644F306F7E7A76317E29F270@DB7PR08MB3387.eurprd08.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(55236004)(71200400001)(68736007)(71190400001)(2616005)(53936002)(386003)(6506007)(86362001)(25786009)(14454004)(6636002)(2201001)(97736004)(256004)(486006)(7736002)(52116002)(6486002)(4326008)(305945005)(3846002)(6116002)(72206003)(8676002)(186003)(36756003)(81156014)(81166006)(5660300002)(110136005)(2906002)(6436002)(476003)(54906003)(26005)(316002)(2501003)(478600001)(50226002)(102836004)(66066001)(6512007)(99286004)(64756008)(66556008)(66476007)(966005)(73956011)(66946007)(6306002)(66446008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3387;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H+QMzQsHvgA1w+EBekdJkjh5ov2p4qeQQ3mOnBZBfeC/oZJ0sey4yZhPTnkPC1qNcElL/PXhPgsZLwTrXR60f2Wyj1e0fTnoOBqm0wkYqbGIq8EraE0bbgYMos8b2z19rVIbUX6wlLDrx8IgdWyjQTjjy2v+L8gDVL0dMfFmefwXh6mHW3JpOfeTRjo0VAVJ9nVY73wPPtnPIJjOqERoX/uzn+a2/pwLz+x0V3RYWJHgEdqjWHpWxz8QNJUyXMxsa05lanEyNDTBOjzR/vt/cbiZMUXIj+7V9m4sTzIYk2Elwy6XDUx5vgzBie6XU0Gvfyro0+cG0mXiOEn4L8sU46PkiesR7VXEPXb31W9iwuKl+Nj/yrbuMfJY8+jdIiUn7cT+se/KqCy/27yQH2mrQZhW83KZuGxyJDPeecJGCvY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a65546a-57dc-4313-fb89-08d6c49cccf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 07:58:25.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgc2VyaWUgYWltcyBhdCBhZGRpbmcgdGhlIHN1cHBvcnQgZm9yIHJvdGF0aW9u
IG9uIEtvbWVkYSBkcml2ZXIuDQpUaGlzIHBhdGNoIHNlcmllcyBkZXBlbmRzIG9uOg0KLSBodHRw
czovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU0NDQ5Lw0KLSBodHRwczovL3Bh
dGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU0NDUwLw0KLSBodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzU4NzEwLw0KLSBodHRwczovL3BhdGNod29yay5mcmVl
ZGVza3RvcC5vcmcvc2VyaWVzLzU5MDAwLw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3Rv
cC5vcmcvc2VyaWVzLzU5MDAyLw0KLSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcv
c2VyaWVzLzU5NDcxLw0KDQpSZWdhcmRzLA0KTG93cnkNCg0KTG93cnkgTGkgKEFybSBUZWNobm9s
b2d5IENoaW5hKSAoMik6DQogIGRybS9rb21lZGE6IEFkZCByb3RhdGlvbiBzdXBwb3J0IG9uIEtv
bWVkYSBkcml2ZXINCiAgZHJtL2tvbWVkYTogQWRkcyBsaW1pdGF0aW9uIGNoZWNrIGZvciBBRkJD
IHdpZGUgYmxvY2sgbm90IHN1cHBvcnQNCiAgICBSb3Q5MA0KDQogZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2Rldi5jICAgICAgfCAxNSArKysrKysrKysrKysrKysN
CiAuLi4vZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Zvcm1hdF9jYXBzLmMgICB8
ICA3ICsrKysrKy0NCiAuLi4vZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Zvcm1h
dF9jYXBzLmggICB8IDE5ICsrKysrKysrKysrKysrKysrKy0NCiAuLi4vZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEva29tZWRhX2ZyYW1lYnVmZmVyLmMgICB8IDE4ICsrKysrKysrKy0tLS0tLS0t
LQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZnJhbWVidWZmZXIuaCAg
IHwgIDUgKysrLS0NCiAuLi4vZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmVf
c3RhdGUuYyAgICB8IDE1ICsrKysrKysrKysrKysrLQ0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEva29tZWRhX3BsYW5lLmMgICAgIHwgMTggKysrKysrKysrKysrKysrKystDQog
NyBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KLS0g
DQoxLjkuMQ0KDQo=
