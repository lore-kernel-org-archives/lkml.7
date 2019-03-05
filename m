Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A4206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="umEs3RHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCEKIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:08:13 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23360 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:08:10 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="28727151"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 05 Mar 2019 03:08:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:08:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2LlApE9KLEwvJ1Xgh4TXz5Ls7//fcDvuKAIwlZx2AU=;
 b=umEs3RHrp3THL2GfaNgs6SMWdxbRQYwcTeKAX+WQ/ofYnVV4V5rf0oFoIbvFK0sqT331vhngXlzbBVVzZL6kVnVCDeOjhadYhmVtMnY/ESKozUrNeYyrJTYJHTvRmz3BoQgg/bIp3RwvPyRcx/5IT83G5mGhAuHVZuZ+z7CeM3k=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:08:06 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:08:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Sandeep.Sheriker@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 6/7] drm: atmel-hlcdc: enable sys_clk during initalization.
Thread-Topic: [PATCH v2 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Index: AQHU0ztTj0DTJY9F7UiMYZcuK/OaDw==
Date:   Tue, 5 Mar 2019 10:08:06 +0000
Message-ID: <1551780434-4580-7-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a74836-6dd4-413a-b04b-08d6a15275fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:BVJdaMVkJizzHuljx4ewjOF/Knbj5Mm/UkDRlvs?=
 =?iso-8859-1?Q?Y/0zfKrA3X3ZRgKY5irBufga/ONMou2VLSk/3QPgvslxpvpBDX/ygWdt3c?=
 =?iso-8859-1?Q?uPUAhROptOtMe2iFR2MLjzDBXYfnXygUFTfTPUiFwdvs5CKAawv4hYfYk7?=
 =?iso-8859-1?Q?9u/d3eOZSdVtY7XISDx+FcQ6pN2imlyDVxHxqjAjjHOA+oTG3UV7f24DCu?=
 =?iso-8859-1?Q?xQ1BOhQjdGjk+vx77sf6lK8xG5Cw4R1tZfAdtsvWTeGlNBI4P82LZivaCI?=
 =?iso-8859-1?Q?RaLRN05mc1vEmImWPU5fWPyYUDGM6oGpjVKR0ncRUh2hHrWb6QllrJbfFh?=
 =?iso-8859-1?Q?3U1kRwiwQuggsdqCm9SFAveFN+VZHwGDYyFjEZiWAwmCKdFNnh1DBEnmuz?=
 =?iso-8859-1?Q?H1MDlulbdupW1tKlSo1jl650JPkjMuoEsnJQ0QPOsGueL/1O9J2uf6oF8F?=
 =?iso-8859-1?Q?oDQE8OGgM9r2+/moOJs37MxWtG225gjF7AYX/xHY1zYzKC02II+ASsrw3H?=
 =?iso-8859-1?Q?KNy6kRje/+3KmFiVGTz6imOH3Ea+OEoKvImEpAxkpyyVZDDOJNd04LtaS+?=
 =?iso-8859-1?Q?M5Uxl9Bghfh3PKTlPXtyXe5xkKi2UgO7HGZFw88Db/VlxHRCzJTTvgR9Wx?=
 =?iso-8859-1?Q?MKovxUjz2Iv3U10ktGdWi65ZQC0oIUD8tvhblhgF+CHrIw84dz8ouvKeY7?=
 =?iso-8859-1?Q?CDHOtcQcb3ZSHd0JRqhE/6Yetg0qRitqiJGblZnwuNFobxZ787WUwdTaz0?=
 =?iso-8859-1?Q?koi1rdpyQ1Hu3S9IuwCLQYVZWkyeAAZZZlrYjG+vCXYmRYUtkjBmu8AVLw?=
 =?iso-8859-1?Q?F48AH1TuUyMICv/8LYr1F87Ma/qBBMg+IXtWDZxrJ/LldEPtC2yNFbI/j3?=
 =?iso-8859-1?Q?DFFk5PhbfdOwnEE1/lEWjgESWtVd3FE21lrVMSiQU1o0n8zPDJOEdnjpON?=
 =?iso-8859-1?Q?8zTz5ECJfYkdMQS5Iq3/xxWrVmjzaohYP/+C8L7Gf9qDb9y/jFo1/5c9U3?=
 =?iso-8859-1?Q?LOpdz/DutKAscH0l2twjIyAvndnXYcK3UfRYmu2BHIUPEUKhKoiBUdpLec?=
 =?iso-8859-1?Q?RrYxJ50kngitmeLMbCZhoAiS0QDoMhrJNpirn9ukhsunqJ+XBoGu1v0+zf?=
 =?iso-8859-1?Q?6iEwHFu1Yw7wllifSvSqi6p3peKUczFMc1IJlZhb7zpfCQPEPwlK/Ffp4B?=
 =?iso-8859-1?Q?PoUROxTY9wHUGqNBi4uiZOELPxbpA3FnlJbOv0GW35o3G7UswCY3T0uBU8?=
 =?iso-8859-1?Q?wWZG171hKPH1rEW7XEkCftyiOeR+GekRiygwdr7PLbk+G1UQ9yEAVNdpx7?=
 =?iso-8859-1?Q?kTNeHgC+mw3pkVyjmNvF15Kz940adE0wlcmJPz6nG8OYf1kihQUa0AcXgM?=
 =?iso-8859-1?Q?d/kYRypGt8TwQMTxNJdwBjzVtC/W0?=
x-microsoft-antispam-prvs: <MWHPR11MB1647C9B68BDF706C70D15F5487720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(14444005)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HlP00Fi6Cby7UCgqkDLn9JYuuA+pz3BMZv9ayEAuoAA33IfRwDdjDocvB3VKsXkmmDyp73i0PptxzYNVfB+olp+3+3uQeR5atkmgxZy0xjQCg5DDkAqzRlfigvUKX9cexibsFFfsjHiHotVAW5/U59++s8a25C/lRaqJazwg2tF9pyo5vcIByBdzV9oKZbRw1YlqLdOf4bwZgejT1DeiDha0BO6QbMJcs+c1PAGcZe4MaZra6iT6mAtkmCRHAYmA5Q5YcmIH8LRh0j9fOTQugFkDxRqyHhz5OC9scuoOLEW7NjpTR27AryyFtQL5uW0v6IDLNuRQcjGFA7720KgaAFBA/hOkV/Onf5cMHA5ll3QcTIm0Nw2oeLXaQj8V3oLKw/4yDhXyO5bTNR95z+RhdZTDBT9efIC33MxO7Yn32nw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a74836-6dd4-413a-b04b-08d6a15275fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:08:06.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.c=
om>

For SAM9X60 SoC, sys_clk is through lcd_gclk clock source and this
needs to be enabled before enabling lcd_clk.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@mi=
crochip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc checks]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.c
index 0be13eceedba..8bf51f853721 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -625,10 +625,18 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev=
)
 	dc->hlcdc =3D dev_get_drvdata(dev->dev->parent);
 	dev->dev_private =3D dc;
=20
+	if (dc->desc->fixed_clksrc) {
+		ret =3D clk_prepare_enable(dc->hlcdc->sys_clk);
+		if (ret) {
+			dev_err(dev->dev, "failed to enable sys_clk\n");
+			goto err_destroy_wq;
+		}
+	}
+
 	ret =3D clk_prepare_enable(dc->hlcdc->periph_clk);
 	if (ret) {
 		dev_err(dev->dev, "failed to enable periph_clk\n");
-		goto err_destroy_wq;
+		goto err_sys_clk_disable;
 	}
=20
 	pm_runtime_enable(dev->dev);
@@ -664,6 +672,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 err_periph_clk_disable:
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+err_sys_clk_disable:
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
=20
 err_destroy_wq:
 	destroy_workqueue(dc->wq);
@@ -688,6 +699,8 @@ static void atmel_hlcdc_dc_unload(struct drm_device *de=
v)
=20
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
 	destroy_workqueue(dc->wq);
 }
=20
@@ -805,6 +818,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *de=
v)
 	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
 	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
=20
 	return 0;
 }
@@ -814,6 +829,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev=
)
 	struct drm_device *drm_dev =3D dev_get_drvdata(dev);
 	struct atmel_hlcdc_dc *dc =3D drm_dev->dev_private;
=20
+	if (dc->desc->fixed_clksrc)
+		clk_prepare_enable(dc->hlcdc->sys_clk);
 	clk_prepare_enable(dc->hlcdc->periph_clk);
 	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
=20
--=20
2.7.4

