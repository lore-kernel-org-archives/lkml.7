Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B8B22BED
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565164770;
	bh=JSAC7j45OZ1kfTJjr0BQxIkmYCewz4OwdGdDy8NKI6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YcQh/bJoDIYKrIBF344tSzWZtHcV7NePROr3U3tFtDCeHWywa6nLw6YukVcR72v2/
	 bi5WF7/RcqNt/bZ0dHYW+lpLBSZVmJcd3vfnjP+vCuLk4yrYTUOZX6nJzKNCUyyqBt
	 lbRxyLwGk+77GGx2a7r74VCjpxwY25Gm/YK2eLVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfHGH73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:59:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727413AbfHGH73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:59:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3C77ACC6;
        Wed,  7 Aug 2019 07:59:27 +0000 (UTC)
Date:   Wed, 7 Aug 2019 09:59:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190807075927.GO11812@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806220150.GA22516@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 18:01:50, Johannes Weiner wrote:
> On Tue, Aug 06, 2019 at 09:27:05AM -0700, Suren Baghdasaryan wrote:
[...]
> > > > I'm not sure 10s is the perfect value here, but I do think the kernel
> > > > should try to get out of such a state, where interacting with the
> > > > system is impossible, within a reasonable amount of time.
> > > >
> > > > It could be a little too short for non-interactive number-crunching
> > > > systems...
> > >
> > > Would it be possible to have a module with tunning knobs as parameters
> > > and hook into the PSI infrastructure? People can play with the setting
> > > to their need, we wouldn't really have think about the user visible API
> > > for the tuning and this could be easily adopted as an opt-in mechanism
> > > without a risk of regressions.
> 
> It's relatively easy to trigger a livelock that disables the entire
> system for good, as a regular user. It's a little weird to make the
> bug fix for that an opt-in with an extensive configuration interface.

Yes, I definitely do agree that this is a bug fix more than a
feature. The thing is that we do not know what the proper default is for
a wide variety of workloads so some way of configurability is needed
(level and period).  If making this a module would require a lot of
additional code then we need a kernel command line parameter at least.

A module would have a nice advantage that you can change your
configuration without rebooting. The same can be achieved by a sysfs on
the other hand.
-- 
Michal Hocko
SUSE Labs
