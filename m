Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71913C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B811217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LoStr+Y9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VuwucUpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfDYIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:39:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29356 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556181509; x=1587717509;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=BU3jWJhcqMptiOKubIpzVh0ucOgBAC1uG527PRawgLE=;
  b=LoStr+Y9diylGVHzKm/o/HpPkDbWgskBU9n/CgOZzX0d38fw2HfXbo2p
   0+CHaHlKkLp/MdK7dxKPDgUH74V0TmqRC4FGWxn2cETeEGHZz8c0XaefV
   pvf/yJSma6a6oPdk4hpQFUEn1eY4g8aAHo/wPB9nQZWxF9W860ASdOVtM
   CzyHBOXOzTbPfPmyeux6R4crezARis7GISCdYLW3K1pbeyRsOQQJi23Re
   SrgJ4NdtFYj/QvQwfZLAute8it1gR5hXdgBWtKUxk0RcJ4p9xGxep7QZk
   a01Jqtc/26ZIBIq81jijc1u/bRSNcJiEl7yAM8110kv2jhL0aeSPOSSb7
   w==;
X-IronPort-AV: E=Sophos;i="5.60,393,1549900800"; 
   d="scan'208";a="108506783"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 16:38:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU3jWJhcqMptiOKubIpzVh0ucOgBAC1uG527PRawgLE=;
 b=VuwucUptEow2Zk+rd/emUzhBgTOuVOBIGzy5hNckmsUDqOV6b2YIKuiH1D2U0nER49v9fC1OqRxrrgnWKZWyRBa1JIVgD/EJyJOmG+bASzXjLYSx+yyiJv0cvInqg7O9hVqRhtdBWRzATKMLqF1ymstxiaBCvCYUl0Pe37FIYLA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5485.namprd04.prod.outlook.com (20.178.248.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 08:38:25 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:38:25 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v6 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH v6 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU+0I/yOG3HNRdnEGYGUxzrL33Bg==
Date:   Thu, 25 Apr 2019 08:38:24 +0000
Message-ID: <20190425083804.11991-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 6033ff1b-9dcc-4f0b-b25f-08d6c959618c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5485;
x-ms-traffictypediagnostic: MN2PR04MB5485:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB54859E3AE4DD0FC0C83E41E88D3D0@MN2PR04MB5485.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(99286004)(36756003)(66066001)(8676002)(81166006)(6486002)(71190400001)(6512007)(8936002)(478600001)(7736002)(50226002)(81156014)(71200400001)(6436002)(97736004)(305945005)(72206003)(86362001)(14454004)(6506007)(14444005)(186003)(6116002)(486006)(44832011)(25786009)(66446008)(52116002)(2906002)(102836004)(4326008)(73956011)(66946007)(26005)(110136005)(2616005)(1076003)(53936002)(386003)(476003)(64756008)(3846002)(54906003)(68736007)(256004)(66476007)(66556008)(2171002)(5660300002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5485;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FX9+LPL9BPMetvRhp9zVvTo/R7W9MUjYTg05roPNeAYwdv/EFEhUS4M5LHgXVThoezbjaZEXAUuDgeUZzKkEihYV+/iT11TTGMf1F9gEPcymKFksPJBvV0+vdaoN2yhjiCSgWzBlwFznSQWh7r+x4ysjdNtK/dTGyqHLwqVj7ayyKpVfr9DBtH0PkUE8x2sgW/1ioBgXvnEbTzaoAfgo5M9I0KKzaMBD6aUgwVGCTj0skB1xMO1R4115GL5aNJ2IWxI2I3YQF9TsaIT8aq3Dqf+BSxPzkg9QZJbasxlYWJRWQYwusN6j1l4T1bLjLvlr6BBsjMhNrIF0JEVSz83FQxgnBqAxXCMuNhSLBzyNxbfhQSyxPuN9wEVpdcWCanrjX/DpmEhbLZulAjN/5Qz9v5Q/q/qEmRDU/QNnHckN4/g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6033ff1b-9dcc-4f0b-b25f-08d6c959618c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:38:24.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5485
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
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjYgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpDaGFuZ2VzIHNpbmNlIHY1Og0KIC0gRHJvcCByZWR1bmRhbnQgSU5U
RVJSVVBUX0NBVVNFX0ZMQUcgZnJvbSBrZXJuZWwvaXJxLmMNCg0KQ2hhbmdlcyBzaW5jZSB2NDoN
CiAtIEV4cHJlc3MgU0NBVVNFX0lSUV9GTEFHIGluLXRlcm1zIG9mIF9fcmlzY3ZfeGxlbg0KDQpD
aGFuZ2VzIHNpbmNlIHYzOg0KIC0gS2VlcCBvbGQgSU5URVJSVVBUX3h5eiBkZWZpbmVzIGluIGtl
cm5lbC9pcnEuYyBmb3IgUEFUQ0gyDQoNCkNoYW5nZXMgc2luY2UgdjI6DQogLSBEcm9wcGVkIFBB
VENIMSB3aGljaCBhZGRlZCBhc20vZW5jb2RpbmcuaA0KIC0gQWRkZWQgbmV3IFBBVENIMSB3aGlj
aCBiZWF1dGlmaWVzIGFzbS9jc3IuaCBieSB1c2luZyB0YWJzIHRvDQogICBhbGlnbiBtYWNybyB2
YWx1ZXMNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIFNxdWFzaCBQQVRDSDIgaW50byBjcGF0Y2gz
DQogLSBBZGRlZCBuZXcgUEFUQ0gyIHRvIGFkZCBpbnRlcnJ1cHQgcmVsYXRlZCBTQ0FVU0UgZGVm
aW5lcw0KICAgaW4gYXNtL2VuY29kaW5nLmgNCg0KQW51cCBQYXRlbCAoMyk6DQogIFJJU0MtVjog
VXNlIHRhYnMgdG8gYWxpZ24gbWFjcm8gdmFsdWVzIGluIGFzbS9jc3IuaA0KICBSSVNDLVY6IEFk
ZCBpbnRlcnJ1cHQgcmVsYXRlZCBTQ0FVU0UgZGVmaW5lcyBpbiBhc20vY3NyLmgNCiAgUklTQy1W
OiBBY2Nlc3MgQ1NScyB1c2luZyBDU1IgbnVtYmVycw0KDQogYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9jc3IuaCAgICAgICAgIHwgMTIzICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIGFyY2gv
cmlzY3YvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCAgICB8ICAxMCArLS0NCiBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL21tdV9jb250ZXh0LmggfCAgIDcgKy0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9lbnRy
eS5TICAgICAgICAgICAgfCAgMjIgKystLS0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgICAg
ICAgICAgICAgfCAgMTIgKy0tDQogYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMgICAgICAgICAgICAg
IHwgIDE2ICstLS0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9wZXJmX2V2ZW50LmMgICAgICAgfCAgIDQg
Ky0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9zbXAuYyAgICAgICAgICAgICAgfCAgIDIgKy0NCiBhcmNo
L3Jpc2N2L2tlcm5lbC90cmFwcy5jICAgICAgICAgICAgfCAgIDYgKy0NCiBhcmNoL3Jpc2N2L21t
L2ZhdWx0LmMgICAgICAgICAgICAgICAgfCAgIDYgKy0NCiAxMCBmaWxlcyBjaGFuZ2VkLCAxMTEg
aW5zZXJ0aW9ucygrKSwgOTcgZGVsZXRpb25zKC0pDQoNCi0tDQoyLjE3LjENCg==
