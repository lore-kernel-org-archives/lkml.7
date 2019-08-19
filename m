Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA3C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2D22184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdzYwGZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHSHvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:51:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34889 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:51:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so700689pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XneCY7KFk+nNdkDMfEbOgnq2lgPlJvwgpvOixbVWXec=;
        b=AdzYwGZUoq1zdTVwWIsLrEYcFhh73xZMOkgFZ6yRdgH7BMao94DWXyzvKFbOxXbnm2
         7OBJBbdOWdIIVjZuHAuG3zTyisw7driMXkIpe6tPgZmkMk63KrKMoBMpICBvHC7D8xVA
         /pYpKGNQYOMg7J6baCRHk5kNzzPp3i99Kcq8gIRVdqDZ68RsfiF6xQV7aYiVNNxIJyHu
         Lv1VaIZFWVNUWGXSkF557SHFFIWuKx7mmEvoUDinUt5DMH84tU9Ti0yA9NCuCo5XbG/W
         E4NOI89NWhYdyeysxMhgTtH/Mvy57hKIqNaTlkbf8uZy9lqvWx8l8UISGRBpMJquwt9O
         a8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XneCY7KFk+nNdkDMfEbOgnq2lgPlJvwgpvOixbVWXec=;
        b=Les6KVYtNe/UizvicI5UsKh1Y04fddt0RoVsJ+K+t03PmbBeOYKiv7AWv+RZKBjiXS
         3ihPm/lG6YtPyK5g7oFsiXubcZrY4AtPtwdHlCJpmcIbOYmGJoxEjmHiuzZPi2asqSpG
         gzsWM85nc1XtJbx/y+2TTY9b+M2IJWQacug/vDy7yP5u/Mx/s/zq/OoWuxdJBU3HRmLT
         BeDr7JTwZlJ96xIzs00CVixHDdF0+mqcjb9sXXKS6SNuk03++emkCKz8xERu047FQBHd
         r547Hdh/tCNSC/iC8swPRCg29F/hVmAufyYRoIU2owX8ICmg1vfp1oql0R9pr66OYbsW
         n8OA==
X-Gm-Message-State: APjAAAUuIY1RD5h5/TOMPI+QAQGMFNORPEM8JzawSvRW4E+2b1XEEc9i
        6uLtyg9puYuT5YXu7P9GKV4=
X-Google-Smtp-Source: APXvYqyoO5uRRxNEL071OeUXBr6ShhRJo6vP8k1/tAif4M55KSGf3lPZ8B56d/g5eTaeTOqJHtCrqA==
X-Received: by 2002:a17:90a:24ed:: with SMTP id i100mr19391388pje.47.1566201097246;
        Mon, 19 Aug 2019 00:51:37 -0700 (PDT)
Received: from localhost.localdomain ([110.225.16.165])
        by smtp.gmail.com with ESMTPSA id b126sm16273886pfa.177.2019.08.19.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 00:51:36 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     robin@protonic.nl, miguel.ojeda.sandonis@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] auxdisplay: ht16k33: Make ht16k33_fb_fix and ht16k33_fb_var constant
Date:   Mon, 19 Aug 2019 13:21:26 +0530
Message-Id: <20190819075126.870-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static structures ht16k33_fb_fix and ht16k33_fb_var, of types
fb_fix_screeninfo and fb_var_screeninfo respectively, are not used
except to be copied into other variables. Hence make both of them
constant to prevent unintended modification.
Issue found with
Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/auxdisplay/ht16k33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 9c0bb771751d..a2fcde582e2a 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -74,7 +74,7 @@ struct ht16k33_priv {
 	struct ht16k33_fbdev fbdev;
 };
 
-static struct fb_fix_screeninfo ht16k33_fb_fix = {
+static const struct fb_fix_screeninfo ht16k33_fb_fix = {
 	.id		= DRIVER_NAME,
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_MONO10,
@@ -85,7 +85,7 @@ static struct fb_fix_screeninfo ht16k33_fb_fix = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo ht16k33_fb_var = {
+static const struct fb_var_screeninfo ht16k33_fb_var = {
 	.xres = HT16K33_MATRIX_LED_MAX_ROWS,
 	.yres = HT16K33_MATRIX_LED_MAX_COLS,
 	.xres_virtual = HT16K33_MATRIX_LED_MAX_ROWS,
-- 
2.19.1

