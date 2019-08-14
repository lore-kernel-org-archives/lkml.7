Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813492133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565807823;
	bh=cdCShOSIn7AVcKuceO9zBeCCl+uxmmjymGg+QTheSZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2iEBlQqtQISaRqlpsTgjw1v1R0LyEyOaoq/9iBRFlHcMz2zp4GiF9eKIuz4UEYfHq
	 CwzHu2nHMmFI6MROkEhxNDL+U2vpiAzXKgMnsRFf5mm7/tBVhZZMj5OPoFsHucviep
	 WwGrQ0GCSlb7mZl9lapHZgnfmkx3qGkPmNgpXNRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfHNShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:37:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728389AbfHNShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:37:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8BC2AC6E;
        Wed, 14 Aug 2019 18:36:58 +0000 (UTC)
Date:   Wed, 14 Aug 2019 20:36:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 2/6] mm/page_idle: Add support for handling swapped
 PG_Idle pages
Message-ID: <20190814183657.GK17933@dhcp22.suse.cz>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807171559.182301-2-joel@joelfernandes.org>
 <20190813150450.GN17933@dhcp22.suse.cz>
 <20190813153659.GD14622@google.com>
 <20190814080531.GP17933@dhcp22.suse.cz>
 <20190814163203.GB59398@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814163203.GB59398@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 12:32:03, Joel Fernandes wrote:
> On Wed, Aug 14, 2019 at 10:05:31AM +0200, Michal Hocko wrote:
> > On Tue 13-08-19 11:36:59, Joel Fernandes wrote:
> > > On Tue, Aug 13, 2019 at 05:04:50PM +0200, Michal Hocko wrote:
> > > > On Wed 07-08-19 13:15:55, Joel Fernandes (Google) wrote:
> > > > > Idle page tracking currently does not work well in the following
> > > > > scenario:
> > > > >  1. mark page-A idle which was present at that time.
> > > > >  2. run workload
> > > > >  3. page-A is not touched by workload
> > > > >  4. *sudden* memory pressure happen so finally page A is finally swapped out
> > > > >  5. now see the page A - it appears as if it was accessed (pte unmapped
> > > > >     so idle bit not set in output) - but it's incorrect.
> > > > > 
> > > > > To fix this, we store the idle information into a new idle bit of the
> > > > > swap PTE during swapping of anonymous pages.
> > > > >
> > > > > Also in the future, madvise extensions will allow a system process
> > > > > manager (like Android's ActivityManager) to swap pages out of a process
> > > > > that it knows will be cold. To an external process like a heap profiler
> > > > > that is doing idle tracking on another process, this procedure will
> > > > > interfere with the idle page tracking similar to the above steps.
> > > > 
> > > > This could be solved by checking the !present/swapped out pages
> > > > right? Whoever decided to put the page out to the swap just made it
> > > > idle effectively.  So the monitor can make some educated guess for
> > > > tracking. If that is fundamentally not possible then please describe
> > > > why.
> > > 
> > > But the monitoring process (profiler) does not have control over the 'whoever
> > > made it effectively idle' process.
> > 
> > Why does that matter? Whether it is a global/memcg reclaim or somebody
> > calling MADV_PAGEOUT or whatever it is a decision to make the page not
> > hot. Sure you could argue that a missing idle bit on swap entries might
> > mean that the swap out decision was pre-mature/sub-optimal/wrong but is
> > this the aim of the interface?
> > 
> > > As you said it will be a guess, it will not be accurate.
> > 
> > Yes and the point I am trying to make is that having some space and not
> > giving a guarantee sounds like a safer option for this interface because
> 
> I do see your point of view, but jJust because a future (and possibly not
> going to happen) usecase which you mentioned as pte reclaim, makes you feel
> that userspace may be subject to inaccuracies anyway, doesn't mean we should
> make everything inaccurate..  We already know idle page tracking is not
> completely accurate. But that doesn't mean we miss out on the opportunity to
> make the "non pte-reclaim" usecase inaccurate as well. 

Just keep in mind that you will add more burden to future features
because they would have to somehow overcome this user visible behavior
and we will get to the usual question - Is this going to break
something that relies on the idle bit being stable?

> IMO, we should do our best for today, and not hypothesize. How likely is pte
> reclaim and is there a thread to describe that direction?

Not that I am aware of now but with large NVDIMM mapped files I can see
that this will get more and more interesting.
-- 
Michal Hocko
SUSE Labs
