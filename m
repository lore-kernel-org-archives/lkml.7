Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F1C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D0F20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439556AbfIWMqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:46:06 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:33788 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfIWMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:46:05 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 3B792B76;
        Mon, 23 Sep 2019 20:43:44 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3051T140289744058112S1569242621440080_;
        Mon, 23 Sep 2019 20:43:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1d669510ee6b1eb3d84b0708437add94>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 07/36] drm/gma500: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:41:11 +0800
Message-Id: <1569242500-182337-8-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
References: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/gma500/framebuffer.c         | 4 ++--
 drivers/gpu/drm/gma500/gma_display.c         | 4 ++--
 drivers/gpu/drm/gma500/mdfld_intel_display.c | 6 +++---
 drivers/gpu/drm/gma500/oaktrail_crtc.c       | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 218f3bb..97e9274 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -61,7 +61,7 @@ static int psbfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	    (transp << info->var.transp.offset);
 
 	if (regno < 16) {
-		switch (fb->format->cpp[0] * 8) {
+		switch (fb->format->bpp[0]) {
 		case 16:
 			((uint32_t *) info->pseudo_palette)[regno] = v;
 			break;
@@ -221,7 +221,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
 	 * 4 bytes per pixel.
 	 */
 	info = drm_get_format_info(dev, mode_cmd);
-	if (!info || !info->depth || info->cpp[0] > 4)
+	if (!info || !info->depth || info->bpp[0] > 32)
 		return -EINVAL;
 
 	if (mode_cmd->pitches[0] & 63)
diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
index e20ccb5..95e975e 100644
--- a/drivers/gpu/drm/gma500/gma_display.c
+++ b/drivers/gpu/drm/gma500/gma_display.c
@@ -78,14 +78,14 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
 	if (ret < 0)
 		goto gma_pipe_set_base_exit;
 	start = gtt->offset;
-	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
+	offset = y * fb->pitches[0] + x * fb->format->bpp[0] / 8;
 
 	REG_WRITE(map->stride, fb->pitches[0]);
 
 	dspcntr = REG_READ(map->cntr);
 	dspcntr &= ~DISPPLANE_PIXFORMAT_MASK;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		dspcntr |= DISPPLANE_8BPP;
 		break;
diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
index b8bfb96..5564472 100644
--- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
+++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
@@ -139,7 +139,7 @@ static int check_fb(struct drm_framebuffer *fb)
 	if (!fb)
 		return 0;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 	case 16:
 	case 24:
@@ -187,13 +187,13 @@ static int mdfld__intel_pipe_set_base(struct drm_crtc *crtc, int x, int y,
 		return 0;
 
 	start = to_gtt_range(fb->obj[0])->offset;
-	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
+	offset = y * fb->pitches[0] + x * fb->format->bpp[0] / 8;
 
 	REG_WRITE(map->stride, fb->pitches[0]);
 	dspcntr = REG_READ(map->cntr);
 	dspcntr &= ~DISPPLANE_PIXFORMAT_MASK;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		dspcntr |= DISPPLANE_8BPP;
 		break;
diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 167c107..8278dfb 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -607,14 +607,14 @@ static int oaktrail_pipe_set_base(struct drm_crtc *crtc,
 		return 0;
 
 	start = to_gtt_range(fb->obj[0])->offset;
-	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
+	offset = y * fb->pitches[0] + x * fb->format->bpp[0] / 8;
 
 	REG_WRITE(map->stride, fb->pitches[0]);
 
 	dspcntr = REG_READ(map->cntr);
 	dspcntr &= ~DISPPLANE_PIXFORMAT_MASK;
 
-	switch (fb->format->cpp[0] * 8) {
+	switch (fb->format->bpp[0]) {
 	case 8:
 		dspcntr |= DISPPLANE_8BPP;
 		break;
-- 
2.7.4



