Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A4AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D9D217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k0+aU7HJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F2vsYy7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfDYIPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61637 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556180119; x=1587716119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qWrl5iluoHriyffRoGf9OGiYcTMqaJKbW95CDI7FhBc=;
  b=k0+aU7HJawrGhm8quReliwERO/1N/MnX6TIDd5jQtg1MY/K3ue65PCSG
   kKB1b0+hRx7tcBROpyccPJd0faUksW6JP+UommBkl4yhTBV7rtlkUoF1u
   OALRi+t4JU55OIVbVFMLo4RHpcpMPe5Pz8cegCV5ReNWsQWBBe/NoT+x1
   HFBwPmBk6dRLNyIOGFbgK3I3E7J/rvI21BaLS5cXo2sk0dQP9FUb3Fpxr
   wCakvcU8G+p54SWUsoEklBtvznChA5pXmq1z5uMivnyKsly9eTMQ0W8ER
   3ozHrsJflkQzYGmY0tNPcnuqldazW/byU6O7jabUqzRLbjbMF6Gl6Uejz
   A==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="106779064"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:15:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWrl5iluoHriyffRoGf9OGiYcTMqaJKbW95CDI7FhBc=;
 b=F2vsYy7DQ7Jz6BO/RpYzBXdFjuWIgTss0kPwJN1I5NEfT095xA+018uOvMiRaNfjdpA6OfgDJVn0dGGQFMXC6/2HBFdSop8wa6D9MGACAIn2TE5DnlHnw+cVVMCn688weyqVvyDozyXwtan+oEMITV1BBq8Qf81ALH/XIkYI3gc=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6095.namprd04.prod.outlook.com (20.178.245.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 08:15:16 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:15:16 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v5 1/3] RISC-V: Use tabs to align macro values in asm/csr.h
Thread-Topic: [PATCH v5 1/3] RISC-V: Use tabs to align macro values in
 asm/csr.h
Thread-Index: AQHU+z8D2/7WVz74r0KPtl1y5u9b5w==
Date:   Thu, 25 Apr 2019 08:15:15 +0000
Message-ID: <20190425081445.929-2-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 0a17bb31-aa93-49c4-a877-08d6c956255f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6095;
x-ms-traffictypediagnostic: MN2PR04MB6095:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6095134C03E4E488D4DC81C08D3D0@MN2PR04MB6095.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(26005)(81156014)(54906003)(386003)(14444005)(7736002)(97736004)(2616005)(76176011)(6506007)(256004)(110136005)(478600001)(68736007)(6436002)(6486002)(446003)(316002)(71200400001)(71190400001)(14454004)(11346002)(25786009)(2171002)(476003)(102836004)(72206003)(8676002)(4326008)(486006)(81166006)(2906002)(50226002)(44832011)(36756003)(99286004)(186003)(3846002)(52116002)(73956011)(64756008)(1076003)(66556008)(66446008)(5660300002)(8936002)(66476007)(66946007)(6512007)(6116002)(86362001)(66066001)(53936002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6095;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sPNbZ5t2nUjaiZxMLlN/7XS1AiNe7XoH56AjR+C6yMqck/2MENfwsVl2MdfY4A37tSHohAI7fMn9g/Iq/UoHea10KEvCRMABweArfObeClT5yuEsB+c03hw+NQspNxR1T0BD2nBPu34oEAGBwodzWTuurDQjKqvlzK9hfTh6119JtKkyw9qddxZ9tGCRDMfYwXqc1IuSji8JTbjeAULiAWWLpVbfZR6fyqTckyaEaAxXXKpPHFJ7cq3WVgdrew590zCFt5nDBt4Pa5eZ9O3THuaB+ac2U/0nYOvLwSY7XfVTphXVBIoq/qWsknEpktq1l/7HQHvessOte9kAx3gJK98RwX8L49qlHz1+2PDxa8ocotUgXMYx7eV6Ic7VdC7FlhaBw3szwDz4EQGB9NSi3k4xqUVgmKipXpSlCZ9gto8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a17bb31-aa93-49c4-a877-08d6c956255f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:15:15.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6095
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
