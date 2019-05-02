Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51E82089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D6oXyOx/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LnFgAVng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBFCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:02:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47504 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfEBFCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556773357; x=1588309357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hudxt7lduVUFNlHFN6S8+Siw1PK1toL0YJqfIpGbsYw=;
  b=D6oXyOx/1xIFclGYFuagr6gEKGDAC1/IHXe892XwPK2L8FDTUBhR9a/Y
   GiMJLcyxKbRc0amkJqnj0SKT/v2gUuTJC+zJ7zzA+QKXAXjII9z2dJ6oM
   Z7ZS4qb4bauvhrFEpvo8gvaEuv14hjcW7jmQKXDolpLyLmuhgKM/jk4kj
   oU8krJwwq2Xmjb9uomOfED1l9gtLLPBCrRZSFey5ByLHhp62PuvaKx2v1
   hqrwB1o8Kt1z3MKcOwmgns9bnkmwg1hDMei3VcsHlHWo9qm1DSp8afXWg
   ajc8UXwZnPLpRFBcaSbWyhnRwLq4WNMkKdOH0/tqDs3Ol/BBhg9rbx7+u
   w==;
X-IronPort-AV: E=Sophos;i="5.60,420,1549900800"; 
   d="scan'208";a="107321531"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 13:02:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hudxt7lduVUFNlHFN6S8+Siw1PK1toL0YJqfIpGbsYw=;
 b=LnFgAVngObiOn9uVgDgQaxyWh9E16+keaHdZeJspv0CacDyz0q+UBoI+x2++N/2xYHtnI5RihNRTLpmVhd1KdQ7dhh8zyN4R3LFw43066EsEeKV67RFmBChFi3+LH42hiRM/GiOjTL6NCN6IUujNDSitBR8Wpo38RExa5XWRdHQ=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5582.namprd04.prod.outlook.com (20.178.248.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 05:02:34 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::c500:5fd2:9194:e38]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::c500:5fd2:9194:e38%3]) with mapi id 15.20.1835.015; Thu, 2 May 2019
 05:02:34 +0000
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
Subject: [PATCH v4 1/2] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Topic: [PATCH v4 1/2] RISC-V: Fix memory reservation in setup_bootmem()
Thread-Index: AQHVAKRAl0Mwp2Ao5UCsXvDdaQGVog==
Date:   Thu, 2 May 2019 05:02:33 +0000
Message-ID: <20190502050206.23373-2-anup.patel@wdc.com>
References: <20190502050206.23373-1-anup.patel@wdc.com>
In-Reply-To: <20190502050206.23373-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e66b71-89f0-4ab3-304e-08d6cebb62f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5582;
x-ms-traffictypediagnostic: MN2PR04MB5582:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB558223E2FF746DFD8ED79E3D8D340@MN2PR04MB5582.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(5660300002)(1076003)(6436002)(486006)(305945005)(66066001)(476003)(71200400001)(71190400001)(26005)(44832011)(81156014)(86362001)(81166006)(8676002)(11346002)(102836004)(54906003)(446003)(2171002)(25786009)(186003)(110136005)(316002)(6486002)(386003)(50226002)(72206003)(6506007)(8936002)(53936002)(256004)(73956011)(36756003)(76176011)(3846002)(6116002)(2906002)(4326008)(68736007)(2616005)(66946007)(99286004)(7736002)(14454004)(6512007)(478600001)(66446008)(64756008)(66556008)(66476007)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5582;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oau2JSBfxc+sHfMGGTYUiLwzR3iET+dgatSOPM26DxLsKqQE/pEdtqzJ7HEyocsJF/7pNBzbFtaRT1jPlptWVIIPeP28E6nHZtXMqH9PP5ENGKoSQiUVp642SJ9wZNtlMTA/JlgJ77DGOmM6sl5cKJp4nLT0li0iAeY+eg4JbA1+v6Hz3+OvmEfqlqlANh4OYEBYKMZ8tz28m2EOVLe/vJgvPGLfZmENpPAMBWoQAqA7pgNGJDedbMN/J91Hn7wteOlBir4b5LWTw18RESPkqvPZLGv1uSLwxhgtVAvCRmK7Hnq2nLmx2G1Fje64hjC+O0IuX+LK6wqUrwDcEufDiSgDS5n2xZTVG77CZcZzzCHyaWO8e697VRkYS68JGnIhlxux95EqxRZom65v1x1Ky+b/0gHpuH6eGxW4ZXVKON8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e66b71-89f0-4ab3-304e-08d6cebb62f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 05:02:34.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5582
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
bS9pbml0LmMNCmluZGV4IGJjN2I3N2UzNGQwOS4uYWIxNzViNjU1OTMzIDEwMDY0NA0KLS0tIGEv
YXJjaC9yaXNjdi9tbS9pbml0LmMNCisrKyBiL2FyY2gvcmlzY3YvbW0vaW5pdC5jDQpAQCAtMjks
NiArMjksOCBAQCB1bnNpZ25lZCBsb25nIGVtcHR5X3plcm9fcGFnZVtQQUdFX1NJWkUgLyBzaXpl
b2YodW5zaWduZWQgbG9uZyldDQogCQkJCQkJCV9fcGFnZV9hbGlnbmVkX2JzczsNCiBFWFBPUlRf
U1lNQk9MKGVtcHR5X3plcm9fcGFnZSk7DQogDQorZXh0ZXJuIGNoYXIgX3N0YXJ0W107DQorDQog
c3RhdGljIHZvaWQgX19pbml0IHpvbmVfc2l6ZXNfaW5pdCh2b2lkKQ0KIHsNCiAJdW5zaWduZWQg
bG9uZyBtYXhfem9uZV9wZm5zW01BWF9OUl9aT05FU10gPSB7IDAsIH07DQpAQCAtMTA4LDE4ICsx
MTAsMTQgQEAgdm9pZCBfX2luaXQgc2V0dXBfYm9vdG1lbSh2b2lkKQ0KIHsNCiAJc3RydWN0IG1l
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
ZGRyX3QpLVBBR0VfT0ZGU0VUKTsNCiANCiAJCQkvKg0KQEAgLTEzMyw2ICsxMzEsOSBAQCB2b2lk
IF9faW5pdCBzZXR1cF9ib290bWVtKHZvaWQpDQogCX0NCiAJQlVHX09OKG1lbV9zaXplID09IDAp
Ow0KIA0KKwkvKiBSZXNlcnZlIGZyb20gdGhlIHN0YXJ0IG9mIHRoZSBrZXJuZWwgdG8gdGhlIGVu
ZCBvZiB0aGUga2VybmVsICovDQorCW1lbWJsb2NrX3Jlc2VydmUodm1saW51eF9zdGFydCwgdm1s
aW51eF9lbmQgLSB2bWxpbnV4X3N0YXJ0KTsNCisNCiAJc2V0X21heF9tYXBucihQRk5fRE9XTiht
ZW1fc2l6ZSkpOw0KIAltYXhfbG93X3BmbiA9IFBGTl9ET1dOKG1lbWJsb2NrX2VuZF9vZl9EUkFN
KCkpOw0KIA0KQEAgLTIxMCw3ICsyMTEsNiBAQCB2b2lkIF9fc2V0X2ZpeG1hcChlbnVtIGZpeGVk
X2FkZHJlc3NlcyBpZHgsIHBoeXNfYWRkcl90IHBoeXMsIHBncHJvdF90IHByb3QpDQogDQogYXNt
bGlua2FnZSB2b2lkIF9faW5pdCBzZXR1cF92bSh2b2lkKQ0KIHsNCi0JZXh0ZXJuIGNoYXIgX3N0
YXJ0Ow0KIAl1aW50cHRyX3QgaTsNCiAJdWludHB0cl90IHBhID0gKHVpbnRwdHJfdCkgJl9zdGFy
dDsNCiAJcGdwcm90X3QgcHJvdCA9IF9fcGdwcm90KHBncHJvdF92YWwoUEFHRV9LRVJORUwpIHwg
X1BBR0VfRVhFQyk7DQotLSANCjIuMTcuMQ0KDQo=
