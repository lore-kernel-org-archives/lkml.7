Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC74C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B62070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139914;
	bh=OF4dM8P3MVzxC/xfOACHe4gewX+htnhSCLrfdsPUH0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s8XUGpvDjYwp8K7O9Q4UYpwenAtitLbHGrTV6bOtxhlhTi8Hk+Cwv2/wx/HqHLAEa
	 fnYI7K+ecpV1H+63Tem8X8OIDuYucq5SoqkLx8Oko1RVSsTFEAJvhjXhuTpPvRTzL4
	 1aJ6Fw8isjtjmwQw043fPhP9n0r3kc9f/KBl2KF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfDARbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733298AbfDARbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470772171F;
        Mon,  1 Apr 2019 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139906;
        bh=OF4dM8P3MVzxC/xfOACHe4gewX+htnhSCLrfdsPUH0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2KrujjA7DfybqBHdeBAd1zd3tQNgjdAYHt3h3a8iouyBjl146T8BbJJdFYcGoMwr3
         kDTZ+iE2tFhrLjHp1HokdVS7lBGCLQy3AqtUcGVUyMs9lkSbwUYWzVkIH1VvtF2Ibg
         Yj/gQgSgVRheRxwiB9sPIdH2mJdciqSrD9ubw+Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markus Metzger <markus.t.metzger@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, vince@deater.net,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 050/131] perf: Synchronously free aux pages in case of allocation failure
Date:   Mon,  1 Apr 2019 19:02:00 +0200
Message-Id: <20190401170056.493312319@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 45c815f06b80031659c63d7b93e580015d6024dd ]

We are currently using asynchronous deallocation in the error path in
AUX mmap code, which is unnecessary and also presents a problem for users
that wish to probe for the biggest possible buffer size they can get:
they'll get -EINVAL on all subsequent attemts to allocate a smaller
buffer before the asynchronous deallocation callback frees up the pages
from the previous unsuccessful attempt.

Currently, gdb does that for allocating AUX buffers for Intel PT traces.
More specifically, overwrite mode of AUX pmus that don't support hardware
sg (some implementations of Intel PT, for instance) is limited to only
one contiguous high order allocation for its buffer and there is no way
of knowing its size without trying.

This patch changes error path freeing to be synchronous as there won't
be any contenders for the AUX pages at that point.

Reported-by: Markus Metzger <markus.t.metzger@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: vince@deater.net
Link: http://lkml.kernel.org/r/1453216469-9509-1-git-send-email-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 358bb53c1e74..94dc6b0763ab 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -468,6 +468,25 @@ static void rb_free_aux_page(struct ring_buffer *rb, int idx)
 	__free_page(page);
 }
 
+static void __rb_free_aux(struct ring_buffer *rb)
+{
+	int pg;
+
+	if (rb->aux_priv) {
+		rb->free_aux(rb->aux_priv);
+		rb->free_aux = NULL;
+		rb->aux_priv = NULL;
+	}
+
+	if (rb->aux_nr_pages) {
+		for (pg = 0; pg < rb->aux_nr_pages; pg++)
+			rb_free_aux_page(rb, pg);
+
+		kfree(rb->aux_pages);
+		rb->aux_nr_pages = 0;
+	}
+}
+
 int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
 {
@@ -556,30 +575,11 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	if (!ret)
 		rb->aux_pgoff = pgoff;
 	else
-		rb_free_aux(rb);
+		__rb_free_aux(rb);
 
 	return ret;
 }
 
-static void __rb_free_aux(struct ring_buffer *rb)
-{
-	int pg;
-
-	if (rb->aux_priv) {
-		rb->free_aux(rb->aux_priv);
-		rb->free_aux = NULL;
-		rb->aux_priv = NULL;
-	}
-
-	if (rb->aux_nr_pages) {
-		for (pg = 0; pg < rb->aux_nr_pages; pg++)
-			rb_free_aux_page(rb, pg);
-
-		kfree(rb->aux_pages);
-		rb->aux_nr_pages = 0;
-	}
-}
-
 void rb_free_aux(struct ring_buffer *rb)
 {
 	if (atomic_dec_and_test(&rb->aux_refcount))
-- 
2.19.1



