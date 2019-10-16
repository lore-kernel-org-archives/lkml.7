Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BADFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E9C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLlv0MeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393109AbfJPMeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:34:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40053 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbfJPMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:34:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so23833163ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EysGKwAMgXXygyzOXkQ7pShV2hQHXICJ75+QvsLTBY=;
        b=HLlv0MeD2E9hs6is28aAs7TiTNwhmn/o8yknVMgs7CtznyDtUhmE4WqzWbmtdEhTEw
         S82uxowSCTfXLgrrpu3BKca7UbPBMptLGgKeISmGBpqeLrsHALwYdZ/mxwR4Q7m+lNe4
         fZyaGKze9yPewQcFzr4L4IFT/7E3DOlrlHFFmgYVHUVGiYJKsjaKZJMOCbqmmD+5nf3I
         Z8OfG77Ns56FlOdXRl4HNITcWI3ZVs2ME5Txl35hnP60CUmmkhXnzV3CwlGCocQBGQ2e
         hNsL5JYJJQGh10rCL3Rnc4KdZP4PRxUsQz/UDVi/Tjx/UtpAXBugovlc/WceAt14S0r3
         1v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EysGKwAMgXXygyzOXkQ7pShV2hQHXICJ75+QvsLTBY=;
        b=LnV/SAygrKgRJJnXwH71ksc/e6zTOrr6PBNpqESyIVKT+KwoFnkcM4apPyeqttp0xJ
         x6nJ8FwcsyLyzuMJcLAZXJYDhGPMsY/hiILTAZWk6gQ59elfwF3WdVTMjUKJHvucWHkR
         kNVBCVoMRtrIvB7uE0/L47CuSpNzs7VTATwO9SpOvg/0rbtl0ExEHcXMHS7r8RYF6sek
         +Lf1a9OdLRBqVp8xR7J2d6z4tmuwypBS9ywnjGUyijpGbDxPa3/QylVIPT59xiap9CQl
         5SVrII/hYcR6p5Fmrrlk8KQJx/vZ5tMvEioXSgC71lG2nqm1aggCHhd8exbEfC4bnx3J
         Rfmg==
X-Gm-Message-State: APjAAAXE1LP8HZpGWfGoFsE1sGCuD5bRN447+mnwzlLKTqwRxUCglqGG
        AFz3usDAMR8WYsxEObOQCco=
X-Google-Smtp-Source: APXvYqwHt7sCh5g0ZTnwvcbI6A3r0Iyc2Qv0wChRhGIC4CIAL/V7habUytiOLi16NvB9mQL5JEMXcg==
X-Received: by 2002:a2e:9a4c:: with SMTP id k12mr26347766ljj.213.1571229247533;
        Wed, 16 Oct 2019 05:34:07 -0700 (PDT)
Received: from workstation.lan (81-229-85-231-no13.tbcn.telia.com. [81.229.85.231])
        by smtp.gmail.com with ESMTPSA id 207sm8605119lfn.0.2019.10.16.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:34:06 -0700 (PDT)
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
Date:   Wed, 16 Oct 2019 14:33:42 +0200
Message-Id: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo where bits got compared (x < y) instead of shifted (x << y).

Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
---
 include/drm/drm_scdc_helper.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_scdc_helper.h b/include/drm/drm_scdc_helper.h
index f92eb2094d6b..6a483533aae4 100644
--- a/include/drm/drm_scdc_helper.h
+++ b/include/drm/drm_scdc_helper.h
@@ -50,9 +50,9 @@
 #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
 
 #define SCDC_STATUS_FLAGS_0 0x40
-#define  SCDC_CH2_LOCK (1 < 3)
-#define  SCDC_CH1_LOCK (1 < 2)
-#define  SCDC_CH0_LOCK (1 < 1)
+#define  SCDC_CH2_LOCK (1 << 3)
+#define  SCDC_CH1_LOCK (1 << 2)
+#define  SCDC_CH0_LOCK (1 << 1)
 #define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
 #define  SCDC_CLOCK_DETECT (1 << 0)
 
-- 
2.23.0

