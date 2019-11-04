Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772ABCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D7920869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soRjtNEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfKDRjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:39:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44552 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfKDRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:39:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so12717288pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqUgfD6J26IDGcrOaE5JALNx00ywjTuLlRjpqn3J8b8=;
        b=soRjtNEeL4D7NTU6MKSNZmvW/YQMSUw4MivNuB+vacYLS9phcwkMDXoTsEql77XHMK
         ku3/NC4+8vQatzqIQidHSwCdiPcYqozapjH2k6snddsCLVAM4EhHqRYgV4cDlm9664Ap
         Mvby3qtJWHW9IsLS2LYYzqtNeegALeNPAfQNnrjsgmioA7CFQbkykCwD47aHseaRbGZU
         0PkS7bjg7l/Y21Ia3E3pGc8zzNyKcBP0AnV3uB0lNXC5TIto5n2SmdgKubVXEShe/Hes
         wJ/5Cpv0Bkrpq7Bnm/WcGgz4W5MKZOk7vl3Fo8cLtOtPh/xO1HSYX9xIQHikkfAGl3go
         1Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqUgfD6J26IDGcrOaE5JALNx00ywjTuLlRjpqn3J8b8=;
        b=XPT8tW0LXsYwOihYj2lMPHi8eR0v+oQjTfdrmF+jA4oQ0SuwZ+y0imwFSYDdV24ZfL
         hDGBd5bK8tAQwzUJfqPTehE6+lmJA1Gy0r0YkC8XevTKF8hxcHoywfxLxZK7uciMAeqA
         6PBALKwaCedXbMfH4vGoK4uz+DW8ybnIS3bSVqFDgVHE4IwY/bbjuMfto7ewgMCXxYrG
         bKDVcVAQxkGsppaDgfmfoWLEPbqoYTkr510hB4y5yF15PJxeqMnZQH6CinCCLaK0eAY+
         IvN3BBNmOx9bHOyKE4R+zZjfeBTRWafndYs3mb6U4iK2kW/u1VTfgy7laq9q4B7yt7/8
         gI4g==
X-Gm-Message-State: APjAAAVeZvKkVziqWYY/iKy45lYRNRJQz8ZfMTgDxDAxd2N2UUiUeMxW
        C7x9JTkUT3BLj+XAhNcrtl0=
X-Google-Smtp-Source: APXvYqy6AGU4waE66mHIwcbc+qrL64JP3OkuPlxqz88KmxLF1+NAbjyWx1AraIIAjcF+WIJ3QQNayA==
X-Received: by 2002:a63:151:: with SMTP id 78mr28973075pgb.95.1572889190458;
        Mon, 04 Nov 2019 09:39:50 -0800 (PST)
Received: from localhost ([100.118.89.215])
        by smtp.gmail.com with ESMTPSA id y24sm20894808pfr.116.2019.11.04.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:39:49 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2 v2] drm/atomic: fix self-refresh helpers crtc state dereference
Date:   Mon,  4 Nov 2019 09:37:36 -0800
Message-Id: <20191104173737.142558-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

drm_self_refresh_helper_update_avg_times() was incorrectly accessing the
new incoming state after drm_atomic_helper_commit_hw_done().  But this
state might have already been superceeded by an !nonblock atomic update
resulting in dereferencing an already free'd crtc_state.

TODO I *think* this will more or less do the right thing.. althought I'm
not 100% sure if, for example, we enter psr in a nonblock commit, and
then leave psr in a !nonblock commit that overtakes the completion of
the nonblock commit.  Not sure if this sort of scenario can happen in
practice.  But not crashing is better than crashing, so I guess we
should either take this patch or rever the self-refresh helpers until
Sean can figure out a better solution.

Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c       | 14 +++++++++++++-
 drivers/gpu/drm/drm_self_refresh_helper.c | 15 +++++++++------
 include/drm/drm_self_refresh_helper.h     |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 3ef2ac52ce94..648494c813e5 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1581,8 +1581,11 @@ static void commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
 	const struct drm_mode_config_helper_funcs *funcs;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc *crtc;
 	ktime_t start;
 	s64 commit_time_ms;
+	unsigned i, new_self_refresh_mask = 0;
 
 	funcs = dev->mode_config.helper_private;
 
@@ -1602,6 +1605,14 @@ static void commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_wait_for_dependencies(old_state);
 
+	/*
+	 * We cannot safely access new_crtc_state after drm_atomic_helper_commit_hw_done()
+	 * so figure out which crtc's have self-refresh active beforehand:
+	 */
+	for_each_new_crtc_in_state(old_state, crtc, new_crtc_state, i)
+		if (new_crtc_state->self_refresh_active)
+			new_self_refresh_mask |= BIT(i);
+
 	if (funcs && funcs->atomic_commit_tail)
 		funcs->atomic_commit_tail(old_state);
 	else
@@ -1610,7 +1621,8 @@ static void commit_tail(struct drm_atomic_state *old_state)
 	commit_time_ms = ktime_ms_delta(ktime_get(), start);
 	if (commit_time_ms > 0)
 		drm_self_refresh_helper_update_avg_times(old_state,
-						 (unsigned long)commit_time_ms);
+						 (unsigned long)commit_time_ms,
+						 new_self_refresh_mask);
 
 	drm_atomic_helper_commit_cleanup_done(old_state);
 
diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
index 68f4765a5896..011b8d5f7dd6 100644
--- a/drivers/gpu/drm/drm_self_refresh_helper.c
+++ b/drivers/gpu/drm/drm_self_refresh_helper.c
@@ -133,6 +133,8 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
  * drm_self_refresh_helper_update_avg_times - Updates a crtc's SR time averages
  * @state: the state which has just been applied to hardware
  * @commit_time_ms: the amount of time in ms that this commit took to complete
+ * @new_self_refresh_mask: bitmask of crtc's that have self_refresh_active in
+ *    new state
  *
  * Called after &drm_mode_config_funcs.atomic_commit_tail, this function will
  * update the average entry/exit self refresh times on self refresh transitions.
@@ -140,22 +142,23 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
  * entering self refresh mode after activity.
  */
 void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
-					      unsigned int commit_time_ms)
+					      unsigned int commit_time_ms,
+					      unsigned int new_self_refresh_mask)
 {
 	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc_state *old_crtc_state;
 	int i;
 
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
+	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
+		bool new_self_refresh_active = new_self_refresh_mask & BIT(i);
 		struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
 		struct ewma_psr_time *time;
 
 		if (old_crtc_state->self_refresh_active ==
-		    new_crtc_state->self_refresh_active)
+		    new_self_refresh_active)
 			continue;
 
-		if (new_crtc_state->self_refresh_active)
+		if (new_self_refresh_active)
 			time = &sr_data->entry_avg_ms;
 		else
 			time = &sr_data->exit_avg_ms;
diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
index 5b79d253fb46..b2c08b328aa1 100644
--- a/include/drm/drm_self_refresh_helper.h
+++ b/include/drm/drm_self_refresh_helper.h
@@ -13,7 +13,8 @@ struct drm_crtc;
 
 void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
 void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
-					      unsigned int commit_time_ms);
+					      unsigned int commit_time_ms,
+					      unsigned int new_self_refresh_mask);
 
 int drm_self_refresh_helper_init(struct drm_crtc *crtc);
 void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
-- 
2.23.0

