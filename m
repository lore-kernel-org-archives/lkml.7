Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66021C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DFA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569226092;
	bh=ud1bYGqiXi/k6R3ixFTxqhNV5mdwlv0XZgbnMWeMqvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pyYXE9RcZr8s5DraswsnKVYBznFcvbdyTGkSCxb8QzsnCHohH2+gwyZ1NHh3F8tzZ
	 essv4terRNwA/11vcvN8XO3jUACqJVQGK993Sg1YOXfZAtREB6fBgWfrZ2vMXgQKrz
	 JdGNLFJ8SbpHXhh23Ol9LrOC0Lo2adOtnrNyo3lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405591AbfIWIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:08:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfIWIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:08:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 594E1B023;
        Mon, 23 Sep 2019 08:08:09 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:08:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190923080808.GA6016@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz>
 <87ftku96md.fsf@x220.int.ebiederm.org>
 <20190918071541.GB12770@dhcp22.suse.cz>
 <87h8585bej.fsf@x220.int.ebiederm.org>
 <20190922065801.GB18814@dhcp22.suse.cz>
 <875zlk3tz9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zlk3tz9.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, do you want me to send the patch or you can grab it from here?

On Sun 22-09-19 16:24:10, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > From 711000fdc243b6bc68a92f9ef0017ae495086d39 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Sun, 22 Sep 2019 08:45:28 +0200
> > Subject: [PATCH] kernel/sysctl.c: do not override max_threads provided by
> >  userspace
> >
> > Partially revert 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> > because the patch is causing a regression to any workload which needs to
> > override the auto-tuning of the limit provided by kernel.
> >
> > set_max_threads is implementing a boot time guesstimate to provide a
> > sensible limit of the concurrently running threads so that runaways will
> > not deplete all the memory. This is a good thing in general but there
> > are workloads which might need to increase this limit for an application
> > to run (reportedly WebSpher MQ is affected) and that is simply not
> > possible after the mentioned change. It is also very dubious to override
> > an admin decision by an estimation that doesn't have any direct relation
> > to correctness of the kernel operation.
> >
> > Fix this by dropping set_max_threads from sysctl_max_threads so any
> > value is accepted as long as it fits into MAX_THREADS which is important
> > to check because allowing more threads could break internal robust futex
> > restriction. While at it, do not use MIN_THREADS as the lower boundary
> > because it is also only a heuristic for automatic estimation and admin
> > might have a good reason to stop new threads to be created even when
> > below this limit.
> >
> > Fixes: 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> > Cc: stable
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks Eric.

> > ---
> >  kernel/fork.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 2852d0e76ea3..ef865be37e98 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2929,7 +2929,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
> >  	struct ctl_table t;
> >  	int ret;
> >  	int threads = max_threads;
> > -	int min = MIN_THREADS;
> > +	int min = 1;
> >  	int max = MAX_THREADS;
> >  
> >  	t = *table;
> > @@ -2941,7 +2941,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
> >  	if (ret || !write)
> >  		return ret;
> >  
> > -	set_max_threads(threads);
> > +	max_threads = threads;
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.20.1

-- 
Michal Hocko
SUSE Labs
