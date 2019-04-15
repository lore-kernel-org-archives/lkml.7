Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF5C20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YyQFfe1g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KS/0jhRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfDOJhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:37:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53670 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555321039; x=1586857039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GURct/l0j0ccOvVnF08e5+y/fSWDYVQQbDkhSw4WGYE=;
  b=YyQFfe1gWAmnhrAa8+TyfOBTpSag6kycHD+DjOcKrAFLqTua4GzXV51m
   XkVLUAh/BHvoaGdtT1nMGFE01vq6PJRIey8YzTmu681FZpEm3UF2EBErk
   ObaG/cPeKUHQRr+Ki4Qv1BDzedXzLwg3WlpUWfa5BD4PMM4KDkVfRkzhX
   ESYdobkxsl4Q+Fn1/+cqMuwZ8KMCfTyKClqwzGl9BjMxTjFGNdPzmtSiB
   QiEo3XELL5qFxwdaPgt2ehXCz+lxfquWM1LmkWXbcZrKslJbNoIOo28tG
   seclKWPUHN1xRlv/iSo/ofruCi8rqtl8XvY7RxORfFbqbKz0bz/8S2K9L
   g==;
X-IronPort-AV: E=Sophos;i="5.60,353,1549900800"; 
   d="scan'208";a="105984895"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 17:37:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GURct/l0j0ccOvVnF08e5+y/fSWDYVQQbDkhSw4WGYE=;
 b=KS/0jhRfcngha4K/Mx9fAJAVCggAhzXN7F3yKT8Ow1QriOTZZLoHcsRXTQx0qwSOG47/9cRvpn6TRYFmgTeor4M5EZiU2A9tdgAe9fvq1kflOc7MIwGQNnWMEn4A4HV3jO4KMDlWCuCSPCMjp2eFCPhIsQjMFfpsl+86Jte2afE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5677.namprd04.prod.outlook.com (20.179.20.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 09:37:17 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 09:37:17 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 1/3] RISC-V: Use tabs to align macro values in asm/csr.h
Thread-Topic: [PATCH v3 1/3] RISC-V: Use tabs to align macro values in
 asm/csr.h
Thread-Index: AQHU827QMDsNf/UZykGzHkCw81g5QQ==
Date:   Mon, 15 Apr 2019 09:37:17 +0000
Message-ID: <20190415093648.7525-2-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 82c757bb-8a19-41a8-744c-08d6c185f2d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5677;
x-ms-traffictypediagnostic: MN2PR04MB5677:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB56770F3FB972642C06C3531C8D2B0@MN2PR04MB5677.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(4326008)(71200400001)(53936002)(71190400001)(26005)(476003)(86362001)(50226002)(186003)(5660300002)(54906003)(3846002)(6116002)(102836004)(97736004)(6512007)(2616005)(6486002)(316002)(105586002)(110136005)(36756003)(11346002)(486006)(6436002)(2171002)(6506007)(386003)(478600001)(44832011)(446003)(8936002)(8676002)(76176011)(68736007)(72206003)(81166006)(2906002)(7736002)(14444005)(256004)(99286004)(14454004)(25786009)(1076003)(52116002)(66066001)(305945005)(81156014)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5677;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kDTVSc/XcAQDWHRd2R+K23xqat3FSCzVJ3rDikGVnHJkGFLdHF8eaLbgm38DDJq/9FjHgy8GF+uG3kg/Ta2bUKAMMZpG3yvPRwVRLzYlI09L5nbdLnD3F7T5X8QfQ+Sp9yQHI2fusQYEbg5AsEnGL4kfjq2w6iV0q8RejwHDr4ry7dkfEAKp6UFBNf8JPwMnWTuf9TRVyCqCLJhCNldJTIz8Q8JCXvhm6ps4cwRWEVAsb3y7Qpv/HA6zN2fQ60IoYss4pRTsyB+9fWkRXNuHsO0eLhVVvkFKGXyhxRmwiCICUV96acq8+VATGti07iW5UH++pmc8YTRFIQCwvYuKt2LF5hjIjtR6bsIZHKIRMKE/ljTbh4lecRGd8FGpcMZ1xBj92YiwSTun3WgJAvuxN8ajeX1YkQjwR8RgiD3rTNE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c757bb-8a19-41a8-744c-08d6c185f2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 09:37:17.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHNwYWNpbmcgYmV0d2VlbiBtYWNybyBuYW1lIGFuZCB2YWx1ZSBpcyBub3QgY29uc2lzdGVu
dCBpbg0KYXNtL2Nzci5oLiBUaGlzIHBhdGNoIGJlYXV0aWZpZXMgYXNtL2Nzci5oIGJ5IHVzaW5n
IHRhYnMgdG8gYWxpZ24NCm1hY3JvIHZhbHVlcyBpbnN0ZWFkIG9mIHNwYWNlcy4NCg0KU2lnbmVk
LW9mZi1ieTogQW51cCBQYXRlbCA8YW51cC5wYXRlbEB3ZGMuY29tPg0KLS0tDQogYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9jc3IuaCB8IDc2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggYi9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL2Nzci5oDQppbmRleCAyOGEwZDFjYjM3NGMuLjJhZTU0YTczODZmMSAxMDA2
NDQNCi0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmgNCisrKyBiL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vY3NyLmgNCkBAIC0xNyw1NCArMTcsNTQgQEANCiAjaW5jbHVkZSA8bGludXgv
Y29uc3QuaD4NCiANCiAvKiBTdGF0dXMgcmVnaXN0ZXIgZmxhZ3MgKi8NCi0jZGVmaW5lIFNSX1NJ
RQlfQUMoMHgwMDAwMDAwMiwgVUwpIC8qIFN1cGVydmlzb3IgSW50ZXJydXB0IEVuYWJsZSAqLw0K
LSNkZWZpbmUgU1JfU1BJRQlfQUMoMHgwMDAwMDAyMCwgVUwpIC8qIFByZXZpb3VzIFN1cGVydmlz
b3IgSUUgKi8NCi0jZGVmaW5lIFNSX1NQUAlfQUMoMHgwMDAwMDEwMCwgVUwpIC8qIFByZXZpb3Vz
bHkgU3VwZXJ2aXNvciAqLw0KLSNkZWZpbmUgU1JfU1VNCV9BQygweDAwMDQwMDAwLCBVTCkgLyog
U3VwZXJ2aXNvciBtYXkgYWNjZXNzIFVzZXIgTWVtb3J5ICovDQotDQotI2RlZmluZSBTUl9GUyAg
ICAgICAgICAgX0FDKDB4MDAwMDYwMDAsIFVMKSAvKiBGbG9hdGluZy1wb2ludCBTdGF0dXMgKi8N
Ci0jZGVmaW5lIFNSX0ZTX09GRiAgICAgICBfQUMoMHgwMDAwMDAwMCwgVUwpDQotI2RlZmluZSBT
Ul9GU19JTklUSUFMICAgX0FDKDB4MDAwMDIwMDAsIFVMKQ0KLSNkZWZpbmUgU1JfRlNfQ0xFQU4g
ICAgIF9BQygweDAwMDA0MDAwLCBVTCkNCi0jZGVmaW5lIFNSX0ZTX0RJUlRZICAgICBfQUMoMHgw
MDAwNjAwMCwgVUwpDQotDQotI2RlZmluZSBTUl9YUyAgICAgICAgICAgX0FDKDB4MDAwMTgwMDAs
IFVMKSAvKiBFeHRlbnNpb24gU3RhdHVzICovDQotI2RlZmluZSBTUl9YU19PRkYgICAgICAgX0FD
KDB4MDAwMDAwMDAsIFVMKQ0KLSNkZWZpbmUgU1JfWFNfSU5JVElBTCAgIF9BQygweDAwMDA4MDAw
LCBVTCkNCi0jZGVmaW5lIFNSX1hTX0NMRUFOICAgICBfQUMoMHgwMDAxMDAwMCwgVUwpDQotI2Rl
ZmluZSBTUl9YU19ESVJUWSAgICAgX0FDKDB4MDAwMTgwMDAsIFVMKQ0KKyNkZWZpbmUgU1JfU0lF
CQlfQUMoMHgwMDAwMDAwMiwgVUwpIC8qIFN1cGVydmlzb3IgSW50ZXJydXB0IEVuYWJsZSAqLw0K
KyNkZWZpbmUgU1JfU1BJRQkJX0FDKDB4MDAwMDAwMjAsIFVMKSAvKiBQcmV2aW91cyBTdXBlcnZp
c29yIElFICovDQorI2RlZmluZSBTUl9TUFAJCV9BQygweDAwMDAwMTAwLCBVTCkgLyogUHJldmlv
dXNseSBTdXBlcnZpc29yICovDQorI2RlZmluZSBTUl9TVU0JCV9BQygweDAwMDQwMDAwLCBVTCkg
LyogU3VwZXJ2aXNvciBVc2VyIE1lbW9yeSBBY2Nlc3MgKi8NCisNCisjZGVmaW5lIFNSX0ZTCQlf
QUMoMHgwMDAwNjAwMCwgVUwpIC8qIEZsb2F0aW5nLXBvaW50IFN0YXR1cyAqLw0KKyNkZWZpbmUg
U1JfRlNfT0ZGCV9BQygweDAwMDAwMDAwLCBVTCkNCisjZGVmaW5lIFNSX0ZTX0lOSVRJQUwJX0FD
KDB4MDAwMDIwMDAsIFVMKQ0KKyNkZWZpbmUgU1JfRlNfQ0xFQU4JX0FDKDB4MDAwMDQwMDAsIFVM
KQ0KKyNkZWZpbmUgU1JfRlNfRElSVFkJX0FDKDB4MDAwMDYwMDAsIFVMKQ0KKw0KKyNkZWZpbmUg
U1JfWFMJCV9BQygweDAwMDE4MDAwLCBVTCkgLyogRXh0ZW5zaW9uIFN0YXR1cyAqLw0KKyNkZWZp
bmUgU1JfWFNfT0ZGCV9BQygweDAwMDAwMDAwLCBVTCkNCisjZGVmaW5lIFNSX1hTX0lOSVRJQUwJ
X0FDKDB4MDAwMDgwMDAsIFVMKQ0KKyNkZWZpbmUgU1JfWFNfQ0xFQU4JX0FDKDB4MDAwMTAwMDAs
IFVMKQ0KKyNkZWZpbmUgU1JfWFNfRElSVFkJX0FDKDB4MDAwMTgwMDAsIFVMKQ0KIA0KICNpZm5k
ZWYgQ09ORklHXzY0QklUDQotI2RlZmluZSBTUl9TRCAgIF9BQygweDgwMDAwMDAwLCBVTCkgLyog
RlMvWFMgZGlydHkgKi8NCisjZGVmaW5lIFNSX1NECQlfQUMoMHg4MDAwMDAwMCwgVUwpIC8qIEZT
L1hTIGRpcnR5ICovDQogI2Vsc2UNCi0jZGVmaW5lIFNSX1NEICAgX0FDKDB4ODAwMDAwMDAwMDAw
MDAwMCwgVUwpIC8qIEZTL1hTIGRpcnR5ICovDQorI2RlZmluZSBTUl9TRAkJX0FDKDB4ODAwMDAw
MDAwMDAwMDAwMCwgVUwpIC8qIEZTL1hTIGRpcnR5ICovDQogI2VuZGlmDQogDQogLyogU0FUUCBm
bGFncyAqLw0KLSNpZiBfX3Jpc2N2X3hsZW4gPT0gMzINCi0jZGVmaW5lIFNBVFBfUFBOICAgICBf
QUMoMHgwMDNGRkZGRiwgVUwpDQotI2RlZmluZSBTQVRQX01PREVfMzIgX0FDKDB4ODAwMDAwMDAs
IFVMKQ0KLSNkZWZpbmUgU0FUUF9NT0RFICAgIFNBVFBfTU9ERV8zMg0KKyNpZm5kZWYgQ09ORklH
XzY0QklUDQorI2RlZmluZSBTQVRQX1BQTglfQUMoMHgwMDNGRkZGRiwgVUwpDQorI2RlZmluZSBT
QVRQX01PREVfMzIJX0FDKDB4ODAwMDAwMDAsIFVMKQ0KKyNkZWZpbmUgU0FUUF9NT0RFCVNBVFBf
TU9ERV8zMg0KICNlbHNlDQotI2RlZmluZSBTQVRQX1BQTiAgICAgX0FDKDB4MDAwMDBGRkZGRkZG
RkZGRiwgVUwpDQotI2RlZmluZSBTQVRQX01PREVfMzkgX0FDKDB4ODAwMDAwMDAwMDAwMDAwMCwg
VUwpDQotI2RlZmluZSBTQVRQX01PREUgICAgU0FUUF9NT0RFXzM5DQorI2RlZmluZSBTQVRQX1BQ
TglfQUMoMHgwMDAwMEZGRkZGRkZGRkZGLCBVTCkNCisjZGVmaW5lIFNBVFBfTU9ERV8zOQlfQUMo
MHg4MDAwMDAwMDAwMDAwMDAwLCBVTCkNCisjZGVmaW5lIFNBVFBfTU9ERQlTQVRQX01PREVfMzkN
CiAjZW5kaWYNCiANCiAvKiBJbnRlcnJ1cHQgRW5hYmxlIGFuZCBJbnRlcnJ1cHQgUGVuZGluZyBm
bGFncyAqLw0KLSNkZWZpbmUgU0lFX1NTSUUgX0FDKDB4MDAwMDAwMDIsIFVMKSAvKiBTb2Z0d2Fy
ZSBJbnRlcnJ1cHQgRW5hYmxlICovDQotI2RlZmluZSBTSUVfU1RJRSBfQUMoMHgwMDAwMDAyMCwg
VUwpIC8qIFRpbWVyIEludGVycnVwdCBFbmFibGUgKi8NCi0jZGVmaW5lIFNJRV9TRUlFIF9BQygw
eDAwMDAwMjAwLCBVTCkgLyogRXh0ZXJuYWwgSW50ZXJydXB0IEVuYWJsZSAqLw0KLQ0KLSNkZWZp
bmUgRVhDX0lOU1RfTUlTQUxJR05FRCAgICAgMA0KLSNkZWZpbmUgRVhDX0lOU1RfQUNDRVNTICAg
ICAgICAgMQ0KLSNkZWZpbmUgRVhDX0JSRUFLUE9JTlQgICAgICAgICAgMw0KLSNkZWZpbmUgRVhD
X0xPQURfQUNDRVNTICAgICAgICAgNQ0KLSNkZWZpbmUgRVhDX1NUT1JFX0FDQ0VTUyAgICAgICAg
Nw0KLSNkZWZpbmUgRVhDX1NZU0NBTEwgICAgICAgICAgICAgOA0KLSNkZWZpbmUgRVhDX0lOU1Rf
UEFHRV9GQVVMVCAgICAgMTINCi0jZGVmaW5lIEVYQ19MT0FEX1BBR0VfRkFVTFQgICAgIDEzDQot
I2RlZmluZSBFWENfU1RPUkVfUEFHRV9GQVVMVCAgICAxNQ0KKyNkZWZpbmUgU0lFX1NTSUUJX0FD
KDB4MDAwMDAwMDIsIFVMKSAvKiBTb2Z0d2FyZSBJbnRlcnJ1cHQgRW5hYmxlICovDQorI2RlZmlu
ZSBTSUVfU1RJRQlfQUMoMHgwMDAwMDAyMCwgVUwpIC8qIFRpbWVyIEludGVycnVwdCBFbmFibGUg
Ki8NCisjZGVmaW5lIFNJRV9TRUlFCV9BQygweDAwMDAwMjAwLCBVTCkgLyogRXh0ZXJuYWwgSW50
ZXJydXB0IEVuYWJsZSAqLw0KKw0KKyNkZWZpbmUgRVhDX0lOU1RfTUlTQUxJR05FRAkwDQorI2Rl
ZmluZSBFWENfSU5TVF9BQ0NFU1MJCTENCisjZGVmaW5lIEVYQ19CUkVBS1BPSU5UCQkzDQorI2Rl
ZmluZSBFWENfTE9BRF9BQ0NFU1MJCTUNCisjZGVmaW5lIEVYQ19TVE9SRV9BQ0NFU1MJNw0KKyNk
ZWZpbmUgRVhDX1NZU0NBTEwJCTgNCisjZGVmaW5lIEVYQ19JTlNUX1BBR0VfRkFVTFQJMTINCisj
ZGVmaW5lIEVYQ19MT0FEX1BBR0VfRkFVTFQJMTMNCisjZGVmaW5lIEVYQ19TVE9SRV9QQUdFX0ZB
VUxUCTE1DQogDQogI2lmbmRlZiBfX0FTU0VNQkxZX18NCiANCi0tIA0KMi4xNy4xDQoNCg==
