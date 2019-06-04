Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C9424B6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfFDLPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:15:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfFDLPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342CA80D;
        Tue,  4 Jun 2019 04:15:08 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64A173F690;
        Tue,  4 Jun 2019 04:15:06 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v3 0/6] sched: Add new tracepoints required for EAS testing
Date:   Tue,  4 Jun 2019 12:14:53 +0100
Message-Id: <20190604111459.2862-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
	- Split pelt_rq TP into pelt_cfs, pelt_rq, pelt_dl and pelt_irq
	- Replace the fatty preprocessing wrappers with exported helper
	  functions to access data in unexported structures.
	- Remove the now unnecessary headers that were introduced in the
	  previous versions.
	- Postfix the tracepoints with '_tp' to make them standout more in the
	  code as bare tracepoints with no events associated.
	- Updated the example module in [2]
		- It demonstrates now how to convert the tracepoints into trace
		  events that extend the sched events subsystem in tracefs.

Changes in v2:
	- Add include guards to the newly added headers
	- Rename tracepoints:
		sched_load_rq -> pelt_rq
		sched_load_se -> pelt_se
	- Rename helper functions: s/sched_tp/sched_trace/
	- Make sched_trace*() less fat by reducing path size to 20 bytes from
	  64.
	- Fix compilation error when building on UP


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

Patch 1 exports autogroup_path function.

Patch 2 adds helper/accessor functions to extract info from unexported data
structures that are passed in the tracepoints. eg: access to sched_avg inside
cfs_rq.

Patches 3-5 add the new tracepoints.

Patch 6 exports the tracepoints so that out of tree modules can probe the new
tracepoints with least amount of effort - which extends the usefulness of the
tracepoints since creating a module to probe them is the only way to access
them.

An example module that uses these tracepoints is available in [2].

[1] https://github.com/ARM-software/lisa
[2] https://github.com/qais-yousef/tracepoints-helpers/tree/pelt-tps-v3-create-events/sched_tp


Qais Yousef (6):
  sched: autogroup: Make autogroup_path() always available
  sched: add a new sched_trace_*() helper functions
  sched: Add new tracepoints to track pelt at rq level
  sched: Add new tracepoint to track pelt at se level
  sched: Add sched_overutilized tracepoint
  sched: export the newly added tracepoints

 include/linux/sched.h        |  16 ++++-
 include/trace/events/sched.h |  31 ++++++++++
 kernel/sched/autogroup.c     |   2 -
 kernel/sched/core.c          |  11 ++++
 kernel/sched/fair.c          | 117 ++++++++++++++++++++++++++++++++++-
 kernel/sched/pelt.c          |  11 +++-
 6 files changed, 182 insertions(+), 6 deletions(-)

-- 
2.17.1

