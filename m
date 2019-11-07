Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AE7FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9E2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCFnrgeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbfKGBtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:49:10 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33159 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbfKGBtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:49:10 -0500
Received: by mail-yw1-f67.google.com with SMTP id q140so90224ywg.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TAQt3b7KLQNOSFGd1p8jQTzIxUSIJglUdkGOyImAfnc=;
        b=DCFnrgehW3glxwwM9s4L3X/Tbi/9biWxHP3feDMT+mhuaGpgSf6yVHt3XehTNKFYok
         HYGbBKs0xlG25FtSgfw8LKuL/X63S/BFDpLQwksYYfLUz/3lvaVbxitxsfUj+8fgAoIu
         trXo+aK8qIdHLk9FRhIQdYOtmOUtoolEd9p+gqYaiX2nw/hAihlL3zInSpRgeB4FOb0A
         mp/EtYYn46BFHQXtS3wIE6Xve6CFopga5P8F5LOmDdMGjfXzN3mdMa7Gv/1pt0YSTfG1
         xfYsddYU9H+zb+y+FRWubGrsxVhhGnz7J9E5yimovtDGcoX6fV83wL0NIJxTVhn5Pt0K
         35rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAQt3b7KLQNOSFGd1p8jQTzIxUSIJglUdkGOyImAfnc=;
        b=OvU7rnYTsvkuT3foj0FsT+SFkuaBfwEi5R7u2E32eoX7NZ45uzJHr5VBz/mtEpNBcb
         3rh2K1+FLyaOpVs9Q5CziqMEZ1Oq3vx0JB5EumJsCZZxLooMcCszoNFIJ4yFFWqXr3Eh
         0Z6ECrxjUwo/ySc0xypnGmfjfwJSHFmHvk7esmXXB03pZk7xRNZD1dhXLgksOlBdjG11
         l6zY56SYi0NagZDREPv0r3Gy2pDkCG07cetNeYo18QVtec6epzyGeerOW0dVvMVjcaL6
         O6Iy/XabcHhiRe3fy9LbRPCrQTlEhS0NcpZ7SeoXbYAnI+6eF2AcKvYrYsZBvbZlKjmf
         J8fg==
X-Gm-Message-State: APjAAAVCLZPxDMhzF/+ifO01j0vt+ExPC/Y7PZoDh42YTkk/RiTvlHMA
        KeUe58MAG3QrZGSQpWlTMkVplQ==
X-Google-Smtp-Source: APXvYqxuWi7c61YZM8teZx+g0wsXMsm/LRIZR7mAoQkMDWU/RqwimMy73uODnh7fgByTuRKqNlRQvg==
X-Received: by 2002:a81:a207:: with SMTP id w7mr524545ywg.476.1573091347626;
        Wed, 06 Nov 2019 17:49:07 -0800 (PST)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id f8sm528894ywb.47.2019.11.06.17.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:49:06 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf tests: Fix out of bounds memory access
Date:   Thu,  7 Nov 2019 09:48:48 +0800
Message-Id: <20191107014848.30008-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case 'Read backward ring buffer' failed on 32bit architectures
which were found by LKFT pert testing.  The test failed on arm32 x15
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

The log hints there have issues for memory usage, thus free() reports
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

