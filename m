Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A6BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD79E217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEejXdvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKASJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:09:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKASJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:09:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id j22so6964180pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeTpB1Wx1lpy3awpQLYzDRRtlZuKfiLn87LhRSvje50=;
        b=MEejXdvJ/xWDM7BvqOG6PxfoSYB1nWSgMQfn97OEzsbkg/GVwzIsbSUvmV1wsqV0Qs
         WIvpo+Z97RKj57DiBqRQ9AjJKfgkiH4umbmx1ElHdLveGg2pwZdKIuDU9PLSdWrvuvw4
         uyxc+lD9UbDSxHAjICjQ3u49KgPDQQo91XCvY1kEv0uJ/6EYQKUzPEhiDG3iZ3NFM/e2
         RL5Lo8JL0VlxAi+HXAiTTYkQVfY5L4ahPLsGyHsPtgF6UZl26yTQ/9RBeQ0XcCFfnWKc
         LI+sgSsbOjbhVKVez+ayoElCg9uvUjX2lOj4Cu0gDBVl5HuxyEe9HLh+1iDpOFrfB8Q1
         PUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeTpB1Wx1lpy3awpQLYzDRRtlZuKfiLn87LhRSvje50=;
        b=YbD+ovKSPrFNa14uCx8CRotR5EoTL82x/zIcPAvYHjznM/6FV/fzHPZPpik0n4QLbF
         b6G+ok7Yspb9u1hqLYxCqcrurTyvx/JvsgwceYruFjBYO2FltoovVehYRDCcq0em5aRX
         O713z95RbWK2Ipx2YaHe0DTmxO/hCsbv7szQxAtWYGtk8xzvHCfLPGHi6fJoLwkW+Igr
         Rrt9iJUFcCd29ROTRVlD3ToKEVqsKv4fWkX5XktWD/E06l2GFT3vpd29MlaF68eKRBy1
         UjhwB5Ikz2cWznPOQlhiZ7CnP/XJ3FN1J2/OXLQ7XDHPK6MeJ0ppWLVPlMvqgdVq/dVV
         1xbA==
X-Gm-Message-State: APjAAAXu0EI79ajrZViDiv1bOqIrmr7ptEqbEvJ6OGjDinTAPWgroGcD
        3tIcWpEmB8MY1hEyWv7hIKI=
X-Google-Smtp-Source: APXvYqyGp7XRZmRiIlwGHykCJbawjeXomnH4aaKmoylErPEGGbORyqTyQ0wtAogksfMUB+aXofXNwQ==
X-Received: by 2002:a63:f919:: with SMTP id h25mr6789478pgi.85.1572631771170;
        Fri, 01 Nov 2019 11:09:31 -0700 (PDT)
Received: from localhost ([100.118.89.209])
        by smtp.gmail.com with ESMTPSA id 16sm9364172pgd.0.2019.11.01.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 11:09:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/atomic: fix self-refresh helpers crtc state dereference
Date:   Fri,  1 Nov 2019 11:07:12 -0700
Message-Id: <20191101180713.5470-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
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

Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
TODO I *think* this will more or less do the right thing.. althought I'm
not 100% sure if, for example, we enter psr in a nonblock commit, and
then leave psr in a !nonblock commit that overtakes the completion of
the nonblock commit.  Not sure if this sort of scenario can happen in
practice.  But not crashing is better than crashing, so I guess we
should either take this patch or rever the self-refresh helpers until
Sean can figure out a better solution.

 drivers/gpu/drm/drm_atomic_helper.c       |  2 ++
 drivers/gpu/drm/drm_self_refresh_helper.c | 11 ++++++-----
 include/drm/drm_atomic.h                  |  8 ++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 3ef2ac52ce94..732bd0ce9241 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2240,6 +2240,8 @@ void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
 	int i;
 
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+		old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
+
 		commit = new_crtc_state->commit;
 		if (!commit)
 			continue;
diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
index 68f4765a5896..77b9079fa578 100644
--- a/drivers/gpu/drm/drm_self_refresh_helper.c
+++ b/drivers/gpu/drm/drm_self_refresh_helper.c
@@ -143,19 +143,20 @@ void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
 					      unsigned int commit_time_ms)
 {
 	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc_state *old_crtc_state;
 	int i;
 
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
+	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
+		bool new_self_refresh_active =
+				state->crtcs[i].new_self_refresh_active;
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
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 927e1205d7aa..86baf2b38bb3 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -155,6 +155,14 @@ struct __drm_crtcs_state {
 	struct drm_crtc *ptr;
 	struct drm_crtc_state *state, *old_state, *new_state;
 
+	/**
+	 * @new_self_refresh_active:
+	 *
+	 * drm_atomic_helper_commit_hw_done() stashes new_crtc_state->self_refresh_active
+	 * so that it can be accessed late in drm_self_refresh_helper_update_avg_times().
+	 */
+	bool new_self_refresh_active;
+
 	/**
 	 * @commit:
 	 *
-- 
2.21.0

