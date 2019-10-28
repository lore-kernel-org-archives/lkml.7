Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B320830
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfJ1LmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:42:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388603AbfJ1LmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:42:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP3PO-0001Kb-0E; Mon, 28 Oct 2019 12:42:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 902341C0081;
        Mon, 28 Oct 2019 12:42:01 +0100 (CET)
Date:   Mon, 28 Oct 2019 11:42:01 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] ubsan, x86: Annotate and allow
 __ubsan_handle_shift_out_of_bounds() in uaccess regions
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, cyphar@cyphar.com,
        keescook@chromium.org, linux@rasmusvillemoes.dk,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191021131149.GA19358@hirez.programming.kicks-ass.net>
References: <20191021131149.GA19358@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <157226292126.29376.1602879935081875165.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     9a50dcaf0416a43e1fe411dc61a99c8333c90119
Gitweb:        https://git.kernel.org/tip/9a50dcaf0416a43e1fe411dc61a99c8333c90119
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Oct 2019 15:11:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 10:43:00 +01:00

ubsan, x86: Annotate and allow __ubsan_handle_shift_out_of_bounds() in uaccess regions

The new check_zeroed_user() function uses variable shifts inside of a
user_access_begin()/user_access_end() section and that results in GCC
emitting __ubsan_handle_shift_out_of_bounds() calls, even though
through value range analysis it would be able to see that the UB in
question is impossible.

Annotate and whitelist this UBSAN function; continued use of
user_access_begin()/user_access_end() will undoubtedly result in
further uses of function.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cyphar@cyphar.com
Cc: keescook@chromium.org
Cc: linux@rasmusvillemoes.dk
Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Link: https://lkml.kernel.org/r/20191021131149.GA19358@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/ubsan.c           | 5 ++++-
 tools/objtool/check.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e7d3173..0c46811 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -374,9 +374,10 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 	struct type_descriptor *lhs_type = data->lhs_type;
 	char rhs_str[VALUE_LENGTH];
 	char lhs_str[VALUE_LENGTH];
+	unsigned long ua_flags = user_access_save();
 
 	if (suppress_report(&data->location))
-		return;
+		goto out;
 
 	ubsan_prologue(&data->location, &flags);
 
@@ -402,6 +403,8 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 			lhs_type->type_name);
 
 	ubsan_epilogue(&flags);
+out:
+	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3..f53d3c5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -481,6 +481,7 @@ static const char *uaccess_safe_builtin[] = {
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
 	"__ubsan_handle_type_mismatch_v1",
+	"__ubsan_handle_shift_out_of_bounds",
 	/* misc */
 	"csum_partial_copy_generic",
 	"__memcpy_mcsafe",
