Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36698222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfKMK5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfKMK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:57:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKM-00026V-0j; Wed, 13 Nov 2019 11:56:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A6DC81C0357;
        Wed, 13 Nov 2019 11:56:45 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:45 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Factor out pt_config_start()
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191025140835.53665-3-alexander.shishkin@linux.intel.com>
References: <20191025140835.53665-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157364260527.29376.8773221510325735408.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8e105a1fc2a02d78698834974083c980d2e5b513
Gitweb:        https://git.kernel.org/tip/8e105a1fc2a02d78698834974083c980d2e5b513
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Fri, 25 Oct 2019 17:08:34 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:15 +01:00

perf/x86/intel/pt: Factor out pt_config_start()

PT trace is now enabled at the bottom of the event configuration
function that takes care of all configuration bits related to a given
event, including the address filter update. This is only needed where
the event configuration changes, that is, in ->add()/->start().

In the interrupt path we can use a lighter version that keeps the
configuration intact, since it hasn't changed, and only flips the
enable bit.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: adrian.hunter@intel.com
Cc: mathieu.poirier@linaro.org
Link: https://lkml.kernel.org/r/20191025140835.53665-3-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 05e43d0..170f3b4 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -397,6 +397,20 @@ static bool pt_event_valid(struct perf_event *event)
  * These all are cpu affine and operate on a local PT
  */
 
+static void pt_config_start(struct perf_event *event)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	u64 ctl = event->hw.config;
+
+	ctl |= RTIT_CTL_TRACEEN;
+	if (READ_ONCE(pt->vmx_on))
+		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
+	else
+		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
+
+	WRITE_ONCE(event->hw.config, ctl);
+}
+
 /* Address ranges and their corresponding msr configuration registers */
 static const struct pt_address_range {
 	unsigned long	msr_a;
@@ -468,7 +482,6 @@ static u64 pt_config_filters(struct perf_event *event)
 
 static void pt_config(struct perf_event *event)
 {
-	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
@@ -501,10 +514,7 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.config = reg;
-	if (READ_ONCE(pt->vmx_on))
-		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
-	else
-		wrmsrl(MSR_IA32_RTIT_CTL, reg);
+	pt_config_start(event);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1381,7 +1391,7 @@ void intel_pt_interrupt(void)
 
 		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 				 buf->output_off);
-		pt_config(event);
+		pt_config_start(event);
 	}
 }
 
