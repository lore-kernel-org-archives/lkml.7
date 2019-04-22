Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC22075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHtigWxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfDVI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:27:08 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:46981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfDVI1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvml2fYmIgVu5k2mrB7Mpk8WBYn0f6b0hcxJxycXrgU=;
 b=AHtigWxk6tw0YFIEv7z+/l+OSemfnGH7dy2rv+ePi4/pyykzEDBlcWgiArYuSb78NoggrhuJe/gnzlCqDjB8HyKHr8/SOOImsF4RVoYnZPC08aNLpWjhN4RV6QVfo/8njGiAmGrWUyupu/eGjkZvJQjCQDfh4VpvD6HnnKKgwGo=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5583.eurprd04.prod.outlook.com (20.178.123.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 08:26:58 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:26:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] scripts/gdb: Add $lx_clk_core_lookup function
Thread-Topic: [PATCH 3/3] scripts/gdb: Add $lx_clk_core_lookup function
Thread-Index: AQHU+OUmSMastDjNC0mx+PohUrHy2g==
Date:   Mon, 22 Apr 2019 08:26:57 +0000
Message-ID: <ebda22b2d3f7e35db5809bf21f4f9ee3ac38f5d9.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1555921081.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.146.100.6]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c2161d-b8e4-4e16-50bc-08d6c6fc48c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5583;
x-ms-traffictypediagnostic: VI1PR04MB5583:
x-microsoft-antispam-prvs: <VI1PR04MB5583553B111B4EA7C1C89023EE220@VI1PR04MB5583.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(68736007)(305945005)(99286004)(6512007)(2906002)(54906003)(316002)(110136005)(52116002)(76176011)(53936002)(7736002)(97736004)(36756003)(386003)(6506007)(102836004)(26005)(66446008)(64756008)(6116002)(8676002)(186003)(71190400001)(71200400001)(66476007)(81166006)(81156014)(86362001)(66556008)(2616005)(4326008)(486006)(66946007)(5660300002)(476003)(73956011)(11346002)(25786009)(44832011)(8936002)(50226002)(118296001)(3846002)(6486002)(256004)(14444005)(6436002)(14454004)(478600001)(446003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5583;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dE2IsLtXWrO1ozqZZ0EJ9XzeJ/Y1pbQdpFXywfLYHyCGohEvI90cG4JD/53y2grAjcBburzLKkXidOeJvVHJ3hoW+6bzJ+Iu7kuxvq2cLmZx4ZW7L36NKUJQFfsC+14vvwjgQRdLq/baeYZIYzUCZ9zX+7MOArmt2iGC6ZVOCHMPLL2Qo7iMwqaVhaMuY4ggKhNgi0ljASzOoNk/fRcJ7imi6Y1WzJDIrExXzFMJcgfZy2baShe120ijD5ILF02E9SuRoGBx+4z6JeNxFGqAgmHFqUCbU44k+ReH3yAmGHMXZ89RCBxdWhw9n0Kkfsh23Mcgxjthpd+Ew+WxNUE5Yq41GcI+4r2K7AJ3rwWpc9LylB/+MWsQBRi0oFwvQE61QmZI5Wb2AQfeOtOYc4Y1TD3dYnaV8BIaeb/fpjpytY4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c2161d-b8e4-4e16-50bc-08d6c6fc48c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:26:57.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmluZGluZyBhbiBpbmRpdmlkdWFsIGNsa19jb3JlIHJlcXVpcmVzIHdhbGtpbmcgdGhlIHRyZWUg
d2hpY2ggY2FuIGJlDQpxdWl0ZSBjb21wbGljYXRlZCBzbyBhZGQgYSBoZWxwZXIgZm9yIGVhc3kg
YWNjZXNzLg0KDQooZ2RiKSBwcmludCAqKHN0cnVjdCBjbGtfc2N1KikkbHhfY2xrX2NvcmVfbG9v
a3VwKCJ1YXJ0MF9jbGsiKS0+aHcNCg0KU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxs
ZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCi0tLQ0KIHNjcmlwdHMvZ2RiL2xpbnV4L2Nsay5weSB8
IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2RiL2xpbnV4L2Nsay5weSBiL3NjcmlwdHMv
Z2RiL2xpbnV4L2Nsay5weQ0KaW5kZXggYTkxMjlkODY1YzVkLi42YmY3MTk3NmI1NWQgMTAwNjQ0
DQotLS0gYS9zY3JpcHRzL2dkYi9saW51eC9jbGsucHkNCisrKyBiL3NjcmlwdHMvZ2RiL2xpbnV4
L2Nsay5weQ0KQEAgLTQyLDUgKzQyLDI4IEBAIGNsYXNzIEx4Q2xrU3VtbWFyeShnZGIuQ29tbWFu
ZCk6DQogICAgICAgICBmb3IgY2xrIGluIGNsa19jb3JlX2Zvcl9lYWNoX2NoaWxkKGdkYi5wYXJz
ZV9hbmRfZXZhbCgiY2xrX29ycGhhbl9saXN0IikpOg0KICAgICAgICAgICAgIHNlbGYuc2hvd19z
dWJ0cmVlKGNsaywgMCkNCiANCiANCiBMeENsa1N1bW1hcnkoKQ0KKw0KKw0KK2NsYXNzIEx4Q2xr
Q29yZUxvb2t1cChnZGIuRnVuY3Rpb24pOg0KKyAgICAiIiJGaW5kIHN0cnVjdCBjbGtfY29yZSBi
eSBuYW1lIiIiDQorDQorICAgIGRlZiBfX2luaXRfXyhzZWxmKToNCisgICAgICAgIHN1cGVyKEx4
Q2xrQ29yZUxvb2t1cCwgc2VsZikuX19pbml0X18oImx4X2Nsa19jb3JlX2xvb2t1cCIpDQorDQor
ICAgIGRlZiBsb29rdXBfaGxpc3Qoc2VsZiwgaGxpc3RfaGVhZCwgbmFtZSk6DQorICAgICAgICBm
b3IgY2hpbGQgaW4gY2xrX2NvcmVfZm9yX2VhY2hfY2hpbGQoaGxpc3RfaGVhZCk6DQorICAgICAg
ICAgICAgaWYgY2hpbGRbJ25hbWUnXS5zdHJpbmcoKSA9PSBuYW1lOg0KKyAgICAgICAgICAgICAg
ICByZXR1cm4gY2hpbGQNCisgICAgICAgICAgICByZXN1bHQgPSBzZWxmLmxvb2t1cF9obGlzdChj
aGlsZFsnY2hpbGRyZW4nXSwgbmFtZSkNCisgICAgICAgICAgICBpZiByZXN1bHQ6DQorICAgICAg
ICAgICAgICAgIHJldHVybiByZXN1bHQNCisNCisgICAgZGVmIGludm9rZShzZWxmLCBuYW1lKToN
CisgICAgICAgIG5hbWUgPSBuYW1lLnN0cmluZygpDQorICAgICAgICByZXR1cm4gKHNlbGYubG9v
a3VwX2hsaXN0KGdkYi5wYXJzZV9hbmRfZXZhbCgiY2xrX3Jvb3RfbGlzdCIpLCBuYW1lKSBvcg0K
KyAgICAgICAgICAgICAgICBzZWxmLmxvb2t1cF9obGlzdChnZGIucGFyc2VfYW5kX2V2YWwoImNs
a19vcnBoYW5fbGlzdCIpLCBuYW1lKSkNCisNCisNCitMeENsa0NvcmVMb29rdXAoKQ0KLS0gDQoy
LjE3LjENCg0K
