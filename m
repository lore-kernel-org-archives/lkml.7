Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7413C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A421841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FsjE4B2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDKIhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:37:50 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:31182
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbfDKIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDxvfaARgehsciYenFq4dyEzSl/UsDYtP4x7fV1Ktcw=;
 b=FsjE4B2vbe5eMCHEN3kAgN4HWZg5foUu5S6HVx6gZsieOwd9Fm4hsRojqNNDxxlEAoENpik6vq3km2eyckmfHBxwVnjEOXdpnBKTAmQrzPVPQShuyoN0pj+pvBuzCuhfI4j1qm3lNGj4U1YKrvVPkOIfrNZF3KscBhFusU+7hac=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3563.eurprd08.prod.outlook.com (20.177.120.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Thu, 11 Apr 2019 08:37:43 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 08:37:43 +0000
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
Subject: [PATCH v2] drm/komeda: Creates plane alpha and blend mode properties
Thread-Topic: [PATCH v2] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHU8EHUCWV0F8LTFkmHStuQlYxQJg==
Date:   Thu, 11 Apr 2019 08:37:43 +0000
Message-ID: <1554971844-22101-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:203:2f::35) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e6cfda-d056-4ac5-31f5-08d6be58f711
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3563;
x-ms-traffictypediagnostic: DB7PR08MB3563:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB35638CBBB9FED81BF90202389F2F0@DB7PR08MB3563.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(71200400001)(71190400001)(110136005)(68736007)(52116002)(7736002)(186003)(26005)(81156014)(2501003)(2616005)(476003)(486006)(256004)(81166006)(8676002)(2201001)(5024004)(386003)(102836004)(8936002)(6506007)(50226002)(105586002)(106356001)(55236004)(2906002)(72206003)(3846002)(316002)(54906003)(4326008)(14454004)(86362001)(966005)(97736004)(6116002)(305945005)(5660300002)(53936002)(25786009)(66066001)(6486002)(6306002)(99286004)(6512007)(36756003)(6436002)(478600001)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3563;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Na9Vn5yL/jg5DkF2zZqMKvsl2O1WBFACFkEjm6KZlY67DsPc0elUU73T37yjOUXbxx3SIpQDi5kDqnEkhVufWVpda+10NxSD5NADzLonViS6f7iageP0suhPaFu/MRjgkiTITOx4dhPKIAgSQWgU7vWWV5CHjLBFYElcwL33EFkh5Cd5vRMYurFw+Ktj4hjV7nGcaj4iBkQTWoilT51KdXVOW1E2FKcnKOAYw12Ot3oOTmDHeODnevQTZOMPsnMG7ivm8vXnHzUKLVQIJGgSDumGZRvEJ+WL2+V24RCvm4zAspvAiNAWO1509n7bba26WOUsauyZ3ovO9IOVNGSCbKN6pHxXAA82WHFMgjIQZ1EKlxjZcJNzlZ82raVq4r45yR+3E0mwIvi7RgqAhObtNqEEUdBCZx1qq7cS4tqQl1A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e6cfda-d056-4ac5-31f5-08d6be58f711
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 08:37:43.6046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3JlYXRlcyBwbGFuZSBhbHBoYSBhbmQgYmxlbmQgbW9kZSBwcm9wZXJ0aWVzIGF0dGFjaGVkIHRv
IHBsYW5lLg0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb246DQotIGh0dHBzOi8vcGF0Y2h3b3JrLmZy
ZWVkZXNrdG9wLm9yZy9zZXJpZXMvNTQ0NDgvDQotIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNr
dG9wLm9yZy9zZXJpZXMvNTQ0NDkvDQotIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9y
Zy9zZXJpZXMvNTQ0NTAvDQoNCkNoYW5nZXMgc2luY2UgdjE6DQotIEFkZHMgcGF0Y2ggZGVucGVu
ZGVuY3kgaW4gdGhlIGNvbW1lbnQNCg0KU2lnbmVkLW9mZi1ieTogTG93cnkgTGkgKEFybSBUZWNo
bm9sb2d5IENoaW5hKSA8bG93cnkubGlAYXJtLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BsYW5lLmMgfCAxMSArKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGxhbmUuYw0KaW5kZXggNjhjZDJjOWUuLmFhZTVlODAg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9w
bGFuZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9w
bGFuZS5jDQpAQCAtMjIwLDYgKzIyMCwxNyBAQCBzdGF0aWMgaW50IGtvbWVkYV9wbGFuZV9hZGQo
c3RydWN0IGtvbWVkYV9rbXNfZGV2ICprbXMsDQogDQogCWRybV9wbGFuZV9oZWxwZXJfYWRkKHBs
YW5lLCAma29tZWRhX3BsYW5lX2hlbHBlcl9mdW5jcyk7DQogDQorCWVyciA9IGRybV9wbGFuZV9j
cmVhdGVfYWxwaGFfcHJvcGVydHkocGxhbmUpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBjbGVhbnVw
Ow0KKw0KKwllcnIgPSBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHkocGxhbmUs
DQorCQkJQklUKERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpIHwNCisJCQlCSVQoRFJNX01PREVf
QkxFTkRfUFJFTVVMVEkpICAgfA0KKwkJCUJJVChEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkpOw0K
KwlpZiAoZXJyKQ0KKwkJZ290byBjbGVhbnVwOw0KKw0KIAlyZXR1cm4gMDsNCiBjbGVhbnVwOg0K
IAlrb21lZGFfcGxhbmVfZGVzdHJveShwbGFuZSk7DQotLSANCjEuOS4xDQoNCg==
