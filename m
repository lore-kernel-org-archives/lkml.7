Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02912070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564374373;
	bh=CzttnjlFh6UNzw5qv7d7Z1f2832TtQ+OkE9O6nLJJZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FGhDCS0hnII051OLNmkWFFnkcE/cTPttzVxbDXnva2wgpwAuDBk48VKAKPecOQ8Hq
	 pkmEWtp/bM4zw2ZqoTjTgr+xQsmqQirHaYI0JmJL01OEqqHIuwqbg3ZU6WjY7LzNoo
	 JLNPbFtbBaNmgUvGkLLIYvavPQxXbY25lRvkk1us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfG2E0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfG2E0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:26:11 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1C42075B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564374370;
        bh=CzttnjlFh6UNzw5qv7d7Z1f2832TtQ+OkE9O6nLJJZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wuvz1Bdsr270oQaXKbsBoVoUwpOdZTeaJ5DN0Sl+cVeTA6afYvndWsZuu38GDBDYW
         jx6797SZ/GtrzOwzfcQbxLYJzm8Nlvic/Vu2ic4OyHzwxGmNrGeorIeU+n89IiCcX1
         ogqPy4PB1E+EUEG0ie6213kbJehjVi6Q7zF1hI18=
Received: by mail-wm1-f43.google.com with SMTP id v15so52520680wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:26:10 -0700 (PDT)
X-Gm-Message-State: APjAAAW8VKWVB7zexCDEcjizfFQlUVukToA90wzb6W6lI3d9OsNsk8Wo
        CQFMSsX13MVUvmmXQem5FowX3MH92Ll7NkpQQ5KNcg==
X-Google-Smtp-Source: APXvYqwJ+771E+nh3CDUcgUmU42g0hgbAA6c8xaMFMiyy+NfW9b/zbOuW2go9yk5QO5L7Nl+HAyQaHd2kY9juqJ7hD4=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr36652865wme.173.1564374369164;
 Sun, 28 Jul 2019 21:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729010734.3352-1-devel@etsukata.com>
In-Reply-To: <20190729010734.3352-1-devel@etsukata.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 21:25:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
Message-ID: <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 6:08 PM Eiichi Tsukata <devel@etsukata.com> wrote:
>
> If context tracking is enabled, causing page fault in preemptirq
> irq_enable or irq_disable events triggers the following RCU EQS warning.
>

Yuck.

> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index be01a4d627c9..860eaf9780e5 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -148,6 +148,11 @@ void __context_tracking_exit(enum ctx_state state)
>                 return;
>
>         if (__this_cpu_read(context_tracking.state) == state) {
> +               /*
> +                * Change state before executing codes which can trigger
> +                * page fault leading unnecessary re-entrance.
> +                */
> +               __this_cpu_write(context_tracking.state, CONTEXT_KERNEL);

Seems reasonable.

>                 if (__this_cpu_read(context_tracking.active)) {
>                         /*
>                          * We are going to run code that may use RCU. Inform
> @@ -159,7 +164,6 @@ void __context_tracking_exit(enum ctx_state state)
>                                 trace_user_exit(0);
>                         }
>                 }
> -               __this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
>         }
>         context_tracking_recursion_exit();
>  }
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 4d8e99fdbbbe..031b51cb94d0 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
>  #include <linux/kprobes.h>
> +#include <linux/context_tracking.h>
>  #include "trace.h"
>
>  #define CREATE_TRACE_POINTS
> @@ -49,9 +50,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
>
>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>  {
> +       enum ctx_state prev_state;
> +
>         if (this_cpu_read(tracing_irq_cpu)) {
> -               if (!in_nmi())
> +               if (!in_nmi()) {
> +                       prev_state = exception_enter();
>                         trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> +                       exception_exit(prev_state);
> +               }
>                 tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
>                 this_cpu_write(tracing_irq_cpu, 0);
>         }

This seems a bit distressing.  Now we're going to do a whole bunch of
context tracking transitions for each kernel entry.  Would a better
fix me to change trace_hardirqs_on_caller to skip the trace event if
the previous state was already IRQs on and, more importantly, to skip
tracing IRQs off if IRQs were already off?  The x86 code is very
careful to avoid ever having IRQs on and CONTEXT_USER at the same
time.

--Andy
