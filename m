Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2EA2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfEEL6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:58:24 -0400
Received: from foss.arm.com ([217.140.101.70]:56800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfEEL6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:58:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9739D374;
        Sun,  5 May 2019 04:58:23 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19A3B3F5C1;
        Sun,  5 May 2019 04:58:21 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 0/7] Add new tracepoints required for EAS testing
Date:   Sun,  5 May 2019 12:57:25 +0100
Message-Id: <20190505115732.9844-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add the bare minimum tracepoints required to perform EAS
testing in Lisa[1].

The new tracepoints are bare in a sense that they don't export any info in
tracefs, hence shouldn't introduce any ABI. The intended way to use them is by
loading a module that will probe the tracepoints and extract the info required
for userspace testing.

It is done in this way because adding new TRACE_EVENTS() is no longer accepted
AFAIU.

The tracepoints are focused around tracking PELT signals which is what EAS uses
to make its decision, hence knowing the value of PELT as it changes allows
verifying that EAS is doing the right thing based on synthetic tests that
simulate different scenarios.

Beside EAS, the new tracepoints can help investigate CFS load balancer and CFS
taskgroup handling as they are both based on PELT signals too.

The first 2 patches do a bit of code shuffling to expose some required
functions.

Patch 3 adds a new cfs helper function.

Patches 4-6 add the new tracepoints.

Patch 7 exports the tracepoints so that out of tree modules can probe the new
tracepoints with least amount of effort - which extends the usefulness of the
tracepoints since creating a module to probe them is the only way to access
them.

An example module that uses these tracepoints is available in [2].

[1] https://github.com/ARM-software/lisa
[2] https://github.com/qais-yousef/tracepoints-helpers/blob/master/lisa_tp/lisa_tp.c

Qais Yousef (7):
  sched: autogroup: Make autogroup_path() always available
  sched: fair: move helper functions into fair.h
  sched: fair.h: add a new cfs_rq_tg_path()
  sched: Add sched_load_rq tracepoint
  sched: Add sched_load_se tracepoint
  sched: Add sched_overutilized tracepoint
  sched: export the newly added tracepoints

 include/trace/events/sched.h     |  17 +++
 kernel/sched/autogroup.c         |   2 -
 kernel/sched/core.c              |   8 ++
 kernel/sched/fair.c              | 212 ++----------------------------
 kernel/sched/fair.h              | 215 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.c              |   6 +
 kernel/sched/sched.h             |   1 +
 kernel/sched/sched_tracepoints.h |  52 ++++++++
 8 files changed, 313 insertions(+), 200 deletions(-)
 create mode 100644 kernel/sched/fair.h
 create mode 100644 kernel/sched/sched_tracepoints.h

-- 
2.17.1

