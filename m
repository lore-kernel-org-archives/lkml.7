Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0432BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A/enW6jO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cO7to09u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDOJh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:37:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53685 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555321045; x=1586857045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2IDNV3G824yMZZw1Lc5BZVkhjzk96LM19BohmWGDemA=;
  b=A/enW6jOu+UQxaUFam/rCkIKkVLZn8JZMxsbm53DWVVL1rt3TrSOXQ8G
   RbKe+S0RW0Fb4en5dDKQIEdJyt7k9KnLAN+BvND2EsSqqPuceZ1lHMLUT
   q5kM36BfM7TEk7XBnqnvADN/OIqPGU4PfdMJv/0co3AMY2ZCrAuza4B5i
   /S97dlgxDxquIJ2zt9ep1zKTZcheMoeB+v0frTeFK/t9N5z+6bNb+AZr+
   tcrAzFABlhf3mEJ4rbd1POE2eMJVmsM8aE1+hKWJ4GTbH+L54Z8Z25hlw
   vhz2eBJ3FSkjFOa35JqVAbLALBJDesRTGV2flLfdpO3ytctUYi0WUqK/h
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,353,1549900800"; 
   d="scan'208";a="105984906"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 17:37:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IDNV3G824yMZZw1Lc5BZVkhjzk96LM19BohmWGDemA=;
 b=cO7to09uPOemPOKEqNbvGDZgA4smDomzC7KuCOZdmF27IS9B/GUzZKv9US1VoAS55Dx3qQWuBPTRARmg2Kq0eVgwZKNPQI2Ow43ceCY0WKhgg3TQuwiKmwgwfQyGfKRRRYpPfPvs+ENlfkp8VZm2krmzkQ2y2UUVLKZjr/VJy0w=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5677.namprd04.prod.outlook.com (20.179.20.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 09:37:23 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 09:37:23 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Topic: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Index: AQHU827U4QwgrExo4UujjLmFmbLC7A==
Date:   Mon, 15 Apr 2019 09:37:23 +0000
Message-ID: <20190415093648.7525-3-anup.patel@wdc.com>
References: <20190415093648.7525-1-anup.patel@wdc.com>
In-Reply-To: <20190415093648.7525-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a3acff1-7af0-489a-ad76-08d6c185f653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5677;
x-ms-traffictypediagnostic: MN2PR04MB5677:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB567785C70F69949C4D28FB6B8D2B0@MN2PR04MB5677.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(4326008)(71200400001)(53936002)(71190400001)(26005)(476003)(86362001)(50226002)(186003)(5660300002)(54906003)(3846002)(6116002)(102836004)(97736004)(6512007)(2616005)(6486002)(316002)(105586002)(110136005)(36756003)(11346002)(486006)(6436002)(2171002)(6506007)(386003)(478600001)(44832011)(446003)(8936002)(8676002)(76176011)(68736007)(72206003)(81166006)(2906002)(7736002)(14444005)(256004)(99286004)(14454004)(25786009)(1076003)(52116002)(66066001)(305945005)(81156014)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5677;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i7yHhuKCLdco52OSqG5cBTCChXgih+/XLbb/pB7wioCiiqfZ2fDKZF0zdDVbfD2Y6re9CImqm0sTC5qDQDn3eF9DbV9Sp3nb8wvtSQu+PAI9nPdvt528k3gwQHQ8Y/3iwwdcVTIPbKSQrgt+hRmVdpW7Q+ETZmdfdQ5KEVeEjIXGDbro7N6dXYTYAzQsrfb0Cy9w0vB18DmTZY1LPjJ39l57+ljECZLS9CzJtgL4msSyxBH7WM2cfhniosDVPe6NNP5oB7ydNEwDh+cGWMH4dyfM0g957b2MweXHljkPB9vHCZcsvvleqA7v1QfLmJ4SG7yvT7viZGK6iXUrbUCJMt2PQT6kR/cQhxJNBned8vjSaKVewcSZLfZyfeptAaZ5JmVk3KuZkgRYVN426cOZHGVBBLACX4z0O+bK5bWBVF4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3acff1-7af0-489a-ad76-08d6c185f653
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 09:37:23.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5677
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
ICB8IDIzICsrKystLS0tLS0tLS0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vY3NyLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oDQppbmRleCAyYWU1
NGE3Mzg2ZjEuLmFiNDBhOTM2Y2IyZCAxMDA2NDQNCi0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vY3NyLmgNCisrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmgNCkBAIC01MSwxMCAr
NTEsMjIgQEANCiAjZGVmaW5lIFNBVFBfTU9ERQlTQVRQX01PREVfMzkNCiAjZW5kaWYNCiANCi0v
KiBJbnRlcnJ1cHQgRW5hYmxlIGFuZCBJbnRlcnJ1cHQgUGVuZGluZyBmbGFncyAqLw0KLSNkZWZp
bmUgU0lFX1NTSUUJX0FDKDB4MDAwMDAwMDIsIFVMKSAvKiBTb2Z0d2FyZSBJbnRlcnJ1cHQgRW5h
YmxlICovDQotI2RlZmluZSBTSUVfU1RJRQlfQUMoMHgwMDAwMDAyMCwgVUwpIC8qIFRpbWVyIElu
dGVycnVwdCBFbmFibGUgKi8NCi0jZGVmaW5lIFNJRV9TRUlFCV9BQygweDAwMDAwMjAwLCBVTCkg
LyogRXh0ZXJuYWwgSW50ZXJydXB0IEVuYWJsZSAqLw0KKy8qIFNDQVVTRSAqLw0KKyNpZmRlZiBD
T05GSUdfNjRCSVQNCisjZGVmaW5lIFNDQVVTRV9JUlFfRkxBRwkJX0FDKDB4ODAwMDAwMDAwMDAw
MDAwMCwgVUwpDQorI2Vsc2UNCisjZGVmaW5lIFNDQVVTRV9JUlFfRkxBRwkJX0FDKDB4ODAwMDAw
MDAsIFVMKQ0KKyNlbmRpZg0KKw0KKyNkZWZpbmUgSVJRX1VfU09GVAkJMA0KKyNkZWZpbmUgSVJR
X1NfU09GVAkJMQ0KKyNkZWZpbmUgSVJRX01fU09GVAkJMw0KKyNkZWZpbmUgSVJRX1VfVElNRVIJ
CTQNCisjZGVmaW5lIElSUV9TX1RJTUVSCQk1DQorI2RlZmluZSBJUlFfTV9USU1FUgkJNw0KKyNk
ZWZpbmUgSVJRX1VfRVhUCQk4DQorI2RlZmluZSBJUlFfU19FWFQJCTkNCisjZGVmaW5lIElSUV9N
X0VYVAkJMTENCiANCiAjZGVmaW5lIEVYQ19JTlNUX01JU0FMSUdORUQJMA0KICNkZWZpbmUgRVhD
X0lOU1RfQUNDRVNTCQkxDQpAQCAtNjYsNiArNzgsMTEgQEANCiAjZGVmaW5lIEVYQ19MT0FEX1BB
R0VfRkFVTFQJMTMNCiAjZGVmaW5lIEVYQ19TVE9SRV9QQUdFX0ZBVUxUCTE1DQogDQorLyogU0lF
IChJbnRlcnJ1cHQgRW5hYmxlKSBhbmQgU0lQIChJbnRlcnJ1cHQgUGVuZGluZykgZmxhZ3MgKi8N
CisjZGVmaW5lIFNJRV9TU0lFCQkoX0FDKDB4MSwgVUwpIDw8IElSUV9TX1NPRlQpDQorI2RlZmlu
ZSBTSUVfU1RJRQkJKF9BQygweDEsIFVMKSA8PCBJUlFfU19USU1FUikNCisjZGVmaW5lIFNJRV9T
RUlFCQkoX0FDKDB4MSwgVUwpIDw8IElSUV9TX0VYVCkNCisNCiAjaWZuZGVmIF9fQVNTRU1CTFlf
Xw0KIA0KICNkZWZpbmUgY3NyX3N3YXAoY3NyLCB2YWwpCQkJCQlcDQpkaWZmIC0tZ2l0IGEvYXJj
aC9yaXNjdi9rZXJuZWwvaXJxLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYw0KaW5kZXggNDhl
NmI3ZGI4M2ExLi42OGU1MDI1YjVhNTggMTAwNjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9p
cnEuYw0KKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMNCkBAIC0xMSwyMSArMTEsNiBAQA0K
ICNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPg0KICNpbmNsdWRlIDxhc20vc21wLmg+DQogDQot
LyoNCi0gKiBQb3NzaWJsZSBpbnRlcnJ1cHQgY2F1c2VzOg0KLSAqLw0KLSNkZWZpbmUgSU5URVJS
VVBUX0NBVVNFX1NPRlRXQVJFICAgIDENCi0jZGVmaW5lIElOVEVSUlVQVF9DQVVTRV9USU1FUiAg
ICAgICA1DQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfRVhURVJOQUwgICAgOQ0KLQ0KLS8qDQot
ICogVGhlIGhpZ2ggb3JkZXIgYml0IG9mIHRoZSB0cmFwIGNhdXNlIHJlZ2lzdGVyIGlzIGFsd2F5
cyBzZXQgZm9yDQotICogaW50ZXJydXB0cywgd2hpY2ggYWxsb3dzIHVzIHRvIGRpZmZlcmVudGlh
dGUgdGhlbSBmcm9tIGV4Y2VwdGlvbnMNCi0gKiBxdWlja2x5LiAgVGhlIElOVEVSUlVQVF9DQVVT
RV8qIG1hY3JvcyBkb24ndCBjb250YWluIHRoYXQgYml0LCBzbyB3ZQ0KLSAqIG5lZWQgdG8gbWFz
ayBpdCBvZmYuDQotICovDQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfRkxBRwkoMVVMIDw8IChf
X3Jpc2N2X3hsZW4gLSAxKSkNCi0NCiBpbnQgYXJjaF9zaG93X2ludGVycnVwdHMoc3RydWN0IHNl
cV9maWxlICpwLCBpbnQgcHJlYykNCiB7DQogCXNob3dfaXBpX3N0YXRzKHAsIHByZWMpOw0KQEAg
LTM3LDEyICsyMiwxMiBAQCBhc21saW5rYWdlIHZvaWQgX19pcnFfZW50cnkgZG9fSVJRKHN0cnVj
dCBwdF9yZWdzICpyZWdzKQ0KIAlzdHJ1Y3QgcHRfcmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3Jl
Z3MocmVncyk7DQogDQogCWlycV9lbnRlcigpOw0KLQlzd2l0Y2ggKHJlZ3MtPnNjYXVzZSAmIH5J
TlRFUlJVUFRfQ0FVU0VfRkxBRykgew0KLQljYXNlIElOVEVSUlVQVF9DQVVTRV9USU1FUjoNCisJ
c3dpdGNoIChyZWdzLT5zY2F1c2UgJiB+U0NBVVNFX0lSUV9GTEFHKSB7DQorCWNhc2UgSVJRX1Nf
VElNRVI6DQogCQlyaXNjdl90aW1lcl9pbnRlcnJ1cHQoKTsNCiAJCWJyZWFrOw0KICNpZmRlZiBD
T05GSUdfU01QDQotCWNhc2UgSU5URVJSVVBUX0NBVVNFX1NPRlRXQVJFOg0KKwljYXNlIElSUV9T
X1NPRlQ6DQogCQkvKg0KIAkJICogV2Ugb25seSB1c2Ugc29mdHdhcmUgaW50ZXJydXB0cyB0byBw
YXNzIElQSXMsIHNvIGlmIGEgbm9uLVNNUA0KIAkJICogc3lzdGVtIGdldHMgb25lLCB0aGVuIHdl
IGRvbid0IGtub3cgd2hhdCB0byBkby4NCkBAIC01MCw3ICszNSw3IEBAIGFzbWxpbmthZ2Ugdm9p
ZCBfX2lycV9lbnRyeSBkb19JUlEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQogCQlyaXNjdl9zb2Z0
d2FyZV9pbnRlcnJ1cHQoKTsNCiAJCWJyZWFrOw0KICNlbmRpZg0KLQljYXNlIElOVEVSUlVQVF9D
QVVTRV9FWFRFUk5BTDoNCisJY2FzZSBJUlFfU19FWFQ6DQogCQloYW5kbGVfYXJjaF9pcnEocmVn
cyk7DQogCQlicmVhazsNCiAJZGVmYXVsdDoNCi0tIA0KMi4xNy4xDQoNCg==
