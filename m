Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8EAC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C221655
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H74A0OkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfGWKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:38:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389114AbfGWKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:38:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so18946474pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJJwPLAueXtxcGlCD6Tbo/0lOc3eLv/7iWCoapVa8ow=;
        b=H74A0OkK53PNTxp+3xX64AB7CmCxmHA9QmUrMj5pVW2BzDEsAI/QE3sNuR/4YdN+Bm
         sBycghr3u74CwximQ0nefQymZWIsB4MyyIN/sMlX8OnH1nKxQGGJPymLXlDyuFrMTG+S
         LDOeAPkSsMznr0JQ5eIiWZ+T8LTZOzgyn8xJ60yUGySCDHLhCYH/1j0Ln+zuvxwvVZKj
         YpEw6wstepCt+tGrVAShqHeJxBppgBGWCUnQDMHEWEn1jUypBsPuf1wX0IFA7r21732F
         fzAQcjTy8in38a56QucG6+PWrZELrxmn8jQSEmeSGjJ4hCAa69KPE8OloZqJTqu8dDgM
         7QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJJwPLAueXtxcGlCD6Tbo/0lOc3eLv/7iWCoapVa8ow=;
        b=Kk1bHEEW+HM83qSWDD5Y+dFGCj54WKnWMZC9fNSa+6BwFSmWXNV52e+U/nZroFXuPs
         S+GuoGC5ocLILfWYrsplEqkOWu+GtqF7o27FWr0BB0WRj5hjsq6820cY/i+f+TAX2wZC
         ohJZPidA7lrNlVWB+TqxwK/U3TcM+6dip4EF7JFvI1mLHIFPL4lnsnyXO2SWsCqTzXZ0
         wLeSal/08ZYSx4/lxKhLEKuwye8ATp0fO+rJJhsiBGEDcToukMTbnmnofQsMSACFB91A
         iFuPWEza46+DN8FJmRzZncBZTBMbPDK0ajYiZM9HPjG5ObyQWKt8rQJDipOUs+lu5b2Y
         0mGg==
X-Gm-Message-State: APjAAAVHyskkjwa2jKEUCi7P2j0IsAM9HvwLGT0SjJdloPlmOCHTk9J5
        DJ21tsyNY7udPxsExE4QrWs=
X-Google-Smtp-Source: APXvYqzuYXp35SrBzLoGEon+ubsLDyfehTkzqhmAJ+MDwKId9H+Ph/4X3ofmDJXq+sAICpnXj/cxVg==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr81701030pjw.79.1563878330481;
        Tue, 23 Jul 2019 03:38:50 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o11sm72345572pfh.114.2019.07.23.03.38.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:38:49 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/gma500: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 18:38:30 +0800
Message-Id: <20190723103829.3848-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/gma500/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
index bea8578846d1..d67e01ce7766 100644
--- a/drivers/gpu/drm/gma500/power.c
+++ b/drivers/gpu/drm/gma500/power.c
@@ -308,7 +308,7 @@ int psb_runtime_resume(struct device *dev)
 
 int psb_runtime_idle(struct device *dev)
 {
-	struct drm_device *drmdev = pci_get_drvdata(to_pci_dev(dev));
+	struct drm_device *drmdev = dev_get_drvdata(dev);
 	struct drm_psb_private *dev_priv = drmdev->dev_private;
 	if (dev_priv->display_count)
 		return 0;
-- 
2.20.1

