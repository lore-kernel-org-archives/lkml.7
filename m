Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45464C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AB021835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfLECFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLECFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:05:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063592077B;
        Thu,  5 Dec 2019 02:05:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1icgWa-000oAr-4L; Wed, 04 Dec 2019 21:05:48 -0500
Message-Id: <20191205020459.023316620@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 04 Dec 2019 21:04:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] [GIT PULL] tracing: three more updates
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two fixes and one patch that was missed:

 Fixes:

  - Missing __print_hex_dump undef for processing new function in trace events
  - Stop WARN_ON messages when lockdown disables tracing on boot up

 Enhancement:

  - Debug option to inject trace events from userspace (for rasdaemon)

The enhancement has its own config option and is non invasive. It's been
discussed for sever months and should have been added to my original
push, but I never pulled it into my queue.

Please pull the latest trace-v5.5-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.5-2

Tag SHA1: 075c954bfa42bcd2dad254f1fe6fcd81197512de
Head SHA1: a356646a56857c2e5ad875beec734d7145ecd49a


Cong Wang (1):
      tracing: Introduce trace event injection

Piotr Maziarz (1):
      tracing: Fix __print_hex_dump scope

Steven Rostedt (VMware) (1):
      tracing: Do not create directories if lockdown is in affect

----
 include/trace/trace_events.h       |   1 +
 kernel/trace/Kconfig               |   9 +
 kernel/trace/Makefile              |   1 +
 kernel/trace/ring_buffer.c         |   6 +
 kernel/trace/trace.c               |  17 ++
 kernel/trace/trace.h               |   1 +
 kernel/trace/trace_events.c        |   6 +
 kernel/trace/trace_events_inject.c | 331 +++++++++++++++++++++++++++++++++++++
 8 files changed, 372 insertions(+)
 create mode 100644 kernel/trace/trace_events_inject.c
