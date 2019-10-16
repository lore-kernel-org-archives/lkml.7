Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B4ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E8D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194629;
	bh=+hMs2m5naZTA2c7LWGpnvVExxP3tbc8QTkpfH07iBqs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zAjRBa8LsWh6VqY4WIH3BXmAi5CVvJ2Eh3SHwMsvyPEXjuudtXCqQrtTCu+fWqkW9
	 Kih4YMD+0xWPXJbZ92+jmDhKkHPBmOikq9+u2vBsGUc8aaeM50oUR0rGRCidxFYfaN
	 WRS9oc3EzWbJutPLkLDzpR3JT6GjddFvwbzf+s0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbfJPC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJPC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:07 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F21D20663;
        Wed, 16 Oct 2019 02:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194626;
        bh=+hMs2m5naZTA2c7LWGpnvVExxP3tbc8QTkpfH07iBqs=;
        h=From:To:Cc:Subject:Date:From;
        b=cUtp9lyFMxO2vgaBQlAF/1/1jU+pMkFgiN1/v/8+7+8LIQT0dQE4Zt4/zuBwfpnM0
         0opTnnWinszln+xlbsVsc3Srx3TMAoAWpE8veEqP0IxB5wo/DPy8Igma2imjHhZjPS
         HZj5WbupUzu57tCy95uKUkfBpyPoqV6Hfi0cmX2w=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 00/14] sched/nohz: Make kcpustat's CPUTIME_SYSTEM vtime aware v2 (Partially fix kcpustat on nohz_full)
Date:   Wed, 16 Oct 2019 04:56:46 +0200
Message-Id: <20191016025700.31277-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the recent patches that have brought a sensible rq->curr RCU
lifecycle, here comes a simplified rework of
	"[PATCH 00/25] sched/nohz: Make kcpustat vtime aware"

See for the record and a summary: https://lore.kernel.org/lkml/1542163569-20047-1-git-send-email-frederic@kernel.org/

Since I'm trying to cut and simplify the series, this one only fixes
the reading of kcpustat's system field for now. But that also provides
all the necessary preparation work for the rest.

User and guest time will have their own series because niceness brings
issues of its own.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat-v2

HEAD: e179e89320c53a96c5d585af38126cfb124da789

Thanks,
	Frederic
---

Frederic Weisbecker (14):
      sched/vtime: Record CPU under seqcount for kcpustat needs
      sched/cputime: Add vtime idle task state
      sched/cputime: Add vtime guest task state
      context_tracking: Remove context_tracking_active()
      context_tracking: s/context_tracking_is_enabled/context_tracking_enabled()
      context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
      context_tracking: Introduce context_tracking_enabled_cpu()
      sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
      sched/vtime: Introduce vtime_accounting_enabled_cpu()
      context_tracking: Check static key on context_tracking_enabled_*cpu()
      sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM
      procfs: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      cpufreq: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
      leds: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM


 arch/x86/entry/calling.h                |   2 +-
 drivers/cpufreq/cpufreq.c               |   2 +-
 drivers/leds/trigger/ledtrig-activity.c |   2 +-
 fs/proc/stat.c                          |   4 +-
 include/linux/context_tracking.h        |  26 +++----
 include/linux/context_tracking_state.h  |  21 +++---
 include/linux/kernel_stat.h             |  11 +++
 include/linux/sched.h                   |   9 ++-
 include/linux/tick.h                    |   2 +-
 include/linux/vtime.h                   |  23 +++---
 kernel/context_tracking.c               |   6 +-
 kernel/sched/cputime.c                  | 119 ++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c                |   2 +-
 13 files changed, 172 insertions(+), 57 deletions(-)
