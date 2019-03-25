Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E9B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfCYR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:57:17 -0400
Received: from [217.140.106.55] ([217.140.106.55]:44607 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729728AbfCYR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:57:17 -0400
X-Greylist: delayed 3356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 13:57:16 EDT
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.87])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id x2PH1EEQ009920;
        Mon, 25 Mar 2019 17:01:14 GMT
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] arm/komeda: Compile komeda_debugfs_init() only if CONFIG_DEBUG_FS is enabled
Date:   Mon, 25 Mar 2019 17:01:14 +0000
Message-Id: <20190325170114.20407-1-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't call this function if CONFIG_DEBUG_FS is not defined, but we
should not be compiling it either, as the declaration of the debugfs
core functions is not included.

Reported by the kbuild test robot.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index b420c6205d6bf..24548b87e1827 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -44,6 +44,7 @@ static const struct file_operations komeda_register_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_DEBUG_FS
 static void komeda_debugfs_init(struct komeda_dev *mdev)
 {
 	if (!debugfs_initialized())
@@ -56,6 +57,7 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 	debugfs_create_file("register", 0444, mdev->debugfs_root,
 			    mdev, &komeda_register_fops);
 }
+#endif
 
 static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_node *np)
 {
-- 
2.21.0

