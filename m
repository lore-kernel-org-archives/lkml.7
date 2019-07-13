Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E9C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A852083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yBiG4ihX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfGMKxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:53:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:53:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAqO2B3837429
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:52:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAqO2B3837429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015145;
        bh=c7PkIHOd4Cs+8uiLrOFi603cWwVghZS3JqS2QX0EezQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yBiG4ihXxN4cbT1Jz/0ckjcS8/vmB6AG872Ig49qMm3igSxgqiZUI/zkPOV/yqmIj
         5IH8KsUGuauLvLRcBLFRhzi+IPbxbdoMopPu6GVwwhNcmdwUg3LYKELVBOzmoYJZ4q
         tL0kZl9xOI8IuNTcsZ7LN1cyAo8cVjgiR0rkP07ayRBUlvn6OzsAxn69RYS1kJ+dBB
         Hm2cxHS3kE+AhN2tCNstMa3ABrLm61FU7hjkHyPNxWedeXvcb9aNcInT37UewcPVwu
         cSp37NUN74TNKMELoWTzvRegc2gMRAi4aCU4JSLr9YKHAEFrbB59gdQFenWPkChNAC
         GDNSEP0LKBWwg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAqNxs3837422;
        Sat, 13 Jul 2019 03:52:23 -0700
Date:   Sat, 13 Jul 2019 03:52:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Numfor Mbiziwo-Tiapo <tipbot@zytor.com>
Message-ID: <tip-4e4cf62b37da5ff45c904a3acf242ab29ed5881d@git.kernel.org>
Cc:     mbd@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, irogers@google.com,
        alexander.shishkin@linux.intel.com, songliubraving@fb.com,
        tglx@linutronix.de, eranian@google.com, jolsa@redhat.com,
        acme@redhat.com, peterz@infradead.org, nums@google.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, mbd@fb.com,
          nums@google.com, peterz@infradead.org, jolsa@redhat.com,
          acme@redhat.com, eranian@google.com, songliubraving@fb.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          irogers@google.com, hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <20190702173716.181223-1-nums@google.com>
References: <20190702173716.181223-1-nums@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test mmap-thread-lookup: Initialize variable
 to suppress memory sanitizer warning
Git-Commit-ID: 4e4cf62b37da5ff45c904a3acf242ab29ed5881d
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

Commit-ID:  4e4cf62b37da5ff45c904a3acf242ab29ed5881d
Gitweb:     https://git.kernel.org/tip/4e4cf62b37da5ff45c904a3acf242ab29ed5881d
Author:     Numfor Mbiziwo-Tiapo <nums@google.com>
AuthorDate: Tue, 2 Jul 2019 10:37:15 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:54 -0300

perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning

Running the 'perf test' command after building perf with a memory
sanitizer causes a warning that says:

  WARNING: MemorySanitizer: use-of-uninitialized-value... in mmap-thread-lookup.c

Initializing the go variable to 0 silences this harmless warning.

Committer warning:

This was harmless, just a simple test writing whatever was at that
sizeof(int) memory area just to signal another thread blocked reading
that file created with pipe(). Initialize it tho so that we don't get
this warning.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190702173716.181223-1-nums@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index ba87e6e8d18c..0a4301a5155c 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -53,7 +53,7 @@ static void *thread_fn(void *arg)
 {
 	struct thread_data *td = arg;
 	ssize_t ret;
-	int go;
+	int go = 0;
 
 	if (thread_init(td))
 		return NULL;
