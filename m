Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B2C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604A02725F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395180;
	bh=0BH7zsVElE5DDidWWhc24VgxlmlbeytlvrOF5RZBkgI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TSOmFkXGNz2AFik7phxiZeuiBWpcNsAY1PSWnMGGNxFpbSfUH8idjqryt73jMTuBH
	 1/x3Tj9pANl9c3jzMFVUaeu53IktEjFFS09H5uCHIizKqXCKLQkNTfwPtj2x+rF1wq
	 d7ezvXOqW6o3F/1/96LGbKBgT145gZZVaCRFdETM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfFANTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfFANTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:19:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4A4272BE;
        Sat,  1 Jun 2019 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395176;
        bh=0BH7zsVElE5DDidWWhc24VgxlmlbeytlvrOF5RZBkgI=;
        h=From:To:Cc:Subject:Date:From;
        b=DnuLTbkFfqGn9ia3ApPI4iiDFb+8wx9EuSLf9veL3lVWa0QV0j9T6O6SogD1ivUwV
         Fn9/4XpeFSO1cow30isMmcxRSSEr/1m+8APJjDM1ekazo/Y3IkKI/ppl90tuwjCOrI
         IxOOvDTp0mqM+dXILwCTGrJqz0eg6Ui1CKR3hCcQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 001/173] media: rockchip/vpu: Fix/re-order probe-error/remove path
Date:   Sat,  1 Jun 2019 09:16:33 -0400
Message-Id: <20190601131934.25053-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit fc8670d1f72b746ff3a5fe441f1fca4c4dba0e6f ]

media_device_cleanup() and v4l2_m2m_unregister_media_controller() were
missing in the probe error path.
While at it, re-order calls in the remove path to unregister/cleanup
things in the reverse order they were initialized/registered.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
index 962412c79b917..33b556b3f0df8 100644
--- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
+++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
@@ -481,10 +481,12 @@ static int rockchip_vpu_probe(struct platform_device *pdev)
 	return 0;
 err_video_dev_unreg:
 	if (vpu->vfd_enc) {
+		v4l2_m2m_unregister_media_controller(vpu->m2m_dev);
 		video_unregister_device(vpu->vfd_enc);
 		video_device_release(vpu->vfd_enc);
 	}
 err_m2m_rel:
+	media_device_cleanup(&vpu->mdev);
 	v4l2_m2m_release(vpu->m2m_dev);
 err_v4l2_unreg:
 	v4l2_device_unregister(&vpu->v4l2_dev);
@@ -501,13 +503,13 @@ static int rockchip_vpu_remove(struct platform_device *pdev)
 	v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
 
 	media_device_unregister(&vpu->mdev);
-	v4l2_m2m_unregister_media_controller(vpu->m2m_dev);
-	v4l2_m2m_release(vpu->m2m_dev);
-	media_device_cleanup(&vpu->mdev);
 	if (vpu->vfd_enc) {
+		v4l2_m2m_unregister_media_controller(vpu->m2m_dev);
 		video_unregister_device(vpu->vfd_enc);
 		video_device_release(vpu->vfd_enc);
 	}
+	media_device_cleanup(&vpu->mdev);
+	v4l2_m2m_release(vpu->m2m_dev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	pm_runtime_disable(vpu->dev);
-- 
2.20.1

