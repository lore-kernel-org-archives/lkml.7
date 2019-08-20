Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7705206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="cuZpaUG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfHTGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:14:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37712 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbfHTGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:14:40 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id AE5EA20B7188; Mon, 19 Aug 2019 23:14:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE5EA20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1566281679;
        bh=irR5tenrmHwMixa4DhE9mKUf8q1VdVSaHTLm1Tuq9yA=;
        h=From:To:Cc:Subject:Date:From;
        b=cuZpaUG5UeYZabz6oj8RDw5nXWLrMKQlGvwqEH61vpCcMvvbx+jn98by0EUpmUT6a
         zcb4blqVOXkVebSjaczWLBjfWMWtR/mbapJcKNSpir7WhOaZdS/KrYKp3XAEnsHhyQ
         uq6RDsIUM90aYLW8/6RLLIqSl+EWGZjcVXalIyW0=
From:   longli@linuxonhyperv.com
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 0/3] fix interrupt swamp in NVMe
Date:   Mon, 19 Aug 2019 23:14:26 -0700
Message-Id: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patch set tries to fix interrupt swamp in NVMe devices.

On large systems with many CPUs, a number of CPUs may share one NVMe hardware
queue. It may have this situation where several CPUs are issuing I/Os, and
all the I/Os are returned on the CPU where the hardware queue is bound to.
This may result in that CPU swamped by interrupts and stay in interrupt mode
for extended time while other CPUs continue to issue I/O. This can trigger
Watchdog and RCU timeout, and make the system unresponsive.

This patch set addresses this by enforcing scheduling and throttling I/O when
CPU is starved in this situation.

Long Li (3):
  sched: define a function to report the number of context switches on a
    CPU
  sched: export idle_cpu()
  nvme: complete request in work queue on CPU with flooded interrupts

 drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/sched.h    |  2 ++
 kernel/sched/core.c      |  7 +++++
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.17.1

