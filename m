Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55185C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23736222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119586;
	bh=DgPK/T0HZnKx0FixGTBXeg0NyxeriDAR+9mR7HWK4XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhVs4w6+cr6xod/3CjWAMn1scNQoZwuMDl0kZ7v6A3ZSXhHVBmSiCtAjcvzvFxTsx
	 7s+KHIZjxxWtALHbXfF90dG1iVXr6MIJBkAPRdofrfdbA2qAgRCC1g3NMxh8XxkaLC
	 WtAx1s1A6zM2+PddjqnYPCIOR0y2+RBDQ81MJOp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfJCQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbfJCQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FC92054F;
        Thu,  3 Oct 2019 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119577;
        bh=DgPK/T0HZnKx0FixGTBXeg0NyxeriDAR+9mR7HWK4XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1S7gwfiat2L8VzAAbBaaB/KgPgDIgiIy1bjSPdMBlIoy1a3lWEl45XTFhcfq4Lak
         MryVlLy3wfSAl23KoHtGvXXFL7SHb76mrv9ypvpSWvIB3SbTlX+b5qFITHcKQ7gr4N
         J5ITTri7JjS41/qXlBdORLSgRMJhtFkTKeiUh8Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/211] media: imx: mipi csi-2: Dont fail if initial state times-out
Date:   Thu,  3 Oct 2019 17:52:24 +0200
Message-Id: <20191003154505.303768265@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit 0d5078c7172c46db6c58718d817b9fcf769554b4 ]

Not all sensors will be able to guarantee a proper initial state.
This may be either because the driver is not properly written,
or (probably unlikely) because the hardware won't support it.

While the right solution in the former case is to fix the sensor
driver, the real world not always allows right solutions, due to lack
of available documentation and support on these sensors.

Let's relax this requirement, and allow the driver to support stream start,
even if the sensor initial sequence wasn't the expected.

Also improve the warning message to better explain the problem and provide
a hint that the sensor driver needs to be fixed.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Steve Longerbeam <slongerbeam@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index ceeeb3069a024..212fa06f7c57c 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -247,7 +247,7 @@ static int __maybe_unused csi2_dphy_wait_ulp(struct csi2_dev *csi2)
 }
 
 /* Waits for low-power LP-11 state on data and clock lanes. */
-static int csi2_dphy_wait_stopstate(struct csi2_dev *csi2)
+static void csi2_dphy_wait_stopstate(struct csi2_dev *csi2)
 {
 	u32 mask, reg;
 	int ret;
@@ -258,11 +258,9 @@ static int csi2_dphy_wait_stopstate(struct csi2_dev *csi2)
 	ret = readl_poll_timeout(csi2->base + CSI2_PHY_STATE, reg,
 				 (reg & mask) == mask, 0, 500000);
 	if (ret) {
-		v4l2_err(&csi2->sd, "LP-11 timeout, phy_state = 0x%08x\n", reg);
-		return ret;
+		v4l2_warn(&csi2->sd, "LP-11 wait timeout, likely a sensor driver bug, expect capture failures.\n");
+		v4l2_warn(&csi2->sd, "phy_state = 0x%08x\n", reg);
 	}
-
-	return 0;
 }
 
 /* Wait for active clock on the clock lane. */
@@ -320,9 +318,7 @@ static int csi2_start(struct csi2_dev *csi2)
 	csi2_enable(csi2, true);
 
 	/* Step 5 */
-	ret = csi2_dphy_wait_stopstate(csi2);
-	if (ret)
-		goto err_assert_reset;
+	csi2_dphy_wait_stopstate(csi2);
 
 	/* Step 6 */
 	ret = v4l2_subdev_call(csi2->src_sd, video, s_stream, 1);
-- 
2.20.1



