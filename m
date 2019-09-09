Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C169C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA62E2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CgvOpLx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404953AbfIINwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:52:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfIINwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:52:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89Dk8fX017391;
        Mon, 9 Sep 2019 15:52:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=rYVIo3r17iq7Z7YeJ7NgdCnnOH3SsaQSMquqlvDN8rM=;
 b=CgvOpLx+O53leDPXfE+v4RhXH8+N++ERxeMizdfUrB91Qs1tU68oiEvx/97ygAIimZGX
 g2j9a9QsbLZBWr4m/c59gNBuPum9+f40P+60tN/Qnc3fk1u3MbbFObs81xN+GQdzHFbE
 o5+hlqPEBtgIIb1kB3NQG4RCNFHc7XPuKh41UfOUUfoi/i6rkKZ0qqy2/rX17Gt2Wmon
 P9Pf49mBVp85GSvObwWOJ+LLVwQOcyH5vcz1p6dIMM7IoRaGYtg/AgOYA8UUrOP77POT
 597y6Ei8c9YGXEHN0E2+/WngfMwY9FvN0vv/Gs/9TKsIuVyU33qpYlIFOJynZnPwjRIS 9Q== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uv1pa6b6j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Sep 2019 15:52:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE48C4D;
        Mon,  9 Sep 2019 13:52:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B2A62AE79C;
        Mon,  9 Sep 2019 15:52:11 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019
 15:52:11 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Sep 2019 15:52:10
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <benjamin.gaignard@linaro.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: atomic helper: fix W=1 warnings
Date:   Mon, 9 Sep 2019 15:52:05 +0200
Message-ID: <20190909135205.10277-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190909135205.10277-1-benjamin.gaignard@st.com>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_06:2019-09-09,2019-09-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings with W=1.
Few for_each macro set variables that are never used later.
Prevent warning by marking these variables as __maybe_unused.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index aa16ea17ff9b..b69d17b0b9bd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -262,7 +262,7 @@ steal_encoder(struct drm_atomic_state *state,
 	      struct drm_encoder *encoder)
 {
 	struct drm_crtc_state *crtc_state;
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	int i;
 
@@ -412,7 +412,7 @@ mode_fixup(struct drm_atomic_state *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *new_conn_state;
 	int i;
 	int ret;
@@ -608,7 +608,7 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	int i, ret;
 	unsigned connectors_mask = 0;
@@ -984,7 +984,7 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
 static void
 disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 {
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *old_conn_state, *new_conn_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
@@ -1173,7 +1173,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *old_state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *new_conn_state;
 	int i;
 
@@ -1294,7 +1294,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc_state *new_crtc_state;
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *new_conn_state;
 	int i;
 
@@ -1384,7 +1384,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 				      struct drm_atomic_state *state,
 				      bool pre_swap)
 {
-	struct drm_plane *plane;
+	struct drm_plane __maybe_unused *plane;
 	struct drm_plane_state *new_plane_state;
 	int i, ret;
 
@@ -1431,7 +1431,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 		struct drm_atomic_state *old_state)
 {
 	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc_state __maybe_unused *old_crtc_state, *new_crtc_state;
 	int i, ret;
 	unsigned crtc_mask = 0;
 
@@ -1621,7 +1621,7 @@ static void commit_work(struct work_struct *work)
 int drm_atomic_helper_async_check(struct drm_device *dev,
 				   struct drm_atomic_state *state)
 {
-	struct drm_crtc *crtc;
+	struct drm_crtc __maybe_unused *crtc;
 	struct drm_crtc_state *crtc_state;
 	struct drm_plane *plane = NULL;
 	struct drm_plane_state *old_plane_state = NULL;
@@ -1982,9 +1982,9 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct drm_connector *conn;
+	struct drm_connector __maybe_unused *conn;
 	struct drm_connector_state *old_conn_state, *new_conn_state;
-	struct drm_plane *plane;
+	struct drm_plane __maybe_unused *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct drm_crtc_commit *commit;
 	int i, ret;
@@ -2214,7 +2214,7 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
  */
 void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
 {
-	struct drm_crtc *crtc;
+	struct drm_crtc __maybe_unused *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct drm_crtc_commit *commit;
 	int i;
@@ -2300,7 +2300,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_state *state)
 {
-	struct drm_connector *connector;
+	struct drm_connector __maybe_unused *connector;
 	struct drm_connector_state *new_conn_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
@@ -2953,9 +2953,9 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
 {
 	struct drm_atomic_state *state;
 	struct drm_connector_state *conn_state;
-	struct drm_connector *conn;
+	struct drm_connector __maybe_unused *conn;
 	struct drm_plane_state *plane_state;
-	struct drm_plane *plane;
+	struct drm_plane __maybe_unused *plane;
 	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
 	int ret, i;
@@ -3199,11 +3199,11 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 {
 	int i, ret;
 	struct drm_plane *plane;
-	struct drm_plane_state *new_plane_state;
+	struct drm_plane_state __maybe_unused *new_plane_state;
 	struct drm_connector *connector;
-	struct drm_connector_state *new_conn_state;
+	struct drm_connector_state __maybe_unused *new_conn_state;
 	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
+	struct drm_crtc_state __maybe_unused *new_crtc_state;
 
 	state->acquire_ctx = ctx;
 
-- 
2.15.0

