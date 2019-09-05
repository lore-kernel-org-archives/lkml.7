Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DCC00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AC3206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c//c8CR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbfIEQtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:49:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45683 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389229AbfIEQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:49:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so1542414plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6DdguLvpsjaqo1lAmRSLNlZYbZ+JCGQjvxznUaMzTI=;
        b=c//c8CR3CeKTHpkY1e60ykUjFtWvCTwYYIu4ZtBmF+C02FkkgM93ytDGJYQ4LuHlam
         IqmTalKEpb0IMhzFi+CmNqN9Ol9EBP7YwFiDQyig0qyu7HDZRVQNpX0tokzkp8kQuq2V
         tFKHRE2O3kZWyNHrX3P1ZIwuyYVLs0k2sT6fLv661VId9qIqH2fPI7WaX8mAVruZlBTj
         jlPncrpwl/G/PVVsbI2ooHkU9yIQFv+x05yImzeIL9B4gPJQeM0I1wF+qu+WWO0qmKzL
         9B+siYWXDopmE0bXbyYTOgPsZQ+G7aSTI+YYc0uXPU9OVkBFe9bKOStBuGaCOke59yoa
         d+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6DdguLvpsjaqo1lAmRSLNlZYbZ+JCGQjvxznUaMzTI=;
        b=EcR6iCEHq7KBkq8NX5+GWlmgQ8kuteh6eY2YhQnYALGp9KWbkWwb9TUugyuiiekag0
         wHwa/Pp1Imnki21W7brZhlU24SNe82sH8oYLzPaXWPUZbu74YAWLCCH2kABqwSAZq81j
         crgAr0hpz7WLUEESNbrtThRXycMuyVQD5mHDtcpVlY+dj5Tbk4lEzM9x0iTDuujsvwcc
         t5hI8W+7wqhGUtQazk5YiALjMqX1TzinqZe/kI+KbUV9htlIflz3By05UOCHG3+loWKG
         JwGOLcCjmLo1SW8UBCOQnC3KDtVVcrvSVoMZc6znLRrlgM4yCIg8wj2AQ1u8HqetZhSC
         sIXQ==
X-Gm-Message-State: APjAAAW9lAkYskWZcl1P7cPJEetcYhqPOfPBjvFLWxWpU91mVr0IMjCN
        sDdv2LfLD2EqxevumnQ0tcE=
X-Google-Smtp-Source: APXvYqy5FTSj1o4qiUifTBZryJq5dflpS2JHAw2RAL+7NfZGM87jUh0fwlVBE09na3kPvS080r4Tgg==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr4553227pld.284.1567702162891;
        Thu, 05 Sep 2019 09:49:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:e84e])
        by smtp.gmail.com with ESMTPSA id l10sm2563407pgt.93.2019.09.05.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:49:21 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:49:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?utf-8?Q?Hladk=C3=BD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190905164918.qoufootukks6egtl@ast-mbp.dhcp.thefacebook.com>
References: <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
 <20190904154000.GJ240514@google.com>
 <CAADnVQK+bSzFdZmgTnDSgibhJ81pR19P6hFArqmZa_xKA1r1VQ@mail.gmail.com>
 <20190904174707.GV2332@hirez.programming.kicks-ass.net>
 <CAADnVQJFXq0n1J+vFMwhNgGNBYXK+EsFaE_Zebp84wMOLN8TNA@mail.gmail.com>
 <20190905081310.GA46285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905081310.GA46285@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:13:10AM +0200, Ingo Molnar wrote:
> 
> * Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Wed, Sep 4, 2019 at 10:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Sep 04, 2019 at 08:51:21AM -0700, Alexei Starovoitov wrote:
> > > > Anything in tracing can be deleted.
> > > > Tracing is about debugging and introspection.
> > > > When underlying kernel code changes the introspection points change as well.
> > >
> > > Right; except when it breaks widely used tools; like say powertop. Been
> > > there, done that.
> > 
> > powertop was a lesson learned, but it's not a relevant example anymore.
> > There are more widely used tools today. Like bcc tools.
> > And bpftrace is quickly gaining momentum and large user base.
> > bcc tools did break already several times and people fixed them.
> 
> Are these tools using libtraceevents?

bcc tools and bpftrace are using libbcc.
Which in turn is using libbpf.
libtraceevents is not used.

Interesting example is https://github.com/iovisor/bcc/blob/master/tools/tcplife.py
It's using "inet_sock_set_state" tracepoint when available on newer kernels
and kprobe in tcp_set_state() function on older kernels.
That tracepoint changed significantly over time.
It had different name 'tcp_set_state' and slightly different semantics.
Hence the tool was fixed when that change in tracepoint happened:
https://github.com/iovisor/bcc/commit/fd93dc0409b626b749b90f115d3d550a870ed125

Note that tcp:tcp_set_state tracepoint existed for full kernel release.
Yet people didn't make fuzz about the fact it disappeared in 4.16.
Though tcplife.py tool is simple there are more complex tools based
on this idea that are deployed in netflix and fb that went through the same
tcp_set_state->inet_sock_set_state fixes.

