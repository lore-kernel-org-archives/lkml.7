Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FEDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E533F21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502966AbfJXPA1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502956AbfJXPA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:00:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64232166E;
        Thu, 24 Oct 2019 15:00:25 +0000 (UTC)
Date:   Thu, 24 Oct 2019 11:00:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024110024.324a9435@gandalf.local.home>
In-Reply-To: <20191024101609.GA4131@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
        <20191018074634.801435443@infradead.org>
        <20191021222110.49044eb5@oasis.local.home>
        <20191022202401.GO1817@hirez.programming.kicks-ass.net>
        <20191023145245.53c75d70@gandalf.local.home>
        <20191024101609.GA4131@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 12:16:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 23, 2019 at 02:52:45PM -0400, Steven Rostedt wrote:
> > After applying this series and this patch I triggered this:  
> 
> Bah, I hate C.
> 
> (also for some reason I had KPROBE_EVENTS disabled, when I enabled it it
> failed on boot due to selftests)
> 
> this one seems to boot and survive your selftests thing (that takes for
> bloody ever to run).
> 

Care to enable CONFIG_HIST_TRIGGERS?

  CC [M]  drivers/gpu/drm/i915/gem/i915_gem_context.o
/work/git/linux-trace.git/kernel/trace/trace_events_hist.c: In function ‘register_synth_event’:
/work/git/linux-trace.git/kernel/trace/trace_events_hist.c:1157:15: error: ‘struct trace_event_class’ has no member named ‘define_fields’; did you mean ‘get_fields’?
  call->class->define_fields = synth_event_define_fields;
               ^~~~~~~~~~~~~
               get_fields
make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:265: kernel/trace/trace_events_hist.o] Error 1
make[3]: *** Waiting for unfinished jobs....

-- Steve
