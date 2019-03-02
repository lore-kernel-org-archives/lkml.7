Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6360C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B42720840
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kSUuuE7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCBAsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:48:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727645AbfCBAsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:48:37 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x220jHh2029455
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 16:48:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ZF7EFcBroV2u3cyQy9TAJgLSWWXNhtHN66iFkwpSAm4=;
 b=kSUuuE7NlFfXNEFdG/WBIjpnlFsSeVVpeG81qblLOwdRLJh3HqKY/CkU9+hOCUM7H5ir
 VbTnKs68b9gp4ii3evGKTvZcYNjbn6VYBDbR/GUsqh0ndWpE1CSHxZXXAtN5ZPCWGtwu
 B01+K2BNZhpycMro4JBymoS5typn2MlGy7s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qyeff864x-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 16:48:36 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 1 Mar 2019 16:48:33 -0800
Received: by devbig008.ftw2.facebook.com (Postfix, from userid 10532)
        id D90E623A26C6; Fri,  1 Mar 2019 16:48:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Hostname: devbig008.ftw2.facebook.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Calvin Owens <calvinowens@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 1/4] printk: Introduce per-console loglevel setting
Date:   Fri, 1 Mar 2019 16:48:17 -0800
Message-ID: <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all consoles are created equal: depending on the actual hardware,
the latency of a printk() call can vary dramatically. The worst examples
are serial consoles, where it can spin for tens of milliseconds banging
the UART to emit a message, which can cause application-level problems
when the kernel spews onto the console.

At Facebook we use netconsole to monitor our fleet, but we still have
serial consoles attached on each host for live debugging, and the latter
has caused problems. An obvious solution is to disable the kernel
console output to ttyS0, but this makes live debugging frustrating,
since crashes become silent and opaque to the ttyS0 user. Enabling it on
the fly when needed isn't feasible, since boxes you need to debug via
serial are likely to be borked in ways that make this impossible.

That puts us between a rock and a hard place: we'd love to set
kernel.printk to KERN_INFO and get all the logs. But while netconsole is
fast enough to permit that without perturbing userspace, ttyS0 is not,
and we're forced to limit console logging to KERN_WARNING and higher.

This patch introduces a new per-console loglevel setting, and changes
console_unlock() to use max(global_level, per_console_level) when
deciding whether or not to emit a given log message.

This lets us have our cake and eat it too: instead of being forced to
limit all consoles verbosity based on the speed of the slowest one, we
can "promote" the faster console while still using a conservative system
loglevel setting to avoid disturbing applications.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 36 +++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..3c27a4a29b8c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -155,6 +155,7 @@ struct console {
 	int	cflag;
 	void	*data;
 	struct	 console *next;
+	int	level;
 };
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d170374ceb..6ead14f8c2bc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1164,9 +1164,14 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static int effective_loglevel(struct console *con)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	return max(console_loglevel, con ? con->level : LOGLEVEL_EMERG);
+}
+
+static bool suppress_message_printing(int level, struct console *con)
+{
+	return (level >= effective_loglevel(con) && !ignore_loglevel);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -1198,7 +1203,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| suppress_message_printing(level, NULL)) {
 		return;
 	}
 
@@ -1712,7 +1717,7 @@ static int console_trylock_spinning(void)
  * The console_lock must be held.
  */
 static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len)
+				 const char *text, size_t len, int level)
 {
 	struct console *con;
 
@@ -1731,6 +1736,8 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		if (!cpu_online(smp_processor_id()) &&
 		    !(con->flags & CON_ANYTIME))
 			continue;
+		if (suppress_message_printing(level, con))
+			continue;
 		if (con->flags & CON_EXTENDED)
 			con->write(con, ext_text, ext_len);
 		else
@@ -2022,7 +2029,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len) {}
+				 const char *text, size_t len, int level) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
@@ -2358,21 +2365,11 @@ void console_unlock(void)
 		} else {
 			len = 0;
 		}
-skip:
+
 		if (console_seq == log_next_seq)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
-			/*
-			 * Skip record we have buffered and already printed
-			 * directly to the console when we received it, and
-			 * record that has level above the console loglevel.
-			 */
-			console_idx = log_next(console_idx);
-			console_seq++;
-			goto skip;
-		}
 
 		/* Output to all consoles once old messages replayed. */
 		if (unlikely(exclusive_console &&
@@ -2405,7 +2402,7 @@ void console_unlock(void)
 		console_lock_spinning_enable();
 
 		stop_critical_timings();	/* don't trace print latency */
-		call_console_drivers(ext_text, ext_len, text, len);
+		call_console_drivers(ext_text, ext_len, text, len, msg->level);
 		start_critical_timings();
 
 		if (console_lock_spinning_disable_and_check()) {
@@ -2671,6 +2668,11 @@ void register_console(struct console *newcon)
 	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV))
 		newcon->flags &= ~CON_PRINTBUFFER;
 
+	/*
+	 * By default, the per-console minimum forces no messages through.
+	 */
+	newcon->level = LOGLEVEL_EMERG;
+
 	/*
 	 *	Put this console in the list - keep the
 	 *	preferred driver at the head of the list.
-- 
2.17.1

