Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24849C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3042184B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558435050;
	bh=V+fDl9/QwjneUHZbOSez8ISwIolvlwPU41KCQr75m7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CCzrJ8FhKrCnplAtFxxxY2GtS6EAQL6U53EPq62qwLq9oObdX90wtx1L/wg1vH7RT
	 n01Em8B+nH9oJzaV0zSCVD2T0wEv8UAljTTnxwNBx3xxnnrY/jUPbqRLw3x/EiIySc
	 smc4ZW/wHcHM6zCRiUtY7+WCFM6EmCA+hIv0ol8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfEUKh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:37:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUKh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:37:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 452F8AF1C;
        Tue, 21 May 2019 10:37:27 +0000 (UTC)
Date:   Tue, 21 May 2019 12:37:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190521103726.GM32329@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz>
 <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
 <20190521102613.GC219653@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521102613.GC219653@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 19:26:13, Minchan Kim wrote:
> On Tue, May 21, 2019 at 08:24:21AM +0200, Michal Hocko wrote:
> > On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> > > On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > > > [Cc linux-api]
> > > > 
> > > > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > > > Currently, process_madvise syscall works for only one address range
> > > > > so user should call the syscall several times to give hints to
> > > > > multiple address range.
> > > > 
> > > > Is that a problem? How big of a problem? Any numbers?
> > > 
> > > We easily have 2000+ vma so it's not trivial overhead. I will come up
> > > with number in the description at respin.
> > 
> > Does this really have to be a fast operation? I would expect the monitor
> > is by no means a fast path. The system call overhead is not what it used
> > to be, sigh, but still for something that is not a hot path it should be
> > tolerable, especially when the whole operation is quite expensive on its
> > own (wrt. the syscall entry/exit).
> 
> What's different with process_vm_[readv|writev] and vmsplice?
> If the range needed to be covered is a lot, vector operation makes senese
> to me.

I am not saying that the vector API is wrong. All I am trying to say is
that the benefit is not really clear so far. If you want to push it
through then you should better get some supporting data.
-- 
Michal Hocko
SUSE Labs
