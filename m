Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ACCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DFD2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LUEautm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:08:27 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:31969
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLOI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJIDQnlKqwOkJTmZ0r2e9tba3p0zl6hhO2B7O1Dt7H8=;
 b=LUEautm4B+AgHrwcXwlS/30mZXyfmEo06CJsJzZnpXmTxANnLfkkuLwnAOYECE7KU2mmpcr9oTNNp/aBR+FaQImBpzM+qXCub7iWAGwl8iQAP/4puZ3Z1YhguvGvMUaAFEIdENBzcEUt52jYVyIuTpe+WF1DiEOBuwWpOfafYt4=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1789.eurprd08.prod.outlook.com (10.168.67.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Fri, 12 Apr 2019 14:08:23 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::ec0c:910f:7b71:aff4%7]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 14:08:23 +0000
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
Subject: [PATCH v2 0/2] Add writeback scaling
Thread-Topic: [PATCH v2 0/2] Add writeback scaling
Thread-Index: AQHU8Tkwc1Sk3D4FEkuUpzqQkpknHg==
Date:   Fri, 12 Apr 2019 14:08:23 +0000
Message-ID: <1555078094-6587-1-git-send-email-ben.davis@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0478.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::34) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3303bdae-3a75-4f8c-e8b2-08d6bf5052c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0801MB1789;
x-ms-traffictypediagnostic: VI1PR0801MB1789:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB178968EC89243AEAAE7BA6B7E5280@VI1PR0801MB1789.eurprd08.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(97736004)(4326008)(36756003)(14454004)(86362001)(6512007)(99286004)(53936002)(256004)(44832011)(2501003)(7736002)(305945005)(14444005)(6916009)(71200400001)(478600001)(71190400001)(54906003)(81156014)(3846002)(2616005)(25786009)(476003)(68736007)(105586002)(486006)(50226002)(6486002)(5640700003)(72206003)(106356001)(2906002)(6506007)(6436002)(316002)(102836004)(26005)(2351001)(8676002)(8936002)(66066001)(5660300002)(186003)(52116002)(386003)(81166006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1789;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YCJ+m+rVXXcbojcbxQgM/F0TdzmT2hRhaHVyt8UB7KYwE00fFFx3qv+3TUTia60jJQkXbAFi9sNp/5WO/OvPzfuYFktNdyLIGKLZ4ccA+tqT7xOb+vwDj6vl0Mabddo0rEvqYeeCLnGwHQr8U0inKsJ+gDgLscd6Xwj0/ctsSYfN4B3pgMNXcH/f+LnpB1egWqjyx7UllaeMB10jXjv7QSR0rA2/B3qnapMizxfunoSK/TEvFUDKkp/MMSLam/q7FGEIPHDEtsTx3Yod/IMF4E/GbfuEuOvfSU1GnzM6MiItvp+W5cxJHnIvrP29YDeapzE0ADHvYUzfkFQlPh3Bu8lqggzpz8/LtyQvNadlbTr2aa2mPpjW+kzjdzBQb5udoPADK8ZNR5/yRLasAtZBDeefY86yn4D9hCxMDe72QLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303bdae-3a75-4f8c-e8b2-08d6bf5052c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 14:08:23.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIHNjYWxpbmcgb24gd3JpdGViYWNrLiBUbyBkbyB0aGlzIGFkZCB3cml0
ZWJhY2tfdyBhbmQNCndyaXRlYmFja19oIGFzIHdyaXRlYmFjayBjb25uZWN0b3IgcHJvcGVydGll
cyB0byBzcGVjaWZ5IHRoZSBkZXNpcmVkDQpvdXRwdXQgZGltZW5zaW9ucy4NClRoZW4gaW1wbGVt
ZW50IGRvd25zY2FsaW5nIG9uIHdyaXRlYmFjayBmb3IgTWFsaWRwLTU1MCBhbmQgTWFsaWRwLTY1
MA0KKHVwc2NhbGluZyBvbiB3cml0ZWJhY2sgaXMgbm90IHN1cHBvcnRlZCBvbiB0aGVzZSBkZXZp
Y2VzKS4NCg0KdjI6IFVzZSAwIGFzIGRlZmF1bHQgZm9yIHdyaXRlYmFja193LGggYW5kIHNvIHVw
ZGF0ZSByYW5nZSB0byB1c2UgMSBhcw0KICAgIG1pbmltdW0uDQoNCkJlbiBEYXZpcyAoMik6DQog
IGRybTogQWRkIHdyaXRlYmFja193LGggcHJvcGVydGllcw0KICBkcm0vbWFsaWRwOiBFbmFibGUg
d3JpdGViYWNrIHNjYWxpbmcNCg0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2NydGMuYyB8
IDQ5ICsrKysrKysrKysrKy0tLS0tLS0tLS0NCiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9j
cnRjLmggfCAxMiArKysrKysNCiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9kcnYuYyAgfCAx
MCArKystLQ0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2h3LmMgICB8IDQ1ICsrKysrKysr
KysrKysrLS0tLS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfaHcuaCAgIHwgMTkgKysr
KysrKy0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfbXcuYyAgIHwgODYgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9tYWxp
ZHBfcmVncy5oIHwgIDEgKw0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX3VhcGkuYyB8ICA4
ICsrKysNCiBkcml2ZXJzL2dwdS9kcm0vZHJtX3dyaXRlYmFjay5jICAgfCAyOCArKysrKysrKysr
KysrDQogaW5jbHVkZS9kcm0vZHJtX2Nvbm5lY3Rvci5oICAgICAgIHwgIDQgKysNCiBpbmNsdWRl
L2RybS9kcm1fbW9kZV9jb25maWcuaCAgICAgfCAxMCArKysrKw0KIDExIGZpbGVzIGNoYW5nZWQs
IDIxMSBpbnNlcnRpb25zKCspLCA2MSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfY3J0Yy5oDQoNCi0tIA0KMi43LjQNCg0K
