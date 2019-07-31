Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73430C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460DA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+JF52Ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfGaCBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:01:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36961 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfGaCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:01:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so29740693plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUnqDkhp8I/U34Xk2DihF2fZ0LXl/ojC5Gdgd+5fT1g=;
        b=O+JF52OwlX7DJZJebJXT4RUqHd0r3qbpYtaxn6ewSPHQLcKwyQGvK0/ODbEtH0tfdz
         /P0NpWinz+mUDl+ISIrB3Kco4NAo2moAYmR5aGeQv9zqZE8A5WoWxCEzRDxlNVTMT7qD
         OTqviILCV+c9TG0f/RdiUcENtADWt5QRPKH2DPikcQ7gRprVxFFKJBE2/yrqesM0ZnTF
         aNXTM0tABV+gIo5d09djhevPL623s2Mky0iqmL0Jpimycy7U0EW7Qqg7MQrU4ywrhlXh
         EjwIVO0YdUpynIYJdXazGYDpkhMEYxw/kC91v1hDOGYJCXn61KRnD4XeMw13pCrVM2bR
         hGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUnqDkhp8I/U34Xk2DihF2fZ0LXl/ojC5Gdgd+5fT1g=;
        b=fExu9g0FstBh+pjoBS1D8y1Ess8XwR1pEMNyeEFqMtfyxjQdNGE6FWy7HmkbB22B/x
         cHMYf07uvV+I4rEIIkAJbWK3NUHXKGbIGf+MHYnkZw7rXiKcRHUww/UeT0vceIw0cVqi
         B7cNktp3IJomAu2d0i1utCZKP0odt931jXQGSUgGJJZpNyPisPjibhtVus5j7H0Blvj7
         wIUcMz2LuDiisgdm9W40LIz8YkpT5RDETvxhCGk7tIASccPH7iOV6GCEZ0NZHdlFDh8H
         pNw3YIktt1U6ChuW5xISuRV1Cawwi6qZaBOGt1V6XWg1nsPxm3UYLd2al5RlU0nWIl0d
         8Byg==
X-Gm-Message-State: APjAAAVgfg6eAHdCR4JCq3MP9JCY3P1gbBFsp+Qia5X0/eIkUSsymUea
        BBCGJaSferXoMI/d12kCubdECpqMGg0=
X-Google-Smtp-Source: APXvYqzJrbpGmHIg0kbbZs6GahNcyT6zhIhopnwv1zrLWr8TeZLNTK95uTLobGMRMrwnRwYlbgEC5A==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr115099946pli.49.1564538511043;
        Tue, 30 Jul 2019 19:01:51 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b14sm117664pga.20.2019.07.30.19.01.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 19:01:50 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] drm/modes: Fix unterminated strncpy
Date:   Wed, 31 Jul 2019 10:01:40 +0800
Message-Id: <20190731020140.3529-1-hslester96@gmail.com>
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
Changes in v2:
  - Check whether mode_end + 1 exceeds
	the size of mode->name.

 drivers/gpu/drm/drm_modes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 80fcd5dc1558..b0369e690f36 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1770,7 +1770,9 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 	}
 
 	if (named_mode) {
-		strncpy(mode->name, name, mode_end);
+		if (mode_end + 1 > DRM_DISPLAY_MODE_LEN)
+			return false;
+		strscpy(mode->name, name, mode_end + 1);
 	} else {
 		ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
 						      parse_extras,
-- 
2.20.1

