Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F44C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C0oNfeKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfDSSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfDSSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIcC84384876
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:38:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIcC84384876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699094;
        bh=TCKc54tId747hgym/x7du8UVb1IBSjT2pkoDMuBjiRA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C0oNfeKp2j0aFXyPm+YoGdJq2o4LgZfzuWQ2Ac3OFe9GiIiB+GpKKHMxLvFI+r7m8
         LFMOXlxu/891XYEe3NDuGgbZCNAoIOY/6l0s4XtGMn+0nBs4G/BEYq3Cd9pqy1eOLn
         5i5/6+Ef6EQOasiAFbUO8nxleisyRTsRk3UnxsPLiXgZYMGQoL2Cje1XBT545aFIFi
         48dls6Zufdr+56jCeRX83yMTZSWmVSr9rj7vDJGLgvos/Jn8thHEHg2FAHRkQmr0DI
         9767UEdpWRCsOrf+TP6Vy9rOam6qeG6A6ykTrwouDSl7UUiquSeq02V0roHA/mioUa
         YgvPrzrPvgWzg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIcCZ2384872;
        Fri, 19 Apr 2019 11:38:12 -0700
Date:   Fri, 19 Apr 2019 11:38:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-ddbefdc167f3d492036e6b0babd11a350c3bd3e3@git.kernel.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com, crecklin@redhat.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, jkosina@suse.cz,
        mhiramat@kernel.org, jolsa@redhat.com, bristot@redhat.com,
        williams@redhat.com, jbaron@akamai.com, brgerst@gmail.com,
        luto@kernel.org, acme@redhat.com, swood@redhat.com,
        rostedt@goodmis.org, mtosatti@redhat.com, dvlasenk@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, williams@redhat.com,
          bristot@redhat.com, brgerst@gmail.com, jbaron@akamai.com,
          hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
          mhiramat@kernel.org, jkosina@suse.cz, gregkh@linuxfoundation.org,
          rostedt@goodmis.org, mtosatti@redhat.com, jolsa@redhat.com,
          dvlasenk@redhat.com, alexander.shishkin@linux.intel.com,
          swood@redhat.com, acme@redhat.com, luto@kernel.org,
          jpoimboe@redhat.com, tglx@linutronix.de, crecklin@redhat.com,
          peterz@infradead.org
In-Reply-To: <296d5a75c4aee4a957ee7923127c0604903f9daa.1545228276.git.bristot@redhat.com>
References: <296d5a75c4aee4a957ee7923127c0604903f9daa.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/jump_label: Move checking code away from
 __jump_label_transform()
Git-Commit-ID: ddbefdc167f3d492036e6b0babd11a350c3bd3e3
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

Commit-ID:  ddbefdc167f3d492036e6b0babd11a350c3bd3e3
Gitweb:     https://git.kernel.org/tip/ddbefdc167f3d492036e6b0babd11a350c3bd3e3
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

x86/jump_label: Move checking code away from __jump_label_transform()

Move the check of the current code, before updating an entry, to specialized
functions. No changes in the method, only code relocation.

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
Link: http://lkml.kernel.org/r/296d5a75c4aee4a957ee7923127c0604903f9daa.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 60 +++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f99bd26bd3f1..e443c43478eb 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,16 +35,53 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
+static inline void __jump_label_trans_check_enable(struct jump_entry *entry,
+						   enum jump_label_type type,
+						   const unsigned char *ideal_nop,
+						   int init)
+{
+	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+	const void *expect;
+	int line;
+
+	if (init) {
+		expect = default_nop; line = __LINE__;
+	} else {
+		expect = ideal_nop; line = __LINE__;
+	}
+
+	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+		bug_at((void *)jump_entry_code(entry), line);
+}
+
+static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
+						    enum jump_label_type type,
+						    union jump_code_union *jmp,
+						    int init)
+{
+	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+	const void *expect;
+	int line;
+
+	if (init) {
+		expect = default_nop; line = __LINE__;
+	} else {
+		expect = jmp->code; line = __LINE__;
+	}
+
+	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+		bug_at((void *)jump_entry_code(entry), line);
+}
+
+
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
 					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
 	union jump_code_union jmp;
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect, *code;
-	int line;
+	const void *code;
 
 	jmp.jump = 0xe9;
 	jmp.offset = jump_entry_target(entry) -
@@ -54,26 +91,13 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = ideal_nop; line = __LINE__;
-		}
-
+		__jump_label_trans_check_enable(entry, type, ideal_nop, init);
 		code = &jmp.code;
 	} else {
-		if (init) {
-			expect = default_nop; line = __LINE__;
-		} else {
-			expect = &jmp.code; line = __LINE__;
-		}
-
+		__jump_label_trans_check_disable(entry, type, &jmp, init);
 		code = ideal_nop;
 	}
 
-	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
-		bug_at((void *)jump_entry_code(entry), line);
-
 	/*
 	 * Make text_poke_bp() a default fallback poker.
 	 *
