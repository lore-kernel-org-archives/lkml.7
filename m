Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5143FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EAC20862
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SdLWnqht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEULjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:39:24 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40265 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEULjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:39:23 -0400
Received: by mail-pf1-f172.google.com with SMTP id u17so8940586pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rMELqJJL8ZvhzB/8cSs6BQtnel3t9MrBMkPMUPyznmo=;
        b=SdLWnqht52B7OyRuEON7GO5cjkx9YeJP66M6ScLRWshZWL/JYyRN1lFyS40hdy0MJ7
         n9ExXWXHib1zZMYNbdFrZEN53orV+OYjDbpw7JDnMP01MXEX7G1yHjFhrDXQ4Eb8z2zM
         FL6+EPWF0kR5pyFdpwGT/HWLd/PPTM3s4egkFIwajYeHoecTV3ILXHJjAszQtPt1HiO1
         h9WIme+Dsrb2+2sHBUKk4xvGdXL9gP4yx1/IfCzd8LH0R1nwWc5O8eotAs3ljXarhHfx
         +4ZZisu2cFZzAXmblk9zr1p68VDSVl31TX+9SlqeSpKAK2QmEwJpG3NZuMQYgq+LEtRS
         cGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rMELqJJL8ZvhzB/8cSs6BQtnel3t9MrBMkPMUPyznmo=;
        b=g/WlESO++88PITFMVfiuDxvL5GihVXxOZVGeD01+IGV2X23OzlQX+PtM5Lh9F5vxDE
         QLMnwrWBkXHTCk9lKo5nXqGZXqq/u/3LIwWbvO9gq+U6c6PloRbVHvqxM0TbzyytoRiZ
         bn6Nsnk/JXqbzgWac0RM8GKhi7qYMwHxvGopcog+to0dtvp6tXqSQOcuF/wQkL88JcMq
         2TGPjcR19N7kjCPiaQIG5PncY+liduONmv+HlwtsdexQNZZqPsFHcL8DrLaeHXgQWicX
         6XV6EH01e3ZHJ6v9S+Q8pnmDo2i1JbkdAvxL0tA4TgL8g7Yw+Q3rctudnPAyGCLGt/WV
         nq8Q==
X-Gm-Message-State: APjAAAWODoxaEnP5l/CGYGHB42NRdQIRWz/jO9U8vgt2MdLSZRzWzC1F
        1v7qLM6qcxPhjvJZWBlIgJi2s3bAN4PCmg==
X-Google-Smtp-Source: APXvYqx0c0fKttsWZt0IdW2QrLYIQNUSw5ol3x3/F1gUtr6E6B5iBHc/ImczvzmHNxcnr7K3JVzAhg==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr79262796pgl.361.1558438762842;
        Tue, 21 May 2019 04:39:22 -0700 (PDT)
Received: from brauner.io ([208.54.39.182])
        by smtp.gmail.com with ESMTPSA id u123sm35572404pfu.67.2019.05.21.04.39.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 04:39:22 -0700 (PDT)
Date:   Tue, 21 May 2019 13:39:13 +0200
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
Message-ID: <20190521113911.2rypoh7uniuri2bj@brauner.io>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com>
 <20190521113029.76iopljdicymghvq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521113029.76iopljdicymghvq@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:30:29PM +0200, Christian Brauner wrote:
> On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
> > On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote:
> > > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > > - Background
> > > > 
> > > > The Android terminology used for forking a new process and starting an app
> > > > from scratch is a cold start, while resuming an existing app is a hot start.
> > > > While we continually try to improve the performance of cold starts, hot
> > > > starts will always be significantly less power hungry as well as faster so
> > > > we are trying to make hot start more likely than cold start.
> > > > 
> > > > To increase hot start, Android userspace manages the order that apps should
> > > > be killed in a process called ActivityManagerService. ActivityManagerService
> > > > tracks every Android app or service that the user could be interacting with
> > > > at any time and translates that into a ranked list for lmkd(low memory
> > > > killer daemon). They are likely to be killed by lmkd if the system has to
> > > > reclaim memory. In that sense they are similar to entries in any other cache.
> > > > Those apps are kept alive for opportunistic performance improvements but
> > > > those performance improvements will vary based on the memory requirements of
> > > > individual workloads.
> > > > 
> > > > - Problem
> > > > 
> > > > Naturally, cached apps were dominant consumers of memory on the system.
> > > > However, they were not significant consumers of swap even though they are
> > > > good candidate for swap. Under investigation, swapping out only begins
> > > > once the low zone watermark is hit and kswapd wakes up, but the overall
> > > > allocation rate in the system might trip lmkd thresholds and cause a cached
> > > > process to be killed(we measured performance swapping out vs. zapping the
> > > > memory by killing a process. Unsurprisingly, zapping is 10x times faster
> > > > even though we use zram which is much faster than real storage) so kill
> > > > from lmkd will often satisfy the high zone watermark, resulting in very
> > > > few pages actually being moved to swap.
> > > > 
> > > > - Approach
> > > > 
> > > > The approach we chose was to use a new interface to allow userspace to
> > > > proactively reclaim entire processes by leveraging platform information.
> > > > This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> > > > that are known to be cold from userspace and to avoid races with lmkd
> > > > by reclaiming apps as soon as they entered the cached state. Additionally,
> > > > it could provide many chances for platform to use much information to
> > > > optimize memory efficiency.
> > > > 
> > > > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > > > and MADV_FREE by adding non-destructive ways to gain some free memory
> > > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > > > kernel that memory region is not currently needed and should be reclaimed
> > > > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > > > kernel that memory region is not currently needed and should be reclaimed
> > > > when memory pressure rises.
> > > > 
> > > > To achieve the goal, the patchset introduce two new options for madvise.
> > > > One is MADV_COOL which will deactive activated pages and the other is
> > > > MADV_COLD which will reclaim private pages instantly. These new options
> > > > complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
> > > > gain some free memory space. MADV_COLD is similar to MADV_DONTNEED in a way
> > > > that it hints the kernel that memory region is not currently needed and
> > > > should be reclaimed immediately; MADV_COOL is similar to MADV_FREE in a way
> > > > that it hints the kernel that memory region is not currently needed and
> > > > should be reclaimed when memory pressure rises.
> > > > 
> > > > This approach is similar in spirit to madvise(MADV_WONTNEED), but the
> > > > information required to make the reclaim decision is not known to the app.
> > > > Instead, it is known to a centralized userspace daemon, and that daemon
> > > > must be able to initiate reclaim on its own without any app involvement.
> > > > To solve the concern, this patch introduces new syscall -
> > > > 
> > > > 	struct pr_madvise_param {
> > > > 		int size;
> > > > 		const struct iovec *vec;
> > > > 	}
> > > > 
> > > > 	int process_madvise(int pidfd, ssize_t nr_elem, int *behavior,
> > > > 				struct pr_madvise_param *restuls,
> > > > 				struct pr_madvise_param *ranges,
> > > > 				unsigned long flags);
> > > > 
> > > > The syscall get pidfd to give hints to external process and provides
> > > > pair of result/ranges vector arguments so that it could give several
> > > > hints to each address range all at once.
> > > > 
> > > > I guess others have different ideas about the naming of syscall and options
> > > > so feel free to suggest better naming.
> > > 
> > > Yes, all new syscalls making use of pidfds should be named
> > > pidfd_<action>. So please make this pidfd_madvise.
> > 
> > I don't have any particular preference but just wondering why pidfd is
> > so special to have it as prefix of system call name.
> 
> It's a whole new API to address processes. We already have
> clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since you
> exported pidfd_to_pid(). And we're going to have pidfd_open(). Your
> syscall works only with pidfds so it's tied to this api as well so it
> should follow the naming scheme. This also makes life easier for
> userspace and is consistent.

This is at least my reasoning. I'm not going to make this a whole big
pedantic argument. If people have really strong feelings about not using
this prefix then fine. But if syscalls can be grouped together and have
consistent naming this is always a big plus.
