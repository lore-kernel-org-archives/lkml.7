Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F483C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DC520825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="efF1jVgL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SVQR3yUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfFGGBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:01:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2240 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfFGGBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559887292; x=1591423292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ad9OzhObcTVEjpq5II81XSqfa/NVOOqA0VlDrpha9k4=;
  b=efF1jVgLKyQUbBOMR7wsulxduD64PDnaco98y7u6i1ISbTZ7sRo9gH4K
   ZIBpmyI/EiElOlSJcX3Rkvp2wGX3AKDRLODEuLM7E99Q7b/0sUulVPj0W
   EtFADvRNjm2NVv3hDIa9Ebbtf197LTCPIp+06Qbk5AV7QUPkp+XeZNNLE
   WaRmkk6BcZRC7o3vqPI0eR/ZV2kz9Yvg5l0F4U24f8yVmgBzjG8JJ2QIM
   fkgQvX4JB8qDisspZyOf929XJR9lFqi7nJcpI5ErHT867Lw8K8ppsyQGY
   C2HMSJNAOpi3NqTOBGfUuaKCKyI2QUm46Hk9RZh1obYgCzOnWFskBdiJt
   g==;
X-IronPort-AV: E=Sophos;i="5.63,562,1557158400"; 
   d="scan'208";a="216314733"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 14:01:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad9OzhObcTVEjpq5II81XSqfa/NVOOqA0VlDrpha9k4=;
 b=SVQR3yUghs0LnAkJkZZwTOLgN3kjQ+dBGP/jAvHyKWzkHcz4rWk1dEyMfWESmG4JqStw7rLeGIScIXNf0Q0CG2uqwXTli10gCP7WjiusuQFh1IhPO0G71Bst/n1Dbz/UJmJfxR+UqyjGPBsGCPyNv4GUewuYrndyhOCzFEUxYN8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 06:01:29 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e%7]) with mapi id 15.20.1943.026; Fri, 7 Jun 2019
 06:01:29 +0000
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
Subject: [PATCH v5 1/2] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Topic: [PATCH v5 1/2] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Index: AQHVHPZypc49rHUlikqL/+SNUsZZag==
Date:   Fri, 7 Jun 2019 06:01:29 +0000
Message-ID: <20190607060049.29257-2-anup.patel@wdc.com>
References: <20190607060049.29257-1-anup.patel@wdc.com>
In-Reply-To: <20190607060049.29257-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af326713-9a46-49c9-108d-08d6eb0d9524
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5920;
x-ms-traffictypediagnostic: MN2PR04MB5920:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5920C58C1DB035AF48D8CE728D100@MN2PR04MB5920.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(68736007)(256004)(6512007)(54906003)(2906002)(386003)(81156014)(71200400001)(52116002)(81166006)(76176011)(110136005)(72206003)(476003)(26005)(2616005)(53936002)(8936002)(8676002)(99286004)(7736002)(4326008)(2171002)(305945005)(6506007)(102836004)(50226002)(71190400001)(14454004)(186003)(25786009)(478600001)(486006)(6436002)(86362001)(6116002)(3846002)(6486002)(66476007)(64756008)(66446008)(66556008)(66946007)(73956011)(1076003)(446003)(316002)(66066001)(11346002)(44832011)(5660300002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5920;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UTBchpBzC8+vg93h3DiRc9NUEbqKHA1gt9qb09KphLBGciKQhfomiMa5wFWTZiS1+ku5EE3gWV9y5ohCb2gwQCtvT5hltgDtHsQ6Zwq2M7bw3nbahNOTXJbfXNXuAQtY62/9VaS3oT5Lt+GaMSR2aNZ83gcJelRJf3sHn9KRiasdDT8IBgktOAPAvBVDUjPhMhf14jp8wQX2slCrjD9avXOpBr3byZ+rNAnDRhSBSfUQCVRmpqPsebkeL+EsQibeo/nDO2+cWfbwq6cAuYifUxzGvlOue5u92td/5coA4QejrBveyEDXodCPcUezNY8c44L88egC+kcuC81pHOU1HyAq8uTlqsL7+By2bc121BSALXKBXAnz6qf9lOzXMHITsG9beoAtNmiVaMtfxR+2ij6jEvdsyBqFD6MeDF9ZFr0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af326713-9a46-49c9-108d-08d6eb0d9524
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 06:01:29.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anup.Patel@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VycmVudGx5LCB0aGUgc2V0dXBfYm9vdG1lbSgpIHJlc2VydmVzIG1lbW9yeSBmcm9tIFJBTSBz
dGFydCB0byB0aGUNCmtlcm5lbCBlbmQuIFRoaXMgcHJldmVudHMgdXMgZnJvbSBleHBsb3Jpbmcg
d2F5cyB0byB1c2UgdGhlIFJBTSBiZWxvdw0KKG9yIGJlZm9yZSkgdGhlIGtlcm5lbCBzdGFydCBo
ZW5jZSB0aGlzIHBhdGNoIHVwZGF0ZXMgc2V0dXBfYm9vdG1lbSgpDQp0byBvbmx5IHJlc2VydmUg
bWVtb3J5IGZyb20gdGhlIGtlcm5lbCBzdGFydCB0byB0aGUga2VybmVsIGVuZC4NCg0KU3VnZ2Vz
dGVkLWJ5OiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBBbnVwIFBhdGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQotLS0NCiBhcmNoL3Jpc2N2L21tL2luaXQuYyB8IDE0ICsr
KysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbW0vaW5pdC5jIGIvYXJjaC9yaXNjdi9t
bS9pbml0LmMNCmluZGV4IDhiZjZmOWMyZDQ4Yy4uMTg3OTUwMWJkMTU2IDEwMDY0NA0KLS0tIGEv
YXJjaC9yaXNjdi9tbS9pbml0LmMNCisrKyBiL2FyY2gvcmlzY3YvbW0vaW5pdC5jDQpAQCAtMjks
NiArMjksOCBAQCB1bnNpZ25lZCBsb25nIGVtcHR5X3plcm9fcGFnZVtQQUdFX1NJWkUgLyBzaXpl
b2YodW5zaWduZWQgbG9uZyldDQogCQkJCQkJCV9fcGFnZV9hbGlnbmVkX2JzczsNCiBFWFBPUlRf
U1lNQk9MKGVtcHR5X3plcm9fcGFnZSk7DQogDQorZXh0ZXJuIGNoYXIgX3N0YXJ0W107DQorDQog
c3RhdGljIHZvaWQgX19pbml0IHpvbmVfc2l6ZXNfaW5pdCh2b2lkKQ0KIHsNCiAJdW5zaWduZWQg
bG9uZyBtYXhfem9uZV9wZm5zW01BWF9OUl9aT05FU10gPSB7IDAsIH07DQpAQCAtMTAzLDE4ICsx
MDUsMTQgQEAgdm9pZCBfX2luaXQgc2V0dXBfYm9vdG1lbSh2b2lkKQ0KIHsNCiAJc3RydWN0IG1l
bWJsb2NrX3JlZ2lvbiAqcmVnOw0KIAlwaHlzX2FkZHJfdCBtZW1fc2l6ZSA9IDA7DQorCXBoeXNf
YWRkcl90IHZtbGludXhfZW5kID0gX19wYSgmX2VuZCk7DQorCXBoeXNfYWRkcl90IHZtbGludXhf
c3RhcnQgPSBfX3BhKCZfc3RhcnQpOw0KIA0KIAkvKiBGaW5kIHRoZSBtZW1vcnkgcmVnaW9uIGNv
bnRhaW5pbmcgdGhlIGtlcm5lbCAqLw0KIAlmb3JfZWFjaF9tZW1ibG9jayhtZW1vcnksIHJlZykg
ew0KLQkJcGh5c19hZGRyX3Qgdm1saW51eF9lbmQgPSBfX3BhKF9lbmQpOw0KIAkJcGh5c19hZGRy
X3QgZW5kID0gcmVnLT5iYXNlICsgcmVnLT5zaXplOw0KIA0KIAkJaWYgKHJlZy0+YmFzZSA8PSB2
bWxpbnV4X2VuZCAmJiB2bWxpbnV4X2VuZCA8PSBlbmQpIHsNCi0JCQkvKg0KLQkJCSAqIFJlc2Vy
dmUgZnJvbSB0aGUgc3RhcnQgb2YgdGhlIHJlZ2lvbiB0byB0aGUgZW5kIG9mDQotCQkJICogdGhl
IGtlcm5lbA0KLQkJCSAqLw0KLQkJCW1lbWJsb2NrX3Jlc2VydmUocmVnLT5iYXNlLCB2bWxpbnV4
X2VuZCAtIHJlZy0+YmFzZSk7DQogCQkJbWVtX3NpemUgPSBtaW4ocmVnLT5zaXplLCAocGh5c19h
ZGRyX3QpLVBBR0VfT0ZGU0VUKTsNCiANCiAJCQkvKg0KQEAgLTEyOCw2ICsxMjYsOSBAQCB2b2lk
IF9faW5pdCBzZXR1cF9ib290bWVtKHZvaWQpDQogCX0NCiAJQlVHX09OKG1lbV9zaXplID09IDAp
Ow0KIA0KKwkvKiBSZXNlcnZlIGZyb20gdGhlIHN0YXJ0IG9mIHRoZSBrZXJuZWwgdG8gdGhlIGVu
ZCBvZiB0aGUga2VybmVsICovDQorCW1lbWJsb2NrX3Jlc2VydmUodm1saW51eF9zdGFydCwgdm1s
aW51eF9lbmQgLSB2bWxpbnV4X3N0YXJ0KTsNCisNCiAJc2V0X21heF9tYXBucihQRk5fRE9XTiht
ZW1fc2l6ZSkpOw0KIAltYXhfbG93X3BmbiA9IFBGTl9ET1dOKG1lbWJsb2NrX2VuZF9vZl9EUkFN
KCkpOw0KIA0KQEAgLTIwNSw3ICsyMDYsNiBAQCB2b2lkIF9fc2V0X2ZpeG1hcChlbnVtIGZpeGVk
X2FkZHJlc3NlcyBpZHgsIHBoeXNfYWRkcl90IHBoeXMsIHBncHJvdF90IHByb3QpDQogDQogYXNt
bGlua2FnZSB2b2lkIF9faW5pdCBzZXR1cF92bSh2b2lkKQ0KIHsNCi0JZXh0ZXJuIGNoYXIgX3N0
YXJ0Ow0KIAl1aW50cHRyX3QgaTsNCiAJdWludHB0cl90IHBhID0gKHVpbnRwdHJfdCkgJl9zdGFy
dDsNCiAJcGdwcm90X3QgcHJvdCA9IF9fcGdwcm90KHBncHJvdF92YWwoUEFHRV9LRVJORUwpIHwg
X1BBR0VfRVhFQyk7DQotLSANCjIuMTcuMQ0KDQo=
