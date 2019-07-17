Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E347C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061D1217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="G6g/k5/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGQIsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:48:12 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48390 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:48:11 -0400
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
IronPort-SDR: egWQ9HtsRDa705GfteZXFOPH8QLexUVokU3RVIIv/ic8K8l0Yc5dkz3HXn2M+Jw/255cZEHnkP
 WD5Zz/EG7+oeGXD1hsazskvvYTo1/+q0SETZKW/rm2JWg2KKfAbCbHJFcVWvaNQTEyfKdw6Cz2
 L2umNOExdR9jrHrQ4eXmpQ2G2rc0C1uLSS4SvYKHB2eENgGtunye7eVOfqFMjZAoYYuUuxr75U
 rsiFOSyMjJGLblZVDD+x/fQLtsStTbL8ss7R/swg9LsH/Ecl197zRqqU5NNcVwgn/5+PQSmkeC
 7kQ=
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="40862716"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 01:48:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jul 2019 01:48:10 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 17 Jul 2019 01:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b163yfHVKC3KTVDBB98iIo1JLJ1LsuEM9zehDTePH91I2o4a85hIRB9Ev8ndYUz++icup2b9GugQkIiiyT/wWxg5IOXLqwZ66o8wcCkc+fr3jucTMGD6PWOHLPFn7pqGF96eeEEbho4KbsNNIecNGgigqH3lhcDdvocL1X10cltKb6bDReq+5NKKQEGBgBUZrsWXJ/HTVAqLajXN8kffYD1cUdzqBLvSlTMpr2yfZDMpZCKOOEivUnxOW4Qxni3TITb2hkPfukNeIfRpiQhljb+ToB3L5P+uA8/V/dONIgTrq4LS8lnMUblUZYJrIi3lxOvXzF5dp1850EJRSjwlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPAPUOclcugboN9S4o4SFdiLKfo5ZOxWTUuFfV8gUHs=;
 b=YBErepf72/mRoFfFk1K8XJyz702laOeE89wU3TYvapC8q4WNgdA8Cjjy9/xQfg1GwHyrlV6mgcbhKSeSQ3cKagkrtU4/kzx5pnuUJ3+XgtQ8BiMFpYkmWcyGWYoJV2zgZm3LB2SUJF6g6PBfBYonZ/i0pGAX3oBtvzViBcRLSiLFrsaCkW85A04zDdmRWWFL9AIb8SDTzLapzsEwpC6/ZsGqa6fQm5PF9XCg9lmCTIVmFaIFDkmD2/ciNtUoppQwiKLq+HPIWHvISO1JZpxwfDE2JWE8LjcKX4uaXzETDu+8vdQmw8u6IKpy0KHbrMnT3aARl18tFcAmN6qXjoCprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPAPUOclcugboN9S4o4SFdiLKfo5ZOxWTUuFfV8gUHs=;
 b=G6g/k5/8jLxBKtLJeP/gZZgXSzQZX/BGB37Dw873q5Byxn0t+AKKKABNT47FAPrXKwsq8ctZys78ypfHEoIcXN6HDSUbGRkHpzKwfwRTjGW0i9UP/tK3m8AZMMPOc6ItZE4xlpjHXAzfCNyrBJVCpkX77GWr16SLSan9O+064j0=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6SPR00MB254.namprd11.prod.outlook.com (10.173.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 08:48:07 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102%12]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 08:48:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/5] mtd: spi-nor: fix description for int
 (*flash_is_locked)()
Thread-Topic: [PATCH 1/5] mtd: spi-nor: fix description for int
 (*flash_is_locked)()
Thread-Index: AQHVPHxaKG+eJEFhOUur/Urn3TTMig==
Date:   Wed, 17 Jul 2019 08:48:06 +0000
Message-ID: <20190717084745.19322-2-tudor.ambarus@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190717084745.19322-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f688b50-a3b9-449a-2c6e-08d70a937cc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6SPR00MB254;
x-ms-traffictypediagnostic: BN6SPR00MB254:
x-microsoft-antispam-prvs: <BN6SPR00MB254FA928B623D8090EC3C35F0C90@BN6SPR00MB254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(66066001)(102836004)(186003)(4326008)(99286004)(52116002)(76176011)(2616005)(486006)(386003)(6436002)(446003)(256004)(26005)(476003)(86362001)(53936002)(107886003)(6506007)(6486002)(66446008)(11346002)(14454004)(14444005)(6512007)(71190400001)(64756008)(71200400001)(25786009)(81156014)(110136005)(2501003)(478600001)(305945005)(7736002)(54906003)(1076003)(2906002)(5660300002)(36756003)(66476007)(81166006)(66556008)(6116002)(8676002)(50226002)(8936002)(4744005)(316002)(3846002)(66946007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6SPR00MB254;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SYtxu3ie0Kzj0mHQ84xhV3Bwp4HfJ/y/ZkNkDnaXK03HUzUOe7iN2MQ4OC3nuPhipg4wI/in2ot3y2cFLBquRQMvMUZhmXNWN5NKMTsEsz4jJJ9AouQDfOoJ4CSsNvWZjLh3+ExgijxSdgApPJvUduMRCBjFUftdoKaQA0v/PmvIpyCOJ5WSB9j5cAFi3mrq9uxdRy7uqk5OBCUvgTtzj5A3CdLhs3K+zHZZjUP1mxHqi5Fu6PGspu6b0ZrikRUWk5s638lIsfv74Q/QFE+jYlhb4QnPRrKDjBx1k2bfU0KqUEVcS2V4ZsCkgjAZVwN2OrMJMC9sJto+609hV0a655mVOYDuGpBCJPfIjc1zMcAQPICeXiIa03JHes/V5vk+djuahvp4mcNH9k5qJv68EbARacLqwE3TEYU+Rtuy2Ho=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f688b50-a3b9-449a-2c6e-08d70a937cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:48:06.9046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The description was interleaved.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/linux/mtd/spi-nor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 9f57cdfcc93d..c4c2c5971284 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -372,10 +372,10 @@ struct flash_info;
  * @flash_lock:		[FLASH-SPECIFIC] lock a region of the SPI NOR
  * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
  * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
+ *			completely locked
  * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
- *			completely locked
  * @priv:		the private data
  */
 struct spi_nor {
--=20
2.9.5

