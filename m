Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31FAC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CDB24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NuMpicKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFXO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:14:59 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:35861 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfLFXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:14:57 -0500
Received: by mail-il1-f181.google.com with SMTP id b15so7721917iln.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb5X/YG7EhxVVMb4rPYE5JMk9umoZgG5Z8q8yvwSs2M=;
        b=NuMpicKsb6T6BeUCy+TlL4PJnkcDqAUqaRI0E66NpQifyU90z1WQQyECfu2NVtv0jA
         0bdI49nIuuwI4aiB/lszsIyNXya/559wjjVjvlvZZTdoQI097EexNyicnvZFeMHeIkho
         MUjJv2HRu6cwQ32HoRuTJf/Fo6/aKrxETWbAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb5X/YG7EhxVVMb4rPYE5JMk9umoZgG5Z8q8yvwSs2M=;
        b=Cbqgxz0/ngF7pPMCLvCBfdM659MW2QdytGaIECdbZhJ75Z3jOXzZrAxW0twRDjjJdn
         FV1hudjIZmTEY5bVORA1yZEy38R8aZY5lIU3sHcObBPmQT3EuUQeTqNxz7WfvnAZXLYH
         H6HD6vl888Hs67YoYN97LFSdQPS6NfFauDpvGPos80ixtSiu/mNGIZSCC9Va5CuKHdzT
         WmtHYDaP1372dQu0ZIBJB0htRwjm6hG9yH0nN/OdbK2Kortj7rtePkHBhh8ZeM39QXr+
         YDJb3RTHUg6Z6sd4o9GyQXjaojicvE1GnDJG7mHip/kVVgRlAmzlfs7UC+i1bW3Ol49Y
         ykzQ==
X-Gm-Message-State: APjAAAUQzAhNAASV0aqrOruwgrypP7LooSd1YAYLh7W1Vj8gtQohE4K0
        hwyigN0Xe58ALfAi74vQhDa6Lg==
X-Google-Smtp-Source: APXvYqyszDdpM/3ud4bfV15wu6oE2QbjCevykqalAbVlwCBIN4naArSw84K73+sk7klQIdxWF+06mQ==
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr15201727ill.68.1575674097195;
        Fri, 06 Dec 2019 15:14:57 -0800 (PST)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:0:92f:a80a:519d:f777])
        by smtp.gmail.com with ESMTPSA id b15sm4317946ilo.37.2019.12.06.15.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Dec 2019 15:14:56 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        Sean Paul <sean@poorly.run>, Bruce Wang <bzwang@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/6] drm/msm/dpu: Remove unnecessary NULL checks
Date:   Fri,  6 Dec 2019 16:13:45 -0700
Message-Id: <20191206161137.3.I55d53dbb7c64256e4231a6b99c6e6d1c336f624b@changeid>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
References: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpu_crtc_mixer.hw_lm will never be NULL, so don't check.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index b9ed8285ab39..bf513411b243 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -197,10 +197,6 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	DPU_DEBUG("%s\n", dpu_crtc->name);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
-		if (!mixer[i].hw_lm) {
-			DPU_ERROR("invalid lm assigned to mixer\n");
-			return;
-		}
 		mixer[i].mixer_op_mode = 0;
 		mixer[i].flush_mask = 0;
 		if (mixer[i].lm_ctl->ops.clear_all_blendstages)
@@ -1113,12 +1109,9 @@ static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
 
 	for (i = 0; i < cstate->num_mixers; ++i) {
 		m = &cstate->mixers[i];
-		if (!m->hw_lm)
-			seq_printf(s, "\tmixer[%d] has no lm\n", i);
-		else
-			seq_printf(s, "\tmixer:%d ctl:%d width:%d height:%d\n",
-				m->hw_lm->idx - LM_0, m->lm_ctl->idx - CTL_0,
-				out_width, mode->vdisplay);
+		seq_printf(s, "\tmixer:%d ctl:%d width:%d height:%d\n",
+			m->hw_lm->idx - LM_0, m->lm_ctl->idx - CTL_0,
+			out_width, mode->vdisplay);
 	}
 
 	seq_puts(s, "\n");
-- 
2.21.0

