Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF7C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E0C216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfEJQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfEJQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:38:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D817021479;
        Fri, 10 May 2019 16:38:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hP8Xf-0004lt-VX; Fri, 10 May 2019 12:38:39 -0400
Message-Id: <20190510163519.794235443@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 10 May 2019 12:35:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: [RFC][PATCH 0/2 v2] tracing/x86_32: Remove non DYNAMIC_FTRACE and mcount support
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to support either DYNAMIC_FTRACE=n or mcount (non fentry)
in x86_32. As the static tracing (DYNAMIC_FTRACE=n) does not support
fentry, we can just remove it, as the static tracing is only around to
test the static tracing in generic code as other architectures have it
but not DYNAMIC_FTRACE.

This will allow also allow us to remove klp_check_compiler_support()
in later patches.

Steven Rostedt (VMware) (2):
      ftrace/x86_32: Remove support for non DYNAMIC_FTRACE
      ftrace/x86: Remove mcount support

----
 arch/x86/Kconfig                 | 11 ++++++
 arch/x86/include/asm/ftrace.h    |  8 ++---
 arch/x86/include/asm/livepatch.h |  3 --
 arch/x86/kernel/ftrace_32.S      | 75 +++-------------------------------------
 arch/x86/kernel/ftrace_64.S      | 28 +--------------
 5 files changed, 20 insertions(+), 105 deletions(-)
