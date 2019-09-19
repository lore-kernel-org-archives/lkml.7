Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE44C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EC4217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405641AbfISXYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390655AbfISXYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:24:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FE8214AF;
        Thu, 19 Sep 2019 23:24:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iB5mJ-0000eb-FE; Thu, 19 Sep 2019 19:23:59 -0400
Message-Id: <20190919232313.198902049@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 19:23:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Final updates before sending to Linus
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: b78b94b82122208902c0f83805e614e1239f9893


Andy Shevchenko (1):
      tracing: Be more clever when dumping hex in __print_hex()

Changbin Du (1):
      ftrace: Simplify ftrace hash lookup code in clear_func_from_hash()

Masami Hiramatsu (4):
      tracing/kprobe: Fix NULL pointer access in trace_porbe_unlink()
      tracing/probe: Fix to allow user to enable events on unloaded modules
      tracing/probe: Reject exactly same probe event
      selftests/ftrace: Update kprobe event error testcase

Steven Rostedt (VMware) (1):
      selftests/ftrace: Select an existing function in kprobe_eventname test

Tom Zanussi (1):
      tracing: Make sure variable reference alias has correct var_ref_idx

----
 kernel/trace/ftrace.c                              |  6 +-
 kernel/trace/trace_events_hist.c                   |  2 +
 kernel/trace/trace_kprobe.c                        | 69 +++++++++++++++-------
 kernel/trace/trace_output.c                        |  6 +-
 kernel/trace/trace_probe.c                         | 11 ++--
 kernel/trace/trace_probe.h                         |  3 +-
 kernel/trace/trace_uprobe.c                        | 52 +++++++++++++---
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       | 16 ++++-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  1 +
 9 files changed, 123 insertions(+), 43 deletions(-)
