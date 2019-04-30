Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40FCC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AAA2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="d2OI9BHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfD3IRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:17:14 -0400
Received: from rout6.hes.trendmicro.com ([54.219.188.12]:48405 "EHLO
        rout6.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfD3IRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:17:13 -0400
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.0.79])
        by rout6.hes.trendmicro.com (Postfix) with SMTP id 140F4C66075;
        Tue, 30 Apr 2019 08:17:12 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.58])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id C53AC142C0C3;
        Tue, 30 Apr 2019 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPYLmowVYQ02EvrAA3jHGiyQaBFwbFriXrHDk92xRuw=;
 b=d2OI9BHal8v0r/0hMwFAtAynvImlvGzHqchZ8HFfQm+D/vwIaQG+beGI9e1weEUXSWfF7ZBd8htHUVz8otjH4ZuhGNyB7oaRQEkiEpk01N/m10WCC3rvF/oRPDASJq/ZUpWbZFPtfVMaMC1or8LiiZC29B04HvKPmMyFuMcw3SY=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXPR01MB2864.INDPRD01.PROD.OUTLOOK.COM (52.134.153.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 08:17:04 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 08:17:04 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philippe Cornu <philippe.cornu@st.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Thread-Topic: [PATCH v2] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Thread-Index: AQHU/y0X85i6EeTE0U60zrEiE1o5cg==
Date:   Tue, 30 Apr 2019 08:17:04 +0000
Message-ID: <20190430081646.23845-1-matt.redfearn@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::16)
 To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6559e8f4-9d5f-46bd-4cd7-08d6cd443a34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MAXPR01MB2864;
x-ms-traffictypediagnostic: MAXPR01MB2864:
x-microsoft-antispam-prvs: <MAXPR01MB28644A0AEA1A9C90343BDDE0F13A0@MAXPR01MB2864.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(66946007)(68736007)(97736004)(25786009)(14454004)(66066001)(8936002)(5660300002)(81166006)(71200400001)(8676002)(1076003)(50226002)(478600001)(81156014)(66446008)(66556008)(66476007)(73956011)(53936002)(4326008)(71190400001)(110136005)(54906003)(64756008)(316002)(99286004)(6512007)(52116002)(486006)(26005)(386003)(6506007)(7416002)(2616005)(36756003)(476003)(256004)(186003)(5024004)(14444005)(6486002)(6436002)(102836004)(305945005)(7736002)(2906002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXPR01MB2864;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFn5nMroDhE+ZWXiqjgPtEX5DJWAEYJx6hoNjDns8o8/i29tKR5GW87ewF/4WrVjWrLL1fFzwZRk+/K/2tZljW8X4P0Pnxta3iY7ZKHiFkKqCP96lB/EzPI9Gc3G2AHenpCre+1rsc+QK7xLrUV2l4aNeZlEMb14osW6bVa+6rjJ24Dm5KSlstkGPM0admJF8UIK62J/a2C8P/zp2rLtXyIe/iEVAi9Fwie3BsrAozvBrFTUkGXvxwB22VaahwCvUS9ftSC0tyQO1oVz73bvhJd9CY05HBQ+V7DtcSpZvc/4vY7V5bP4jIeiaOfRSH1Cps6hIbx5ZLy3Dqpc2m1qk+COBoWeDEPMhjrL+IOC5vthlh08Rs+SLKfa/kW3z6v4L8qXyg1Manyh6o2h8CKhhOxjAa8rBYshZTfic8BYPpg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6559e8f4-9d5f-46bd-4cd7-08d6cd443a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 08:17:04.2914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB2864
X-TMASE-Version: StarCloud-1.3-8.2.1013-24582.005
X-TMASE-Result: 10--9.128500-4.000000
X-TMASE-MatchedRID: nGppxvS+IHPR4xvaZ9xZ8Vz+axQLnAVBSjyMfjCRfaN4+LtSkGbmRCHa
        aMcDmXB8BBpBXZf7YnUzZe+o7AuU8Fgh7i+m6ZSoQ4srjeRbxTZMkOX0UoduuUYvSDWdWaRhvhz
        rAO0tfOGNa38iHcumyZE+qu86ckW2MDQQSfAWi0UjRwcsjqWGApnaxzJFBx6vFLXUWU5hGiF7+y
        KPdawX8BMn1w92ZWV2V1M/l3DgYRGw8kFTdnBpUcnlbo5l7mGF97DDOyJXCvCur1HD2qZWmBv/r
        jinePEHJkTkP3kjv4h+NZ4lfSsps4f1OcQR3MITEzQnFLEeMUndB/CxWTRRu25FeHtsUoHuUrFm
        wQyEzhCd8GFbBUTB/TVBAMAoIf4wC80R8ph3RCtLDBwYotNgRw==
X-TM-Deliver-Signature: 4264680189D75E601961A73C5D6DB708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys MIPI DSI IP contains a video test pattern generator which
is helpful in debugging video timing with connected displays.
Add a debugfs directory containing files which allow the VPG to be
enabled and disabled, and its orientation to be changed.

Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

Changes in v2:
- Ensure dw_mipi_dsi_video_mode_config() doesn't break without CONFIG_DEBUG=
_FS
- Tidy up initialisation / tidy up of debugfs

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index 0ee440216b8..bffeef7a6cc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -10,6 +10,7 @@
=20
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/debugfs.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -86,6 +87,8 @@
 #define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
 #define VID_MODE_TYPE_BURST			0x2
 #define VID_MODE_TYPE_MASK			0x3
+#define VID_MODE_VPG_ENABLE		BIT(16)
+#define VID_MODE_VPG_HORIZONTAL		BIT(24)
=20
 #define DSI_VID_PKT_SIZE		0x3c
 #define VID_PKT_SIZE(p)			((p) & 0x3fff)
@@ -234,6 +237,13 @@ struct dw_mipi_dsi {
 	u32 format;
 	unsigned long mode_flags;
=20
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+
+	bool vpg;
+	bool vpg_horizontal;
+#endif /* CONFIG_DEBUG_FS */
+
 	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
 	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
=20
@@ -525,6 +535,13 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mi=
pi_dsi *dsi)
 	else
 		val |=3D VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
=20
+#ifdef CONFIG_DEBUG_FS
+	if (dsi->vpg) {
+		val |=3D VID_MODE_VPG_ENABLE;
+		val |=3D dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : 0;
+	}
+#endif /* CONFIG_DEBUG_FS */
+
 	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
=20
@@ -935,6 +952,33 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridg=
e_funcs =3D {
 	.attach	      =3D dw_mipi_dsi_bridge_attach,
 };
=20
+#ifdef CONFIG_DEBUG_FS
+
+static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
+{
+	dsi->debugfs =3D debugfs_create_dir(dev_name(dsi->dev), NULL);
+	if (IS_ERR(dsi->debugfs)) {
+		dev_err(dsi->dev, "failed to create debugfs root\n");
+		return;
+	}
+
+	debugfs_create_bool("vpg", 0660, dsi->debugfs, &dsi->vpg);
+	debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs,
+			    &dsi->vpg_horizontal);
+}
+
+static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
+{
+	debugfs_remove_recursive(dsi->debugfs);
+}
+
+#else
+
+static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi) { }
+static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi) { }
+
+#endif /* CONFIG_DEBUG_FS */
+
 static struct dw_mipi_dsi *
 __dw_mipi_dsi_probe(struct platform_device *pdev,
 		    const struct dw_mipi_dsi_plat_data *plat_data)
@@ -1005,6 +1049,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		clk_disable_unprepare(dsi->pclk);
 	}
=20
+	dw_mipi_dsi_debugfs_init(dsi);
 	pm_runtime_enable(dev);
=20
 	dsi->dsi_host.ops =3D &dw_mipi_dsi_host_ops;
@@ -1012,6 +1057,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	ret =3D mipi_dsi_host_register(&dsi->dsi_host);
 	if (ret) {
 		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
+		dw_mipi_dsi_debugfs_remove(dsi);
 		return ERR_PTR(ret);
 	}
=20
@@ -1029,6 +1075,7 @@ static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *=
dsi)
 	mipi_dsi_host_unregister(&dsi->dsi_host);
=20
 	pm_runtime_disable(dsi->dev);
+	dw_mipi_dsi_debugfs_remove(dsi);
 }
=20
 void dw_mipi_dsi_set_slave(struct dw_mipi_dsi *dsi, struct dw_mipi_dsi *sl=
ave)
--=20
2.17.1

