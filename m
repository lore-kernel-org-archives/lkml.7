Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD79C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544920885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304278;
	bh=ViOn4xX3fkceu9uxzsTzwd8e9zgSUmFxBQ7qZ3wYGXQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=I5w5bUKUW7Ez3biytuBixIvxS6VxPv1e5Rs8Q2WBLrTbJajhLkVNCFrqQcdz2Ws2t
	 LeHRilJrOFurmENvIHaOd7k6idoWdbJcHWWrU4BTqY6svQ3dIAMV5muTiqcmE2uXM2
	 lzj+4wHRAkfOQbu9vHC/kuuvOz0f+mm/h15HxQuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUCoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKUCog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:36 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66B02075A;
        Thu, 21 Nov 2019 02:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304276;
        bh=ViOn4xX3fkceu9uxzsTzwd8e9zgSUmFxBQ7qZ3wYGXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tJ1gp7hz9RITa87ooHnfpF39ppKY1N4tVOczDfTzDKxou5gksBZtY4mMGAi8ey/i5
         5dACx6tUBhcmlUbHBb8cXEI8q96BqLL6sLGtWwdnr5BedFzii6+LhGGZhoQPYC5eKv
         1nv5pylsU+ixqus5HcYBRhaauCPlF1Y2hk2NQUPk=
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
Subject: [PATCH 0/6] sched/nohz: Make the rest of kcpustat vtime aware v3
Date:   Thu, 21 Nov 2019 03:44:24 +0100
Message-Id: <20191121024430.19938-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(For the record, see v2 at
https://lore.kernel.org/lkml/20191119232218.4206-1-frederic@kernel.org/ )

This set addresses reviews from Ingo on previous take:

* Fix comment nit
* Remind in comment about the reschedule IPI that may happen on renice
* Constify input
* Indent a few blocks of assignments
* Use struct kernel_cpustat as an output for kcpustat accessor. It makes
  things easier and cleaner than the independant variables.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	nohz/kcpustat-v5

HEAD: 8941f0df7da73e1d95f0c0bed0121a14cdb52873

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      sched/cputime: Support other fields on kcpustat_field()
      sched/vtime: Bring up complete kcpustat accessor
      procfs: Use all-in-one vtime aware kcpustat accessor
      cpufreq: Use vtime aware kcpustat accessors for user time
      leds: Use all-in-one vtime aware kcpustat accessor
      rackmeter: Use vtime aware kcpustat accessor


 drivers/cpufreq/cpufreq.c               |  17 +--
 drivers/cpufreq/cpufreq_governor.c      |   6 +-
 drivers/leds/trigger/ledtrig-activity.c |  14 ++-
 drivers/macintosh/rack-meter.c          |   7 +-
 fs/proc/stat.c                          |  56 +++++-----
 include/linux/kernel_stat.h             |   7 ++
 kernel/sched/cputime.c                  | 190 ++++++++++++++++++++++++++------
 7 files changed, 223 insertions(+), 74 deletions(-)
