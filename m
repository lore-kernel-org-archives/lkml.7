Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F67F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knht/IRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfG3Ikj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:40:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43802 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbfG3Ikj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:40:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id r22so2082691pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89mycYetQz5Yslqgw4Pph6ixeB6FTUjlPdQo+OF5joc=;
        b=Knht/IRU4k7wq/cQ51U9Kxl0GUJxlqbKKLjv2bcHydJTmkTGI1lgEFLzf2ku2tIMRe
         1WKKDR4H6ZH0aTu5xzGX+lYUbF9om75GP75DYAj+ry99lrHXFWJWxr6MZrp9ppXQZL0h
         uOiU81fhEolXjHRrU9XkX6YogMjGoMX2b/Gk84URoDW0XFWkHNGvyCoxQoGKNOpsdbKY
         KfSpp8Q9LSBnJf4MS3Btn/LO+55IxBE/KCEBIbGPHQcVH3SKzA8yAbMNTJF5ZcL3q7vv
         aykgAf2pBeGUIqa10lPl5i6UmtWtNfUjUFCbBGf+ryV9kturtIUcqPnjXxz8O+dPE/lh
         njXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89mycYetQz5Yslqgw4Pph6ixeB6FTUjlPdQo+OF5joc=;
        b=CZgwIQnZkDK3rk8u10+Ne01rh5y1KMNTk9R2gaB4ou74joAXSJiXur+EN4AQUVerKs
         hH1huFcCYZVOMxJTG75blwSB5TJA1Op9oxXAzpxCmE8JCcuuu0eviB8hetIWJYIzwcgO
         0mh5UZCFQD28pAw6unywovT7iQ5AFBGxh9GFevUKDnu5nvlnVNIGcvzodW28bUpOF9g3
         vavdFmatEQctQQKYSHigBGzkzR7KMBVvYs2kcjTWsbBAfkW75GcHIZL96daJetsDYWzo
         Ian16AHNDot2K+x0WrXRP3/Xuc/a1IdRsWrVlicqC/S2lPBtS8zbK9VOVrCRDUqPilXG
         zRlg==
X-Gm-Message-State: APjAAAXPyBALYByaUEDGHoy/QzVoweXspuT9p02M6gWrEC6ZMKxuAX7T
        Gc/X/zUCEjGsyl+MRspS4Dg=
X-Google-Smtp-Source: APXvYqwCGMJk7lZF/xsXFdQ865XRIEZNHtSYQFSJRY9fc8zCbMdRagl6dMRC+1/yHF/RMoyVyiY/tQ==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr113839937pjp.105.1564476038528;
        Tue, 30 Jul 2019 01:40:38 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f14sm64869091pfn.53.2019.07.30.01.40.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:40:37 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/modes: Fix unterminated strncpy
Date:   Tue, 30 Jul 2019 16:40:32 +0800
Message-Id: <20190730084032.26428-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy(dest, src, strlen(src)) leads to unterminated
dest, which is dangerous.
Fix it by using strscpy.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/drm_modes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 80fcd5dc1558..170fc24e0f31 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1770,7 +1770,7 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 	}
 
 	if (named_mode) {
-		strncpy(mode->name, name, mode_end);
+		strscpy(mode->name, name, mode_end + 1);
 	} else {
 		ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
 						      parse_extras,
-- 
2.20.1

