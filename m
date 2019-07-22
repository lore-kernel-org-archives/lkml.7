Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF8621911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGVKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:33:44 -0400
Received: from foss.arm.com ([217.140.110.172]:35420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGVKdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E68D1509;
        Mon, 22 Jul 2019 03:33:42 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32B53F71A;
        Mon, 22 Jul 2019 03:33:40 -0700 (PDT)
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
Subject: [PATCH 1/3] printk: Allow architecture-specific timestamping function
Date:   Mon, 22 Jul 2019 11:33:28 +0100
Message-Id: <20190722103330.255312-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722103330.255312-1-marc.zyngier@arm.com>
References: <20190722103330.255312-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk currently relies on local_clock to time-stamp the kernel
messages. In order to allow the timestamping (and only that)
to be overridden by architecture-specific code, let's declare
a new timestamp_clock() function, which gets used by the printk
code. Architectures willing to make use of this facility will
have to define CONFIG_ARCH_HAS_TIMESTAMP_CLOCK.

The default is of course to return local_clock(), so that the
existing behaviour stays unchanged.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/sched/clock.h | 13 +++++++++++++
 kernel/printk/printk.c      |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 867d588314e0..3cf4b2a8ce18 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -98,4 +98,17 @@ static inline void enable_sched_clock_irqtime(void) {}
 static inline void disable_sched_clock_irqtime(void) {}
 #endif
 
+#ifdef CONFIG_ARCH_HAS_TIMESTAMP_CLOCK
+/* Special need architectures can provide their timestamping function */
+extern u64 timestamp_clock(void);
+
+#else
+
+static inline u64 timestamp_clock(void)
+{
+	return local_clock();
+}
+
+#endif
+
 #endif /* _LINUX_SCHED_CLOCK_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..166702316714 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -638,7 +638,7 @@ static int log_store(u32 caller_id, int facility, int level,
 	if (ts_nsec > 0)
 		msg->ts_nsec = ts_nsec;
 	else
-		msg->ts_nsec = local_clock();
+		msg->ts_nsec = timestamp_clock();
 #ifdef CONFIG_PRINTK_CALLER
 	msg->caller_id = caller_id;
 #endif
@@ -1841,7 +1841,7 @@ static bool cont_add(u32 caller_id, int facility, int level,
 		cont.facility = facility;
 		cont.level = level;
 		cont.caller_id = caller_id;
-		cont.ts_nsec = local_clock();
+		cont.ts_nsec = timestamp_clock();
 		cont.flags = flags;
 	}
 
-- 
2.20.1

