Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20210C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085B2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iHYdPp/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403975AbfGWVt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:49:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfGWVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:49:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLmYpu253323
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:48:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLmYpu253323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918515;
        bh=omeHcK3ImAUZ8za7Md9AG8k6yV0W5yQr/qgxm45Del4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iHYdPp/oic3KgpPCvB2Rm18KN9e+4lIDwbab1+nTRhuEl9MbBb8DDn7w4H2XC9QJ4
         u59W78O7Xpr3WAAFUMWwgh3eWtuqFiwk8u+AsLdgu9uaKn+AsTL1krytdbMp4Wsb21
         mYaop6Q91dMOUOIibv35oHALUj4X5GCrivmWfLGdGLwEarSjdKi45IHpx9bh1RdgQ6
         NWQXbNZHvnPQvHm4tFpWY2ScZXPO0HJ+JUGoc64dtlQY+Z4770tmLEoZR5UlasbWio
         lAe+NURnzIIKMiwesNllZlLLpMweHv1Ivn5gIYWEj5DCJzT6ds39pBkEytA46DnJKx
         FrreHB1IxhtTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLmXk4253320;
        Tue, 23 Jul 2019 14:48:33 -0700
Date:   Tue, 23 Jul 2019 14:48:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-79b2fe5e756163897175a8f57d66b26cd9befd59@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, davidcc@google.com,
        kan.liang@linux.intel.com, acme@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        songliubraving@fb.com
Reply-To: songliubraving@fb.com, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          acme@redhat.com, kan.liang@linux.intel.com, davidcc@google.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190715140426.32509-1-jolsa@kernel.org>
References: <20190715140426.32509-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix proper buffer size for feature
 processing
Git-Commit-ID: 79b2fe5e756163897175a8f57d66b26cd9befd59
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

Commit-ID:  79b2fe5e756163897175a8f57d66b26cd9befd59
Gitweb:     https://git.kernel.org/tip/79b2fe5e756163897175a8f57d66b26cd9befd59
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 15 Jul 2019 16:04:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 08:59:49 -0300

perf tools: Fix proper buffer size for feature processing

After Song Liu's segfault fix for pipe mode, Arnaldo reported following
error:

  # perf record -o - | perf script
  0x514 [0x1ac]: failed to process type: 80

It's caused by wrong buffer size setup in feature processing, which
makes cpu topology feature fail, because it's using buffer size to
recognize its header version.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: e9def1b2e74e ("perf tools: Add feature header record to pipe-mode")
Link: http://lkml.kernel.org/r/20190715140426.32509-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..20111f8da5cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3747,7 +3747,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
