Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A50922CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fWMsbeF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfIDNL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:11:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43334 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDNL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:11:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id d15so3711168pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RPkDcYyP7ehkD7xSD+BzrrBbkyrBwGtW1j5qR5j+2TY=;
        b=fWMsbeF3CLbLjMrjN+Ubb7mtT0ExO3I+cS8Q0AxX/mzI7PPAZGIuzxmEPJmp8AmEHz
         H8BnMTeDxHMrkCZ+4M7Kep5nomTGY435eZlwaqsuUBXcVltHz6gHO8B+RKHWlyq09m5J
         0Zu1ttbSFjtFKRhUVR69/JfAy9iH7m2f0VrAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RPkDcYyP7ehkD7xSD+BzrrBbkyrBwGtW1j5qR5j+2TY=;
        b=FF50CqeDKOZPBSjjDQIQYmPIkdOhfR8o+yVpO41hnRVsleJdcAAeH5wcnSp/052e2r
         paJn78LGDoJSSW42fPvOqsIHK3XKHxiIG/NKrvY7qPZ7HZJoSU6yID8sEhlT+Mc1ZQDg
         3q+Ds/Kp1vfZYK5OVboHpxqeyCp/ePQ7aAjVppgf3y+jFvNeDgtymuKdvgt4oOUHhvgM
         xizQS78DR6YuiK6HHkr0xEhtjHDSDbW8yOMFOcu2LU+KYkhUcZpVC3FbNVWSevU/dnRf
         VimwEF45wlwzRYA2AWuxmG3VdQRBpfCJ0WUnJEPMJbdZXkWzoJ+C7bGM/xsUxrCmGRHR
         BR8w==
X-Gm-Message-State: APjAAAWcP2lbesBtxk/4fBnV7audcdL9fmFQZqOmnjV/emANmsMcJKSN
        8eVU6eY83slL1wIAoljI+HmCMg==
X-Google-Smtp-Source: APXvYqykdExTzsXCFIMNfzNWf8okJRBSTVv0nw1zuDb3x0zIPMlMSZ582lhvp7f7n601Su3Gzug95A==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr34773139pgl.420.1567602716027;
        Wed, 04 Sep 2019 06:11:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t3sm9011228pfe.7.2019.09.04.06.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:11:55 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:11:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904131154.GF144846@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904081448.GZ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904081448.GZ2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:14:48AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 04, 2019 at 12:23:10AM -0400, Joel Fernandes wrote:
> > On Tue, Sep 03, 2019 at 05:05:47PM +0100, Valentin Schneider wrote:
> > > On 03/09/2019 16:43, Radim Krčmář wrote:
> > > > The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
> > > > custom data gathering points to better understand what was going on in
> > > > the scheduler.
> > > > Red Hat adapted one of them for the tracepoint framework and created a
> > > > tool to plot a heatmap of nr_running, where the sched_update_nr_running
> > > > tracepoint is being used for fine grained monitoring of scheduling
> > > > imbalance.
> > > > The tool is available from https://github.com/jirvoz/plot-nr-running.
> > > > 
> > > > The best place for the tracepoints is inside the add/sub_nr_running,
> > > > which requires some shenanigans to make it work as they are defined
> > > > inside sched.h.
> > > > The tracepoints have to be included from sched.h, which means that
> > > > CREATE_TRACE_POINTS has to be defined for the whole header and this
> > > > might cause problems if tree-wide headers expose tracepoints in sched.h
> > > > dependencies, but I'd argue it's the other side's misuse of tracepoints.
> > > > 
> > > > Moving the import sched.h line lower would require fixes in s390 and ppc
> > > > headers, because they don't include dependecies properly and expect
> > > > sched.h to do it, so it is simpler to keep sched.h there and
> > > > preventively undefine CREATE_TRACE_POINTS right after.
> > > > 
> > > > Exports of the pelt tracepoints remain because they don't need to be
> > > > protected by CREATE_TRACE_POINTS and moving them closer would be
> > > > unsightly.
> > > > 
> > > 
> > > Pure trace events are frowned upon in scheduler world, try going with
> > > trace points. 
> 
> Quite; I hate tracepoints for the API constraints they impose. Been
> bitten by that, not want to ever have to deal with that again.

Your NACKs on trace patches over the years have spoken out loud about this
point ;-)

> > >  Qais did something very similar recently:
> > > 
> > > https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/
> > > 
> > > You'll have to implement the associated trace events in a module, which
> > > lets you define your own event format and doesn't form an ABI :).
> > 
> > Is that really true? eBPF programs loaded from userspace can access
> > tracepoints through BPF_RAW_TRACEPOINT_OPEN, which is UAPI:
> > https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L103
> > 
> > I don't have a strong opinion about considering tracepoints as ABI / API or
> > not, but just want to get the facts straight :)
> 
> eBPF can access all sorts of kernel internals; if we were to deem eBPF
> and API we'd be fscked.

True. However, for kprobes-based BPF program - it does check for kernel
version to ensure that the BPF program is built against the right kernel
version (in order to ensure the program is built against the right set of
kernel headers). If it is not, then BPF refuses to load the program.

But, to your point bpf_probe_read() can away access kernel memory and
assume structure layouts; so I guess a badly written bpf program can still do
all sorts of ABI-unstable things.

Good to know that the raw tracepoint being Ok since it is non-ABI; is where
we draw the line.

thanks,

 - Joel

