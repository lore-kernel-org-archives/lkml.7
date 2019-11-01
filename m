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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA88CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD73217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctnx2Mq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKASLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:11:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKASLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:11:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id e4so6975753pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6pp+waK1B6eoQZsfgu20T9S0S5gE50J59ZyY893XeU=;
        b=ctnx2Mq7v0ZwoxZpgw8YqdbWutmx0MLZKmxmioikkvICWrTw1w/6AKRvR8X0KBJo1Q
         H0q5nPYMGRreXVKlEPeoh4VtEN1K97KsqpD13ts5v4lWQFJg4H2P5+JzG7oAlzLrVo1p
         oI5Os+HHsLwy+OUClFC8ZVGFwLA6KHN6/4DoMryIAOT7NsStmpHqwZFUtokc9oZL/kT+
         cGvXVaiQTIs40ctu7V2vStfRIJlOGEpU2g9cmAKmuhy+UxHp9xJWz1vqEaJ+QNmFvjN+
         y8MDer/CsYviNag0SnshQ6oPqAx3IpnuaI3HL54iKUW3BxQAZRGqCosbW1KAi6YtEudk
         jw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6pp+waK1B6eoQZsfgu20T9S0S5gE50J59ZyY893XeU=;
        b=pK0vGwt+s512Z6aTBFuE6rDJ5mYzl7Jn5wf4J5nrHm8ETDzyUM8HGX0CS5ql+VqfA+
         96usvDdOL+AKbVnFbr0MnLH72HaZEcoCJslPmicIFcwm6bCZwzBkYqOwPdaae6SUKlzz
         ZHMF4k1fj54ZoOJZeRDF5Hy981FDSvX75pL1U0gInmr1XtsgtIuqU2QnI1P0c7/Bjz5t
         rqqHa6YzBWKbMXfsCfq2lPwJiq/Vw2FWMZ8YA2SbAAZpjV7b0LQXdqOVhwI+D0yIV7rM
         /irevEG8tzwPgEQJ94YKj6tB03P0ovJI6lG8qqeZq0YqrbJqe6fyEL0POsWpbkLlC0xg
         ylIg==
X-Gm-Message-State: APjAAAUZXSpl4KvxSCYMehHNlTIYiFI+LA55UFOOVXNkvLaiFx3dn+V6
        O+33MJR3Y/dBgxHTQrRLLQo=
X-Google-Smtp-Source: APXvYqyntvvTNEB7b5YRQX6acrnW6EDOe32CdQyaoFyh8/yeQSOf08HCyibGS7j+0s+Mu2D+PSSeIg==
X-Received: by 2002:a17:90a:8816:: with SMTP id s22mr12344442pjn.31.1572631902246;
        Fri, 01 Nov 2019 11:11:42 -0700 (PDT)
Received: from localhost ([100.118.89.209])
        by smtp.gmail.com with ESMTPSA id h5sm11525487pjc.9.2019.11.01.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 11:11:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
Date:   Fri,  1 Nov 2019 11:07:13 -0700
Message-Id: <20191101180713.5470-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101180713.5470-1-robdclark@gmail.com>
References: <20191101180713.5470-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The new state should not be accessed after this point.  Clear the
pointers to make that explicit.

This makes the error corrected in the previous patch more obvious.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 732bd0ce9241..176831df8163 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
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
 		old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
+		old_state->crtcs[i].new_state = NULL;
 
 		commit = new_crtc_state->commit;
 		if (!commit)
-- 
2.21.0

