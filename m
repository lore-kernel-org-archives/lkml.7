Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A4C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5933205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JCCmw2v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfDSSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:44:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfDSSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:44:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIg7VW385821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:42:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIg7VW385821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699329;
        bh=m+8R/uc5aqy+TanhPsQcbUzmeYZkGXLyWbX4WzohkEE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JCCmw2v+N6ISdRXBkBsosyjZCBRnPncMYJmfXqy80M87CawhE/dw7nN6LP5VChFwO
         aE9D+H8vf02vN27yKFT3JVsEL45geOp2YLYKX72PS4kOL8oFVLCXb79W8DvRDvCOCX
         D6iuj5ZMKD068queKIsLQq9iN2VyRI5N1IdrgBi+KmCw3kFtm+VznpIzybtBp6NWIT
         oYDiLc2wlybwdUiwinG+IYN3hKkMtk+6jW66+MVLfyyTqszU78C9uM5WN4jZDhJ4K/
         XIwTJM6NrrjS3pBV3Zb5NZrTk1kwa6SWOfUG0f3zGuIOxuDpuaXpz1vxuPCjyrisX9
         HGFk+9qKXdPaw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIg72G385818;
        Fri, 19 Apr 2019 11:42:07 -0700
Date:   Fri, 19 Apr 2019 11:42:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-9f4a3121e69d4e93cde30d1a274bd877f58e6b0a@git.kernel.org>
Cc:     brgerst@gmail.com, jolsa@redhat.com, mtosatti@redhat.com,
        alexander.shishkin@linux.intel.com, jbaron@akamai.com,
        bp@alien8.de, torvalds@linux-foundation.org, jkosina@suse.cz,
        rostedt@goodmis.org, acme@redhat.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, williams@redhat.com, swood@redhat.com,
        peterz@infradead.org, bristot@redhat.com, dvlasenk@redhat.com,
        hpa@zytor.com, mingo@kernel.org, jpoimboe@redhat.com,
        luto@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        crecklin@redhat.com
Reply-To: jolsa@redhat.com, mtosatti@redhat.com, brgerst@gmail.com,
          williams@redhat.com, gregkh@linuxfoundation.org,
          tglx@linutronix.de, rostedt@goodmis.org, jkosina@suse.cz,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          jbaron@akamai.com, bp@alien8.de, torvalds@linux-foundation.org,
          mingo@kernel.org, jpoimboe@redhat.com, dvlasenk@redhat.com,
          bristot@redhat.com, hpa@zytor.com, swood@redhat.com,
          peterz@infradead.org, crecklin@redhat.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          mhiramat@kernel.org
In-Reply-To: <b39e5320498f144410d2cf85a8bd9b079302c10a.1545228276.git.bristot@redhat.com>
References: <b39e5320498f144410d2cf85a8bd9b079302c10a.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] jump_label: Batch updates if arch supports
 it
Git-Commit-ID: 9f4a3121e69d4e93cde30d1a274bd877f58e6b0a
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

Commit-ID:  9f4a3121e69d4e93cde30d1a274bd877f58e6b0a
Gitweb:     https://git.kernel.org/tip/9f4a3121e69d4e93cde30d1a274bd877f58e6b0a
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:33 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:35 +0200

jump_label: Batch updates if arch supports it

If the architecture supports the batching of jump label updates, use it!

An easy way to see the benefits of this patch is switching the
schedstats on and off. For instance:

-------------------------- %< ----------------------------

while [ true ]; do
    sysctl -w kernel.sched_schedstats=1
    sleep 2
    sysctl -w kernel.sched_schedstats=0
    sleep 2
done
-------------------------- >% ----------------------------

while watching the IPI count:

-------------------------- %< ----------------------------
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/b39e5320498f144410d2cf85a8bd9b079302c10a.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jump_label.h |  3 +++
 kernel/jump_label.c        | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 53b7c85c0b09..944c75a0b09b 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -407,6 +407,7 @@ bool jump_label_can_update_check(struct jump_entry *entry, bool init)
 	return 0;
 }
 
+#ifndef HAVE_JUMP_LABEL_BATCH
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
@@ -419,6 +420,34 @@ static void __jump_label_update(struct static_key *key,
 		}
 	}
 }
+#else
+static void __jump_label_update(struct static_key *key,
+				struct jump_entry *entry,
+				struct jump_entry *stop,
+				bool init)
+{
+	for_each_label_entry(key, entry, stop) {
+
+		if (!jump_label_can_update_check(entry, init))
+			continue;
+
+		if (arch_jump_label_transform_queue(entry,
+						    jump_label_type(entry)))
+			continue;
+
+		/*
+		 * Queue's overflow: Apply the current queue, and then
+		 * queue again. If it stills not possible to queue, BUG!
+		 */
+		arch_jump_label_transform_apply();
+		if (!arch_jump_label_transform_queue(entry,
+						     jump_label_type(entry))) {
+			BUG();
+		}
+	}
+	arch_jump_label_transform_apply();
+}
+#endif
 
 void __init jump_label_init(void)
 {
