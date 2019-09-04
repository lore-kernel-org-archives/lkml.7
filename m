Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F7CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DAD2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nDwdhp5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfIDOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:42:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43310 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbfIDOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:42:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id d15so3869255pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+l0B/sPtzf8Wtk+7BnPmFPi6qM7qQmGgZhFwpRCmdSY=;
        b=nDwdhp5h8iKTczDvhLe7Tfig57HJ5zy8BPpspinLM0eoG/AvgS3MNkGHL51+cWLQiq
         x2Sx2Z7L9benrWKjNfHgO7KGpupUbfv0DiRx0Km/XI5WQNVkXyY2xlBW3RkFOMKAdrSO
         7ubrYFlXcmAM6qimb6dbVJaT9LRHIiVU80tRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+l0B/sPtzf8Wtk+7BnPmFPi6qM7qQmGgZhFwpRCmdSY=;
        b=EbdzBe8Mb2mbS+89wnzITSwybfBdlzQe+z0xvzZ6pAw6zDcQT/rvWoXlGAEKuxPj1F
         TwnvygU7BSQmP/hdY4YTeSQrjJMl+KHL2N0wBA8ISs5Akv/PHdjdBenq6hg3hb4qZg4D
         M3cNk4Oaa5IRdZZCrX8Eiv3LBPBg5dvBcmFkZGi+2gg0dv+ik9Swn/WDPvp7T6V2Kpsn
         9bmfGNP8KsgT8+5c2QpQ5HbdbbPQNrMfGbo3i6Esr+dVIkx3Ye1CZly817Av2o4gZZWD
         4+vE2CRMTiN4jGsjpFvvJFqFBWFtzxhOAe6hxGXdf6YQmnw4KgVBeZAifzuccSzZKiEn
         P85w==
X-Gm-Message-State: APjAAAVvPSoOuakHkK6DEukFE5829OqGIDJebDsD/+MPYgf1Xd+AEzhu
        pAM+nOnoWJRdGPhnzf5/cTsMMA==
X-Google-Smtp-Source: APXvYqyXecl0fLRyFUiT/Fr9kle9wJrRdlEd5bNH7I3Bzy5qA8cJdSO5c3TFtDs5HGzJKP4ASjeMPA==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr35400892pgp.368.1567608120769;
        Wed, 04 Sep 2019 07:42:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d15sm2562267pfo.118.2019.09.04.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:42:00 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:41:59 -0400
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
Message-ID: <20190904144159.GE240514@google.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <20190904142017.kz7dj2cc43wvs4ve@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904142017.kz7dj2cc43wvs4ve@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:20:17PM +0100, Qais Yousef wrote:
> On 09/04/19 09:06, Joel Fernandes wrote:
> > > 
> > > It is actually true.
> > >
> > > But you need to make the distinction between a tracepoint
> > > and a trace event first.
> > 
> > I know this distinction well.
> > 
> > > What Valentin is talking about here is the *bare*
> > > tracepoint without any event associated with them like the one I added to the
> > > scheduler recently. These ones are not accessible via eBPF, unless something
> > > has changed since I last tried.
> > 
> > Can this tracepoint be registered on with tracepoint_probe_register()?
> > Quickly looking at these new tracepoint, they can be otherwise how would they
> > even work right? If so, then eBPF can very well access it. Look at
> > __bpf_probe_register() and bpf_raw_tracepoint_open() which implement the
> > BPF_RAW_TRACEPOINT_OPEN.
> 
> Humm okay. I tried to use raw tracepoint with bcc but failed to attach. But
> maybe I missed something on the way it should be used. AFAICT it was missing
> the bits that I implemented in [1]. Maybe the method you mention is lower level
> than bcc.

Oh, Ok. Not sure about BCC. I know that facebook folks are using *existing*
tracepoints (not trace events) to probe context switches and such (probably
not through BCC but some other BPF tracing code). Peter had rejected trace
events they were trying to add IIRC, so they added BPF_RAW_TRACEPOINT_OPEN
then IIRC.

> > > The current infrastructure needs to be expanded to allow eBPF to attach these
> > > bare tracepoints. Something similar to what I have in [1] is needed - but
> > > instead of creating a new macro it needs to expand the current macro. [2] might
> > > give full context of when I was trying to come up with alternatives to using
> > > trace events.
> > > 
> > > [1] https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > > [2] https://lore.kernel.org/lkml/20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com/
> > 
> > 
> > As I was mentioning, tracepoints, not "trace events" can already be opened
> > directly with BPF. I don't see how these new tracepoints are different.
> > 
> > I wonder if this distinction of "tracepoint" being non-ABI can be documented
> > somewhere. I would be happy to do that if there is a place for the same. I
> > really want some general "policy" in the kernel on where we draw a line in
> > the sand with respect to tracepoints and ABI :).
> > 
> > For instance, perhaps VFS can also start having non-ABI tracepoints for the
> > benefit of people tracing the VFS.
> 
> Good question. I did consider that but failed to come up with a place. AFAIU
> the history moved from tracepoints to trace events and now moving back to
> tracepoints. Something Steve is not very enthusiastic about.

Yeah this is a bit of a mess. I think for every recent LPC this has come up.
But the DECLARE_TRACE approach you did is interesting in that it
reduces/removes the API surface for trace-events at least.

thanks,

 - Joel

