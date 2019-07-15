Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB3C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA1820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfGOK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:26:13 -0400
Received: from foss.arm.com ([217.140.110.172]:46830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbfGOK0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE99D2B;
        Mon, 15 Jul 2019 03:26:12 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC1DF3F59C;
        Mon, 15 Jul 2019 03:26:11 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, mgorman@suse.de,
        riel@surriel.com
Subject: [PATCH 0/3] sched/fair: Init NUMA task_work in sched_fork()
Date:   Mon, 15 Jul 2019 11:25:05 +0100
Message-Id: <20190715102508.32434-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A TODO has been sitting in task_tick_numa() regarding init'ing the
task_numa_work() task_work in sched_fork() rather than in task_tick_numa(),
so I figured I'd have a go at it.

Patches 1 & 2 do that, and patch 3 is a freebie cleanup.

Briefly tested on a 2 * (Xeon E5-2690) system, didn't see any obvious
breakage.

Valentin Schneider (3):
  sched/fair: Move init_numa_balancing() below task_numa_work()
  sched/fair: Move task_numa_work() init to init_numa_balancing()
  sched/fair: Change task_numa_work() storage to static

 kernel/sched/fair.c | 93 +++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

--
2.22.0

