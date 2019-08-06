Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C773C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3670D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfHFMqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:46:30 -0400
Received: from foss.arm.com ([217.140.110.172]:32826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfHFMqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:46:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B942028;
        Tue,  6 Aug 2019 05:46:29 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.cambridge.arm.com (unknown [10.1.25.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90B9B3F694;
        Tue,  6 Aug 2019 05:46:28 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, nd@arm.com
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, ayan.halder@arm.com,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3] drm/crc-debugfs: Add notes about CRC<->commit interactions
Date:   Tue,  6 Aug 2019 13:46:22 +0100
Message-Id: <20190806124622.28399-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRC generation can be impacted by commits coming from userspace, and
enabling CRC generation may itself trigger a commit. Add notes about
this to the kerneldoc.

Changes since v1:
 - Clarified that anything that would disable CRCs counts as a full
   modeset, and so userspace needs to reconfigure after full modesets

Changes since v2:
 - Add these notes
 - Rebase onto drm-misc-next (trivial conflict in comment)

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 9 +++++++++
 include/drm/drm_crtc.h            | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 6604ed223160..be1b7ba92ffe 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -69,6 +69,15 @@
  * implement &drm_crtc_funcs.set_crc_source and &drm_crtc_funcs.verify_crc_source.
  * The debugfs files are automatically set up if those vfuncs are set. CRC samples
  * need to be captured in the driver by calling drm_crtc_add_crc_entry().
+ * Depending on the driver and HW requirements, &drm_crtc_funcs.set_crc_source
+ * may result in a commit (even a full modeset).
+ *
+ * CRC results must be reliable across non-full-modeset atomic commits, so if a
+ * commit via DRM_IOCTL_MODE_ATOMIC would disable or otherwise interfere with
+ * CRC generation, then the driver must mark that commit as a full modeset
+ * (drm_atomic_crtc_needs_modeset() should return true). As a result, to ensure
+ * consistent results, generic userspace must re-setup CRC generation after a
+ * legacy SETCRTC or an atomic commit with DRM_MODE_ATOMIC_ALLOW_MODESET.
  */
 
 static int crc_control_show(struct seq_file *m, void *data)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 128d8b210621..7d14c11bdc0a 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -756,6 +756,9 @@ struct drm_crtc_funcs {
 	 * provided from the configured source. Drivers must accept an "auto"
 	 * source name that will select a default source for this CRTC.
 	 *
+	 * This may trigger an atomic modeset commit if necessary, to enable CRC
+	 * generation.
+	 *
 	 * Note that "auto" can depend upon the current modeset configuration,
 	 * e.g. it could pick an encoder or output specific CRC sampling point.
 	 *
@@ -767,6 +770,7 @@ struct drm_crtc_funcs {
 	 * 0 on success or a negative error code on failure.
 	 */
 	int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
+
 	/**
 	 * @verify_crc_source:
 	 *
-- 
2.17.1

