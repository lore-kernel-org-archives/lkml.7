Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC9C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23310206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfEWJ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:57:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfEWJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:57:47 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4N9v5RO041482;
        Thu, 23 May 2019 18:57:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 23 May 2019 18:57:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4N9uo60041398
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 23 May 2019 18:57:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190514091917.GA26804@jagdpanzerIV>
 <3e2cf31d-25af-e7c3-b308-62f64d650974@i-love.sakura.ne.jp>
Message-ID: <4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp>
Date:   Thu, 23 May 2019 18:56:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3e2cf31d-25af-e7c3-b308-62f64d650974@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the culprit of this problem might be syz_execute_func().

  https://twitter.com/ed_maste/status/1131165065485398016

Then, blacklisting specific syscalls/arguments might not work.
We will need to guard specific paths on the kernel side using
some kernel config option...

Anyway, Andrew, will you send this patch to linux-next.git ?
syzbot would identify which syz_execute_func() call is triggering
this problem.

From 96e0741839f56c461f85d83e20bf5ae6baac9a3a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 23 May 2019 05:57:52 +0900
Subject: [PATCH] printk: Monitor change of console loglevel.

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
index 1888f6a..5326015 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3343,3 +3343,23 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
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
