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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE5DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F6F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOLeErTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfKDRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:42:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfKDRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:42:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so7891852plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhTEQnP8RxA0q/YUDgp2LWFOIs06F90qLkFMbfArLJ4=;
        b=NOLeErTWRsJ7mN747WHY9/xb1Kg1Hmm4WyT9ASnpWW0NeBwlmbQZ3Z+5xAi5VUE9Sb
         4gM4OzKFJ/4Nb/zH2q6oy+JO+AFbAHT8SIm8kVgxoEaXVGXBEuG1GrZguZrwDAMINdBt
         kHKvu96X6R+599zqtFFa25k/ltlNyAaIkFbARSN1ZQhuDALuQoc9ITIRtP5ov1HBO4Mt
         1WspukrqvBEEd5PWvqO+ze040GR/D7uAg+xaMI1A26AMqmF4V02bqwvsz0lvMR2khAjG
         FtkE3BCZl1+/6HEqGysTfHFdTTJnpOGsYsikqtBLrsOrGg7rkCFeIUxRC2dxigKxNmT4
         fezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhTEQnP8RxA0q/YUDgp2LWFOIs06F90qLkFMbfArLJ4=;
        b=iITGub1FkJOuEnWZkXRAqKdhmJBOp4yKM9e4C0oTHMmKhfNXe+sC6ULxguTDGmTjqO
         znxmS2pLpfLniPrdz85JBpKRBO1SelIO4CplLrm+KkkFuGSAnd+RpDaqgHdXPQpwNnMW
         egw+fXA+UU7Xg5rAbpFnxRn7228syHJANWL84RXgEMj8uGCU6oGxoSEsn/XdxpkZwo3J
         iWYr4DLkL7pqNn0iXMUK3BjQXX0CJ92qhw1CkmXbJBi6luwmDhjbFV3zF81GbIE6XF4h
         vNzbhK1dSLSGqMXScHvANJ2tMCTmR5wrlLV1Oto9vVa9Sg+J75s+vNuIcqBCx/GlRXJK
         jYYA==
X-Gm-Message-State: APjAAAUNM0E3PJyaHCQDpZGLONXDJ6OG7NQmZ/xPYAMnT8V0j2BDH3k4
        kKNEDL3zvJ6ifwrlwQnSDik=
X-Google-Smtp-Source: APXvYqxj7NUxsNzZ5uvdnA8/Jr0AxmR8ai/BmIlz7poN4i1CbMzixfFCPpxTjgrC3DYB9I08CU03WA==
X-Received: by 2002:a17:902:27:: with SMTP id 36mr28813529pla.28.1572889321382;
        Mon, 04 Nov 2019 09:42:01 -0800 (PST)
Received: from localhost ([100.118.89.215])
        by smtp.gmail.com with ESMTPSA id b17sm18758746pfr.17.2019.11.04.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:42:00 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2 v2] drm/atomic: clear new_state pointers at hw_done
Date:   Mon,  4 Nov 2019 09:37:37 -0800
Message-Id: <20191104173737.142558-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104173737.142558-1-robdclark@gmail.com>
References: <20191104173737.142558-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The new state should not be accessed after this point.  Clear the
pointers to make that explicit.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 648494c813e5..aec9759d9df2 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2246,12 +2246,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
  */
 void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
 {
+	struct drm_connector *connector;
+	struct drm_connector_state *old_conn_state, *new_conn_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct drm_crtc_commit *commit;
+	struct drm_private_obj *obj;
+	struct drm_private_state *old_obj_state, *new_obj_state;
 	int i;
 
+	/*
+	 * After this point, drivers should not access the permanent modeset
+	 * state, so we also clear the new_state pointers to make this
+	 * restriction explicit.
+	 *
+	 * For the CRTC state, we do this in the same loop where we signal
+	 * hw_done, since we still need to new_crtc_state to fish out the
+	 * commit.
+	 */
+
+	for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
+		old_state->connectors[i].new_state = NULL;
+	}
+
+	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
+		old_state->planes[i].new_state = NULL;
+	}
+
+	for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
+		old_state->private_objs[i].new_state = NULL;
+	}
+
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+		old_state->crtcs[i].new_state = NULL;
+
 		commit = new_crtc_state->commit;
 		if (!commit)
 			continue;
-- 
2.23.0

