Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C1C20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565332836;
	bh=JICce7ZE0IlFX5w611YV9nbuvP6Q94yyb0UJ4gSpMys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dcopIptH9nGJTdhrLdgrtlZR4RWIglNdVdAYnp9N77hUsa6sLei92NonB63VrBk5E
	 Be7yUnf9n228eZ0xkv2vxxOLiIenQIUgUO9eXi0JHn7f9Xe4uNNQWX//UGc/lyRwhv
	 JVMSjbb4H0M/YBuDk94POEiR9r0QY1aIs8nXH27Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405497AbfHIGkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:40:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbfHIGkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:40:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF531ABD2;
        Fri,  9 Aug 2019 06:40:33 +0000 (UTC)
Date:   Fri, 9 Aug 2019 08:40:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190809064032.GJ18351@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
 <20190808185119.GF18351@dhcp22.suse.cz>
 <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
 <20190808200715.GI18351@dhcp22.suse.cz>
 <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Again, please do not top post - it makes a mess of any longer
discussion]

On Thu 08-08-19 15:15:12, Edward Chron wrote:
> In our experience far more (99.9%+) OOM events are not kernel issues,
> they're user task memory issues.
> Properly maintained Linux kernel only rarely have issues.
> So useful information about the killed task, displayed in a manner
> that can be quickly digested, is very helpful.
> But it turns out the totalpages parameter is also critical to make
> sense of what is shown.

We already do print that information (see mem_cgroup_print_oom_meminfo
resp. show_mem).

> So if we report the fooWidget task was using ~15% of memory (I know
> this is just an approximation but it is often an adequate metric) we
> often can tell just from that the number is larger than expected so we
> can start there.
> Even though the % is a ballpark number, if you are familiar with the
> tasks on your system and approximately how much memory you expect them
> to use you can often tell if memory usage is excessive.
> This is not always the case but it is a fair amount of the time.
> So the % of memory field is helpful. But we've found we need totalpages as well.
> The totalpages effects the % of memory the task uses.

Is it too difficult to calculate that % from the data available in the
existing report? I would expect this would be a quite simple script
which I would consider a better than changing the kernel code.

[...]
> The oom_score tells us how Linux calculated the score for the task,
> the oom_score_adj effects this so it is helpful to have that in
> conjunction with the oom_score.
> If the adjust is high it can tell us that the task was acting as a
> canary and so it's oom_score is high even though it's memory
> utilization can be modest or low.

I am sorry but I still do not get it. How are you going to use that
information without seeing other eligible tasks. oom_score is just a
normalized memory usage + some heuristics potentially (we have given a
discount to root processes until just recently). So this value only
makes sense to the kernel oom killer implementation. Note that the
equation might change in the future (that has happen in the past several
times) so looking at the value in isolation might be quite misleading.

I can see some point in printing oom_score_adj, though. Seeing biased -
one way or the other - tasks being selected might confirm the setting is
reasonable or otherwise (e.g. seeing tasks with negative scores will
give an indication that they might be not biased enough). Then you can
go and check the eligible tasks dump and see what happened. So this part
makes some sense to me.
-- 
Michal Hocko
SUSE Labs
