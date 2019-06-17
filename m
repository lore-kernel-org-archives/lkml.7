Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23550C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB882084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pYEiXPMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfFQTgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:36:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfFQTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:36:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJaBSl3565922
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:36:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJaBSl3565922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800171;
        bh=FaA2Nfz3B4urIyEabrtfPZ+AWEH6l4I7ye4YsZqpkuE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pYEiXPMfI0o5Fg8bWHtRtRQewR61LYjdN1D2IlrHsWVg8Im+HGsVSK7Z1ypJB6whN
         tmigUFmzEtmV52zKTVjJyF7Oz9RFGgrz/lrF/CebA6nmKk5Lfe1kJdqXEU2He56mjN
         x8/tf8NkM+4+SyAGmOa0QDBIF/cOUl62rStchAl21v/edpEy4YXwInXzszhYpkYA6c
         wZUaeI+zZO5lkIb90/k3bxDLNhQtl7tc+NfuoE6ThM0Qh1hOn8Mi5ygd3tJcISJRMN
         FnZC+QI0czMVIZH5STy5wCCqpjdmlbjVI6znJteihSYpMngAyiFjktvaz0UuqDNdQu
         BEPXqDK9l5NnQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJaAof3565919;
        Mon, 17 Jun 2019 12:36:10 -0700
Date:   Mon, 17 Jun 2019 12:36:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-e45c48a9a4d20ebc7b639a62c3ef8f4b08007027@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, mingo@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        leo.yan@linaro.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, jolsa@redhat.com, tglx@linutronix.de
Reply-To: jolsa@redhat.com, suzuki.poulose@arm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, leo.yan@linaro.org,
          acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, mathieu.poirier@linaro.org
In-Reply-To: <20190605161633.12245-1-mathieu.poirier@linaro.org>
References: <20190605161633.12245-1-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Properly set the value of 'old' and
 'head' in snapshot mode
Git-Commit-ID: e45c48a9a4d20ebc7b639a62c3ef8f4b08007027
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

Commit-ID:  e45c48a9a4d20ebc7b639a62c3ef8f4b08007027
Gitweb:     https://git.kernel.org/tip/e45c48a9a4d20ebc7b639a62c3ef8f4b08007027
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Wed, 5 Jun 2019 10:16:33 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode

This patch adds the necessary intelligence to properly compute the value
of 'old' and 'head' when operating in snapshot mode.  That way we can
get the latest information in the AUX buffer and be compatible with the
generic AUX ring buffer mechanic.

Tester notes:

> Leo, have you had the chance to test/review this one? Suzuki?

Sure.  I applied this patch on the perf/core branch (with latest
commit 3e4fbf36c1e3 'perf augmented_raw_syscalls: Move reading
filename to the loop') and passed testing with below steps:

  # perf record -e cs_etm/@tmc_etr0/ -S -m,64 --per-thread ./sort &
  [1] 19097
  Bubble sorting array of 30000 elements

  # kill -USR2 19097
  # kill -USR2 19097
  # kill -USR2 19097
  [ perf record: Woken up 4 times to write data ]
  [ perf record: Captured and wrote 0.753 MB perf.data ]

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190605161633.12245-1-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 127 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index cc7f1cd23b14..279c69caef91 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -31,6 +31,8 @@ struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
 	struct perf_evlist	*evlist;
+	int			wrapped_cnt;
+	bool			*wrapped;
 	bool			snapshot_mode;
 	size_t			snapshot_size;
 };
@@ -684,16 +686,131 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
-static int cs_etm_find_snapshot(struct auxtrace_record *itr __maybe_unused,
+static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
+{
+	bool *wrapped;
+	int cnt = ptr->wrapped_cnt;
+
+	/* Make @ptr->wrapped as big as @idx */
+	while (cnt <= idx)
+		cnt++;
+
+	/*
+	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
+	 * cross compilation problems where the host's system supports
+	 * reallocarray() but not the target.
+	 */
+	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
+	if (!wrapped)
+		return -ENOMEM;
+
+	wrapped[cnt - 1] = false;
+	ptr->wrapped_cnt = cnt;
+	ptr->wrapped = wrapped;
+
+	return 0;
+}
+
+static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
+				      size_t buffer_size, u64 head)
+{
+	u64 i, watermark;
+	u64 *buf = (u64 *)buffer;
+	size_t buf_size = buffer_size;
+
+	/*
+	 * We want to look the very last 512 byte (chosen arbitrarily) in
+	 * the ring buffer.
+	 */
+	watermark = buf_size - 512;
+
+	/*
+	 * @head is continuously increasing - if its value is equal or greater
+	 * than the size of the ring buffer, it has wrapped around.
+	 */
+	if (head >= buffer_size)
+		return true;
+
+	/*
+	 * The value of @head is somewhere within the size of the ring buffer.
+	 * This can be that there hasn't been enough data to fill the ring
+	 * buffer yet or the trace time was so long that @head has numerically
+	 * wrapped around.  To find we need to check if we have data at the very
+	 * end of the ring buffer.  We can reliably do this because mmap'ed
+	 * pages are zeroed out and there is a fresh mapping with every new
+	 * session.
+	 */
+
+	/* @head is less than 512 byte from the end of the ring buffer */
+	if (head > watermark)
+		watermark = head;
+
+	/*
+	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
+	 */
+	watermark >>= 3;
+	buf_size >>= 3;
+
+	/*
+	 * If we find trace data at the end of the ring buffer, @head has
+	 * been there and has numerically wrapped around at least once.
+	 */
+	for (i = watermark; i < buf_size; i++)
+		if (buf[i])
+			return true;
+
+	return false;
+}
+
+static int cs_etm_find_snapshot(struct auxtrace_record *itr,
 				int idx, struct auxtrace_mmap *mm,
-				unsigned char *data __maybe_unused,
+				unsigned char *data,
 				u64 *head, u64 *old)
 {
+	int err;
+	bool wrapped;
+	struct cs_etm_recording *ptr =
+			container_of(itr, struct cs_etm_recording, itr);
+
+	/*
+	 * Allocate memory to keep track of wrapping if this is the first
+	 * time we deal with this *mm.
+	 */
+	if (idx >= ptr->wrapped_cnt) {
+		err = cs_etm_alloc_wrapped_array(ptr, idx);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Check to see if *head has wrapped around.  If it hasn't only the
+	 * amount of data between *head and *old is snapshot'ed to avoid
+	 * bloating the perf.data file with zeros.  But as soon as *head has
+	 * wrapped around the entire size of the AUX ring buffer it taken.
+	 */
+	wrapped = ptr->wrapped[idx];
+	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
+		wrapped = true;
+		ptr->wrapped[idx] = true;
+	}
+
 	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
 		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
 
-	*old = *head;
-	*head += mm->len;
+	/* No wrap has occurred, we can just use *head and *old. */
+	if (!wrapped)
+		return 0;
+
+	/*
+	 * *head has wrapped around - adjust *head and *old to pickup the
+	 * entire content of the AUX buffer.
+	 */
+	if (*head >= mm->len) {
+		*old = *head - mm->len;
+	} else {
+		*head += mm->len;
+		*old = *head - mm->len;
+	}
 
 	return 0;
 }
@@ -734,6 +851,8 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
+
+	zfree(&ptr->wrapped);
 	free(ptr);
 }
 
