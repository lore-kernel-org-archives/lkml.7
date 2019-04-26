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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059FEC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2F02087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYKIYvXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfD0GpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:45:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34643 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfD0GnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so1651968pgt.1;
        Fri, 26 Apr 2019 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4ax2hOd4Buhijx/oNSuXPhWpslJbmlh2LJYha9eHFk=;
        b=RYKIYvXmL5tJ4u/bU0iLk60YO+Ox59zCcKmrYcUn0L0mc7KUA8ZtJ2R4XNYjQk2a8B
         DcQM399thIjNSjXHuZQ6k7afM/SMh1l1QYkf2D0hRQ+1xwvUSHZnrIJ4UJtkR2NL1yLe
         l1RYwwd0hroNUCsKi5IV5ZZNm8YzK8J7h42F1sPN4gG9Y1ehTjsd+VC718e5LdQep+gS
         k/OhJCSCkHRbcX+8zk8NtqDpMNtIV6Cqdz0zcbSsIjK/yzdPAJzadIJkFTsIuXX0ujKs
         CagOndVrfBrJnKlvTuPVqrDmZeIo9JxoUR6B70xI9bSBAuYLVmprrE1fKIlJc4O0C9hS
         uf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4ax2hOd4Buhijx/oNSuXPhWpslJbmlh2LJYha9eHFk=;
        b=rSaTzuCf2BuOwLUgzt+pfo/Yj6lrJQJQHQOcSt5ZFaWenlhTmX/2oYyOA366c3XPsy
         dEjDNUyo1FKmTO+aVeUMnvhmxjgb2wl7UlDp2WR7O/pAxmdu6RAf9FRD3afL85ehZqbl
         RL0JmYcqgRzwL6+5mibSQXBhtMG0VW5jZYUVT9v2DgjR/3ueOoUITHkVNzgzSBQmkD6N
         xOrAg0mQF5psZsX/mjdCvtAbYC8x10BC7Apd0eWqfDBO/ths6spjwHTuIKGQB3BhaP5a
         54O5DWRC1f313n3uX6a/xdCS60UIKYC8dq3rnNDFnD/tQtqRM1XHe16xfVazH2jBszLN
         3pYQ==
X-Gm-Message-State: APjAAAVmA/gtp8uCQEe0f+B0IXzT5u0yIw4mpyrmJmQls+1YkuHxleen
        s+VI4Bwc/TSh1s3uzIqOKd8=
X-Google-Smtp-Source: APXvYqzYil+3Ftso1TWpSV8095HGNQL/URTfcLD+HpGX4LAA48WZkM07V5HZ0EJt2GuXBL8qYa+EnA==
X-Received: by 2002:a63:b0b:: with SMTP id 11mr12676888pgl.445.1556347385725;
        Fri, 26 Apr 2019 23:43:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:05 -0700 (PDT)
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
Subject: [PATCH v6 02/24] x86/jump_label: Use text_poke_early() during early init
Date:   Fri, 26 Apr 2019 16:22:41 -0700
Message-Id: <20190426232303.28381-3-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

There is no apparent reason not to use text_poke_early() during
early-init, since no patching of code that might be on the stack is done
and only a single core is running.

This is required for the next patches that would set a temporary mm for
text poking, and this mm is only initialized after some static-keys are
enabled/disabled.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/jump_label.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f99bd26bd3f1..e7d8c636b228 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -50,7 +50,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	if (early_boot_irqs_disabled)
+	/*
+	 * As long as only a single processor is running and the code is still
+	 * not marked as RO, text_poke_early() can be used; Checking that
+	 * system_state is SYSTEM_BOOTING guarantees it.
+	 */
+	if (system_state == SYSTEM_BOOTING)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
-- 
2.17.1

