Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C2CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99732204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jbsw4DkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfDSSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:40:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfDSSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:40:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIcxVq384955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:38:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIcxVq384955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699140;
        bh=CNht6t272tDNcceBwrS+DDl5XBg8a4NE821ISZMmD9g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Jbsw4DkL24ptjyaDZ+xr/OHxsFQcyrCHJbP32DlFG//0aFUBpDAtpu6BaNNca44nv
         +FC77pzUM8ZlqG7gaSZECrZrJPq1JdlhT4/hcomxsmjrFdViVZG2fHkl+tJmy+SAXM
         oHm/uK8CruJxfe+T5Xjrt0od3gQJfoao/JdZoH7oTrt4cDnFf18w1Sdk3yB4HCmNpE
         TzT+XymlNitZ6LZp43egOU6YRDXuNonKFhpzmh5F9GXiPwSf6+s8H5LAkmvMgyPFTu
         PkVXvgFWSyboEmRV5Ulp662guLoPgN+m7q25gK6Ulq/aAiXJmEsJZWUfLKzJB+S2q9
         gU/Nl7tgzahhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIcvwt384952;
        Fri, 19 Apr 2019 11:38:57 -0700
Date:   Fri, 19 Apr 2019 11:38:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-369670e583390ce7324ba3db988de09a7fceca93@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org, jolsa@redhat.com,
        dvlasenk@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jbaron@akamai.com, crecklin@redhat.com, bp@alien8.de,
        jkosina@suse.cz, bristot@redhat.com, swood@redhat.com,
        acme@redhat.com, mtosatti@redhat.com, brgerst@gmail.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, williams@redhat.com, luto@kernel.org,
        jpoimboe@redhat.com, mhiramat@kernel.org
Reply-To: mtosatti@redhat.com, brgerst@gmail.com,
          alexander.shishkin@linux.intel.com, bristot@redhat.com,
          swood@redhat.com, acme@redhat.com, jpoimboe@redhat.com,
          williams@redhat.com, luto@kernel.org, mhiramat@kernel.org,
          hpa@zytor.com, peterz@infradead.org, gregkh@linuxfoundation.org,
          torvalds@linux-foundation.org, jolsa@redhat.com,
          dvlasenk@redhat.com, mingo@kernel.org, rostedt@goodmis.org,
          tglx@linutronix.de, crecklin@redhat.com, jkosina@suse.cz,
          bp@alien8.de, jbaron@akamai.com, linux-kernel@vger.kernel.org
In-Reply-To: <eb97675f0d139aa6f78874db3abc81fcdba7a80f.1545228276.git.bristot@redhat.com>
References: <eb97675f0d139aa6f78874db3abc81fcdba7a80f.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/jump_label: Add
 __jump_label_set_jump_code() helper
Git-Commit-ID: 369670e583390ce7324ba3db988de09a7fceca93
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

Commit-ID:  369670e583390ce7324ba3db988de09a7fceca93
Gitweb:     https://git.kernel.org/tip/369670e583390ce7324ba3db988de09a7fceca93
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

x86/jump_label: Add __jump_label_set_jump_code() helper

Move the definition of the code to be written from
__jump_label_transform() to a specialized function. No change in the
method, code relocation only.

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
Link: http://lkml.kernel.org/r/eb97675f0d139aa6f78874db3abc81fcdba7a80f.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e443c43478eb..2ef687db5a87 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -73,30 +73,36 @@ static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
 		bug_at((void *)jump_entry_code(entry), line);
 }
 
+static void __jump_label_set_jump_code(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       union jump_code_union *code,
+				       int init)
+{
+	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+
+	code->jump = 0xe9;
+	code->offset = jump_entry_target(entry) -
+		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+
+	if (type == JUMP_LABEL_JMP) {
+		__jump_label_trans_check_enable(entry, type, ideal_nop, init);
+	} else {
+		__jump_label_trans_check_disable(entry, type, code, init);
+		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+	}
+}
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
 					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
-	union jump_code_union jmp;
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *code;
-
-	jmp.jump = 0xe9;
-	jmp.offset = jump_entry_target(entry) -
-		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	union jump_code_union code;
 
 	if (early_boot_irqs_disabled)
 		poker = text_poke_early;
 
-	if (type == JUMP_LABEL_JMP) {
-		__jump_label_trans_check_enable(entry, type, ideal_nop, init);
-		code = &jmp.code;
-	} else {
-		__jump_label_trans_check_disable(entry, type, &jmp, init);
-		code = ideal_nop;
-	}
+	__jump_label_set_jump_code(entry, type, &code, init);
 
 	/*
 	 * Make text_poke_bp() a default fallback poker.
@@ -107,12 +113,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
+		(*poker)((void *)jump_entry_code(entry), &code,
 			 JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
 		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
