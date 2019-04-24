Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073321900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125906;
	bh=QspD3OEHvahxz8M5azcgKQFBPNYfoaRr3RMuD42XjzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Kw+p6Ut4zdsmtS10sp4x8RZ6LLzKHgcGzwG9qDUyawXHO/uHZQ33dXUlXwzSo5sN
	 KUa77XDSF2DmfkvIf57myCbCa76tqUIkSVrY0olnJkVRDyimq56E1O9J4ka+eBuE4y
	 0vlUb44dXva1PBu13qNxhC+oBZgkQvwPrGcZLdNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfDXRLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfDXRLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:11:39 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AE12148D;
        Wed, 24 Apr 2019 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125898;
        bh=QspD3OEHvahxz8M5azcgKQFBPNYfoaRr3RMuD42XjzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTrsS9N+fb0Cg9JtaJziu7ymYNF0w2to38W/lmL50MIIL3Uni1WPdfHYNKvrqPdl2
         i1vfjLUYH4lV9yjnOpsgtdJbE/dQjmqPhondbYGeQ8kjKgSPM4tejBSrORl8zetM8U
         ZFg9dBtfw49Rs1NbHLG+U+ep3VPFTzrzNLjZlyK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 022/104] kprobes: Prohibit probing on bsearch()
Date:   Wed, 24 Apr 2019 19:08:39 +0200
Message-Id: <20190424170853.757405900@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e33c179089db..d50048446b77 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -51,3 +52,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
-- 
2.19.1



