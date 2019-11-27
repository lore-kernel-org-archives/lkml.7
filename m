Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185AEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE51720665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmasFfWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK0PnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:43:11 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:36098 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0PnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:43:10 -0500
Received: by mail-qk1-f178.google.com with SMTP id v19so245691qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/AQWXCsbMEoobdkxfkCWy1IZmK9HjISqz+p8LcZgoQ8=;
        b=JmasFfWc75na/HxWZkq+ZuHw9Av/1Em2rFCjmNcMsQDR11VD2LdzOeirDieQiWLp5+
         dWwg5KAiS77QJbdqaLsdNUpNIp6jggYSAR9lEwZIMdVT2xsGah++wG5gAsy/UDYGDAY4
         RNfIl/EfTX2ohJ4i+C2YaWQP4izr24jtBZTiyOqxDhdDKvan3UJk8p/W2rRvAR2EGk6Y
         FwKGnPzMnjH7TK2UdAiKe4UHhF1/6gpMGLmx2T2hbn+8TLvV0BmZbANX+DueBpdBVwRr
         KLhwJGVUSZVoZ/Gv5z7WEE9/F80YDP+FeRPIFphhLVSZLv/ms+yMXC9+fSlxuy8H00NW
         bO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AQWXCsbMEoobdkxfkCWy1IZmK9HjISqz+p8LcZgoQ8=;
        b=CwjFlSc74s0PLEN8ujqeCbgIHM64d4iXk1R7c8uTyR+vGGZYm8qJiNkf9475+tiRuu
         YQYlSGlno0c6gosIHE8US4lN6m1xGErDNtgygUOdNhrwFOs1LrAtp9bjxeRdSCnHL7Uj
         2I/p6WqkuFlw1xVQw1/GAWysyDK11N1ltPs6AZB3wPlKTCyYuhEXPCyo9d51lrznLF/C
         jDvEJdUY183cdArFPnREGdxST4NyEQgiZnjbMylsDWlnZ5iBa0e+mTfV3RuUkcocAjoO
         nCsde3/C3fVcvLIqnA2X+Dn7FDG+qkUK8Y64KzFhv7sc0RVWQDUalWck1KZ8sTBLWx9T
         K57g==
X-Gm-Message-State: APjAAAXIIySB1Ce/mKSIyAp5gvgEU2nXAA2bPLGxo72/2zlm1/WDBxUj
        aH0mp/C9+cwwOH0dqQFapw5RlIPuiP8=
X-Google-Smtp-Source: APXvYqx2Zk9+tS3WccFl2PRfSxVcPjVCRGwd3ti1PjfFz9w6P/0ryxntZQO64HcVITnjXjPYaBo0bQ==
X-Received: by 2002:a05:620a:15bc:: with SMTP id f28mr4860212qkk.57.1574869389535;
        Wed, 27 Nov 2019 07:43:09 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p10sm7894129qte.63.2019.11.27.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:43:08 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0946A40D3E; Wed, 27 Nov 2019 12:43:06 -0300 (-03)
Date:   Wed, 27 Nov 2019 12:43:05 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
Message-ID: <20191127154305.GJ22719@kernel.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
 <20191127151657.GE22719@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127151657.GE22719@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 27, 2019 at 12:16:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 20, 2019 at 04:15:10PM -0800, Andi Kleen escreveu:
> > [v8: Address review feedback. Only changes one patch.]
> > 
> > This patch kit optimizes perf stat for a large number of events 
> > on systems with many CPUs and PMUs.
> > 
> > Some profiling shows that the most overhead is doing IPIs to
> > all the target CPUs. We can optimize this by using sched_setaffinity
> > to set the affinity to a target CPU once and then doing
> > the perf operation for all events on that CPU. This requires
> > some restructuring, but cuts the set up time quite a bit.
> > 
> > In theory we could go further by parallelizing these setups
> > too, but that would be much more complicated and for now just batching it
> > per CPU seems to be sufficient. At some point with many more cores 
> > parallelization or a better bulk perf setup API might be needed though.
> > 
> > In addition perf does a lot of redundant /sys accesses with
> > many PMUs, which can be also expensve. This is also optimized.
> > 
> > On a large test case (>700 events with many weak groups) on a 94 CPU
> > system I go from
> > 
> > real	0m8.607s
> > user	0m0.550s
> > sys	0m8.041s
> > 
> > to 
> > 
> > real	0m3.269s
> > user	0m0.760s
> > sys	0m1.694s
> > 
> > so shaving ~6 seconds of system time, at slightly more cost
> > in perf stat itself. On a 4 socket system the savings
> > are more dramatic:
> > 
> > real	0m15.641s
> > user	0m0.873s
> > sys	0m14.729s
> > 
> > to 
> > 
> > real	0m4.493s
> > user	0m1.578s
> > sys	0m2.444s
> > 
> > so 11s difference in the user visible set up time.
> 
> Applied to my local perf/core branch, now undergoing test builds on all
> the containers.

So, have you tried running 'perf test' after each cset is applied and
built?

[root@quaco ~]# perf test 49
49: Event times                                           : FAILED!

I did a bisect and it ends at:

[acme@quaco perf]$ git bisect good
af39eb7d060751f7f3336e0ffa713575c6bea902 is the first bad commit
commit af39eb7d060751f7f3336e0ffa713575c6bea902
Author: Andi Kleen <ak@linux.intel.com>
Date:   Wed Nov 20 16:15:19 2019 -0800

    perf stat: Use affinity for opening events

    Restructure the event opening in perf stat to cycle through the events
    by CPU after setting affinity to that CPU.

---------

Which for me was a surprise till I saw that this doesn't touch just
'perf stat' as the commit log seems to indicate.

Please check this, and consider splitting the patches to help with
bisection.

I'm keeping this in a separate local branch for now, will leave the
first few patches, that seems ok to go now.

- Arnaldo
