Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41930C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AER/bTPn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VQMQE2cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfDYIii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:38:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63209 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfDYIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556181515; x=1587717515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qWrl5iluoHriyffRoGf9OGiYcTMqaJKbW95CDI7FhBc=;
  b=AER/bTPngljpCJXBi8c75VxzDG0bg1jgVeQhouKsSn9+f+tBCfKl0MMR
   EPHvywcHtXQqoS7RmZzm5dG2dbV54tYRaDC6fGEQwb8x7lfO87th/N5pD
   cSXYBcTdId6wOuqS7ZIGswhq5/B4JhaC+ZbyVWQ38QXPLZFTF9MyDnRHm
   0eLkNqB6QPTf7pPKMZ1VYiCnJaSkNoiNTkmnqo9SRudMgPvlk4H/tIp+r
   gmHFXqzvHtGmCK4xChy8iJ4Qiv3Gym5nuhNnZUTtrog61SVRu5ayZTVPX
   iaeLZFDKvml7c1scmUzqv5JLHdoFqDbdQjhiDXBMfy4K7V366Iosoo7u9
   A==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="106780573"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:38:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWrl5iluoHriyffRoGf9OGiYcTMqaJKbW95CDI7FhBc=;
 b=VQMQE2cb/JnMGmI7ZF/nytSReL1Rq5YKSKJGtjg0dFd4h9pZR3OtsAGl8oHpoQm62qbx6ofhrF7MuLaExkDquIArIXKj/bUHhgHoMed5ylJEmfDatitANOvudKYg+0NopSazCXgy6vkAjytmmkXdvq9UfoJUo9QmufdwXz8LGQs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5485.namprd04.prod.outlook.com (20.178.248.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 08:38:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:38:31 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v6 1/3] RISC-V: Use tabs to align macro values in asm/csr.h
Thread-Topic: [PATCH v6 1/3] RISC-V: Use tabs to align macro values in
 asm/csr.h
Thread-Index: AQHU+0JCFWfNFu2mTUG+uCuJd9l6jg==
Date:   Thu, 25 Apr 2019 08:38:30 +0000
Message-ID: <20190425083804.11991-2-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 8d06a88e-893a-49fb-5646-08d6c9596502
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5485;
x-ms-traffictypediagnostic: MN2PR04MB5485:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB54857DD676AC8B199E3674208D3D0@MN2PR04MB5485.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(76176011)(66446008)(14444005)(186003)(6506007)(86362001)(14454004)(25786009)(44832011)(11346002)(6116002)(486006)(476003)(64756008)(386003)(3846002)(2171002)(66476007)(66556008)(316002)(5660300002)(54906003)(446003)(68736007)(256004)(102836004)(2906002)(52116002)(2616005)(110136005)(26005)(66946007)(53936002)(1076003)(4326008)(73956011)(6512007)(71190400001)(8936002)(36756003)(99286004)(81166006)(6486002)(66066001)(8676002)(6436002)(71200400001)(305945005)(72206003)(97736004)(7736002)(478600001)(50226002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5485;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I2VXiQuSsQAcecLsxy3jS7cmvO46gnhzK8Pm6PGp5swsklGeUHrSxzWkbSWAnwLO0+pRp6UuWBVtSScOJReTEr9dSAM4y9mwqm6mzjoH3Ng+04NdjBel2B7RI7e+tIBXbBo7NSAIA4WEyvImFjQcn+PmSBeKJ4LkgGcv/PUKC2r8mkkPFcLt3C02De1ZCcNBZmZyOcXAf4Xagclc6wAugSjvXPd2UxW4rFPMdwxxjdw6lTcvBFPCieux6+6BDFh3Pyi1CyKBUe/nnV7gCG2j+PuxZ5VUQ2ntNs63NKxyn3456qTal1z3E8GqZ8ZpUeby0UOgpP1c6yT4KmeqqJU088KR5dgepoAuloi7fJ7FnCGsX1sSDd2yvl9Xn620rwMHghXRA6OA6SbrdkFhzj5/QlHCqS8cLvCejr9N3IQrsT8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d06a88e-893a-49fb-5646-08d6c9596502
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:38:30.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHNwYWNpbmcgYmV0d2VlbiBtYWNybyBuYW1lIGFuZCB2YWx1ZSBpcyBub3QgY29uc2lzdGVu
dCBpbg0KYXNtL2Nzci5oLiBUaGlzIHBhdGNoIGJlYXV0aWZpZXMgYXNtL2Nzci5oIGJ5IHVzaW5n
IHRhYnMgdG8gYWxpZ24NCm1hY3JvIHZhbHVlcyBpbnN0ZWFkIG9mIHNwYWNlcy4NCg0KU2lnbmVk
LW9mZi1ieTogQW51cCBQYXRlbCA8YW51cC5wYXRlbEB3ZGMuY29tPg0KUmV2aWV3ZWQtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KLS0tDQogYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9jc3IuaCB8IDc2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2Nzci5oDQppbmRleCAyOGEwZDFjYjM3NGMuLjJhZTU0YTczODZmMSAxMDA2NDQNCi0tLSBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmgNCisrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20v
Y3NyLmgNCkBAIC0xNyw1NCArMTcsNTQgQEANCiAjaW5jbHVkZSA8bGludXgvY29uc3QuaD4NCiAN
CiAvKiBTdGF0dXMgcmVnaXN0ZXIgZmxhZ3MgKi8NCi0jZGVmaW5lIFNSX1NJRQlfQUMoMHgwMDAw
MDAwMiwgVUwpIC8qIFN1cGVydmlzb3IgSW50ZXJydXB0IEVuYWJsZSAqLw0KLSNkZWZpbmUgU1Jf
U1BJRQlfQUMoMHgwMDAwMDAyMCwgVUwpIC8qIFByZXZpb3VzIFN1cGVydmlzb3IgSUUgKi8NCi0j
ZGVmaW5lIFNSX1NQUAlfQUMoMHgwMDAwMDEwMCwgVUwpIC8qIFByZXZpb3VzbHkgU3VwZXJ2aXNv
ciAqLw0KLSNkZWZpbmUgU1JfU1VNCV9BQygweDAwMDQwMDAwLCBVTCkgLyogU3VwZXJ2aXNvciBt
YXkgYWNjZXNzIFVzZXIgTWVtb3J5ICovDQotDQotI2RlZmluZSBTUl9GUyAgICAgICAgICAgX0FD
KDB4MDAwMDYwMDAsIFVMKSAvKiBGbG9hdGluZy1wb2ludCBTdGF0dXMgKi8NCi0jZGVmaW5lIFNS
X0ZTX09GRiAgICAgICBfQUMoMHgwMDAwMDAwMCwgVUwpDQotI2RlZmluZSBTUl9GU19JTklUSUFM
ICAgX0FDKDB4MDAwMDIwMDAsIFVMKQ0KLSNkZWZpbmUgU1JfRlNfQ0xFQU4gICAgIF9BQygweDAw
MDA0MDAwLCBVTCkNCi0jZGVmaW5lIFNSX0ZTX0RJUlRZICAgICBfQUMoMHgwMDAwNjAwMCwgVUwp
DQotDQotI2RlZmluZSBTUl9YUyAgICAgICAgICAgX0FDKDB4MDAwMTgwMDAsIFVMKSAvKiBFeHRl
bnNpb24gU3RhdHVzICovDQotI2RlZmluZSBTUl9YU19PRkYgICAgICAgX0FDKDB4MDAwMDAwMDAs
IFVMKQ0KLSNkZWZpbmUgU1JfWFNfSU5JVElBTCAgIF9BQygweDAwMDA4MDAwLCBVTCkNCi0jZGVm
aW5lIFNSX1hTX0NMRUFOICAgICBfQUMoMHgwMDAxMDAwMCwgVUwpDQotI2RlZmluZSBTUl9YU19E
SVJUWSAgICAgX0FDKDB4MDAwMTgwMDAsIFVMKQ0KKyNkZWZpbmUgU1JfU0lFCQlfQUMoMHgwMDAw
MDAwMiwgVUwpIC8qIFN1cGVydmlzb3IgSW50ZXJydXB0IEVuYWJsZSAqLw0KKyNkZWZpbmUgU1Jf
U1BJRQkJX0FDKDB4MDAwMDAwMjAsIFVMKSAvKiBQcmV2aW91cyBTdXBlcnZpc29yIElFICovDQor
I2RlZmluZSBTUl9TUFAJCV9BQygweDAwMDAwMTAwLCBVTCkgLyogUHJldmlvdXNseSBTdXBlcnZp
c29yICovDQorI2RlZmluZSBTUl9TVU0JCV9BQygweDAwMDQwMDAwLCBVTCkgLyogU3VwZXJ2aXNv
ciBVc2VyIE1lbW9yeSBBY2Nlc3MgKi8NCisNCisjZGVmaW5lIFNSX0ZTCQlfQUMoMHgwMDAwNjAw
MCwgVUwpIC8qIEZsb2F0aW5nLXBvaW50IFN0YXR1cyAqLw0KKyNkZWZpbmUgU1JfRlNfT0ZGCV9B
QygweDAwMDAwMDAwLCBVTCkNCisjZGVmaW5lIFNSX0ZTX0lOSVRJQUwJX0FDKDB4MDAwMDIwMDAs
IFVMKQ0KKyNkZWZpbmUgU1JfRlNfQ0xFQU4JX0FDKDB4MDAwMDQwMDAsIFVMKQ0KKyNkZWZpbmUg
U1JfRlNfRElSVFkJX0FDKDB4MDAwMDYwMDAsIFVMKQ0KKw0KKyNkZWZpbmUgU1JfWFMJCV9BQygw
eDAwMDE4MDAwLCBVTCkgLyogRXh0ZW5zaW9uIFN0YXR1cyAqLw0KKyNkZWZpbmUgU1JfWFNfT0ZG
CV9BQygweDAwMDAwMDAwLCBVTCkNCisjZGVmaW5lIFNSX1hTX0lOSVRJQUwJX0FDKDB4MDAwMDgw
MDAsIFVMKQ0KKyNkZWZpbmUgU1JfWFNfQ0xFQU4JX0FDKDB4MDAwMTAwMDAsIFVMKQ0KKyNkZWZp
bmUgU1JfWFNfRElSVFkJX0FDKDB4MDAwMTgwMDAsIFVMKQ0KIA0KICNpZm5kZWYgQ09ORklHXzY0
QklUDQotI2RlZmluZSBTUl9TRCAgIF9BQygweDgwMDAwMDAwLCBVTCkgLyogRlMvWFMgZGlydHkg
Ki8NCisjZGVmaW5lIFNSX1NECQlfQUMoMHg4MDAwMDAwMCwgVUwpIC8qIEZTL1hTIGRpcnR5ICov
DQogI2Vsc2UNCi0jZGVmaW5lIFNSX1NEICAgX0FDKDB4ODAwMDAwMDAwMDAwMDAwMCwgVUwpIC8q
IEZTL1hTIGRpcnR5ICovDQorI2RlZmluZSBTUl9TRAkJX0FDKDB4ODAwMDAwMDAwMDAwMDAwMCwg
VUwpIC8qIEZTL1hTIGRpcnR5ICovDQogI2VuZGlmDQogDQogLyogU0FUUCBmbGFncyAqLw0KLSNp
ZiBfX3Jpc2N2X3hsZW4gPT0gMzINCi0jZGVmaW5lIFNBVFBfUFBOICAgICBfQUMoMHgwMDNGRkZG
RiwgVUwpDQotI2RlZmluZSBTQVRQX01PREVfMzIgX0FDKDB4ODAwMDAwMDAsIFVMKQ0KLSNkZWZp
bmUgU0FUUF9NT0RFICAgIFNBVFBfTU9ERV8zMg0KKyNpZm5kZWYgQ09ORklHXzY0QklUDQorI2Rl
ZmluZSBTQVRQX1BQTglfQUMoMHgwMDNGRkZGRiwgVUwpDQorI2RlZmluZSBTQVRQX01PREVfMzIJ
X0FDKDB4ODAwMDAwMDAsIFVMKQ0KKyNkZWZpbmUgU0FUUF9NT0RFCVNBVFBfTU9ERV8zMg0KICNl
bHNlDQotI2RlZmluZSBTQVRQX1BQTiAgICAgX0FDKDB4MDAwMDBGRkZGRkZGRkZGRiwgVUwpDQot
I2RlZmluZSBTQVRQX01PREVfMzkgX0FDKDB4ODAwMDAwMDAwMDAwMDAwMCwgVUwpDQotI2RlZmlu
ZSBTQVRQX01PREUgICAgU0FUUF9NT0RFXzM5DQorI2RlZmluZSBTQVRQX1BQTglfQUMoMHgwMDAw
MEZGRkZGRkZGRkZGLCBVTCkNCisjZGVmaW5lIFNBVFBfTU9ERV8zOQlfQUMoMHg4MDAwMDAwMDAw
MDAwMDAwLCBVTCkNCisjZGVmaW5lIFNBVFBfTU9ERQlTQVRQX01PREVfMzkNCiAjZW5kaWYNCiAN
CiAvKiBJbnRlcnJ1cHQgRW5hYmxlIGFuZCBJbnRlcnJ1cHQgUGVuZGluZyBmbGFncyAqLw0KLSNk
ZWZpbmUgU0lFX1NTSUUgX0FDKDB4MDAwMDAwMDIsIFVMKSAvKiBTb2Z0d2FyZSBJbnRlcnJ1cHQg
RW5hYmxlICovDQotI2RlZmluZSBTSUVfU1RJRSBfQUMoMHgwMDAwMDAyMCwgVUwpIC8qIFRpbWVy
IEludGVycnVwdCBFbmFibGUgKi8NCi0jZGVmaW5lIFNJRV9TRUlFIF9BQygweDAwMDAwMjAwLCBV
TCkgLyogRXh0ZXJuYWwgSW50ZXJydXB0IEVuYWJsZSAqLw0KLQ0KLSNkZWZpbmUgRVhDX0lOU1Rf
TUlTQUxJR05FRCAgICAgMA0KLSNkZWZpbmUgRVhDX0lOU1RfQUNDRVNTICAgICAgICAgMQ0KLSNk
ZWZpbmUgRVhDX0JSRUFLUE9JTlQgICAgICAgICAgMw0KLSNkZWZpbmUgRVhDX0xPQURfQUNDRVNT
ICAgICAgICAgNQ0KLSNkZWZpbmUgRVhDX1NUT1JFX0FDQ0VTUyAgICAgICAgNw0KLSNkZWZpbmUg
RVhDX1NZU0NBTEwgICAgICAgICAgICAgOA0KLSNkZWZpbmUgRVhDX0lOU1RfUEFHRV9GQVVMVCAg
ICAgMTINCi0jZGVmaW5lIEVYQ19MT0FEX1BBR0VfRkFVTFQgICAgIDEzDQotI2RlZmluZSBFWENf
U1RPUkVfUEFHRV9GQVVMVCAgICAxNQ0KKyNkZWZpbmUgU0lFX1NTSUUJX0FDKDB4MDAwMDAwMDIs
IFVMKSAvKiBTb2Z0d2FyZSBJbnRlcnJ1cHQgRW5hYmxlICovDQorI2RlZmluZSBTSUVfU1RJRQlf
QUMoMHgwMDAwMDAyMCwgVUwpIC8qIFRpbWVyIEludGVycnVwdCBFbmFibGUgKi8NCisjZGVmaW5l
IFNJRV9TRUlFCV9BQygweDAwMDAwMjAwLCBVTCkgLyogRXh0ZXJuYWwgSW50ZXJydXB0IEVuYWJs
ZSAqLw0KKw0KKyNkZWZpbmUgRVhDX0lOU1RfTUlTQUxJR05FRAkwDQorI2RlZmluZSBFWENfSU5T
VF9BQ0NFU1MJCTENCisjZGVmaW5lIEVYQ19CUkVBS1BPSU5UCQkzDQorI2RlZmluZSBFWENfTE9B
RF9BQ0NFU1MJCTUNCisjZGVmaW5lIEVYQ19TVE9SRV9BQ0NFU1MJNw0KKyNkZWZpbmUgRVhDX1NZ
U0NBTEwJCTgNCisjZGVmaW5lIEVYQ19JTlNUX1BBR0VfRkFVTFQJMTINCisjZGVmaW5lIEVYQ19M
T0FEX1BBR0VfRkFVTFQJMTMNCisjZGVmaW5lIEVYQ19TVE9SRV9QQUdFX0ZBVUxUCTE1DQogDQog
I2lmbmRlZiBfX0FTU0VNQkxZX18NCiANCi0tIA0KMi4xNy4xDQoNCg==
