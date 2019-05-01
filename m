Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C178EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997022089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEAUby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfEAUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:31:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8CD20656;
        Wed,  1 May 2019 20:31:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hLvtQ-0006Y2-Ah; Wed, 01 May 2019 16:31:52 -0400
Message-Id: <20190501202830.347656894@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 01 May 2019 16:28:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 0/2] ftrace/x86: Allow for breakpoint handlers to emulate call functions
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I split Peter's patch up into two. One that implements the gap in the
breakpoint handler, and supplies the helper functions. And the other one
that adds ftrace as the user of that code.

Peter, I need an offical "Signed-off-by" from you for these.

I'm currently running them through my full test suite (which will also
test 32bit). If they work I think these may be the final set to go.

Let me know if there's any issues.

-- Steve



Peter Zijlstra (2):
      x86: Allow breakpoints to emulate call functions
      ftrace/x86: Emulate call function while updating in breakpoint handler

----
 arch/x86/entry/entry_32.S            | 11 +++++++++++
 arch/x86/entry/entry_64.S            | 14 ++++++++++++--
 arch/x86/include/asm/text-patching.h | 20 ++++++++++++++++++++
 arch/x86/kernel/ftrace.c             | 25 ++++++++++++++++++++-----
 4 files changed, 63 insertions(+), 7 deletions(-)
