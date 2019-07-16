Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123BC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F991206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfGPH2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:28:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:34992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfGPH2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:28:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BE0BB11D;
        Tue, 16 Jul 2019 07:28:29 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] panic/printk/x86: Prevent some more printk-related deadlocks in panic()
Date:   Tue, 16 Jul 2019 09:28:03 +0200
Message-Id: <20190716072805.22445-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found some spare duct tape and wrapped some more printk-related
deadlocks in panic().

More seriously, someone reported a deadlock in panic(). Some non-trivial
debugging pointed out a problem with the following combination:

     + x86_64 architecture
     + panic()
     + pstore configured as message dumper (kmsg_dump())
     + crash kernel configured
     + crash_kexec_post_notifiers

In this case, CPUs are stopped by crash_smp_send_stop(). It uses
NMI but it does not modify cpu_online_mask. Therefore logbuf_lock
might stay locked, see 2nd patch for more details.

The above is a real corner case. But similar problem seems to be
even in the common situations on architectures that do not use
NMI in smp_send_stop() as a fallback, see 1st patch.

Back to the duct tape. I hope that we will get rid of these problems
with the lockless printk ringbuffer rather sooner than later.
But it still might take some time. And the two fixes might be
useful also for stable kernels.


Petr Mladek (2):
  printk/panic: Access the main printk log in panic() only when safe
  printk/panic/x86: Allow to access printk log buffer after
    crash_smp_send_stop()

 arch/x86/kernel/crash.c     |  6 +++++-
 include/linux/printk.h      |  6 ++++++
 kernel/panic.c              | 49 +++++++++++++++++++++++++++------------------
 kernel/printk/printk_safe.c | 37 ++++++++++++++++++++++------------
 4 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.16.4

