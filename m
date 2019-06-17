Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B84C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920952085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MGwcLeaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfFQT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:29:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfFQT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:27:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJQS2U3563461
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:26:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJQS2U3563461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799588;
        bh=6ntYTMQFd92e4t+hT6gJOgjKu4zno+WcGsT0fK2pzM8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MGwcLeaXafzODl76PrkStNDkgA6ShLOp4xwTy/vl9XW8+qE7F8OzyTOWv4qLQZX/s
         VhywwvAyHsI1aCscDnZD/DS/G/9Wz5gT84+YCqFC/KOq6ox9hKy8SkVtkH1GYmxynu
         9hyfVP+0cY5aOeIjev2ZeadjCkMcEJTro96gERuzI3r2U444yVSWbDfChFkjdywD/b
         z4WmVbw/wamJv8OM3vnPSFEqRpXI6EdsyNfMjc7TP68DA2yUMdXhHsGsKurp9Qmf06
         iylsnCpF6idFCTCHOF0oEKraaOqiuFEOUUqt0fcaXLvcvGDGD86PEWaIz01hfZbTCK
         OqOyPG6U2n+Ww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJQR1I3563458;
        Mon, 17 Jun 2019 12:26:28 -0700
Date:   Mon, 17 Jun 2019 12:26:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-6672559307d07f6b58bfd1b4b4cb44a247f51365@git.kernel.org>
Cc:     suzuki.poulose@arm.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
        mathieu.poirier@linaro.org, jolsa@redhat.com, tglx@linutronix.de
Reply-To: leo.yan@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org,
          tglx@linutronix.de, jolsa@redhat.com
In-Reply-To: <20190524173508.29044-11-mathieu.poirier@linaro.org>
References: <20190524173508.29044-11-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Get rid of unused cpu in struct
 cs_etm_queue
Git-Commit-ID: 6672559307d07f6b58bfd1b4b4cb44a247f51365
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

Commit-ID:  6672559307d07f6b58bfd1b4b4cb44a247f51365
Gitweb:     https://git.kernel.org/tip/6672559307d07f6b58bfd1b4b4cb44a247f51365
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:35:01 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Get rid of unused cpu in struct cs_etm_queue

Nowadays the synthesize code is using the packet's cpu information,
making cs_etm_queue::cpu useless.  As such simply remove it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-11-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9e8212c74055..531bbb355ba4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -79,7 +79,6 @@ struct cs_etm_queue {
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
 	pid_t pid, tid;
-	int cpu;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -599,7 +598,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
-	etmq->cpu = queue->cpu;
 	etmq->tid = queue->tid;
 	etmq->pid = -1;
 	etmq->offset = 0;
@@ -831,11 +829,8 @@ static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 		etmq->thread = machine__find_thread(etm->machine, -1,
 						    etmq->tid);
 
-	if (etmq->thread) {
+	if (etmq->thread)
 		etmq->pid = etmq->thread->pid_;
-		if (queue->cpu == -1)
-			etmq->cpu = etmq->thread->cpu;
-	}
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
