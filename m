Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1AC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FC924656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430709;
	bh=5r1Q8nbDUxC71h9s7mcYWX05RWLrI6p1AJIXVWfWwFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIIka3fg3YchfAiOweyMG1afTXTTRvU9sc0U1hTUvs9MJIRNPP8vUf3EhfhneHhhM
	 TTxJCvgOF3CWH0Lh9D/nCEl0tx9Ywm6VFSlp8SL+aHyA37qH79cDyUnfrn9dwEumIY
	 H18hsxEO4FbxN5obTZa6RjqEUZpfZdsSIC1/3tVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgAGU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgAGU60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:58:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FF42087F;
        Tue,  7 Jan 2020 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430705;
        bh=5r1Q8nbDUxC71h9s7mcYWX05RWLrI6p1AJIXVWfWwFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLCX3Csn9naHKhty5kWVDfFamLIn3BPGWsUGO25L6ZnbqBEejdoPghsTOyLbW80IP
         6+oXVtRaXWdqc/ZmyAtVrNmasCE169sZ9FWXKAwIwDm9iVBGHpYziEu+llFTKO8saP
         3v2fdDnShuURFa8x2PwOoCDSgUv4uuCD6I3e1OJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/191] s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits
Date:   Tue,  7 Jan 2020 21:52:45 +0100
Message-Id: <20200107205335.404192099@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7511b71d2931..47515c96032e 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1325,6 +1325,22 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
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



