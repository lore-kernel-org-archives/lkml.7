Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4858222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EdtZx5m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfDJLLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:11:10 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:21838
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728160AbfDJLLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIhee+Tl92NmNOeLD0RpHPOPR5HuZBChzgkhucqJGjI=;
 b=EdtZx5m1afyCGic6/23z1nIqRSrAZv5iHX2vwMOU7CPPfOZXCE9KYKDa9FAkhlYDWTmQr6iJKJ3wx0BTs4shas3Z86cV8FxXxEjlrIy5eyURYBg8G5rHsefpDy+7nLdPYDSPwKQZuXh/c7m0RPSw9QgqbPcceqL4/FjzekAl9z8=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1856.eurprd08.prod.outlook.com (10.168.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Wed, 10 Apr 2019 11:11:05 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011%9]) with mapi id 15.20.1771.014; Wed, 10 Apr 2019
 11:11:05 +0000
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
Subject: [PATCH 0/2] Add writeback scaling
Thread-Topic: [PATCH 0/2] Add writeback scaling
Thread-Index: AQHU744XgTXMIWC1L0GyXqo+hXDehw==
Date:   Wed, 10 Apr 2019 11:11:05 +0000
Message-ID: <cover.1554891327.git.ben.davis@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::30) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b99936a-4ead-409e-44c9-08d6bda5396b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0801MB1856;
x-ms-traffictypediagnostic: VI1PR0801MB1856:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB1856982BE1066481CA7ACEE3E52E0@VI1PR0801MB1856.eurprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(4326008)(99286004)(81156014)(54906003)(6486002)(7736002)(305945005)(66066001)(81166006)(71190400001)(86362001)(2501003)(53936002)(186003)(71200400001)(476003)(486006)(6512007)(316002)(478600001)(2616005)(36756003)(8676002)(52116002)(2906002)(3846002)(6116002)(105586002)(5660300002)(68736007)(106356001)(8936002)(26005)(25786009)(50226002)(102836004)(14454004)(44832011)(6436002)(2351001)(256004)(5640700003)(97736004)(6916009)(72206003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1856;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6BAgSHsGnG0Hrb3tIsxLBz3qlIcUjYOf5YFdOnZf47AAoVpZhK+j+WIlSTC5NeDsCAZO/Ph8padUJQExl7IW1oLWkJwrNmvJtLcqvwho7rvQ8FIojCDyi5oI5LHWqSVxC0U4tGmmFVnF0j5IEHQZTft0ILInLOVFcWgsvxjHJ6l6bQnkoZyBhXJIOcgN1+FuKG43TG/9gDIAJ2qMdrpkQHXUthTqW6D2Ufj7tfIwDu4iR1qLyX+OrvU6ORqXXRpcSikBDe2psGfTBifuVeioLNLtRz6e73VhhCJWNnhFcqZGM+JFPfoy0tdoKhXm/RPlppbZUBTNxpRpaJ9XViqcwKZnMq0+QKwyq7Uqy7YhDU6JjLfnQswp06XEDV42tmykuwWlSeySsz5m/V7/OaiMyKgm43xnNm0mgROIQ4p47x8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b99936a-4ead-409e-44c9-08d6bda5396b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:11:05.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIHNjYWxpbmcgb24gd3JpdGViYWNrLiBUbyBkbyB0aGlzIGFkZCB3cml0
ZWJhY2tfdyBhbmQNCndyaXRlYmFja19oIGFzIHdyaXRlYmFjayBjb25uZWN0b3IgcHJvcGVydGll
cyB0byBzcGVjaWZ5IHRoZSBkZXNpcmVkDQpvdXRwdXQgZGltZW5zaW9ucy4NClRoZW4gaW1wbGVt
ZW50IGRvd25zY2FsaW5nIG9uIHdyaXRlYmFjayBmb3IgTWFsaWRwLTU1MCBhbmQgTWFsaWRwLTY1
MA0KKHVwc2NhbGluZyBvbiB3cml0ZWJhY2sgaXMgbm90IHN1cHBvcnRlZCBvbiB0aGVzZSBkZXZp
Y2VzKS4NCg0KQmVuIERhdmlzICgyKToNCiAgZHJtOiBBZGQgd3JpdGViYWNrX3csaCBwcm9wZXJ0
aWVzDQogIGRybS9tYWxpZHA6IEVuYWJsZSB3cml0ZWJhY2sgc2NhbGluZw0KDQogZHJpdmVycy9n
cHUvZHJtL2FybS9tYWxpZHBfY3J0Yy5jIHwgNDkgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIGRy
aXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2NydGMuaCB8IDEyICsrKysrKw0KIGRyaXZlcnMvZ3B1
L2RybS9hcm0vbWFsaWRwX2Rydi5jICB8IDEwICsrKy0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9t
YWxpZHBfaHcuYyAgIHwgNDUgKysrKysrKysrKysrKystLS0tLS0NCiBkcml2ZXJzL2dwdS9kcm0v
YXJtL21hbGlkcF9ody5oICAgfCAxOSArKysrKysrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYXJtL21h
bGlkcF9tdy5jICAgfCA4NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9yZWdzLmggfCAgMSArDQogZHJpdmVycy9ncHUv
ZHJtL2RybV9hdG9taWNfdWFwaS5jIHwgIDggKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fd3Jp
dGViYWNrLmMgICB8IDI4ICsrKysrKysrKysrKysNCiBpbmNsdWRlL2RybS9kcm1fY29ubmVjdG9y
LmggICAgICAgfCAgNCArKw0KIGluY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oICAgICB8IDEw
ICsrKysrDQogMTEgZmlsZXMgY2hhbmdlZCwgMjExIGluc2VydGlvbnMoKyksIDYxIGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYXJtL21hbGlkcF9jcnRj
LmgNCg0KLS0gDQoyLjcuNA0KDQo=
