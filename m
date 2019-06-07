Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED277C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72AD20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ahW76oCH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CjfhZxKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfFGGB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:01:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2240 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfFGGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559887286; x=1591423286;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=F55XFh+0L2QVaK0P9ne3JsQL6JQK5dEWWxxIHPMXMP4=;
  b=ahW76oCHAow6B+epQ/M6a/tECEX1uu9Jr/I4wJWk+vSPSfBEED1daJA/
   Weosjvdhfp2Y8AEclPnqgVHXUmbvDuM9cq2I2EI9CoKLZpp5HRJSUigbv
   ymbl0sgEpwXcdjDxoGdx3fTyTKTbgnj7peNuBC2/MNP395tKMhvsXJKRp
   0r1ZJ63zvL1zwApvCC2mKfKfQ+eSeNVGopdb/CQ4qwGGGj9uJXNuYHatM
   GIVdpqG1t8owv7YSKiaAU7nysxOul7ln18fC74Pa0F7AjXEeQvEI40s/H
   Pk2CkqoGCoZgWo19ISNcHrGSueGQKLPbo7T2haPCJA9Q2IfPWwZfIJAbE
   A==;
X-IronPort-AV: E=Sophos;i="5.63,562,1557158400"; 
   d="scan'208";a="216314725"
Received: from mail-by2nam05lp2058.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.58])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 14:01:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F55XFh+0L2QVaK0P9ne3JsQL6JQK5dEWWxxIHPMXMP4=;
 b=CjfhZxKUB9rKNudLXoG0I6GK8jEr7avvMs3fqu3Q+dWSxoe/sxKsBzwVR5sAY7weNDyNzpJLfdNEfJ6rTR7FyYjVfU/zCXbrV4jwqaZMewrtQMvBlS1d51ebCjqpYtJVZxnzjXkvCjO54t3f92X25BJWbRCctgxhuyOJNxXY1TA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 06:01:24 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::98ab:5e60:9c5c:4e0e%7]) with mapi id 15.20.1943.026; Fri, 7 Jun 2019
 06:01:24 +0000
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
Subject: [PATCH v5 0/2] Two-stagged initial page table setup
Thread-Topic: [PATCH v5 0/2] Two-stagged initial page table setup
Thread-Index: AQHVHPZv/4z6R2LBokaKhvaK1uY0gg==
Date:   Fri, 7 Jun 2019 06:01:24 +0000
Message-ID: <20190607060049.29257-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 782186a4-33f9-4b70-4c3b-08d6eb0d921c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5920;
x-ms-traffictypediagnostic: MN2PR04MB5920:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB59209CF918D57FE29A73DD868D100@MN2PR04MB5920.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(68736007)(256004)(6512007)(54906003)(2906002)(386003)(81156014)(71200400001)(52116002)(81166006)(110136005)(72206003)(476003)(26005)(2616005)(53936002)(8936002)(8676002)(99286004)(7736002)(4326008)(2171002)(305945005)(6506007)(102836004)(50226002)(71190400001)(14454004)(186003)(25786009)(478600001)(486006)(6436002)(86362001)(6116002)(3846002)(6486002)(66476007)(64756008)(66446008)(66556008)(66946007)(73956011)(1076003)(316002)(66066001)(44832011)(5660300002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5920;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jUdzOvHf8gZUpu8RjyiXIcYmYgvaPthoMvtLEs/QmSo/pQOjDXQ5CBfxW0SH7ImEWyP9I+rL3O1kLsGhYMEHyHJw/NPlIT7BaavD7E1RAvfytY7n3/b/uFELKFIsSaphLfMslaidu4r31tA4PuF+ZcCII006jF2ytVHb9QOnW8WRE7c93TxUyx0AmkOr+w0C3FHzb92kni0/lPr4I425HAfZLqN+nuVWCGh2UTJdpdVt8tJy5bLLcb5pTpJ1rLfjppZIrhtFVq7smTq2FZDqrYiUI6ozc02jvL8EfcQPeqq3uNB3v0BfvNzXibXfgvWkkixRVG1eeC96HvZxurRT9opm+l8bT8mdeHNR2ZcRgW/zU/hXlfqZGDoAqBO3fr0g7CtlQjFsGB8p7wXm+ZBtihFNWuOIzy5qSd7voMdZsCs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782186a4-33f9-4b70-4c3b-08d6eb0d921c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 06:01:24.2851
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

VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHR3by1zdGFnZ2VkIGluaXRpYWwgcGFnZSB0YWJsZSBz
ZXR1cCB1c2luZyBmaXhtYXANCnRvIGF2b2lkIG1hcHBpbmcgbm9uLWV4aXN0ZW50IFJBTSBhbmQg
YWxzbyByZWR1Y2UgaGlnaF9tZW1vcnkgY29uc3VtZWQgYnkNCmluaXRpYWwgcGFnZSB0YWJsZXMu
DQoNClRoZSBwYXRjaHNldCBpcyBiYXNlZCBvbiBMaW51eC01LjItcmMzIGFuZCB0ZXN0ZWQgb24g
U2lGaXZlIFVubGVhc2hlZCBib2FyZA0KYW5kIFFFTVUgdmlydCBtYWNoaW5lLg0KDQpUaGVzZSBw
YXRjaGVzIGNhbiBiZSBmb3VuZCBpbiByaXNjdl9zZXR1cF92bV92NSBicmFuY2ggb2YNCmh0dHBz
Ly9naXRodWIuY29tL2F2cGF0ZWwvbGludXguZ2l0DQoNCkNoYW5nZXMgc2luY2UgdjQ6DQotIEFk
ZGVkIGR0Yl9lYXJseV92YSB3aGljaCBwb2ludHMgdG8gRFRCIGZvciBlYXJseSBwYXJzaW5nDQoN
CkNoYW5nZXMgc2luY2UgdjM6DQotIENoYW5nZWQgcGF0Y2ggc2VyaWVzIHN1YmplY3QuDQotIERy
b3BwZWQgUEFUQ0gxIGJlY2F1c2UgaXQncyBhbHJlYWR5IG1lcmdlZA0KLSBEcm9wcGVkIFBBVENI
MyBiZWNhdXNlIHRyYW1wb2xpbmUgcGFnZSB0YWJsZSBoYW5kbGVzIGEgY29ybmVyIGNhc2UNCiAg
Zm9yIDMyYml0IHN5c3RlbXMgd2hlcmUgbG9hZCBhZGRyZXNzIHJhbmdlIG92ZXJsYXBzIGtlcm5l
bCB2aXJ0dWFsDQogIGFkZHJlc3MgcmFuZ2UNCi0gUmV2YW1wZWQgUEFUQ0ggZm9yIDRLIGFsaWdu
ZWQgYm9vdGluZyBpbnRvIHR3by1zdGFnZ2VkIGluaXRpYWwgcGFnZQ0KICB0YWJsZSBzZXR1cA0K
DQpDaGFuZ2VzIHNpbmNlIHYyOg0KLSBEcm9wcGVkIFBBVENIMiBiZWNhdXNlIHdlIGhhdmUgc2Vw
YXJhdGUgZml4IGZvciBMaW51eC01LjEtcmNYDQotIE1vdmVkIFBBVENINSB0byBQQVRDSDINCi0g
TW92ZWQgUEFUQ0g0IHRvIFBBVENIMw0KLSBUaGUgIkJvb3Rpbmcga2VybmVsIGZyb20gYW55IDRL
QiBhbGlnbmVkIGFkZHJlc3MiIGlzIG5vdyBQQVRDSDQNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCi0g
QWRkIGtjb25maWcgb3B0aW9uIEJPT1RfUEFHRV9BTElHTkVEIHRvIGVuYWJsZSA0S0IgYWxpZ25l
ZCBib290aW5nDQotIEltcHJvdmVkIGluaXRpYWwgcGFnZSB0YWJsZSBzZXR1cCBjb2RlIHRvIHNl
bGVjdCBiZXN0L2JpZ2dlc3QNCiAgcG9zc2libGUgbWFwcGluZyBzaXplIGJhc2VkIG9uIGxvYWQg
YWRkcmVzcyBhbGlnbm1lbnQNCi0gQWRkZWQgUEFUQ0g0IHRvIHJlbW92ZSByZWR1bmRhbnQgdHJh
bXBvbGluZSBwYWdlIHRhYmxlDQotIEFkZGVkIFBBVENINSB0byBmaXggbWVtb3J5IHJlc2VydmF0
aW9uIGluIHNldHVwX2Jvb3RtZW0oKQ0KDQpBbnVwIFBhdGVsICgyKToNCiAgUklTQy1WOiBGaXgg
bWVtb3J5IHJlc2VydmF0aW9uIGluIHNldHVwX2Jvb3RtZW0oKQ0KICBSSVNDLVY6IFNldHVwIGlu
aXRpYWwgcGFnZSB0YWJsZXMgaW4gdHdvIHN0YWdlcw0KDQogYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9maXhtYXAuaCAgICAgfCAgIDUgKw0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS02
NC5oIHwgICA1ICsNCiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICB8ICAgOCAr
DQogYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TICAgICAgICAgICAgfCAgMTcgKy0NCiBhcmNoL3Jp
c2N2L2tlcm5lbC9zZXR1cC5jICAgICAgICAgICB8ICAgNiArLQ0KIGFyY2gvcmlzY3YvbW0vaW5p
dC5jICAgICAgICAgICAgICAgIHwgMzMxICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCiA2
IGZpbGVzIGNoYW5nZWQsIDI5MiBpbnNlcnRpb25zKCspLCA4MCBkZWxldGlvbnMoLSkNCg0KLS0N
CjIuMTcuMQ0K
