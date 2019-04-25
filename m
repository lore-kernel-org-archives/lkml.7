Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA161208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XfO04KzZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ae8QHlP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfDYIip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:38:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37585 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfDYIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556181522; x=1587717522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=on79Ts72rLyLoS1IcUncchvB0BZA1WoFMfG+UJpYe9M=;
  b=XfO04KzZUM5fkCQLXrf3H4Xx8oEfBQYwvMhyGjSIUYeM1ZzXXxuKQv+r
   OHBEJXtLhkbsLp3xhG84+MD5oaxHDoljnd8UaaxGOCpt1gVIGRez6N1iQ
   OLgqCUiMdgljDHSK1Nkv6JFmekEdoGk2Jr9FmYFqph1QVG+v+fI7ishxC
   6fP44nEuGJ8PDc41+j4IBDrwXjktBMiLePIdO9wAdCiwihMcFLeDEj8xH
   EJvdxqRMVcI/TVHxwj4lvBcX0rydy71S2llvEIkuCIeTNHUl+luxTsy4v
   mmlmidWyl/PZ3U/VncMziyL7jnaYmsp5mngRtxZhkUXujB9spsM5T5XFy
   A==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="111735591"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:38:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on79Ts72rLyLoS1IcUncchvB0BZA1WoFMfG+UJpYe9M=;
 b=Ae8QHlP85vO5IG0okd9otADJ2GLi4aH8SlxuVKm4hflG1S8n7ycsfoSlq7TGt32Z6dfw83cXp1UQsoyx7ei2Iljd57rSBRd/DqdR/KiNDBRieIlUo0pQ/1tn8zBHmtMTq2DDgenT0EsFKF/acUopQlKRN3/Nw+E/INWmnZQiJiM=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5485.namprd04.prod.outlook.com (20.178.248.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 08:38:37 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:38:37 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v6 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Topic: [PATCH v6 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/csr.h
Thread-Index: AQHU+0JGgHu5TmuBJkiSOInvWIqQgw==
Date:   Thu, 25 Apr 2019 08:38:37 +0000
Message-ID: <20190425083804.11991-3-anup.patel@wdc.com>
References: <20190425083804.11991-1-anup.patel@wdc.com>
In-Reply-To: <20190425083804.11991-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 33596b1e-cb06-4df7-2000-08d6c959691c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5485;
x-ms-traffictypediagnostic: MN2PR04MB5485:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5485B942FD4A7468999A24C38D3D0@MN2PR04MB5485.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(76176011)(66446008)(14444005)(186003)(6506007)(86362001)(14454004)(25786009)(44832011)(11346002)(6116002)(486006)(476003)(64756008)(386003)(3846002)(2171002)(66476007)(66556008)(316002)(5660300002)(54906003)(446003)(68736007)(256004)(102836004)(2906002)(52116002)(2616005)(110136005)(26005)(66946007)(53936002)(1076003)(4326008)(73956011)(6512007)(71190400001)(8936002)(36756003)(99286004)(81166006)(6486002)(66066001)(8676002)(6436002)(71200400001)(305945005)(72206003)(97736004)(7736002)(478600001)(50226002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5485;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c7mPEGbQm6F9W4Fid1QedlCn+A02tkDtMBXsGgQqNWHXibiSKU8eoaZ7zBEVQtmdGZZzc0O/haYri1DK5bRrhCRjvT3S8c7aBRoIy3pEXqsTKjhoddioX2/CcNtAKBpBg8gFzDFRHVQIjB6mJ187aD4tKhkWAXzq11UOH7AfKEn2Qrmr6bjCOL6p3JROo2HVcyLoJ7s20TvLKysoDw4SIAw9ys7vJmzPKp1vPlCH0nx2PJvbg5yCWHWvQUQ/YUjtea/msjXVqi/WiKxGY9oI/cSkEu6Fm3eY76BFNqQ+TZsUm5gUGuOhTimKduFi6WvhskwTthiQaxFPA6uiTF2hAmXUY40Lly0v740sIMA4NQL57FNshDkbbv2LxiyGaxn6xfEnzR3ozNWruosraoIlpC7sPscqLPw9Y7vbOMjUE2M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33596b1e-cb06-4df7-2000-08d6c959691c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:38:37.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5485
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
MTYgKysrKy0tLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nz
ci5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaA0KaW5kZXggMmFlNTRhNzM4NmYxLi5h
ODlhOWJmMmM3ZjIgMTAwNjQ0DQotLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oDQor
KysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oDQpAQCAtNTEsMTAgKzUxLDE4IEBADQog
I2RlZmluZSBTQVRQX01PREUJU0FUUF9NT0RFXzM5DQogI2VuZGlmDQogDQotLyogSW50ZXJydXB0
IEVuYWJsZSBhbmQgSW50ZXJydXB0IFBlbmRpbmcgZmxhZ3MgKi8NCi0jZGVmaW5lIFNJRV9TU0lF
CV9BQygweDAwMDAwMDAyLCBVTCkgLyogU29mdHdhcmUgSW50ZXJydXB0IEVuYWJsZSAqLw0KLSNk
ZWZpbmUgU0lFX1NUSUUJX0FDKDB4MDAwMDAwMjAsIFVMKSAvKiBUaW1lciBJbnRlcnJ1cHQgRW5h
YmxlICovDQotI2RlZmluZSBTSUVfU0VJRQlfQUMoMHgwMDAwMDIwMCwgVUwpIC8qIEV4dGVybmFs
IEludGVycnVwdCBFbmFibGUgKi8NCisvKiBTQ0FVU0UgKi8NCisjZGVmaW5lIFNDQVVTRV9JUlFf
RkxBRwkJKF9BQygxLCBVTCkgPDwgKF9fcmlzY3ZfeGxlbiAtIDEpKQ0KKw0KKyNkZWZpbmUgSVJR
X1VfU09GVAkJMA0KKyNkZWZpbmUgSVJRX1NfU09GVAkJMQ0KKyNkZWZpbmUgSVJRX01fU09GVAkJ
Mw0KKyNkZWZpbmUgSVJRX1VfVElNRVIJCTQNCisjZGVmaW5lIElSUV9TX1RJTUVSCQk1DQorI2Rl
ZmluZSBJUlFfTV9USU1FUgkJNw0KKyNkZWZpbmUgSVJRX1VfRVhUCQk4DQorI2RlZmluZSBJUlFf
U19FWFQJCTkNCisjZGVmaW5lIElSUV9NX0VYVAkJMTENCiANCiAjZGVmaW5lIEVYQ19JTlNUX01J
U0FMSUdORUQJMA0KICNkZWZpbmUgRVhDX0lOU1RfQUNDRVNTCQkxDQpAQCAtNjYsNiArNzQsMTEg
QEANCiAjZGVmaW5lIEVYQ19MT0FEX1BBR0VfRkFVTFQJMTMNCiAjZGVmaW5lIEVYQ19TVE9SRV9Q
QUdFX0ZBVUxUCTE1DQogDQorLyogU0lFIChJbnRlcnJ1cHQgRW5hYmxlKSBhbmQgU0lQIChJbnRl
cnJ1cHQgUGVuZGluZykgZmxhZ3MgKi8NCisjZGVmaW5lIFNJRV9TU0lFCQkoX0FDKDB4MSwgVUwp
IDw8IElSUV9TX1NPRlQpDQorI2RlZmluZSBTSUVfU1RJRQkJKF9BQygweDEsIFVMKSA8PCBJUlFf
U19USU1FUikNCisjZGVmaW5lIFNJRV9TRUlFCQkoX0FDKDB4MSwgVUwpIDw8IElSUV9TX0VYVCkN
CisNCiAjaWZuZGVmIF9fQVNTRU1CTFlfXw0KIA0KICNkZWZpbmUgY3NyX3N3YXAoY3NyLCB2YWwp
CQkJCQlcDQpkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMgYi9hcmNoL3Jpc2N2
L2tlcm5lbC9pcnEuYw0KaW5kZXggNDhlNmI3ZGI4M2ExLi5kNWZkMjM2OTI1NmMgMTAwNjQ0DQot
LS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYw0KKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvaXJx
LmMNCkBAIC0xNCwxNyArMTQsOSBAQA0KIC8qDQogICogUG9zc2libGUgaW50ZXJydXB0IGNhdXNl
czoNCiAgKi8NCi0jZGVmaW5lIElOVEVSUlVQVF9DQVVTRV9TT0ZUV0FSRSAgICAxDQotI2RlZmlu
ZSBJTlRFUlJVUFRfQ0FVU0VfVElNRVIgICAgICAgNQ0KLSNkZWZpbmUgSU5URVJSVVBUX0NBVVNF
X0VYVEVSTkFMICAgIDkNCi0NCi0vKg0KLSAqIFRoZSBoaWdoIG9yZGVyIGJpdCBvZiB0aGUgdHJh
cCBjYXVzZSByZWdpc3RlciBpcyBhbHdheXMgc2V0IGZvcg0KLSAqIGludGVycnVwdHMsIHdoaWNo
IGFsbG93cyB1cyB0byBkaWZmZXJlbnRpYXRlIHRoZW0gZnJvbSBleGNlcHRpb25zDQotICogcXVp
Y2tseS4gIFRoZSBJTlRFUlJVUFRfQ0FVU0VfKiBtYWNyb3MgZG9uJ3QgY29udGFpbiB0aGF0IGJp
dCwgc28gd2UNCi0gKiBuZWVkIHRvIG1hc2sgaXQgb2ZmLg0KLSAqLw0KLSNkZWZpbmUgSU5URVJS
VVBUX0NBVVNFX0ZMQUcJKDFVTCA8PCAoX19yaXNjdl94bGVuIC0gMSkpDQorI2RlZmluZSBJTlRF
UlJVUFRfQ0FVU0VfU09GVFdBUkUJSVJRX1NfU09GVA0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNF
X1RJTUVSCQlJUlFfU19USU1FUg0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX0VYVEVSTkFMCUlS
UV9TX0VYVA0KIA0KIGludCBhcmNoX3Nob3dfaW50ZXJydXB0cyhzdHJ1Y3Qgc2VxX2ZpbGUgKnAs
IGludCBwcmVjKQ0KIHsNCkBAIC0zNyw3ICsyOSw3IEBAIGFzbWxpbmthZ2Ugdm9pZCBfX2lycV9l
bnRyeSBkb19JUlEoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQogCXN0cnVjdCBwdF9yZWdzICpvbGRf
cmVncyA9IHNldF9pcnFfcmVncyhyZWdzKTsNCiANCiAJaXJxX2VudGVyKCk7DQotCXN3aXRjaCAo
cmVncy0+c2NhdXNlICYgfklOVEVSUlVQVF9DQVVTRV9GTEFHKSB7DQorCXN3aXRjaCAocmVncy0+
c2NhdXNlICYgflNDQVVTRV9JUlFfRkxBRykgew0KIAljYXNlIElOVEVSUlVQVF9DQVVTRV9USU1F
UjoNCiAJCXJpc2N2X3RpbWVyX2ludGVycnVwdCgpOw0KIAkJYnJlYWs7DQotLSANCjIuMTcuMQ0K
DQo=
