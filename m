Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D88C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEAF2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562680109;
	bh=JN693HyMmOmzS0bNwb+eUOUnWSLeYN3drCnU1nNmjsQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ucg/Jw7vWJ201H9N2GADCW9KLG7Vf5VclxpELx86gda+drd6enPqkpwkgL5Gh//PL
	 vBNzrgEtksNZhTpN1HvHbhmath2sfv0SyEhsrGNl5e/mu/laIDs8xQahPmt9NBUuzo
	 rXBdf6lj1UOlZ0Dv/aVXufNlDByGecrf9CrSIpcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfGINs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:48:28 -0400
Received: from lerouge.home (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065BC214AF;
        Tue,  9 Jul 2019 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562680107;
        bh=JN693HyMmOmzS0bNwb+eUOUnWSLeYN3drCnU1nNmjsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JLLzYdqc+adtmRDqO0x7oEpeqr651kv5hcj12INlJwHZbI/9PSb6UbzkqLoNZSise
         RsJG8mJoFsGOtwm6gW0OinHnbKKvoAv3K7J2CmBnZL5YdLykhgDf0NiYPMFYPD4XLF
         A8rpciLFB+6KGALGLVpZeudMguT5+Ni3d1dIOl9w=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/2] perf/hw_breakpoint: Fix breakpoint overcommit issue
Date:   Tue,  9 Jul 2019 15:48:19 +0200
Message-Id: <20190709134821.8027-1-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Syzbot has found a breakpoint overcommit issue:

https://lore.kernel.org/lkml/000000000000639f6a0584d11b82@google.com/

It took me a long time to find out what the actual root problem was. Also
its reproducer only worked on a few month old kernel but it didn't feel like
the issue was actually solved.

I eventually cooked a reproducer that works with latest upstream, see in
the end of this message.

The fix is just a few liner but implies to shut down the context swapping
optimization for contexts containing breakpoints.

Also I feel like uprobes may be concerned as well as it seems to make use
of event.hw->target after pmu::init().

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/pin

HEAD: 35b749650cc72402ae47beb5e0048c36636a4002

Thanks,
	Frederic
---

Frederic Weisbecker (2):
      perf: Allow a pmu to pin context
      perf/hw_breakpoints: Pin perf contexts of breakpoints


 include/linux/perf_event.h    | 2 ++
 kernel/events/core.c          | 6 ++++++
 kernel/events/hw_breakpoint.c | 1 +
 3 files changed, 9 insertions(+)

---

#define _GNU_SOURCE
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static struct perf_event_attr attr = {
	.type = PERF_TYPE_BREAKPOINT,
	.size = sizeof(attr),
	.config = 0,
	.sample_period = 1,
	.sample_type = PERF_SAMPLE_IP,
	.read_format = PERF_FORMAT_ID,
	.inherit = 1,
	.pinned = 1,
	.wakeup_events = 1,
	.bp_type = HW_BREAKPOINT_W,
	.bp_addr = 0,
	.bp_len = 8,
};

static void loop(int secs)
{
	struct timespec tp;
	int start;

	clock_gettime(CLOCK_MONOTONIC, &tp);
	start = tp.tv_sec;

	for (;;) {
		clock_gettime(CLOCK_MONOTONIC, &tp);
		if (tp.tv_sec - start >= secs)
			return;
	}
}

int main(int argc, char **argv)
{
	int fd, i, status;
	pid_t child1, child2;

	for (i = 0; i < 4; i++) {
		fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
		if (fd < 0)
			perror("perf_event_open");
	}

	child1 = fork();
	if (child1 == 0) {
		loop(1);
		return 0;
	}

	child2 = fork();
	if (child2 == 0) {
		loop(2);
		fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
		if (fd < 0)
			perror("perf_event_open");

		return 0;
	}

	return 0;
}

