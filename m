Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA79720652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L7X9sbiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfDPPAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:57005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfDPPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426748;
        bh=vb89RwI58hI4Muw6KGF7jp8e4/iof1jiOcMOYSRKE5s=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=L7X9sbiK0JQchn7H1/1F0Y67m8s/KWTebMXVBIhxYh41Dzb/bCTrYu0Zm5GawaA+3
         UAWPBKAnCOZOmDssnQhB2a5i5EBTv3KZezzVKSNIb8UOd/mvH4VM2+cuVJTWgDsq2E
         04vDisehgKGy+BtiQjE6muI+AjHWYCgwsp2QqSks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.53.43.193]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MQdAP-1hPv0g3zR7-00U6nL; Tue, 16 Apr 2019 16:59:08 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 1/4] drm/mediatek: config component output by device node port
Date:   Tue, 16 Apr 2019 16:58:45 +0200
Message-Id: <20190416145848.11932-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416145848.11932-1-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:kF6Fe8nmXqHsGRsCBMzwIHxJsQ4jrJQeH0U7ChtBG+ENZtnMU4P
 mzP3fZ6LmMQ9wzkXLEtxyhTug7mVNnZ5aRzOFtDq+bXEq6StIN1HuPxF+cEbqgUyw0rBmgQ
 Grs0BXCKVhhEvUQ8wh8nQ0gJs1jDIDs0wbAfatxsea8E+iWDx3z9vtBnYDPza0MyYsJ+W/X
 muRpCNbF5TU+fI8/fFP2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/3inT9AlIQ=:44r0/nuzjukXaTBsgKDboP
 pT1POkQ6M8/HZoLcCnmLj6XfuC9q7DdHAHhC0f8xyemgxH2+P+PbSYbo6hJ0R6FW04r7RYktR
 3AJ0EctkNLJY4ZE2FTigSx7zhDYnKQHl22HcIktqkShVG2ae9nZvsU136yXkjt0pHLU3qN+Hb
 5pAV8Z4kWSxi8mPsovmk7joxceR6CndqpwobMZ0mgjKM4AoJ8MIiaMuFPMrH0hcwzjEiWNs8d
 kPhSutKkZZhI/OMypx7X7A3GOCmzjggy5CY2n1q8kDhwARFXruJY/lcvtvRFPSUv7QA2si8kl
 L7C0TPt6pBapGDcDc8yfp3p00+Pg+f07LRdJY6acAeIu/DMeMwc3MplvT09NkRUCNLu1Beqd0
 Ddi1YtffUaXk8hnCBvwOV9GPxTEt8+Ygkb/3focXigvUs1FEBX3NVxjrCRoglLmwvYdEo50Yb
 Sg4VTQgfiHCRvvUOHhnN4Rp/pV7AZbMJ/+AMCnwbC1SH4l4ZbK2ClhiwKM0TiiuplrVtXxr9C
 GRSQl4WaSo4cipbjQ5EDg+Q1GzSRSMwGTROqov6kaweq6COjudOjUdR4Yf70e3a4eaprrMerJ
 r9bp5qq7OGfNWasVi+3DZu25Q9duElGrUuBPndKbmSO84ZdPbNX1eq6qCC0FZIenrxjS0ZqqD
 v2VGMdYvJYi4xI70aBKp3w8sXlJorf47gMeakPNnNn0mAsH8nMHPqgpCeBS+hMLOVBZBpiTFH
 aHsHrvZrgdRFesO41hodsMWn+JGStrbehCVlSCCLwD0WcxllDbh53t8ZRO73R/lfvkx9Jp85c
 T0kgK2WEwcIjydFfPS5+STf1UVXaOstdjMt3wXdSeQLUL81evXnLoU05IERBQzm+DUsn7arne
 J2Z3dLQJ1XeiihsRk8BbnwnyDx4F8k2PpPligzJUVJy9mwb4QKvfQmBoJxKz95
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

We can select output component by decive node port.
Main path default output component is DSI.
External path default output component is DPI.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
=2D--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 41 ++++++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 +--
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/medi=
atek/mtk_drm_drv.c
index 57ce4708ef1b..d3e86426dc65 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -22,7 +22,9 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/component.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>

@@ -134,7 +136,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode=
_config_funcs =3D {
 	.atomic_commit =3D mtk_atomic_commit,
 };

-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_COLOR0,
@@ -142,12 +144,12 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_mai=
n[] =3D {
 	DDP_COMPONENT_DSI0,
 };

-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_DPI0,
 };

-static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
@@ -157,7 +159,7 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[=
] =3D {
 	DDP_COMPONENT_PWM0,
 };

-static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_AAL1,
@@ -173,7 +175,7 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third=
[] =3D {
 	DDP_COMPONENT_PWM2,
 };

-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] =3D {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
@@ -184,7 +186,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[=
] =3D {
 	DDP_COMPONENT_PWM0,
 };

-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] =3D {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -479,6 +481,7 @@ static int mtk_drm_probe(struct platform_device *pdev)

 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
+		struct device_node *port, *ep, *remote;
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -538,6 +541,32 @@ static int mtk_drm_probe(struct platform_device *pdev=
)

 			private->ddp_comp[comp_id] =3D comp;
 		}
+
+		if (comp_type !=3D MTK_DSI && comp_type !=3D MTK_DPI) {
+			port =3D of_graph_get_port_by_id(node, 0);
+			if (!port)
+				continue;
+			ep =3D of_get_child_by_name(port, "endpoint");
+			of_node_put(port);
+			if (!ep)
+				continue;
+			remote =3D of_graph_get_remote_port_parent(ep);
+			of_node_put(ep);
+			if (!remote)
+				continue;
+			of_id =3D of_match_node(mtk_ddp_comp_dt_ids, remote);
+			if (!of_id)
+				continue;
+			comp_type =3D (enum mtk_ddp_comp_type)of_id->data;
+			for (i =3D 0; i < private->data->main_len - 1; i++)
+				if (private->data->main_path[i] =3D=3D comp_id)
+					private->data->main_path[i + 1] =3D
+					mtk_ddp_comp_get_id(node, comp_type);
+			for (i =3D 0; i < private->data->ext_len - 1; i++)
+				if (private->data->ext_path[i] =3D=3D comp_id)
+					private->data->ext_path[i + 1] =3D
+					mtk_ddp_comp_get_id(node, comp_type);
+		}
 	}

 	if (!private->mutex_node) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/medi=
atek/mtk_drm_drv.h
index ecc00ca3221d..256a3ff2e66e 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -29,9 +29,9 @@ struct drm_property;
 struct regmap;

 struct mtk_mmsys_driver_data {
-	const enum mtk_ddp_comp_id *main_path;
+	enum mtk_ddp_comp_id *main_path;
 	unsigned int main_len;
-	const enum mtk_ddp_comp_id *ext_path;
+	enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
 	const enum mtk_ddp_comp_id *third_path;
 	unsigned int third_len;
=2D-
2.17.1

