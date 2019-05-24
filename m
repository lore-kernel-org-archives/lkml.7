Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B318C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152702184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWSgtcfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbfEXRfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37177 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403898AbfEXRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so5419709pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLeIs2ht3Bexy615KPYvuA1gjE4ZvABeyxgkVxsxj04=;
        b=yWSgtcfvNEzSucZd2HObaLO8RWQcceH4AX+g6zfH930jotOnk6YMB5pQ/SLW4ipjhJ
         jZ5iI7gJfpoSYQtQUcZ79lBPaNPG+hbO2hs4QYVeDM7GG+D8UhlGkg4IwoFS/GymgbHf
         lm3l8Rz829dZxNiy3CRzcoX8x69OUkaFafZq681COCJ81z2pXxwUW2/iWULdJsICdI5n
         6AYDsGP+qVK/YeCmljvY0U3ZMXj4yA8XmpwqYCiu1NEMSNnk0ZobahU98vScCjkqCUf6
         u3tZRBZnKTaTIrtQlGjp7AC2DoG2GAM3gFXJiKR5h511V0HeFOVIUvDbVKCJqIlmOLm2
         gopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLeIs2ht3Bexy615KPYvuA1gjE4ZvABeyxgkVxsxj04=;
        b=feCacX2YeinEi1jOkcXr27InURrqIQ+Vgd6jDBQeah79s5A5yI61t3uVkQGKpYZP8Q
         lLufzRtHo3AYqpcRXB4+dl4TeDhdvse1akYV/KNE/uOOZ6/pfI2oH5MDeH3+hPgx6ABT
         VKm0Gsv75s0KMr9XR7Xz3XgeTlwCG5uJPfh3JNB4ja7RZP12YX5fDIOuOOeV4yzBUOO+
         Wg3ns0TcWK2Mo2eOTAkwgid5xRM/fFsMAmqGWmto8HFXrYaEqetNj5qpXW5jZJ/0ota7
         lYG3DkF12DyBzsFDCidYHqctXFSxftcJQRiiRq2EugRqoGqjiQBOTsIzOFfaz7zYBei+
         q+kQ==
X-Gm-Message-State: APjAAAXdEUpORYwYYCpbOux2bLzJgEX5mjrUUS4+kj4ywQZkfbkEMbRh
        a1zc8Ns0fgmmpAlSvMb4bFAL8w==
X-Google-Smtp-Source: APXvYqz6Z9QeG1cYwrhxHF6PF7OOomptz6Teuxu81LFJg0dPX+YqM5WwRF3ij2Zbc9TCmxntEiW4AQ==
X-Received: by 2002:a63:2a06:: with SMTP id q6mr20337812pgq.290.1558719327903;
        Fri, 24 May 2019 10:35:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 14/17] perf tools: Add support for multiple traceID queues
Date:   Fri, 24 May 2019 11:35:05 -0600
Message-Id: <20190524173508.29044-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide trace mode with a source/sink topology of N:1
packets with multiple traceID will end up in the same cs_etm_queue.  In
order to properly decode packets they need to be split in different
queues, i.e one queue per traceID.

As such add support for multiple traceID per cs_etm_queue by adding
a new cs_etm_traceid_queue every time a new traceID is discovered
in the trace stream.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/Makefile.config |   3 +
 tools/perf/util/cs-etm.c   | 131 ++++++++++++++++++++++++++++++-------
 2 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e1bb5288ab1f..feb2d1b85087 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -412,6 +412,9 @@ ifdef CORESIGHT
   $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
+    ifeq ($(feature-reallocarray), 0)
+      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
+    endif
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
     EXTLIBS += $(OPENCSDLIBS)
     $(call detected,CONFIG_LIBOPENCSD)
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2483293266d8..afc2491f9f2a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -29,6 +29,7 @@
 #include "thread.h"
 #include "thread_map.h"
 #include "thread-stack.h"
+#include <tools/libc_compat.h>
 #include "util.h"
 
 #define MAX_TIMESTAMP (~0ULL)
@@ -82,7 +83,9 @@ struct cs_etm_queue {
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
-	struct cs_etm_traceid_queue *traceid_queues;
+	/* Conversion between traceID and index in traceid_queues array */
+	struct intlist *traceid_queues_list;
+	struct cs_etm_traceid_queue **traceid_queues;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -208,31 +211,71 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 static struct cs_etm_traceid_queue
 *cs_etm__etmq_get_traceid_queue(struct cs_etm_queue *etmq, u8 trace_chan_id)
 {
-	struct cs_etm_traceid_queue *tidq;
+	int idx;
+	struct int_node *inode;
+	struct intlist *traceid_queues_list;
+	struct cs_etm_traceid_queue *tidq, **traceid_queues;
 	struct cs_etm_auxtrace *etm = etmq->etm;
 
-	if (!etm->timeless_decoding)
-		return NULL;
+	if (etm->timeless_decoding)
+		trace_chan_id = CS_ETM_PER_THREAD_TRACEID;
 
-	tidq = etmq->traceid_queues;
+	traceid_queues_list = etmq->traceid_queues_list;
 
-	if (tidq)
-		return tidq;
+	/*
+	 * Check if the traceid_queue exist for this traceID by looking
+	 * in the queue list.
+	 */
+	inode = intlist__find(traceid_queues_list, trace_chan_id);
+	if (inode) {
+		idx = (int)(intptr_t)inode->priv;
+		return etmq->traceid_queues[idx];
+	}
 
+	/* We couldn't find a traceid_queue for this traceID, allocate one */
 	tidq = malloc(sizeof(*tidq));
 	if (!tidq)
 		return NULL;
 
 	memset(tidq, 0, sizeof(*tidq));
 
+	/* Get a valid index for the new traceid_queue */
+	idx = intlist__nr_entries(traceid_queues_list);
+	/* Memory for the inode is free'ed in cs_etm_free_traceid_queues () */
+	inode = intlist__findnew(traceid_queues_list, trace_chan_id);
+	if (!inode)
+		goto out_free;
+
+	/* Associate this traceID with this index */
+	inode->priv = (void *)(intptr_t)idx;
+
 	if (cs_etm__init_traceid_queue(etmq, tidq, trace_chan_id))
 		goto out_free;
 
-	etmq->traceid_queues = tidq;
+	/* Grow the traceid_queues array by one unit */
+	traceid_queues = etmq->traceid_queues;
+	traceid_queues = reallocarray(traceid_queues,
+				      idx + 1,
+				      sizeof(*traceid_queues));
+
+	/*
+	 * On failure reallocarray() returns NULL and the original block of
+	 * memory is left untouched.
+	 */
+	if (!traceid_queues)
+		goto out_free;
+
+	traceid_queues[idx] = tidq;
+	etmq->traceid_queues = traceid_queues;
 
-	return etmq->traceid_queues;
+	return etmq->traceid_queues[idx];
 
 out_free:
+	/*
+	 * Function intlist__remove() removes the inode from the list
+	 * and delete the memory associated to it.
+	 */
+	intlist__remove(traceid_queues_list, inode);
 	free(tidq);
 
 	return NULL;
@@ -412,6 +455,44 @@ static int cs_etm__flush_events(struct perf_session *session,
 	return cs_etm__process_timeless_queues(etm, -1);
 }
 
+static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
+{
+	int idx;
+	uintptr_t priv;
+	struct int_node *inode, *tmp;
+	struct cs_etm_traceid_queue *tidq;
+	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
+
+	intlist__for_each_entry_safe(inode, tmp, traceid_queues_list) {
+		priv = (uintptr_t)inode->priv;
+		idx = priv;
+
+		/* Free this traceid_queue from the array */
+		tidq = etmq->traceid_queues[idx];
+		thread__zput(tidq->thread);
+		zfree(&tidq->event_buf);
+		zfree(&tidq->last_branch);
+		zfree(&tidq->last_branch_rb);
+		zfree(&tidq->prev_packet);
+		zfree(&tidq->packet);
+		zfree(&tidq);
+
+		/*
+		 * Function intlist__remove() removes the inode from the list
+		 * and delete the memory associated to it.
+		 */
+		intlist__remove(traceid_queues_list, inode);
+	}
+
+	/* Then the RB tree itself */
+	intlist__delete(traceid_queues_list);
+	etmq->traceid_queues_list = NULL;
+
+	/* finally free the traceid_queues array */
+	free(etmq->traceid_queues);
+	etmq->traceid_queues = NULL;
+}
+
 static void cs_etm__free_queue(void *priv)
 {
 	struct cs_etm_queue *etmq = priv;
@@ -419,14 +500,8 @@ static void cs_etm__free_queue(void *priv)
 	if (!etmq)
 		return;
 
-	thread__zput(etmq->traceid_queues->thread);
 	cs_etm_decoder__free(etmq->decoder);
-	zfree(&etmq->traceid_queues->event_buf);
-	zfree(&etmq->traceid_queues->last_branch);
-	zfree(&etmq->traceid_queues->last_branch_rb);
-	zfree(&etmq->traceid_queues->prev_packet);
-	zfree(&etmq->traceid_queues->packet);
-	zfree(&etmq->traceid_queues);
+	cs_etm__free_traceid_queues(etmq);
 	free(etmq);
 }
 
@@ -497,19 +572,21 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	u8  cpumode;
 	u64 offset;
 	int len;
-	struct	 thread *thread;
-	struct	 machine *machine;
-	struct	 addr_location al;
-
-	(void)trace_chan_id;
+	struct thread *thread;
+	struct machine *machine;
+	struct addr_location al;
+	struct cs_etm_traceid_queue *tidq;
 
 	if (!etmq)
 		return 0;
 
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	if (!tidq)
+		return 0;
 
-	thread = etmq->traceid_queues->thread;
+	thread = tidq->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
 			return 0;
@@ -545,6 +622,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	if (!etmq)
 		return NULL;
 
+	etmq->traceid_queues_list = intlist__new(NULL);
+	if (!etmq->traceid_queues_list)
+		goto out_free;
+
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 
@@ -579,6 +660,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	intlist__delete(etmq->traceid_queues_list);
 	free(etmq);
 
 	return NULL;
@@ -1280,8 +1362,9 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 				 struct cs_etm_packet *packet,
 				 u64 end_addr)
 {
-	u16 instr16;
-	u32 instr32;
+	/* Initialise to keep compiler happy */
+	u16 instr16 = 0;
+	u32 instr32 = 0;
 	u64 addr;
 
 	switch (packet->isa) {
-- 
2.17.1

