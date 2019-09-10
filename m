Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9429C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9981120863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="BjwE/NLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfIJO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:27:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfIJO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:27:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so20711496wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svTfK8XVs7zcozaB1slOaxRqDQ/z/h8slzAfLwekH/0=;
        b=BjwE/NLnb5Cq/OR3pqpew/QLm3vmNoHfIfpotJzLcmLzNArKzgt/lsD5QdvF9yE+HC
         clUWKDeU6jN8CHM3yG1dq84pdttJ01xchYNaIA9AFUTYpFC+UwH0fv/6rH+rkJMbjQDs
         aRsVIDEc4nWtXEdzKHuVahH0vylOq7Eggibc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svTfK8XVs7zcozaB1slOaxRqDQ/z/h8slzAfLwekH/0=;
        b=n70zRKScW0MbLrhe3oHJGVliACVrvtkEvUzLRYsQXP+5dG9JL3iSsj57Y5DxZWsoJ6
         SRJNwX6WW/XXMItbwYd7mV8gUqx0efIEBZElRY5lTuP+wW7XSiS0o6BLQKdlPrqtQm32
         Wwk5JXd+sXPzTUHgMwYdo9bXw0/cp70YHhwLj3hyM6cuFZgjIEtL1YXg4+zFKRVTNjzL
         dQ/ViN7Y6uuFo1lClcCNwJjz2z1cEpvSHMKM5w8Mv8R4aJCpNJRnGLP0TDLpjy5bITJW
         m+HR77Tdtn3jLE6gYngsNgv17uMWGaM/c/ex7bWXzVoM456B8m1dAWrd4BqF/X9A2zaI
         u11w==
X-Gm-Message-State: APjAAAXW4k7huTvlVPiRxqXooclgdXwOIdYDkpxgKaOxqWRPKis9nGbO
        3DuMzBjVQRCc/1Y4ve3huZ1KOQ==
X-Google-Smtp-Source: APXvYqwMWJpaNy5fVNNj4cuTfglviaBc1H7tNSSdaqBDZhSBk1b00BQ5392WE1asafhKj3I3z333Wg==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr17795069wrw.345.1568125649269;
        Tue, 10 Sep 2019 07:27:29 -0700 (PDT)
Received: from sinkpad ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id v7sm15915206wru.87.2019.09.10.07.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Sep 2019 07:27:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:27:17 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190910142717.GA1855@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
 <20190827215035.GH2332@hirez.programming.kicks-ass.net>
 <20190828153033.GA15512@pauld.bos.csb>
 <20190828160114.GE17205@worktop.programming.kicks-ass.net>
 <20190829143050.GA7262@pauld.bos.csb>
 <20190829143821.GX2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829143821.GX2369@hirez.programming.kicks-ass.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Aug-2019 04:38:21 PM, Peter Zijlstra wrote:
> On Thu, Aug 29, 2019 at 10:30:51AM -0400, Phil Auld wrote:
> > I think, though, that you were basically agreeing with me that the current
> > core scheduler does not close the holes, or am I reading that wrong.
>
> Agreed; the missing bits for L1TF are ugly but doable (I've actually
> done them before, Tim has that _somewhere_), but I've not seen a
> 'workable' solution for MDS yet.

Following the discussion we had yesterday at LPC, after we have agreed
on a solution for fixing the current fairness issue, we will post the
v4. We will then work on prototyping the other synchronisation points
(syscalls, interrupts and VMEXIT) to evaluate the overhead in various
use-cases.

Depending on the use-case, we know the performance overhead maybe
heavier than just disabling SMT, but the benchmarks we have seen so far
indicate that there are valid cases for core scheduling. Core scheduling
will continue to be unused by default, but with it, we will have the
option to tune the system to be both secure and faster than disabling
SMT for those cases.

Thanks,

Julien

P.S: I think the branch that contains the VMEXIT handling is here
https://github.com/pdxChen/gang/commits/sched_1.23-base

