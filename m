Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE12AC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfDNUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:42:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:42:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKfYtC2689774
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:41:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKfXSr2689771;
        Sun, 14 Apr 2019 13:41:33 -0700
Date:   Sun, 14 Apr 2019 13:41:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4621c9858f05ab08434221e3a15cc8098645ef2a@git.kernel.org>
Cc:     glider@google.com, akpm@linux-foundation.org, hpa@zytor.com,
        jpoimboe@redhat.com, rppt@linux.vnet.ibm.com, mhocko@suse.com,
        rostedt@goodmis.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        luto@kernel.org, tglx@linutronix.de
Reply-To: rostedt@goodmis.org, peterz@infradead.org, luto@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mhocko@suse.com, jpoimboe@redhat.com,
          rppt@linux.vnet.ibm.com, glider@google.com,
          akpm@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20190410103644.661974663@linutronix.de>
References: <20190410103644.661974663@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/page_owner: Remove the ULONG_MAX stack
 trace hackery
Git-Commit-ID: 4621c9858f05ab08434221e3a15cc8098645ef2a
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

Commit-ID:  4621c9858f05ab08434221e3a15cc8098645ef2a
Gitweb:     https://git.kernel.org/tip/4621c9858f05ab08434221e3a15cc8098645ef2a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:30 +0200

mm/page_owner: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lkml.kernel.org/r/20190410103644.661974663@linutronix.de

---
 mm/page_owner.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 925b6f44a444..df277e6bc3c6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -148,9 +148,6 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	depot_stack_handle_t handle;
 
 	save_stack_trace(&trace);
-	if (trace.nr_entries != 0 &&
-	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
-		trace.nr_entries--;
 
 	/*
 	 * We need to check recursion here because our request to stackdepot
