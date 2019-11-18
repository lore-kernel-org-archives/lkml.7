Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39297C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097DB206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tub8CI3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfKRCsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:48:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44872 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfKRCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:48:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so9591399pfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kl5ahZw2sQnevip0m9byS4aFaaYYEpVFO0JkWfU568=;
        b=tub8CI3C2kZF7VVfdEZdXWUm8Dt6YYRt0JM2LJ9MVDoSYCQ7LSblnmcfTyOsaR+qGW
         h8JhSZ1pG97f9SiDEf/aiJXeni+wSrKf4hl371gAT1eEdthYNLPeJ98HkQjsFIp1FUU4
         RcjXEPXWFyZg0LvuhJV5AcB8xVfB8qv0jj9xR8A8Jtk6F79yHorUhwlWKHSB3sFErJLq
         r7MP4nPkmgTKQgzksGYYBeUZVnCiqS0IHcqdSAVGlZ1s/QATv6gdp3+lkE/cV7YlvIyM
         aVoF91H0071Idd+txdFXk/z/n245IoNWUSHFHoSylBTKDZKBXLNEFBu76uTntAUv47la
         B35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kl5ahZw2sQnevip0m9byS4aFaaYYEpVFO0JkWfU568=;
        b=JcVywas9D3Eqin6Mw897BItFv5gxB2EDxgXGNO4IAOloRCdDy3wrAdEl75AUqtzZWG
         Bx+I6pED9bCftRJYIpfMXyJzscSAGnhuaXGfrKBbKncukJnCblKuVLKlBU5S9Y1haOX9
         FBjGyekZuVH9Gcht5g9dpl2u7x/Ecn105OWJTFRnoeI3Wa4GcYzAhvvpRsMcmVZy43em
         uoRBeLxp5wBLA4/a9Dk1/EkcMz37czf9/oy5MdgQPs/pEVThlvAmv7Mzun9Oceat1Ck1
         0HLmhpfbNE6VqN06/fJMmU7R33vJ/iurmL8YTqhKgftV7zrqcc5B6081GYaRh/zjaQzt
         MpeQ==
X-Gm-Message-State: APjAAAVJ2GxiqQ1diZ2+gdhrcyf5cOeZOQ1eA3IE5/8XYxzuwaWB9ias
        QJmaN5H8TBWddyw13cahTfc=
X-Google-Smtp-Source: APXvYqzOYITC4AQD4cll3vg5byNRwh0UT/CFOt1LAEbVB3s0Yr8Kp1aA98musXirXMhUJX8saTflKQ==
X-Received: by 2002:a62:7643:: with SMTP id r64mr30020700pfc.191.1574045284995;
        Sun, 17 Nov 2019 18:48:04 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id r16sm15576124pgl.77.2019.11.17.18.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 18:48:04 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/v3d: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 10:47:55 +0800
Message-Id: <20191118024755.21456-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 3506ae2723ae..e109bb8cd67d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -333,6 +333,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 dev_destroy:
 	drm_dev_put(drm);
 dma_free:
+	pm_runtime_disable(dev);
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
 dev_free:
 	kfree(v3d);
@@ -350,6 +351,8 @@ static int v3d_platform_drm_remove(struct platform_device *pdev)
 
 	drm_dev_put(drm);
 
+	pm_runtime_disable(v3d->dev);
+
 	dma_free_wc(v3d->dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
 
 	return 0;
-- 
2.24.0

