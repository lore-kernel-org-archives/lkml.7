Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1898C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5708D21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MBpMLoeS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NSbL/Idj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDEFtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:49:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59786 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEFti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554443377; x=1585979377;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jaFL673RBcYD0MxzbcKzRSHkARG80AZ4VElLTB5Jv00=;
  b=MBpMLoeShdlX7OBbaicwGyekY+qJIIWBiBRecypLxNPSMSk7mACMT2P7
   THqN7V4tonBtHx3KzYsS65HZTJV+7aLGyX0+v3Z7+eUlpumsmKvdl6pTt
   2XCErDk90Ke4xaNWI2FXjXbIGkiF3wxOrr0IHwuaknZa5FtRjpo03ieUK
   lyGNcG4aZUm0kiymgfI7Q5AcB/75qi85JDpTBIL3isniyA8o9Mk75Go/o
   M/svgsDOiKh1xoTw+jHQXBy0rsNr0qR507S3miY0mNOPEmwY657fniCTh
   7zWv+6drXc27Rlf/Kn9cNxjV1MttC+KsYrHCrG4gpqfORldnG6LmaUk+x
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,310,1549900800"; 
   d="scan'208";a="106421600"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2019 13:49:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaFL673RBcYD0MxzbcKzRSHkARG80AZ4VElLTB5Jv00=;
 b=NSbL/Idj8eDk7SXYR6YrWrfQRAviEir3Tn6Y1ZUek8oZ3Ikl/wiImn8A3Vq9Lf+SroFTf7BQzaK28IjPbb17dJsCGYH5g7CcAYngQEUBsQf5zdS7QAl511l5fEXZvgIhH8LvxMW7o1G/NL2eJtsaRP52MAJAgr72ThF89vWcLnc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6064.namprd04.prod.outlook.com (20.178.246.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 05:49:35 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 05:49:35 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit
 systems
Thread-Topic: [PATCH v3] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
Thread-Index: AQHU63NZIDKXRCAY5Uanum6fHV6nQA==
Date:   Fri, 5 Apr 2019 05:49:34 +0000
Message-ID: <20190405054909.3238-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::30)
 To MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae31c6b4-9078-4426-f505-08d6b98a7b4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB6064;
x-ms-traffictypediagnostic: MN2PR04MB6064:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6064F5BF3F480E260613F0118D510@MN2PR04MB6064.namprd04.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(14454004)(386003)(52116002)(305945005)(7736002)(256004)(6512007)(6506007)(186003)(25786009)(26005)(102836004)(36756003)(99286004)(53936002)(54906003)(110136005)(2171002)(4326008)(316002)(97736004)(1076003)(486006)(68736007)(86362001)(2616005)(106356001)(6116002)(3846002)(6436002)(2906002)(105586002)(476003)(66066001)(6486002)(5660300002)(8936002)(50226002)(71190400001)(81166006)(8676002)(81156014)(72206003)(478600001)(44832011)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6064;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gZ3E4Pc/WMeOtugxBDdIFYM0h3jcVYlQvtLPBshiKqrzJLn+Vtnsc/14hC59HqU9VJgzOMCxBFTs5E4fT/deM1vUIh2IW3O5KCBk2fAC7Rqlho6XX7J47aob/nzUSSqJyq1h7YY/cOCERttMpjnPuEnYFH24r2Lgz9EypaAFW5VbdLnxVpEjla4ccJ2aoOvO/ALMCbgOo+yO43QYhsBRkkxdMqrJ7YuaRVg+I01VKf6q4u/KClEApSYqaRb7H2Atznwu8gd07msM7lkYdGKOV72P3YrzxN2SVypdYk1JnzDL6IJiXzwVe3EcuqzC3OG82/qDOtcpCD6+jdn6xaZmDT8AW9EUHw6hsaCcLnne4gYvTOLyeYEvH/+xL0cVST6ikeCAFEfLdtBwfNmq5v55aWyzoRjOB92QFlTd9NciV54=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae31c6b4-9078-4426-f505-08d6b98a7b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 05:49:35.0248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIE1heGltdW0gUGh5c2ljYWwgTWVtb3J5IDJHaUIgb3B0aW9uIGZvciA2NGJpdCBzeXN0ZW1z
IGlzIGN1cnJlbnRseQ0KYnJva2VuIGJlY2F1c2Uga2VybmVsIGhhbmdzIGF0IGJvb3QtdGltZSB3
aGVuIHRoaXMgb3B0aW9uIGlzIGVuYWJsZWQNCmFuZCB0aGUgdW5kZXJseWluZyBzeXN0ZW0gaGFz
IG1vcmUgdGhhbiAyR2lCIG1lbW9yeS4NCg0KVGhpcyBpc3N1ZSBjYW4gYmUgZWFzaWx5IHJlcHJv
ZHVjZWQgb24gU2lGaXZlIFVubGVhc2hlZCBib2FyZCB3aGVyZQ0Kd2UgaGF2ZSA4R2lCIG9mIG1l
bW9yeS4NCg0KVGhpcyBwYXRjaCBmaXhlcyBhYm92ZSBpc3N1ZSBieSByZW1vdmluZyB1bnVzYWJs
ZSBtZW1vcnkgcmVnaW9uIGluDQpzZXR1cF9ib290bWVtKCkuDQoNClNpZ25lZC1vZmYtYnk6IEFu
dXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT4NClJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCi0tLQ0KQ2hhbmdlcyBzaW5jZSB2MjoNCi0gRHJvcCBicmFja2V0
cyBpbiBpZigpIGNvbmRpdGlvbiBhZGRlZCBieSB0aGlzIHBhdGNoDQpDaGFuZ2VzIHNpbmNlIHYx
Og0KLSBVc2UgbWVtYmxvY2tfcmVtb3ZlKCkgaW5zdGVhZCBvZiBtZW1ibG9ja19yZXNlcnZlKCkN
Ci0tLQ0KIGFyY2gvcmlzY3YvbW0vaW5pdC5jIHwgOCArKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vaW5pdC5jIGIv
YXJjaC9yaXNjdi9tbS9pbml0LmMNCmluZGV4IDVmZDhjOTIyZTFjMi4uYmM3Yjc3ZTM0ZDA5IDEw
MDY0NA0KLS0tIGEvYXJjaC9yaXNjdi9tbS9pbml0LmMNCisrKyBiL2FyY2gvcmlzY3YvbW0vaW5p
dC5jDQpAQCAtMTIxLDYgKzEyMSwxNCBAQCB2b2lkIF9faW5pdCBzZXR1cF9ib290bWVtKHZvaWQp
DQogCQkJICovDQogCQkJbWVtYmxvY2tfcmVzZXJ2ZShyZWctPmJhc2UsIHZtbGludXhfZW5kIC0g
cmVnLT5iYXNlKTsNCiAJCQltZW1fc2l6ZSA9IG1pbihyZWctPnNpemUsIChwaHlzX2FkZHJfdCkt
UEFHRV9PRkZTRVQpOw0KKw0KKwkJCS8qDQorCQkJICogUmVtb3ZlIG1lbWJsb2NrIGZyb20gdGhl
IGVuZCBvZiB1c2FibGUgYXJlYSB0byB0aGUNCisJCQkgKiBlbmQgb2YgcmVnaW9uDQorCQkJICov
DQorCQkJaWYgKHJlZy0+YmFzZSArIG1lbV9zaXplIDwgZW5kKQ0KKwkJCQltZW1ibG9ja19yZW1v
dmUocmVnLT5iYXNlICsgbWVtX3NpemUsDQorCQkJCQkJZW5kIC0gcmVnLT5iYXNlIC0gbWVtX3Np
emUpOw0KIAkJfQ0KIAl9DQogCUJVR19PTihtZW1fc2l6ZSA9PSAwKTsNCi0tDQoyLjE3LjENCg==
