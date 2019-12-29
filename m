Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E5A21744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641872;
	bh=kXUYMUazpeA9aa6t8663MGnk4sLrJM9Oq5+Y8rhQ32w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7hkNZO3ulfM85EdvI+0883oR9/mMngZgDDpKcTd7b4bcV+fmpzeXaIKE2dLx+trI
	 WOEX8r+kHL3YEfvXR0qtuPdEwWhRGjR9ZyMf+Q5Y8c4ueizJFzzLggsr4bnso1ynsu
	 aue2aBo2NqdxaUokC/KCei+ZNQkvba9xpVOn8nqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfL2RvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732017AbfL2RvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:51:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF07B207FD;
        Sun, 29 Dec 2019 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641864;
        bh=kXUYMUazpeA9aa6t8663MGnk4sLrJM9Oq5+Y8rhQ32w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEmJ1rAJuX4iyLW3pl/uO1BSa8SDl8jQtcr1h4GP4hUKj69vx3JDlyWBtLStCj3Io
         AdlnhCvmX2HD7rnMZtBxsBsb8bjR/wZGCJ03+4eGYRHgennz/qEvoRgsOReirMMAFI
         dmkfybNcYbqK53ZZXNYofj78QQ7uszs+ENa1x9Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 244/434] perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
Date:   Sun, 29 Dec 2019 18:24:57 +0100
Message-Id: <20191229172718.090768227@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 9d604aad4bb022e848dec80d6fe5f73fe87061a2 ]

Macro TO_CS_QUEUE_NR definition has a typo, which uses 'trace_id_chan'
as its parameter, this doesn't match with its definition body which uses
'trace_chan_id'.  So renames the parameter to 'trace_chan_id'.

It's luck to have a local variable 'trace_chan_id' in the function
cs_etm__setup_queue(), even we wrongly define the macro TO_CS_QUEUE_NR,
the local variable 'trace_chan_id' is used rather than the macro's
parameter 'trace_id_chan'; so the compiler doesn't complain for this
before.

After renaming the parameter, it leads to a compiling error due
cs_etm__setup_queue() has no variable 'trace_id_chan'.  This patch uses
the variable 'trace_chan_id' for the macro so that fixes the compiling
error.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lore.kernel.org/lkml/20191021074808.25795-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4ba0f871f086..f5f855fff412 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -110,7 +110,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
  * encode the etm queue number as the upper 16 bit and the channel as
  * the lower 16 bit.
  */
-#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)	\
+#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)	\
 		      (queue_nr << 16 | trace_chan_id)
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
@@ -819,7 +819,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	 * Note that packets decoded above are still in the traceID's packet
 	 * queue and will be processed in cs_etm__process_queues().
 	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
+	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
 out:
 	return ret;
-- 
2.20.1



