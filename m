Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF967C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9DD2231F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbfHGR3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388501AbfHGR3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:29:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B7B2229C;
        Wed,  7 Aug 2019 17:29:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hvPkJ-0007yx-2L; Wed, 07 Aug 2019 13:29:07 -0400
Message-Id: <20190807172826.352574408@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 07 Aug 2019 13:28:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2 v2] tracing/arm: Fix the stack tracer when LR is saved after local storage
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As arm64 saves the link register after a function's local variables are
stored, it causes the max stack tracer to be off by one in its output
of which function has the bloated stack frame.

The first patch fixes this by creating a ARCH_RET_ADDR_BEFORE_LOCAL_VARS
define that an achitecture (arm64) may set in asm/ftrace.h, and this
will cause the stack tracer to make the shift.

As it has been proven that the stack tracer isn't the most trivial
algorithm to understand by staring at the code, the second patch adds
comments to the code to explain the algorithm with and without the
ARCH_RET_ADDR_BEFORE_LOCAL_VARS.

Hmm, should this be sent to stable (and for inclusion now?)

-- Steve

Changes since v1:

 - Fixed wrong value in stack_trace_index[] array in comment

 - Added a comment about gcc currently saves the LR after local variables,
   but there's no guarantee that it will be like that in the future.
   (Notified of this by Mark Rutland)

Steven Rostedt (VMware) (2):
      tracing/arm64: Have max stack tracer handle the case of return address after data
      tracing: Document the stack trace algorithm in the comments

----
 arch/arm64/include/asm/ftrace.h |  13 +++++
 kernel/trace/trace_stack.c      | 112 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
