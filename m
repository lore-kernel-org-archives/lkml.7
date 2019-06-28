Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C962C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585EE208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="BQYZaSpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfF1DAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:00:11 -0400
Received: from mail-eopbgr750101.outbound.protection.outlook.com ([40.107.75.101]:13440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbfF1DAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:00:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Uc2rgkiIm/rKgrKPoHWYfsia27P5ZSTQ7pgjl0gdKfYuouKyb1k0MEFmm15vFdRIyEpK0ERn4+HHdVrPPUWL0CYYVSraDmxrW6cNdFJEEFMC2I1OVOZX6GHrqU6zm4DSo3m9iQpQjHyJdQjnWBYMUeRt371GCFMV5PTKoAQEAU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1l5Z0vYbqYP7KSTi3kmtsxMgBFD18PPqdWQg1taQ8k=;
 b=SBef9vcl/ByCcIjvX9PZlpmA62c9RfA1xYYVq7g+S2aW4owMCMAOltyti84U5K/Ngg8dhoCxbYNi1eJ/Q4K10fKsqXHLkClSrWTwDSbBl1JDxLjWR1piOk2OM/0WkMpY0eh8PvGycZ8Yb80HmB7Ts1YMOMUfbvm3FfPvaFPtkTM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector1-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1l5Z0vYbqYP7KSTi3kmtsxMgBFD18PPqdWQg1taQ8k=;
 b=BQYZaSpddyHy5qH581WiXcXmUs833otM2wwWWv4znS/viNrS0+ACkjXNMrptTSS+vobJtUGgjPuRlZCxdXk3cCBcoLEHAdXeep0bjoI7QCNoRFQrZUIE4soHtBnND5tAyOMnQ0uddVNhwrXJ54CJhtofGRMv5RlWVNPYkHYZ9xk=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB5726.namprd04.prod.outlook.com (20.179.21.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Fri, 28 Jun 2019 03:00:05 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::397b:3922:4027:f635%3]) with mapi id 15.20.2032.016; Fri, 28 Jun 2019
 03:00:05 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v2] Adjust analogix chip driver location
Thread-Topic: [PATCH v2] Adjust analogix chip driver location
Thread-Index: AQHVLV2WCWeZm1Hwg0iNc/LOCnv60g==
Date:   Fri, 28 Jun 2019 03:00:05 +0000
Message-ID: <20190628025957.GA16108@xin-VirtualBox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:36::29) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad8ee2a3-7f84-4d6e-e486-08d6fb74b859
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5726;
x-ms-traffictypediagnostic: MN2PR04MB5726:
x-microsoft-antispam-prvs: <MN2PR04MB5726452372BCF3A88EA6FA7BC7FC0@MN2PR04MB5726.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(39850400004)(346002)(136003)(366004)(189003)(199004)(476003)(66476007)(66446008)(64756008)(81156014)(256004)(5660300002)(2501003)(33716001)(2906002)(86362001)(66556008)(66946007)(73956011)(71200400001)(71190400001)(1076003)(14454004)(8936002)(110136005)(486006)(6116002)(81166006)(8676002)(3846002)(26005)(316002)(54906003)(53936002)(25786009)(66066001)(186003)(99286004)(9686003)(7736002)(4326008)(6506007)(107886003)(52116002)(305945005)(6486002)(478600001)(102836004)(33656002)(68736007)(6512007)(386003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5726;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oTfQZaLkek8/ipkHWISD84b2A19OyXztbcXnmwoTE2JDVNAjGfaTrW1w1RjPYTwnqfS8su/qXDd5CvWwG7hC1tykLWQaUsVWcbrJmIqvyUtjpNDbtTvuIboSYIT6TDAexRGE4B3+k2F4g69XJ+S4gKK7ktZX9PrUgDswUFJFnLiqJr0uIITNHM7dQ3m7yq4AnN+/w9n6wyHIBldNAXRhEm9JXoNQvCqva6g2iTQ0sA1rdB/xgCyOQv5sMx78NV8wn37+D3s7dELD7XaGu87kupbqV1sP2MnY79cfZW43tOneq018y72YiLqOVvpdyq705YzZLCd8nDu3HubZ0d2AJjAZxfbr7117Xkuin+ItNcFJx27v0hay8fGn96ojR5rZTI8ch1jA7HmuX39J2oYDhSavnahDAE1V0naFreWfeOM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B9E23BCA8BDD34EA3486D765F48E57A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8ee2a3-7f84-4d6e-e486-08d6fb74b859
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 03:00:05.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xji@analogixsemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move analogix chip ANX78XX bridge driver into "analogix" directory.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/Kconfig                           | 10 ----------
 drivers/gpu/drm/bridge/Makefile                          |  3 +--
 drivers/gpu/drm/bridge/analogix/Kconfig                  | 10 ++++++++++
 drivers/gpu/drm/bridge/analogix/Makefile                 |  2 ++
 drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.c |  0
 drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.h |  0
 6 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.c (100%)
 rename drivers/gpu/drm/bridge/{ =3D> analogix}/analogix-anx78xx.h (100%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfi=
g
index ee77746..862789b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -16,16 +16,6 @@ config DRM_PANEL_BRIDGE
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
=20
-config DRM_ANALOGIX_ANX78XX
-	tristate "Analogix ANX78XX bridge"
-	select DRM_KMS_HELPER
-	select REGMAP_I2C
-	---help---
-	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
-	  designed for portable devices. The ANX78XX transforms
-	  the HDMI output of an application processor to MyDP
-	  or DisplayPort.
-
 config DRM_CDNS_DSI
 	tristate "Cadence DPI/DSI bridge"
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makef=
ile
index 4934fcf..223ca5d 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) +=3D analogix-anx78xx.o
 obj-$(CONFIG_DRM_CDNS_DSI) +=3D cdns-dsi.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) +=3D dumb-vga-dac.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) +=3D lvds-encoder.o
@@ -12,8 +11,8 @@ obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
 obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358764) +=3D tc358764.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) +=3D tc358767.o
-obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
 obj-$(CONFIG_DRM_TI_SN65DSI86) +=3D ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) +=3D ti-tfp410.o
+obj-y +=3D analogix/
 obj-y +=3D synopsys/
diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/brid=
ge/analogix/Kconfig
index e930ff9..dfe84f5 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config DRM_ANALOGIX_ANX78XX
+	tristate "Analogix ANX78XX bridge"
+	select DRM_KMS_HELPER
+	select REGMAP_I2C
+	---help---
+	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
+	  designed for portable devices. The ANX78XX transforms
+	  the HDMI output of an application processor to MyDP
+	  or DisplayPort.
+
 config DRM_ANALOGIX_DP
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bri=
dge/analogix/Makefile
index fdbf3fd..d4c54ac 100644
--- a/drivers/gpu/drm/bridge/analogix/Makefile
+++ b/drivers/gpu/drm/bridge/analogix/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) +=3D analogix-anx78xx.o
+
 analogix_dp-objs :=3D analogix_dp_core.o analogix_dp_reg.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) +=3D analogix_dp.o
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/br=
idge/analogix/analogix-anx78xx.c
similarity index 100%
rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/br=
idge/analogix/analogix-anx78xx.h
similarity index 100%
rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
--=20
2.7.4

