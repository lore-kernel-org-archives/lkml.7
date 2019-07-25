Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8417C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91890229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="u8MhPja8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbfGYQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:09:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389618AbfGYQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:09:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG9OeX1073997
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:09:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG9OeX1073997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070965;
        bh=9SG7t/RY018saHj3Z1m4ZVOailUC1xrgcrB5xVaf+Hg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=u8MhPja8rUqGbbPrt0vFgWJbo2rPzCZ4Crew2zA+00w2KdhK5w4eGcYyqx+Tt63zf
         WgDUHX0lQ+2lOFifbhqWIY5Q1Kr/H/6/V2JenILYAmOuZc7GY4qOwGVGSLiJ+htjoP
         cTu8PWYTZbbGfKDt6odzPm0WW7/3DAqaHUx8NAd5Gvm/hy5KCS5vDqwJ49oYYNOoQU
         h5r4Tv0CcTfIdhaD5SQbPGsZgjTs/11puwwww1c0LFd6cFQP3JgnJ0C+h49su8MQ4y
         2vaAP+KWDpcKoTQbtD+7zIfEEeJRqkdnu7BlAAi3ZJCd8IeAB6KyLd7Fl10ksdSnSp
         VdaH0YmNGDtMg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG9Ofm1073994;
        Thu, 25 Jul 2019 09:09:24 -0700
Date:   Thu, 25 Jul 2019 09:09:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-a2970421640bd9b6a78f2685d7750a791abdfd4e@git.kernel.org>
Cc:     mingo@kernel.org, will.deacon@arm.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: longman@redhat.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bvanassche@acm.org,
          will.deacon@arm.com, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190722182443.216015-3-bvanassche@acm.org>
References: <20190722182443.216015-3-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] stacktrace: Constify 'entries' arguments
Git-Commit-ID: a2970421640bd9b6a78f2685d7750a791abdfd4e
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

Commit-ID:  a2970421640bd9b6a78f2685d7750a791abdfd4e
Gitweb:     https://git.kernel.org/tip/a2970421640bd9b6a78f2685d7750a791abdfd4e
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 22 Jul 2019 11:24:41 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:43:26 +0200

stacktrace: Constify 'entries' arguments

Make it clear to humans and to the compiler that the stack trace
('entries') arguments are not modified.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190722182443.216015-3-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/stacktrace.h | 4 ++--
 kernel/stacktrace.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index f0cfd12cb45e..83bd8cb475d7 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -9,9 +9,9 @@ struct task_struct;
 struct pt_regs;
 
 #ifdef CONFIG_STACKTRACE
-void stack_trace_print(unsigned long *trace, unsigned int nr_entries,
+void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
 		       int spaces);
-int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces);
 unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 			      unsigned int skipnr);
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f5440abb7532..6d1f68b7e528 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -20,7 +20,7 @@
  * @nr_entries:	Number of entries in the storage array
  * @spaces:	Number of leading spaces to print
  */
-void stack_trace_print(unsigned long *entries, unsigned int nr_entries,
+void stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
 		       int spaces)
 {
 	unsigned int i;
@@ -43,7 +43,7 @@ EXPORT_SYMBOL_GPL(stack_trace_print);
  *
  * Return: Number of bytes printed.
  */
-int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces)
 {
 	unsigned int generated, i, total = 0;
