Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hqg6nfQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfDSSki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:40:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35147 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfDSSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:40:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIdj2n385282
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:39:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIdj2n385282
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699186;
        bh=F46fXeY9WyHzw0pM51C9KmQDpKbLci+JlazHARzhQzU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hqg6nfQKSKS4iJY2tjZQOybeujdMDlGK2MyLhAkzr6r4376r9Yr+fNY5kpk8shwxe
         riMARnBbVZ/dj3iACH1+Kd6xffuAubvC+4z39nmxzhrdrQBXmbUgeqWazc2WaZNxPE
         y5x1U5MT0FjRqjx/rVnx05FCbI4wzkjYNUODHOKkCG6aMDtrSInla9IRd6ndletCBx
         Y5ePH+dG88S0ZmqvfVD5u1Ehz6BzcJk3xDImXIBXGywF7Ge9++gGV6TkrohBei0G6x
         Ww4+LkH8oGgV7nAr2zhInJJKY2k38G7SVlYkZ6TNX9I3UXE3XXmKGCntuKDjKwFcbf
         heSg/+JUEn2nA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIdiiK385278;
        Fri, 19 Apr 2019 11:39:44 -0700
Date:   Fri, 19 Apr 2019 11:39:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-6d2b0054d9a448d384264e003474219497e70bb9@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, jpoimboe@redhat.com,
        crecklin@redhat.com, williams@redhat.com, acme@redhat.com,
        bristot@redhat.com, alexander.shishkin@linux.intel.com,
        rostedt@goodmis.org, mingo@kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de, jkosina@suse.cz, mtosatti@redhat.com,
        peterz@infradead.org, brgerst@gmail.com, swood@redhat.com,
        jbaron@akamai.com, luto@kernel.org, gregkh@linuxfoundation.org,
        dvlasenk@redhat.com
Reply-To: peterz@infradead.org, swood@redhat.com, brgerst@gmail.com,
          jbaron@akamai.com, dvlasenk@redhat.com,
          gregkh@linuxfoundation.org, luto@kernel.org,
          alexander.shishkin@linux.intel.com, rostedt@goodmis.org,
          bristot@redhat.com, tglx@linutronix.de, mhiramat@kernel.org,
          mingo@kernel.org, jkosina@suse.cz, mtosatti@redhat.com,
          williams@redhat.com, acme@redhat.com, jolsa@redhat.com,
          hpa@zytor.com, bp@alien8.de, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, jpoimboe@redhat.com,
          crecklin@redhat.com
In-Reply-To: <67c326c50f8efa728d3040d3563f258949ff32c4.1545228276.git.bristot@redhat.com>
References: <67c326c50f8efa728d3040d3563f258949ff32c4.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/alternative: Split text_poke_bp() into
 tree steps
Git-Commit-ID: 6d2b0054d9a448d384264e003474219497e70bb9
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

Commit-ID:  6d2b0054d9a448d384264e003474219497e70bb9
Gitweb:     https://git.kernel.org/tip/6d2b0054d9a448d384264e003474219497e70bb9
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:30 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

x86/alternative: Split text_poke_bp() into tree steps

text_poke_bp() updates instructions on live kernel on SMP in three steps:
 1) add a int3 trap to the address that will be patched
 2) update all but the first byte of the patched range
 3) replace the first byte (int3) by the first byte of

This patch creates one function for each of these steps.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
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
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/67c326c50f8efa728d3040d3563f258949ff32c4.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9a79c7808f9c..7fce844017f1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -768,6 +768,29 @@ int poke_int3_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
+static void text_poke_bp_set_handler(void *addr, void *handler,
+				     unsigned char int3)
+{
+	bp_int3_handler = handler;
+	bp_int3_addr = (u8 *)addr + sizeof(int3);
+	text_poke(addr, &int3, sizeof(int3));
+}
+
+static void patch_all_but_first_byte(void *addr, const void *opcode,
+				     size_t len, unsigned char int3)
+{
+	/* patch all but the first byte */
+	text_poke((char *)addr + sizeof(int3),
+		  (const char *) opcode + sizeof(int3),
+		  len - sizeof(int3));
+}
+
+static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
+{
+	/* patch the first byte */
+	text_poke(addr, opcode, sizeof(int3));
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -792,27 +815,21 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
 
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
-	bp_patching_in_progress = true;
-
 	lockdep_assert_held(&text_mutex);
 
+	bp_patching_in_progress = true;
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * in_progress and handler are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
-	text_poke(addr, &int3, sizeof(int3));
+	text_poke_bp_set_handler(addr, handler, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
 	if (len - sizeof(int3) > 0) {
-		/* patch all but the first byte */
-		text_poke((char *)addr + sizeof(int3),
-			  (const char *) opcode + sizeof(int3),
-			  len - sizeof(int3));
+		patch_all_but_first_byte(addr, opcode, len, int3);
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -821,8 +838,7 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	/* patch the first byte */
-	text_poke(addr, opcode, sizeof(int3));
+	patch_first_byte(addr, opcode, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
