Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2616AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384920644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfDYOJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:09:45 -0400
Received: from www.osadl.org ([62.245.132.105]:37911 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfDYOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:09:44 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3PE9Pbc004910;
        Thu, 25 Apr 2019 16:09:25 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Mack <daniel@zonque.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] drm/msm: check for equals 0 only
Date:   Thu, 25 Apr 2019 16:03:51 +0200
Message-Id: <1556201031-3676-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns 0 on timeout and aleast 1 otherwise
so checking for < makes no sense here. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with an experimental coccinelle script

While this check does no harm in this form - it should be fixed anyway
to comply with the API see: kernel/sched/completion.c

Also noticed that get_maintainer.pl will not list linux-kernel@vger.kernel.org
when run on drivers/gpu/drm/msm/dsi/dsi_host.c - is that intentional ?

Patch was compile-tested with: qcom_defconfig (implies DRM_MSM_DSI=y)

Patch is against v5.1-rc6 (localversion-next is next-20190424)

 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 610183d..dc16067 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1049,7 +1049,7 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
 	ret = wait_for_completion_timeout(&msm_host->video_comp,
 			msecs_to_jiffies(70));
 
-	if (ret <= 0)
+	if (ret == 0)
 		DRM_DEV_ERROR(dev, "wait for video done timed out\n");
 
 	dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_VIDEO_DONE, 0);
-- 
2.1.4

