Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3245C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D220862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="edbEwp0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEPGNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:13:13 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:19281
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbfEPGNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3F4ErHRqgXkDldi8UKWdQb75CrjG+6mTe5gROo47t0=;
 b=edbEwp0MoJUjVQhLW7MaAE52Y+0qWyYRX1FzKrOTDNyhPtgpX7SclsqAjunLlZYQryuS5YyxWm06BuoR82SnIzqVj+YoAEIjuqza9sOCyUswPVI/VqnDDBbIdWTL8axJw0kDcD6jJDUDTAyYpCxCCRNwzdwhUBZcoSgu6vY8IQs=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3788.eurprd08.prod.outlook.com (20.178.84.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Thu, 16 May 2019 06:13:09 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::e41c:9e3c:80bf:25c6]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::e41c:9e3c:80bf:25c6%5]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 06:13:09 +0000
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
Subject: [PATCH v1 1/2] drm/komeda: Update HW up-sampling on D71
Thread-Topic: [PATCH v1 1/2] drm/komeda: Update HW up-sampling on D71
Thread-Index: AQHVC65u2tprcwPR+EKKtDTG4grT0g==
Date:   Thu, 16 May 2019 06:13:09 +0000
Message-ID: <1557987170-24032-2-git-send-email-lowry.li@arm.com>
References: <1557987170-24032-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1557987170-24032-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a802f8ce-735a-4314-dc5e-08d6d9c5912f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3788;
x-ms-traffictypediagnostic: DB7PR08MB3788:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB3788F3B7AE5C431D1AD7EBA59F0A0@DB7PR08MB3788.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(486006)(6512007)(36756003)(8676002)(6436002)(26005)(81156014)(73956011)(66446008)(64756008)(66556008)(66476007)(81166006)(66946007)(7736002)(6636002)(186003)(305945005)(11346002)(2616005)(6486002)(476003)(446003)(8936002)(50226002)(66066001)(478600001)(316002)(55236004)(25786009)(102836004)(15650500001)(2201001)(386003)(52116002)(71190400001)(76176011)(86362001)(71200400001)(6506007)(3846002)(72206003)(2906002)(2501003)(68736007)(6116002)(14454004)(53936002)(4326008)(54906003)(5660300002)(256004)(14444005)(99286004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3788;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H/EvwJngq/q3fVk1xgXvpTfc9GKC8lxWLwOvet5Uh840wAvklG7LkeSdjwxfhxpTD+iu0yil8GNsWzIWcsPj7NzDS2cUhXQWPC1e7vmb8el76QvaJvY55rKUac2nlYz41pKikXN6nnvNEf7f1WGdscQI6osHaLj0d9siGBJgJ913u2ySLRTfkeatn7SyhoGA0B7gtCCaCm4DlzcIWvM/RHGtSTQOXPY8U03hE0/pGrt1XQ1zj2KabjT/qUcWwKvmuSZ2JldAAysngqZ33bSLUr40NC5pAe6WQN5TICA32DSuYs8WgNhJeQYa6eqs4O2FbcHaceIUwcPpOEK4s4H6Lk0DNQtWduCRyNBpwZPlFarnkluB7XM1qzyAko2QEIBEeF+5m08+/xQAFKiSsr3ctf5zYjXZ0BBnd4fvf7itQjc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a802f8ce-735a-4314-dc5e-08d6d9c5912f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 06:13:09.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXBkYXRlcyBIVyB1cC1zYW1wbGluZyBtZXRob2QgYWNjb3JkaW5nIHRvIHRoZSBmb3JtYXQgdHlw
ZS4NCg0KU2lnbmVkLW9mZi1ieTogTG93cnkgTGkgKEFybSBUZWNobm9sb2d5IENoaW5hKSA8bG93
cnkubGlAYXJtLmNvbT4NCi0tLQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEv
ZDcxX2NvbXBvbmVudC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCAyOSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJt
L2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFfY29tcG9uZW50LmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJt
L2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFfY29tcG9uZW50LmMNCmluZGV4IGY4ODQ2YzYuLmRmYzcw
ZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2Q3MS9k
NzFfY29tcG9uZW50LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEv
ZDcxL2Q3MV9jb21wb25lbnQuYw0KQEAgLTIxMiw2ICsyMTIsMzUgQEAgc3RhdGljIHZvaWQgZDcx
X2xheWVyX3VwZGF0ZShzdHJ1Y3Qga29tZWRhX2NvbXBvbmVudCAqYywNCiAJCW1hbGlkcF93cml0
ZTMyKHJlZywgQkxLX1AxX1BUUl9ISUdILCB1cHBlcl8zMl9iaXRzKGFkZHIpKTsNCiAJfQ0KIA0K
KwlpZiAoZmItPmZvcm1hdC0+aXNfeXV2KSB7DQorCQl1MzIgdXBzYW1wbGluZyA9IDA7DQorDQor
CQlzd2l0Y2ggKGtmYi0+Zm9ybWF0X2NhcHMtPmZvdXJjYykgew0KKwkJY2FzZSBEUk1fRk9STUFU
X1lVWVY6DQorCQkJdXBzYW1wbGluZyA9IGZiLT5tb2RpZmllciA/IExSX0NISTQyMl9CSUxJTkVB
UiA6DQorCQkJCSAgICAgTFJfQ0hJNDIyX1JFUExJQ0FUSU9OOw0KKwkJCWJyZWFrOw0KKwkJY2Fz
ZSBEUk1fRk9STUFUX1VZVlk6DQorCQkJdXBzYW1wbGluZyA9IExSX0NISTQyMl9SRVBMSUNBVElP
TjsNCisJCQlicmVhazsNCisJCWNhc2UgRFJNX0ZPUk1BVF9OVjEyOg0KKwkJY2FzZSBEUk1fRk9S
TUFUX1lVVjQyMF84QklUOg0KKwkJY2FzZSBEUk1fRk9STUFUX1lVVjQyMF8xMEJJVDoNCisJCWNh
c2UgRFJNX0ZPUk1BVF9ZVVY0MjA6DQorCQljYXNlIERSTV9GT1JNQVRfUDAxMDoNCisJCS8qIHRo
ZXNlIGZtdCBzdXBwb3J0IE1QR0UvSlBFRyBib3RoLCBoZXJlIHBlcmZlciBKUEVHKi8NCisJCQl1
cHNhbXBsaW5nID0gTFJfQ0hJNDIwX0pQRUc7DQorCQkJYnJlYWs7DQorCQljYXNlIERSTV9GT1JN
QVRfWDBMMjoNCisJCQl1cHNhbXBsaW5nID0gTFJfQ0hJNDIwX0pQRUc7DQorCQkJYnJlYWs7DQor
CQlkZWZhdWx0Og0KKwkJCWJyZWFrOw0KKwkJfQ0KKw0KKwkJbWFsaWRwX3dyaXRlMzIocmVnLCBM
QVlFUl9SX0NPTlRST0wsIHVwc2FtcGxpbmcpOw0KKwl9DQorDQogCW1hbGlkcF93cml0ZTMyKHJl
ZywgTEFZRVJfRk1ULCBrZmItPmZvcm1hdF9jYXBzLT5od19pZCk7DQogCW1hbGlkcF93cml0ZTMy
KHJlZywgQkxLX0lOX1NJWkUsIEhWX1NJWkUoc3QtPmhzaXplLCBzdC0+dnNpemUpKTsNCiANCi0t
IA0KMS45LjENCg0K
