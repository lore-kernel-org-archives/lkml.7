Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BB6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXwXQRIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfDWGZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:25:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36052 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:25:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so6933473pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZFTdBIUUJjfsimkakHcVoELoo4JIW9HjqOJTQGZKvM=;
        b=DXwXQRIFynXjbkoWSNBA9YVgbZpa4J+UmtQB1P9lCuMCDc00asqHips14uFiEMKzbz
         zbCh8VNMovT3nnQcCEWTw+PO99J+X7T+c4m1NexkxBYHc0xy/usN4JYo5TlA1Bsykk3p
         pKlNE7nE6LZXYHX3zX/u/USVYB4v+o0sjTUwhU9RxPylJS8xK7DVJuK70afXXFdaPmYE
         sKQsfa7akklnAufAZetaFwinQZMgQu7LI/GBQoqUEiYm42yw06kFNmaSrGhBAV4BqCrq
         HBEjfnO74064r1jnzfZwephhjopzPaNX9mk4OH8ugKTT909epmvImc1Ur7jPgdXNPZdI
         RQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZFTdBIUUJjfsimkakHcVoELoo4JIW9HjqOJTQGZKvM=;
        b=hxt/83a2jfkwCkxrlRnDpka34ScuBJzLwHlPsM9T6vhog18OtAx6V0K24JRIIFxRSJ
         pBFcTTi9+G+IaMHsK/GcJ2kX37Y6nyPUlVymVPSylAethesl0omFJs1046u8+aB9gXXr
         6I8wYm/zrgrVw5lb9BKsXNGifB5xcXqnRUje4zyRN+PdgTKXsPduK7Ayiu1NtKG+3vQX
         HY2/ZP47e4mVl+FPf4qR3OrZjir5mOV3T5hsUNzZWs/mE4I7wGVIb+lPG3PPeIhRPJ0d
         y/YJ7LkFvQ7ftgdcFL9CM6jOwaTk3q5eRW7G+vvGSUOEkxwc71O1KAU+eLXqAlw12UAu
         gCUA==
X-Gm-Message-State: APjAAAWSdUAL6MuPvNNLlrcMF7T86W/jxvUhgx0wMpGZhOiJKoyrtyIH
        lEAretBsk16XDy3DOCzQ0B443P+y
X-Google-Smtp-Source: APXvYqzIBmudb2yv11DMvHwkl8cabyTzaNzunQksPWFhT11BEkRzLKwOs7ge4SULOCw0Pkrp7E+AAw==
X-Received: by 2002:a65:6659:: with SMTP id z25mr22844346pgv.10.1556000725300;
        Mon, 22 Apr 2019 23:25:25 -0700 (PDT)
Received: from localhost.localdomain ([175.223.38.143])
        by smtp.gmail.com with ESMTPSA id p3sm19490287pfn.167.2019.04.22.23.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 23:25:24 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 1/2] printk: lock console_sem before we unregister boot consoles
Date:   Tue, 23 Apr 2019 15:25:10 +0900
Message-Id: <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following pattern is not completely safe:

     for_each_console(bcon)
         if (bcon->flags & CON_BOOT)
             unregister_console(bcon);

Because, in theory, console drivers list and console drivers
can be modified concurrently from another CPU. Take console_sem
lock, which protects console drivers list and console drivers,
before we start iterating console drivers list.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 98 ++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17102fd4c136..b0e361ca1bea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2605,6 +2605,48 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int __unregister_console(struct console *console)
+{
+	struct console *a, *b;
+	int res;
+
+	pr_info("%sconsole [%s%d] disabled\n",
+		(console->flags & CON_BOOT) ? "boot" : "",
+		console->name, console->index);
+
+	res = _braille_unregister_console(console);
+	if (res)
+		return res;
+
+	res = 1;
+	if (console_drivers == console) {
+		console_drivers = console->next;
+		res = 0;
+	} else if (console_drivers) {
+		for (a = console_drivers->next, b = console_drivers;
+		     a; b = a, a = b->next) {
+			if (a == console) {
+				b->next = a->next;
+				res = 0;
+				break;
+			}
+		}
+	}
+
+	if (!res && (console->flags & CON_EXTENDED))
+		nr_ext_console_drivers--;
+
+	/*
+	 * If this isn't the last console and it has CON_CONSDEV set, we
+	 * need to set it on the next preferred console.
+	 */
+	if (console_drivers != NULL && console->flags & CON_CONSDEV)
+		console_drivers->flags |= CON_CONSDEV;
+
+	console->flags &= ~CON_ENABLED;
+	return res;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2777,62 +2819,34 @@ void register_console(struct console *newcon)
 	pr_info("%sconsole [%s%d] enabled\n",
 		(newcon->flags & CON_BOOT) ? "boot" : "" ,
 		newcon->name, newcon->index);
-	if (bcon &&
-	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
-	    !keep_bootcon) {
-		/* We need to iterate through all boot consoles, to make
+
+	if (keep_bootcon)
+		return;
+
+	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
+		console_lock();
+		/*
+		 * We need to iterate through all boot consoles, to make
 		 * sure we print everything out, before we unregister them.
 		 */
 		for_each_console(bcon)
 			if (bcon->flags & CON_BOOT)
-				unregister_console(bcon);
+				__unregister_console(bcon);
+		console_unlock();
+		console_sysfs_notify();
 	}
 }
 EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
 {
-        struct console *a, *b;
-	int res;
-
-	pr_info("%sconsole [%s%d] disabled\n",
-		(console->flags & CON_BOOT) ? "boot" : "" ,
-		console->name, console->index);
-
-	res = _braille_unregister_console(console);
-	if (res)
-		return res;
+	int ret;
 
-	res = 1;
 	console_lock();
-	if (console_drivers == console) {
-		console_drivers=console->next;
-		res = 0;
-	} else if (console_drivers) {
-		for (a=console_drivers->next, b=console_drivers ;
-		     a; b=a, a=b->next) {
-			if (a == console) {
-				b->next = a->next;
-				res = 0;
-				break;
-			}
-		}
-	}
-
-	if (!res && (console->flags & CON_EXTENDED))
-		nr_ext_console_drivers--;
-
-	/*
-	 * If this isn't the last console and it has CON_CONSDEV set, we
-	 * need to set it on the next preferred console.
-	 */
-	if (console_drivers != NULL && console->flags & CON_CONSDEV)
-		console_drivers->flags |= CON_CONSDEV;
-
-	console->flags &= ~CON_ENABLED;
+	ret = __unregister_console(console);
 	console_unlock();
 	console_sysfs_notify();
-	return res;
+	return ret;
 }
 EXPORT_SYMBOL(unregister_console);
 
-- 
2.21.0

