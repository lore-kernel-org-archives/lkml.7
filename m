Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F182070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140009;
	bh=AZZmrHyeLP9V+hKISCkPEYCYz3uXYeKNMK8LvDw59cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6x1PUm/pRZgkLaOcibX7KBgduMoyNQTHOZntTTjwfQIBzNJvpe9sHJH4jMb/qJOM
	 elJohlZmnApe7+DLcoycPT9+A5vhnwwtfwZu9h6OYjD+tC2hDqF7e/nvzAYISoaFNg
	 NYlEOuQIe0U+h/zTHssiVqIt549I1u0zbuYFJuas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfDARd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbfDARdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0C820830;
        Mon,  1 Apr 2019 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140002;
        bh=AZZmrHyeLP9V+hKISCkPEYCYz3uXYeKNMK8LvDw59cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5oRfqwQiLIQ/GHDi9ag58TFzqrdMQEXtBs9VLCay/1xQpOx2pn+mJANePliytFvw
         Rau9vA8q6pkH0VFAzwSjbfcDtenguDmyjZxF7ry+KwVAc9rP7H/2/LPSZa3TyMSvBe
         7n9XlEXKMFtPV4/UOazdpbGnKvx04bPEmtQ4Uef0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, vince@deater.net,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 076/131] perf/ring_buffer: Refuse to begin AUX transaction after rb->aux_mmap_count drops
Date:   Mon,  1 Apr 2019 19:02:26 +0200
Message-Id: <20190401170058.429119601@linuxfoundation.org>
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

[ Upstream commit dcb10a967ce82d5ad20570693091139ae716ff76 ]

When ring buffer's AUX area is unmapped and rb->aux_mmap_count drops to
zero, new AUX transactions into this buffer can still be started,
even though the buffer in en route to deallocation.

This patch adds a check to perf_aux_output_begin() for rb->aux_mmap_count
being zero, in which case there is no point starting new transactions,
in other words, the ring buffers that pass a certain point in
perf_mmap_close will not have their events sending new data, which
clears path for freeing those buffers' pages right there and then,
provided that no active transactions are holding the AUX reference.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: vince@deater.net
Link: http://lkml.kernel.org/r/1457098969-21595-2-git-send-email-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 94dc6b0763ab..7324d83d6bd8 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -288,6 +288,13 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	if (!rb_has_aux(rb) || !atomic_inc_not_zero(&rb->aux_refcount))
 		goto err;
 
+	/*
+	 * If rb::aux_mmap_count is zero (and rb_has_aux() above went through),
+	 * the aux buffer is in perf_mmap_close(), about to get freed.
+	 */
+	if (!atomic_read(&rb->aux_mmap_count))
+		goto err;
+
 	/*
 	 * Nesting is not supported for AUX area, make sure nested
 	 * writers are caught early
-- 
2.19.1



