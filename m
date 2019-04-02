Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168BCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593D207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzDBZl1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfDBNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:22:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45751 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:22:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so11544479ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7+g/iYIWMSAyqpdMvQ0Q7lGt5FdIMeDmj57P8TlVG4=;
        b=MzDBZl1tdfETNjYIicV0opq1TK9RnNrBdMmsMK181pJlJhDT2yd5Uf14yQP842NNJ2
         flCoUCU40Llemlllx2eeinISgjZxUFthV65ZH6SeBae4s7YGJqPzlmlB5VkKG52D2ISu
         S7Ukqu1TIBuORVUgZNCiPZ1z3UZi50AAXLyAcAJP6pFXPA5tuSvx9oeprMqy7zFnTuYl
         0rxJvoZlFKplXhtKiPUcKD3QekKq6ToAnJGVm2UpI3VxFOfDmvTWLa8wCyS1VGqT7sPz
         541VVsma1UovY2mcIF+D35kgtQPJ05cP2Sm8MDH7x0XmlFtyHHNUk/W7OzUA6dXLxQGI
         vlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7+g/iYIWMSAyqpdMvQ0Q7lGt5FdIMeDmj57P8TlVG4=;
        b=KXYn33G+Y1T3xOkLO9Q4+T7SCg+HcYQTOz+ZaeJx226lbaukHZZhQKFEPqEWDSkjSt
         0zF38WgYmvqG2ikPBhEEbdHrchA2uWYNCwu8qrAiZhROvnDANNFZGK3zHdUQyiWmQES1
         oxUw+sBmyrgVqPeZ1AF1GgcjbK404kN77h3uHiAmj1Jp1ty/oedaEEFJ47X83EQgWoow
         WzNIdX+X7HA5c3+rKTEOy8tHF3hPyLF1IuvcjAPa1bKFRyw+7mVT5LTq7PmsmtIZrjYM
         MGGcL9d26doCzlJpFaitDGSPudewVGHOgj6QqxW0gS8JQS0gvi/f+gORuw3Gs9wgMFJg
         letQ==
X-Gm-Message-State: APjAAAX1KKcUFMIfTKI2v7wxPUj5xpeUcnk9jlLAAsHgLbYqwbwxCLKN
        WEbISkkDHKC1l3SN3g3jnfs=
X-Google-Smtp-Source: APXvYqzrFZn9KN2dd30zOWm69EgUO6rLJ33810PJreRMT7P9e6fBaRT6vweQLqCJVA46ufRUnMM9hQ==
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr8732084lje.20.1554211323073;
        Tue, 02 Apr 2019 06:22:03 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id e5sm2715449lja.96.2019.04.02.06.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 06:22:01 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A493C4607D0; Tue,  2 Apr 2019 16:22:00 +0300 (MSK)
Date:   Tue, 2 Apr 2019 16:22:00 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, Vince Weaver <vince@deater.net>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Message-ID: <20190402132200.GA23501@uranus>
References: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
 <20190402130302.GL12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402130302.GL12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:03:02PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 01, 2019 at 09:46:33PM +0000, Lendacky, Thomas wrote:
> > This patch series addresses issues with increased NMI latency in newer
> > AMD processors that can result in unknown NMI messages when PMC counters
> > are active.
> > 
> > The following fixes are included in this series:
> > 
> > - Resolve a race condition when disabling an overflowed PMC counter,
> >   specifically when updating the PMC counter with a new value.
> > - Resolve handling of active PMC counter overflows in the perf NMI
> >   handler and when to report that the NMI is not related to a PMC.
> > - Remove earlier workaround for spurious NMIs by re-ordering the
> >   PMC stop sequence to disable the PMC first and then remove the PMC
> >   bit from the active_mask bitmap. As part of disabling the PMC, the
> >   code will wait for an overflow to be reset.
> > 
> > The last patch re-works the order of when the PMC is removed from the
> > active_mask. There was a comment from a long time ago about having
> > to clear the bit in active_mask before disabling the counter because
> > the perf NMI handler could re-enable the PMC again. Looking at the
> > handler today, I don't see that as possible, hence the reordering. The
> > question will be whether the Intel PMC support will now have issues.
> > There is still support for using x86_pmu_handle_irq() in the Intel
> > core.c file. Did Intel have any issues with spurious NMIs in the past?
> > Peter Z, any thoughts on this?
> 
> I can't remember :/ I suppose we'll see if anything pops up after these
> here patches. At least then we get a chance to properly document things.
> 
> > Also, I couldn't completely get rid of the "running" bit because it
> > is used by arch/x86/events/intel/p4.c. An old commit comment that
> > seems to indicate the p4 code suffered the spurious interrupts:
> > 03e22198d237 ("perf, x86: Handle in flight NMIs on P4 platform").
> > So maybe that partially answers my previous question...
> 
> Yeah, the P4 code is magic, and I don't have any such machines left, nor
> do I think does Cyrill who wrote much of that.

It was so long ago :) What I remember from the head is some of the counters
were borken on hardware level so that I had to use only one counter instead
of two present in the system. And there were spurious NMIs too. I think
we can move this "running" bit to per-cpu base declared inside p4 code
only, so get rid of it from cpu_hw_events?

> I have vague memories of the P4 thing crashing with Vince's perf_fuzzer,
> but maybe I'm wrong.

No, you're correct. p4 was crashing many times before we manage to make
it more-less stable. The main problem though that to find working p4 box
is really a problem.

> Ideally we'd find a willing victim to maintain that thing, or possibly
> just delete it, dunno if anybody still cares.

As to me, I would rather mark this p4pmu code as deprecated, until there
is *real* need for its support.

> 
> Anyway, I like these patches, but I cannot apply since you send them
> base64 encoded and my script chokes on that.
