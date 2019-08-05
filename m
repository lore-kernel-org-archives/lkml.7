Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60259C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEBE21738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfHEPLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:11:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfHEPLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE62337;
        Mon,  5 Aug 2019 08:11:53 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.cambridge.arm.com (ubuntu-vbox.cambridge.arm.com [10.1.36.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B793F694;
        Mon,  5 Aug 2019 08:11:52 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>, nd@arm.com,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/crc-debugfs: Add notes about CRC<->commit interactions
Date:   Mon,  5 Aug 2019 16:11:43 +0100
Message-Id: <20190805151143.12317-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802140910.GN7444@phenom.ffwll.local>
References: <20190802140910.GN7444@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRC generation can be impacted by commits coming from userspace, and
enabling CRC generation may itself trigger a commit. Add notes about
this to the kerneldoc.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---

I might have got the wrong end of the stick, but this is what I
understood from what you said.

Cheers,
-Brian

 drivers/gpu/drm/drm_debugfs_crc.c | 15 +++++++++++----
 include/drm/drm_crtc.h            |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 7ca486d750e9..1dff956bcc74 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -65,10 +65,17 @@
  * it submits. In this general case, the maximum userspace can do is to compare
  * the reported CRCs of frames that should have the same contents.
  *
- * On the driver side the implementation effort is minimal, drivers only need to
- * implement &drm_crtc_funcs.set_crc_source. The debugfs files are automatically
- * set up if that vfunc is set. CRC samples need to be captured in the driver by
- * calling drm_crtc_add_crc_entry().
+ * On the driver side the implementation effort is minimal, drivers only need
+ * to implement &drm_crtc_funcs.set_crc_source. The debugfs files are
+ * automatically set up if that vfunc is set. CRC samples need to be captured
+ * in the driver by calling drm_crtc_add_crc_entry(). Depending on the driver
+ * and HW requirements, &drm_crtc_funcs.set_crc_source may result in a commit
+ * (even a full modeset).
+ *
+ * It's also possible that a "normal" commit via DRM_IOCTL_MODE_ATOMIC or the
+ * legacy paths may interfere with CRC generation. So, in the general case,
+ * userspace can't rely on the values in crtc-N/crc/data being valid
+ * across a commit.
  */
 
 static int crc_control_show(struct seq_file *m, void *data)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 128d8b210621..0f7ea094a900 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -756,6 +756,8 @@ struct drm_crtc_funcs {
 	 * provided from the configured source. Drivers must accept an "auto"
 	 * source name that will select a default source for this CRTC.
 	 *
+	 * This may trigger a commit if necessary, to enable CRC generation.
+	 *
 	 * Note that "auto" can depend upon the current modeset configuration,
 	 * e.g. it could pick an encoder or output specific CRC sampling point.
 	 *
@@ -767,6 +769,7 @@ struct drm_crtc_funcs {
 	 * 0 on success or a negative error code on failure.
 	 */
 	int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
+
 	/**
 	 * @verify_crc_source:
 	 *
-- 
2.17.1

