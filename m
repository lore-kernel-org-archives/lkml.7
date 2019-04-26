Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8928206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e91hCkkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDZFdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:33:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDZFdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:33:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1035939pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxcDl6YtGEDrYEZF0hWYyn6AOE3wA7P4SWUdISOueR8=;
        b=e91hCkkXiRL4cPs9OCJl9R17PEWPW96Zhyzgi2mTpzvQLXjgGtm8+a0XfTKIxTRMFe
         q6elUiYo0cYI567Aqj2yniBvGcE63QZvpF+2oBC25Sqz4M+S5eL+jWIE2SLzKeoh9xoi
         27tK0Do8YpV11gRZfNXmQOjF4KiA0PaKCRIDWxkyI8iG/cv4+Z+oWaG8LhWtT1s7O9+a
         GqNW8cMKvd1EZEP7ZcICv7L2B4nOpqmX9Pn8XcJnQh0atXXoCXX1V/wdDCgkg9U/FpSX
         73zpQ4E1mH0UKMp8l/DSN+bWMSVAV16dKVlN4ydZUhWJdw0mmL4F4+FSMrYxqdh5ibOD
         vc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxcDl6YtGEDrYEZF0hWYyn6AOE3wA7P4SWUdISOueR8=;
        b=Zlxzh8RuC1exJqbO3Nm7QjRPX1akSJT0YlJHjS+HQo7oTpRbuBDA3WQt4zNrmGMfTq
         HF3vOSmnCDLmwNVWpo0S4WweCqwwCdq/iNHBb9Lc8I0zgbP2i10Z8RjXcijxaDH03O4T
         JIWChX95cgXdYHfHN4Zug9+/BuXunYUcgogr71/mFV6sVTaXnBy5IxkOODHphF+yFB0d
         pFpVq1YpDj7RuAGbt12pJRrjbpHXLHQS2Dmc+OK9FMWi6QweRXeipMo1k9Nxu2BIeAAx
         Slg+a0QqqTVsSQfvg05kkGGRrcMcV/q8G0yu8wR4CMd5A/YgodD5rMETzTcq46Gh9O7h
         rYHA==
X-Gm-Message-State: APjAAAWCSZvjz1OXBf3ZfzGObfvbxRhe/5r24n1IStjjLtB4DDnmNSbd
        RnVIwhVSaZfn94Fra1LiHzo=
X-Google-Smtp-Source: APXvYqxSLuykJSO2CXjYAEnNWXBWyv+x7ZZRLFg7CktKXWGd4Pbu6uj48h5De1JJaFJnO/XldVM4Fg==
X-Received: by 2002:a62:a503:: with SMTP id v3mr12646795pfm.32.1556256803128;
        Thu, 25 Apr 2019 22:33:23 -0700 (PDT)
Received: from localhost.localdomain ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id j5sm5256532pfg.186.2019.04.25.22.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:33:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv2 3/4] printk: factor out register_console() code
Date:   Fri, 26 Apr 2019 14:33:01 +0900
Message-Id: <20190426053302.4332-4-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to take console_sem lock when we iterate console drivers
list. Otherwise, another CPU can concurrently modify console drivers
list or console drivers. Current register_console() has several
race conditions - for_each_console() must be done under console_sem.

Factor out console registration code and hold console_sem throughout
entire registration process. Note that we need to unlock console_sem
and lock it again after we added new console to the list and before
we unregister boot consoles. This might look a bit weird, but this
is how we print pending logbuf messages to all registered and
available consoles.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3ac71701afa3..3b36e26d4a51 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2666,7 +2666,7 @@ static int __unregister_console(struct console *console)
  *  - Once a "real" console is registered, any attempt to register a
  *    bootconsoles will be rejected
  */
-void register_console(struct console *newcon)
+static void __register_console(struct console *newcon)
 {
 	int i;
 	unsigned long flags;
@@ -2771,7 +2771,6 @@ void register_console(struct console *newcon)
 	 *	Put this console in the list - keep the
 	 *	preferred driver at the head of the list.
 	 */
-	console_lock();
 	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
 		newcon->next = console_drivers;
 		console_drivers = newcon;
@@ -2818,6 +2817,7 @@ void register_console(struct console *newcon)
 
 	console_unlock();
 	console_sysfs_notify();
+	console_lock();
 
 	if (keep_bootcon)
 		return;
@@ -2830,14 +2830,19 @@ void register_console(struct console *newcon)
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
 	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
-		console_lock();
 		for_each_console(bcon)
 			if (bcon->flags & CON_BOOT)
 				__unregister_console(bcon);
-		console_unlock();
-		console_sysfs_notify();
 	}
 }
+
+void register_console(struct console *newcon)
+{
+	console_lock();
+	__register_console(newcon);
+	console_unlock();
+	console_sysfs_notify();
+}
 EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
-- 
2.21.0

