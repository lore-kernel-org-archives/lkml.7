Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D075C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0105B21911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfGVKdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:33:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGVKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:33:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E54728;
        Mon, 22 Jul 2019 03:33:40 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E90F3F71A;
        Mon, 22 Jul 2019 03:33:39 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: Allow early timestamping of kernel log
Date:   Mon, 22 Jul 2019 11:33:27 +0100
Message-Id: <20190722103330.255312-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, we've let the arm64 kernel start its meaningful time stamping
of the kernel log pretty late, which is caused by sched_clock() being
initialised rather late compared to other architectures.

Pavel Tatashin proposed[1] to move the initialisation of sched_clock
much earlier, which I had objections to. The reason for initialising
sched_clock late is that a number of systems have broken counters, and
we need to apply all kind of terrifying workarounds to avoid time
going backward on the affected platforms. Being able to identify the
right workaround comes pretty late in the kernel boot, and providing
an unreliable sched_clock, even for a short period of time, isn't an
appealing prospect.

To address this, I'm proposing that we allow an architecture to chose
to (1) divorce time stamping and sched_clock during the early phase of
booting, and (2) inherit the time stamping clock as the new epoch the
first time a sched_sched clock gets registered.

(1) would allow arm64 to provide a time stamping clock, however
unreliable it might be, while (2) would allow sched_clock to provide
time stamps that are continuous with the time-stamping clock.

The last patch in the series adds the necessary logic to arm64,
allowing the (potentially unreliable) time stamping of early kernel
messages.

Tested on a bunch of arm64 systems, both bare-metal and in VMs. Boot
tested on a x86 guest.

[1] https://lore.kernel.org/patchwork/patch/1015110/

Marc Zyngier (3):
  printk: Allow architecture-specific timestamping function
  sched/clock: Allow sched_clock to inherit timestamp_clock epoch
  arm64: Allow early time stamping

 arch/arm64/Kconfig          |  3 +++
 arch/arm64/kernel/setup.c   | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/sched/clock.h | 13 +++++++++++
 kernel/printk/printk.c      |  4 ++--
 kernel/time/sched_clock.c   | 10 +++++++++
 5 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.20.1

