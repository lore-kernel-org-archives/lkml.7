Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9256218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cIs0GbvS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R4TWqIA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbfDYFuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:50:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26629 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfDYFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556171443; x=1587707443;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rpildqgy8o5UmVecA6pVi+IR582CkbrPqwkLNiXaLMk=;
  b=cIs0GbvSvTj6Z+JUoPCKjqlJb5rZokvI78X6iZ09AiRqvfhIYKg+sSvS
   am05r0oKHddLrEamGG+lnr1zsokkRmhpTcQBgCxgqikI7cFA1yF/bkrFj
   DoclVZNC/1VPtJWjRCroMghVdRnaApLD5oUzRx7x93O38UqCruThcB9T3
   q+I53Iu7HpjESarjly8W8jBSbyzITaW8UqEVyozhLNZlYS9/OU84Qch1/
   prIjsF3js/OLOceHnQEwlYyg8iWNkJVNULYrEE8LSeGjvKAS8VfEDNWWF
   HMe/5uGnKCl0zIMiVsXt8DgsMDBnctzumfnPJqTedw9CYuwvd998LQOIc
   g==;
X-IronPort-AV: E=Sophos;i="5.60,392,1549900800"; 
   d="scan'208";a="111723154"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 13:50:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpildqgy8o5UmVecA6pVi+IR582CkbrPqwkLNiXaLMk=;
 b=R4TWqIA1Mxj4SXl++c8puwQF5tGkFll8GcEylCCdTfqgqcmwXd4G5GQDyddNR4fF0iKmJWnzXQ1ZghtJKOj/5CY6mSvvZmNhsZOeONQYI21QshwQiuA6I3XkcaCJFPrDkM/Uq39VFr3DTUR8QMRaAeG3HucI3lNC8phObKDDmAU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5552.namprd04.prod.outlook.com (20.178.247.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 05:50:40 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 05:50:40 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 0/3] Allow accessing CSR using CSR number
Thread-Topic: [PATCH v4 0/3] Allow accessing CSR using CSR number
Thread-Index: AQHU+yrQT0ofH6i420urVRWglJkVYw==
Date:   Thu, 25 Apr 2019 05:50:40 +0000
Message-ID: <20190425055015.45487-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 2dfedd7d-fdad-4e61-a25c-08d6c941f2b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5552;
x-ms-traffictypediagnostic: MN2PR04MB5552:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5552A8B1DECD942A04CC1ACE8D3D0@MN2PR04MB5552.namprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(6486002)(1076003)(2616005)(476003)(14444005)(486006)(50226002)(256004)(66066001)(7736002)(305945005)(73956011)(2906002)(72206003)(14454004)(478600001)(6436002)(3846002)(6116002)(66476007)(316002)(64756008)(66446008)(66556008)(66946007)(54906003)(110136005)(6512007)(8676002)(6506007)(386003)(71200400001)(71190400001)(186003)(86362001)(4326008)(102836004)(68736007)(2171002)(5660300002)(81166006)(26005)(81156014)(53936002)(8936002)(97736004)(52116002)(25786009)(99286004)(44832011)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5552;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tfB/ucMA5oqtudkwCITOiNbCvr3NP+opL3G3JWhsT/+GmDHS4PvDsdw5oAMawF1a1wQfHq2y88qE9BWUM9LQKqkE36bri0gigbLWLuFHTox4wYcJxO5VfPK8Ug7Xw/0rXju4W0FSFwKY6vqxB0lNvZt9xvGac2WqIeB/uPUC59Xo9ntZmOxJHTJFHhtpChmRLl56M0NZVySkpLBl1mWyPp8I/MGR2NcTBrHzMwlraky1tyx9ki41gQ9pDgPn6M1O8EAfGSZIcpbTYOMc3ZNCWiFcoZn4PiPPvJ6ljexDBRkFzyhvzwB/RgVmp/7b+fvEtwMmv4mOQr1V+/Q7kBft1YDsrr8XWxpZZjPbQqBnOejB/0pDsVjKuj/7mM4kuoXPtCXuEsZluRG9o8Aob3RKyArZfHjXQmNy6BDfjlFw+38=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfedd7d-fdad-4e61-a25c-08d6c941f2b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 05:50:40.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
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
IGluIHJpc2N2X2Nzcl9udW1iZXJfdjQgYnJhbmNoIG9mDQpodHRwcy8vZ2l0aHViLmNvbS9hdnBh
dGVsL2xpbnV4LmdpdA0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KIC0gS2VlcCBvbGQgSU5URVJSVVBU
X3h5eiBkZWZpbmVzIGluIGtlcm5lbC9pcnEuYyBmb3IgUEFUQ0gyDQoNCkNoYW5nZXMgc2luY2Ug
djI6DQogLSBEcm9wcGVkIFBBVENIMSB3aGljaCBhZGRlZCBhc20vZW5jb2RpbmcuaA0KIC0gQWRk
ZWQgbmV3IFBBVENIMSB3aGljaCBiZWF1dGlmaWVzIGFzbS9jc3IuaCBieSB1c2luZyB0YWJzIHRv
DQogICBhbGlnbiBtYWNybyB2YWx1ZXMNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIFNxdWFzaCBQ
QVRDSDIgaW50byBjcGF0Y2gzDQogLSBBZGRlZCBuZXcgUEFUQ0gyIHRvIGFkZCBpbnRlcnJ1cHQg
cmVsYXRlZCBTQ0FVU0UgZGVmaW5lcw0KICAgaW4gYXNtL2VuY29kaW5nLmgNCg0KQW51cCBQYXRl
bCAoMyk6DQogIFJJU0MtVjogVXNlIHRhYnMgdG8gYWxpZ24gbWFjcm8gdmFsdWVzIGluIGFzbS9j
c3IuaA0KICBSSVNDLVY6IEFkZCBpbnRlcnJ1cHQgcmVsYXRlZCBTQ0FVU0UgZGVmaW5lcyBpbiBh
c20vY3NyLmgNCiAgUklTQy1WOiBBY2Nlc3MgQ1NScyB1c2luZyBDU1IgbnVtYmVycw0KDQogYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9jc3IuaCAgICAgICAgIHwgMTI3ICsrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCAgICB8ICAxMCAr
LS0NCiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmggfCAgIDcgKy0NCiBhcmNo
L3Jpc2N2L2tlcm5lbC9lbnRyeS5TICAgICAgICAgICAgfCAgMjIgKystLS0NCiBhcmNoL3Jpc2N2
L2tlcm5lbC9oZWFkLlMgICAgICAgICAgICAgfCAgMTIgKy0tDQogYXJjaC9yaXNjdi9rZXJuZWwv
aXJxLmMgICAgICAgICAgICAgIHwgICA4ICstDQogYXJjaC9yaXNjdi9rZXJuZWwvcGVyZl9ldmVu
dC5jICAgICAgIHwgICA0ICstDQogYXJjaC9yaXNjdi9rZXJuZWwvc21wLmMgICAgICAgICAgICAg
IHwgICAyICstDQogYXJjaC9yaXNjdi9rZXJuZWwvdHJhcHMuYyAgICAgICAgICAgIHwgICA2ICst
DQogYXJjaC9yaXNjdi9tbS9mYXVsdC5jICAgICAgICAgICAgICAgIHwgICA2ICstDQogMTAgZmls
ZXMgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKyksIDg5IGRlbGV0aW9ucygtKQ0KDQotLQ0KMi4x
Ny4xDQo=
