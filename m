Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434D8222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576853260;
	bh=+ewN4H3bL7oqpAKah4rUKhxhumZWFXWnRUMoMswRnhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DkKmVGp2vUn2dJ50JEULcKs58dE329d/3FcnWhJc+l8vSB9eA3tLAolN2CdiFBIKL
	 smEhF4goGW3axrsfMmYidgbnia/s/KN3/WuQKwifQM2X+nvFUo8gkReEQRXCZyGp5B
	 h1GNhG707hHF53ov9cj3fzD2E9cMvdg3Vqwh0Ars=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfLTOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfLTOrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:47:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C78222C2;
        Fri, 20 Dec 2019 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853230;
        bh=+ewN4H3bL7oqpAKah4rUKhxhumZWFXWnRUMoMswRnhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzeaITJDYfkr+xw/32V8PYU0QvTSF9bA4ZUyqloeR1F2ggNNxWgsmQCTgzy3+Mh7Y
         9VkqGPqGt3X+90CTLUVZ/+xr5HwZab5+pACNY7wCsG73wSJiTH3BgA6c9cPvFKz2fq
         nX2kjOCCH1Kx//mFLM+ojVueJfUpN7V6iZR++NkU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/14] s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits
Date:   Fri, 20 Dec 2019 09:46:53 -0500
Message-Id: <20191220144658.10414-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220144658.10414-1-sashal@kernel.org>
References: <20191220144658.10414-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 39d4a501a9ef55c57b51e3ef07fc2aeed7f30b3b ]

Function perf_event_ever_overflow() and perf_event_account_interrupt()
are called every time samples are processed by the interrupt handler.
However function perf_event_account_interrupt() has checks to avoid being
flooded with interrupts (more then 1000 samples are received per
task_tick).  Samples are then dropped and a PERF_RECORD_THROTTLED is
added to the perf data. The perf subsystem limit calculation is:

    maximum sample frequency := 100000 --> 1 samples per 10 us
    task_tick = 10ms = 10000us --> 1000 samples per task_tick

The work flow is

measurement_alert() uses SDBT head and each SBDT points to 511
 SDB pages, each with 126 sample entries. After processing 8 SBDs
 and for each valid sample calling:

     perf_event_overflow()
       perf_event_account_interrupts()

there is a considerable amount of samples being dropped, especially when
the sample frequency is very high and near the 100000 limit.

To avoid the high amount of samples being dropped near the end of a
task_tick time frame, increment the sampling interval in case of
dropped events. The CPU Measurement sampling facility on the s390
supports only intervals, specifiing how many CPU cycles have to be
executed before a sample is generated. Increase the interval when the
samples being generated hit the task_tick limit.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index f46e5c0cb6d95..0cf130d37a325 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1294,6 +1294,22 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 	if (sampl_overflow)
 		OVERFLOW_REG(hwc) = DIV_ROUND_UP(OVERFLOW_REG(hwc) +
 						 sampl_overflow, 1 + num_sdb);
+
+	/* Perf_event_overflow() and perf_event_account_interrupt() limit
+	 * the interrupt rate to an upper limit. Roughly 1000 samples per
+	 * task tick.
+	 * Hitting this limit results in a large number
+	 * of throttled REF_REPORT_THROTTLE entries and the samples
+	 * are dropped.
+	 * Slightly increase the interval to avoid hitting this limit.
+	 */
+	if (event_overflow) {
+		SAMPL_RATE(hwc) += DIV_ROUND_UP(SAMPL_RATE(hwc), 10);
+		debug_sprintf_event(sfdbg, 1, "%s: rate adjustment %ld\n",
+				    __func__,
+				    DIV_ROUND_UP(SAMPL_RATE(hwc), 10));
+	}
+
 	if (sampl_overflow || event_overflow)
 		debug_sprintf_event(sfdbg, 4, "hw_perf_event_update: "
 				    "overflow stats: sample=%llu event=%llu\n",
-- 
2.20.1

