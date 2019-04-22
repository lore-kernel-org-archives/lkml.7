Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E931CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDC6218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="H4xOz2da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfDVDQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:16:25 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:30518
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfDVDQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdMe3S243+bmDedCukF9TCI4gX/Gsv6zILk/6Y2euAw=;
 b=H4xOz2daFg6Pv7y9JqQMdDblOeZ9y+eflVfoFuNgVJ4Oy+j63mSujuOyEJsliexirFivEug799lmVMbXnOZNaJtrdwtfng0iDOk2zkg8frC4mBODQymBvFu191LaUIyHm4BeXodbOVi+Ty7dWnOasxLhX4bEZrAwAYBSHlzw2jA=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3081.eurprd08.prod.outlook.com (52.134.110.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 03:16:20 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 03:16:20 +0000
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
Thread-Index: AQHU+LnBw5bzLHZanUSATrurYAmlWg==
Date:   Mon, 22 Apr 2019 03:16:20 +0000
Message-ID: <1555902945-2877-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42202480-fce7-4145-07f5-08d6c6d0e402
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3081;
x-ms-traffictypediagnostic: DB7PR08MB3081:
x-ms-exchange-purlcount: 5
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB30817F88E6C9B8A6BECB88209F220@DB7PR08MB3081.eurprd08.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(102836004)(386003)(86362001)(72206003)(6506007)(55236004)(316002)(66946007)(54906003)(305945005)(14454004)(26005)(25786009)(186003)(73956011)(81156014)(81166006)(66476007)(110136005)(6636002)(53936002)(6306002)(966005)(6512007)(478600001)(50226002)(7736002)(2201001)(66066001)(97736004)(68736007)(256004)(99286004)(4326008)(476003)(2616005)(486006)(2906002)(6116002)(8676002)(36756003)(5660300002)(52116002)(3846002)(71190400001)(64756008)(66556008)(8936002)(2501003)(71200400001)(6486002)(6436002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3081;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zf3F6cJyGSJFDon9NajuDB+FEVKHTIfOl/dl6z7rXCYPp9VmbXYFr9GrP7kn/hjmAHkNmK+u9AzgilfNWGi2y0cY/lE8J8gbK2+D1adpkBPYjSLn3TiD+A2Q/AdLsng9W+xAkZdn7RJZB8hCE+DTTGSCChl5MjLJGpU350zLgbEJ7nEw3/Xh5ylY1JPBtv3bu2v2si27jSbLcOxMZP7Q6zARKleauvKusjOZSMgUKj7QIh6Hn7O078IFFJHc737DjnfTVN77t9FnimEy5MiS5anc+MdtqG0rq6BGf/ec4WQIEzgyEXYwo4C67wcey33TGZbfejaDWOJi4Go/R9U4Zgpl08iOh6b/r5FHtlUru3bGnMPuvII193cjNOo+vmuDOLpgvboVZNqckqe/qn/xxkU4vQ1Q3hF9kgDoYqiUzrQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42202480-fce7-4145-07f5-08d6c6d0e402
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 03:16:20.5152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgc2VyaWUgYWltcyBhdCBhZGRpbmcgdGhlIHN1cHBvcnQgZm9yIHJvdGF0aW9u
IG9uIEtvbWVkYSBkcml2ZXIuDQpGb3Igcm90YXRpb24sIEQ3MSBkb2Vzbid0IHN1cHBvcnQgUm90
OTAgZm9yIEFGQkMgd2lkZSBibG9jay4gU28gdGhpcyBwYXRjaA0Kc2V0IGFsc28gaW5jbHVkZXMg
dGhlIGxpbWl0YXRpb24gY2hlY2suDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGRlcGVuZHMgb246DQot
IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NDkvDQotIGh0dHBz
Oi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NTAvDQotIGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTg3MTAvDQotIGh0dHBzOi8vcGF0Y2h3b3Jr
LmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTkwMDAvDQotIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVk
ZXNrdG9wLm9yZy9zZXJpZXMvNTkwMDIvDQoNClJlZ2FyZHMsDQpMb3dyeQ0KDQpMb3dyeSBMaSAo
QXJtIFRlY2hub2xvZ3kgQ2hpbmEpICgyKToNCiAgZHJtL2tvbWVkYTogQWRkIHJvdGF0aW9uIHN1
cHBvcnQgb24gS29tZWRhIGRyaXZlcg0KICBkcm0va29tZWRhOiBBZGRzIGxpbWl0YXRpb24gY2hl
Y2sgZm9yIEFGQkMgd2lkZSBibG9jayBub3Qgc3VwcG9ydA0KICAgIFJvdDkwDQoNCiBkcml2ZXJz
L2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFfZGV2LmMgICAgICB8IDE1ICsrKysr
KysrKysrKysrKw0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZm9ybWF0
X2NhcHMuYyAgIHwgIDcgKysrKysrLQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9r
b21lZGFfZm9ybWF0X2NhcHMuaCAgIHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KIC4uLi9ncHUv
ZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZnJhbWVidWZmZXIuYyAgIHwgMTggKysrKysr
KysrLS0tLS0tLS0tDQogLi4uL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9mcmFt
ZWJ1ZmZlci5oICAgfCAgNSArKystLQ0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVk
YV9waXBlbGluZV9zdGF0ZS5jICAgIHwgMTUgKysrKysrKysrKysrKystDQogZHJpdmVycy9ncHUv
ZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGxhbmUuYyAgICAgfCAxOCArKysrKysrKysr
KysrKysrKy0NCiA3IGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQ0KDQotLSANCjEuOS4xDQoNCg==
