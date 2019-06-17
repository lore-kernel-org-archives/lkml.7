Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50137C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CEvPQfAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfFQORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:17:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:17:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEGb1l3452484
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:16:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEGb1l3452484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780998;
        bh=rlKpGCYloCpmgmr8Oy56Sj+JOtl9+BZDTSNa68QN37E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CEvPQfAvW2wUa0q+uzU1zKrjDFwiB+ZF1X8iy3uQZjRuOfnbgOQkoP5ID+F7VHfNe
         xkhkb+IENxWrvN2oRU0iGnUdwVsA4JfoGD93q1noxDgHQVfkwGXATbd92Sp+iyJxYc
         vpaC6Rs+bBDDBI3fbdal/Bb1Ed1THdi2wvwI9yIoB5wzZfYG7FuZMlkLLPQMtDE5U6
         NqXOypW304qCEE2HUPyYpk66nhVg2qgbNKWdN6/rNOBm1obv7Rdnxdfi8bixOJmMjt
         +lE6t9LkJfk/1yui4UjkKeaeb/iOUjK8hURccG5LXk5LTYHQwKq2JGEfayWznThWT/
         FVy1LWNzmv1Hw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEGbvs3452481;
        Mon, 17 Jun 2019 07:16:37 -0700
Date:   Mon, 17 Jun 2019 07:16:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-ba54f0c3f7c400a392c413d8ca21d3ada35f2584@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com, bp@alien8.de, bristot@redhat.com,
        mtosatti@redhat.com, swood@redhat.com, mhiramat@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        crecklin@redhat.com, torvalds@linux-foundation.org,
        jkosina@suse.cz, williams@redhat.com
Reply-To: mhiramat@kernel.org, swood@redhat.com, jpoimboe@redhat.com,
          crecklin@redhat.com, linux-kernel@vger.kernel.org,
          jkosina@suse.cz, torvalds@linux-foundation.org,
          williams@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          rostedt@goodmis.org, peterz@infradead.org,
          gregkh@linuxfoundation.org, jbaron@akamai.com, mingo@kernel.org,
          bristot@redhat.com, bp@alien8.de, mtosatti@redhat.com
In-Reply-To: <57b4caa654bad7e3b066301c9a9ae233dea065b5.1560325897.git.bristot@redhat.com>
References: <57b4caa654bad7e3b066301c9a9ae233dea065b5.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] x86/jump_label: Batch jump label updates
Git-Commit-ID: ba54f0c3f7c400a392c413d8ca21d3ada35f2584
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

Commit-ID:  ba54f0c3f7c400a392c413d8ca21d3ada35f2584
Gitweb:     https://git.kernel.org/tip/ba54f0c3f7c400a392c413d8ca21d3ada35f2584
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:31 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:23 +0200

x86/jump_label: Batch jump label updates

Currently, the jump label of a static key is transformed via the arch
specific function:

    void arch_jump_label_transform(struct jump_entry *entry,
                                   enum jump_label_type type)

The new approach (batch mode) uses two arch functions, the first has the
same arguments of the arch_jump_label_transform(), and is the function:

    bool arch_jump_label_transform_queue(struct jump_entry *entry,
                                         enum jump_label_type type)

Rather than transforming the code, it adds the jump_entry in a queue of
entries to be updated. This functions returns true in the case of a
successful enqueue of an entry. If it returns false, the caller must to
apply the queue and then try to queue again, for instance, because the
queue is full.

This function expects the caller to sort the entries by the address before
enqueueuing then. This is already done by the arch independent code, though.

After queuing all jump_entries, the function:

    void arch_jump_label_transform_apply(void)

Applies the changes in the queue.

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
Link: https://lkml.kernel.org/r/57b4caa654bad7e3b066301c9a9ae233dea065b5.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/jump_label.h |  2 ++
 arch/x86/kernel/jump_label.c      | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..06c3cc22a058 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
+#define HAVE_JUMP_LABEL_BATCH
+
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f33408f1c3f6..ea13808bf6da 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -101,6 +101,75 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	mutex_unlock(&text_mutex);
 }
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
+static struct text_poke_loc tp_vec[TP_VEC_MAX];
+int tp_vec_nr = 0;
+
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
+{
+	struct text_poke_loc *tp;
+	void *entry_code;
+
+	if (system_state == SYSTEM_BOOTING) {
+		/*
+		 * Fallback to the non-batching mode.
+		 */
+		arch_jump_label_transform(entry, type);
+		return true;
+	}
+
+	/*
+	 * No more space in the vector, tell upper layer to apply
+	 * the queue before continuing.
+	 */
+	if (tp_vec_nr == TP_VEC_MAX)
+		return false;
+
+	tp = &tp_vec[tp_vec_nr];
+
+	entry_code = (void *)jump_entry_code(entry);
+
+	/*
+	 * The INT3 handler will do a bsearch in the queue, so we need entries
+	 * to be sorted. We can survive an unsorted list by rejecting the entry,
+	 * forcing the generic jump_label code to apply the queue. Warning once,
+	 * to raise the attention to the case of an unsorted entry that is
+	 * better not happen, because, in the worst case we will perform in the
+	 * same way as we do without batching - with some more overhead.
+	 */
+	if (tp_vec_nr > 0) {
+		int prev = tp_vec_nr - 1;
+		struct text_poke_loc *prev_tp = &tp_vec[prev];
+
+		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
+			return false;
+	}
+
+	__jump_label_set_jump_code(entry, type,
+				   (union jump_code_union *) &tp->opcode, 0);
+
+	tp->addr = entry_code;
+	tp->detour = entry_code + JUMP_LABEL_NOP_SIZE;
+	tp->len = JUMP_LABEL_NOP_SIZE;
+
+	tp_vec_nr++;
+
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	if (!tp_vec_nr)
+		return;
+
+	mutex_lock(&text_mutex);
+	text_poke_bp_batch(tp_vec, tp_vec_nr);
+	mutex_unlock(&text_mutex);
+
+	tp_vec_nr = 0;
+}
+
 static enum {
 	JL_STATE_START,
 	JL_STATE_NO_UPDATE,
