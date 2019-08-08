Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B352C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B4A216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ro+Mx/Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404595AbfHHUQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:16:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404515AbfHHUQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:16:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KGBTR3320822
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:16:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KGBTR3320822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295372;
        bh=KlHhAHW4UWN4ntQ6v/zsL83YuSZGT1anxQXQaCLdSpg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ro+Mx/KoYopwwl+AR3SVIvINLf71Qj2YCsy5gzA1wQTrJCBGExN+J4luXoYQlVEZh
         85gPdSjMkhq9XRVOoz1SZmy197H4BxHswysNB/OlkdXKnMaJgHS2E7Yslmi5n8CTBO
         X/jetJHyFoWhPrZKYv8Hl0+2kWIi1v3hNIlLycklD7VKVpBAbJWfWZIEkOw2Ymb+Jq
         5b42oWNc+nNg1tNiyumxzEfSqZdrOJCvuPfbOYytlttctM6WfChLHtVw6zfKH5eSJY
         Q0DZiPyj/DEVwk+po/7o9LGRYPiSiE3HCfIAfb/vMxqDH9SYqwj8Ox6ZiaVCyuZORs
         YJI+ZNqMwCZ8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KGBNM3320819;
        Thu, 8 Aug 2019 13:16:11 -0700
Date:   Thu, 8 Aug 2019 13:16:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6bbfe4e602691b90ac866712bd4c43c51e546a60@git.kernel.org>
Cc:     jolsa@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
        sathnaga@linux.vnet.ibm.com, mpetlan@redhat.com, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, mpetlan@redhat.com,
          sathnaga@linux.vnet.ibm.com, tglx@linutronix.de,
          ak@linux.intel.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190801142642.28004-1-jolsa@kernel.org>
References: <20190801142642.28004-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bench numa: Fix cpu0 binding
Git-Commit-ID: 6bbfe4e602691b90ac866712bd4c43c51e546a60
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

Commit-ID:  6bbfe4e602691b90ac866712bd4c43c51e546a60
Gitweb:     https://git.kernel.org/tip/6bbfe4e602691b90ac866712bd4c43c51e546a60
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Aug 2019 16:26:42 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 1 Aug 2019 11:34:13 -0300

perf bench numa: Fix cpu0 binding

Michael reported an issue with perf bench numa failing with binding to
cpu0 with '-0' option.

  # perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd
  # Running 'numa/mem' benchmark:

   # Running main, "perf bench numa numa-mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd"
  binding to node 0, mask: 0000000000000001 => -1
  perf: bench/numa.c:356: bind_to_memnode: Assertion `!(ret)' failed.
  Aborted (core dumped)

This happens when the cpu0 is not part of node0, which is the benchmark
assumption and we can see that's not the case for some powerpc servers.

Using correct node for cpu0 binding.

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190801142642.28004-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index a640ca7aaada..513cb2f2fa32 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -379,8 +379,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
 
 	/* Allocate and initialize all memory on CPU#0: */
 	if (init_cpu0) {
-		orig_mask = bind_to_node(0);
-		bind_to_memnode(0);
+		int node = numa_node_of_cpu(0);
+
+		orig_mask = bind_to_node(node);
+		bind_to_memnode(node);
 	}
 
 	bytes = bytes0 + HPSIZE;
