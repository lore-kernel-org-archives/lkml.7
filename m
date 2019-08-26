Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5672EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DA72342A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BGQbRv/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfHZMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:31 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33290 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfHZMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:10 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: b2VO+xxIKFb1CuCNtQ0a28mRRQ4CENRjBCiwKiXRVoYQvflenQQ3BOX65rRkjfcHjr+pdBuJmR
 MIcKl62wGvEQ92lzbduQp+Iudov6o8APhcpVH+fF4Zo/Yg1kmjoLg7GzDAgMvi9+uJbVgIl/MX
 tuOJn9eEQJLyJ4dm+4ijcuuD35nxwdU3JAFyZyevrMMIcnl2JSJzBCbk+wjO9PszEVEHgnP7r8
 wsVRw++65M67vlTC4t+GLLuzqiGxGcVijv1UKj5roDOkCVZDsv/ycXz/NT7yCZT5MAunVp38er
 iUI=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46520796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNS2oYdUoEWrjEQ3tEhhQ/rDqqmiIk7okcacacAJspCOi3yYyIvkCum5KknIblW5aiis1M9GwQWuSNVUm7Cav15D4h+JuAjs5l+hUaKlzp4e+STZc3kDogtQ3pOpMd1TlDZPgcd4d+Xh2yqM6fJVz5Woz930PJLhVE6w2lil1jI6NmGFkFetkGwXgRMSG3uxWquxDR7zQ2QR7PzclMudBTrAtTQyGBwT+fzGBd+1VvV6NbXyDgYaC8C1+ozqDMFAaLTQH7lH+l6UnPPF36jTtn1JVLRS1/A5OeZ/DpGoBgKwzdI4C15+hAV01O6JC7T2EU1Emfq89mbbXJEO+FmFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teywPRmKxNCHDCqoMd8uKvncvMQgIAjI6tlFv8GhTDU=;
 b=C7X89nduv/dDjWW7KjmTUNK1ivf8x9gXMhAmAyMNgpPgn6EO07Ic9NkIrtFzlCjz7Pm2DxrEeTsVLtk1lVSULQH2MGdhUG25iQQ5HCfeM0i1A8wQIwaCb149voabUCLhBaSrhWUpKT3JfO58OS8DJu9v9ZNC7aBnQ3QxYjj9Q5CwvAlGQG+DzYfMhd0nDjczRrmlx3oAI1oTkMagIEBxHBUoN1M9SF0ZCpu8Q/35l5d1ZN5qT1WzjUWECUZaCpOYNQEJnAIyqnCmBezelP6OYjJo/1hU5BuBITYFoWpZ2gG642udyz5V4nBgbx7kA6pJHYazjNRr7kLOFptm5QrJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teywPRmKxNCHDCqoMd8uKvncvMQgIAjI6tlFv8GhTDU=;
 b=BGQbRv/qpRnNGpv2yOwlSbo+YpL1svACu+DuPCCUOrvLQiXO41z1ENMYH1J5zgdkyB+VUXyoIJQs86aZKLyizKj0LiLfAUy1uqvaAiiEg6R+yZ7YrZD84oEWZGbLS1w1QHkCIVFOckkhBQVeYzdSmm21yLnC37i9t0V8bkcP+k8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 18/20] mtd: spi_nor: Introduce
 spi_nor_set_addr_width()
Thread-Topic: [RESEND PATCH v3 18/20] mtd: spi_nor: Introduce
 spi_nor_set_addr_width()
Thread-Index: AQHVXAcO02WZRVSyz024bw8uo4qH9g==
Date:   Mon, 26 Aug 2019 12:09:05 +0000
Message-ID: <20190826120821.16351-19-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:28::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23377e7b-e457-447f-d426-08d72a1e30f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36784C773C38B66FEF689701F0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(52116002)(6666004)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cYq+6vIutXNSRxe4vZYEOezs1abEsUpqnZZoegUyPJESMpf9fn/I6lqIBhlpjjUo+TtIq0y3LGS/Eg080yXGnV7nEyk1UGzWfUiDAv81vxz2A2bshs6m8yh8VxaqaRBu5P5N3DTua7C4smqDCH7J6gMaDaW4IR1P9fQQmvaEh8vL7/q5EgTojbMx1q+Pqkp1nAt0iHvUo9vZ43lOQYopPqEUhtKPekd239ES8tHU5GhKLf28MjrWpz1UjcMa9lcTLMiBcCHtrBUUmjl5gFuwtm5kfvsAC+/T5uhmpmySwz3agrfft3X2DsJjt8oTfHufP6Xwz2SQVQV4czZRfSsLtI5gRgiQLNR3HWVq909OW1yvPkPnLfzqtt5tPa+1Lz9pCZoNoGlX+bGzv9jW8HxI3YmOoUu6zHavU6Sr3xbnw48=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23377e7b-e457-447f-d426-08d72a1e30f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:09:05.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2Pz4AXKn8vilZDd8euInAzbBH1a6VqpgIm/8fH37H7HQ6sKZzymhlo6zLFroIWccvHRXjEcIOfKpeHOCVLbfk/TX3LQKj1u1uZ9HqKPVQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Parsing of flash parameters were interleaved with setting of the
nor addr width. Dedicate a function for setting nor addr width.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: no changes

 drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index dcda96a20f6c..d13317d1f372 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4739,6 +4739,33 @@ static const struct flash_info *spi_nor_match_id(con=
st char *name)
 	return NULL;
 }
=20
+static int spi_nor_set_addr_width(struct spi_nor *nor)
+{
+	if (nor->addr_width) {
+		/* already configured from SFDP */
+	} else if (nor->info->addr_width) {
+		nor->addr_width =3D nor->info->addr_width;
+	} else if (nor->mtd.size > 0x1000000) {
+		/* enable 4-byte addressing if the device exceeds 16MiB */
+		nor->addr_width =3D 4;
+	} else {
+		nor->addr_width =3D 3;
+	}
+
+	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
+		dev_err(nor->dev, "address width is too large: %u\n",
+			nor->addr_width);
+		return -EINVAL;
+	}
+
+	/* Set 4byte opcodes when possible. */
+	if (nor->addr_width =3D=3D 4 && nor->flags & SNOR_F_4B_OPCODES &&
+	    !(nor->flags & SNOR_F_HAS_4BAIT))
+		spi_nor_set_4byte_opcodes(nor);
+
+	return 0;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -4885,29 +4912,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 	if (ret)
 		return ret;
=20
-	if (nor->addr_width) {
-		/* already configured from SFDP */
-	} else if (info->addr_width) {
-		nor->addr_width =3D info->addr_width;
-	} else if (mtd->size > 0x1000000) {
-		/* enable 4-byte addressing if the device exceeds 16MiB */
-		nor->addr_width =3D 4;
-	} else {
-		nor->addr_width =3D 3;
-	}
-
 	if (info->flags & SPI_NOR_4B_OPCODES)
 		nor->flags |=3D SNOR_F_4B_OPCODES;
=20
-	if (nor->addr_width =3D=3D 4 && nor->flags & SNOR_F_4B_OPCODES &&
-	    !(nor->flags & SNOR_F_HAS_4BAIT))
-		spi_nor_set_4byte_opcodes(nor);
-
-	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
-		dev_err(dev, "address width is too large: %u\n",
-			nor->addr_width);
-		return -EINVAL;
-	}
+	ret =3D spi_nor_set_addr_width(nor);
+	if (ret)
+		return ret;
=20
 	/* Send all the required SPI flash commands to initialize device */
 	ret =3D spi_nor_init(nor);
--=20
2.9.5

