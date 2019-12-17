Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18541C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7BB21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576616416;
	bh=TX0HzVIbgBTc0UcW3nmHkrddhV3bY2BUtakgwtAHKQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cJfJxdWhfkfxdRUwG/lNSi+FkPoAwqME2Df0SX1kRBMp3fKa9aMn8qIP7AUR8I+qD
	 PYKOrkVQiIdh8tme/xrEvvlYAYeyfSLiznv8GtQB9dThquvUxfQVk5pkWMo93P4RSf
	 FyuctTPHBjtrwn23KJDY1sZFRj14iKnvM9KfxzDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfLQVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfLQVAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:00:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55431206EC;
        Tue, 17 Dec 2019 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576616414;
        bh=TX0HzVIbgBTc0UcW3nmHkrddhV3bY2BUtakgwtAHKQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd28In3hleDtfPBRKondVS0wUWQPD+jr1QwGu13j3tuxaQ7IgtTParwg4c1im9/mz
         Z3+7/MTicAEk+/I5VmWnzldl3cnFW8nwje7qBAx8IVacfrJpP7CSVH4qMECrMaHCfL
         aeqZVkGy1Sulfqc8DImWH1Ef5D1vtxUTFvW0zoco=
Date:   Tue, 17 Dec 2019 22:00:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched
 hierarchy
Message-ID: <20191217210012.GA4171463@kroah.com>
References: <20191204200623.198897-1-joshdon@google.com>
 <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
 <CAKfTPtCJGT0axT5=E=hLWtMav_kLGVFrSvjZS8+cfvjYS72vqQ@mail.gmail.com>
 <CABk29Ntp5eRFn2otK2o5Fe=uYOvKpjHgKRSw0_er45CVC025Pg@mail.gmail.com>
 <20191217204244.GJ2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217204244.GJ2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:42:44PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 17, 2019 at 11:58:28AM -0800, Josh Don wrote:
> > > Ingo, Peter, what do you think ?
> > 
> > I could add the Co-developed-by tag if that would be sufficient here.
> > As a side note, I'm also looking at upstreaming our other sched
> > fixes/patches, and some of these have the same issue with respect to
> > the original author.  How would you prefer I handle these in general?
> 
> These internal patches that you have, don't they have a SoB on from the
> original author?
> 
> Ingo, Greg, how do we handle patches where the original Author has
> vanished/left etc and no SoB is present?
> 
> Now, in this case we know Venki was with Google in the US, and the US
> allows/has copyright assignment to employers and therefore any old SoB
> from a Google person should probably be sufficient, but that argument
> doesn't work in general (Germany for example doesn't allow copyright
> assignment/transfer).

Most Google kernel work is "work for hire" from what I have heard.

But the copyright of the patch really doesn't matter if the patch is
under the GPLv2 (obviously here), then anyone can send it in and put
their s-o-b on it.  The fact that it's someone from the same company is
good enough to let us know who to track down and kick if something
breaks with the patch, which is all we really need :)

hope this helps,

greg k-h
