Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F882089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm+pwRG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfJKJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:20:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38142 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfJKJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:20:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so9471763wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JePE8ClpvmkdREqAemoY5/Xc8Y8z7AI4rivC6NTKD84=;
        b=Jm+pwRG0HzWyJjQGN+1v3eL2WIqd5IsEwLRdxn/PV5CkmMnZpTcCwdw/MI9JFaAQxH
         5Bme0bpmr00gbYIaw5o1SqfSl3V3VgAjFwPXzemCtKQpeZUpAsWfaq9pjhv9UsgC0cCe
         Y3uB5VEEmmL+i605dBiywQX/4xlOpr5emrQLVTambUIj6xa8Jnr6oZ+U4cGK48S3bcA5
         fqEL/ctyy9UvxO9K94DZ4q56v8nnxOkcC+2OG2PslOJfYFu+6V8FjiP9Uyov4jCiHjOi
         zoJfRSbt2cFf5Wf0uzmWlgihH8n3o/hVgZl+ZLC81fteGXF9rM+oMOWbrX+XZIl3R0lB
         L+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JePE8ClpvmkdREqAemoY5/Xc8Y8z7AI4rivC6NTKD84=;
        b=oYDB3NOWKzT61YOzHRHltgleiLAua3ib8v4o8M1zrBfOR4SI80ycczcMT3PCEFyrBB
         9FknD/SKEDuu+kFdbEbHr0CXL57G4JQmqmiCZpahpU3nDRlXvkIyPnCA0SEyYXH12GsS
         b6ZJmQ+Z6h3nV1zw+ghizS41XmVTPnNdEceZrF0JFJVqR2dxOsba1J0OQbidA1JW33iQ
         FKyoCqZd7HUVzkO+8GX1dyTVxCrUc24Q9yQvVbucH7Ds5kV9m5uze9ZwBA4kDCTgLAWc
         pYNpbIfeZykzUS0fpfLmT0d2q7gsuXOIkw4PjX8qjCTzsfWiz/jAF4De30sd5WQ/pRhQ
         MD9g==
X-Gm-Message-State: APjAAAXRcVy6MLMnI4R+3sT1TyCei2uWZaie+pPqmYas+hqgeJfuI96v
        pOB7Ut+d19a/Hh/ZxtuTTWFduw==
X-Google-Smtp-Source: APXvYqy81ucKBfLp4NPCr9YZdfPcNx5llAgGpYyda7UMIIHcQZiTmWkdGca5oeZff4YN1u74EfpbXg==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr2463573wml.169.1570785600656;
        Fri, 11 Oct 2019 02:20:00 -0700 (PDT)
Received: from localhost.localdomain (li2042-79.members.linode.com. [172.105.81.79])
        by smtp.gmail.com with ESMTPSA id u10sm8603492wmm.0.2019.10.11.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 02:19:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf test: Report failure for mmap events
Date:   Fri, 11 Oct 2019 17:19:41 +0800
Message-Id: <20191011091942.29841-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fail to mmap events in task exit case, it misses to set 'err' to
-1; thus the testing will not report failure for it.

This patch sets 'err' to -1 when fails to mmap events, thus Perf tool
can report correct result.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/task-exit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index bce3a4cb4c89..ca0a6ca43b13 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -110,6 +110,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = -1;
 		goto out_delete_evlist;
 	}
 
-- 
2.17.1

