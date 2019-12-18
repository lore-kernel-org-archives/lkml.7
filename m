Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D079C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F091206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/qv0ZCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLRDAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:00:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39883 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRDAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:00:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so515844oty.6;
        Tue, 17 Dec 2019 19:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwTUvw7XaRz2SlqwuKp+LVG2T88wKaGXcyDmN7449mo=;
        b=M/qv0ZCZkJmxKvIbZ4PXNPWC/fhpd48XEONEmvva4ejd2BHXSxvrlhZ7SCIYEmuoFv
         Ik5Xu3mWH63/5iHKxKWWHrTFKDsSQESLrupFeEt0xZb8NwQOwIGFJav3ttaH0m6GNW51
         XHYXeh1pHCczyCjIBveXYhH4SNvpZfTuggOrRzKdUnSpnpuAn9NDAbupV8pQE8C6v/Eo
         yMIEMVS+FeOGTWwjy801kTD5c/BB8fQJHqdlGXk/oqCu4max09GZAxwLb7LzQLLemhcP
         oBdSSOspGKJk6mKm7uFQ6W0wt16uOedOnliZPdJ67Iv1R6PGlT18n48Pe7xj7+Ppm5sf
         GwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwTUvw7XaRz2SlqwuKp+LVG2T88wKaGXcyDmN7449mo=;
        b=B+ukqtv9jQw5x1oTtHPEUWjZIY5hMbEcWi47hSmV/UNPRMHy3xFHa01UDr/3z83UXF
         F61ZZ15O6y8JZBQhpdgcgdKBaoXOQCwsOIMRdgPBmiFXIPuW/jwRs8H/pOIbEZCzF/vQ
         PIew/LN5EuFyXISedyOqDvP6L2a4k/ZTv+DhaUQ6+6PuS82wAYRrLMFsWPfQQtOSvNFE
         p7gJYMHwbdxs23BFHOy0ICfMj+gA0/cIrRJDQi5RYOah5dFffj3hO7NBQ+Nx90icW+FC
         Ne60E/tchZtBX1qEr5AGIaajMK77id9+zWiVHKYjHSTsc6gCcSyrWCxGH1rkNBUA40C/
         B+pA==
X-Gm-Message-State: APjAAAXZQoL+phcRnrSufRKzPmKlM3q54I3qD71ajXlA9/iS3I2OIsbD
        UJECX1AVWoxriAxFdc7gv/E=
X-Google-Smtp-Source: APXvYqwi52DW7BTH/Joy63L2i6a/L8NgInTxr1fjqelbSr7NB6xlsFO0WENr+MWp3f3/50zFaX0Qbg==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr29328otp.143.1576638030607;
        Tue, 17 Dec 2019 19:00:30 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b3sm327530oie.25.2019.12.17.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:00:30 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] fbmem: Adjust indentation in fb_prepare_logo and fb_blank
Date:   Tue, 17 Dec 2019 20:00:25 -0700
Message-Id: <20191218030025.10064-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/video/fbdev/core/fbmem.c:665:3: warning: misleading
indentation; statement is not part of the previous 'else'
[-Wmisleading-indentation]
        if (fb_logo.depth > 4 && depth > 4) {
        ^
../drivers/video/fbdev/core/fbmem.c:661:2: note: previous statement is
here
        else
        ^
../drivers/video/fbdev/core/fbmem.c:1075:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        return ret;
        ^
../drivers/video/fbdev/core/fbmem.c:1072:2: note: previous statement is
here
        if (!ret)
        ^
2 warnings generated.

This warning occurs because there are spaces before the tabs on these
lines. Normalize the indentation in these functions so that it is
consistent with the Linux kernel coding style and clang no longer warns.

Fixes: 1692b37c99d5 ("fbdev: Fix logo if logo depth is less than framebuffer depth")
Link: https://github.com/ClangBuiltLinux/linux/issues/825
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 36 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0662b61fdb50..bf63cc0e6b65 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -662,20 +662,20 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 		fb_logo.depth = 1;
 
 
- 	if (fb_logo.depth > 4 && depth > 4) {
- 		switch (info->fix.visual) {
- 		case FB_VISUAL_TRUECOLOR:
- 			fb_logo.needs_truepalette = 1;
- 			break;
- 		case FB_VISUAL_DIRECTCOLOR:
- 			fb_logo.needs_directpalette = 1;
- 			fb_logo.needs_cmapreset = 1;
- 			break;
- 		case FB_VISUAL_PSEUDOCOLOR:
- 			fb_logo.needs_cmapreset = 1;
- 			break;
- 		}
- 	}
+	if (fb_logo.depth > 4 && depth > 4) {
+		switch (info->fix.visual) {
+		case FB_VISUAL_TRUECOLOR:
+			fb_logo.needs_truepalette = 1;
+			break;
+		case FB_VISUAL_DIRECTCOLOR:
+			fb_logo.needs_directpalette = 1;
+			fb_logo.needs_cmapreset = 1;
+			break;
+		case FB_VISUAL_PSEUDOCOLOR:
+			fb_logo.needs_cmapreset = 1;
+			break;
+		}
+	}
 
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
@@ -1060,19 +1060,19 @@ fb_blank(struct fb_info *info, int blank)
 	struct fb_event event;
 	int ret = -EINVAL;
 
- 	if (blank > FB_BLANK_POWERDOWN)
- 		blank = FB_BLANK_POWERDOWN;
+	if (blank > FB_BLANK_POWERDOWN)
+		blank = FB_BLANK_POWERDOWN;
 
 	event.info = info;
 	event.data = &blank;
 
 	if (info->fbops->fb_blank)
- 		ret = info->fbops->fb_blank(blank, info);
+		ret = info->fbops->fb_blank(blank, info);
 
 	if (!ret)
 		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
 
- 	return ret;
+	return ret;
 }
 EXPORT_SYMBOL(fb_blank);
 
-- 
2.24.1

