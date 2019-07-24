Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D7AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209392189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pd8KMi+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfGXWuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:50:07 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48270 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfGXWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:50:04 -0400
Received: by mail-qt1-f201.google.com with SMTP id x7so42839385qtp.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NxY1kodMJBd2/ei1bMYZJ0+xBcLCSsSTWKWnJLyiC4A=;
        b=pd8KMi+0zEXQfuPRHUcE9sM5o0zzd8ue5+jsXpSqx6c/66eG0WAG3ATGyB+CNnP0dl
         5o2U6KvUPKQfe6sTG/9En17b61ENuw/XRZcBFw2/jmuv9E3Rw6u7oqlIXTyCajhjbfTH
         Cw6RovJEGZ4qjCs8Arl9r5NUIr3pkuykNI6xBFtxP5sXYn+t8AdXumnIMULFuurrbIYy
         heZCb8n/ypmJjlEKL1WOqCXqrkuCN1Tl8pvwIbwrx2gyQUNLarF+b9jzMURXCu7Sixw3
         q2uIWT2wdJU6rZRPSyqI/PP7cfbAUWMXA/gOaHZlti5QnsnSjBmZtRlznNS2BoViRO4f
         EWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NxY1kodMJBd2/ei1bMYZJ0+xBcLCSsSTWKWnJLyiC4A=;
        b=d9MKdv5khuCkV422JczRu4TVEVJ5goMj7P1HrXEDneQlLBE05UnZQ5jobkb3XtCAs2
         m7UcVcyZnZwDvmgUmI0Mb6EZF0VLoyoZHp+D/+9OBIef62bfrMNnQQ0XfD6JFKAXOFwC
         A/QlXAPcz9jGQ2SYUCet9NdMt493gYHeOBMvdci6mV32ETRAFMVJyaunMczMk1CXgprO
         reZfqEWnQ+jD//T8DwQ1pW0CjT+gz0ubgPBPhYn6D1z8kB26Z9KwWt2O8F7HZ2Lo0No2
         gVoQT9B87ON0ikD/wvaCxjRo2kGSpA2W6ZBJsQzF3lrh7HF+bYYbf+KeCkhvWEBLxXkf
         FiJw==
X-Gm-Message-State: APjAAAU6VxQAlhjYNPAexDDB82fN7qrVhsEzv7RGlpYPsa/Qq69g2Cwk
        3JlyC8BAAEpaf8WMCPDyh7vufOa8
X-Google-Smtp-Source: APXvYqwTiaEmHGfxNqrCbrjI1j9LA5A9ou08lYvHVjTv1cgZyCF3303x39esyOIccerHbqj8VFBg5Cxk
X-Received: by 2002:a05:620a:1f4:: with SMTP id x20mr57368093qkn.415.1564008603064;
 Wed, 24 Jul 2019 15:50:03 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:49:54 -0700
In-Reply-To: <20190724224954.229540-1-nums@google.com>
Message-Id: <20190724224954.229540-3-nums@google.com>
Mime-Version: 1.0
References: <20190724224954.229540-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [RFC][PATCH 2/2] Fix evsel.c misaligned address errors
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ubsan (undefined behavior sanitizer) build of perf throws
misaligned address erros during 'Sample parsing function' in
perf test.

To reproduce, run:
make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"

(see the cover letter for why perf may not build)

then run: tools/perf/perf test 26 -v

Most of the misaligned address errors come from improperly assigning
values to the u64 array in the 'perf_event__synthesize_sample'
function. These are easily fixed by changing the assignments
to use memcpy instead.

In the 'perf_evsel__parse_sample' function, the 'u64* array'
variable has varying numbers of bytes added to it depending on
which if statements it passes. Since this function is called
multiple times under different conditions, the 'array' variable
is sometimes misaligned by 4 bytes and sometimes not. This causes
issues when 'data->branch_stack' is later assigned to an element
in the array.

In the case that the array is misaligned we can add 4 bytes to the
array to realign it. This still causes an incorrect perf data file
(so the test still fails with the ubsan build) but it at least
gets rid of the error.

Comments?

Not-Quite-Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/util/evsel.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466db368..a1289fcbbb2d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2288,6 +2288,11 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 					  sizeof(struct branch_entry);
 
 		OVERFLOW_CHECK_u64(array);
+		if ((((u64)array) & 7) != 0)
+			array = (void *)array + sizeof(u32);
+
+		assert((((u64)array) & 7) == 0);
+		
 		data->branch_stack = (struct branch_stack *)array++;
 
 		if (data->branch_stack->nr > max_branch_nr)
@@ -2646,7 +2651,8 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
-			*array++ = sample->user_regs.abi;
+			memcpy(array++, &sample->user_regs.abi,
+				sizeof(sample->user_regs.abi));
 			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
@@ -2657,32 +2663,31 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 
 	if (type & PERF_SAMPLE_STACK_USER) {
 		sz = sample->user_stack.size;
-		*array++ = sz;
+		memcpy(array++, &sz, sizeof(sample->user_stack.size));
 		if (sz) {
 			memcpy(array, sample->user_stack.data, sz);
 			array = (void *)array + sz;
-			*array++ = sz;
+			memcpy(array++, &sz, sizeof(sz));
 		}
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT) {
-		*array = sample->weight;
-		array++;
+		memcpy(array++, &sample->weight, sizeof(sample->weight));
 	}
 
 	if (type & PERF_SAMPLE_DATA_SRC) {
-		*array = sample->data_src;
-		array++;
+		memcpy(array++, &sample->data_src, sizeof(sample->data_src));
 	}
 
 	if (type & PERF_SAMPLE_TRANSACTION) {
-		*array = sample->transaction;
-		array++;
+		memcpy(array++, &sample->transaction,
+			sizeof(sample->transaction));
 	}
 
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
-			*array++ = sample->intr_regs.abi;
+			memcpy(array++, &sample->intr_regs.abi,
+				sizeof(sample->intr_regs.abi));
 			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
@@ -2692,8 +2697,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	}
 
 	if (type & PERF_SAMPLE_PHYS_ADDR) {
-		*array = sample->phys_addr;
-		array++;
+		memcpy(array++, &sample->phys_addr, sizeof(sample->phys_addr));
 	}
 
 	return 0;
-- 
2.22.0.657.g960e92d24f-goog

