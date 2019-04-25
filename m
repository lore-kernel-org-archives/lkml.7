Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66440C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1982148D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b+eu9RzB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fTIInJTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfDYFuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:50:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26629 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388228AbfDYFux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556171452; x=1587707452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tXF0+Sgwo6f/hlvIo2DQ7O1Z1n6PVRbgXCBswBGwVLY=;
  b=b+eu9RzBD1aDQYjE1s+WIsjXvMBujkfFQ8gp7qg6EnXuGVmFeAojVkTn
   WltGUp1SuE6uW81kGLJoU1fiorejgLCjNDhCjVctYK1t5sE4uELM/AAhj
   imyyNOc3HpKm0+VuGOZE+JlOVymLJpku1inYtCe+/9qYvonZNtdN6V0vO
   2yocUrMVhBNb9+pg47BwjUI0C4wFv0vu0OkY5J1GJD6WBOHqDxBz99OMf
   uagdPEdf9XLjfv9PtHTe7pJqGoAjhnajMXqeFESRdnVj3VEf2ctzqNAch
   EirAcrubg7w5iLqprzYV+r+GNVlZhVQ8bNlbchxmD2H06Au0Cg7WXbZhK
   A==;
X-IronPort-AV: E=Sophos;i="5.60,392,1549900800"; 
   d="scan'208";a="111723191"
Received: from mail-by2nam05lp2053.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 13:50:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXF0+Sgwo6f/hlvIo2DQ7O1Z1n6PVRbgXCBswBGwVLY=;
 b=fTIInJTnNuYf65gIycpzXHrsN/1Np2+aZ7cIqXOEF+Zz1uDaTgp4Z0Vu3aumXVIRnLePcCmM3bYR4/b6N4BegglAEecIzEwZX6pDzjsFcgYUhVD8JPjdqS2i2U+QxNb3zyRRLpy7drt7+eCuaEpB7rJi9XeWYXv2pkUCoJqW4Cs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5552.namprd04.prod.outlook.com (20.178.247.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 05:50:50 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 05:50:50 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Topic: [PATCH v4 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Index: AQHU+yrWFZqJVy7gAUCSnXFDUgxCNQ==
Date:   Thu, 25 Apr 2019 05:50:49 +0000
Message-ID: <20190425055015.45487-3-anup.patel@wdc.com>
References: <20190425055015.45487-1-anup.patel@wdc.com>
In-Reply-To: <20190425055015.45487-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bbe0788-0df1-43a7-6d63-08d6c941f850
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5552;
x-ms-traffictypediagnostic: MN2PR04MB5552:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5552C6D35FA14464141DEEA48D3D0@MN2PR04MB5552.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(6486002)(1076003)(2616005)(476003)(76176011)(14444005)(486006)(50226002)(256004)(66066001)(7736002)(305945005)(73956011)(2906002)(72206003)(14454004)(446003)(478600001)(11346002)(6436002)(3846002)(6116002)(66476007)(316002)(64756008)(66446008)(66556008)(66946007)(54906003)(110136005)(6512007)(8676002)(6506007)(386003)(71200400001)(71190400001)(186003)(86362001)(4326008)(102836004)(68736007)(2171002)(5660300002)(81166006)(26005)(81156014)(53936002)(8936002)(97736004)(52116002)(25786009)(99286004)(44832011)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5552;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m4KHtMs97/UwCTuqwCLsQTsVDodeCDpfPrnwUfbzNalitpWhWcyjXhftZzCcp6tuhdg/byU1C6DadQo2RC8H88HtW6T24I559UhyEKCJJXc/P5Ckln555xqvZJqSI2vIPWuRSyO2SuyrN4IRUzqoxwyEeh7AfF1B1MEi9WRJ4FKw+GNLaK9WJXMP9NcrvYQE5IOdjaObUlAL7hcMn4IPGL4aezhVEqrMA/42FCrcHQAHAoWO+fNTtscN/b0Ya8s02OSnr8YusvApBVFsez3ib3A0bFk786x+zrlorGe6hCkc4cvAHD4bwFW/L0J24nlsGaNsvQCyBK4m5RFLiT6n93djm55ByeVzEfZEls3KcHQdpQVBeAbU4chlmEgZ/QsHgZBCGSeThBhHwvRVnaItVqLUuJiFmGqFfiNiEd9DCdI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbe0788-0df1-43a7-6d63-08d6c941f850
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 05:50:49.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFNDQVVTRSBpbnRlcnJ1cHQgZmxhZyBhbmQgU0NBVVNFIGludGVycnVw
dCByZWxhdGVkDQpkZWZpbmVzIHRvIGFzbS9jc3IuaC4gV2UgYWxzbyB1c2UgdGhlc2UgZGVmaW5l
cyBpbiBrZXJuZWwvaXJxLmMgYW5kDQpleHByZXNzIFNJRS9TSVAgZmxhZ3MgaW4tdGVybXMgb2Yg
U0NBVVNFIGludGVycnVwdCBjYXVzZXMuDQoNClNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFu
dXAucGF0ZWxAd2RjLmNvbT4NCi0tLQ0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggfCAy
NSArKysrKysrKysrKysrKysrKysrKystLS0tDQogYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMgICAg
ICB8ICA4ICsrKystLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaCBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmgNCmluZGV4IDJhZTU0YTczODZmMS4uYWI0MGE5
MzZjYjJkIDEwMDY0NA0KLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaA0KKysrIGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaA0KQEAgLTUxLDEwICs1MSwyMiBAQA0KICNkZWZp
bmUgU0FUUF9NT0RFCVNBVFBfTU9ERV8zOQ0KICNlbmRpZg0KIA0KLS8qIEludGVycnVwdCBFbmFi
bGUgYW5kIEludGVycnVwdCBQZW5kaW5nIGZsYWdzICovDQotI2RlZmluZSBTSUVfU1NJRQlfQUMo
MHgwMDAwMDAwMiwgVUwpIC8qIFNvZnR3YXJlIEludGVycnVwdCBFbmFibGUgKi8NCi0jZGVmaW5l
IFNJRV9TVElFCV9BQygweDAwMDAwMDIwLCBVTCkgLyogVGltZXIgSW50ZXJydXB0IEVuYWJsZSAq
Lw0KLSNkZWZpbmUgU0lFX1NFSUUJX0FDKDB4MDAwMDAyMDAsIFVMKSAvKiBFeHRlcm5hbCBJbnRl
cnJ1cHQgRW5hYmxlICovDQorLyogU0NBVVNFICovDQorI2lmZGVmIENPTkZJR182NEJJVA0KKyNk
ZWZpbmUgU0NBVVNFX0lSUV9GTEFHCQlfQUMoMHg4MDAwMDAwMDAwMDAwMDAwLCBVTCkNCisjZWxz
ZQ0KKyNkZWZpbmUgU0NBVVNFX0lSUV9GTEFHCQlfQUMoMHg4MDAwMDAwMCwgVUwpDQorI2VuZGlm
DQorDQorI2RlZmluZSBJUlFfVV9TT0ZUCQkwDQorI2RlZmluZSBJUlFfU19TT0ZUCQkxDQorI2Rl
ZmluZSBJUlFfTV9TT0ZUCQkzDQorI2RlZmluZSBJUlFfVV9USU1FUgkJNA0KKyNkZWZpbmUgSVJR
X1NfVElNRVIJCTUNCisjZGVmaW5lIElSUV9NX1RJTUVSCQk3DQorI2RlZmluZSBJUlFfVV9FWFQJ
CTgNCisjZGVmaW5lIElSUV9TX0VYVAkJOQ0KKyNkZWZpbmUgSVJRX01fRVhUCQkxMQ0KIA0KICNk
ZWZpbmUgRVhDX0lOU1RfTUlTQUxJR05FRAkwDQogI2RlZmluZSBFWENfSU5TVF9BQ0NFU1MJCTEN
CkBAIC02Niw2ICs3OCwxMSBAQA0KICNkZWZpbmUgRVhDX0xPQURfUEFHRV9GQVVMVAkxMw0KICNk
ZWZpbmUgRVhDX1NUT1JFX1BBR0VfRkFVTFQJMTUNCiANCisvKiBTSUUgKEludGVycnVwdCBFbmFi
bGUpIGFuZCBTSVAgKEludGVycnVwdCBQZW5kaW5nKSBmbGFncyAqLw0KKyNkZWZpbmUgU0lFX1NT
SUUJCShfQUMoMHgxLCBVTCkgPDwgSVJRX1NfU09GVCkNCisjZGVmaW5lIFNJRV9TVElFCQkoX0FD
KDB4MSwgVUwpIDw8IElSUV9TX1RJTUVSKQ0KKyNkZWZpbmUgU0lFX1NFSUUJCShfQUMoMHgxLCBV
TCkgPDwgSVJRX1NfRVhUKQ0KKw0KICNpZm5kZWYgX19BU1NFTUJMWV9fDQogDQogI2RlZmluZSBj
c3Jfc3dhcChjc3IsIHZhbCkJCQkJCVwNCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9p
cnEuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2lycS5jDQppbmRleCA0OGU2YjdkYjgzYTEuLjhiN2Zl
Yjk0YWViOCAxMDA2NDQNCi0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2lycS5jDQorKysgYi9hcmNo
L3Jpc2N2L2tlcm5lbC9pcnEuYw0KQEAgLTE0LDkgKzE0LDkgQEANCiAvKg0KICAqIFBvc3NpYmxl
IGludGVycnVwdCBjYXVzZXM6DQogICovDQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfU09GVFdB
UkUgICAgMQ0KLSNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1RJTUVSICAgICAgIDUNCi0jZGVmaW5l
IElOVEVSUlVQVF9DQVVTRV9FWFRFUk5BTCAgICA5DQorI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0Vf
U09GVFdBUkUJSVJRX1NfU09GVA0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1RJTUVSCQlJUlFf
U19USU1FUg0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX0VYVEVSTkFMCUlSUV9TX0VYVA0KIA0K
IC8qDQogICogVGhlIGhpZ2ggb3JkZXIgYml0IG9mIHRoZSB0cmFwIGNhdXNlIHJlZ2lzdGVyIGlz
IGFsd2F5cyBzZXQgZm9yDQpAQCAtMjQsNyArMjQsNyBAQA0KICAqIHF1aWNrbHkuICBUaGUgSU5U
RVJSVVBUX0NBVVNFXyogbWFjcm9zIGRvbid0IGNvbnRhaW4gdGhhdCBiaXQsIHNvIHdlDQogICog
bmVlZCB0byBtYXNrIGl0IG9mZi4NCiAgKi8NCi0jZGVmaW5lIElOVEVSUlVQVF9DQVVTRV9GTEFH
CSgxVUwgPDwgKF9fcmlzY3ZfeGxlbiAtIDEpKQ0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX0ZM
QUcJCVNDQVVTRV9JUlFfRkxBRw0KIA0KIGludCBhcmNoX3Nob3dfaW50ZXJydXB0cyhzdHJ1Y3Qg
c2VxX2ZpbGUgKnAsIGludCBwcmVjKQ0KIHsNCi0tIA0KMi4xNy4xDQoNCg==
