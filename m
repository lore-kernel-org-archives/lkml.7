Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D789C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572A2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DYM26yvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfFQOQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:16:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:16:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEFtrT3452399
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:15:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEFtrT3452399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780956;
        bh=bRUpAMP3+2MttUQFM00wGOJZZl0Vur+HegccH9fDJoI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DYM26yvEdhqeIE1BMVbAdOWwvtO3NXCFtlsRja9gRwz4hlzOxXknaZ8mqaV8tktoi
         cGkjSHGOHJJXUfm4W45BuK94v7nAKDKRELjX+1EeHhgh/HrEkInRST6qQyRz8bGyTY
         QH4Mi6I8oV8HE5f5bohN9rnivOLfx7WWzDVNpDACr17b4sqZw+cvSDddGlHWKIquqt
         X+BEuxMsiDve2RSaokuVQ7cOK2lwbO/EWL5GrACaf1Ol3yRBELzmzA2C3FauCGOvOk
         oag9BqNOebaKWWameeTR77Tzld1stZHBPpAKgIFLjE0UoaUg0VU4Y2u0gTfnPpoOtj
         NKJjvTQz8U+1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEFt9F3452396;
        Mon, 17 Jun 2019 07:15:55 -0700
Date:   Mon, 17 Jun 2019 07:15:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-c2ba8a15f310d915f8748dd8324c91c82b12b5ff@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, bp@alien8.de, swood@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, bristot@redhat.com,
        mtosatti@redhat.com, mhiramat@kernel.org, jkosina@suse.cz,
        williams@redhat.com, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, crecklin@redhat.com
Reply-To: linux-kernel@vger.kernel.org, crecklin@redhat.com,
          jbaron@akamai.com, hpa@zytor.com, gregkh@linuxfoundation.org,
          williams@redhat.com, jpoimboe@redhat.com, mhiramat@kernel.org,
          jkosina@suse.cz, bristot@redhat.com, rostedt@goodmis.org,
          mtosatti@redhat.com, bp@alien8.de, tglx@linutronix.de,
          swood@redhat.com, torvalds@linux-foundation.org,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <acc891dbc2dbc9fd616dd680529a2337b1d1274c.1560325897.git.bristot@redhat.com>
References: <acc891dbc2dbc9fd616dd680529a2337b1d1274c.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] jump_label: Batch updates if arch supports it
Git-Commit-ID: c2ba8a15f310d915f8748dd8324c91c82b12b5ff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c2ba8a15f310d915f8748dd8324c91c82b12b5ff
Gitweb:     https://git.kernel.org/tip/c2ba8a15f310d915f8748dd8324c91c82b12b5ff
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:30 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:22 +0200

jump_label: Batch updates if arch supports it

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/acc891dbc2dbc9fd616dd680529a2337b1d1274c.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jump_label.h |  3 +++
 kernel/jump_label.c        | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..3526c0aee954 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -215,6 +215,9 @@ extern void arch_jump_label_transform(struct jump_entry *entry,
 				      enum jump_label_type type);
 extern void arch_jump_label_transform_static(struct jump_entry *entry,
 					     enum jump_label_type type);
+extern bool arch_jump_label_transform_queue(struct jump_entry *entry,
+					    enum jump_label_type type);
+extern void arch_jump_label_transform_apply(void);
 extern int jump_label_text_reserved(void *start, void *end);
 extern void static_key_slow_inc(struct static_key *key);
 extern void static_key_slow_dec(struct static_key *key);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index ca00ac10d9b9..df3008419a1d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -414,6 +414,7 @@ static bool jump_label_can_update(struct jump_entry *entry, bool init)
 	return true;
 }
 
+#ifndef HAVE_JUMP_LABEL_BATCH
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
@@ -424,6 +425,28 @@ static void __jump_label_update(struct static_key *key,
 			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
 }
+#else
+static void __jump_label_update(struct static_key *key,
+				struct jump_entry *entry,
+				struct jump_entry *stop,
+				bool init)
+{
+	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+
+		if (!jump_label_can_update(entry, init))
+			continue;
+
+		if (!arch_jump_label_transform_queue(entry, jump_label_type(entry))) {
+			/*
+			 * Queue is full: Apply the current queue and try again.
+			 */
+			arch_jump_label_transform_apply();
+			BUG_ON(!arch_jump_label_transform_queue(entry, jump_label_type(entry)));
+		}
+	}
+	arch_jump_label_transform_apply();
+}
+#endif
 
 void __init jump_label_init(void)
 {
