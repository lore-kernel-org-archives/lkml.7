Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751321903
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfDAI6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfDAI6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1270D3092679;
        Mon,  1 Apr 2019 08:58:49 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E75335D706;
        Mon,  1 Apr 2019 08:58:42 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V5 6/7] jump_label: Batch updates if arch supports it
Date:   Mon,  1 Apr 2019 10:58:18 +0200
Message-Id: <3fbdeb0d8c19968f4a2e2af17a872a31b9a4adcf.1554106794.git.bristot@redhat.com>
In-Reply-To: <cover.1554106794.git.bristot@redhat.com>
References: <cover.1554106794.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 01 Apr 2019 08:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the architecture supports the batching of jump label updates, use it!

An easy way to see the benefits of this patch is switching the
schedstats on and off. For instance:

-------------------------- %< ----------------------------
  #!/bin/sh
  while [ true ]; do
      sysctl -w kernel.sched_schedstats=1
      sleep 2
      sysctl -w kernel.sched_schedstats=0
      sleep 2
  done
-------------------------- >% ----------------------------

while watching the IPI count:

-------------------------- %< ----------------------------
  # watch -n1 "cat /proc/interrupts | grep Function"
-------------------------- >% ----------------------------

With the current mode, it is possible to see +- 168 IPIs each 2 seconds,
while with this patch the number of IPIs goes to 3 each 2 seconds.

Regarding the performance impact of this patch set, I made two measurements:

    The time to update a key (the task that is causing the change)
    The time to run the int3 handler (the side effect on a thread that
                                      hits the code being changed)

The schedstats static key was chosen as the key to being switched on and off.
The reason being is that it is used in more than 56 places, in a hot path. The
change in the schedstats static key will be done with the following command:

while [ true ]; do
    sysctl -w kernel.sched_schedstats=1
    usleep 500000
    sysctl -w kernel.sched_schedstats=0
    usleep 500000
done

In this way, they key will be updated twice per second. To force the hit of the
int3 handler, the system will also run a kernel compilation with two jobs per
CPU. The test machine is a two nodes/24 CPUs box with an Intel Xeon processor
@2.27GHz.

Regarding the update part, on average, the regular kernel takes 57 ms to update
the schedstats key, while the kernel with the batch updates takes just 1.4 ms
on average. Although it seems to be too good to be true, it makes sense: the
schedstats key is used in 56 places, so it was expected that it would take
around 56 times to update the keys with the current implementation, as the
IPIs are the most expensive part of the update.

Regarding the int3 handler, the non-batch handler takes 45 ns on average, while
the batch version takes around 180 ns. At first glance, it seems to be a high
value. But it is not, considering that it is doing 56 updates, rather than one!
It is taking four times more, only. This gain is possible because the patch
uses a binary search in the vector: log2(56)=5.8. So, it was expected to have
an overhead within four times.

(voice of tv propaganda) But, that is not all! As the int3 handler keeps on for
a shorter period (because the update part is on for a shorter time), the number
of hits in the int3 handler decreased by 10%.

The question then is: Is it worth paying the price of "135 ns" more in the int3
handler?

Considering that, in this test case, we are saving the handling of 53 IPIs,
that takes more than these 135 ns, it seems to be a meager price to be paid.
Moreover, the test case was forcing the hit of the int3, in practice, it
does not take that often. While the IPI takes place on all CPUs, hitting
the int3 handler or not!

For instance, in an isolated CPU with a process running in user-space
(nohz_full use-case), the chances of hitting the int3 handler is barely zero,
while there is no way to avoid the IPIs. By bounding the IPIs, we are improving
a lot this scenario.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/jump_label.h |  3 +++
 kernel/jump_label.c        | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 7e91af98bbb1..b3dfce98edb7 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -215,6 +215,9 @@ extern void arch_jump_label_transform(struct jump_entry *entry,
 				      enum jump_label_type type);
 extern void arch_jump_label_transform_static(struct jump_entry *entry,
 					     enum jump_label_type type);
+extern int arch_jump_label_transform_queue(struct jump_entry *entry,
+					    enum jump_label_type type);
+extern void arch_jump_label_transform_apply(void);
 extern int jump_label_text_reserved(void *start, void *end);
 extern void static_key_slow_inc(struct static_key *key);
 extern void static_key_slow_dec(struct static_key *key);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 8b7bfbba4cef..7357a2df2e8c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -406,6 +406,7 @@ static bool jump_label_can_update(struct jump_entry *entry, bool init)
 	return true;
 }
 
+#ifndef HAVE_JUMP_LABEL_BATCH
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
@@ -417,6 +418,42 @@ static void __jump_label_update(struct static_key *key,
 		}
 	}
 }
+#else
+int fallback_batch __read_mostly;
+static void __jump_label_update(struct static_key *key,
+				struct jump_entry *entry,
+				struct jump_entry *stop,
+				bool init)
+{
+	for_each_label_entry(key, entry, stop) {
+
+		if (!jump_label_can_update(entry, init))
+			continue;
+
+		if (unlikely(fallback_batch)) {
+			arch_jump_label_transform(entry, jump_label_type(entry));
+			continue;
+		}
+
+		if (!arch_jump_label_transform_queue(entry, jump_label_type(entry)))
+			continue;
+
+		/*
+		 * Queue's overflow: Apply the current queue, and then try to
+		 * queue again. If it stills fail to queue, fallback to the
+		 * non-batch mode!
+		 */
+		arch_jump_label_transform_apply();
+
+		if (arch_jump_label_transform_queue(entry, jump_label_type(entry))) {
+			WARN(1, "jump_label: batch mode failure!\n");
+			fallback_batch = 1;
+			arch_jump_label_transform(entry, jump_label_type(entry));
+		}
+	}
+	arch_jump_label_transform_apply();
+}
+#endif
 
 void __init jump_label_init(void)
 {
-- 
2.20.1

