Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC81C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C9E21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfEHKbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:31:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49799 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfEHKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:31:53 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x48AVDjN074608;
        Wed, 8 May 2019 19:31:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Wed, 08 May 2019 19:31:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x48AV79X074551
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 8 May 2019 19:31:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
Message-ID: <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
Date:   Wed, 8 May 2019 19:31:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

We are again getting corrupted reports where message from WARN() is missing.
For example, https://syzkaller.appspot.com/text?tag=CrashLog&x=1720cac8a00000 was
titled as "WARNING in cgroup_exit" because the
"WARNING: CPU: 0 PID: 7870 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
line is there but https://syzkaller.appspot.com/text?tag=CrashLog&x=1670a602a00000
was titled as "corrupted report (2)" because the
"WARNING: CPU: 0 PID: 10223 at kernel/cgroup/cgroup.c:6008 cgroup_exit+0x51a/0x5d0"
line is missing. Also, it is unlikely that there was no printk() for a few minutes.
Thus, I suspect something is again suppressing console output.
Since this problem is happening in 5.1.0-next-20190507, do we want to try below one?

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





By the way, recently we are hitting false positives caused by "WARNING:"
string from not WARN() messages but plain printk() messages (e.g.

  https://syzkaller.appspot.com/bug?id=31bdef63e48688854fde93e6edf390922b70f8a4
  https://syzkaller.appspot.com/bug?id=faae4720a75cadb8cd0dbda5c4d3542228d37340

) and we need to avoid emitting "WARNING:" string from plain printk() messages
during fuzzing testing. I guess we want to add something like
CONFIG_DEBUG_AID_FOR_SYZBOT to all kernels in order to mask such string...
