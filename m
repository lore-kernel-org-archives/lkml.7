Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0507CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99D220830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571644246;
	bh=VY9Qvz5WmbdYEr9ygqvSjQmQmMmH8/l080URcUt2aYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QktqVdKeN/DlRWL9vELw9iTDXspGyJ2I8P/7Iqwl4QXJ3R/8C/PJUMthLwMDm+cMx
	 6JfF03sGDOHqbptDYl9KZ+Fd/Y9hsIdDWwY0+mbmI0tZpLu4lTwJKX+b2ueSlXty9X
	 f9HP2l9KCB+/BpHb3B/d4L3HrV6LHbquB2PcYofc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfJUHup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:50:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53902 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:50:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so12048600wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jD0aygx1RzJcRT1rSlbsUwMYFlUFS5dZEZR0twgS150=;
        b=muONkUMOJelMPqJXH/0cp6GnjtDnOzbX9uiER+2AkejOG5YLLDnd33CyF/Od9Yxglp
         yy73SGR+vj39zhyNIIb91TQnZjUqfnKRzX3G5uYGM1eEPLenY3J50QK9EvNjFecugXdu
         IxUHxNSMChQtS01cuPI+xImNIx7HsyoUwJfCID4LoEN7gAWTkcY0WF6L+O4U99NBC1b4
         i+PO21liuJe9FsqN8wIet+tr1cyTgrE0Jq1SxJpE99Woy3Qol/M/JawmDgPK7pEiZAQf
         M10Ny4lZecwludr6YFDq++aySLwk3p+Jk4UYA4FX9rqNCbnCKcOxdIrJ5S0pfEBT8sFb
         eDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jD0aygx1RzJcRT1rSlbsUwMYFlUFS5dZEZR0twgS150=;
        b=bX/mHwUdLCJrzZqqSuL2aDtP4wEhlxEUj5vndjiSkg45eaRfXA9p2BBFdPfa1AYcE/
         DVejjM7U8GpjGHCatvTt0III+w20SpkmkPboh11EoKEilHgOhMVRXpkMHW+AcyFL3Vet
         pCWNhfa3H81Enkb+O1QrWdHLQHZPeJN6zXlsthW6tz7eV6fzNyzx5rbNyie+rmKgoLAP
         xygT7TQTBjZ+O68yJ20vTESTquXaFCYG0YgIW1kvx8hMN70pzpbjldB9wB5h8ksrI8iK
         HuruK2mAmXWO6S877fqD2Gze5lk2v+EYijvJL0+4j2NfZUbiCn2tEcB+fO07vl7G6sM+
         dXRQ==
X-Gm-Message-State: APjAAAX2BTxq531euxGkOzsilqm2PuVPcGVIjZij7RUBS14SLjMOd5a0
        FyikUf0nRGzI1Igj08Rw9jY=
X-Google-Smtp-Source: APXvYqwJz5bfWbhzme/2+AoXNmJIQY26KQAtKmv0XIqZrDYKObx02zY9en2txdybhIV0/+7Qkr+2FA==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr18449058wmb.164.1571644241927;
        Mon, 21 Oct 2019 00:50:41 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q22sm12299738wmj.5.2019.10.21.00.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 00:50:41 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:50:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191021075038.GA27361@gmail.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Several wrong task placement have been raised with the current load
> balance algorithm but their fixes are not always straight forward and
> end up with using biased values to force migrations. A cleanup and rework
> of the load balance will help to handle such UCs and enable to fine grain
> the behavior of the scheduler for other cases.
> 
> Patch 1 has already been sent separately and only consolidate asym policy
> in one place and help the review of the changes in load_balance.
> 
> Patch 2 renames the sum of h_nr_running in stats.
> 
> Patch 3 removes meaningless imbalance computation to make review of
> patch 4 easier.
> 
> Patch 4 reworks load_balance algorithm and fixes some wrong task placement
> but try to stay conservative.
> 
> Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
> into account when pulling tasks.
> 
> Patch 6 replaces runnable_load by load now that the signal is only used
> when overloaded.
> 
> Patch 7 improves the spread of tasks at the 1st scheduling level.
> 
> Patch 8 uses utilization instead of load in all steps of misfit task
> path.
> 
> Patch 9 replaces runnable_load_avg by load_avg in the wake up path.
> 
> Patch 10 optimizes find_idlest_group() that was using both runnable_load
> and load. This has not been squashed with previous patch to ease the
> review.
> 
> Patch 11 reworks find_idlest_group() to follow the same steps as
> find_busiest_group()
> 
> Some benchmarks results based on 8 iterations of each tests:
> - small arm64 dual quad cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe      53125 +/-0.18%        53443 +/-0.52%   (+0.60%)
> 
> hackbench -l (2560/#grp) -g #grp
>  1 groups      1.579 +/-29.16%       1.410 +/-13.46% (+10.70%)
>  4 groups      1.269 +/-9.69%        1.205 +/-3.27%   (+5.00%)
>  8 groups      1.117 +/-1.51%        1.123 +/-1.27%   (+4.57%)
> 16 groups      1.176 +/-1.76%        1.164 +/-2.42%   (+1.07%)
> 
> Unixbench shell8
>   1 test     1963.48 +/-0.36%       1902.88 +/-0.73%    (-3.09%)
> 224 tests    2427.60 +/-0.20%       2469.80 +/-0.42%  (1.74%)
> 
> - large arm64 2 nodes / 224 cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe     124084 +/-1.36%       124445 +/-0.67%   (+0.29%)
> 
> hackbench -l (256000/#grp) -g #grp
>   1 groups    15.305 +/-1.50%       14.001 +/-1.99%   (+8.52%)
>   4 groups     5.959 +/-0.70%        5.542 +/-3.76%   (+6.99%)
>  16 groups     3.120 +/-1.72%        3.253 +/-0.61%   (-4.92%)
>  32 groups     2.911 +/-0.88%        2.837 +/-1.16%   (+2.54%)
>  64 groups     2.805 +/-1.90%        2.716 +/-1.18%   (+3.17%)
> 128 groups     3.166 +/-7.71%        3.891 +/-6.77%   (+5.82%)
> 256 groups     3.655 +/-10.09%       3.185 +/-6.65%  (+12.87%)
> 
> dbench
>   1 groups   328.176 +/-0.29%      330.217 +/-0.32%   (+0.62%)
>   4 groups   930.739 +/-0.50%      957.173 +/-0.66%   (+2.84%)
>  16 groups  1928.292 +/-0.36%     1978.234 +/-0.88%   (+0.92%)
>  32 groups  2369.348 +/-1.72%     2454.020 +/-0.90%   (+3.57%)
>  64 groups  2583.880 +/-3.39%     2618.860 +/-0.84%   (+1.35%)
> 128 groups  2256.406 +/-10.67%    2392.498 +/-2.13%   (+6.03%)
> 256 groups  1257.546 +/-3.81%     1674.684 +/-4.97%  (+33.17%)
> 
> Unixbench shell8
>   1 test     6944.16 +/-0.02     6605.82 +/-0.11      (-4.87%)
> 224 tests   13499.02 +/-0.14    13637.94 +/-0.47%     (+1.03%)
> lkp reported a -10% regression on shell8 (1 test) for v3 that 
> seems that is partially recovered on my platform with v4.
> 
> tip/sched/core sha1:
>   commit 563c4f85f9f0 ("Merge branch 'sched/rt' into sched/core, to pick up -rt changes")
>   
> Changes since v3:
> - small typo and variable ordering fixes
> - add some acked/reviewed tag
> - set 1 instead of load for migrate_misfit
> - use nr_h_running instead of load for asym_packing
> - update the optimization of find_idlest_group() and put back somes
>  conditions when comparing load
> - rework find_idlest_group() to match find_busiest_group() behavior
> 
> Changes since v2:
> - fix typo and reorder code
> - some minor code fixes
> - optimize the find_idles_group()
> 
> Not covered in this patchset:
> - Better detection of overloaded and fully busy state, especially for cases
>   when nr_running > nr CPUs.
> 
> Vincent Guittot (11):
>   sched/fair: clean up asym packing
>   sched/fair: rename sum_nr_running to sum_h_nr_running
>   sched/fair: remove meaningless imbalance calculation
>   sched/fair: rework load_balance
>   sched/fair: use rq->nr_running when balancing load
>   sched/fair: use load instead of runnable load in load_balance
>   sched/fair: evenly spread tasks when not overloaded
>   sched/fair: use utilization to select misfit task
>   sched/fair: use load instead of runnable load in wakeup path
>   sched/fair: optimize find_idlest_group
>   sched/fair: rework find_idlest_group
> 
>  kernel/sched/fair.c | 1181 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 682 insertions(+), 499 deletions(-)

Thanks, that's an excellent series!

I've queued it up in sched/core with a handful of readability edits to 
comments and changelogs.

There are some upstreaming caveats though, I expect this series to be a 
performance regression magnet:

 - load_balance() and wake-up changes invariably are such: some workloads 
   only work/scale well by accident, and if we touch the logic it might 
   flip over into a less advantageous scheduling pattern.

 - In particular the changes from balancing and waking on runnable load 
   to full load that includes blocking *will* shift IO-intensive 
   workloads that you tests don't fully capture I believe. You also made 
   idle balancing more aggressive in essence - which might reduce cache 
   locality for some workloads.

A full run on Mel Gorman's magic scalability test-suite would be super 
useful ...

Anyway, please be on the lookout for such performance regression reports.

Also, we seem to have grown a fair amount of these TODO entries:

  kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
  kernel/sched/fair.c: * XXX: only do this for the part of runnable > running ?
  kernel/sched/fair.c:     * XXX illustrate
  kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
  kernel/sched/fair.c: * can also include other factors [XXX].
  kernel/sched/fair.c: * [XXX expand on:
  kernel/sched/fair.c: * [XXX more?]
  kernel/sched/fair.c: * [XXX write more on how we solve this.. _after_ merging pjt's patches that
  kernel/sched/fair.c:             * XXX for now avg_load is not computed and always 0 so we
  kernel/sched/fair.c:            /* XXX broken for overlapping NUMA groups */

:-)

Thanks,

	Ingo
