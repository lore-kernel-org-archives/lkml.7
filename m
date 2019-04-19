Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53F8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABCF205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tbOTq2zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfDSSjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfDSSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIbOxQ384772
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:37:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIbOxQ384772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699045;
        bh=qhfzhDsUYm+ropBQrcfCGmoyoJH6fuWuP0UnMUJk6WM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tbOTq2zodLczYof3nSiYR066wl6HQEXf/sYcyu/W40zdhmeebK12x+8lZJaPK3Zr2
         fsfsxQsSD2nuUHvYHo7M4uzjDkY/sbqC+M+Un39t/NMZcClOGJMCQWXAeNF4SQHglz
         V11nNXPXgbKJEKmhWn+i5SnZtQvp/bbLYLD/VdMNO6W03N6vJe9Z/SP8sja10LUYoD
         8MT5LiZaFobl0Nr67ece3nX7CcHi+2//MHoCzs8HADLmhrIYDv5yX0QepIpHR9XICl
         48l5lZQ3NQKX3j4oaG0NlRs/MhoP3iZmSAoEBFKvDPh7cgLSC8brrYBS646J30GczN
         yJu6Iv0PSsfew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIbOgD384769;
        Fri, 19 Apr 2019 11:37:24 -0700
Date:   Fri, 19 Apr 2019 11:37:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-41bef31d0abe29b5888b33b526cacc8a30795318@git.kernel.org>
Cc:     jkosina@suse.cz, linux-kernel@vger.kernel.org, jbaron@akamai.com,
        mhiramat@kernel.org, dvlasenk@redhat.com, bristot@redhat.com,
        mingo@kernel.org, hpa@zytor.com, brgerst@gmail.com,
        swood@redhat.com, peterz@infradead.org, acme@redhat.com,
        luto@kernel.org, alexander.shishkin@linux.intel.com,
        jpoimboe@redhat.com, crecklin@redhat.com, tglx@linutronix.de,
        jolsa@redhat.com, rostedt@goodmis.org,
        torvalds@linux-foundation.org, williams@redhat.com,
        gregkh@linuxfoundation.org, mtosatti@redhat.com, bp@alien8.de
Reply-To: peterz@infradead.org, swood@redhat.com, brgerst@gmail.com,
          hpa@zytor.com, mingo@kernel.org, bristot@redhat.com,
          alexander.shishkin@linux.intel.com, luto@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, jkosina@suse.cz,
          dvlasenk@redhat.com, mhiramat@kernel.org, jbaron@akamai.com,
          mtosatti@redhat.com, gregkh@linuxfoundation.org,
          williams@redhat.com, bp@alien8.de, jolsa@redhat.com,
          tglx@linutronix.de, crecklin@redhat.com, jpoimboe@redhat.com,
          torvalds@linux-foundation.org, rostedt@goodmis.org
In-Reply-To: <1e758cd3b2206be96091a57a17b26585e94792b6.1545228276.git.bristot@redhat.com>
References: <1e758cd3b2206be96091a57a17b26585e94792b6.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] jump_label: Add the
 jump_label_can_update_check() helper
Git-Commit-ID: 41bef31d0abe29b5888b33b526cacc8a30795318
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

Commit-ID:  41bef31d0abe29b5888b33b526cacc8a30795318
Gitweb:     https://git.kernel.org/tip/41bef31d0abe29b5888b33b526cacc8a30795318
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:27 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

jump_label: Add the jump_label_can_update_check() helper

Move the check of if a jump_entry is valid to a specific function. No
functional change.

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
Link: http://lkml.kernel.org/r/1e758cd3b2206be96091a57a17b26585e94792b6.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 288d630da22d..456c0d7cbb5b 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -374,22 +374,32 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 	return enabled ^ branch;
 }
 
+bool jump_label_can_update_check(struct jump_entry *entry, bool init)
+{
+	/*
+	 * An entry->code of 0 indicates an entry which has been
+	 * disabled because it was in an init text area.
+	 */
+	if (init || !jump_entry_is_init(entry)) {
+		if (!kernel_text_address(jump_entry_code(entry))) {
+			WARN_ONCE(1, "can't patch jump_label at %pS",
+				  (void *)jump_entry_code(entry));
+			return 0;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
 				bool init)
 {
 	for_each_label_entry(key, entry, stop) {
-		/*
-		 * An entry->code of 0 indicates an entry which has been
-		 * disabled because it was in an init text area.
-		 */
-		if (init || !jump_entry_is_init(entry)) {
-			if (kernel_text_address(jump_entry_code(entry)))
-				arch_jump_label_transform(entry, jump_label_type(entry));
-			else
-				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)jump_entry_code(entry));
+		if (jump_label_can_update_check(entry, init)) {
+			arch_jump_label_transform(entry,
+						  jump_label_type(entry));
 		}
 	}
 }
