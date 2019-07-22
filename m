Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DEF21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfGVKdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:33:47 -0400
Received: from foss.arm.com ([217.140.110.172]:35440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfGVKdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:33:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27DD1576;
        Mon, 22 Jul 2019 03:33:43 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7347E3F71A;
        Mon, 22 Jul 2019 03:33:42 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched/clock: Allow sched_clock to inherit timestamp_clock epoch
Date:   Mon, 22 Jul 2019 11:33:29 +0100
Message-Id: <20190722103330.255312-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722103330.255312-1-marc.zyngier@arm.com>
References: <20190722103330.255312-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can let an architecture override the timestamping
function, it becomes desirable to ensure that, should the
architecture code switch its timestamping code to sched_clock
once it has been registered, the sched_clock inherits the
timestamp value as its new epoch.

This ensures that the time stamps are continuous and that there
is no jitter other than that introduced by the lack of quality
of the timestamping clock.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/time/sched_clock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 142b07619918..ee1bd449ec81 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -192,6 +192,16 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	new_epoch = read();
 	cyc = cd.actual_read_sched_clock();
 	ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) & rd.sched_clock_mask, rd.mult, rd.shift);
+
+	/*
+	 * If the architecture has a timestamp clock, and this is the
+	 * first time we register a new sched_clock, use the timestamp
+	 * clock as the epoch.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_HAS_TIMESTAMP_CLOCK) &&
+	    unlikely(cd.actual_read_sched_clock == jiffy_sched_clock_read))
+		ns = timestamp_clock();
+
 	cd.actual_read_sched_clock = read;
 
 	rd.read_sched_clock	= read;
-- 
2.20.1

