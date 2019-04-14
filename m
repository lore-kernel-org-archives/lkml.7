Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D9C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A520850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfDNUmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:42:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:42:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKgGvu2690044
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:42:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKgFpp2690041;
        Sun, 14 Apr 2019 13:42:15 -0700
Date:   Sun, 14 Apr 2019 13:42:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-ead97a49ec3a3cb9b5133acbfed9a49b91ebf37c@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        aryabinin@virtuozzo.com, luto@kernel.org, glider@google.com,
        tglx@linutronix.de, rostedt@goodmis.org, dvyukov@google.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, jpoimboe@redhat.com, mingo@kernel.org,
          aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
          tglx@linutronix.de, rostedt@goodmis.org, dvyukov@google.com
In-Reply-To: <20190410103644.750219625@linutronix.de>
References: <20190410103644.750219625@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/kasan: Remove the ULONG_MAX stack trace
 hackery
Git-Commit-ID: ead97a49ec3a3cb9b5133acbfed9a49b91ebf37c
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

Commit-ID:  ead97a49ec3a3cb9b5133acbfed9a49b91ebf37c
Gitweb:     https://git.kernel.org/tip/ead97a49ec3a3cb9b5133acbfed9a49b91ebf37c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:31 +0200

mm/kasan: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Link: https://lkml.kernel.org/r/20190410103644.750219625@linutronix.de

---
 mm/kasan/common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 80bbe62b16cd..38e5f20a775a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -74,9 +74,6 @@ static inline depot_stack_handle_t save_stack(gfp_t flags)
 
 	save_stack_trace(&trace);
 	filter_irq_stacks(&trace);
-	if (trace.nr_entries != 0 &&
-	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
-		trace.nr_entries--;
 
 	return depot_save_stack(&trace, flags);
 }
