Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF31206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143604;
	bh=Qd/xuIspfGELkLAKANspg6whBWC/YOasqt+zS66jQBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jdfQanjUf6cxiTPi6VsD1j0YZgdh+AwDTEGRAcgxwHZ8FI6zhXoBZJyR+Z4+NdDq1
	 gTTtcrb2/VNEnSLmWbSelMDoMPOPr9Z251KV4yKOF2vIEoxIABRlrGfRswqRrxAX4C
	 tBnbgB4MWGMBKc/ISV2RIX/JfIyS+hnjcnI4pwG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKSFeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfKSFeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922682071B;
        Tue, 19 Nov 2019 05:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141662;
        bh=Qd/xuIspfGELkLAKANspg6whBWC/YOasqt+zS66jQBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtoweNwgEiVotIvL6M6HW8OoV9o/PIUhbcpWKuYo2hVsTB8P/utKmlwVIwDuOOXXi
         /Slih44J1ZVmmmg//3WRMbmfawjaBswV94C73x0q6U9SA2S9n4toSRIOXSTsiB/MVU
         6FY05oGtlWmZCD70w3DzFDGdLdCUc//ryFWxCrw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 238/422] media: vsp1: Fix YCbCr planar formats pitch calculation
Date:   Tue, 19 Nov 2019 06:17:15 +0100
Message-Id: <20191119051414.480175473@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

[ Upstream commit 9b2798d5b71c50f64c41a40f0cbcae47c3fbd067 ]

YCbCr planar formats can have different pitch values for the luma and
chroma planes. This isn't taken into account in the driver. Fix it.

Based on a BSP patch from Koji Matsuoka <koji.matsuoka.xm@renesas.com>.

Fixes: 7863ac504bc5 ("drm: rcar-du: Add tri-planar memory formats support")
[Updated documentation of the struct vsp1_du_atomic_config pitch field]

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vsp1/vsp1_drm.c | 11 ++++++++++-
 include/media/vsp1.h                   |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index b9c0f695d002b..8d86f618ec776 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -770,6 +770,7 @@ int vsp1_du_atomic_update(struct device *dev, unsigned int pipe_index,
 	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
 	struct vsp1_drm_pipeline *drm_pipe = &vsp1->drm->pipe[pipe_index];
 	const struct vsp1_format_info *fmtinfo;
+	unsigned int chroma_hsub;
 	struct vsp1_rwpf *rpf;
 
 	if (rpf_index >= vsp1->info->rpf_count)
@@ -810,10 +811,18 @@ int vsp1_du_atomic_update(struct device *dev, unsigned int pipe_index,
 		return -EINVAL;
 	}
 
+	/*
+	 * Only formats with three planes can affect the chroma planes pitch.
+	 * All formats with two planes have a horizontal subsampling value of 2,
+	 * but combine U and V in a single chroma plane, which thus results in
+	 * the luma plane and chroma plane having the same pitch.
+	 */
+	chroma_hsub = (fmtinfo->planes == 3) ? fmtinfo->hsub : 1;
+
 	rpf->fmtinfo = fmtinfo;
 	rpf->format.num_planes = fmtinfo->planes;
 	rpf->format.plane_fmt[0].bytesperline = cfg->pitch;
-	rpf->format.plane_fmt[1].bytesperline = cfg->pitch;
+	rpf->format.plane_fmt[1].bytesperline = cfg->pitch / chroma_hsub;
 	rpf->alpha = cfg->alpha;
 
 	rpf->mem.addr[0] = cfg->mem[0];
diff --git a/include/media/vsp1.h b/include/media/vsp1.h
index 3093b9cb9067e..5b383d01c84a0 100644
--- a/include/media/vsp1.h
+++ b/include/media/vsp1.h
@@ -46,7 +46,7 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
 /**
  * struct vsp1_du_atomic_config - VSP atomic configuration parameters
  * @pixelformat: plane pixel format (V4L2 4CC)
- * @pitch: line pitch in bytes, for all planes
+ * @pitch: line pitch in bytes for the first plane
  * @mem: DMA memory address for each plane of the frame buffer
  * @src: source rectangle in the frame buffer (integer coordinates)
  * @dst: destination rectangle on the display (integer coordinates)
-- 
2.20.1



