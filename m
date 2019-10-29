Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FDCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E4020663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OBSs0dkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfJ2LRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36203 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbfJ2LRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:49 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rPDtM7apdA6ZoH3Drx9TulZgvq9dfJRlV2+RL2SjRVxgtv9YrrmM5uHLBU2LGUhya6gEYYXmTH
 wuftgPf9xkp9rBr7YawTvLIg9muTYwDeA5B4sxoDmvql+v61xNIS8o2Js00sWLC+oL+X4LvWOR
 RWeQ1L+3ETVD+MdvrHKOlknWmlPf4BN/ZUj8pJCjUtrqaxfnZHUgElL+6rkG3FMscofeisEMSy
 ozzf6FCSXVh48/V7OTFgj6GYDovppCL9o3NDg0GC2eGEwNdDBgU9xg2VTJ4EtRWOWg0ybfONhh
 15M=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:38 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwYcFAr3R+JcfG/usAOWsbm+iNcNMAnF/KdDilC39Dmm0wXHmFqOfJ3J440OFeg8mbiFLv4UwJXUj7T5onkQMe1U2L4PoOLv5Kn8jRy/rpWaJWFcABEa6153QLClIJ3nSys3Ars3xwkY3cpz8Nm4JFteysckW5PT575RQc1/y8DAZDqZf2Dz+YvPsCjBjKgeWckAP8BpiEq4piSW8V+xjvex8gHMXUYfLopGwGqgob7xn/RzNw0kGWtDaLCWF3/OfPc+RVKk9tyRvQpc64Rt39gHOMUB1Sl+1Kg+UVeO0cT5hZFcViXo8L1zaxQYCz66mIMZV6Oa8L5qmse+5EoYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJlWcQDwNXfE6rVzzGZgx0NSl+5FVZ/RacoT0M6zA6s=;
 b=e7iFvrIn39U1BEU+02iRSpLfkQCuk2XvRH0YOFBSp+X/B4Ric8GiLe+jJqd6rGX66173RQmlKKzVgS2PLmjRDlIl6z2Q8LuqPcOmcfzr3oogvITUJudW1KhwQ9fy0PLentm2s/4QABDL+YM9X+/jUFrahcIKRZGWprKPyK/epKMP79EE6TN/0B8q6ofJ93zGA4MIC1CufHLk8P7TTK2eejtE2+I4wF1dXO2dgVerxxe1AV9+cMU/YyUo8el32UB2o3ERtSfALkNdA6enJivLced5Z9Hug2qU2VChjwuTqCREHqGDVI0Dd7rjlvSkOBcg2rgwR2nCD435mULZSpfM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJlWcQDwNXfE6rVzzGZgx0NSl+5FVZ/RacoT0M6zA6s=;
 b=OBSs0dkf96e9biZFNFOHSt+Ktcng2vf0FrqXmfPZEuGQPwWfhlCwSS5TZ+jQNn78Erfa7GHVA0lcq/YdzFgLgKksq95OWD/+FZJDT4hrkvZSPdaqX+H0L0DKPliSo50XgdkDYgu6MVm49TyfS7uGjNl5WMzl9vd/EytN9m3zJq4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:37 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 30/32] mtd: spi-nor: Rename macronix_quad_enable to
 spi_nor_sr1_bit6_quad_enable
Thread-Topic: [PATCH v3 30/32] mtd: spi-nor: Rename macronix_quad_enable to
 spi_nor_sr1_bit6_quad_enable
Thread-Index: AQHVjkp4zogvBUS0eEqgEdAzXKqfHg==
Date:   Tue, 29 Oct 2019 11:17:37 +0000
Message-ID: <20191029111615.3706-31-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [83.166.207.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aaae1f0-9f3f-41e2-2112-08d75c619a88
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37123ECF8F28E303695A93FDF0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(14444005)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AzUPkTIlty1BrtbYofEl9yaxIqKem9ChBZPcBBvjQWDKXLU7drlcc9PyovuxedU4BQJ8BvKE9E3NhOLyjRHLAnhzpBrvVjbOgkTqxgLWyeOlr7cYECtBGAuZj1hMwCSvQsUA3LYmNanXKrL5+kZHRLNN037NX3CMj00m3pUQOFflNjvSyM9BlhO5sWGiA9UCGOkpWqh+9TrLhH4156ka0d7JlaZmO9rfom9Wcs6rFsKnKlJFe+/EX5oUYkKwi+EQ2wrUmI7lz6ZWC0KJ+LE6CHHtCBrKqJRPBD8/YzB3oCdn4wXjlYF2BeaYmS1Imr/IOfYi88TyB4Lo4j2N3WJ+C5w4M4I4hM0PxYOMFEziDyz4ml7tgRyY7t1endLaq8INY/IuQcbiJEB7dVxRIO708sIxIYZGP+vhfSMBWvz5gr7URZp/15NY8fK2kFtVfl1K
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaae1f0-9f3f-41e2-2112-08d75c619a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:37.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZPCfAFxeuuhN9yuewJ+pIY1E9UDGrnLjC39u+oWwLmjJPcPzPzBZdjEmmkFkt6rZLNS6dFpmKCR0RR49WMF4yWquszvqiJoIzPed24u4rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename method to a generic name: spi_nor_sr1_bit6_quad_enable().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 19 +++++++++----------
 include/linux/mtd/spi-nor.h   |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ab028afc503f..47d159959461 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2078,16 +2078,15 @@ static int spi_nor_is_locked(struct mtd_info *mtd, =
loff_t ofs, uint64_t len)
 }
=20
 /**
- * macronix_quad_enable() - set QE bit in Status Register.
+ * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Stat=
us
+ * Register 1.
  * @nor:	pointer to a 'struct spi_nor'
  *
- * Set the Quad Enable (QE) bit in the Status Register.
- *
- * bit 6 of the Status Register is the QE bit for Macronix like QSPI memor=
ies.
+ * Bit 6 of the Status Register 1 is the QE bit for Macronix like QSPI mem=
ories.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int macronix_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -2095,10 +2094,10 @@ static int macronix_quad_enable(struct spi_nor *nor=
)
 	if (ret)
 		return ret;
=20
-	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
+	if (nor->bouncebuf[0] & SR1_QUAD_EN_BIT6)
 		return 0;
=20
-	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
+	nor->bouncebuf[0] |=3D SR1_QUAD_EN_BIT6;
=20
 	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
 }
@@ -2349,7 +2348,7 @@ static void gd25q256_default_init(struct spi_nor *nor=
)
 	 * indicate the quad_enable method for this case, we need
 	 * to set it in the default_init fixup hook.
 	 */
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
@@ -3729,7 +3728,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
 		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-		params->quad_enable =3D macronix_quad_enable;
+		params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
@@ -4627,7 +4626,7 @@ static int spi_nor_setup(struct spi_nor *nor,
=20
 static void macronix_set_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 	nor->params.set_4byte =3D macronix_set_4byte;
 }
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f626e0e52909..6d703df97f13 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -133,7 +133,7 @@
 #define SR_E_ERR		BIT(5)
 #define SR_P_ERR		BIT(6)
=20
-#define SR_QUAD_EN_MX		BIT(6)	/* Macronix Quad I/O */
+#define SR1_QUAD_EN_BIT6	BIT(6)
=20
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
--=20
2.9.5

