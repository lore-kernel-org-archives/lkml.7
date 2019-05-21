Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC76217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gaz82++3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfEULao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:30:44 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33466 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEULan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:30:43 -0400
Received: by mail-pf1-f172.google.com with SMTP id z28so8954753pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u3aOCF7DfNjOUaUxeGwv8GNryvyR8Wto9mzcT26En+8=;
        b=gaz82++3GLFJz+NYZhFL463z/kKlo0LB5+AxLKqcQcr25Au3ZagpLlvofHN5Kpj31X
         kKXIkGUhEsVjvdFSZ1d9PRzo003Fl0lhi4bSXQVhk/+mPI+7pAgVTbXn4EQzd9U/mwHq
         gquUUPQt543lEQ+4PXdzsTAOpSkEYbWHEAmXQTyZM9jGFlIg7oiB7Y8cMzZLBeBGhcrs
         a8pv+97z6xSh6oHkeUiv08wxgPQz+quul0dy+DPgC86FWigNnRECU/8+AvNsOhqLHP+H
         cZz8qTYbyXJfIab5RamvA2Lmh8sxenfTxdj9jemGrLjFEZjGdr72jiaeIfRVSj4Xnb7q
         Wb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u3aOCF7DfNjOUaUxeGwv8GNryvyR8Wto9mzcT26En+8=;
        b=gLSMAmv/NeqWrV1GCH9/3FjjmrvxIRlqsiLLMc1ccbCZnfJOwwvlzc0UHNNOn9ZD3j
         L4XcQS/MjDiAyxM0FxRBER3vIwHV1O5M3jkQ1bQ2EW4AkfXAXVE+V1WPqttQ9d+FIdi0
         kTSVVKWl7IQPTpJWNRnVFhVJQY87fub/5ywuSGH+jTFoJ3upjC9cEBG9inuVLKSpmRRC
         358QbounA+uTqBzpAJC6uaPcEetp4XvesHXDAxC01FBfuJ5o6h09SJeEPGRBVxc3R657
         9ftf5SB7o2RNVIt6WrHoyPYLnLWft5eWqZa0J+YjXb9b0CnkPFs0jYtJls2OooKhVS5s
         cvzA==
X-Gm-Message-State: APjAAAW7LpLY0cuit2klE79TQ6CeOyJfjKY5gbjG5+51ObhSh63r6loy
        jvq0M/9WtBEpfyn8WjU7CvXyJq64eH3+lA==
X-Google-Smtp-Source: APXvYqwJPD0ZUEtL4HulVslE71s0X020brUXLDTYwpPLeLG7JLmhdoNZKge0vYtjnm0wXLCQDZ2gEQ==
X-Received: by 2002:a63:4342:: with SMTP id q63mr80473096pga.435.1558438242250;
        Tue, 21 May 2019 04:30:42 -0700 (PDT)
Received: from brauner.io ([208.54.39.182])
        by smtp.gmail.com with ESMTPSA id d9sm25956682pgj.34.2019.05.21.04.30.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 04:30:41 -0700 (PDT)
Date:   Tue, 21 May 2019 13:30:32 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521113029.76iopljdicymghvq@brauner.io>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521110552.GG219653@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
> On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote:
> > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > - Background
> > > 
> > > The Android terminology used for forking a new process and starting an app
> > > from scratch is a cold start, while resuming an existing app is a hot start.
> > > While we continually try to improve the performance of cold starts, hot
> > > starts will always be significantly less power hungry as well as faster so
> > > we are trying to make hot start more likely than cold start.
> > > 
> > > To increase hot start, Android userspace manages the order that apps should
> > > be killed in a process called ActivityManagerService. ActivityManagerService
> > > tracks every Android app or service that the user could be interacting with
> > > at any time and translates that into a ranked list for lmkd(low memory
> > > killer daemon). They are likely to be killed by lmkd if the system has to
> > > reclaim memory. In that sense they are similar to entries in any other cache.
> > > Those apps are kept alive for opportunistic performance improvements but
> > > those performance improvements will vary based on the memory requirements of
> > > individual workloads.
> > > 
> > > - Problem
> > > 
> > > Naturally, cached apps were dominant consumers of memory on the system.
> > > However, they were not significant consumers of swap even though they are
> > > good candidate for swap. Under investigation, swapping out only begins
> > > once the low zone watermark is hit and kswapd wakes up, but the overall
> > > allocation rate in the system might trip lmkd thresholds and cause a cached
> > > process to be killed(we measured performance swapping out vs. zapping the
> > > memory by killing a process. Unsurprisingly, zapping is 10x times faster
> > > even though we use zram which is much faster than real storage) so kill
> > > from lmkd will often satisfy the high zone watermark, resulting in very
> > > few pages actually being moved to swap.
> > > 
> > > - Approach
> > > 
> > > The approach we chose was to use a new interface to allow userspace to
> > > proactively reclaim entire processes by leveraging platform information.
> > > This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> > > that are known to be cold from userspace and to avoid races with lmkd
> > > by reclaiming apps as soon as they entered the cached state. Additionally,
> > > it could provide many chances for platform to use much information to
> > > optimize memory efficiency.
> > > 
> > > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > > and MADV_FREE by adding non-destructive ways to gain some free memory
> > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > > kernel that memory region is not currently needed and should be reclaimed
> > > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > > kernel that memory region is not currently needed and should be reclaimed
> > > when memory pressure rises.
> > > 
> > > To achieve the goal, the patchset introduce two new options for madvise.
> > > One is MADV_COOL which will deactive activated pages and the other is
> > > MADV_COLD which will reclaim private pages instantly. These new options
> > > complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
> > > gain some free memory space. MADV_COLD is similar to MADV_DONTNEED in a way
> > > that it hints the kernel that memory region is not currently needed and
> > > should be reclaimed immediately; MADV_COOL is similar to MADV_FREE in a way
> > > that it hints the kernel that memory region is not currently needed and
> > > should be reclaimed when memory pressure rises.
> > > 
> > > This approach is similar in spirit to madvise(MADV_WONTNEED), but the
> > > information required to make the reclaim decision is not known to the app.
> > > Instead, it is known to a centralized userspace daemon, and that daemon
> > > must be able to initiate reclaim on its own without any app involvement.
> > > To solve the concern, this patch introduces new syscall -
> > > 
> > > 	struct pr_madvise_param {
> > > 		int size;
> > > 		const struct iovec *vec;
> > > 	}
> > > 
> > > 	int process_madvise(int pidfd, ssize_t nr_elem, int *behavior,
> > > 				struct pr_madvise_param *restuls,
> > > 				struct pr_madvise_param *ranges,
> > > 				unsigned long flags);
> > > 
> > > The syscall get pidfd to give hints to external process and provides
> > > pair of result/ranges vector arguments so that it could give several
> > > hints to each address range all at once.
> > > 
> > > I guess others have different ideas about the naming of syscall and options
> > > so feel free to suggest better naming.
> > 
> > Yes, all new syscalls making use of pidfds should be named
> > pidfd_<action>. So please make this pidfd_madvise.
> 
> I don't have any particular preference but just wondering why pidfd is
> so special to have it as prefix of system call name.

It's a whole new API to address processes. We already have
clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since you
exported pidfd_to_pid(). And we're going to have pidfd_open(). Your
syscall works only with pidfds so it's tied to this api as well so it
should follow the naming scheme. This also makes life easier for
userspace and is consistent.

> 
> > 
> > Please make sure to Cc me on this in the future as I'm maintaining
> > pidfds. Would be great to have Jann on this too since he's been touching
> > both mm and parts of the pidfd stuff with me.
> 
> Sure!

Thanks!
