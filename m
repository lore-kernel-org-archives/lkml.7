Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0C920896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfFLJ6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbfFLJ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 645087DD03;
        Wed, 12 Jun 2019 09:58:00 +0000 (UTC)
Received: from localhost.default (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D20B7836B;
        Wed, 12 Jun 2019 09:57:57 +0000 (UTC)
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
Subject: [PATCH V6 6/6] x86/jump_label: Batch jump label updates
Date:   Wed, 12 Jun 2019 11:57:31 +0200
Message-Id: <57b4caa654bad7e3b066301c9a9ae233dea065b5.1560325897.git.bristot@redhat.com>
In-Reply-To: <cover.1560325897.git.bristot@redhat.com>
References: <cover.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 09:58:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/include/asm/jump_label.h |  2 +
 arch/x86/kernel/jump_label.c      | 69 +++++++++++++++++++++++++++++++
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
index d3328062b8cf..7391d6d90bcf 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -110,6 +110,75 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	mutex_unlock(&text_mutex);
 }
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_patch_loc))
+static struct text_patch_loc tp_vec[TP_VEC_MAX];
+int tp_vec_nr = 0;
+
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
+{
+	struct text_patch_loc *tp;
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
+	 * The int3 handler will do a bsearch in the queue, so we need entries
+	 * to be sorted. We can survive an unsorted list by rejecting the entry,
+	 * forcing the generic jump_label code to apply the queue. Warning once,
+	 * to raise the attention to the case of an unsorted entry that is
+	 * better not happen, because, in the worst case we will perform in the
+	 * same way as we do without batching - with some more overhead.
+	 */
+	if (tp_vec_nr > 0) {
+		int prev = tp_vec_nr - 1;
+		struct text_patch_loc *prev_tp = &tp_vec[prev];
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
-- 
2.20.1

