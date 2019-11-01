Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFB5CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1421218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="XLj19cNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfKAVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:43:01 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:1504
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfKAVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:42:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4wdwB22G4ATggMFR9ucwgMtRoL9kY7wzmkltozVRc8WxfFrSsOeCBrJeZHBOzRbt46xcuf35F+5BlcJ+4M2TF5AoIrABdCuqxVPzzoXFa7t4lOeZqx0kzKpHzmpAFqMHve4FX5eoI6z7TPsdcSegjWQkayTKP/FVWI3r1UTCnyKe45Fp8B4t6SckFp9dX4lnJfoRcIPmhDglYk/8ouo8dbpRqEoXf2EMEKa2cP/3D/hKmAQOrWXi7nVvsVRw6Lh16q464B3wLU2roIri+yYHD56I0zYSdKaUlDJNkpFslTQZks6HVmn6VgW/1e9KXZ5XbKfgvWujNem2ACqzOJ2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1asZxG7iy1G+ohx5StQOK1UeIf1kysj2FMuZhcOMis=;
 b=dzH/0S8TOwRDhL+9pfKxJ7Q9mUffuWjpK/mxncV6VwEg67gq6Zmi4VlAo9fTU9yzG/OjhvcZk4xRixuXAFRKp63WjBRoQnBP1edt95FejPjUfWuk5ZyyQsR+C7we7qlV7o8+i9DCjj+Otti98H0ivm+H/P2O6Sa9EKfRjFmo9xUOi49E1lYWurcT2EpFAyedJ2OrbRSkEUdhEga/ebQakTI5xawoiE4hk7nEl1P32Otmh6kKZ0A7qc191CiH+lnj9y2nVmxoNMqIav9BILDFuF+dFaJOWt2s5pKJyA8NKlzanxGU1R+EcLF/DEwQJ+MsOnwqs/7JCjRpAwgjJsGPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1asZxG7iy1G+ohx5StQOK1UeIf1kysj2FMuZhcOMis=;
 b=XLj19cNiaSsYNj73vR7njmYWcXc6eFvOHfHmC33qNQRYGoISSlHyzwDsDriOfSYJN8j+enKaWxSLLReTNrYuDTIgy4QaL9ejF5zMK4IC8TCzTKYQfCwaEfGZGb4wawAAxmgjN2buWLA7PNquakOAdEUnyP3Je3DfauGgPQmRPEY=
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB4679.eurprd08.prod.outlook.com (20.179.47.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 21:42:55 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::4c2f:e455:fb07:bdee%6]) with mapi id 15.20.2387.031; Fri, 1 Nov 2019
 21:42:55 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] staging: axis-fifo: request resources using managed
 functions
Thread-Topic: [PATCH 2/3] staging: axis-fifo: request resources using managed
 functions
Thread-Index: AQHVkP1RD3//gI2KB0K7rhYWv+gNHA==
Date:   Fri, 1 Nov 2019 21:42:54 +0000
Message-ID: <20191101214232.16960-3-quentin.deslandes@itdev.co.uk>
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
x-ms-office365-filtering-correlation-id: fc08792d-75f5-4db2-81dd-08d75f147421
x-ms-traffictypediagnostic: DBBPR08MB4679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB4679C71FE2DAFC331361E3D6B3620@DBBPR08MB4679.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(36756003)(2351001)(86362001)(186003)(66066001)(6916009)(14444005)(66556008)(476003)(486006)(71200400001)(64756008)(5640700003)(2501003)(6512007)(66946007)(6486002)(44832011)(71190400001)(2906002)(6436002)(11346002)(6116002)(3846002)(50226002)(66476007)(4326008)(305945005)(8936002)(25786009)(5660300002)(7736002)(81166006)(256004)(386003)(8676002)(6506007)(54906003)(81156014)(66446008)(2616005)(508600001)(14454004)(76176011)(52116002)(446003)(99286004)(102836004)(316002)(1076003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4679;H:DBBPR08MB4491.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYpin8wDLP/q3qXHhJb1uWZ12ZF/zNRdUh6c3yRQQJmMUw24heRDJ9pLPq+QvficTuOUkwJW9d1cH5MVAsZVj3QNCnbuGMcQhTGWryF2onWC/rF5ad/JrRHGfC+ZSnP0NkkU15Ln3SKGe65akL3p81GkwyiM/bq/+Vg850DkChf7VA7cvNCT3rw4AeJWNR5mFVpQGyG3TkEx1O763WMaFOD+Fm1avJHZOHRaxD4Nl/8oep6rrXsghEWqVp9NM4spo3bPMY6a8TrekJMki/ABw2zgDmfG/b2SiY+aZQ0gL3DS5pcnHo7O6J75U0Elv44uYHMY/251qfy1AcXa9HdG8Hrs8eQ9QLnuaGRFd/Y0mgBKZfQkheo7+CsAzKC0bMaa4a+Dmwb6smyFxUeW+yngUoX0GbYaOZ1hzYvYs6u6UFgpvgsHM6YlIFRo33Z57ag2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: fc08792d-75f5-4db2-81dd-08d75f147421
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 21:42:54.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yt2gU9z4S1/rg72Ka1DeOZP26dkwp45LPufwwWRkNrb7qb7K9fL9j+Lk+/zR3tJ2ZortZb0ZEFV1yOeqtMScFO4DChcqn0PjEUx0OAk7OEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request device's resources (memory, interrupt...) using managed
function.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 drivers/staging/axis-fifo/axis-fifo.c | 45 ++++++++-------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-f=
ifo/axis-fifo.c
index b436f48a9d50..2e6e2f149a26 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -809,24 +809,13 @@ static int axis_fifo_probe(struct platform_device *pd=
ev)
 	fifo->mem =3D r_mem;
=20
 	/* request physical memory */
-	if (!request_mem_region(fifo->mem->start, resource_size(fifo->mem),
-				DRIVER_NAME)) {
-		dev_err(fifo->dt_device,
-			"couldn't lock memory region at 0x%pa\n",
-			&fifo->mem->start);
-		rc =3D -EBUSY;
+	fifo->base_addr =3D devm_ioremap_resource(fifo->dt_device, fifo->mem);
+	if (IS_ERR(fifo->base_addr)) {
+		rc =3D PTR_ERR(fifo->base_addr);
+		dev_err(fifo->dt_device, "can't remap IO resource (%d)\n", rc);
 		goto err_initial;
 	}
-	dev_dbg(fifo->dt_device, "got memory location [0x%pa - 0x%pa]\n",
-		&fifo->mem->start, &fifo->mem->end);
-
-	/* map physical memory to kernel virtual address space */
-	fifo->base_addr =3D ioremap(fifo->mem->start, resource_size(fifo->mem));
-	if (!fifo->base_addr) {
-		dev_err(fifo->dt_device, "couldn't map physical memory\n");
-		rc =3D -ENOMEM;
-		goto err_mem;
-	}
+
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
=20
 	/* create unique device name */
@@ -842,7 +831,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
=20
 	rc =3D axis_fifo_parse_dt(fifo);
 	if (rc)
-		goto err_unmap;
+		goto err_initial;
=20
 	reset_ip_core(fifo);
=20
@@ -857,16 +846,17 @@ static int axis_fifo_probe(struct platform_device *pd=
ev)
 		dev_err(fifo->dt_device, "no IRQ found for 0x%pa\n",
 			&fifo->mem->start);
 		rc =3D -EIO;
-		goto err_unmap;
+		goto err_initial;
 	}
=20
 	/* request IRQ */
 	fifo->irq =3D r_irq->start;
-	rc =3D request_irq(fifo->irq, &axis_fifo_irq, 0, DRIVER_NAME, fifo);
+	rc =3D devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
+			      DRIVER_NAME, fifo);
 	if (rc) {
 		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
 			fifo->irq);
-		goto err_unmap;
+		goto err_initial;
 	}
=20
 	/* ----------------------------
@@ -877,7 +867,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
 	/* allocate device number */
 	rc =3D alloc_chrdev_region(&fifo->devt, 0, 1, DRIVER_NAME);
 	if (rc < 0)
-		goto err_irq;
+		goto err_initial;
 	dev_dbg(fifo->dt_device, "allocated device number major %i minor %i\n",
 		MAJOR(fifo->devt), MINOR(fifo->devt));
=20
@@ -901,7 +891,7 @@ static int axis_fifo_probe(struct platform_device *pdev=
)
 	}
=20
 	/* create sysfs entries */
-	rc =3D sysfs_create_group(&fifo->device->kobj, &axis_fifo_attrs_group);
+	rc =3D devm_device_add_group(fifo->device, &axis_fifo_attrs_group);
 	if (rc < 0) {
 		dev_err(fifo->dt_device, "couldn't register sysfs group\n");
 		goto err_cdev;
@@ -919,12 +909,6 @@ static int axis_fifo_probe(struct platform_device *pde=
v)
 	device_destroy(axis_fifo_driver_class, fifo->devt);
 err_chrdev_region:
 	unregister_chrdev_region(fifo->devt, 1);
-err_irq:
-	free_irq(fifo->irq, fifo);
-err_unmap:
-	iounmap(fifo->base_addr);
-err_mem:
-	release_mem_region(fifo->mem->start, resource_size(fifo->mem));
 err_initial:
 	dev_set_drvdata(dev, NULL);
 	return rc;
@@ -935,15 +919,12 @@ static int axis_fifo_remove(struct platform_device *p=
dev)
 	struct device *dev =3D &pdev->dev;
 	struct axis_fifo *fifo =3D dev_get_drvdata(dev);
=20
-	sysfs_remove_group(&fifo->device->kobj, &axis_fifo_attrs_group);
 	cdev_del(&fifo->char_device);
 	dev_set_drvdata(fifo->device, NULL);
 	device_destroy(axis_fifo_driver_class, fifo->devt);
 	unregister_chrdev_region(fifo->devt, 1);
-	free_irq(fifo->irq, fifo);
-	iounmap(fifo->base_addr);
-	release_mem_region(fifo->mem->start, resource_size(fifo->mem));
 	dev_set_drvdata(dev, NULL);
+
 	return 0;
 }
=20
--=20
2.23.0

