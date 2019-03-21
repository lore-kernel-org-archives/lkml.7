Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F548218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCUIOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:14:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727823AbfCUIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:14:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2L8D6MY005365;
        Thu, 21 Mar 2019 09:14:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8q5bmd42-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 09:14:15 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4779C31;
        Thu, 21 Mar 2019 08:14:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AA0A24DF;
        Thu, 21 Mar 2019 08:14:15 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Mar
 2019 09:14:15 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Mar 2019 09:14:14
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] drm/stm: dw_mipi_dsi-stm: add sleep power management
Date:   Thu, 21 Mar 2019 09:13:53 +0100
Message-ID: <1553156033-13792-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements system sleep power management ops.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index a672b59..1bef73e 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -356,12 +356,40 @@ static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
+{
+	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	clk_disable_unprepare(dsi->pllref_clk);
+
+	return 0;
+}
+
+static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
+{
+	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	clk_prepare_enable(dsi->pllref_clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_mipi_dsi_stm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
+				dw_mipi_dsi_stm_resume)
+};
+
 static struct platform_driver dw_mipi_dsi_stm_driver = {
 	.probe		= dw_mipi_dsi_stm_probe,
 	.remove		= dw_mipi_dsi_stm_remove,
 	.driver		= {
 		.of_match_table = dw_mipi_dsi_stm_dt_ids,
 		.name	= "stm32-display-dsi",
+		.pm = &dw_mipi_dsi_stm_pm_ops,
 	},
 };
 
-- 
2.7.4

