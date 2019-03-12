Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6523D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413677;
	bh=kLMcvt54jUyMa8fUvuZRSrEkyGzzoOUEdFkvDC/BYL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NNxqy7zTgz78O4OI58StA4hyTF6axGWaTtz58wy3Zg+qlZn3v0SRp+3h41hnUWqTF
	 La+J6+yJIf9qoD+db40FadMp21t6gou4X426RcnRQ/KyabmohHHouWE/ROyBmOLzOg
	 edcDBK5ozHOve7nkwzkHe5jwI4eYgdXT1O5XwnvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCLSBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfCLRNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437722177E;
        Tue, 12 Mar 2019 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410793;
        bh=kLMcvt54jUyMa8fUvuZRSrEkyGzzoOUEdFkvDC/BYL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWV7PhyxdciHB/Gpyiz6918DUgzVc6HlIv3hibXCjMGkL9/RzZ7gexmmRtz+sclZg
         FWrbNFVYLnKSwULIqE2Havtix4SVqoVHt2SiYBmEXq2vpB3+Qh11bRI81aqdFptmI2
         Pk1yMwOJKvZ02DSlAYvA/PogkBcGFoSXRIYEzLBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 138/171] drm/omap: dsi: Hack-fix DSI bus flags
Date:   Tue, 12 Mar 2019 10:08:38 -0700
Message-Id: <20190312170359.563760416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b5685018d830..64fb788b6647 100644
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



