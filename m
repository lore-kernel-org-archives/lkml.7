Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D52AC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE602083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDKCe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfDKCe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71ABD7D7D5;
        Thu, 11 Apr 2019 02:34:28 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F04B13ABE;
        Thu, 11 Apr 2019 02:34:27 +0000 (UTC)
Date:   Wed, 10 Apr 2019 21:34:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC patch 16/41] tracing: Remove the ULONG_MAX stack trace
 hackery
Message-ID: <20190411023425.f7aolamijvxdcuvp@treble>
References: <20190410102754.387743324@linutronix.de>
 <20190410103645.048761764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410103645.048761764@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 11 Apr 2019 02:34:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:28:10PM +0200, Thomas Gleixner wrote:
> No architecture terminates the stack trace with ULONG_MAX anymore. As the
> code checks the number of entries stored anyway there is no point in
> keeping all that ULONG_MAX magic around.
> 
> The histogram code zeroes the storage before saving the stack, so if the
> trace is shorter than the maximum number of entries it can terminate the
> print loop if a zero entry is detected.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c |    2 +-
>  kernel/trace/trace_stack.c       |   20 +++++---------------
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5246,7 +5246,7 @@ static void hist_trigger_stacktrace_prin
>  	unsigned int i;
>  
>  	for (i = 0; i < max_entries; i++) {
> -		if (stacktrace_entries[i] == ULONG_MAX)
> +		if (!stacktrace_entries[i])
>  			return;
>  
>  		seq_printf(m, "%*c", 1 + spaces, ' ');
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -18,8 +18,7 @@
>  
>  #include "trace.h"
>  
> -static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
> -	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
> +static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES + 1];

Is the "+ 1" still needed?  AFAICT, accesses to this array never go past
nr_entries.

Also I've been staring at the code but I can't figure out why
max_entries is "- 1".

struct stack_trace stack_trace_max = {
	.max_entries		= STACK_TRACE_ENTRIES - 1,
	.entries		= &stack_dump_trace[0],
};

-- 
Josh
