Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D145CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A115021734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552409341;
	bh=4+i5e3zX+U/metbZ2m+lAIpb4e8JlI1+gTjO+9Rprv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OtuoRi/NH6V6ySy5z8EZhg1W7Re8v7VdE35voNnRLkn6AgJamoD2vkZvDRO+Z2kpC
	 tGvKxJ2hJ+KzTdUpotFC4HdjC4zUo65c3bbsQr3zMc5WOPN6PELP0uv5RNgx6kGuzc
	 UgOBE2xBVLOh3Mt2KESce7/CzFn34MtH4maomZ74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCLQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfCLQs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:48:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F914AFE8;
        Tue, 12 Mar 2019 16:48:58 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:48:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190312164857.GE5721@dhcp22.suse.cz>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312163741.GA2762@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 09:37:41, Sultan Alsawaf wrote:
> On Tue, Mar 12, 2019 at 09:05:32AM +0100, Michal Hocko wrote:
> > The only way to control the OOM behavior pro-actively is to throttle
> > allocation speed. We have memcg high limit for that purpose. Along with
> > PSI, I can imagine a reasonably working user space early oom
> > notifications and reasonable acting upon that.
> 
> The issue with pro-active memory management that prompted me to create this was
> poor memory utilization. All of the alternative means of reclaiming pages in the
> page allocator's slow path turn out to be very useful for maximizing memory
> utilization, which is something that we would have to forgo by relying on a
> purely pro-active solution. I have not had a chance to look at PSI yet, but
> unless a PSI-enabled solution allows allocations to reach the same point as when
> the OOM killer is invoked (which is contradictory to what it sets out to do),
> then it cannot take advantage of all of the alternative memory-reclaim means
> employed in the slowpath, and will result in killing a process before it is
> _really_ necessary.

If you really want to reach the real OOM situation then you can very
well rely on the in-kernel OOM killer. The only reason you want a
customized oom killer is the tasks clasification. And that is a
different story. User space hints on the victim selection has been a
topic for quite while. It never get to any conclusion as interested
parties have always lost an interest because it got hairy quickly.

> > If you design is relies on the speed of killing then it is fundamentally
> > flawed AFAICT. You cannot assume anything about how quickly a task dies.
> > It might be blocked in an uninterruptible sleep or performin an
> > operation which takes some time. Sure, oom_reaper might help here but
> > still.
> 
> In theory we could instantly zap any process that is not trapped in the kernel
> at the time that the OOM killer is invoked without any consequences though, no?

No, this is not so simple. Have a look at the oom_reaper and hops it has
to go through.
-- 
Michal Hocko
SUSE Labs
