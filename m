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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F27F21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs0MAylM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRCxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:53:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43120 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLRCxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:53:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so481923oth.10;
        Tue, 17 Dec 2019 18:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=napGSWjNbtalCcb/TGth7a+gCE4XiYyJESJ2KzfJmU8=;
        b=hs0MAylM1x9OeqPMSPUXXG4f/LQFGdgUZ+x09WQNrJ6Is+O9oD5Yz4jKugxFxQzh7n
         S9bw9s50RChQY5ZGMz76zzUpS1LFrrARuogPumZpCpxuAEhE+QB5MxGeJaKNzvwOuOiQ
         YPgor9D+jr0x3K0qnhzgruo6r0y9XBCLMhokJiNc2AI26q3ckHXNU4pF3tRcS+cRtkId
         qM4t1XRlWudrz2fDAxMCfN4HpXkPgE+W34bSz+J5Ycf7GvNuRcSBzMyIIt59UkKxQBHd
         OujXN65VcqHiTytgficx6Bq6nF6nRNhz1l/+Ak3lmmG/dxdjfjGkOs52tT0ehE30R7fZ
         bGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=napGSWjNbtalCcb/TGth7a+gCE4XiYyJESJ2KzfJmU8=;
        b=DLStilepSzUI/mDAFmbeixFL2tNW3AhY/egiS9Z8aWZj/5VJKx+yhk3o/y0Swkvd6n
         KWHrO+CNRAWkx2B0XtTgq3VZn6p+kzjHqxlRl2S2iUST+fmmhXubIKUtTJm7qBcF7jDJ
         OiKg09Pz7uScutRzKwY+5ECtua6Jd2bdzpujCQehBS19K+Um421wZ5Ti7VkEjG3A/iVR
         C8kn2WKEgQzXrsbRTMzc0Ur9Q2ACtyvl/qzGljoLDK8BeywrdalW2sfqC2fYMxDHaE0p
         5QU1V1IJ3yuaKjVGWSxgBbXjI6WfmoTtG0P82fBth3HFRAgK5a6AlHfhY5c8TD1IUzUu
         fi4Q==
X-Gm-Message-State: APjAAAWw1m5H/EhzyZOCHTryR5eahaZVzr0BzInq3+1P+FffguDXHW3W
        Wv9oiE/dJMA2ydYwp+j1nfazIPTb
X-Google-Smtp-Source: APXvYqweUnGyc7Bkuy40mtuJwRPbvb6R4a3nrdaFBq7qRzNeSOHozOIJBbv5SpCrYTFmG64y7nKIEg==
X-Received: by 2002:a05:6830:2361:: with SMTP id r1mr51151oth.88.1576637627813;
        Tue, 17 Dec 2019 18:53:47 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q16sm279817otl.74.2019.12.17.18.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 18:53:47 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] fbcon: Adjust indentation in set_con2fb_map
Date:   Tue, 17 Dec 2019 19:53:37 -0700
Message-Id: <20191218025337.35044-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/video/fbdev/core/fbcon.c:915:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        return err;
        ^
../drivers/video/fbdev/core/fbcon.c:912:2: note: previous statement is
here
        if (!search_fb_in_map(info_idx))
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. This happens on several lines in this function; normalize them
so that the indentation is consistent with the Linux kernel coding
style and clang no longer warns.

This warning was introduced before the beginning of git history so no
fixes tab.

Link: https://github.com/ClangBuiltLinux/linux/issues/824
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c9235a2f42f8..9d2c43e345a4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -866,7 +866,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
- 	int found, err = 0;
+	int found, err = 0;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -888,31 +888,30 @@ static int set_con2fb_map(int unit, int newidx, int user)
 
 	con2fb_map[unit] = newidx;
 	if (!err && !found)
- 		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
-
+		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
 
 	/*
 	 * If old fb is not mapped to any of the consoles,
 	 * fbcon should release it.
 	 */
- 	if (!err && oldinfo && !search_fb_in_map(oldidx))
- 		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
- 					     found);
+	if (!err && oldinfo && !search_fb_in_map(oldidx))
+		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
+					     found);
 
- 	if (!err) {
- 		int show_logo = (fg_console == 0 && !user &&
- 				 logo_shown != FBCON_LOGO_DONTSHOW);
+	if (!err) {
+		int show_logo = (fg_console == 0 && !user &&
+				 logo_shown != FBCON_LOGO_DONTSHOW);
 
- 		if (!found)
- 			fbcon_add_cursor_timer(info);
- 		con2fb_map_boot[unit] = newidx;
- 		con2fb_init_display(vc, info, unit, show_logo);
+		if (!found)
+			fbcon_add_cursor_timer(info);
+		con2fb_map_boot[unit] = newidx;
+		con2fb_init_display(vc, info, unit, show_logo);
 	}
 
 	if (!search_fb_in_map(info_idx))
 		info_idx = newidx;
 
- 	return err;
+	return err;
 }
 
 /*
-- 
2.24.1

