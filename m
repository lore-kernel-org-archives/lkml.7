Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37363C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0451A216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfEJPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:19:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51005 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfEJPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:19:34 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4AFJHvo041995;
        Sat, 11 May 2019 00:19:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 11 May 2019 00:19:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4AFJ8BC041939
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 May 2019 00:19:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] printk: Monitor change of console loglevel.
Date:   Sat, 11 May 2019 00:19:06 +0900
Message-Id: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing syzbot reports [1] where printk() messages prior to panic()
are missing for unknown reason. To test whether it is due to some testcase
changing console loglevel, let's panic() as soon as console loglevel has
changed. This patch is intended for testing on linux-next.git only, and
will be removed after we found what is wrong.

[1] https://lkml.kernel.org/r/127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e1e8250..f0b9463 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3338,3 +3338,23 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
+
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+static int initial_loglevel;
+static void check_loglevel(struct timer_list *timer)
+{
+	if (console_loglevel < initial_loglevel)
+		panic("Console loglevel changed (%d->%d)!", initial_loglevel,
+		      console_loglevel);
+	mod_timer(timer, jiffies + HZ);
+}
+static int __init loglevelcheck_init(void)
+{
+	static DEFINE_TIMER(timer, check_loglevel);
+
+	initial_loglevel = console_loglevel;
+	mod_timer(&timer, jiffies + HZ);
+	return 0;
+}
+late_initcall(loglevelcheck_init);
+#endif
-- 
1.8.3.1
