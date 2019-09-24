Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE9C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE51214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RDD3Hgm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503941AbfIXHqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:52 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18442 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438742AbfIXHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:48 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bdjAl3UPD8OsWsGvbIErvqPj3UQKN2Jut3auqZp65CBKSm+Fap7oWb61Qy4JJb5HuONVJLwbkG
 3+rjErLb7J8/DIjwnqkMlOQrzG15N5RYWXXOZ8AlbyYtbdyGa4mI1x5p0JPVIKKYFbga2dnsm4
 DjASstyw72ILSkJqtiGTGB0rd8hNoF00LjBcSquzCOuWpJosDXDbvht8nd/F+pSiiB+DVLDpl4
 gLFIP5nXxMuDAUq6G9Xj59ZyQpysFcTO4oBS5Cp0MlXFhNyUND9/vARR8TrPER3j/7xP48s3qi
 HLY=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="49066195"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOqMBTbbekoHXm7GjWJ+FTwLtiqEqMZDJxFdHY1/ErcYs1NmjuC0XUAXMNmMmQ++h3vd5zI/9S5NFit8Z5gZIx8B55ERojtu31VweAI1D/QwA3M1pHSpBO+b0asv4L4coZcljoOylBPzaStr7QdzaaR+PBdJAA2eTm4L31GYe6kthHSBapeKCfKNGAdmhGgM7THuG85Y+Z2A1tnOT5FdPcFY0p7nl4kOQDBGZ82QLno/4nb5OZ9apZzlqhKXax7/12q9JHXlZWVQyQafCj3TeBsI77eoUGjypq/8y9/i4fmjTw5dJnYw25ArR/xl1OcpAnwpjmLDxf/BrFjtsNyUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/JQqCwKWHa+thZi6BbGu87sx9883Lw02e8xwZUj3VU=;
 b=fpPZmB2OrwXCj8mYH+kgaptbCtCo6878Mjii/gYxCDab/dxBnHGEJ7Oiz8k7J/J2ruZL74idOaBbRJWGLLnfiRt8AtiItL0bB/LantlSa6Rdjg2O2ljks2u3moQ37Geu9Xma5SkLEKp3nD3Sb7VfIQLfocU7FhfEPwhYaqnqnFzynEREnO5CeVDHsgQzU+cswBhZgZuJ9NnDLuQNzO9uNzDmlHBvoXswPjbKsFR2oBX9FgXJ3wW/KqYOYayBzVeemMkrKUWl61IU3uX/yI7JCpLHGq2Nu15WLn75nEyoIcqAk22F6OGNy95IKkeHsBlEScL9MfnlHTHhVeok+Lq37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/JQqCwKWHa+thZi6BbGu87sx9883Lw02e8xwZUj3VU=;
 b=RDD3Hgm7CMGrsnkGIn7QjReGPwkL6O5RO2B7vmYeXqB1LYf8eIUAKtudAiAR/J0qD/jpGCcAk7RobpXOREWeyNhR0I347IBjGxI8qQI8Qt2RzjAFldgq8WGQWubPB2UmA8sobvkX8qZWbxWyaJxColWRMtx8lqVUFdBT5BukuyQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:44 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 16/22] mtd: spi-nor: Fix errno on quad_enable methods
Thread-Topic: [PATCH v2 16/22] mtd: spi-nor: Fix errno on quad_enable methods
Thread-Index: AQHVcqw22gGmk60ca0uOGGwWABc8zA==
Date:   Tue, 24 Sep 2019 07:46:44 +0000
Message-ID: <20190924074533.6618-17-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f65d399c-0f4b-4457-022b-08d740c3586a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43199297E286272FE4227CE6F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TJo3zOHxezPKwmKSa06kWfh6ul1mfNkCq8ztipZRj7syO2SLx/V4JfXLXoxX45ALOiq2ern1hsc5zKqUMREDeg2thLQvqKElXufXOhBSH5TJ2zsQvBr6cJJzC/iv3DuP7rvBgVWTCimLN3wd1yM7cGiAdv9aRSYXmLFmZAlAoKnsTFqztmAc/hyBQrSIso578TNTac13P0oysBFKqezL8SUtCbBGWZJl8wgdoIAgopRQran8qYFbmmzbTjAC2sR9QaOnmJJKQpsBCFTbYZzx8ZNJUgE8rqB1MbAyU1spKGrCX0A+azVS2UaAbvXeJwlu72I+mRqIzg9r8kJGmA52BsT9L3rHUO40KWiR4rIHlerjESkdNcc/y6VM1NshGPx6yAXam3SkqEt3ALaB/Yq/Cnqj0GnG2ElSwN/7CHnVCHw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f65d399c-0f4b-4457-022b-08d740c3586a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:44.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScJrBNdNnjzIXvp/8TkYL9dRgeh2xsR4bw18mqVtTv6Ywm9lfMl8xy4P/sT90f66mvjNllZjf4wyweDLzyNgdUEOYLgRMzfQbTkfy56/9NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

When the Read-Modify-Write-Read-Back Quad Enable methods failed on
the Read-Back, they returned -EINVAL. Since this is an I/O error,
return -EIO.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 668afa9a8c87..6429c855547e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1862,7 +1862,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
=20
 	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
@@ -1940,7 +1940,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
=20
 	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
@@ -1985,7 +1985,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
=20
 	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
 		dev_err(nor->dev, "SR2 Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
--=20
2.9.5

