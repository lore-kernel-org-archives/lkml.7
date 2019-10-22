Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C1A2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT4hV1Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbfJVUq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:46:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbfJVUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:46:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so10669504pgk.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DAp3p0mZdXn6xiYKus4DMfpoChlQo3Gj1FHfH6+NAQ=;
        b=jT4hV1Ci1hMyB12C5lrqcacviAlp8tbktomotS9dTlof24qaAX0aY2zP/EoS+lJYgS
         9E2Cf0D3T3rDkPHyvmlNrI7Dr/TVKv31S2nk2eMFMOQXosjLSiuFNuZCHmcok6QADhC+
         lJ0dqILrxc0GGgSGxAZLa8xe7mgOZstNCjDMSrtu5xxPtO9073zQB0KchOgpjzqGUyi1
         fc925b3KejOBstHIdtjoFmerJYacRkdzO3qpY3YeGvhPEo04aeytFLj3Mju4iGkRB9Ad
         rcm2+hVm+HP3veptMZ8UBgvBVFdTABd0e+SdYlg4Tbj59p+RKf96MdI53FFcSwu8xwcP
         DVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DAp3p0mZdXn6xiYKus4DMfpoChlQo3Gj1FHfH6+NAQ=;
        b=QGO4fXzS3ebf12GCfRAIc+aeJC58aZXKwtY1xY2JTrhEa+OC2bh8a8VMrsCfUFygH9
         jGCE/zIWoNqeN40NZJzoLFC8/Vu30x+iwdTnFyKQxGbFzgAGU1Ootn1RjX7JkwWyl++X
         WYgIwnoDEubX5q62vRwCoOb6eCLGxHYYKj820HMD1A6FA1saNVOateomwGsibTya9BA+
         e72wcitBbzMJp6FxuDKtF6WEtwqkeLpgObpvq/FLRQIPgN+OliMKYTRBlOZoEoQ2KRod
         2wwHwHBOSrVFyIDJfO5aURjiab90hkKwq0yK3T2Av+RZqT1JUGWrknVuZ4QMzSfPccdO
         C8hg==
X-Gm-Message-State: APjAAAXVUKksCvXApz6LcFSsKC4yJg3eH9kWJrQgDDYzPIXPXdrEtjLM
        srK2cq0WAeZCX5kCn8lQ8W4=
X-Google-Smtp-Source: APXvYqzHB6PwFfwW4Xm0au7mHzXGJ4V21QPryC+q0H8GOFpvZNgDvs6hD0t+onvR5y+bMGiuTy9RiA==
X-Received: by 2002:a62:685:: with SMTP id 127mr6262398pfg.211.1571777186133;
        Tue, 22 Oct 2019 13:46:26 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1833])
        by smtp.gmail.com with ESMTPSA id i37sm18281370pje.23.2019.10.22.13.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 13:46:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:46:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
 <20191021204310.3c26f730@oasis.local.home>
 <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
 <20191021231630.49805757@oasis.local.home>
 <20191021231904.4b968dc1@oasis.local.home>
 <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
 <20191022071956.07e21543@gandalf.local.home>
 <20191022094455.6a0a1a27@gandalf.local.home>
 <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
 <20191022141021.2c4496c2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022141021.2c4496c2@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 02:10:21PM -0400, Steven Rostedt wrote:
> On Tue, 22 Oct 2019 10:50:56 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > +static void my_hijack_func(unsigned long ip, unsigned long pip,
> > > +			   struct ftrace_ops *ops, struct pt_regs *regs)  
> > 
> > 1.
> > To pass regs into the callback ftrace_regs_caller() has huge amount
> > of stores to do. Saving selector registers is not fast. pushf/popf are even slower.
> > ~200 bytes of stack is being used for save/restore.
> > This is pure overhead that bpf execution cannot afford.
> > bpf is different from traditional ftrace and other tracing, since
> > it's often active 24/7. Every nanosecond counts.
> 
> Live patching is the same as what you have. If not even more critical.
> 
> Note, it would be easy to also implement a "just give me IP regs" flag,
> or have that be the default if IPMODIFY is set and REGS is not.

And that will reduce overhead from 20+ regs save/restore into 3-4 ?
Say, it's only two regs (rbp and rip). Why bpf side has to pay this runtime
penalty? I see no good technical reason.

> 
> > So for bpf I'm generating assembler trampoline tailored to specific kernel
> > function that has its fentry nop replaced with a call to that trampoline.
> > Instead of 20+ register save I save only arguments of that kernel function.
> > For example the trampoline that attaches to kfree_skb() will save only two registers
> > (rbp and rdi on x86) and will use 16 bytes of stack.
> > 
> > 2.
> > The common ftrace callback api allows ftrace infra to use generic ftrace_ops_list_func()
> > that works for all ftracers, but it doesn't scale.
> 
> That only happens if you have more than one callback to a same
> function. Otherwise you get a dedicated trampoline.

That's exactly what I tried to explain below. We have production use case
with 2 kprobes (backed by ftrace) at the same function.
fwiw the function is tcp_retransmit_skb.

> > We see different teams writing bpf services that attach to the same function.
> > In addition there are 30+ kprobes active in other places, so for every
> > fentry the ftrace_ops_list_func() walks long linked list and does hash
> > lookup for each. That's not efficient and we see this slowdown in practice.
> > Because of unique trampoline for every kernel function single
> > generic list caller is not possible.
> > Instead generated unique trampoline handles all attached bpf program
> > for this particular kernel function in a sequence of calls.
> 
> Why not have a single ftrace_ops() that calls this utility and do the
> multiplexing then?

because it's not an acceptable overhead.

> > No link lists to walk, no hash tables to lookup.
> > All overhead is gone.
> > 
> > 3.
> > The existing kprobe bpf progs are using pt_regs to read arguments. Due to
> 
> That was done because kprobes in general work off of int3. And the
> saving of pt_regs was to reuse the code and allow kprobes to work both
> with or without a ftrace helper.

sure. that makes sense. That's why ftrace-based kprobes are the best
and fastest kernel infra today for bpf to attach to.
But after using it all in prod we see that it's too slow for ever growing
demands which are bpf specific. All the optimizations that went
into kprobe handling do help. No doubt about that. But here I'm talking
about removing _all_ overhead. Not just making kprobe 2-3 times faster.

> > that ugliness all of them are written for single architecture (x86-64).
> > Porting them to arm64 is not that hard, but porting to 32-bit arch is close
> > to impossible. With custom generated trampoline we'll have bpf progs that
> > work as-is on all archs. raw_tracepoint bpf progs already demonstrated
> > that such portability is possible. This new kprobe++ progs will be similar.
> > 
> > 4.
> > Due to uniqueness of bpf trampoline sharing trampoline between ftracers
> > and bpf progs is not possible, so users would have to choose whether to
> > ftrace that particular kernel function or attach bpf to it.
> > Attach is not going to stomp on each other. I'm reusing ftrace_make_call/nop
> > approach that checks that its a 'nop' being replaced.
> 
> What about the approach I showed here? Just register a ftrace_ops with
> ip modify set, and then call you unique trampoline directly.

It's 100% unnecessary overhead.

> It would keep the modification all in one place instead of having
> multiple implementations of it. We can make ftrace call your trampoline
> just like it was called directly, without writing a whole new
> infrastructure.

That is not true at all.
I haven't posted the code yet, but you're already arguing about
hypothetical code duplication.
There is none so far. I'm not reinventing ftrace.
There will be no FTRACE_OPS_FL_* flags, no ftrace_ops equivalent.
None of it applies.
Since Peter is replacing ftrace specific nop->int3->call patching
with text_poke() I can just use that.

