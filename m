Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E40C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE392245D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574205749;
	bh=i0NUgNq4gMl9UfHnh8U9xWiSPOocqT4BEPzUo/pGTFA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q01ktleqD6tVjoffAI0ZjftfU06rj5gQ4zA4RTlpyxb2PLEmixPeY5wcSQ7FF553b
	 DyQsSPgu6ePTU9vr5aYRUCI3UElPtTyLKj1DlzmTMTA8l+dgwi4sZmsAXC3T+8JO3Y
	 XPICiSjM2d11fLu/xjhPikucWxe/GjHL3sQZqRWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKSXW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfKSXW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:22:27 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C30C222DF;
        Tue, 19 Nov 2019 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574205746;
        bh=i0NUgNq4gMl9UfHnh8U9xWiSPOocqT4BEPzUo/pGTFA=;
        h=From:To:Cc:Subject:Date:From;
        b=J3m1PSLNZbm+lpPkvQXvRwcbuyG2i7RlNtH/EUSM2CCmBs2ackC9+WylAc/rTXv4J
         7WERSplOcy/RkhSTPuvf1mq0Fl9/uBrP3t3jmMi7LmbTsccTpHyXvdP51vN53zytnV
         JofxOWauCDLYqoDTmiQrcC09pgxyLWYUAPJAHX2I=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/6] sched/nohz: Make the rest of kcpustat vtime aware v2
Date:   Wed, 20 Nov 2019 00:22:12 +0100
Message-Id: <20191119232218.4206-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(See https://lore.kernel.org/lkml/20191106030807.31091-1-frederic@kernel.org/
for the record)

After review from Peter, I eventually gave up with the idea of fixing
the nice fields of kcpustat. Therefore if a nice update happens on a
task while it runs on a nohz_full CPU, the whole cputime will be
accounted under the nice value observed at accounting time, hence the
possibility of a nice VS unnice kcpustat inacurrate distribution.

But that's a lesser evil compared to interrupting a nohz_full CPU, which
would be required to fix that. Also users of nohz_full shouldn't care
about nice at all since a single task is expected to run on the CPU.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat-v4

HEAD: dd59f186dc21e164097f659b4d60815e232f9555

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      sched/cputime: Support other fields on kcpustat_field()
      sched/vtime: Bring all-in-one kcpustat accessor for vtime fields
      procfs: Use all-in-one vtime aware kcpustat accessor
      cpufreq: Use vtime aware kcpustat accessors for user time
      leds: Use all-in-one vtime aware kcpustat accessor
      rackmeter: Use vtime aware kcpustat accessor


 drivers/cpufreq/cpufreq.c               |  13 ++-
 drivers/cpufreq/cpufreq_governor.c      |   6 +-
 drivers/leds/trigger/ledtrig-activity.c |   9 +-
 drivers/macintosh/rack-meter.c          |   7 +-
 fs/proc/stat.c                          |  20 ++--
 include/linux/kernel_stat.h             |  23 ++++
 kernel/sched/cputime.c                  | 192 ++++++++++++++++++++++++++------
 7 files changed, 216 insertions(+), 54 deletions(-)
