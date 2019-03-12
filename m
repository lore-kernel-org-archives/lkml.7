Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28DC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B62A205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552405172;
	bh=ooefpY5XUomA4H20flu3Tv/FyAe+8GjrL+qbwLrbORE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2UnQMhJ8jNEFcNU6j1AhqSZV2HYC6gjxFZRlZeySK5+AFSSdcu6JphVd3rdqfsyU1
	 8O59RuN0Tal8AFi7UmJJ/u7quLrhPNNJ24sCpEi3MDDGwx378Yttrq+Fnh2hS1qQ6e
	 yBDH+If3jDiFasEMn9KGnJi6X2OpCgzpfePxzoZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfCLPja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:39:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfCLPja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:39:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7525B172;
        Tue, 12 Mar 2019 15:39:28 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:39:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
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
Message-ID: <20190312153928.GW5721@dhcp22.suse.cz>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312152541.GI19508@bombadil.infradead.org>
 <20190312153315.GV5721@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312153315.GV5721@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 16:33:15, Michal Hocko wrote:
> On Tue 12-03-19 08:25:41, Matthew Wilcox wrote:
> > On Tue, Mar 12, 2019 at 09:05:32AM +0100, Michal Hocko wrote:
> > > On Mon 11-03-19 15:15:35, Suren Baghdasaryan wrote:
> > > > Yeah, killing speed is a well-known problem which we are considering
> > > > in LMKD. For example the recent LMKD change to assign process being
> > > > killed to a cpuset cgroup containing big cores cuts the kill time
> > > > considerably. This is not ideal and we are thinking about better ways
> > > > to expedite the cleanup process.
> > > 
> > > If you design is relies on the speed of killing then it is fundamentally
> > > flawed AFAICT. You cannot assume anything about how quickly a task dies.
> > > It might be blocked in an uninterruptible sleep or performin an
> > > operation which takes some time. Sure, oom_reaper might help here but
> > > still.
> > 
> > Many UNINTERRUPTIBLE sleeps can be converted to KILLABLE sleeps.  It just
> > needs someone to do the work.
> 
> They can and should as much as possible. No question about that. But not
> all of them can and that is why nobody should be relying on that. That
> is the whole point of having the oom_reaper and async oom victim tear
> down.

Let me clarify a bit. LMK obviously doesn't need any guarantee like the
core oom killer because it is more of a pro-active measure than the last
resort. I merely wanted to say that relying on a design which assumes
anything about time victim needs to exit is flawed and it will fail
under different workloads. On the other hand this might work good enough
on very specific workloads to be usable. I am not questioning that. The
point is that this is not generic enough to be accepted to the upstream
kernel.
-- 
Michal Hocko
SUSE Labs
