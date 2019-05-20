Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE559C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5F1214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="B5h9DtN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbfETQjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:39:07 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:28806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392284AbfETQjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsV4xLsEHW847tDGXygNk+cSPrInu4leyKWVXDOc+Fo=;
 b=B5h9DtN0PCX0qCHa9QyUtjqxb7Z3wYUPmhXGRXwfuReHHIQxwCDzLOT1cKHX8C3l2+G+gX3iQAkj22zJ1iQUtWJaPZ2qTmXoocyh+26EnoFx+E4RxO1D6AnakUM9pwH9nIXm43k4CuppFWRl2iNHXeBMspbvKA7VfB1EH51tnr0=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 16:39:01 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 16:39:01 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] staging: vt6656: fix potential NULL pointer dereference
Thread-Topic: [PATCH 1/7] staging: vt6656: fix potential NULL pointer
 dereference
Thread-Index: AQHVDyqHVygu4rsUu0mODeKbe+LVHQ==
Date:   Mon, 20 May 2019 16:39:01 +0000
Message-ID: <20190520163844.1225-2-quentin.deslandes@itdev.co.uk>
References: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::14) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d0f3e4d-b471-4138-2db9-08d6dd41a991
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3662;
x-ms-traffictypediagnostic: VI1PR08MB3662:
x-microsoft-antispam-prvs: <VI1PR08MB36620232AB976B34DAF1905BB3060@VI1PR08MB3662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:308;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39830400003)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(1730700003)(2501003)(14454004)(73956011)(486006)(8936002)(44832011)(71190400001)(71200400001)(50226002)(81156014)(81166006)(4326008)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(53936002)(446003)(316002)(11346002)(476003)(2616005)(305945005)(6436002)(66066001)(508600001)(6486002)(7736002)(5640700003)(68736007)(25786009)(186003)(6512007)(14444005)(86362001)(256004)(6116002)(3846002)(1076003)(5660300002)(26005)(36756003)(76176011)(99286004)(6916009)(6506007)(386003)(52116002)(102836004)(2351001)(54906003)(4744005)(74482002)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3662;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cjMYmwPORsFIzvZtRvpa7uv+0Ahl2nfX2UAwRdU4jyH8PLvrOtj8Nf1YLjh3GnewBqYsQnNMiRb3P172PpAfcnG3yyeYY6Pw6aCW5ledIMkE99vUxanbKvUGMNQqNLOX4hDjrgof87IHrdw+TVjgDkkOmJGTODqFWPni6WV19ZTFuqWzTTYG0YHsV++3wHTAORjVOoGinxQxqWWmoUAuEe4hpT+DGtuDgKzdDWpT3QvyouC0p4gIxzxxqjV/PBsmWSQbVvAZSBTMGEfR5q+1WHPhCbHx0eTMqNVOihg50xiu4DIAcL4WR7E9WTXeoo0GNN+RI8M2ulgS9P4yHs0jgA5H6NvAP1aq1Dgn1hE9FDcW+3LdpmmSnudGfXjLQvNGC03lgVCDVV+nbJ6GGKUHGg3e7bI5qHiO93TPnAAMXuo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0f3e4d-b471-4138-2db9-08d6dd41a991
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 16:39:01.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm50X2ZyZWVfdHhfYnVmcygpIHJlbGllcyBvbiBwcml2LT50eF9jb250ZXh0IGVsZW1lbnRzIHRv
IGJlIE5VTEwgaWYNCnRoZXkgYXJlIG5vdCBpbml0aWFsaXplZCAoYXMgdm50X2ZyZWVfcnhfYnVm
cygpIGRvZXMpLiBBZGQgYSBjaGVjayB0bw0KdGhlc2UgZWxlbWVudHMgaW4gb3JkZXIgdG8gYXZv
aWQgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBRdWVudGluIERl
c2xhbmRlcyA8cXVlbnRpbi5kZXNsYW5kZXNAaXRkZXYuY28udWs+DQotLS0NCiBkcml2ZXJzL3N0
YWdpbmcvdnQ2NjU2L21haW5fdXNiLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2Iu
YyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KaW5kZXggY2NhZmNjMmM4N2Fj
Li5iZmU5NTJmZTI3YmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L21haW5f
dXNiLmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KQEAgLTM2Myw2
ICszNjMsOSBAQCBzdGF0aWMgdm9pZCB2bnRfZnJlZV90eF9idWZzKHN0cnVjdCB2bnRfcHJpdmF0
ZSAqcHJpdikNCiANCiAJZm9yIChpaSA9IDA7IGlpIDwgcHJpdi0+bnVtX3R4X2NvbnRleHQ7IGlp
KyspIHsNCiAJCXR4X2NvbnRleHQgPSBwcml2LT50eF9jb250ZXh0W2lpXTsNCisJCWlmICghdHhf
Y29udGV4dCkNCisJCQljb250aW51ZTsNCisNCiAJCS8qIGRlYWxsb2NhdGUgVVJCcyAqLw0KIAkJ
aWYgKHR4X2NvbnRleHQtPnVyYikgew0KIAkJCXVzYl9raWxsX3VyYih0eF9jb250ZXh0LT51cmIp
Ow0KLS0gDQoyLjE3LjENCg0K
