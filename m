Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB39C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4D820659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009796;
	bh=5ECmT8FGRoGD6l/D6ITTUE2Q2jjqPWMI3DiUs4PR6cw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D0UbrIvVxHF2Uf2tW4ZSxb/Wk2y8ZG9rZes+lVvGHtIdIDVqQqXpUCbmaZsS9snqw
	 B4lJKckTpHdX+U+LyfN0ivXmhcaHQLA+QfTKQXWx63PLZIvcX+cY6YoadrvX2yxENv
	 ZSeEZ8bAkK/ykO9O/lG2//gpjgkBvp/JeaAgyb1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbfKFDIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388166AbfKFDIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:17 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36F3217F4;
        Wed,  6 Nov 2019 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009696;
        bh=5ECmT8FGRoGD6l/D6ITTUE2Q2jjqPWMI3DiUs4PR6cw=;
        h=From:To:Cc:Subject:Date:From;
        b=CJ15ziau/jYm63JLGehDix5QfhcY1Uca/GkRGHKleOhRMHRtCMJg7JAwaq+dS9t+h
         Vls8DVe4fIVT6UC3Hjq5zjNv5iCTTeZ4VUz3nQxrFm71Tp2TMfAp0XpBiJjwIJw5/1
         7CMBv/m8J7XABRZNFcOrXjV4hMrMjiqYIIsyLgGE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 0/9] sched/nohz: Make the rest of kcpustat vtime aware
Date:   Wed,  6 Nov 2019 04:07:58 +0100
Message-Id: <20191106030807.31091-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we fixed CPUTIME_SYSTEM on nohz_full, now is the turn for
CPUTIME_USER, CPUTIME_NICE, CPUTIME_GUEST and CPUTIME_GUEST_NICE.

The tricky piece was to handle "nice-ness" correctly. I think I addressed
most reviews (one year ago now) from peterz
(https://lore.kernel.org/lkml/20181120141754.GW2131@hirez.programming.kicks-ass.net/)
Among which:

* Merge patches that didn't make sense together
* Clarify the changelog (I hope) and add comments
* Also hook nice updates on __setscheduler_params()
* Uninline a big function

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat-v3

HEAD: cfd377b0f261f1107ba5f3d2cf68a8ac5f359943

Thanks,
	Frederic
---

Frederic Weisbecker (9):
      sched/cputime: Allow to pass cputime index on user/guest accounting
      sched/cputime: Standardize the kcpustat index based accounting functions
      sched/vtime: Handle nice updates under vtime
      sched/cputime: Support other fields on kcpustat_field()
      sched/vtime: Bring all-in-one kcpustat accessor for vtime fields
      procfs: Use all-in-one vtime aware kcpustat accessor
      cpufreq: Use vtime aware kcpustat accessors for user time
      leds: Use all-in-one vtime aware kcpustat accessor
      rackmeter: Use vtime aware kcpustat accessor


 arch/ia64/kernel/time.c                 |   6 +-
 arch/powerpc/kernel/time.c              |   6 +-
 arch/s390/kernel/vtime.c                |   2 +-
 drivers/cpufreq/cpufreq.c               |  13 +-
 drivers/cpufreq/cpufreq_governor.c      |   6 +-
 drivers/leds/trigger/ledtrig-activity.c |   9 +-
 drivers/macintosh/rack-meter.c          |   7 +-
 fs/proc/stat.c                          |  20 +-
 include/linux/kernel_stat.h             |  25 ++-
 include/linux/sched.h                   |   1 +
 include/linux/vtime.h                   |   2 +
 kernel/sched/core.c                     |  16 +-
 kernel/sched/cputime.c                  | 378 ++++++++++++++++++++++++++------
 kernel/sched/sched.h                    |  18 ++
 14 files changed, 412 insertions(+), 97 deletions(-)
