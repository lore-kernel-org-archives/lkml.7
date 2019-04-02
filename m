Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE9920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="umFlkWm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfDBIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:01:26 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:21091
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfDBIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNXycKjCy6tlTFfpUnoY+O2zwl94Dr2MiOJmgK8zYDw=;
 b=umFlkWm5V2grioKF0ILrEJ5ultDJhhSd3XS3qdvdblIlr41dLD+de6tM6LYSSwBfdSGGrufJfpD8X4LIVo/Eg426qnFUXh7dgtuqgMRzfo881CATTIB3AE7i6Rd4AzVWpnVRKGPcbcf9E/hYBI6CpkKPYjC+l7UrsgQ1d/osrlY=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB5467.eurprd06.prod.outlook.com (20.178.84.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 08:01:22 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%5]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 08:01:22 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [RFC PATCH 1/1] regmap: verify if register is writeable before
 writing operations
Thread-Topic: [RFC PATCH 1/1] regmap: verify if register is writeable before
 writing operations
Thread-Index: AQHU6SpDEml42faHk0mW1d8iFyaNgA==
Date:   Tue, 2 Apr 2019 08:01:22 +0000
Message-ID: <20190402080100.4875-2-nandor.han@vaisala.com>
References: <20190402080100.4875-1-nandor.han@vaisala.com>
In-Reply-To: <20190402080100.4875-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0046.eurprd04.prod.outlook.com
 (2603:10a6:3:19::14) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb1103ab-a698-4b2b-4a08-08d6b7416590
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR06MB5467;
x-ms-traffictypediagnostic: DB7PR06MB5467:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB54675F6EB385AD72FC17BAAE85560@DB7PR06MB5467.eurprd06.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(189003)(199004)(6506007)(2616005)(97736004)(106356001)(71190400001)(11346002)(256004)(446003)(6436002)(50226002)(81166006)(476003)(2501003)(14454004)(105586002)(186003)(71200400001)(8936002)(53936002)(386003)(486006)(6512007)(6116002)(3846002)(76176011)(52116002)(25786009)(15650500001)(2906002)(305945005)(102836004)(4326008)(2201001)(86362001)(99286004)(68736007)(66066001)(107886003)(7736002)(1076003)(478600001)(8676002)(316002)(26005)(5660300002)(14444005)(36756003)(81156014)(6486002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB5467;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 96KPH2aP2Sgnkf8bGA9gIX9MQp71lILluKjXTjEEsPpQn2/2i1L56XLaIlT9mT9AOstamKab3uKuN1qVfsqgdztNiXL8pC8jzwqQvuAKYBojzYB9HghqBKMbrLxiU7sCNCo9bwAXSBxEiqgDZTFhhlap38V0kV9kjym4dURgzJOzqNi8thZzO02eyFSlfAC7TeaEU9D0+vCivO4anrQQ5+viO2uRpSqazCUaa9JKQaLSSYnoJap/7hfUtYASypjKKlkDEWV1xas1VsJd1swarinSUmjpbZq1S6GgCBcfCltk2cDOyFQzmX5OE/gLQxx7wM2cp6BWObrRMSxCLLhaTMbFl9q5h1CYy2zs96JJgmEubfNGLAbaMVWWziXQXiN9UWLJqydVR24t/Qo4wF878V9MKbOibgajCC4r2ri81oc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1103ab-a698-4b2b-4a08-08d6b7416590
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 08:01:22.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap provides a couple of ways to validate the register range used.
a) maxim allowed register, b) writable/readable register tables,
c) callback function that can be provided by the driver to validate
a register. regmap framework should verify if registers
are writeable before every write operation. However this doesn't
seems to happen in every situation.

The method `_regmap_raw_write_impl` is only using the `writeable_reg`
callback to verify if register is writeable, ignoring the other two.
This can lead to undefined behaviour since this allows to write to
registers that could be declared un-writeable by using any other
option.

Change `_regmap_raw_write_impl` to use the `regmap_writeable` method
to verify if registers are writable before the write operation.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 drivers/base/regmap/regmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4f822e087def..42d8404bc8cc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1493,11 +1493,10 @@ static int _regmap_raw_write_impl(struct regmap *ma=
p, unsigned int reg,
 	WARN_ON(!map->bus);
=20
 	/* Check for unwritable registers before we start */
-	if (map->writeable_reg)
-		for (i =3D 0; i < val_len / map->format.val_bytes; i++)
-			if (!map->writeable_reg(map->dev,
-					       reg + regmap_get_offset(map, i)))
-				return -EINVAL;
+	for (i =3D 0; i < val_len / map->format.val_bytes; i++)
+		if (!regmap_writeable(map,
+				     reg + regmap_get_offset(map, i)))
+			return -EINVAL;
=20
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
--=20
2.17.2

