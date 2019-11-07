Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECDFC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760C5217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgWna+jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfKGCC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:02:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36492 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:02:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id v17so362033ybs.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x48pWm4f9iU44CaGrv+6NLJDhaVTJTxRNSeF8LdSSOU=;
        b=JgWna+jpZAHAjhIZwGuTdiMSXNQZr5F84NM4mXC5sMlcZjWOhc3hE9qqcbEV25kHVf
         STKZBRPtUDzZIOX51uxCXmYSd8V8JyAmgb8QCHA1cZmPGUkF7Y4A5HbpEednCwMJHdOa
         P9aAla6rQOtV2T/gfuB0FmjjA5YljwZYxdJddv19UhD9opIcwEoCiu6qDtZGJQCEglgA
         HX3+1/2biZnfw9byQOAXkahMXlAbTiL/UVGMh3zwvEV7sRUZLgqIKRvQpGmR6aR0MU1z
         KI0hPfVKCmwAlMtl4t8rE0TbXW/r7cYMrRRrkwQ0A8Edwk76REZkuaBUlEZgabOcWa2F
         ZSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x48pWm4f9iU44CaGrv+6NLJDhaVTJTxRNSeF8LdSSOU=;
        b=pOXVKILlSPE9oolalWMl6XLha286bvqGc3onnU3FedMrXVgPJx5u9aTPOYxfmn1D2/
         SXeg0GAMAzOCvmHt8e4CLA9EIzW/93JDLfjrR9NAZPK6twIkLElkLqcoczyFHxlVVHJD
         PqRYMB5huy44iCobyqtCXd3KmBzJ4/asvuY2o8LMsFWeyEsH2OvY+iRroVIBfaytvabG
         j4WDIImOqcb1VksVYd9D+OVpHACZVQ8BKm+eO1MEI2cBHtszDpnIeWFXlds8uce6wEzF
         MTDdRlbqd43ZNHh0Z5L9R5FmqvucrhMxfkWyPt7ddoc0datcapUqe2gA5rvRx6e0BUsO
         B5AA==
X-Gm-Message-State: APjAAAU1KPlWuTfDGyDk9sk9s8HcI8IE517HlX/egfi7TR2CGIzY7XUI
        c67K6K87Pga+T4h+534lu23l6g==
X-Google-Smtp-Source: APXvYqwBcxame7eANsXdk2WgbBdPCh+DKf7ZNUj6m9cER4+5Z0k7zW/NSYhhF/MoYaTvk9tf4m6vog==
X-Received: by 2002:a25:6c86:: with SMTP id h128mr1156370ybc.133.1573092178038;
        Wed, 06 Nov 2019 18:02:58 -0800 (PST)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id x136sm201679ywd.58.2019.11.06.18.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 18:02:57 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] perf tests: Fix out of bounds memory access
Date:   Thu,  7 Nov 2019 10:02:44 +0800
Message-Id: <20191107020244.2427-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case 'Read backward ring buffer' failed on 32-bit architectures
which were found by LKFT perf testing.  The test failed on arm32 x15
device, qemu_arm32, qemu_i386, and found intermittent failure on i386;
the failure log is as below:

  50: Read backward ring buffer                  :
  --- start ---
  test child forked, pid 510
  Using CPUID GenuineIntel-6-9E-9
  mmap size 1052672B
  mmap size 8192B
  Finished reading overwrite ring buffer: rewind
  free(): invalid next size (fast)
  test child interrupted
  ---- end ----
  Read backward ring buffer: FAILED!

The log hints there have issue for memory usage, thus free() reports
error 'invalid next size' and directly exit for the case.  Finally, this
issue is root caused as out of bounds memory access for the data array
'evsel->id'.

The backward ring buffer test invokes do_test() twice.  'evsel->id' is
allocated at the first call with the flow:

  test__backward_ring_buffer()
    `-> do_test()
	  `-> evlist__mmap()
	        `-> evlist__mmap_ex()
	              `-> perf_evsel__alloc_id()

So 'evsel->id' is allocated with one item, and it will be used in
function perf_evlist__id_add():

   evsel->id[0] = id
   evsel->ids   = 1

At the second call for do_test(), it skips to initialize 'evsel->id'
and reuses the array which is allocated in the first call.  But
'evsel->ids' contains the stale value.  Thus:

   evsel->id[1] = id    -> out of bound access
   evsel->ids   = 2

To fix this issue, we will use evlist__open() and evlist__close() pair
functions to prepare and cleanup context for evlist; so 'evsel->id' and
'evsel->ids' can be initialized properly when invoke do_test() and avoid
the out of bounds memory access.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/backward-ring-buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 338cd9faa835..5128f727c0ef 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -147,6 +147,15 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 		goto out_delete_evlist;
 	}
 
+	evlist__close(evlist);
+
+	err = evlist__open(evlist);
+	if (err < 0) {
+		pr_debug("perf_evlist__open: %s\n",
+			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		goto out_delete_evlist;
+	}
+
 	err = do_test(evlist, 1, &sample_count, &comm_count);
 	if (err != TEST_OK)
 		goto out_delete_evlist;
-- 
2.17.1

