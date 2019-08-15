Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB0C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA20D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LcThbfWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfHOMf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:35:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46203 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:35:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id p13so1607005qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dMM4Yh2lSK206Ipl1C50HgHP0mjyxRSuLJo2cy44isg=;
        b=LcThbfWlDi/1kO+hot7trp2RyPL/m8trA/zLWvD92LpYSw9yeBGasQ9R8EuhQAD4Bt
         bKTs6mxBzCYP5bxVj7suBbpQpwPmyVk9+ValBigp6E3/dN66mhkX8Njt4ppVEZtvDs7I
         pFV8ElSL59gPu/AJrf/nBtVrnXSJNWNiktqRsXie0F6agJz4BKwmgdVzNu8UCtVSZyjt
         8Wo1tUaZ7v0gu4catDl7h/ooM4QQ31MZD++g646hqe9H7YlNvUSIJCxR7iEcgQ6UNJ9L
         6M/IYIm3vG+ItNPPGAvXI3A8PLTW1EGMyGgSG4iOIgZ0ADxVFk0nYIVgDLqPrtq/MGRs
         HJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dMM4Yh2lSK206Ipl1C50HgHP0mjyxRSuLJo2cy44isg=;
        b=ubhrthV8M4eCxqOK67zH20qKiOG5HfydXIXcksBy8T29TMyb9ehTUW+giecH3qmuvE
         hUJHbuZ4MnjX8g72BosYIqTlXpaKucxrinChsXTdotCwghH1v+Lhzg1/JR60BlkOYxAH
         zCBFVPGWFkR0UCDvQE4TxTmdA2CVOAAB8OD18tmNGnO57hj3GWCzO5Aba9bDB0CBM4gw
         CEw7UYvVpgUooUuR9yTPuFtvDtPQN8YxS84iFIlWqHK4A57iN83m651OMJ61QpAFjFZq
         +qRZ9eSxTSz2VdPN9BgAPOnix8H03KB4eyUp48xJ1RqrtKj2L4m1MXIQJCwf3LzULghn
         C0wQ==
X-Gm-Message-State: APjAAAUHIcLVTpvhIZOnPIjuFmaSeQy0cM4AvTb2c/oiMJi6NZOHmMPA
        L0JACeTmbmDsStOUgfIQZakavLx+TZw=
X-Google-Smtp-Source: APXvYqzZPQEBN057F2yrI4X3kt2D83j+OvSKMlIAqweM6AFW+AjersDlJeeVNu5FXC0uFyP+8gWENQ==
X-Received: by 2002:a37:96c7:: with SMTP id y190mr3700663qkd.111.1565872557356;
        Thu, 15 Aug 2019 05:35:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w10sm1320862qts.37.2019.08.15.05.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 05:35:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyEyy-00043M-ES; Thu, 15 Aug 2019 09:35:56 -0300
Date:   Thu, 15 Aug 2019 09:35:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190815123556.GB21596@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-4-daniel.vetter@ffwll.ch>
 <20190815000029.GC11200@ziepe.ca>
 <20190815070249.GB7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815070249.GB7444@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:02:49AM +0200, Daniel Vetter wrote:
> On Wed, Aug 14, 2019 at 09:00:29PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 14, 2019 at 10:20:25PM +0200, Daniel Vetter wrote:
> > > We need to make sure implementations don't cheat and don't have a
> > > possible schedule/blocking point deeply burried where review can't
> > > catch it.
> > > 
> > > I'm not sure whether this is the best way to make sure all the
> > > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > > But it gets the job done.
> > > 
> > > Inspired by an i915 patch series which did exactly that, because the
> > > rules haven't been entirely clear to us.
> > 
> > I thought lockdep already was able to detect:
> > 
> >  spin_lock()
> >  might_sleep();
> >  spin_unlock()
> > 
> > Am I mistaken? If yes, couldn't this patch just inject a dummy lockdep
> > spinlock?
> 
> Hm ... assuming I didn't get lost in the maze I think might_sleep (well
> ___might_sleep) doesn't do any lockdep checking at all. And we want
> might_sleep, since that catches a lot more than lockdep.

Don't know how it works, but it sure looks like it does:

This:
	spin_lock(&file->uobjects_lock);
	down_read(&file->hw_destroy_rwsem);
	up_read(&file->hw_destroy_rwsem);
	spin_unlock(&file->uobjects_lock);

Causes:

[   33.324729] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1444
[   33.325599] in_atomic(): 1, irqs_disabled(): 0, pid: 247, name: ibv_devinfo
[   33.326115] 3 locks held by ibv_devinfo/247:
[   33.326556]  #0: 000000009edf8379 (&uverbs_dev->disassociate_srcu){....}, at: ib_uverbs_open+0xff/0x5f0 [ib_uverbs]
[   33.327657]  #1: 000000005e0eddf1 (&uverbs_dev->lists_mutex){+.+.}, at: ib_uverbs_open+0x16c/0x5f0 [ib_uverbs]
[   33.328682]  #2: 00000000505f509e (&(&file->uobjects_lock)->rlock){+.+.}, at: ib_uverbs_open+0x31a/0x5f0 [ib_uverbs]

And this:

	spin_lock(&file->uobjects_lock);
	might_sleep();
	spin_unlock(&file->uobjects_lock);

Causes:

[   16.867211] BUG: sleeping function called from invalid context at drivers/infiniband/core/uverbs_main.c:1095
[   16.867776] in_atomic(): 1, irqs_disabled(): 0, pid: 245, name: ibv_devinfo
[   16.868098] 3 locks held by ibv_devinfo/245:
[   16.868383]  #0: 000000004c5954ff (&uverbs_dev->disassociate_srcu){....}, at: ib_uverbs_open+0xf8/0x600 [ib_uverbs]
[   16.868938]  #1: 0000000020a6fae2 (&uverbs_dev->lists_mutex){+.+.}, at: ib_uverbs_open+0x16c/0x600 [ib_uverbs]
[   16.869568]  #2: 00000000036e6a97 (&(&file->uobjects_lock)->rlock){+.+.}, at: ib_uverbs_open+0x317/0x600 [ib_uverbs]

I think this is done in some very expensive way, so it probably only
works when lockdep is enabled..

Jason
