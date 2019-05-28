Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C3CC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4302075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LTim0pnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfE1AYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:24:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45469 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfE1AYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:24:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so14123604edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nMaiGb8J85vI8VaTTCJ77RKJKQIuOftlKRmnStHdLU=;
        b=LTim0pnlOuBp52iCB81PuABbPYz+4sbajZLtd5npLwJtzNHxn63+B2/2yergtUubP/
         m1Hf0AD8iq8cJDHulH9/yImX3BJsuhWm86WdaApjUUrsfFDU829uX/6kvYp8laS7Xxwv
         YhplqxkjC46HZ+ITdNEDSIxyT1diANMiPQV1GJHSqkvjzIriW0M3AnLh+je85XC/yPqw
         aaf88kGR9M+zw0/wDLdB8veS13BuvWsHJq4eCxisalHVjAYjcEvPWFcQhcuhRXhvHQRl
         5PmoiODwqmK+la/vySL6V4Zshb8z+KBUNDz4YFjypCv286jpDSHQdSDiEM2/rnuiSabb
         502g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nMaiGb8J85vI8VaTTCJ77RKJKQIuOftlKRmnStHdLU=;
        b=Z2spezq7vgq20YdMjlUrIq1lOxRz5nlsCM03577BaaJ/rtTNkHN/cGdeBOp7vl40fP
         80Lgzh7ItXPUG3IIUWD47H0jHM8F52fbHpV6kuXqPyeXlAA0644nF8/BBq67YUoX2egk
         mWrQ3bXSulFjQ6IGmXXhUrhRJRs4Z3jTuTcsyDS459lxU0L+UlzeLcjwqpsBDljYaD96
         Qy2rQ2cxt0swqGxjJGDrmv0SXb8gGMD71Hhm2EokecT34q/DmHLO10lyouyJLwitAHOQ
         t3TP/lPKk5jPkcpcOlvTWrWMJh1QPkgmbR6j8xt70OGv/0xRxNOiQxEyNf4A9oBsd2no
         CtDQ==
X-Gm-Message-State: APjAAAXdrVgdw527MZWmC5Mcu/XUa/0YrqUh6ZBkFEXbyIGqh2Mo+339
        2021eDtNeGh5Hku7zGP0MjafP3d0d00=
X-Google-Smtp-Source: APXvYqzjm/QtROf9I03NIyUBzt7nEyfnokeq3d3tUBhFoqimO9nosab0iXXuom70eHMVYJUDUD25BQ==
X-Received: by 2002:aa7:c402:: with SMTP id j2mr126076494edq.165.1559003054587;
        Mon, 27 May 2019 17:24:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c8sm222018ejm.55.2019.05.27.17.24.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 17:24:13 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC] printk/sysrq: Don't play with console_loglevel
Date:   Tue, 28 May 2019 01:24:12 +0100
Message-Id: <20190528002412.1625-1-dima@arista.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While handling sysrq the console_loglevel is bumped to default to print
sysrq headers. It's done to print sysrq messages with WARNING level for
consumers of /proc/kmsg, though it sucks by the following reasons:
- changing console_loglevel may produce tons of messages (especially on
  bloated with debug/info prints systems)
- it doesn't guarantee that the message will be printed as printk may
  deffer the actual console output from buffer (see the comment near
  printk() in kernel/printk/printk.c)

Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
Make sysrq print the headers unsuppressed instead of changing
console_loglevel.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
(I'm not fond at all of this patch - sending as RFC just to touch
 how you all feel about this..)

 drivers/tty/sysrq.c         | 34 ++++++++++++++++++----------------
 include/linux/kern_levels.h |  6 ++++++
 include/linux/printk.h      |  1 +
 kernel/printk/printk.c      | 17 ++++++++++++-----
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 59e82e6d776d..ea37e3aa84b3 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -523,23 +523,28 @@ static void __sysrq_put_key_op(int key, struct sysrq_key_op *op_p)
                 sysrq_key_table[i] = op_p;
 }
 
+#if (CONSOLE_LOGLEVEL_DEFAULT > LOGLEVEL_INFO)
+#define KERN_SYSRQ		KERN_UNSUPPRESSED
+#else
+#define KERN_SYSRQ
+#endif
+#define sysrq_info(fmt, ...)	\
+	printk(KERN_SYSRQ KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define sysrq_cont(fmt, ...)	\
+	printk(KERN_SYSRQ KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	struct sysrq_key_op *op_p;
-	int orig_log_level;
 	int i;
 
 	rcu_sysrq_start();
 	rcu_read_lock();
+
 	/*
-	 * Raise the apparent loglevel to maximum so that the sysrq header
-	 * is shown to provide the user with positive feedback.  We do not
-	 * simply emit this at KERN_EMERG as that would change message
-	 * routing in the consumers of /proc/kmsg.
+	 * We do not simply emit this at KERN_EMERG as that would change
+	 * message routing in the consumers of /proc/kmsg.
 	 */
-	orig_log_level = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
-
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
 		/*
@@ -547,15 +552,13 @@ void __handle_sysrq(int key, bool check_mask)
 		 * should not) and is the invoked operation enabled?
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
-			pr_info("%s\n", op_p->action_msg);
-			console_loglevel = orig_log_level;
+			sysrq_info("%s\n", op_p->action_msg);
 			op_p->handler(key);
 		} else {
-			pr_info("This sysrq operation is disabled.\n");
-			console_loglevel = orig_log_level;
+			sysrq_info("This sysrq operation is disabled.\n");
 		}
 	} else {
-		pr_info("HELP : ");
+		sysrq_info("HELP : ");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {
@@ -566,11 +569,10 @@ void __handle_sysrq(int key, bool check_mask)
 					;
 				if (j != i)
 					continue;
-				pr_cont("%s ", sysrq_key_table[i]->help_msg);
+				sysrq_cont("%s ", sysrq_key_table[i]->help_msg);
 			}
 		}
-		pr_cont("\n");
-		console_loglevel = orig_log_level;
+		sysrq_cont("\n");
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();
diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index bf2389c26ae3..2f40d6ace60d 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -23,6 +23,12 @@
  */
 #define KERN_CONT	KERN_SOH "c"
 
+/*
+ * Annotation for a message that will be printed regardless current
+ * console_loglevel. _DO_NOT_USE_IT! Exists for legacy code.
+ */
+#define KERN_UNSUPPRESSED	KERN_SOH "u"
+
 /* integer equivalents of KERN_<LEVEL> */
 #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
 					 * are set to this special level */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 84ea4d094af3..60a5cfde1488 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -19,6 +19,7 @@ static inline int printk_get_level(const char *buffer)
 		switch (buffer[1]) {
 		case '0' ... '7':
 		case 'c':	/* KERN_CONT */
+		case 'u':	/* KERN_UNSUPPRESSED */
 			return buffer[1];
 		}
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..c6dd82c37382 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -345,6 +345,7 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 
 enum log_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
+	LOG_DONT_SUPPRESS = 4,	/* ignore current console_loglevel */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
@@ -1179,9 +1180,12 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static bool suppress_message_printing(int level, u8 lflags)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	if (ignore_loglevel || (lflags & LOG_DONT_SUPPRESS))
+		return false;
+
+	return level >= console_loglevel;
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -1213,7 +1217,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| suppress_message_printing(level, 0)) {
 		return;
 	}
 
@@ -1917,6 +1921,9 @@ int vprintk_store(int facility, int level,
 				break;
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
+				break;
+			case 'u':	/* KERN_UNSUPPRESSED */
+				lflags |= LOG_DONT_SUPPRESS;
 			}
 
 			text_len -= 2;
@@ -2069,7 +2076,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
+static bool suppress_message_printing(int level, u8 lflags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2407,7 +2414,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if (suppress_message_printing(msg->level, msg->flags)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
-- 
2.21.0

