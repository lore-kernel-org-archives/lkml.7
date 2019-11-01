Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D41FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="VWkOgbSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKAVnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:43:07 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:1504
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfKAVnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8gWy9t3tTdY6mMyjGyEF3LvbGVwKq4DWan1lp6165+1uXLnqHG72exhUSmhmAVYZqBsHBoeC0H28+OfCw2AEO08/piYucJehCddxz6yBzIbcUVxfn9N1yKntM9y3EqvcaPSgytjNQo8jhO3OeAmjUfLjJyVtkNDHU2uJXCW0GYZnp48v+tpnZB75ONQ1oSU0E8f4eeqDP8UcP5ndSRwyTLwIpYazHqbsG1iHZVKFHl1R9w+NNFbs+cgLUwlYg5J3bh22QTB2nZUKfTB2Wg5zY+lobOv+ebko/Wk8eRb1EvNnBcvLc3Us8RAky1CEqenZKyi+zDcmP42OGeFdsfu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tbDgwYm7i3M2kgWjGD06NtwTINNoD5Qp0G0Z5fm1fI=;
 b=LIA/RI3s3+5Scr2RFFW5b1XjOhv1lhGt+7J2Kiwqe3en0znezR3uc0akr7NDDsWhcbQfszXtJNxCj+3LByQ9BsVoctnQ0BiqhvZoPkbrGdWab1OhEtqHnCPCh8W6q3p5x2p1pEH01wq3obPFNmB80yKRcQa+x6xno6ZP7vWhReYoq0ZhAAnYIRUMIb8mva7xPXwQ5lM17nzsY8kGzQF/rJt/0RAQyKSN3dVpfEhMYw9cViz98v0xfwA7mYKwO/867yr/iZyR9dzGkWMNwrrkGA9hBaxWnZdD8z18QDLtDcegjBEyxQ9iYSpWjy4rqVDc5jhtEN0Wi39C7V6DrBZGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tbDgwYm7i3M2kgWjGD06NtwTINNoD5Qp0G0Z5fm1fI=;
 b=VWkOgbShV8v+r5Pzup4XkkUu7dHdlaHUyr3nzxOTwjHYzz3n2vO9oDJmt+pR93hOejFhJGT7E4IWYrJjtAivCm7kQUZBEk6euZwBsuC4wz4yTp/DAEsmdXJ6VIYFDiDsG7lqcO0/PZdpgL8VAZr6Wg6LNnyUUQk6m63I5vvhVt8=
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4679.eurprd08.prod.outlook.com (20.179.47.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 21:42:59 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee%6]) with mapi id 15.20.2387.031; Fri, 1 Nov 2019
 21:42:59 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] staging: axis-fifo: remove unused pointer to memory
 resource
Thread-Topic: [PATCH 3/3] staging: axis-fifo: remove unused pointer to memory
 resource
Thread-Index: AQHVkP1UzicuaAAUZk66MpcyAj/NRw==
Date:   Fri, 1 Nov 2019 21:42:59 +0000
Message-ID: <20191101214232.16960-4-quentin.deslandes@itdev.co.uk>
References: <20191101214232.16960-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20191101214232.16960-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [81.98.213.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfae3b0e-75ab-46d4-269d-08d75f14769b
x-ms-traffictypediagnostic: DBBPR08MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB46799E5C11E255F745E5E9ACB3620@DBBPR08MB4679.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(36756003)(2351001)(86362001)(186003)(66066001)(6916009)(14444005)(66556008)(476003)(486006)(71200400001)(64756008)(5640700003)(2501003)(6512007)(66946007)(6486002)(44832011)(71190400001)(2906002)(6436002)(11346002)(6116002)(3846002)(50226002)(66476007)(4326008)(305945005)(8936002)(25786009)(5660300002)(7736002)(81166006)(256004)(386003)(8676002)(6506007)(54906003)(81156014)(66446008)(2616005)(508600001)(14454004)(76176011)(52116002)(446003)(99286004)(102836004)(316002)(1076003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4679;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDwTgDFKNic/y0hKd407ooVPIbb++FMSEHnNS/JuMhQ57q1bVI4TB7tYp2YZ1f2kH/hUFEkis8dhX0ljF825LEvsvuqBa63wUFLA3LqXg/yXF6h3yS9H0LnfFyhoJWyQYMYUi179l61Sjm33bQSlL1Y49LN3HyDRUB7xD+lLXr0qeSJ4ls+sh8WyCwa3ET7MTm8JuG8U2w+G8G1EmY5PKiBjdrvhpQrOlQxUmeoZ465hgVYQ5ZIv1zLPaT8ArLdLIuwhECDcSwVCEsJ61X+51WHNuOcmtF7Eh8SBbrnq1gYAI4Gn7wGDy0ZMzfnFk2rg21toSwZdseir9BgYlTwhdiP5SRv4vc7ZgGP1RBwccDOx3QsugBipXoNz0UVzP2QqOztFFs6lBQfT1zH1SRH+fwO9wknlGWIJVb5f0zyD+t28vJSFt/CorLQeYyIA903a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: dfae3b0e-75ab-46d4-269d-08d75f14769b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 21:42:59.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NiYWv3V8QjHwkgJ0dtpl2G6s2fiNUb5B1AwfHPnyNDgj4BdXGEr+AVc+S797WdcXlC2aslSuwmTh9p7mltlQSPBBTFXoWRbeb3ap0q5p3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused resource pointer from the device's internal structure.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 drivers/staging/axis-fifo/axis-fifo.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-f=
ifo/axis-fifo.c
index 2e6e2f149a26..39e6c59df1e9 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -125,7 +125,6 @@ MODULE_PARM_DESC(write_timeout, "ms to wait before bloc=
king write() timing out;
=20
 struct axis_fifo {
 	int irq; /* interrupt */
-	struct resource *mem; /* physical memory */
 	void __iomem *base_addr; /* kernel space memory */
=20
 	unsigned int rx_fifo_depth; /* max words in the receive fifo */
@@ -806,10 +805,8 @@ static int axis_fifo_probe(struct platform_device *pde=
v)
 		goto err_initial;
 	}
=20
-	fifo->mem =3D r_mem;
-
 	/* request physical memory */
-	fifo->base_addr =3D devm_ioremap_resource(fifo->dt_device, fifo->mem);
+	fifo->base_addr =3D devm_ioremap_resource(fifo->dt_device, r_mem);
 	if (IS_ERR(fifo->base_addr)) {
 		rc =3D PTR_ERR(fifo->base_addr);
 		dev_err(fifo->dt_device, "can't remap IO resource (%d)\n", rc);
@@ -820,7 +817,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
=20
 	/* create unique device name */
 	snprintf(device_name, sizeof(device_name), "%s_%pa",
-		 DRIVER_NAME, &fifo->mem->start);
+		 DRIVER_NAME, &r_mem->start);
=20
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
=20
@@ -844,7 +841,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
 	r_irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!r_irq) {
 		dev_err(fifo->dt_device, "no IRQ found for 0x%pa\n",
-			&fifo->mem->start);
+			&r_mem->start);
 		rc =3D -EIO;
 		goto err_initial;
 	}
@@ -898,7 +895,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
 	}
=20
 	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=
=3D%i, major=3D%i, minor=3D%i\n",
-		 &fifo->mem->start, &fifo->base_addr, fifo->irq,
+		 &r_mem->start, &fifo->base_addr, fifo->irq,
 		 MAJOR(fifo->devt), MINOR(fifo->devt));
=20
 	return 0;
--=20
2.23.0

