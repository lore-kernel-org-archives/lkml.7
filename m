Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F17218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ioVysbrN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gN+DqDbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfDYIP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10009 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfDYIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556180124; x=1587716124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHyazrR/mXgchQNmPehjvYWM3E0V04hHpFHICrIiwEo=;
  b=ioVysbrNJo+J+6ePsNrXSDMUDoiNVXCdRGeKGDHZmjl3Pmfy2OlXYWDF
   LQ3nWPbRzvImrC1S9A/zh3bRcTRAJKehK3koW8RYOg1auxkESMIcXfSaK
   bziRRjTimbTa6AOHrHWQs8CqQILBKkb5R5zgRzXzD2LebvDUxIH5G90HG
   hBQhnALPK4Zwxh5QnYs1DENxb8OCyoDOZ52lIRPpovk6i4qSOSbMYfSSo
   ZzSN0g5VyJJTouM2CTFL8caxbgH7f66gzctqe4DvNpkfBTvNg0GcHnwGN
   8vftAP2muzkLVs8ZHWK4aC4qV0ayLLj7GXU2Ll8DzuPtMG4BLW9ePTEdv
   w==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="212623987"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:15:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHyazrR/mXgchQNmPehjvYWM3E0V04hHpFHICrIiwEo=;
 b=gN+DqDbcnaFHGYTdG26uV0u8YzmL0UPnDdEsxLfUQ5xhq502+tuoJsIWHPk3gk2Y9IbwmjUsMj5h7bb0YDjSIUaNuQ63mRbDqZqCJHiLJAWMRyiACVFiD7wpNP4vMySBBbSXY0Jx8+GpBjj4/+G3mFptPei+1IT1hJtLBi+67VU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6095.namprd04.prod.outlook.com (20.178.245.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 08:15:20 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:15:20 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v5 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Topic: [PATCH v5 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Index: AQHU+z8FXNaXzxAGQ0aUaZPYNDj8nw==
Date:   Thu, 25 Apr 2019 08:15:19 +0000
Message-ID: <20190425081445.929-3-anup.patel@wdc.com>
References: <20190425081445.929-1-anup.patel@wdc.com>
In-Reply-To: <20190425081445.929-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::33) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c595f784-f143-4d4e-d69a-08d6c9562808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6095;
x-ms-traffictypediagnostic: MN2PR04MB6095:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB60958613F9B2EE3DFE92DC628D3D0@MN2PR04MB6095.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(26005)(81156014)(54906003)(386003)(14444005)(7736002)(97736004)(2616005)(76176011)(6506007)(256004)(110136005)(478600001)(68736007)(6436002)(6486002)(446003)(316002)(71200400001)(71190400001)(14454004)(11346002)(25786009)(2171002)(476003)(102836004)(72206003)(8676002)(4326008)(486006)(81166006)(2906002)(50226002)(44832011)(36756003)(99286004)(186003)(3846002)(52116002)(73956011)(64756008)(1076003)(66556008)(66446008)(5660300002)(8936002)(66476007)(66946007)(6512007)(6116002)(86362001)(66066001)(53936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6095;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PWY+n+54p5lldnnjnWhs/hqsICyOn0VAG6RtvfErOcNbWyG9rKbHvSHgCiAOjKObdjMiX2SKvLEC8W1mgj1n4rvOWrZysZPss4qhZdYqftzI3hV535HATXfXUblU7dBc6ehE4Tia8ksI82l85mW7F3/Tsew0CFJR+FZthBm1BVfYn1ecLMFKGLyJUUBXtPCXbFWLL9KEodwEPUjH83JowhR9vgmOneXVuHmCVzhPqQQDwFHoKf9nWczBIi8+8G7RI/gFWCQeU0lH5VbMAIXSRMz95CYGKU9f4NwBCWOhw48BmzAHRWesR59FHZEjvOQ/Rzpew786SOKgUWqtRQdaFWyZ51Jr4wmvQ6KoJblrrZEEjwCuwYd46va612dnMNu5nsiHR6wSI5DR27OmVrKembPCyGzHMapV1rEXuWAl8ho=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c595f784-f143-4d4e-d69a-08d6c9562808
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:15:19.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFNDQVVTRSBpbnRlcnJ1cHQgZmxhZyBhbmQgU0NBVVNFIGludGVycnVw
dCByZWxhdGVkDQpkZWZpbmVzIHRvIGFzbS9jc3IuaC4gV2UgYWxzbyB1c2UgdGhlc2UgZGVmaW5l
cyBpbiBrZXJuZWwvaXJxLmMgYW5kDQpleHByZXNzIFNJRS9TSVAgZmxhZ3MgaW4tdGVybXMgb2Yg
U0NBVVNFIGludGVycnVwdCBjYXVzZXMuDQoNClNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFu
dXAucGF0ZWxAd2RjLmNvbT4NCi0tLQ0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggfCAy
MSArKysrKysrKysrKysrKysrKy0tLS0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYyAgICAgIHwg
IDggKysrKy0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oIGIvYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaA0KaW5kZXggMmFlNTRhNzM4NmYxLi5hODlhOWJmMmM3
ZjIgMTAwNjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oDQorKysgYi9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oDQpAQCAtNTEsMTAgKzUxLDE4IEBADQogI2RlZmluZSBT
QVRQX01PREUJU0FUUF9NT0RFXzM5DQogI2VuZGlmDQogDQotLyogSW50ZXJydXB0IEVuYWJsZSBh
bmQgSW50ZXJydXB0IFBlbmRpbmcgZmxhZ3MgKi8NCi0jZGVmaW5lIFNJRV9TU0lFCV9BQygweDAw
MDAwMDAyLCBVTCkgLyogU29mdHdhcmUgSW50ZXJydXB0IEVuYWJsZSAqLw0KLSNkZWZpbmUgU0lF
X1NUSUUJX0FDKDB4MDAwMDAwMjAsIFVMKSAvKiBUaW1lciBJbnRlcnJ1cHQgRW5hYmxlICovDQot
I2RlZmluZSBTSUVfU0VJRQlfQUMoMHgwMDAwMDIwMCwgVUwpIC8qIEV4dGVybmFsIEludGVycnVw
dCBFbmFibGUgKi8NCisvKiBTQ0FVU0UgKi8NCisjZGVmaW5lIFNDQVVTRV9JUlFfRkxBRwkJKF9B
QygxLCBVTCkgPDwgKF9fcmlzY3ZfeGxlbiAtIDEpKQ0KKw0KKyNkZWZpbmUgSVJRX1VfU09GVAkJ
MA0KKyNkZWZpbmUgSVJRX1NfU09GVAkJMQ0KKyNkZWZpbmUgSVJRX01fU09GVAkJMw0KKyNkZWZp
bmUgSVJRX1VfVElNRVIJCTQNCisjZGVmaW5lIElSUV9TX1RJTUVSCQk1DQorI2RlZmluZSBJUlFf
TV9USU1FUgkJNw0KKyNkZWZpbmUgSVJRX1VfRVhUCQk4DQorI2RlZmluZSBJUlFfU19FWFQJCTkN
CisjZGVmaW5lIElSUV9NX0VYVAkJMTENCiANCiAjZGVmaW5lIEVYQ19JTlNUX01JU0FMSUdORUQJ
MA0KICNkZWZpbmUgRVhDX0lOU1RfQUNDRVNTCQkxDQpAQCAtNjYsNiArNzQsMTEgQEANCiAjZGVm
aW5lIEVYQ19MT0FEX1BBR0VfRkFVTFQJMTMNCiAjZGVmaW5lIEVYQ19TVE9SRV9QQUdFX0ZBVUxU
CTE1DQogDQorLyogU0lFIChJbnRlcnJ1cHQgRW5hYmxlKSBhbmQgU0lQIChJbnRlcnJ1cHQgUGVu
ZGluZykgZmxhZ3MgKi8NCisjZGVmaW5lIFNJRV9TU0lFCQkoX0FDKDB4MSwgVUwpIDw8IElSUV9T
X1NPRlQpDQorI2RlZmluZSBTSUVfU1RJRQkJKF9BQygweDEsIFVMKSA8PCBJUlFfU19USU1FUikN
CisjZGVmaW5lIFNJRV9TRUlFCQkoX0FDKDB4MSwgVUwpIDw8IElSUV9TX0VYVCkNCisNCiAjaWZu
ZGVmIF9fQVNTRU1CTFlfXw0KIA0KICNkZWZpbmUgY3NyX3N3YXAoY3NyLCB2YWwpCQkJCQlcDQpk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9p
cnEuYw0KaW5kZXggNDhlNmI3ZGI4M2ExLi44YjdmZWI5NGFlYjggMTAwNjQ0DQotLS0gYS9hcmNo
L3Jpc2N2L2tlcm5lbC9pcnEuYw0KKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMNCkBAIC0x
NCw5ICsxNCw5IEBADQogLyoNCiAgKiBQb3NzaWJsZSBpbnRlcnJ1cHQgY2F1c2VzOg0KICAqLw0K
LSNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1NPRlRXQVJFICAgIDENCi0jZGVmaW5lIElOVEVSUlVQ
VF9DQVVTRV9USU1FUiAgICAgICA1DQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfRVhURVJOQUwg
ICAgOQ0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1NPRlRXQVJFCUlSUV9TX1NPRlQNCisjZGVm
aW5lIElOVEVSUlVQVF9DQVVTRV9USU1FUgkJSVJRX1NfVElNRVINCisjZGVmaW5lIElOVEVSUlVQ
VF9DQVVTRV9FWFRFUk5BTAlJUlFfU19FWFQNCiANCiAvKg0KICAqIFRoZSBoaWdoIG9yZGVyIGJp
dCBvZiB0aGUgdHJhcCBjYXVzZSByZWdpc3RlciBpcyBhbHdheXMgc2V0IGZvcg0KQEAgLTI0LDcg
KzI0LDcgQEANCiAgKiBxdWlja2x5LiAgVGhlIElOVEVSUlVQVF9DQVVTRV8qIG1hY3JvcyBkb24n
dCBjb250YWluIHRoYXQgYml0LCBzbyB3ZQ0KICAqIG5lZWQgdG8gbWFzayBpdCBvZmYuDQogICov
DQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfRkxBRwkoMVVMIDw8IChfX3Jpc2N2X3hsZW4gLSAx
KSkNCisjZGVmaW5lIElOVEVSUlVQVF9DQVVTRV9GTEFHCQlTQ0FVU0VfSVJRX0ZMQUcNCiANCiBp
bnQgYXJjaF9zaG93X2ludGVycnVwdHMoc3RydWN0IHNlcV9maWxlICpwLCBpbnQgcHJlYykNCiB7
DQotLSANCjIuMTcuMQ0KDQo=
