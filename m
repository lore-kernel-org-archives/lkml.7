Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BB0206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV2NQqI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDZFdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:33:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZFdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:33:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so1084358pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvkYiBnq9MCULm/XbZkyhm0S4jkttSGd8t6FhCRPz8E=;
        b=bV2NQqI0BA48W1JrRKkIJGq1IdGE5UQpjuTwmWh5v+YUkj0Zm+mTcTQXZ7x9tSWCOV
         7mLDXwjKvtnoQRGIurqSFd9BooDqcBh0Dviv5JHbNPwrfYrvyIh0QcfJ/lneexd63DWB
         SEK6SiI7IIAEZK3NtEQQ4vJc/dLBRItRx/dBOP5HypvTe9vSBa4FuR2lGexV+4qSF8Zm
         g7bMYeMaJ+ESgPRhczsa/miV4mHdM6E7P33HE4XZ0lBJ5VYvdUtlJTGPoOw0trQQqR9z
         ySfwc15Yq3XRdlNWIWoJxa6yNq2Pl7d6O6z0rhL2dwwQp2CdDGekfuMrApAoAE46Bk1C
         wM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvkYiBnq9MCULm/XbZkyhm0S4jkttSGd8t6FhCRPz8E=;
        b=h/4436Qa5aBivBGwUPssbDn9nQtPlfWhYyxtDImYINpvMX80u16M16h1FZFb/xFcH9
         wW2Vgn5S6B54ue1US06t0Aa2oiIlHrE3sOdfs0Csnb9tDmKSZqTC3C7YdElfQ4jW5aj/
         laZYKYO8OVD9+En3hY1JNEGvJ6cbpvzKarCTWxx0E4JbXA9qB6ubkCpl3ag3rEQ/v61K
         Uhfyrc033efaFmVYlwiqHFD7+8/ir9kpVEQ5M3EeV7I0XCDracaI6PTaltIcW8TPajPA
         LtcSjNs8NScOEhDDdYhfOVkXrgNTDOkEOjB7RcdSrs1ykZtfadmWr3M1DtkuLRM982i2
         okvg==
X-Gm-Message-State: APjAAAUgCcNGUy/yuRY8b6XiD4ZWo6Iej6Y3rB1Xd9IsbQf9wBwrAGiw
        yfC4gc1yswwoySf4GR2NP3c=
X-Google-Smtp-Source: APXvYqxsuKbpvWHd0xidzeD0trXxRdeAODnMR9L967E9BvwPkPTHONfsb1fMMfZ6EDnXbpX4PCSdGQ==
X-Received: by 2002:a63:d84a:: with SMTP id k10mr41126551pgj.441.1556256798901;
        Thu, 25 Apr 2019 22:33:18 -0700 (PDT)
Received: from localhost.localdomain ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id j5sm5256532pfg.186.2019.04.25.22.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:33:18 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv2 2/4] printk: remove invalid register_console() comment
Date:   Fri, 26 Apr 2019 14:33:00 +0900
Message-Id: <20190426053302.4332-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't iterate consoles twice, since commit 8259cf434202
("printk: Ensure that "console enabled" messages are printed
 on the console"), so the comment is not valid anymore, and
can be removed, as was suggested by Petr.

The patch also invokes pr_info("%sconsole [%s%d] enabled\n")
before we unlock_consoles(), just to make sure that we really
print that message on every registered and enabled console.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b0e361ca1bea..3ac71701afa3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2806,9 +2806,22 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 		logbuf_unlock_irqrestore(flags);
 	}
+
+	/*
+	 * We are still under console_sem, pr_info() will only add the message
+	 * to the kernel's log buffer. console_unlock() will print it on all
+	 * registered and enabled consoles.
+	 */
+	pr_info("%sconsole [%s%d] enabled\n",
+		(newcon->flags & CON_BOOT) ? "boot" : "",
+		newcon->name, newcon->index);
+
 	console_unlock();
 	console_sysfs_notify();
 
+	if (keep_bootcon)
+		return;
+
 	/*
 	 * By unregistering the bootconsoles after we enable the real console
 	 * we get the "console xxx enabled" message on all the consoles -
@@ -2816,19 +2829,8 @@ void register_console(struct console *newcon)
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
-	pr_info("%sconsole [%s%d] enabled\n",
-		(newcon->flags & CON_BOOT) ? "boot" : "" ,
-		newcon->name, newcon->index);
-
-	if (keep_bootcon)
-		return;
-
 	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
 		console_lock();
-		/*
-		 * We need to iterate through all boot consoles, to make
-		 * sure we print everything out, before we unregister them.
-		 */
 		for_each_console(bcon)
 			if (bcon->flags & CON_BOOT)
 				__unregister_console(bcon);
-- 
2.21.0

