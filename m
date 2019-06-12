Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B71C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3D5qSk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbfFMRAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:00:41 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:38682 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbfFLX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:58:38 -0400
Received: by mail-yb1-f201.google.com with SMTP id a13so16952958ybm.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yYB71N56/U5nJhQbhNUWbENgcXZCI0bW+Vplj/QJV3Y=;
        b=L3D5qSk4yCBQXeK/aFvbSB+ZGxQIQCLKbFQsu6tl+wobBVotYYEFmur7xqd90bDCY0
         uNua69ri9O+S2ZhjuTLsl+MrQk57rb3p+A0xVJ+vBxpzuJ5+QpK8HygJlfYWZBRQkw1z
         EzJpZHnCzFew6rWCaX15Jqgdzt+eY5ydSMqlzHikdcjf4wxmQ0w+BbkF0H6MaGwK+ivx
         GUaoeTz+1ZcN+rzM4Ega0Qr+Nc6IljLoVtLtHO3RGHvD3wEzd6nRUtcQfGk/MjLjhBWl
         boh65s934voespHQ47oIGTcIP4aKIdfbhX45vlXoRUKcVL+ThwxznHxtQ0HkAlQ4SVoB
         OpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yYB71N56/U5nJhQbhNUWbENgcXZCI0bW+Vplj/QJV3Y=;
        b=KLFlx0llpLjGQj2P+ZU9braeHu+fDEITOluL3fKvgaSso40pQgQBtpZaZGX4ubz+nE
         7mJAbZaX2j2IOJT8RuXRm5/PfpTbJwIeXeBbSJqWqI2NIJJiGosi0I1+mzALfFU7oXgu
         ul4m8bOsyPpqzFGj2nkbUZ63KaXoghe3tYfkvBr+9vk7eij72ueRdyokS9XtjB9ZyH/Q
         sGddQhM/okHhs19Td1NF9ejBdfJ/5NdTLy48lvJkGeW6sd3KTW+p/lc3BGEOnkQU9fpm
         5WydDTpL3k0mgR4RCyfB4sn4E1cKGMPBU8C5tJQVbGVI43dq27nwcLRVFwmTGXFpkFIE
         1gSA==
X-Gm-Message-State: APjAAAV4nrs2NSa5bdJqUHhKdGSV30GUZB66kGlcI4z51UMV+lgK+CKY
        mitv7kF+wtz3KsQnnJMulCcIqBE8jQ==
X-Google-Smtp-Source: APXvYqxQsIAuwUkeEw6dmQi8jxqyLd0soq95WIuFqa6rF1GfYqz3bp/GztaqYMzknAo0AiUfAiokSpIVuA==
X-Received: by 2002:a81:6ad5:: with SMTP id f204mr25535319ywc.108.1560383917681;
 Wed, 12 Jun 2019 16:58:37 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:58:03 -0700
Message-Id: <20190612235803.9290-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] Input: atmel_mxt_ts - fix -Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/input/touchscreen/atmel_mxt_ts.c:259:42: warning: unused
variable 'mxt_video_fops' [-Wunused-const-variable]
static const struct v4l2_file_operations mxt_video_fops = {

Since mxt_video_fops is only used inside an ifdef. It should
be moved inside the ifdef.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/527
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 19378f200c63..48411c83320b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -256,6 +256,7 @@ enum v4l_dbg_inputs {
 	MXT_V4L_INPUT_MAX,
 };
 
+#ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
 static const struct v4l2_file_operations mxt_video_fops = {
 	.owner = THIS_MODULE,
 	.open = v4l2_fh_open,
@@ -265,6 +266,7 @@ static const struct v4l2_file_operations mxt_video_fops = {
 	.mmap = vb2_fop_mmap,
 	.poll = vb2_fop_poll,
 };
+#endif
 
 enum mxt_suspend_mode {
 	MXT_SUSPEND_DEEP_SLEEP	= 0,
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

