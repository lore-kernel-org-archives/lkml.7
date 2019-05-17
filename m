Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E85C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936B520833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KB/z6YqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfEQNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:23:54 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:4955
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbfEQNXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBmXP12jued37Cn2jJr5lyc0BbF57RZiJAI9HflG3d8=;
 b=KB/z6YqG+K6muSue9EjAiVyxZDTOa3jlb/tVH/+Fex+8ZLtvjsqVU8u+pSpWTojCsPPGDhRIWXL4dOVgnbDaC7F53Q6MsWmY6+MIhfB2/+rq5Uuxx5zn4kGzVjuGvPOBnZI3zujNU+JY4QoTvLFcbbNkmDmkj4Ne8y9oT7tS/wY=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3360.eurprd04.prod.outlook.com (52.134.1.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 13:23:50 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f%6]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 13:23:50 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] regmap: debugfs: Fix memory leak in regmap_debugfs_init
Thread-Topic: [PATCH] regmap: debugfs: Fix memory leak in regmap_debugfs_init
Thread-Index: AQHVDLPD+2EIGZgO10q5DmSnHC/t5w==
Date:   Fri, 17 May 2019 13:23:49 +0000
Message-ID: <20190517132324.23603-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::17) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 372570a0-b266-4668-d878-08d6dacae5c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3360;
x-ms-traffictypediagnostic: VI1PR0402MB3360:
x-microsoft-antispam-prvs: <VI1PR0402MB33606D4148276D1CCB6195F7F90B0@VI1PR0402MB3360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(6436002)(478600001)(26005)(305945005)(256004)(2906002)(6916009)(1076003)(25786009)(3846002)(6512007)(54906003)(6116002)(486006)(53936002)(386003)(316002)(2616005)(102836004)(6486002)(71200400001)(71190400001)(476003)(36756003)(52116002)(99286004)(186003)(44832011)(68736007)(4326008)(6506007)(86362001)(14454004)(5660300002)(5640700003)(2501003)(66066001)(66556008)(66946007)(7736002)(8676002)(1730700003)(50226002)(81156014)(81166006)(2351001)(8936002)(64756008)(66446008)(66476007)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3360;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g5JMfg82zALDGWou4ZKdP1TblAyzTjlJIN3WAi2+vP8KZvF3Pg+hdc4smm5fOAat2cxxGabbaZazJI1ziTpttBjNeIbXPi4GSvKuTZPciw4DV7LSfDnORa2jj1pBZrIHAcy5KP1trjuMQSiqBCmoZbLPSRDgOMpWIyllFbC+OUjunll1LQcahIJJ10yelZsBIMOh/E3mDnXTJtuJk4ZyIauQgAodkqNSwXZMmjs7ahZVyuAM4BqW6K8yQfWEB2fA0+HDXT23jUgIM2BgXWrNov/CGja7weJ6EYdktjLBMMkCWBDHw2eGMKcg2OpKEdz4RSCT8CnqAe8zu5jxTs/YuICV/IR9WNYN4nVKfLGeJZU1Igl9BOZc5fqaLD0EJLvmVDGp0oemfIi/NFBE6pBH+mjD/MY3nfdm6MfvRL5if3Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <382881C5698B314BB69FE10453BC256B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372570a0-b266-4668-d878-08d6dacae5c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 13:23:49.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As detected by kmemleak running on i.MX6ULL board:

nreferenced object 0xd8366600 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937370 (age 933.220s)
  hex dump (first 32 bytes):
    64 75 6d 6d 79 2d 69 6f 6d 75 78 63 2d 67 70 72  dummy-iomuxc-gpr
    40 32 30 65 34 30 30 30 00 e3 f3 ab fe d1 1b dd  @20e4000........
  backtrace:
    [<b0402aec>] kasprintf+0x2c/0x54
    [<a6fbad2c>] regmap_debugfs_init+0x7c/0x31c
    [<9c8d91fa>] __regmap_init+0xb5c/0xcf4
    [<5b1c3d2a>] of_syscon_register+0x164/0x2c4
    [<596a5d80>] syscon_node_to_regmap+0x64/0x90
    [<49bd597b>] imx6ul_init_machine+0x34/0xa0
    [<250a4dac>] customize_machine+0x1c/0x30
    [<2d19fdaf>] do_one_initcall+0x7c/0x398
    [<e6084469>] kernel_init_freeable+0x328/0x448
    [<168c9101>] kernel_init+0x8/0x114
    [<913268aa>] ret_from_fork+0x14/0x20
    [<ce7b131a>] 0x0

Root cause is that map->debugfs_name is allocated using kasprintf
and then the pointer is lost by assigning it other memory address.

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/reg=
map-debugfs.c
index 263f82516ff4..e5e1b3a01b1a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -579,6 +579,8 @@ void regmap_debugfs_init(struct regmap *map, const char=
 *name)
 	}
=20
 	if (!strcmp(name, "dummy")) {
+		kfree(map->debugfs_name);
+
 		map->debugfs_name =3D kasprintf(GFP_KERNEL, "dummy%d",
 						dummy_index);
 		name =3D map->debugfs_name;
--=20
2.17.1

