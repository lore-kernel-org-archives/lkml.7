Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA5A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgAINbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:31:11 -0500
Received: from foss.arm.com ([217.140.110.172]:59102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgAINbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:31:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B9431B;
        Thu,  9 Jan 2020 05:31:10 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432493F534;
        Thu,  9 Jan 2020 05:31:09 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Remove core stack power management
Date:   Thu,  9 Jan 2020 13:31:04 +0000
Message-Id: <20200109133104.11661-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explict management of the GPU's core stacks is only necessary in the
case of a broken integration with the PDC. Since there are no known
platforms which have such a broken integration let's remove the explict
control from the driver since this apparently causes problems on other
platforms and will have a small performance penality.

The out of tree mali_kbase driver contains this text regarding
controlling the core stack (CONFIGMALI_CORESTACK):

  Enabling this feature on supported GPUs will let the driver powering
  on/off the GPU core stack independently without involving the Power
  Domain Controller. This should only be enabled on platforms which
  integration of the PDC to the Mali GPU is known to be problematic.
  This feature is currently only supported on t-Six and t-HEx GPUs.

  If unsure, say N.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 8822ec13a0d6..460fc190de6e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -309,10 +309,6 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
 		val, val == pfdev->features.l2_present, 100, 1000);
 
-	gpu_write(pfdev, STACK_PWRON_LO, pfdev->features.stack_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
-		val, val == pfdev->features.stack_present, 100, 1000);
-
 	gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
 	ret |= readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
 		val, val == pfdev->features.shader_present, 100, 1000);
@@ -329,7 +325,6 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 {
 	gpu_write(pfdev, TILER_PWROFF_LO, 0);
 	gpu_write(pfdev, SHADER_PWROFF_LO, 0);
-	gpu_write(pfdev, STACK_PWROFF_LO, 0);
 	gpu_write(pfdev, L2_PWROFF_LO, 0);
 }
 
-- 
2.20.1

