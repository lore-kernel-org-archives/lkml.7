Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B47BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3952720645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X8DMqnit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfDSSoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:44:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDSSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:44:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIgqka385896
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:42:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIgqka385896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699374;
        bh=4on0OWQ2nXU+eHXkuB3p+IonPb9C+Pn0U+Dqfp6nx0U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X8DMqnitotsDOY1CHYP3L7f7A6dxmtUNtpf4XHZvipGxwsUgSM+1qIpPJfCvIfxKh
         QRPAcEHxBMYDitMsbwGqU9SXQKhOqkdvICOIjmQ7BV6bkJiz31FokX4kmnr2z4zySf
         /AM14x3z0CzUtVRBRdwVTSFk6Vep6kDhE1cs+2B0yWKJOrb22R1d4r6O1y4DFm9BU2
         QL3mxR6GjtDXYe2bLRSkgP8xdNx8FjNSkCfVwO4c4S7HN5/9wmEeSHNaBUjAS8lVaM
         ebozK5i/qywgAnHAVvSIqu8QG9pd+Urg/tbhizss0SAgEZ8OQqEoBBsjNMoYQFgeYi
         QBdp/BvW6TEQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIgqqd385893;
        Fri, 19 Apr 2019 11:42:52 -0700
Date:   Fri, 19 Apr 2019 11:42:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-1f30946b1a01baf22df6faf74c0a1e602bb6cac7@git.kernel.org>
Cc:     hpa@zytor.com, jbaron@akamai.com, tglx@linutronix.de,
        brgerst@gmail.com, jpoimboe@redhat.com, dvlasenk@redhat.com,
        luto@kernel.org, acme@redhat.com, bp@alien8.de, bristot@redhat.com,
        jkosina@suse.cz, swood@redhat.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        crecklin@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, jolsa@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, williams@redhat.com
Reply-To: williams@redhat.com, rostedt@goodmis.org, mtosatti@redhat.com,
          mhiramat@kernel.org, gregkh@linuxfoundation.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, peterz@infradead.org,
          torvalds@linux-foundation.org, crecklin@redhat.com,
          jkosina@suse.cz, mingo@kernel.org, swood@redhat.com,
          bp@alien8.de, bristot@redhat.com, dvlasenk@redhat.com,
          luto@kernel.org, acme@redhat.com, hpa@zytor.com,
          jpoimboe@redhat.com, brgerst@gmail.com, jbaron@akamai.com,
          tglx@linutronix.de
In-Reply-To: <a7ff8be5f195e72d69b8a1689d13d3995056994c.1545228276.git.bristot@redhat.com>
References: <a7ff8be5f195e72d69b8a1689d13d3995056994c.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/jump_label: Batch jump label updates
Git-Commit-ID: 1f30946b1a01baf22df6faf74c0a1e602bb6cac7
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

Commit-ID:  1f30946b1a01baf22df6faf74c0a1e602bb6cac7
Gitweb:     https://git.kernel.org/tip/1f30946b1a01baf22df6faf74c0a1e602bb6cac7
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:34 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:35 +0200

x86/jump_label: Batch jump label updates

Currently, the jump label of a static key is transformed via the arch
specific function:

    void arch_jump_label_transform(struct jump_entry *entry,
                                   enum jump_label_type type)

The new approach (batch mode) uses two arch functions, the first has the
same arguments of the arch_jump_label_transform(), and is the function:

    void arch_jump_label_transform_queue(struct jump_entry *entry,
					 enum jump_label_type type)

Rather than transforming the code, it adds the jump_entry in a queue of
entries to be updated. This functions returns 1 in the case of a
successful enqueue of an entry. If it returns 0, the caller must to
apply the queue and then try to queue again, for instance, because the
queue is full.

This function expects the caller to sort the entries by the address before
enqueueuing then. This is already done by the arch independent code, though.

After queuing all jump_entries, the function:

    void arch_jump_label_transform_apply(void)

Applies the changes in the queue.

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
Link: http://lkml.kernel.org/r/a7ff8be5f195e72d69b8a1689d13d3995056994c.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/jump_label.h |  2 +
 arch/x86/kernel/jump_label.c      | 88 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

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
index 2ef687db5a87..3c81cf8f06ca 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -15,6 +15,7 @@
 #include <asm/kprobes.h>
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
+#include <linux/slab.h>
 
 union jump_code_union {
 	char code[JUMP_LABEL_NOP_SIZE];
@@ -130,6 +131,93 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	mutex_unlock(&text_mutex);
 }
 
+struct text_to_poke *entry_vector;
+unsigned int entry_vector_max_elem __read_mostly;
+unsigned int entry_vector_nr_elem;
+
+void arch_jump_label_init(void)
+{
+	entry_vector = (void *) __get_free_page(GFP_KERNEL);
+
+	if (WARN_ON_ONCE(!entry_vector))
+		return;
+
+	entry_vector_max_elem = PAGE_SIZE / sizeof(struct text_to_poke);
+	return;
+}
+
+int arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
+{
+	void *entry_code;
+	struct text_to_poke *tp;
+
+	/*
+	 * Batch mode disabled before being able to allocate memory:
+	 * Fallback to the non-batching mode.
+	 */
+	if (unlikely(!entry_vector_max_elem)) {
+		if (!slab_is_available() || early_boot_irqs_disabled)
+			goto fallback;
+
+		arch_jump_label_init();
+	}
+
+	/*
+	 * No more space in the vector, tell upper layer to apply
+	 * the queue before continuing.
+	 */
+	if (entry_vector_nr_elem == entry_vector_max_elem)
+		return 0;
+
+	tp = &entry_vector[entry_vector_nr_elem];
+
+	entry_code = (void *)jump_entry_code(entry);
+
+	/*
+	 * The int3 handler will do a bsearch in the queue, so we need entries
+	 * to be sorted. We can survive an unsorted list by rejecting the entry,
+	 * forcing the generic jump_label code to apply the queue. Warning once,
+	 * to raise the attention to the case of an unsorted entry that is
+	 * better not happen, because, in the worst case we will perform in the
+	 * same way as we do without batching - with some more overhead.
+	 */
+	if (entry_vector_nr_elem > 0) {
+		int prev_idx = entry_vector_nr_elem - 1;
+		struct text_to_poke *prev_tp = &entry_vector[prev_idx];
+
+		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
+			return 0;
+	}
+
+	__jump_label_set_jump_code(entry, type,
+				   (union jump_code_union *) &tp->opcode, 0);
+
+	tp->addr = entry_code;
+	tp->handler = entry_code + JUMP_LABEL_NOP_SIZE;
+	tp->len = JUMP_LABEL_NOP_SIZE;
+
+	entry_vector_nr_elem++;
+
+	return 1;
+
+fallback:
+	arch_jump_label_transform(entry, type);
+	return 1;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	if (early_boot_irqs_disabled || !entry_vector_nr_elem)
+		return;
+
+	mutex_lock(&text_mutex);
+	text_poke_bp_batch(entry_vector, entry_vector_nr_elem);
+	mutex_unlock(&text_mutex);
+
+	entry_vector_nr_elem = 0;
+}
+
 static enum {
 	JL_STATE_START,
 	JL_STATE_NO_UPDATE,
