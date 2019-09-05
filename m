Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E750AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D3922CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfIEMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfIEMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcM-0007t8-7r; Thu, 05 Sep 2019 14:12:02 +0200
Message-Id: <20190905120339.561100423@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 0/6] posix-cpu-timers: Fallout fixes and permission tightening
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysbot triggered an issue in the posix timer rework which was trivial to
fix, but after running another test case I discovered that the rework broke
the permission checks subtly. That's also a straightforward fix.

Though when staring at it I discovered that the permission checks for
process clocks and process timers are completely bonkers. The only
requirement is that the target PID is a group leader. Which means that any
process can read the clocks and attach timers to any other process without
priviledge restrictions.

That's just wrong because the clocks and timers can be used to observe
behaviour and both reading the clocks and arming timers adds overhead and
influences runtime performance of the target process.

The last 4 patches deal with that and introduce ptrace based permission
checks and also make the behaviour consistent between thread and process
timers/clocks.

Thanks,

	tglx
---
 include/linux/posix-timers.h   |    9 +---
 kernel/time/posix-cpu-timers.c |   78 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 18 deletions(-)



