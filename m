Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA51C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1D2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfCZPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:17:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42183 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:17:17 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h8npE-0002v5-0t
        for linux-kernel@vger.kernel.org; Tue, 26 Mar 2019 15:17:16 +0000
Received: by mail-wm1-f71.google.com with SMTP id 16so6663282wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCTT4HeI24lZ4s3NPPhbU2k8cL7vAe8DX3JDmVZbazM=;
        b=Hri7cngtoKyYsqmAxqjtCirWHBTwU+pf8B8IuFgBU+4YKcC85p6ouMyM9Tr/e0GCOR
         s/6wpPCbNhJZFDfKWT3HReAjVUNLPPwRx1dg3Eh7qSJW/U9N34klBXwF1tAs+sG4+vJP
         SztMtsx3MRZIrYR+RCLN8sdiIFybJ1iuBlz8eX/Sb1mm6K5I79OE60niMACf4O+4onV3
         00ZU773mXQkuRYlmmmPMQ6oThc70/mYjkGJYDVWgq7zZuQjc8/e8KTPkNzsa5UKsHNoZ
         FMRRhdDnP07NklgifMyyVcRAwN06gwd3PaaqxFj9yLfrX+la6jLDUO0ixN5a8lqdh4nC
         8MzQ==
X-Gm-Message-State: APjAAAXUf41X7nDW6E8XynnCVt8+7iW2hGKLWf19/FBzqilpyp+lsQnr
        K5n+aDuNAflUNsWCHon2Q7djC0kkvlc4p4KZ2n4//Nnzyu7YXpa50sOHyVPfUZyd8ospB0yuJz8
        KPk2Xxjxu/fwynRuqL893mmGTnJTpepKMsEYRKni7qw==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr21012580wru.164.1553613435338;
        Tue, 26 Mar 2019 08:17:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBivHfydn7RNtyhMoWS2CRXpu/+cBaGqpJDTh8Uwk5fIUH7OqwkveILOhcoG4eG45wE1pVvw==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr21012571wru.164.1553613435168;
        Tue, 26 Mar 2019 08:17:15 -0700 (PDT)
Received: from localhost (host118-125-dynamic.3-87-r.retail.telecomitalia.it. [87.3.125.118])
        by smtp.gmail.com with ESMTPSA id x192sm21091566wmf.48.2019.03.26.08.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:17:14 -0700 (PDT)
Date:   Tue, 26 Mar 2019 16:17:13 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip v3 04/10] x86/kprobes: Prohibit probing on IRQ
 handlers directly
Message-ID: <20190326151713.GB27897@xps-13>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
 <154998796400.31052.8406236614820687840.stgit@devbox>
 <20190325172334.559f8c5b@gandalf.local.home>
 <20190326235052.793b81b121021020fb3b1e93@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326235052.793b81b121021020fb3b1e93@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:50:52PM +0900, Masami Hiramatsu wrote:
> On Mon, 25 Mar 2019 17:23:34 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 13 Feb 2019 01:12:44 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Prohibit probing on IRQ handlers in irqentry_text because
> > > if it interrupts user mode, at that point we haven't changed
> > > to kernel space yet and which eventually leads a double fault.
> > > E.g.
> > > 
> > >  # echo p apic_timer_interrupt > kprobe_events
> > 
> > Hmm, this breaks one of my tests (which I probe on do_IRQ).
> 
> OK, it seems this patch is a bit redundant, because
> I found that these interrupt handler issue has been fixed
> by Andrea's commit before merge this patch.
> 
> commit a50480cb6d61d5c5fc13308479407b628b6bc1c5
> Author: Andrea Righi <righi.andrea@gmail.com>
> Date:   Thu Dec 6 10:56:48 2018 +0100
> 
>     kprobes/x86: Blacklist non-attachable interrupt functions
>     
>     These interrupt functions are already non-attachable by kprobes.
>     Blacklist them explicitly so that they can show up in
>     /sys/kernel/debug/kprobes/blacklist and tools like BCC can use this
>     additional information.
> 
> This description is a bit odd (maybe his patch is after mine?) I think
> while updating this series, the patches were merged out of order.
> Anyway, with above patch, the core problematic probe points are blacklisted.

This is the previous thread when I posted my patch (not sure if it helps
to figure out what happened - maybe it was just an out of order merge
issue, like you said):

https://lkml.org/lkml/2018/12/6/212

> 
> > 
> > It's been working for years.
> > 
> > 
> > >  # echo 1 > events/kprobes/enable
> > >  PANIC: double fault, error_code: 0x0
> > >  CPU: 1 PID: 814 Comm: less Not tainted 4.20.0-rc3+ #30
> > >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> > >  RIP: 0010:error_entry+0x12/0xf0
> > >  [snip]
> > >  Call Trace:
> > >   <ENTRY_TRAMPOLINE>
> > >   ? native_iret+0x7/0x7
> > >   ? async_page_fault+0x8/0x30
> > >   ? trace_hardirqs_on_thunk+0x1c/0x1c
> > >   ? error_entry+0x7c/0xf0
> > >   ? async_page_fault+0x8/0x30
> > >   ? native_iret+0x7/0x7
> > >   ? int3+0xa/0x20
> > >   ? trace_hardirqs_on_thunk+0x1c/0x1c
> > >   ? error_entry+0x7c/0xf0
> > >   ? int3+0xa/0x20
> > >   ? apic_timer_interrupt+0x1/0x20
> > >   </ENTRY_TRAMPOLINE>
> > >  Kernel panic - not syncing: Machine halted.
> > >  Kernel Offset: disabled
> > 
> > I'm not able to reproduce this (by removing this commit). 
> 
> I ensured that if I revert both of this patch and Andrea's patch,
> I can reproduce this with probing on apic_timer_interrupt().
> 
> > I'm thinking something else may have changed, as I've been tracing
> > interrupt entries for years, and interrupting userspace while doing
> > this.
> > 
> > I've even added probes where ftrace isn't (where it uses an int3) and
> > still haven't hit a problem.
> > 
> > I think this patch is swatting a symptom of a bug and not addressing
> > the bug itself. Can you send me the config that triggers this?
> 
> Yes, it seems you're right. Andrea's commit specifically fixed the
> issue and mine is redundant. (I'm not sure why do_IRQ is in 
> __irqentry_text...)

Not sure if there are specific reasons for that, but do_IRQ is part of
__irqentry_text because it's explicitly marked with __irq_entry.

> 
> So, Ingo, please revert this, since this bug already has been fixed by
> commit a50480cb6d61 ("kprobes: x86_64: blacklist non-attachable interrupt
> functions")
> 
> BTW, for further error investigation, I attached my kconfig which is
> usually I'm testing (some options can be changed) on Qemu.
> I'm using my mini-container shellscript ( https://github.com/mhiramat/mincs 
> ) which supports qemu-container.
> 
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
-Andrea
