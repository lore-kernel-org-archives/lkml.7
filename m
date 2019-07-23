Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D13C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA1B2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iDA4cLJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392205AbfGWVvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:51:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392189AbfGWVvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:51:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLomZh253519
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:50:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLomZh253519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918649;
        bh=IEij/GnBGNnp56JzgSfaId2G9nO0kTiOaD0kP2MqF+g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iDA4cLJlR6/sPXdNXUuSrIKcGXVO/aryLNevxPk5vUb0ZGLKzbxfP5pVjeFaDNe/k
         0AqOhiw44VINUxz56+3yKflaP9fsGbSmQZQ8taIWeVqN0viFbmFc4cNDBFgocg3WhT
         Eev3irIrXCEgckl13mNVF9sMjxEfCy7LLqxEMpelhmidmk+T9RDge/GZIhn8W/F8ix
         uvUJrvwJAjspYh4lzg3pctu2Ncj6AOyO5HDfbxj2Ok5WYPaBcKaLaGflTgRurLCKO5
         Ko9JgUjU/Jmq8xOnFZPRnppNXQbn35us3RS0avzxmapWnmqfI3Bgf6Le40DQMdBztr
         KhtGmYrgxa4Kg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLom7x253516;
        Tue, 23 Jul 2019 14:50:48 -0700
Date:   Tue, 23 Jul 2019 14:50:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-872c8ee8f0f47222f7b10da96eea84d0486540a3@git.kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        alexey.budankov@linux.intel.com, namhyung@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
          alexey.budankov@linux.intel.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Fix loading of compressed data
 split across adjacent records
Git-Commit-ID: 872c8ee8f0f47222f7b10da96eea84d0486540a3
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

Commit-ID:  872c8ee8f0f47222f7b10da96eea84d0486540a3
Gitweb:     https://git.kernel.org/tip/872c8ee8f0f47222f7b10da96eea84d0486540a3
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 9 Jul 2019 17:48:14 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:04:03 -0300

perf session: Fix loading of compressed data split across adjacent records

Fix decompression failure found during the loading of compressed trace
collected on larger scale systems (>48 cores).

The error happened due to lack of decompression space for a mmaped
buffer data chunk split across adjacent PERF_RECORD_COMPRESSED records.

  $ perf report -i bt.16384.data --stats
  failed to decompress (B): 63869 -> 0 : Destination buffer is too small
  user stack dump failure
  Can't parse sample, err = -14
  0x2637e436 [0x4080]: failed to process type: 9
  Error:
  failed to process sample

  $ perf test 71
  71: Zstd perf.data compression/decompression              : Ok

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 22 ++++++++++++++--------
 tools/perf/util/session.h |  1 +
 tools/perf/util/zstd.c    |  4 ++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0fd6c614e68..37efa1f43d8b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,10 +36,16 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	void *src;
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
-	size_t decomp_len = session->header.env.comp_mmap_len;
+	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->decomp_last;
 
-	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		decomp_len += decomp_last_rem;
+	}
+
+	mmap_len = sizeof(struct decomp) + decomp_len;
+	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
 		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (decomp == MAP_FAILED) {
 		pr_err("Couldn't allocate memory for decompression\n");
@@ -47,10 +53,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	}
 
 	decomp->file_pos = file_offset;
+	decomp->mmap_len = mmap_len;
 	decomp->head = 0;
 
-	if (decomp_last) {
-		decomp_last_rem = decomp_last->size - decomp_last->head;
+	if (decomp_last_rem) {
 		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
 		decomp->size = decomp_last_rem;
 	}
@@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
-		munmap(decomp, sizeof(struct decomp) + decomp_len);
+		munmap(decomp, mmap_len);
 		pr_err("Couldn't decompress data\n");
 		return -1;
 	}
@@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
 static void perf_session__release_decomp_events(struct perf_session *session)
 {
 	struct decomp *next, *decomp;
-	size_t decomp_len;
+	size_t mmap_len;
 	next = session->decomp;
-	decomp_len = session->header.env.comp_mmap_len;
 	do {
 		decomp = next;
 		if (decomp == NULL)
 			break;
 		next = decomp->next;
-		munmap(decomp, decomp_len + sizeof(struct decomp));
+		mmap_len = decomp->mmap_len;
+		munmap(decomp, mmap_len);
 	} while (1);
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index dd8920b745bc..863dbad87849 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -46,6 +46,7 @@ struct perf_session {
 struct decomp {
 	struct decomp *next;
 	u64 file_pos;
+	size_t mmap_len;
 	u64 head;
 	size_t size;
 	char data[];
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 23bdb9884576..d2202392ffdb 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -99,8 +99,8 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
-			       src_size, output.size, ZSTD_getErrorName(ret));
+			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
 		output.dst  = dst + output.pos;
