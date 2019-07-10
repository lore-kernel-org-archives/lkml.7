Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0611EC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C315A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US++iuqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGJWQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:16:26 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53684 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:16:25 -0400
Received: by mail-qt1-f202.google.com with SMTP id h47so3653040qtc.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LfsYZQ1FRiE0bw7kCJomJg4di3yrMlfg60/oNCU7xAA=;
        b=US++iuqYGexjet6fsSabUB0y+E3m9i5b5/gizd5WbrvUI8HQDxJdMDHXFObW/m2QZ2
         MJqUY/5SiDkahg/N/48ZvptoZ/vxVrWfTlu4XKwTncpQx5X1/iMikZ8Ep8T93DHN1l/h
         b6GHZtVbFuoirURekH61UfV7PzZJEwhY/8dH1qpJXTxLfl211F/RHm09APBKcgoRLx6N
         /ilugJdaLy+8z7tQUudNZTqnU8OZfxTgttkmjT7sMGVyZlIj38Ww+HU9SJ5vOGePkj2v
         4v1BqYiUr0SAbmyOeaGWsN1nwEVaNkPWzMec/GLYsGYi/ygrtplPgv3VfM/DZjmuVgdI
         jJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LfsYZQ1FRiE0bw7kCJomJg4di3yrMlfg60/oNCU7xAA=;
        b=q4CnkALBwInEo2CTrrBjQRJVq4a2g+HRO6HF/hmz15rLfI/P5XaSpDp6Ivv9DZ3Bue
         Yvjv6LAHLew9BB2FFU4KRy7p4oBn1UEzUdHxXjaQHdHtJ2zWhxjb6OXbkpNBR8xxWaXS
         xMlRaBLriHW0JzcCHQS6HzAtpbKyVruNvujj935IxxtbHIUYOO+2J5BMXltA7qjITyd4
         0zicp1HIUlzHmCiVadxIJr80pFfz4ocZAw07at2BHRcY6MzwnealqnI/alViqYE8fytj
         c3uJ8kdkz4//tIG3Gck7CcrxCQyDApExyILx0UuAhb1nXadKPWp8m/LI7uSR+bY+gzXY
         FprA==
X-Gm-Message-State: APjAAAVmHj2hlHDHuT1YQCa+DWfzhDcP7Fonj7K8/Y7Ze5jCPDMdGb4m
        QKJY3ENx20RrjvbayRKEfzdejM/M
X-Google-Smtp-Source: APXvYqwkI2Pafuj+ei8Fi6KTVRncFqjdKxU6G8NqAOJVbINwEJH/A47W2xVsrtYG7NJ38ijdQKihoW+c
X-Received: by 2002:ac8:3f81:: with SMTP id d1mr243721qtk.5.1562796984336;
 Wed, 10 Jul 2019 15:16:24 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:16:20 -0700
Message-Id: <20190710221620.211059-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] Fix perf test data race for tsan build
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

The tsan build of perf gives a data race warning in
mmap-thread-lookup.c when perf test is run on our local machines.
This is because there is no lock around the "go_away" variable in
"mmap-thread-lookup.c".

The warning is difficult to reproduce from the tip branch and we
suspect it has something to do with tsan working differently
depending on the clang version.

The warning can be silenced by adding locks around the variable
but it is better practice to make the variable atomic and use
the atomic_set and atomic_read functions. This does not actually
silence the warning because tsan doesn't recognize the atomic
functions as thread safe, but in actuality it should prevent a
data race.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 5ede9b561d32..f4cbb3d92a46 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -17,7 +17,7 @@
 
 #define THREADS 4
 
-static int go_away;
+static atomic_t go_away;
 
 struct thread_data {
 	pthread_t	pt;
@@ -64,7 +64,7 @@ static void *thread_fn(void *arg)
 		return NULL;
 	}
 
-	while (!go_away) {
+	while (!atomic_read(&go_away)) {
 		/* Waiting for main thread to kill us. */
 		usleep(100);
 	}
@@ -98,7 +98,7 @@ static int threads_create(void)
 	struct thread_data *td0 = &threads[0];
 	int i, err = 0;
 
-	go_away = 0;
+	atomic_set(&go_away, 0);
 
 	/* 0 is main thread */
 	if (thread_init(td0))
@@ -118,7 +118,7 @@ static int threads_destroy(void)
 	/* cleanup the main thread */
 	munmap(td0->map, page_size);
 
-	go_away = 1;
+	atomic_set(&go_away, 1);
 
 	for (i = 1; !err && i < THREADS; i++)
 		err = pthread_join(threads[i].pt, NULL);
-- 
2.22.0.410.gd8fdbe21b5-goog

