Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668782464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nsIITroc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLFXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:14:58 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:38425 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfLFXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:14:57 -0500
Received: by mail-il1-f170.google.com with SMTP id u17so7715093ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OgzAFB+zH8GlVojyTVFAow6dMpgwdrzIFhrdEHUtvhg=;
        b=nsIITrocRHSetuaCgKu6s2C8xayl6Q5U5QuN0tQkjiMBXf/22zQ0Oy//9Xu9MWCty2
         yc8AMl720Dpjg2XaZaV2/kpE/sVz+RkudZ9qSIjdYAehIgapE3ky5KufYM8aE+sHzuW1
         uNagLcHcb+6YLBLMsg9FuwWL3Bvs3/dlCS+yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OgzAFB+zH8GlVojyTVFAow6dMpgwdrzIFhrdEHUtvhg=;
        b=qmWkPKwhechWbt55XKvGwEaHwgxInUAQLfEw5559pL5Cb31OMWAVrk+BpgHUzIstx+
         UYWpAGS1RyETxywyJEZQB0j03wP4v89U9LJKYUlYP7TiECF3MX+PFyT2fjX2K4G1qaZC
         dkcqZkp8JVyvj1DfsuouMoshX1lIezlM1Tk2OSOkYCygnRBRRJT09v//RQqIyW2pyYiG
         7wv1d8vMPbr0TNh+kDD9+04rmmx8YUQAxHtLIE8+sSK6gCURMXbJ3+5u3PxEVC5dU9+d
         kEedjkuRjjUsebmN1IQ12T33Z2Ed+hyf8Bd6uTz3dZJ6x+ih7jj9tZIFyMNmCa06awIJ
         6zZA==
X-Gm-Message-State: APjAAAWmnY09tJU98/EmR+x88aAtv1g/DeS/F7QlUkycsRvRmpqx3Y+B
        baUSjDUyOsdxXRivFSELRIH5R3CrwvU=
X-Google-Smtp-Source: APXvYqwsQs11WhvacrvMTbUHKumnGg/DXD8ql0+dQvEU8SGQm6P6c+S8z35CBbHMIFitiO9F7uITRQ==
X-Received: by 2002:a92:cf52:: with SMTP id c18mr16802212ilr.44.1575674096396;
        Fri, 06 Dec 2019 15:14:56 -0800 (PST)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:0:92f:a80a:519d:f777])
        by smtp.gmail.com with ESMTPSA id b15sm4317946ilo.37.2019.12.06.15.14.55
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
Subject: [PATCH 2/6] drm/msm/dpu: Remove unnecessary NULL checks
Date:   Fri,  6 Dec 2019 16:13:44 -0700
Message-Id: <20191206161137.2.I3e20091f213b47dfa888bc2f528509d84d19c743@changeid>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
References: <20191206161137.1.Ibb7612c1ebcebe3f560b3269150c0e0363f01e44@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpu_crtc_mixer.lm_ctl will never be NULL, so don't bother checking

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index f197dce54576..b9ed8285ab39 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -197,8 +197,8 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	DPU_DEBUG("%s\n", dpu_crtc->name);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
-		if (!mixer[i].hw_lm || !mixer[i].lm_ctl) {
-			DPU_ERROR("invalid lm or ctl assigned to mixer\n");
+		if (!mixer[i].hw_lm) {
+			DPU_ERROR("invalid lm assigned to mixer\n");
 			return;
 		}
 		mixer[i].mixer_op_mode = 0;
@@ -1115,8 +1115,6 @@ static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
 		m = &cstate->mixers[i];
 		if (!m->hw_lm)
 			seq_printf(s, "\tmixer[%d] has no lm\n", i);
-		else if (!m->lm_ctl)
-			seq_printf(s, "\tmixer[%d] has no ctl\n", i);
 		else
 			seq_printf(s, "\tmixer:%d ctl:%d width:%d height:%d\n",
 				m->hw_lm->idx - LM_0, m->lm_ctl->idx - CTL_0,
-- 
2.21.0

