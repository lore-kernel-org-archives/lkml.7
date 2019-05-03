Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19462C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3902075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q9jnEdYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfECF5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:57:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:57:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435v2Ik2618778
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:57:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435v2Ik2618778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556863023;
        bh=kz6MNukui0KiADnNHmzlQuaCU0ATrKZ8pqEHdLeHMVc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=q9jnEdYxQCvaiqAQbg2AVzEmkrnJivFHzkUGrCHqbziC0+QrLomsVSM4JGKsZtR5p
         kpQmkzYogxOO9qw1oNuw5YDKHyyh/QKJRxIYE3JnqkkLqXD5zfHGFu6GJzJV2AjfWg
         p9AWJkhbKBnZCgGB+uRo6d5REBVcu1BOhvTvjrUEZf3anw9q4SiMjsgxVSg8HbNUS6
         z9LWnuEHXUy4j4JF/jGknaz1ez/V5GP4VwOUVKg87x8qJSHTrUf/DDvEzBoHnXjG+I
         xkW2u7N1LsujDvf1Cer39ovK1A7N9zf59ze1L4Ccq+IZzWWLRCULRo4/TIavhI9jwE
         KhG1nb1Jjp7gA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435v2MJ2618680;
        Thu, 2 May 2019 22:57:02 -0700
Date:   Thu, 2 May 2019 22:57:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-35bb59c10a6d0578806dd500477dae9cb4be344e@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, jolsa@redhat.com,
        leo.yan@linaro.org, robert.walker@arm.com,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mike.leach@linaro.org, namhyung@kernel.org, mingo@kernel.org,
        mathieu.poirier@linaro.org
Reply-To: jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          suzuki.poulose@arm.com, leo.yan@linaro.org,
          robert.walker@arm.com, mike.leach@linaro.org,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          mathieu.poirier@linaro.org
In-Reply-To: <20190428083228.20246-1-leo.yan@linaro.org>
References: <20190428083228.20246-1-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Always allocate memory for
 cs_etm_queue::prev_packet
Git-Commit-ID: 35bb59c10a6d0578806dd500477dae9cb4be344e
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

Commit-ID:  35bb59c10a6d0578806dd500477dae9cb4be344e
Gitweb:     https://git.kernel.org/tip/35bb59c10a6d0578806dd500477dae9cb4be344e
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Sun, 28 Apr 2019 16:32:27 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet

Robert Walker reported a segmentation fault is observed when process
CoreSight trace data; this issue can be easily reproduced by the command
'perf report --itrace=i1000i' for decoding tracing data.

If neither the 'b' flag (synthesize branches events) nor 'l' flag
(synthesize last branch entries) are specified to option '--itrace',
cs_etm_queue::prev_packet will not been initialised.  After merging the
code to support exception packets and sample flags, there introduced a
number of uses of cs_etm_queue::prev_packet without checking whether it
is valid, for these cases any accessing to uninitialised prev_packet
will cause crash.

As cs_etm_queue::prev_packet is used more widely now and it's already
hard to follow which functions have been called in a context where the
validity of cs_etm_queue::prev_packet has been checked, this patch
always allocates memory for cs_etm_queue::prev_packet.

Reported-by: Robert Walker <robert.walker@arm.com>
Suggested-by: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 7100b12cf474 ("perf cs-etm: Generate branch sample for exception packet")
Fixes: 24fff5eb2b93 ("perf cs-etm: Avoid stale branch samples when flush packet")
Link: http://lkml.kernel.org/r/20190428083228.20246-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 7777cfc1ad8c..de488b43f440 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -422,11 +422,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	if (!etmq->packet)
 		goto out_free;
 
-	if (etm->synth_opts.last_branch || etm->sample_branches) {
-		etmq->prev_packet = zalloc(szp);
-		if (!etmq->prev_packet)
-			goto out_free;
-	}
+	etmq->prev_packet = zalloc(szp);
+	if (!etmq->prev_packet)
+		goto out_free;
 
 	if (etm->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
