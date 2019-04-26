Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CDCC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4392A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556268149;
	bh=GexypQ8Pm7ow/lMGwZTSP0ppb/YyYYB+NuOh7oXgcrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2J5JX0rQ0CK5fihUhhygyhtTl6U58MjE956qvU8avqUXlDRwR6SbRcDEBFkM2LwL
	 +GWQ8s5WIu/wAplaa3xAlKkGnPIo/xpm8D6yap32M0rYcTEAi3Fa05YO4YppKQhMGt
	 vCgUdgTuIFIZWHYUEd3wjE9K+KOa8DP842Ml6PhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDZIm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:42:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37056 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:42:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so2194487wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q+0quKRLMWkW4GTCpMW+nnDDwCrQdWwcAu4LI29wtYc=;
        b=LgUIJTotNw2va8Dbe6OOfM3wSnk5mZBGq6lr9csd1k7aLIAUSwnRseMNpaAOOirN9P
         7LAfwskAG9azPMCkPNhDG7Rn5+Avr5OCX7D/xCLZUpa49CRE8nNCaF/7QGnol4lu5JPS
         PvHWOg1qJIy3gMIdmU5KYSvy2YbyxWsx9EwadlOdclepDJJIhD7PRR/2X0AS/HNUhYiM
         eKzR3tU4Z4MguMZOhSEprZzPvmRuxvnpd4HNCN1el0VLdphBq1VvcRPnprYJiDmi+Ok8
         fwkwRttx6ft/z7WmC16tCbF8yyp1CWjFt3hFkxy49M8VKKYiaJnuIoRos66VtQOe0w/i
         TvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+0quKRLMWkW4GTCpMW+nnDDwCrQdWwcAu4LI29wtYc=;
        b=itC1tfdiDTJ80Xpw8nBd51I39mbpOl1EhdxabSCxZYCGwLCLjS8qYB8I55s1v2QUUZ
         aJGU09Cl9imyAbv2VI57bSWZdlVByxCK5bA5AqffPGby2Ttw8LFD4uZMPGNY19RyTBKs
         pjP30sQ1B0U4sbycV4czi+07M7ItvFlxGQUwkSBTUcz2a1vDy1zpRBNOEv8w/EGD+PyB
         21UJMukgCe52C14BS9JmHghDlDj8hWydAzEpsp/+PC9VusXYtCbKcfRDuFkeMVkRLuMA
         LDdd2U3daHNYu19wgZFlzbcEJ5cXg0c+qAFX4BCcvrISXzZvcu974g549ZAGKJn00jSG
         4PXA==
X-Gm-Message-State: APjAAAXtmpqZ66pHM2UhioL/n9IYN5GESDDIX125H3PGAjMITtCVMieB
        Wv2Zb//LZIJtUjTUNO7PljY=
X-Google-Smtp-Source: APXvYqySWyLiKN5movF5n/6AwE9xsddG7SRDwtFKayjJGsHaw+EnsR06+2eT2MzCocaSVxrLqnKmsg==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr1512231wmk.69.1556268146158;
        Fri, 26 Apr 2019 01:42:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u17sm44211549wmu.36.2019.04.26.01.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 01:42:25 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:42:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190426084222.GC126896@gmail.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425213145.GY18914@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> > > Same -- performance is better until the machine gets saturated and
> > > disabling HT hits scaling limits earlier.
> > 
> > Interesting. This strongly suggests sub-optimal SMT-scheduling in the 
> > non-saturated HT case, i.e. a scheduler balancing bug.
> > 
> 
> Yeah, it does but mpstat didn't appear to indicate that SMT siblings are
> being used prematurely so it's a bit of a curiousity.
> 
> > As long as loads are clearly below the physical cores count (which they 
> > are in the early phases of your table) the scheduler should spread tasks 
> > without overlapping two tasks on the same core.
> > 
> 
> It should, but it's not perfect. For example, wake_affine_idle does not
> take sibling activity into account even though select_idle_sibling *may*
> take it into account. Even select_idle_sibling in its fast path may use
> an SMT sibling instead of searching.
> 
> There are also potential side-effects with cpuidle. Some workloads
> migration around the socket as they are communicating because of how the
> search for an idle CPU works. With SMT on, there is potentially a longer
> opportunity for a core to reach a deep c-state and incur a bigger wakeup
> latency. This is a very weak theory but I've seen cases where latency
> sensitive workloads with only two communicating tasks are affected by
> CPUs reaching low c-states due to migrations.
> 
> > Clearly it doesn't.
> > 
> 
> It's more that it's best effort to wakeup quickly instead of being perfect
> by using an expensive search every time.

Yeah, but your numbers suggest that for *most* not heavily interacting 
under-utilized CPU bound workloads we hurt in the 5-10% range compared to 
no-SMT - more in some cases.

So we avoid a maybe 0.1% scheduler placement overhead but inflict 5-10% 
harm on the workload, and also blow up stddev by randomly co-scheduling 
two tasks on the same physical core? Not a good trade-off.

I really think we should implement a relatively strict physical core 
placement policy in the under-utilized case, and resist any attempts to 
weaken this for special workloads that ping-pong quickly and benefit from 
sharing the same physical core.

I.e. as long as load is kept below ~50% the SMT and !SMT benchmark 
results and stddev numbers should match up. (With a bit of a leewy if the 
workload gets near to 50% or occasionally goes above it.)

There's absolutely no excluse for these numbers at 30-40% load levels I 
think.

Thanks,

	Ingo
