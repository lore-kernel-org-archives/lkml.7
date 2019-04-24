Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07E4218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="K2Yitmbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDXOW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:22:26 -0400
Received: from rout5.hes.trendmicro.com ([54.219.188.4]:33010 "EHLO
        rout5.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDXOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:22:26 -0400
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.197])
        by rout5.hes.trendmicro.com (Postfix) with SMTP id 9A5E6EFC085;
        Wed, 24 Apr 2019 14:22:24 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.51])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id 289B0142C073;
        Wed, 24 Apr 2019 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvzASMsebWRVqP0Lh5xqAcpXUBMefMIixEOWvfiY2so=;
 b=K2Yitmbp+akFPQ42OpT2OBHD2wXB7NOmVm+QRY09XOBiYTFur6dKLk4YKe4HjjyurH17BBHI0l343DNqWjBpmdxVdFXklK29sDziiESH5ts+dq1xizhVZI8OqhH7DORIA6ch0Uk76XbRBNvc17L9gky3nSXBEZtzKBVrpZe5Z90=
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM (20.179.238.86) by
 MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM (10.255.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:22:18 +0000
Received: from MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a]) by MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f0fa:29f3:9933:7d7a%3]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 14:22:18 +0000
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
Subject: [PATCH] drm/bridge/synopsys: dsi: Allow VPG to be enabled via debugfs
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Thread-Index: AQHU+qkfnnF7eMdiaUyqNeOuxcdkXQ==
Date:   Wed, 24 Apr 2019 14:22:18 +0000
Message-ID: <20190424142205.26088-1-matt.redfearn@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:6:15::48) To MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:7b::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85454ae3-0520-4856-51cc-08d6c8c041bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MA1PR01MB3194;
x-ms-traffictypediagnostic: MA1PR01MB3194:
x-microsoft-antispam-prvs: <MA1PR01MB319452BF8A4628992099F4E6F13C0@MA1PR01MB3194.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(8676002)(316002)(2906002)(2616005)(486006)(476003)(66066001)(36756003)(81166006)(14454004)(81156014)(478600001)(5024004)(6506007)(256004)(14444005)(386003)(26005)(68736007)(186003)(66946007)(73956011)(5660300002)(64756008)(66476007)(3846002)(6116002)(66556008)(50226002)(7416002)(66446008)(8936002)(102836004)(6512007)(71190400001)(1076003)(71200400001)(52116002)(97736004)(53936002)(4326008)(6436002)(25786009)(7736002)(305945005)(99286004)(6486002)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MA1PR01MB3194;H:MA1PR01MB3770.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zv8b3tErnYAtIKDI+sjt3hbsLnxyF8cEy2vIfXIpzfPe3KeBtJBhozfiajOZ27nc2UQahz1uP2NlQMWOk+q/G3DA1tZoggI/Jhj7mcaUsNXmJWG0Ik05PSsX/vPcjR8JKiFlMY0USu4GOP+hJ1oYqIBagWuZI0eQlry2MyBnfAbPAXPKaK1frybAbzv+dUnwfcRVTmXCRhMI+RHsRkvlK3K5JGncHNSdwfDIxDC43DIygs4Ma1QWqs1Yu86KQ6Qguabk8vAU7CbesfvFTPiJuv2XBEeArdgLf4xpjoUl3pXEIDWcXMsdixz9rnAEG56SMK0QD2NmpZt57PiiPv65OUYDr7OJZuJko2TLFXuaGWHE6j7LOLRmVHuyWnzqsODYzuek5wzZ8uqLrbWMU1yRDt/AkgrGwcqjGS9JODJy3ZE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85454ae3-0520-4856-51cc-08d6c8c041bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:22:18.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB3194
X-TMASE-Version: StarCloud-1.3-8.2.1013-24572.000
X-TMASE-Result: 10--8.258500-4.000000
X-TMASE-MatchedRID: N6RoV4w/VMjR4xvaZ9xZ8Vz+axQLnAVBSjyMfjCRfaN4+LtSkGbmRLdX
        7/TKu75Lo5qw/iFKtvYn1aTwtcqsuNvJAvCq+wLJFYJUGv4DL3zX9WK4/6fjuruqk4cq52pzcDD
        lNq1KjQ6/hlMVvNZyV36KhiGbVJ4Imxh0gY/o+VnLtNJZxvPj1sCY5/Mqi1OimI1RpP/+oMnv6l
        FsG12On4VZhfZM9sMSW5X2Hh0ZfAh1ZIBJvSVnHRIRh9wkXSlF8boZEVitthiYh23xcUPEK6PFj
        JEFr+olUkOfGeXobzSrJyRjvjjzprVQu1GNZ+siOwBXM346/+yYF8Y9EFrAyOk3pNkt3vzpOJ40
        Hicpxi/U82UDmKw/6wFrLHz9Z4Ro
X-TM-Deliver-Signature: 776B324028F0BE583E242E7F927C32CD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys MIPI DSI IP contains a video test pattern generator which
is helpful in debugging video timing with connected displays.
Add a debugfs directory containing files which allow the VPG to be
enabled and disabled, and it's orientation to be changed.

Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

---

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index 0ee440216b8..a1ee2306382 100644
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
@@ -234,6 +237,15 @@ struct dw_mipi_dsi {
 	u32 format;
 	unsigned long mode_flags;
=20
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
+	struct dentry *debugfs_vpg;
+	struct dentry *debugfs_vpg_horizontal;
+
+	bool vpg;
+	bool vpg_horizontal;
+#endif /* CONFIG_DEBUG_FS */
+
 	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
 	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
=20
@@ -525,6 +537,11 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mi=
pi_dsi *dsi)
 	else
 		val |=3D VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
=20
+	if (dsi->vpg) {
+		val |=3D VID_MODE_VPG_ENABLE;
+		val |=3D dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : 0;
+	}
+
 	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
=20
@@ -935,6 +952,41 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridg=
e_funcs =3D {
 	.attach	      =3D dw_mipi_dsi_bridge_attach,
 };
=20
+#ifdef CONFIG_DEBUG_FS
+
+static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
+{
+	struct dentry *d;
+
+	d =3D debugfs_create_dir(dev_name(dsi->dev), NULL);
+	if (IS_ERR(d)) {
+		dev_err(dsi->dev, "failed to create debugfs root\n");
+		return;
+	}
+	dsi->debugfs_root =3D d;
+
+	d =3D debugfs_create_bool("vpg", 0660, dsi->debugfs_root, &dsi->vpg);
+	dsi->debugfs_vpg =3D d;
+
+	d =3D debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs_root,
+				&dsi->vpg_horizontal);
+	dsi->debugfs_vpg_horizontal =3D d;
+}
+
+static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
+{
+	debugfs_remove(dsi->debugfs_vpg_horizontal);
+	debugfs_remove(dsi->debugfs_vpg);
+	debugfs_remove(dsi->debugfs_root);
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
@@ -1005,6 +1057,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		clk_disable_unprepare(dsi->pclk);
 	}
=20
+	dw_mipi_dsi_debugfs_init(dsi);
 	pm_runtime_enable(dev);
=20
 	dsi->dsi_host.ops =3D &dw_mipi_dsi_host_ops;
@@ -1012,6 +1065,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 	ret =3D mipi_dsi_host_register(&dsi->dsi_host);
 	if (ret) {
 		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
+		dw_mipi_dsi_debugfs_remove(dsi);
 		return ERR_PTR(ret);
 	}
=20
@@ -1029,6 +1083,7 @@ static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *=
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

