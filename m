Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C4214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCDWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDWHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:07:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D43C2070B;
        Mon,  4 Mar 2019 22:07:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h0vjv-0000iB-52; Mon, 04 Mar 2019 17:07:15 -0500
Message-Id: <20190304220615.385873907@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Mar 2019 17:06:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Simple fix and clean up for 5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This is a "pre-pull". It's only one small fix and one small clean up.
I'm testing a few small patches for my real pull request which will
come at a later time. The second patch depends on your tree anyway
so I included it along with the urgent fix.

A small fix Pavel sent me back in august was accidentally lost due to it
being placed with some other patches that failed some tests, and was rebased
out of my local tree. Which was a regression that caused event filters
not to handle negative numbers.

The clean up is from Masami that realized that the code in kprobes that
calls probe_mem_read() wrapper, which is to be used in code used by both
kprobes and uprobes, was only in code for kprobes. It should not use the
wrapper there, but instead call probe_kernel_read() directly.

Please pull the latest trace-v5.0-pre tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.0-pre

Tag SHA1: 6c5b335a8c8d7d98c09d10e15058f8325ff2cf9d
Head SHA1: 49ef5f45701c3dedc6aa6efee5d03756fea0f99d


Masami Hiramatsu (1):
      tracing/kprobes: Use probe_kernel_read instead of probe_mem_read

Pavel Tikhomirov (1):
      tracing: Fix event filters and triggers to handle negative numbers

----
 kernel/trace/trace_events_filter.c | 5 ++++-
 kernel/trace/trace_kprobe.c        | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
