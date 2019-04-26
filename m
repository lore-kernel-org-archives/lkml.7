Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B2C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF3208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhMsROzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfD0Gob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:44:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42643 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfD0GnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so2743913pfi.9;
        Fri, 26 Apr 2019 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3nO4xFM3yb0X+OIqTEtEp6LbffMj61RqStKCNeSSiM=;
        b=IhMsROzOX/uvsuQybijdR85Kqaxq4yWzjUoagIOqk1LVY6OLTEXQbjBmXHD5WxbAzP
         cmCoo1zMlycyEW/HfwZCgn/X+0dMFPFHyqqtEUKq6AZF6jWZrRVIUAiE8jxYjY0M9MT3
         Ik7ZKhQeM7kg+3gB06XcTjx2xBZpPGhS55GH7o8s674YL85Zg5fEINa05kjxM9iG+Kfo
         SEIwp8JxZ7vs+rhoqI+mg8MouUQf2Zul6cu4rspQPkk8FxQa/9RXPXX4OwkD3jy0+Z/+
         SBrns4/qvGYQvjrl9OPoH7DBVBfA0arFpsKvUBwFWEn4L2+Z7qiKOGh0M4x1w7s8Fe9M
         Y7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3nO4xFM3yb0X+OIqTEtEp6LbffMj61RqStKCNeSSiM=;
        b=LUFmfSZcRq+o6XrAutLGr61MSM5f8+xjqQvDZdY2O1qFAEhVNEufDOesCgYVB3iQmE
         TR723i337mfyO0D9+Mub9sQroN/z1mftT81CHNlM5dkEWgtyubsvbPjN9yVItcrwEx20
         KvTaMsBVuqUrXLPE4T/7fGBSVuih4EaD+0xanPHzTvG8BIa5iCosgDwPPlhS9GyDeosK
         h730Fy7kU9neldz2zWERUdfI1P5pmQq5hHndWLYq0qNwZ93NekPgy341Ll74aEFlVrm5
         rrHRnlQFX9uVI7nSDdQwTG8lAdvNR7fBdcpvtMZRnbaoyNEOJtz1scQ7OSXk+AAhbRvD
         Wj7Q==
X-Gm-Message-State: APjAAAXnQN31cyTgxJAnEdAGXpNYvf6AE3My6C33aEuXifLFEscPIXk/
        unDL4fowi5pWkRmoeSU/kB8=
X-Google-Smtp-Source: APXvYqyXozv8RJ3un5KRfku6J9oOZngaXmf1Y0t3bUJMwzL1TSTEhjmbFCgyEeDgaxJqumt2ZQ+7aA==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr50793424pfb.191.1556347403359;
        Fri, 26 Apr 2019 23:43:23 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:22 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 13/24] x86/jump-label: Remove support for custom poker
Date:   Fri, 26 Apr 2019 16:22:52 -0700
Message-Id: <20190426232303.28381-14-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There are only two types of poking: early and breakpoint based. The use
of a function pointer to perform poking complicates the code and is
probably inefficient due to the use of indirect branches.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/jump_label.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e7d8c636b228..e631c358f7f4 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -37,7 +37,6 @@ static void bug_at(unsigned char *ip, int line)
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
-					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
 	union jump_code_union jmp;
@@ -50,14 +49,6 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	/*
-	 * As long as only a single processor is running and the code is still
-	 * not marked as RO, text_poke_early() can be used; Checking that
-	 * system_state is SYSTEM_BOOTING guarantees it.
-	 */
-	if (system_state == SYSTEM_BOOTING)
-		poker = text_poke_early;
-
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			expect = default_nop; line = __LINE__;
@@ -80,16 +71,19 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		bug_at((void *)jump_entry_code(entry), line);
 
 	/*
-	 * Make text_poke_bp() a default fallback poker.
+	 * As long as only a single processor is running and the code is still
+	 * not marked as RO, text_poke_early() can be used; Checking that
+	 * system_state is SYSTEM_BOOTING guarantees it. It will be set to
+	 * SYSTEM_SCHEDULING before other cores are awaken and before the
+	 * code is write-protected.
 	 *
 	 * At the time the change is being done, just ignore whether we
 	 * are doing nop -> jump or jump -> nop transition, and assume
 	 * always nop being the 'currently valid' instruction
-	 *
 	 */
-	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
-			 JUMP_LABEL_NOP_SIZE);
+	if (init || system_state == SYSTEM_BOOTING) {
+		text_poke_early((void *)jump_entry_code(entry), code,
+				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
@@ -101,7 +95,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
 	mutex_lock(&text_mutex);
-	__jump_label_transform(entry, type, NULL, 0);
+	__jump_label_transform(entry, type, 0);
 	mutex_unlock(&text_mutex);
 }
 
@@ -131,5 +125,5 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, text_poke_early, 1);
+		__jump_label_transform(entry, type, 1);
 }
-- 
2.17.1

