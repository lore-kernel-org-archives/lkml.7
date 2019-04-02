Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A998C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9A1206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDBUEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfDBUEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48BC390B10;
        Tue,  2 Apr 2019 20:04:09 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 929136014D;
        Tue,  2 Apr 2019 20:04:05 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [RFC PATCH 0/7] Early task context tracking
Date:   Tue,  2 Apr 2019 22:03:52 +0200
Message-Id: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Apr 2019 20:04:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: do not take it too seriously, it is just a proof of concept.

Some time ago, while using perf to check the automaton model, I noticed
that perf was losing events. The same was reproducible with ftrace.

See: https://www.spinics.net/lists/linux-rt-users/msg19781.html

Steve pointed to a problem in the identification of the context
execution used by the recursion control.

Currently, recursion control uses the preempt_counter to
identify the current context. The NMI/HARD/SOFT IRQ counters
are set in the preempt_counter in the irq_enter/exit functions.

In a trace, they are set like this:
-------------- %< --------------------
 0)   ==========> |
 0)               |  do_IRQ() {		/* First C function */
 0)               |    irq_enter() {
 0)               |      		/* set the IRQ context. */
 0)   1.081 us    |    }
 0)               |    handle_irq() {
 0)               |     		/* IRQ handling code */
 0) + 10.290 us   |    }
 0)               |    irq_exit() {
 0)               |      		/* unset the IRQ context. */
 0)   6.657 us    |    }
 0) + 18.995 us   |  }
 0)   <========== |
-------------- >% --------------------

As one can see, functions (and events) that take place before the set
and after unset the preempt_counter are identified in the wrong context,
causing the miss interpretation that a recursion is taking place.
When this happens, events are dropped.

To resolve this problem, the set/unset of the IRQ/NMI context needs to
be done before the execution of the first C execution, and after its
return. By doing so, and using this method to identify the context in the
trace recursion protection, no more events are lost.

A possible solution is to use a per-cpu variable set and unset in the
entry point of NMI/IRQs, before calling the C handler. This possible
solution is presented in the next patches as a proof of concept, for
x86_64. However, other ideas might be better than mine... so...

Daniel Bristot de Oliveira (7):
  x86/entry: Add support for early task context tracking
  trace: Move the trace recursion context enum to trace.h and reuse it
  trace: Optimize trace_get_context_bit()
  trace/ring_buffer: Use trace_get_context_bit()
  trace: Use early task context tracking if available
  events: Create an trace_get_context_bit()
  events: Use early task context tracking if available

 arch/x86/entry/entry_64.S       |  9 ++++++
 arch/x86/include/asm/irqflags.h | 30 ++++++++++++++++++++
 arch/x86/kernel/cpu/common.c    |  4 +++
 include/linux/irqflags.h        |  4 +++
 kernel/events/internal.h        | 50 +++++++++++++++++++++++++++------
 kernel/softirq.c                |  5 +++-
 kernel/trace/ring_buffer.c      | 28 ++----------------
 kernel/trace/trace.h            | 46 ++++++++++++++++++++++--------
 8 files changed, 129 insertions(+), 47 deletions(-)

-- 
2.20.1

