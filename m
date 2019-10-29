Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55CECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CDF208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lA4QlZuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfJ2LRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:11 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36095 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbfJ2LRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:09 -0400
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
IronPort-SDR: hj7mXKwNO/M7BwBgyyKaXRkgHQge+hMCaZDbVFciR6dnTkjVQ9vw3cuyXfJ5cwjNBhTGMQhzIZ
 hwWg4MouZKxMWsQUbx2s3Qt6ebLD8xFy5VdEQbFpRjejVK6N1BY3noUwnzpYG/LhO2+7Yf87bx
 i9YUJM4gVu784IRA7X3sf22smF48P01ksT/vJESoM7BovIP9IvKpWH3IXrPA+tc567kKZturNs
 bZcYbr6uiiPFG+RCgbrl1WleURlOdS0q2chQKf92jpRqsgekLM1FSvo8g42IFaocZqSoSW7y0N
 Ff0=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:08 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxRoCxzJNH87z0t6gCgfsuqp/bUcNBPvNKLnocS7SSHOQjF0CM/rlLf+X7AnPHuZ4yjEqTo6c4YHTG1hkX49SKRSAhUgdZxNlkm3n3s1Ovs52nHg3SmKma2x5F2Pw6F74Pth8GDNOQmiRPpP+WJgCdQefbR8PsUoAyM8CUUYEyADge4GgQ4I8BwPL1f2Jp4e9Cs5YYrxtLY4OKgJ/sSlXib3QrPXAF19Ii8BNZEvk8Dblad5eG9ybHWmeS000FbnNAGm5vQLLmJfN5dast1ULmFguDhjIAzhUnXmw7wXyxRY98uo+Ym/Ax28giVvJH+tBVFOTK6jsGEIPdlfAvVcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MavTONoJzzkuikig8gv2I7DIQB3QvjA/J03vrkRtRWw=;
 b=lZ6opAOZy6oOHNoh0CtTC5PLav20k5qr/IA+F0+DGAbdBvCG+fRg903PC+JYK8WFtgnHczheE1TC8CfP/umfzdIYLNBKOcu1oT/8cLkybfYrA+MQMwjBppT9w7Pm4CHhUk39JnOO09f1LQ1xL6rn55OE3+AHYaj9BrgAI+YVonPxK2S5pTme4yRv5At4G5LY5T56E7nWwnAJM15QBLB7oIIuVx/Ncc3CvT/o5QmpDL028Ejo6hWNLh9a0MUlfG2vQTqkfr12h544PEJS1Qz8DCO0veuS7Ff0m/mHZgT/EHCvv3RM8/D1Pj0g9YPq6wIllBgOA5kMTf9nhhHHIdx+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MavTONoJzzkuikig8gv2I7DIQB3QvjA/J03vrkRtRWw=;
 b=lA4QlZuPA/S6gtTVtH3PDrfPQVj5AfiiSxTx5zuczHxiuvFK1YK5npq1tKebcBHQvupS16ydXc0QLsCFrgbFcfM8KjDU47L/EShvKlJIMSOnFGYGk0y8oIPb/PPB2+tlXcjo1n2ODTj08HwDhgyXGFcCrkfuuGAErgJVWj6aH74=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:07 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 12/32] mtd: spi-nor: Void return type for
 spi_nor_clear_sr/fsr()
Thread-Topic: [PATCH v3 12/32] mtd: spi-nor: Void return type for
 spi_nor_clear_sr/fsr()
Thread-Index: AQHVjkpmjsG4in3pP0iw8qKZKwa6NA==
Date:   Tue, 29 Oct 2019 11:17:07 +0000
Message-ID: <20191029111615.3706-13-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: a61b4db4-3836-4694-9d7a-08d75c6188c9
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38234B2F3A7F1EDB9DDFCD10F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(4744005)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4qzb5zpfvH62twAW4cipmj06yHCoOoG68Gf0aB/NmLPqXIM1C2b2FajmDEXK39vIoe+HqE3H4XJAPuRq0kqRqnBqg0UcMu+WH6C0jFBwH+/04iN43aOF4Q2DYf2kcbQFuQyiLBg4f4Ggawo78efzfQFCDdwcYy7n1H0NNZAsyGu5XEJDzH+BTlttwUV4PUhzqAITkJFtXABx8BswZL4ROwzPfUISsVuehsXerHs9ZZIM3fxWe5fkHQgC14g6WNwapQSmS5deO7SxC/llPn1706fCa08FZgbGZTHhIigabMPXpuZGvntuMnJus98QBeCQjnBI2bltFBYcyGzzXlU8j4nbvXIrBnTWgbPM0R2Mv4ZM4Hhduc7hPRmMBW2Yw7REFdOOPkOKXou9R8KlR1D38EvF3wad/8sS6wNzbjm1wAsVfyaomyt2ox53T7llT6W
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a61b4db4-3836-4694-9d7a-08d75c6188c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:07.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3wB05XupozwdzZfOOACa8n7RSIluUsCNwknEr8cTUlWmvVfMmi1Izr9GZ4uvNsVvbWqOlo4FW6r8mpXk+zQYuEVMzol764A872t2CllHsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

spi_nor_clear_sr() and spi_nor_clear_fsr() are called just in case
of errors. The callers didn't check their return value, make them
of type void.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4a1ecf452a39..e5ed9012cd50 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -654,7 +654,7 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	return !!(nor->bouncebuf[0] & XSR_RDY);
 }
=20
-static int spi_nor_clear_sr(struct spi_nor *nor)
+static void spi_nor_clear_sr(struct spi_nor *nor)
 {
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -690,7 +690,7 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
=20
-static int spi_nor_clear_fsr(struct spi_nor *nor)
+static void spi_nor_clear_fsr(struct spi_nor *nor)
 {
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
--=20
2.9.5

