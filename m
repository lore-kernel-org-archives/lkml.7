Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6649D218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366659;
	bh=JE/Kz3jNY9Gw7ZPlb3fuYV6qPDSLNORXZVbNeKV04wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyXVIggy5At8oMYvtaIOxs6BHtvjHJKDOwOhVHvp+11U9CPzNU/Xq+AE9AO73lD2R
	 qvy63ztzi5nVlaSCoB0ITSu3USxXSMARtEMbQ9qzHsbMMuVB2QhvwL/pkoPo1bAx+H
	 WWNu/X5Pj3KcUyXl0c0+r9MzJF7hJuEuUzU8iCWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfB1PK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfB1PK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DAC52171F;
        Thu, 28 Feb 2019 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366655;
        bh=JE/Kz3jNY9Gw7ZPlb3fuYV6qPDSLNORXZVbNeKV04wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg1mR0Ymc9I4oxEqlBAQsBWBD+nj+XF9KQbbi5JUUqPkwUqOMV4OO6LTJ9qTCanrE
         V4YdEc9q1XjfJQe3XR2lxuKXdu466dt7LcnLv9DdCTXUrlbPdo7gRQV+ppZ6cTkUMx
         RpdL9sms8X2lohxVG5SdjkK4v9w1wwKR6dkAc7OM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 74/81] drm/omap: dsi: Hack-fix DSI bus flags
Date:   Thu, 28 Feb 2019 10:08:06 -0500
Message-Id: <20190228150813.10256-74-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 6297388e1eddd2f1345cea5892156223995bcf2d ]

Since commit b4935e3a3cfa ("drm/omap: Store bus flags in the
omap_dss_device structure") video mode flags are managed by the omapdss
(and later omapdrm) core based on bus flags stored in omap_dss_device.
This works fine for all devices whose video modes are set by the omapdss
and omapdrm core, but breaks DSI operation as the DSI still uses legacy
code paths and sets the DISPC timings manually.

To fix the problem properly we should move the DSI encoder to the new
encoder model. This will however require a considerable amount of work.
Restore DSI operation by adding back video mode flags handling in the
DSI encoder driver as a hack in the meantime.

Fixes: b4935e3a3cfa ("drm/omap: Store bus flags in the omap_dss_device structure")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190111035120.20668-5-laurent.pinchart@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index b5685018d8302..64fb788b66474 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4751,6 +4751,17 @@ static int dsi_set_config(struct omap_dss_device *dssdev,
 	dsi->vm.flags |= DISPLAY_FLAGS_HSYNC_HIGH;
 	dsi->vm.flags &= ~DISPLAY_FLAGS_VSYNC_LOW;
 	dsi->vm.flags |= DISPLAY_FLAGS_VSYNC_HIGH;
+	/*
+	 * HACK: These flags should be handled through the omap_dss_device bus
+	 * flags, but this will only be possible when the DSI encoder will be
+	 * converted to the omapdrm-managed encoder model.
+	 */
+	dsi->vm.flags &= ~DISPLAY_FLAGS_PIXDATA_NEGEDGE;
+	dsi->vm.flags |= DISPLAY_FLAGS_PIXDATA_POSEDGE;
+	dsi->vm.flags &= ~DISPLAY_FLAGS_DE_LOW;
+	dsi->vm.flags |= DISPLAY_FLAGS_DE_HIGH;
+	dsi->vm.flags &= ~DISPLAY_FLAGS_SYNC_POSEDGE;
+	dsi->vm.flags |= DISPLAY_FLAGS_SYNC_NEGEDGE;
 
 	dss_mgr_set_timings(&dsi->output, &dsi->vm);
 
-- 
2.19.1

