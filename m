Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21398C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E162084D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912382;
	bh=JdowPRpPbbQQV14qRQQAF/+PxPxi44BB8cKBgxEZ2VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AheFzKSyN1Ds0O0ySXraMYXhqbDXEU1OYlI2p2xs3JSD8kXBr5Bm0/EllgJP4aMOj
	 qBVw8BBE7/v5QZIDGl5zpUNCJvgooTxp86TlsUhblupq1W0/ugG2uzbX0FG1HmuA7l
	 JHYgYaBu5fNevWGSm7wiT1dl2O3oM8zkdPb7OwlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfGWUGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:06:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B77E229F3;
        Tue, 23 Jul 2019 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912378;
        bh=JdowPRpPbbQQV14qRQQAF/+PxPxi44BB8cKBgxEZ2VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el2YLUdWf6MxbybHjXoT1R//wTdDk0RhlC4pBMFAMiCGrTS7o3yLTFunUkmUzVfJt
         SQPYPyKtkZyHHfhfim02HbNL15yfzF5zrJY0hurFQlVjfQa/68yB8hgjzXsgDWWXdg
         w5PkYasLgMwJjGqFAj3WagOrnqYdLy4eapQL4UTU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/10] perf session: Fix loading of compressed data split across adjacent records
Date:   Tue, 23 Jul 2019 17:05:27 -0300
Message-Id: <20190723200530.14090-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
-- 
2.21.0

