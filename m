Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BD5206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i99qGsap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDZGeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:34:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43835 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:34:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so1034780plp.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbSYJTmXjBVZearCiZ36NWRqAeUMukX6DPGvwKnl46Q=;
        b=i99qGsapzMycxtkJiwxvpSxBJVNhpozutRz+rX2NhQS50s3v2EAGs24XYOKwLzlZy/
         nvUKjxwyyAA0igwuj+vTQ74OPyORUdmGBYpLKh4qhMLj1PkTBL4S/z/6MD4nkOYwl1+4
         QWOEZDp96atXu4oijK0HjdKexX45EjxIGLIUO/yRp9fHIIjlJyNEMWO76hFHbiGukwnC
         BpgJ/UIbjlxeE8cF9K2+0PEykQj683A/o5aNep99Olwn/1AxGhfiOsPcKrc9aTCWxk/j
         m4dG7MlDZ8VQDW9rAI6jX1wgyvSP3xHqvZtT3ljekQRIOozEPBCszmVsbsHqPgfSm2+A
         SoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbSYJTmXjBVZearCiZ36NWRqAeUMukX6DPGvwKnl46Q=;
        b=LOUBoD/uRTvYkfiM+QSzCye9mv75rS0vMG8VLdiaIuWe6duhMChKjOtemw7Rub6mp2
         522+4OFw0qgq290bQ/ojZJW5TAOGnBm6kVXNaSOETt29HHnVUDNajGTWR3lSYos6LUfq
         rHimlrnIt/ShX6nyH6XyD5xdEXuBW5R5yREE538rjnaXAeOjcPVFwkU/V25ktT1O9OGn
         it3AB6fyRTnLySbAhRikdnEQjymuWT+cQKFzcGDzW1OxedIon+WzslZ04wwFsYv2cfOa
         dP3D7H0DdTG55CrvqXHW6W4sa79WuNCcl1FEvewlsOQtuObHrxr1xfxjl13Ix2RKFRfW
         3XpA==
X-Gm-Message-State: APjAAAW4WURqCTNRqgQlHPJY7knWb7R5rnzXjNckVhAsWUMiLVix+D7e
        xVvmL63c98AwHxmWMSQL3uU=
X-Google-Smtp-Source: APXvYqzk7nqUHCsHNrXoviKE0lkh/auPwygLC1UBIjq/FhBsmKwmcTQK42f5rYKYIlizoHrAUG+mdA==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr2986166plb.4.1556260443956;
        Thu, 25 Apr 2019 23:34:03 -0700 (PDT)
Received: from localhost.localdomain ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id k3sm31410442pfb.175.2019.04.25.23.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:34:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH] panic: make panic start/end messages consistent
Date:   Fri, 26 Apr 2019 15:33:56 +0900
Message-Id: <20190426063356.20453-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have consistency:
- we always print panic header
	pr_emerg("Kernel panic - not syncing:")

- but we don't always print panic footer
	pr_emerg("---[ end Kernel panic - not syncing:")

For instance, no panic footer (end panic) message will be
printed when panic_timeout is set - the kernel will either
reboot immediately after console_flush_on_panic() (emergency
restart) or after panic_timeout seconds. Additionally,
panic_print_sys_info() goes before panic footer line, which
doesn't look very right, panic_print_sys_info() is just
additional debugging into.

Let's make it consistent:

	pr_emerg("Kernel panic - not syncing:")
	dump_stack();
	console_flush_on_panic();
	pr_emerg("---[ end Kernel panic - not syncing:")

	panic_print_sys_info();
	/* the rest */
	/* panic_timeout handling */

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/panic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 40882dad9f70..6482e4b54f0b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -282,6 +282,7 @@ void panic(const char *fmt, ...)
 	 */
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	panic_print_sys_info();
 
@@ -331,8 +332,6 @@ void panic(const char *fmt, ...)
 		disabled_wait(caller);
 	}
 #endif
-	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
-
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 	local_irq_enable();
-- 
2.21.0

