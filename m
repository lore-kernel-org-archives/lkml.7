Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AA9C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56C4208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CLgNVGHr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T+DacslA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfDMPit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:38:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6958 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfDMPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555170012; x=1586706012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T9yFNNImO8CfkqoFA0/qVcPa2wZJQfUTQnvM/Z+JMQs=;
  b=CLgNVGHrCD7yoMJEFZoxnylai9jwCUYuFv8NQ8QZvqJsz49FP+YJuiwj
   ZL+c+GU9URYTiK2dYyVgahK0Au9A9G2kVS+miJeWPITEXeJMSrdM7IN37
   I7RLWfr8SIq6Dp6qzISG8jhKwEstfC2lEv9P2VGOS9FeC1Qasnajdy0+b
   2k7uUTsKXpkWqylq64KU4niMuDcVr5FtOYavbrScHt6dRlqK9tlv7mrEh
   38JJB7v5LdpTFa+AabTIugJRBlEb8fYo2husxJ76S7cYUV2/SqXPwlRkd
   sd9OjvqkUMlGgViut5pjxXb21VrVZDolyxCJGlO93Qhu9ebsFERt/EI7f
   A==;
X-IronPort-AV: E=Sophos;i="5.60,345,1549900800"; 
   d="scan'208";a="204828673"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2019 23:40:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9yFNNImO8CfkqoFA0/qVcPa2wZJQfUTQnvM/Z+JMQs=;
 b=T+DacslAw7B0kZIzp5yro9u40stmtM5k+LUbRS3hdFtEunxp0NR9naTKKh4gTFIJ8NB3C9rzx93uZnj6/Qr8KfTbdaka0jSVkWu9lADvJii6YOXwfJZZP02Jb3F+Fl+oA6QTrwM/SJerMyR0W6m5qQ0eJxier9IwYcFxU1MY9a4=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5501.namprd04.prod.outlook.com (20.178.245.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sat, 13 Apr 2019 15:38:40 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Sat, 13 Apr 2019
 15:38:40 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/encoding.h
Thread-Topic: [PATCH v2 2/3] RISC-V: Add interrupt related SCAUSE defines in
 asm/encoding.h
Thread-Index: AQHU8g739Jygn8R9+UOEL40FVTFlWw==
Date:   Sat, 13 Apr 2019 15:38:39 +0000
Message-ID: <20190413153807.116227-3-anup.patel@wdc.com>
References: <20190413153807.116227-1-anup.patel@wdc.com>
In-Reply-To: <20190413153807.116227-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::18) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.17.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73cf40a5-6a82-4f21-fceb-08d6c02619f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5501;
x-ms-traffictypediagnostic: MN2PR04MB5501:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB550164A9C673CB093D9CE34E8D290@MN2PR04MB5501.namprd04.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(2906002)(71190400001)(71200400001)(97736004)(50226002)(1076003)(186003)(68736007)(102836004)(8936002)(6486002)(86362001)(110136005)(54906003)(316002)(9456002)(78486014)(55236004)(4326008)(81166006)(81156014)(6506007)(386003)(5660300002)(26005)(8676002)(36756003)(105586002)(44832011)(106356001)(14444005)(256004)(76176011)(3846002)(14454004)(478600001)(72206003)(6116002)(52116002)(6512007)(25786009)(99286004)(53936002)(11346002)(446003)(486006)(2171002)(66066001)(7736002)(6436002)(476003)(305945005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5501;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +VEvovHbr6wOc2u9D0yD1PKGkzDldeGFnMbK9RZwZBOay4vx0/3eB6+KlO2lwJdUhztWs3esS+nON9kmWGfVfTF7AEbmOndQKBYfgXOVbGDZy3fksWKd06YNOOWST7UCxRdvuhcIXgVLLbV/5j1QIaVthQbBlotOy1uGj0/Q++4scfQQnm634JPe57YWcThdYZvwNxzRXc6yciQC1/RQ4XilETbd/ulIkZSQZRD1WiSWayrdJZAhbI7gYCfIPjn++W/lrNQQJ6N8M1m953gpsbxFa25vsoev+soSyMKkxBqFDT6O2s/xXolp4klWgXJtVfISd6AYRpOm52Mu868OYbaVZbI5NuY9eocvnMU9wxhHgIijpRehA0Uvvgrzxd91bsjnYeNle+ISsYgROOk88cdjz6s5k3/7g/UNIFa2ZgI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cf40a5-6a82-4f21-fceb-08d6c02619f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 15:38:39.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIFNDQVVTRSBpbnRlcnJ1cHQgZmxhZyBhbmQgU0NBVVNFIGludGVycnVw
dCBjYXVzZQ0KcmVsYXRlZCBkZWZpbmVzIHRvIGFzbS9lbmNvZGluZy5oLiBXZSBhbHNvIHVzZSB0
aGVzZSBkZWZpbmVzIGluDQphcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYyBhbmQgZXhwcmVzcyBTSUUv
U0lQIGZsYWcgaW4tdGVybXMgb2YNCmludGVycnVwdCBjYXVzZXMuDQoNClNpZ25lZC1vZmYtYnk6
IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT4NCi0tLQ0KIGFyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vZW5jb2RpbmcuaCB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tLS0NCiBhcmNoL3Jp
c2N2L2tlcm5lbC9pcnEuYyAgICAgICAgICAgfCAgOSArKysrKy0tLS0NCiAyIGZpbGVzIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL2VuY29kaW5nLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Vu
Y29kaW5nLmgNCmluZGV4IDI5Njk5NzA1ZGMzNi4uNGYxODc4NTRmZDhiIDEwMDY0NA0KLS0tIGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbmNvZGluZy5oDQorKysgYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2VuY29kaW5nLmgNCkBAIC00NCwxMCArNDQsMjIgQEANCiAjZGVmaW5lIFNBVFBfTU9E
RQlTQVRQX01PREVfMzkNCiAjZW5kaWYNCiANCi0vKiBJbnRlcnJ1cHQgRW5hYmxlIGFuZCBJbnRl
cnJ1cHQgUGVuZGluZyBmbGFncyAqLw0KLSNkZWZpbmUgU0lFX1NTSUUJX0FDKDB4MDAwMDAwMDIs
IFVMKSAvKiBTb2Z0d2FyZSBJbnRlcnJ1cHQgRW5hYmxlICovDQotI2RlZmluZSBTSUVfU1RJRQlf
QUMoMHgwMDAwMDAyMCwgVUwpIC8qIFRpbWVyIEludGVycnVwdCBFbmFibGUgKi8NCi0jZGVmaW5l
IFNJRV9TRUlFCV9BQygweDAwMDAwMjAwLCBVTCkgLyogRXh0ZXJuYWwgSW50ZXJydXB0IEVuYWJs
ZSAqLw0KKy8qIFNDQVVTRSAqLw0KKyNpZmRlZiBDT05GSUdfNjRCSVQNCisjZGVmaW5lIFNDQVVT
RV9JUlFfRkxBRwkJX0FDKDB4ODAwMDAwMDAwMDAwMDAwMCwgVUwpDQorI2Vsc2UNCisjZGVmaW5l
IFNDQVVTRV9JUlFfRkxBRwkJX0FDKDB4ODAwMDAwMDAsIFVMKQ0KKyNlbmRpZg0KKw0KKyNkZWZp
bmUgSVJRX1VfU09GVAkJMA0KKyNkZWZpbmUgSVJRX1NfU09GVAkJMQ0KKyNkZWZpbmUgSVJRX01f
U09GVAkJMw0KKyNkZWZpbmUgSVJRX1VfVElNRVIJCTQNCisjZGVmaW5lIElSUV9TX1RJTUVSCQk1
DQorI2RlZmluZSBJUlFfTV9USU1FUgkJNw0KKyNkZWZpbmUgSVJRX1VfRVhUCQk4DQorI2RlZmlu
ZSBJUlFfU19FWFQJCTkNCisjZGVmaW5lIElSUV9NX0VYVAkJMTENCiANCiAjZGVmaW5lIEVYQ19J
TlNUX01JU0FMSUdORUQJMA0KICNkZWZpbmUgRVhDX0lOU1RfQUNDRVNTCQkxDQpAQCAtNTksNCAr
NzEsOSBAQA0KICNkZWZpbmUgRVhDX0xPQURfUEFHRV9GQVVMVAkxMw0KICNkZWZpbmUgRVhDX1NU
T1JFX1BBR0VfRkFVTFQJMTUNCiANCisvKiBTSUUgKEludGVycnVwdCBFbmFibGUpIGFuZCBTSVAg
KEludGVycnVwdCBQZW5kaW5nKSBmbGFncyAqLw0KKyNkZWZpbmUgU0lFX1NTSUUJCShfQUMoMHgx
LCBVTCkgPDwgSVJRX1NfU09GVCkNCisjZGVmaW5lIFNJRV9TVElFCQkoX0FDKDB4MSwgVUwpIDw8
IElSUV9TX1RJTUVSKQ0KKyNkZWZpbmUgU0lFX1NFSUUJCShfQUMoMHgxLCBVTCkgPDwgSVJRX1Nf
RVhUKQ0KKw0KICNlbmRpZiAvKiBfQVNNX1JJU0NWX0VOQ09ESU5HX0ggKi8NCmRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2lycS5jDQppbmRl
eCA0OGU2YjdkYjgzYTEuLjIyYjgxODNhZThkNCAxMDA2NDQNCi0tLSBhL2FyY2gvcmlzY3Yva2Vy
bmVsL2lycS5jDQorKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9pcnEuYw0KQEAgLTksMTQgKzksMTUg
QEANCiAjaW5jbHVkZSA8bGludXgvaXJxY2hpcC5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFkb21h
aW4uaD4NCiAjaW5jbHVkZSA8bGludXgvc2VxX2ZpbGUuaD4NCisjaW5jbHVkZSA8YXNtL2VuY29k
aW5nLmg+DQogI2luY2x1ZGUgPGFzbS9zbXAuaD4NCiANCiAvKg0KICAqIFBvc3NpYmxlIGludGVy
cnVwdCBjYXVzZXM6DQogICovDQotI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfU09GVFdBUkUgICAg
MQ0KLSNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1RJTUVSICAgICAgIDUNCi0jZGVmaW5lIElOVEVS
UlVQVF9DQVVTRV9FWFRFUk5BTCAgICA5DQorI2RlZmluZSBJTlRFUlJVUFRfQ0FVU0VfU09GVFdB
UkUJSVJRX1NfU09GVA0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX1RJTUVSCQlJUlFfU19USU1F
Ug0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX0VYVEVSTkFMCUlSUV9TX0VYVA0KIA0KIC8qDQog
ICogVGhlIGhpZ2ggb3JkZXIgYml0IG9mIHRoZSB0cmFwIGNhdXNlIHJlZ2lzdGVyIGlzIGFsd2F5
cyBzZXQgZm9yDQpAQCAtMjQsNyArMjUsNyBAQA0KICAqIHF1aWNrbHkuICBUaGUgSU5URVJSVVBU
X0NBVVNFXyogbWFjcm9zIGRvbid0IGNvbnRhaW4gdGhhdCBiaXQsIHNvIHdlDQogICogbmVlZCB0
byBtYXNrIGl0IG9mZi4NCiAgKi8NCi0jZGVmaW5lIElOVEVSUlVQVF9DQVVTRV9GTEFHCSgxVUwg
PDwgKF9fcmlzY3ZfeGxlbiAtIDEpKQ0KKyNkZWZpbmUgSU5URVJSVVBUX0NBVVNFX0ZMQUcJCVND
QVVTRV9JUlFfRkxBRw0KIA0KIGludCBhcmNoX3Nob3dfaW50ZXJydXB0cyhzdHJ1Y3Qgc2VxX2Zp
bGUgKnAsIGludCBwcmVjKQ0KIHsNCi0tIA0KMi4xNy4xDQoNCg==
