Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E66C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B420820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Sb9gfiDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfDDTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:01:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39758 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfDDTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:01:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so4561167qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=84eztZqCHmMb3QpOH7ENjKDxw2e1HRRIAJ1ua0sCvqA=;
        b=Sb9gfiDPziGZuC676SdO63M8pwZRewMrHhT90NXFRalnWecwkt+oSRUkYF58pwNfZu
         FH3ZtuzBUmH9QptaBwkZR2NoWbyQXrhVEfF4UiIl3ZG3V+nRFrTBZaKNd8QZnscorl15
         wx8NMj9KhtYb7mCeXQwx0w8CNdAH8dYSp368E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=84eztZqCHmMb3QpOH7ENjKDxw2e1HRRIAJ1ua0sCvqA=;
        b=ZOiwhGow6H1bQB+r4EqNJlRJKsbZ2r47jJWxuriCtg+XPowThru9VtOe6bw5jbZcWY
         2bxZtC73AGwCWgytYIAFsBpDbK92CUDRAz3MdU6wKTx0hIdr6jB7moDCbT9iLnWciz6H
         cSJfb3f4ED9hoWFzCr8Y5YrWP/qK3ES+uNGP7RX9D97+nSAs6u/4g14l74GkLBXZpzah
         T52jcBOMlfiH1yBKmx82FRk2YYKVCchQGQmmkuE7XzQVqbWA2FsEF566WKzs0m+mq1Pg
         ZKDeHOwW2IVmAcnbrH3tJLQP6OonPNeXU8B+GDhpW7Yd6zP7VrWTDFnhOy9tr02AjyWj
         56OQ==
X-Gm-Message-State: APjAAAUP3swbIt7UMOsqoqTUr6SU3URVNbXPCaSlpsf8fA1rSG1BWOwI
        Cen/v2L0qTszmvUNbjotZpy2/g==
X-Google-Smtp-Source: APXvYqyWFupC46izQaOeLWRWHjUxdTgxN8Z8DfzLyDe0rCgQsamIeiTsDZ/ELmdHqHNxZESjsMnzFQ==
X-Received: by 2002:ac8:1a25:: with SMTP id v34mr6659814qtj.337.1554404478420;
        Thu, 04 Apr 2019 12:01:18 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id n6sm4857235qte.11.2019.04.04.12.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 12:01:17 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 4 Apr 2019 15:01:14 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
In-Reply-To: <20190404164700.GR1421@uranus.lan>
Message-ID: <alpine.DEB.2.21.1904041454290.5597@macbook-air>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air> <20190403191944.GH1421@uranus.lan> <20190403203144.GI1421@uranus.lan> <alpine.DEB.2.21.1904040922350.3758@macbook-air> <20190404133327.GP1421@uranus.lan> <alpine.DEB.2.21.1904041234340.5098@macbook-air>
 <20190404164700.GR1421@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Cyrill Gorcunov wrote:

> On Thu, Apr 04, 2019 at 12:37:18PM -0400, Vince Weaver wrote:
> 
> Oh, Vince, I suspect such kind of bisection might consume a lot of your
> time :( Maybe we could update perf fuzzer so that it would send events
> to some net-storage first then write them to the counters, iow to automatize
> this all stuff somehow?

I do have a lot of this automated already from tracking down past bugs, 
but it turns out that most of the fuzzer-found bugs aren't deterministic 
so it doesn't always work.

For example this bug, while I can easily repeat it, doesn't happen at 
the same time each time.  I suspect something corrupts things, but the
crash doesn't trigger until a context switch happens.

For what it's worth I've put code in p4_pmu_enable_all() to see what's 
going on when the NULL dereference happens, and sure enough the printk is 
triggered where I'd expect.

[  138.132889] VMW: p4_pmu_enable_all: idx 4 is NULL
[  138.171380] VMW: p4_pmu_enable_all: idx 4 is NULL
[  138.212588] VMW: p4_pmu_enable_all: idx 4 is NULL
[  138.263761] VMW: p4_pmu_enable_all: idx 4 is NULL
[  138.279944] VMW: p4_pmu_enable_all: idx 4 is NULL

static void p4_pmu_enable_all(int added)
{
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
        int idx;

        for (idx = 0; idx < x86_pmu.num_counters; idx++) {
                struct perf_event *event = cpuc->events[idx];
                if (!test_bit(idx, cpuc->active_mask))
                        continue;
                if (event==NULL) {
                        printk("VMW: p4_pmu_enable_all: idx %d is NULL\n",idx);
                } else {
                        p4_pmu_enable_event(event);
                }
        }
}


the machine still crashes after this, but not right away.

Vince
