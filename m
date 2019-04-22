Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE895C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA572075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dl+iu4T1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfDVI1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:27:00 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:46981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfDVI07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eejq5ckg8owkzJaow0WCf6asCyl8e3+uYNQuccL2dX4=;
 b=dl+iu4T1niMbLg5oeBaJrUBLPDOCn1TToSpQ+JUB5hUOD2hM1aQVMwe9VY+OAgm+YlcWMHXTn1Xitm3W9rMfzgZHe5oYHt1+tpSXqRqR8uxNLUjqNlliKvlKnJMpsWdLb8mlpBtgHXR6P0LKg0msOPy09IMd37WcWy4t+oH6m6k=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5583.eurprd04.prod.outlook.com (20.178.123.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 08:26:56 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:26:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] scripts/gdb: Initial clk support
Thread-Topic: [PATCH 0/3] scripts/gdb: Initial clk support
Thread-Index: AQHU+OUlD27Q6NU20EiR/EhoElFAzA==
Date:   Mon, 22 Apr 2019 08:26:56 +0000
Message-ID: <cover.1555921081.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.146.100.6]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce0c78fa-6774-42cb-f32c-08d6c6fc47cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5583;
x-ms-traffictypediagnostic: VI1PR04MB5583:
x-microsoft-antispam-prvs: <VI1PR04MB55834D45649958E6B88E0E7EEE220@VI1PR04MB5583.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(68736007)(305945005)(99286004)(4744005)(6512007)(2906002)(54906003)(316002)(110136005)(52116002)(53936002)(7736002)(97736004)(36756003)(386003)(6506007)(102836004)(26005)(66446008)(64756008)(6116002)(8676002)(186003)(71190400001)(71200400001)(66476007)(81166006)(81156014)(86362001)(66556008)(2616005)(4326008)(486006)(66946007)(5660300002)(476003)(73956011)(25786009)(44832011)(8936002)(50226002)(3846002)(6486002)(256004)(6436002)(14454004)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5583;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mPKQMFBQDIVKlpR7lhZ47vARnjoF+7OnNcWo6WMyi4RTgxe0dWENj2ZvDY2IQOf9X5iaYW7qSvHhE7i0z2lGdkSOrsx6Mx9pM7NxFy9VBKNinSKyQvBuQbHNqOOFsctOOJ4lWqfez3aOl9jWXgkOn5W9obL98H5+G26XtirD8PVf24Gwsy2TyqcD6yuNAs+HnLenKHcF9WDLNFetDh8Ad1vxzOAl//Lhc0gbssuWS/6ML+vJLFckjSkSU/EyIPkDxwix/f3ybBhic7ZqtcNVNjZeI59bvj5+Ltz2x1VWnts/jr/T4EsPiIcgHh+Vs3eY7eiu1VjcJwHIGJSdwt6tqbKp6HiBxOklVywTQtyLXSKzvuWTgiYiiDXKoxRNgChBX1HZVy3xWBkkinVkLVCgtBtLhMdImSsjmAH5LpOcLEQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0c78fa-6774-42cb-f32c-08d6c6fc47cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:26:56.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkIHdpdGggb3Blbm9jZCBvbiBpbXggYnV0IHNob3VsZCBiZSB1c2VmdWwgZXZlcnl3aGVy
ZS4gSXQgaXMgY29tbW9uDQpmb3IgY2xrIGlzc3VlcyB0byBsb2NrdXAgdGhlIHN5c3RlbSBhbmQg
bWFrZSAvc3lzIGluYWNjZXNpYmxlLg0KDQpOb3Qgc3VyZSB3aGVyZSB0byBzZW5kIHRoaXM7IHRo
ZXJlIGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGFueSBsaXN0IG1vcmUNCnNwZWNpZmljIHRoYW4gTEtN
TC4NCg0KTGVvbmFyZCBDcmVzdGV6ICgzKToNCiAgc2NyaXB0cy9nZGI6IEFkZCBobGlzdCB1dGls
aXRpZXMNCiAgc2NyaXB0cy9nZGI6IEluaXRpYWwgY2xrIHN1cHBvcnQ6IGx4LWNsay1zdW1tYXJ5
DQogIHNjcmlwdHMvZ2RiOiBBZGQgJGx4X2Nsa19jb3JlX2xvb2t1cCBmdW5jdGlvbg0KDQogc2Ny
aXB0cy9nZGIvbGludXgvY2xrLnB5ICAgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KIHNjcmlwdHMvZ2RiL2xpbnV4L2xpc3RzLnB5IHwgMjMgKysrKysrKysrKysr
Kw0KIHNjcmlwdHMvZ2RiL3ZtbGludXgtZ2RiLnB5IHwgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwg
OTMgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzY3JpcHRzL2dkYi9saW51eC9j
bGsucHkNCg0KLS0gDQoyLjE3LjENCg0K
