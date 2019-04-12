Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFEC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78E720869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mj6R6On8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDLXeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:34:50 -0400
Received: from mail-eopbgr790132.outbound.protection.outlook.com ([40.107.79.132]:48841
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbfDLXeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:34:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=oZ7KQdSuZflgdmr+sRumsWLLyW5wsN6oid9BJLvWjbLU9wnHzMYo2v1TMIj6ZFOpA0Q9U20rXarYtws2OLBBFM9jMIZSJKh2yfpOqOM4UYly3uIOSHcd46o7s4hzCAAUcnd1A2qcgzdkR/8+GrRSRsNn4EiUNR0Cc3jUQ7gEfy7v4BdoBrg0sWA1o05S6LjGiN9e9ZdvTad3Lyph+JXM2r6S2Z2B85JstjqTd+LS0gMBkzT9imAgEgbDT/EZiSarOYJqu6qbOw3FpaLrAu8BBVvEk3mbFYcjied6dVndfBLVJwzw4caNyTHv/ZMYn8NYqNXvMuBMhdhnPUp5v/+sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqa4BWHjVjX4q1TPM/sqmjAoOZ+uEGd0jjTCa8lYrEc=;
 b=KfiQ/RWbFzRffCX3MuCe2VD0PF/ik0kKMC/SSePHMEIipHfzVwSgTWcbwuHlUPJYN/Z2NO47VtKsXtQE8IA/ZHCLUrG85dNixxGRR1nu5QZAnaoQn0Lhy3xBFZ5yMVyAirHw8w4VB8ClJrpnrZSOEdaE+wB7NH4Atm424mthyFM7o9UVn32tMh9DvVD5H2C5tLTdYBGPIeVWkAZOQg1t9TplEcKDqvqh2d2GbWRT+H8/dUwJG89o0csVzLt2aOSVI1OINB22H5flzKyLVdtY61mfDcavVc8YPRNxjk8PeuboV9scNUYEYae6SeOvDcufZ9pBweJ9a5QNWjkRJA4CRA==
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqa4BWHjVjX4q1TPM/sqmjAoOZ+uEGd0jjTCa8lYrEc=;
 b=Mj6R6On8OHCUQbuHraZ1wwEi9nGN2iWusTLZh1WOvgtfZbXUbRTZCefEn3Bh5SE0kaI9IOrTwPvioiReTSLj8RgcvvI9/rk9bCH0qK5WGYim0xMDq16BmdSu7mR920QWkJUIRktUNi4ubROE4zVZGrW60CYCZ81QlDgSCIvBzlA=
Received: from MW2PR2101MB0937.namprd21.prod.outlook.com (52.132.146.10) by
 MW2PR2101MB0907.namprd21.prod.outlook.com (52.132.152.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.0; Fri, 12 Apr 2019 23:34:46 +0000
Received: from MW2PR2101MB0937.namprd21.prod.outlook.com
 ([fe80::14a3:1607:bd48:515b]) by MW2PR2101MB0937.namprd21.prod.outlook.com
 ([fe80::14a3:1607:bd48:515b%3]) with mapi id 15.20.1813.001; Fri, 12 Apr 2019
 23:34:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] vmbus: Remove the undesired put_cpu_ptr() in
 hv_synic_cleanup()
Thread-Topic: [PATCH] vmbus: Remove the undesired put_cpu_ptr() in
 hv_synic_cleanup()
Thread-Index: AQHU8YhPOJo/Dt+Ohk2Vxh0PedeQDQ==
Date:   Fri, 12 Apr 2019 23:34:45 +0000
Message-ID: <20190412233429.29146-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0087.namprd15.prod.outlook.com
 (2603:10b6:101:20::31) To MW2PR2101MB0937.namprd21.prod.outlook.com
 (2603:10b6:302:4::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [2001:4898:80e8:2:4bb:b561:d6cf:51ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda3d468-a988-4475-3487-08d6bf9f71b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0907;
x-ms-traffictypediagnostic: MW2PR2101MB0907:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0907DB6FEC7D610D1C2157B7BF280@MW2PR2101MB0907.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(52116002)(1076003)(6512007)(86612001)(4326008)(186003)(486006)(102836004)(386003)(6506007)(2906002)(4744005)(2501003)(36756003)(71200400001)(6116002)(476003)(2616005)(71190400001)(99286004)(53936002)(46003)(106356001)(256004)(5660300002)(25786009)(68736007)(478600001)(10290500003)(97736004)(81156014)(14444005)(14454004)(6486002)(2201001)(316002)(6636002)(54906003)(110136005)(105586002)(10090500001)(22452003)(86362001)(1511001)(50226002)(305945005)(8936002)(6436002)(81166006)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0907;H:MW2PR2101MB0937.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PF9N3Cb7OSUwK73ByxV0a2Izb8ObaSZAkqJPES21zcsJYMSn3D9bmj5FoItGAa3BTFQoN5CqelSGhm+oo/XE8dxP78Br7NGbeA5Tmec87Qr3Q3d2s3Tnlag2Wm8vaZxnS62iHrzqy//uZZoRggE2k3PEPQW7tjO5bYAfTxHFPMlZxkVLTNVImYClf/mudrP0cl6o4owQn2lOSW0znevTrCFZaKlxyQo0C2PhpH5YgLpa7HEG4DFSPeHu0gVicD+F6smlI9VnLwBmIOLfLs72GySHdhkBVbrA51rw2oz8gn8w8pUVEPyQLwDLmH6s2Ke602Bw8P79TK6Nh9QNIfYFVslw/xH2Q49UixuBYv+KKCblcTCl5qu64AY13gOmX44geX5CYYSu52c16Znzqqs2r8WHVJ6QQIm+R4XH4NVp9mM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda3d468-a988-4475-3487-08d6bf9f71b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 23:34:46.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBDT05GSUdfREVCVUdfUFJFRU1QVD15LCB0aGUgcHV0X2NwdV9wdHIoKSB0cmlnZ2llcnMg
YW4gdW5kZXJmbG93DQp3YXJuaW5nIGluIHByZWVtcHRfY291bnRfc3ViKCkuDQoNCkZpeGVzOiAz
N2NkZDk5MWZhYzggKCJ2bWJ1czogcHV0IHJlbGF0ZWQgcGVyLWNwdSB2YXJpYWJsZSB0b2dldGhl
ciIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KQ2M6IFN0ZXBoZW4gSGVtbWluZ2VyIDxz
dGhlbW1pbkBtaWNyb3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlA
bWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvaHYvaHYuYyB8IDEgLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L2h2LmMgYi9kcml2
ZXJzL2h2L2h2LmMNCmluZGV4IDYzMmQyNTY3NGU3Zi4uNDU2NTMwMjllZTE4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9odi9odi5jDQorKysgYi9kcml2ZXJzL2h2L2h2LmMNCkBAIC00MDgsNyArNDA4
LDYgQEAgaW50IGh2X3N5bmljX2NsZWFudXAodW5zaWduZWQgaW50IGNwdSkNCiANCiAJCWNsb2Nr
ZXZlbnRzX3VuYmluZF9kZXZpY2UoaHZfY3B1LT5jbGtfZXZ0LCBjcHUpOw0KIAkJaHZfY2Vfc2h1
dGRvd24oaHZfY3B1LT5jbGtfZXZ0KTsNCi0JCXB1dF9jcHVfcHRyKGh2X2NwdSk7DQogCX0NCiAN
CiAJaHZfZ2V0X3N5bmludF9zdGF0ZShWTUJVU19NRVNTQUdFX1NJTlQsIHNoYXJlZF9zaW50LmFz
X3VpbnQ2NCk7DQotLSANCjIuMTkuMQ0KDQo=
