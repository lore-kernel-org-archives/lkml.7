Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B35C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C64420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wC+bPskE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfCFGbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:31:00 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:11489
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729052AbfCFGa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukNEdK0riXpPc10OFBxPv/1trFn2JgPClf9gK6MY3v0=;
 b=wC+bPskE64ziu39aY4ID+xdBQydvyqPZ+nFsJQJHRd9+hFRaufSsnVFv29vNMN/uXL3i8nvIu1IiP1b4gpYax0G67ZFvyRvqFyCmcdDymGA5Sld+dHExIZpjrxueSnKjiTtG/MYGP9h8Dj0/WDjEvcgJqtdT2XLpHDoubd2PjrY=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:47 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:47 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 7/8] spi: lpspi: Add the missing NULL check
Thread-Topic: [PATCH V2 7/8] spi: lpspi: Add the missing NULL check
Thread-Index: AQHU0+Yixo4aIJF2cE68MUX+Dtp80Q==
Date:   Wed, 6 Mar 2019 06:30:47 +0000
Message-ID: <20190306063020.793-8-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc5d0619-4c38-47d2-57c7-08d6a1fd448c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:UjyPGAmDFv7ropkX9H5ySx8LJgzib+ucJYVk5hn?=
 =?iso-8859-1?Q?ZLNk2oPhpbXcAd+rZYoSzaUjXxqFxV+wizLOVD9aJXdPPHKhtiX2TMmOCp?=
 =?iso-8859-1?Q?R07ou+hDMj96Hxgxrh6U8f+Qo52fwZxsZ01ufiCiXuPRgSQuuIwlotsUSi?=
 =?iso-8859-1?Q?s+jl1Mmd1hYR6uX1ARHy8BLwkEX4SNaJoy0XBuJl0gvHaartGOpfBmDQE3?=
 =?iso-8859-1?Q?/TfzsZ9OH+seKfFsD4J6Vm1CvnpOArSeu+ayRRcFWaU+fR1mrvbFPMV4pK?=
 =?iso-8859-1?Q?3PAFNqEA0sBFlLLSjl3Qxnfk3pYZD5lUj3a3jrrWTPOE1njpCmc5gRASFu?=
 =?iso-8859-1?Q?IjLGV86p1VkymUFcHALqjpO8xqcWKZ4osK5Yjc0mDLLypEdqF84mCc9r9y?=
 =?iso-8859-1?Q?GKBxHKgdm0MrCr8E770OfFQXzsvWhNG2CWx5+UmjSZPrcld9Oanj7tXH3O?=
 =?iso-8859-1?Q?m6LQed7KJGgnvO4uem0R77P1ZabhfAm1b/0uK+Cvd/F4jg20i/LLyGPNJx?=
 =?iso-8859-1?Q?IypJ/guNkJ3m0x0tRXelxf9j311zwKn/nqjhgbM31qntPJWFz7BdF9DEoj?=
 =?iso-8859-1?Q?Q9Hn3lxfUCCqvmzzhIxEfLm9nzVnC4P5DppH1usnlDvPqwED5BkK3JzUWc?=
 =?iso-8859-1?Q?dTLvJknt5i1keOzXzqdfnVw9EiTWVL/pYcw5smVlvmQ2IcFhA3c48Xh4rM?=
 =?iso-8859-1?Q?xT1z3RFJLqP85F7MTOvwznautMAH+Bss84S5wPIdL0Gq74n3UqizG0j7vK?=
 =?iso-8859-1?Q?ElF+g2bmFVudwr0V2SQutB0eM7KdysOKCTq4ymt3H+idU+BIQ3R1z86Hrx?=
 =?iso-8859-1?Q?XNCxYzN3lFLbFybT6g1ZV5ua7bgzDcma62fMJkHOiRA9P5y2ntyjv4XQcb?=
 =?iso-8859-1?Q?qIE3zKjCvB0cmwoSexXMPJyxOYUebFLmP1BG60b9UOXvwp9l22TWwQI4D1?=
 =?iso-8859-1?Q?Y9SDbvAdrkuBEkFoM+tD2MDLCkiafa+NWaoRy7YPOJ5zsc/xR0wfFCfwbX?=
 =?iso-8859-1?Q?GrT5fjQTVtisdPg/Uz00NnS/gxUNidTnFI0ItKDvfBoSKJK2UuTUIV0ku8?=
 =?iso-8859-1?Q?yO3TEUfhZHCmmPtlQUIpPN2w/0XYqQBr9bqhSZsCYg4fZdvq/UHk5jm6CY?=
 =?iso-8859-1?Q?IkDlKlvGbfdEX7glNKsi2PJHvpUUiS2J6G9+ziRoPIzRFHANSXlM0L0Vh9?=
 =?iso-8859-1?Q?f+RzUPjRjqY7TvbV4vN3TyTx83I40Uof+Sly7SvDkf6MEzsLt1y8rRzS2X?=
 =?iso-8859-1?Q?3b6sDrMcpjKQC/nhq+b6A6c9DMJRbCeIPak9yNAy+n94tJAE8d8unVVUp5?=
 =?iso-8859-1?Q?EwLBQwwH2EJW2u5dUs0J0uEc2V6XVsZU0kMdduH7eveQQ=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB4373F28603FE9BDE6C7DA6BFF3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8wZNWMtjfAZJBn9ciVRgTaAk3K4O8ieKGsllxELs8lsOHnVbNhDtyLsJs8Y1u1JePjYxeLdoMSninU9uWbcIvPHLnWzfsWyM7qlCqGmP0xh7Ubw+dz6v3/R9iFqcb8T0e4NmrDWHi94qY0SUxhVZr5DpJoMXlozaixGdgc6FqgDieGc0kQHNE0o9rwIPoEUCKnoUaVkAfR1yjcUBSeBpDGJG0ITK6DRIj9OOOf6Z/3WwTr1ijFmkCfjLUGa1cBZ/Mr0d8aJHP9kowOMc0SWhEBZNEJkK0+REn18cVXs/Alf4rJQDRvC+NEVjdbr3XDiQeH9NdBXEmm9FCi52WAk33u1Tf4rOFZz6lT3+LTTMTGuKoc71QsGckZv5hs55rGruZ0KguIKldMBHUHIgcN0/tr4SUotcZqkmMzV4NeOowRg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d0619-4c38-47d2-57c7-08d6a1fd448c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:47.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi_transfer *t will be used in one transfer whatever. If t is NULL,
there has no need to try sending data, so add an error return here.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
---
V2:
 - add this patch in this version
---
 drivers/spi/spi-fsl-lpspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9ff32fb67a29..2ac3ac5ea50a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -438,9 +438,12 @@ static int fsl_lpspi_setup_transfer(struct spi_control=
ler *controller,
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(spi->controller);
=20
+	if (t =3D=3D NULL)
+		return -EINVAL;
+
 	fsl_lpspi->config.mode =3D spi->mode;
-	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
-	fsl_lpspi->config.speed_hz =3D t ? t->speed_hz : spi->max_speed_hz;
+	fsl_lpspi->config.bpw =3D t->bits_per_word;
+	fsl_lpspi->config.speed_hz =3D t->speed_hz;
 	fsl_lpspi->config.chip_select =3D spi->chip_select;
=20
 	if (!fsl_lpspi->config.speed_hz)
--=20
2.17.1

