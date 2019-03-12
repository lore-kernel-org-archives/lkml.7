Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC0DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC2A21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552377936;
	bh=XH2tStxWIlE5+LS3Fb9tcdsJI0+c4VlL7elmENUivo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UhaSpK76xUJB1OeykungN4qW9np7GZJZsjaVPssK//kR7qQm0n3vErz40pU/u/5e6
	 dJ31rTa2f7x5E5mg73ST5TMlPKi3lm5FjTHIGX9F1oWVYIkPQAKZ5AeRzziyyTQCwW
	 STspf4TELWGF9QGmz/utWZYNLCjOi+42tTqR3bjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCLIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfCLIFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:05:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64782B608;
        Tue, 12 Mar 2019 08:05:33 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:05:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
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
Message-ID: <20190312080532.GE5721@dhcp22.suse.cz>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-03-19 15:15:35, Suren Baghdasaryan wrote:
> On Mon, Mar 11, 2019 at 1:46 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 01:10:36PM -0700, Suren Baghdasaryan wrote:
> > > The idea seems interesting although I need to think about this a bit
> > > more. Killing processes based on failed page allocation might backfire
> > > during transient spikes in memory usage.
> >
> > This issue could be alleviated if tasks could be killed and have their pages
> > reaped faster. Currently, Linux takes a _very_ long time to free a task's memory
> > after an initial privileged SIGKILL is sent to a task, even with the task's
> > priority being set to the highest possible (so unwanted scheduler preemption
> > starving dying tasks of CPU time is not the issue at play here). I've
> > frequently measured the difference in time between when a SIGKILL is sent for a
> > task and when free_task() is called for that task to be hundreds of
> > milliseconds, which is incredibly long. AFAIK, this is a problem that LMKD
> > suffers from as well, and perhaps any OOM killer implementation in Linux, since
> > you cannot evaluate effect you've had on memory pressure by killing a process
> > for at least several tens of milliseconds.
> 
> Yeah, killing speed is a well-known problem which we are considering
> in LMKD. For example the recent LMKD change to assign process being
> killed to a cpuset cgroup containing big cores cuts the kill time
> considerably. This is not ideal and we are thinking about better ways
> to expedite the cleanup process.

If you design is relies on the speed of killing then it is fundamentally
flawed AFAICT. You cannot assume anything about how quickly a task dies.
It might be blocked in an uninterruptible sleep or performin an
operation which takes some time. Sure, oom_reaper might help here but
still.

The only way to control the OOM behavior pro-actively is to throttle
allocation speed. We have memcg high limit for that purpose. Along with
PSI, I can imagine a reasonably working user space early oom
notifications and reasonable acting upon that.
-- 
Michal Hocko
SUSE Labs
