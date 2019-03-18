Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE30AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4CC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCRF2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 01:28:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18279 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRF2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 01:28:11 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2I5RQWN009989;
        Mon, 18 Mar 2019 14:27:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 18 Mar 2019 14:27:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2I5RQhc009984;
        Mon, 18 Mar 2019 14:27:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x2I5RQVp009981;
        Mon, 18 Mar 2019 14:27:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: =?ISO-2022-JP?B?W3N5emJvdD8gcHJpbnRrP10gbm8gV0FSTl9PTigpIG1lc3NhZ2Vz?=
 =?ISO-2022-JP?B?IHByaW50ZWQgYmVmb3JlICJLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu?=
 =?ISO-2022-JP?B?ZzogcGFuaWNfb25fd2FybiBzZXQgLi4uIg==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
MIME-Version: 1.0
Date:   Mon, 18 Mar 2019 14:27:26 +0900
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp> <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
In-Reply-To: <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> > Then, we need to find what test is changing console_loglevel.
> > Maybe add debug BUG_ON() in linux-next.git using CONFIG_DEBUG_AID_FOR_SYZBOT ?
> 
> Is there a single place to catch this? I could run syzkaller locally
> first with the check.
> 

There is no such place. But not so many places change permanently.
For x86, you can test with below patch applied.

---
 drivers/tty/sysrq.c    |  1 +
 kernel/printk/printk.c |  3 +++
 kernel/sysctl.c        | 23 ++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index fa0ce7d..ad73520 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -91,6 +91,7 @@ static void sysrq_handle_loglevel(int key)
 	i = key - '0';
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 	pr_info("Loglevel set to %d\n", i);
+	WARN_ONCE(i < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", i);
 	console_loglevel = i;
 }
 static struct sysrq_key_op sysrq_loglevel_op = {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827..70d1f8c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1533,11 +1533,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	case SYSLOG_ACTION_CONSOLE_OFF:
 		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
 			saved_console_loglevel = console_loglevel;
+		WARN_ONCE(minimum_console_loglevel < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", minimum_console_loglevel);
 		console_loglevel = minimum_console_loglevel;
 		break;
 	/* Enable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:
 		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
+			WARN_ONCE(saved_console_loglevel < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", saved_console_loglevel);
 			console_loglevel = saved_console_loglevel;
 			saved_console_loglevel = LOGLEVEL_DEFAULT;
 		}
@@ -1548,6 +1550,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return -EINVAL;
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
+		WARN_ONCE(len < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", len);
 		console_loglevel = len;
 		/* Implicitly re-enable logging to console */
 		saved_console_loglevel = LOGLEVEL_DEFAULT;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b3df3ab..2170421 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -273,6 +273,27 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 int sysctl_legacy_va_layout;
 #endif
 
+static int proc_dointvec_loglevel(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write && buffer && *lenp) {
+		size_t len = *lenp;
+		char *kbuf, *p;
+
+		if (len > PAGE_SIZE - 1)
+			len = PAGE_SIZE - 1;
+		p = kbuf = memdup_user_nul(buffer, len);
+		if (IS_ERR(kbuf))
+			return PTR_ERR(kbuf);
+		while (*p && (*p < '0' || *p > '9'))
+			p++;
+		len = *p ? strtoul(p, &p, 10) : CONSOLE_LOGLEVEL_DEFAULT;
+		WARN_ONCE(len < CONSOLE_LOGLEVEL_DEFAULT, "Reducing console_loglevel to %d", (int) len);
+		kfree(kbuf);
+	}
+	return proc_dointvec(table, write, buffer, lenp, ppos);
+}
+
 /* The default sysctl tables: */
 
 static struct ctl_table sysctl_base_table[] = {
@@ -839,7 +860,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_loglevel,
 	},
 	{
 		.procname	= "printk_ratelimit",
-- 
1.8.3.1
