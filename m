Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4551FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15866206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272290;
	bh=oHb6MF8lC+JY413MjCf3LDQb7TZIAPF1qTlZ2YvlOBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QO/yRf3h3sKBgSM6WfWO4KKDbetwwWRWE1LcSdVe/RNqTgy5i3h4ko79Q7Xkx1sYa
	 qq/j4/Kx2sLrIT5iITHVCSm26Yh0W8bJTyztwaHxwj+70nwj6T3Ob/ED13EPVxeXLY
	 KgzKDj/TzQxEEHAZ3QDz2oNjawaKoShFiPCOmYOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDZJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:51:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52442 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDZJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:51:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id j13so3057871wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eIBUFNukdDQCSXCFAOGIysYD96g9fxkE9hYS/NQtUbQ=;
        b=Mub1JIm+6yGSpxTJNCw09BR55aYZEz/mdljtny3p9Kl3Sxic8HLWMO8ek+qIG8eEza
         cCcSmCIqV4QKy0e5G6qtI6GW6KrHIpJ050qDWAkSYgtRF1QAMMQpKbgTW+wvN4E1PoDh
         04NnQ+9XpWxen2MAs1BV8gdi1E9vsBWgYnEjTVWp7uz263b9V98prHsR+LqmLzU1fKh5
         JSXTkEuYSEK6Agao9yYdik0e2P8jXpLWHDEy15jyP+xI54NZj2p7fmc6a+rB8ja+idAM
         VC3sXXxkkLHGNr0biiAuL0/EFYtp6WLLCe63YIHIzIpi5gp8OPyR94PeIuvMoMcuMCS3
         dn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIBUFNukdDQCSXCFAOGIysYD96g9fxkE9hYS/NQtUbQ=;
        b=nGzUVoBRI5yX+jcg8DFtA7Www6Iwy1Wcbjr4ex1AwfryahRcc+DombbPsrJ4KlBzEI
         /5EoZ962hwCi+G59KLag5kq91qMa2GjHSR1mbGiOfx04a6Yohc5q1/R8IdxDCvdQLVg/
         +Esa+kGNpXEK8IbHXeDWqX6Z2owEE4wem+XMmF9WfRcQtH0Usz4l6Dxt5rv05gHgNNcF
         gbyxnmJO+YkY1/tfEcQP6QIIQ0nwU6+cwVJpsrd0cgABVkDv9ma7/O03XRZtq7ro4hIV
         35bgTpiVbeF7HYaq+3vgvzb0rXujKADWf8AE/ztllF89ez32h/yTLCiRQYKUfe3xjV4S
         3OYQ==
X-Gm-Message-State: APjAAAWD28UJzTQFU3ZFpseafmixXJLsthJKsMUdqMNSpc7oeUt8fm+6
        EmZBCfuvo8rxqEO27mi8GY4=
X-Google-Smtp-Source: APXvYqxPsta3t3N5z6tP32HWxCwj88fuhqWnRzW4fIyVk/IzfbALojztbWz7GohMblYv84WJwtnntA==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr7149854wmb.58.1556272286920;
        Fri, 26 Apr 2019 02:51:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y125sm36631305wmc.39.2019.04.26.02.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 02:51:26 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:51:23 +0200
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
Message-ID: <20190426095123.GE126896@gmail.com>
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

> > Interesting.
> > 
> > Here too I'm wondering whether the scheduler could do something to 
> > improve the saturated case: which *is* an important workload, as kernel 
> > hackers tend to over-load their systems a bit when building kernel, to 
> > make sure the system is at least 100% utilized. ;-)
> > 
> 
> Every so often I try but I never managed to settle on a heuristic that 
> helped this case without breaking others. The biggest hurdle is that 
> typically things are better if migrations are low but it's hard to do 
> that in a way that does not also stack tasks on the same CPUs 
> prematurely.

So instead of using a heuristic (which are fragile and most of them are 
also annoyingly non-deterministic and increase overall noise and make 
measurements harder) I'd suggest using SCHED_BATCH just as a hardcore 
toggle to maximize for CPU-bound throughput.

It's not used very much, but the kernel build could use it by default 
(i.e. we could use a "chrt -b" call within the main Makefile), so it 
would be the perfect guinea pig and wouldn't affect anything else.

I.e. we could use SCHED_BATCH to maximize kernel build speed, with no no 
regard to latency (within SCHED_BATCH workloads). I suspect this will 
also maximize bandwidth of a lot of other real-world, highly parallel but 
interacting processing workloads.

[ I'd even be willing to rename it to SCHED_KBUILD, internally. ;-) ]

Thanks,

	Ingo
