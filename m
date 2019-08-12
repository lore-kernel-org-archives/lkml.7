Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55168C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D70208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565610183;
	bh=J2QUGN2hFs/Xmtt8ck2TuwPo3LA4u4ESomEY8TkK5lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ykse/S7H1Er0hbjHmhOCLtyU9VcLBPYoY2uK+ZdYsmpV3248U9ov5IsQJR2XJHzLx
	 cjuP2SR6tJXJ8ONJOAoI//x/5D+fgLZG6mWRVAcInmrBtEZ7YzRsz7WnYrkYq35eDf
	 +idHTwoNbmH/y4Fx7l7qqBOS3drlVdEbxXd2JrvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfHLLnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:43:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728063AbfHLLnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:43:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA11AAF98;
        Mon, 12 Aug 2019 11:42:58 +0000 (UTC)
Date:   Mon, 12 Aug 2019 13:42:56 +0200
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
Message-ID: <20190812114256.GG5117@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
 <20190808185119.GF18351@dhcp22.suse.cz>
 <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
 <20190808200715.GI18351@dhcp22.suse.cz>
 <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
 <20190809064032.GJ18351@dhcp22.suse.cz>
 <CAM3twVRCTLdn+Lhcr+4ZdY3nYVvXFe1O19UR9H121W34H=oV7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVRCTLdn+Lhcr+4ZdY3nYVvXFe1O19UR9H121W34H=oV7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 15:15:18, Edward Chron wrote:
[...]
> So it is optimal if you only have to go and find the correct log and search
> or run your script(s) when you absolutely need to, not on every OOM event.

OK, understood.

> That is the whole point of triage and triage is easier when you have
> relevant information to decide which events require action and with what
> priority.
> 
> The OOM Killed message is the one message that we have go to
> the console and or is sent as SNMP alert to the Admin to let the
> Admin know that a server or switch has suffered a low memory OOM
> event.
> 
> Maybe a few examples would be helpful to show why the few extra
> bits of information would be helpful in such an environment.
> 
> For example if we see serverA and serverB are taking oom events
> with the fooWidget being killed, something along the lines of
> the following you will get message likes this:
> 
> Jul 21 20:07:48 serverA kernel: Out of memory: Killed process 2826
>  (fooWidget) total-vm:10493400kB, anon-rss:10492996kB, file-rss:128kB,
>  shmem-rss:0kB memory-usage:32.0% oom_score: 320 oom_score_adj:0
>  total-pages: 32791748kB
> 
> Jul 21 20:13:51 serverB kernel: Out of memory: Killed process 2911
>  (fooWidget) total-vm:11149196kB, anon-rss:11148508kB, file-rss:128kB,
>  shmem-rss:0kB memory-usage:34.0% oom_score: 340 oom_score_adj:0
>  total-pages: 32791748kB
> 
> It is often possible to recognize that fooWidget is using more memory than
> expected on those systems and you can act on that possibly without ever
> having to hunt down the log and run a script or otherwise analyze the
> log. The % of memory and memory size can often be helpful to understand
> if the numbers look reasonable or not. Maybe the application was updated
> on just the those systems which explains why we don't see issues on the
> other servers running that application, possible application memory leak.

This is all quite vague and requires a lot of guessing. Also your
trained guess eye might easily get confused for constrained OOMs (e.g.
due to NUMA or memcg). So I am not really sold to the percentage idea.
And likewise the oom_score.

[...]

> You can also imagine that if for example systemd-udev gets OOM killed,
> well that should really grab your attention:
> 
> Jul 21 20:08:11 serverX kernel: Out of memory: Killed process 2911
>  (systemd-udevd) total-vm:83128kB, anon-rss:80520kB, file-rss:128kB,
>  shmem-rss:0kB memory-usage:0.1% oom_score: 1001 oom_score_adj:1000
>  total-pages: 8312512kB
> 
> Here we see an obvious issue: systemd-udevd is a critical system app
> and it should not have an oom_score_adj: 1000 that clearly has been changed
> it should be -1000.

I do agree here. As I've said in the previous email oom_score_adj indeed
has some value, and this is a nice example of that. So I am completely
fine with a patch that adds this part to the changelog.

[...]
> > > The oom_score tells us how Linux calculated the score for the task,
> > > the oom_score_adj effects this so it is helpful to have that in
> > > conjunction with the oom_score.
> > > If the adjust is high it can tell us that the task was acting as a
> > > canary and so it's oom_score is high even though it's memory
> > > utilization can be modest or low.
> >
> > I am sorry but I still do not get it. How are you going to use that
> > information without seeing other eligible tasks. oom_score is just a
> > normalized memory usage + some heuristics potentially (we have given a
> > discount to root processes until just recently). So this value only
> > makes sense to the kernel oom killer implementation. Note that the
> > equation might change in the future (that has happen in the past several
> > times) so looking at the value in isolation might be quite misleading.
> 
> We've been through the change where oom_scores went from -17 to 16
> to -1000 to 1000. This was the change David Rientjes from Google made
> back around 2010.
> 
> This was not a problem for us then and if you change again in the future
> (though the current implementation seems quite reasonable) it shouldn't
> be an issue for us going forward or for anyone else that can use the
> additional information in the OOM Kill message we're proposing.

While I appreciate that you are flexible enough to cope with those
changes there are other users which might be less so and there is a
strong "no regressions" rule which might get us into the corner so we
are trying hard to not export to much of an internal information so that
userspace doesn't start depending on them.

[...]

> Now what about the oom_score value changing that you mentioned?
> What if you toss David's OOM Kill algorithm for a new algorithm?
> That could happen. What happens to the message and how do we
> tell things have changed?
> 
> A different oom_score requires a different oom adjustment variable.
> I hope we can agree on that and history supports this.

The idea is that we would have to try to fit oom_score_adj semantic into
a new algoritm and -1000..1000 value range would be hopefully good
enough. That doesn't really dictate the internal calculation of the
badness, if such a theretical alg. would use at all.

> As you recall when David's algorithm was brought in, the Kernel OOM
> team took good care of us. They added a new adjustment value:
> oom_score_adj. As you'll recall the previous oom adjustment variable
> was oom_adj. To keep user level code from breaking the Kernel OOM
> developers provided a conversion so that if your application set
> oom_adj = -17 the Linux OOM code internally set oom_score_adj = -1000.
> They had a conversion that handled all the values. Eventually the
> deprecated oom_adj field was removed, but it was around for several years.

Yes, the scaling just happened to work back then.

[...]

> Further, you export oom_score through the /proc/pid/oom_score
> interface. How the score is calculated could change but it is
> accessible. It's accessible for a reason, it's useful to know how
> the OOM algorithm scores a task and that can be used to help
> set appropriate oom adjustment values. This because what the
> oom_score means is in fact well documented. It needs to.
> Otherwise, the oom adjustment value becomes impossible to
> use intelligently. Thanks to David Rientjes et al for making this so.

The point I am trying to push through is that the score (exported via
proc or displayed via dump_tasks) is valuable only as far as you have a
meaningful comparision to make - aka compare to scores of other tasks.
The value on its own cannot tell you really much without a deep
understanding of how it is calculated. And I absolutely do not want
userspace to hardcode that alg. and rely on it being stable. You really
do not need this internal knowledge when comparing scores of different
tasks, though so it is quite safe and robust from future changes.

We have made those mistakes when exporting way to much internal details
to userspace in the past and got burnt.
 
> One of the really nice design points of David Rientjes implementation
> is that it is very straight forward to use and understand. So hopefully
> if there is a change in the future it's to something that is just as easy
> to use and to understand.
> 
> >
> > I can see some point in printing oom_score_adj, though. Seeing biased -
> > one way or the other - tasks being selected might confirm the setting is
> > reasonable or otherwise (e.g. seeing tasks with negative scores will
> > give an indication that they might be not biased enough). Then you can
> > go and check the eligible tasks dump and see what happened. So this part
> > makes some sense to me.
> 
> Agreed, the oom_score_adj is sorely needed and should be included.

I am willing to ack a patch to add oom_score_adj on the grounds that
this information is helpful to pinpoint misconfigurations and it is not
generally available when dump_tasks is disabled.

> In Summary:
> ----------------
> I hope I have presented a reasonable enough argument for the proposed
> additional parameters.

I am not convinced on oom_score and percentage part because score on its
own is an implementation detail that makes sense when comparing tasks
but on on its own and percentage might be even confusing as explained
above.

Thanks for your detailed information!
-- 
Michal Hocko
SUSE Labs
