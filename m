Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C01C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2382084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="puSVg73c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ut37/hdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDMHji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:39:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45984 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDMHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555141178; x=1586677178;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Vb0bSuVHfdsU4/lcEU6NRIjJZ60lVCyksQuRkLovrWk=;
  b=puSVg73cJOwc3vr6+CutlGH/adZHqalOyii/64X7EfdgG9mSI+itKD51
   dB3025Kcq233TDvSTQTt2NEkrAbFg8O7mUs49wiEl2T+XfkLWNfB+3Oz1
   Uxt+u6uNr0DbZf5n8nF6aI+KGYzUHxnuMWpEoZLkpwU1t5+RVF5CMlQ/f
   a4SGJ67OxPHMN19xSQasJA4zZB9OAKF9YteV3AxEEdYZYmpPoleFMDPHo
   lKfaFAOGsm7m/SM8lNNI6PixMHtmueuluLQ5CFdBqdNXiOQ3KRfPuS2pj
   tPpyxCCHLIKcJ7sab3iPfRIrKBjq/zS61xWEYZT27T9rWXdrFOAEeberg
   w==;
X-IronPort-AV: E=Sophos;i="5.60,344,1549900800"; 
   d="scan'208";a="107542548"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2019 15:39:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb0bSuVHfdsU4/lcEU6NRIjJZ60lVCyksQuRkLovrWk=;
 b=Ut37/hdgK+FdlzwcmlPrfGBMbWPui7IUrLHkyrVFX2PVwuUCUHYIHO5rEJMVS7UBW5ARXx888A6y//LeoKc3zTZR3BVoUOod2orz9fHSDJZI5zfzKJbCEpjuONasbITRm9cNTp7NwkB98eO9fslJ16Vbn9doxqHBiJr1Cfa3VIs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5613.namprd04.prod.outlook.com (20.178.255.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sat, 13 Apr 2019 07:39:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1792.018; Sat, 13 Apr 2019
 07:39:31 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU8cwH7Edud1N9oEOsF2m/mlao1A==
Date:   Sat, 13 Apr 2019 07:39:30 +0000
Message-ID: <20190413073906.53676-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.17.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebcbd522-0287-4475-9502-08d6bfe32a12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5613;
x-ms-traffictypediagnostic: MN2PR04MB5613:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5613E3094CD4C7F3449D8DDD8D290@MN2PR04MB5613.namprd04.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(9456002)(44832011)(256004)(14444005)(78486014)(54906003)(14454004)(316002)(7736002)(1076003)(71200400001)(102836004)(25786009)(186003)(6116002)(50226002)(4326008)(71190400001)(5660300002)(110136005)(386003)(3846002)(8936002)(6506007)(2906002)(55236004)(478600001)(26005)(305945005)(2616005)(476003)(105586002)(72206003)(106356001)(486006)(52116002)(66066001)(6486002)(97736004)(53936002)(36756003)(81156014)(81166006)(99286004)(68736007)(6436002)(86362001)(6512007)(2171002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5613;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cHTI8gjhCjMlgGTWAKwaz85M/x3gEs7sKjnnCBM8giLMdLAXu+hIfQ7LwVk3jQ5kEYgGp566HKwhfcD32GaJzTODvy20OHBiYCsF1qBieeJeheMO5hyXVr4QJVXnK/r19jaWVjpi4N4u3ncTpuvYqazsBDj2ihYqt7o4qIstSfToJ4ZcU4JZUKLLG+6GshnHnLvHJzxrmm6oG1cVYf0VyuQ0i7/MtGxtN4PuEg4GxgKvYXoXrHjihOtozkL1DrQxggTqC+FtQ1WFfNO1EsDQ76IVmfwm+kXRshi8xkUQRJqrAmhhPotnKFEQwzqTKnJZpkA2COvHlzeCRwZ65JJJgkZ/0Mcj+PoH6zCrajte8b6UG3FJbPGKF7BnMTloWhreUvi1ac3U5vxiMrmAO+SNf9r8pinKmcf80M//jQrrA4U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcbd522-0287-4475-9502-08d6bfe32a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 07:39:31.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IHRvIGFjY2VzcyBDU1IgdXNpbmcgYm90aCBD
U1IgbmFtZSBhbmQNCkNTUiBudW1iZXJzLg0KDQpBbHNvLCB3ZSBzaG91bGQgcHJlZmVyIGFjY2Vz
c2luZyBDU1JzIHVzaW5nIHRoZWlyIENTUiBudW1iZXJzIGJlY2F1c2U6DQoxLiBJdCBjb21waWxl
cyBmaW5lIHdpdGggb2xkZXIgdG9vbGNoYWlucy4NCjIuIFdlIGNhbiB1c2UgbGF0ZXN0IENTUiBu
YW1lcyBpbiAjZGVmaW5lIG1hY3JvIG5hbWVzIG9mIENTUiBudW1iZXJzDQogICBhcy1wZXIgUklT
Qy1WIHNwZWMuIChlLmcuIHNwdGJyID0+IENTUl9TQVRQLCBzYmFkYWRkciA9PiBDU1JfU1RWQUws
IGV0Yy4pDQozLiBXZSBjYW4gYWNjZXNzIG5ld2x5IGFkZGVkIENTUnMgZXZlbiBpZiB0b29sY2hh
aW4gZG9lcyBub3QgcmVjb2duaXplDQogICBuZXdseSBhZGRlcyBDU1JzIGJ5IG5hbWUuIChlLmcu
IEJTU1RBVFVTLCBCU0lFLCBTU0lQLCBldGMuKQ0KDQpUaGUgcGF0Y2hzZXQgY2FuIGJlIGZvdW5k
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjEgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpBbnVwIFBhdGVsICgzKToNCiAgUklTQy1WOiBBZGQgc2VwYXJhdGUg
YXNtL2VuY29kaW5nLmggZm9yIHNwZWMgcmVsYXRlZCBkZWZpbmVzDQogIFJJU0MtVjogQWRkIGRl
ZmluZXMgZm9yIENTUiBudW1iZXJzDQogIFJJU0MtVjogQWNjZXNzIENTUnMgdXNpbmcgQ1NSIG51
bWJlcnMNCg0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY3NyLmggICAgICAgICB8ICA2NyArLS0t
LS0NCiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2VuY29kaW5nLmggICAgfCAyOTkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pcnFmbGFncy5oICAg
IHwgIDEwICstDQogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIHwgICAyICst
DQogYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkuUyAgICAgICAgICAgIHwgIDIyICstDQogYXJjaC9y
aXNjdi9rZXJuZWwvaGVhZC5TICAgICAgICAgICAgIHwgIDEyICstDQogYXJjaC9yaXNjdi9rZXJu
ZWwvcGVyZl9ldmVudC5jICAgICAgIHwgICA0ICstDQogYXJjaC9yaXNjdi9rZXJuZWwvc21wLmMg
ICAgICAgICAgICAgIHwgICAyICstDQogYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYyAgICAgICAg
ICAgIHwgICA2ICstDQogYXJjaC9yaXNjdi9tbS9mYXVsdC5jICAgICAgICAgICAgICAgIHwgICAy
ICstDQogMTAgZmlsZXMgY2hhbmdlZCwgMzM4IGluc2VydGlvbnMoKyksIDg4IGRlbGV0aW9ucygt
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2VuY29kaW5nLmgN
Cg0KLS0NCjIuMTcuMQ0K
