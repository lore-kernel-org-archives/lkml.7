Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49F921741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710411;
	bh=fRRvlS6BSlWJEOgJ6mK/HtJMXrjrzPEBnyi5d58cgt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsXOJD19CEH7BvsmIIB/ZsIYNDL3V3k+vIg2Vv0rzqp1EHwm5t4Ze9U/CL024G96t
	 TcUHUZtaARC+AMYlLDH821EiDMp3R6T0sNHfZ+Zc+tu0yO0JmD9PXahLwahhVekhh8
	 DsTP24ce0FQYytAGIjbKGb2hOClBXH7YpQFBc1jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbfC0SN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389416AbfC0SN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000C62177E;
        Wed, 27 Mar 2019 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710405;
        bh=fRRvlS6BSlWJEOgJ6mK/HtJMXrjrzPEBnyi5d58cgt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOpSgGP0iwi+B1KQ3aVIdtJIcc67EyrKnOeCG/y6PxlUSiP4wipBZgUxdjfhxsmaj
         DM7Me8eMvRd56URrB6du7x7VhBMLyo9LoB5MO+1azps0wF3UMJ628qe9NM+uOHiZSf
         bcXcDHsxGm3L7mJ98500zPwSoIy3fNaDKTZM5h3k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Righi <righi.andrea@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 104/192] kprobes: Prohibit probing on bsearch()
Date:   Wed, 27 Mar 2019 14:08:56 -0400
Message-Id: <20190327181025.13507-104-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Righi <righi.andrea@gmail.com>

[ Upstream commit 02106f883cd745523f7766d90a739f983f19e650 ]

Since kprobe breakpoing handler is using bsearch(), probing on this
routine can cause recursive breakpoint problem.

int3
 ->do_int3()
   ->ftrace_int3_handler()
     ->ftrace_location()
       ->ftrace_location_range()
         ->bsearch() -> int3

Prohibit probing on bsearch().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998813406.31052.8791425358974650922.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/bsearch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
-- 
2.19.1

