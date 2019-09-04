Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F056C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B122186A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OZjV1T8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfIDNGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:06:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34117 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:06:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so11245002pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4T9oniM7RmFsChJrriXtsChjQdrGfJ3xc+bU+X9Taqc=;
        b=OZjV1T8WM8YBT/s9sHS6caOoL9wdd1/evqJwt/wzRbbNRbZNUB3AgOf/k63fhXTcTI
         GnzsImP02zwLSONwVCehG7i9FI2gg2oakev4KuJOT/l6UC9wuE5aAqh/cqjI9n6ZNsdR
         Brp1GjU6BnZN7mq/dGFKI6OmRjFWU80/J8lC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4T9oniM7RmFsChJrriXtsChjQdrGfJ3xc+bU+X9Taqc=;
        b=eOOi2Req+kJfjkx+MDJ8b7Uo81u9hGHme8jTAFQnx+oNDSokYkql+ncyDmR9yY0o2I
         FCQC4h8q7Z4r9sovkh7EloFE3Cnk3l+KsUg+nHAfCgx9n6FnLw9kuCe1kzoMSXnuHr8P
         wgnjxs6gCAXC+9dT5PgGPCnpYuB0bBnENDALCEV/RPxHaaO7l1xw+GPsEbPqjJ6Nd0UK
         CqpAAFbOqtpLQZELwblXbvsg5H5QQyoqk4gOJ7vo3g80lMjqQUDw1b+C5qeueNdgt5eD
         05jdV4pdASdVm1YwfYUylQlhookAJpcgGpGc37YIAYWsRWJw3uHv4si59/YMq8vZSda+
         SiCQ==
X-Gm-Message-State: APjAAAWKbAESlLJb/xcHimzupYW0AQa5CG2OCwEBzSafdd87W7Nm4Zul
        QrKRiojgLy5eIclI0Iesjlpgwg==
X-Google-Smtp-Source: APXvYqxKZ72CyKgb6C5D+D9WIil5lZByiKU2/fN6QU0G6/AsBbGVc5qQQOEFFWoy0ZmPRCkYZgfPsw==
X-Received: by 2002:aa7:8bcc:: with SMTP id s12mr30769719pfd.93.1567602390255;
        Wed, 04 Sep 2019 06:06:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u16sm19783515pgm.83.2019.09.04.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:06:29 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:06:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?iso-8859-1?Q?Hladk=FD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904130628.GE144846@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:43:33AM +0100, Qais Yousef wrote:
> On 09/04/19 00:23, Joel Fernandes wrote:
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
> > > trace points. Qais did something very similar recently:
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
> It is actually true.
>
> But you need to make the distinction between a tracepoint
> and a trace event first.

I know this distinction well.

> What Valentin is talking about here is the *bare*
> tracepoint without any event associated with them like the one I added to the
> scheduler recently. These ones are not accessible via eBPF, unless something
> has changed since I last tried.

Can this tracepoint be registered on with tracepoint_probe_register()?
Quickly looking at these new tracepoint, they can be otherwise how would they
even work right? If so, then eBPF can very well access it. Look at
__bpf_probe_register() and bpf_raw_tracepoint_open() which implement the
BPF_RAW_TRACEPOINT_OPEN.

> The current infrastructure needs to be expanded to allow eBPF to attach these
> bare tracepoints. Something similar to what I have in [1] is needed - but
> instead of creating a new macro it needs to expand the current macro. [2] might
> give full context of when I was trying to come up with alternatives to using
> trace events.
> 
> [1] https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> [2] https://lore.kernel.org/lkml/20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com/


As I was mentioning, tracepoints, not "trace events" can already be opened
directly with BPF. I don't see how these new tracepoints are different.

I wonder if this distinction of "tracepoint" being non-ABI can be documented
somewhere. I would be happy to do that if there is a place for the same. I
really want some general "policy" in the kernel on where we draw a line in
the sand with respect to tracepoints and ABI :).

For instance, perhaps VFS can also start having non-ABI tracepoints for the
benefit of people tracing the VFS.

thanks,

 - Joel

