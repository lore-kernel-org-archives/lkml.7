Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62788C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F41D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558438889;
	bh=j7NRBuK3uUusKIc6eMMjuvoy8MaQuN0ybJMXn9pt+Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TxDLnJU8suwDH3Q60p+2rFdAwx1yqWuBY7ikIBFMEg0R/IN0JLgd8wt37wgc8cgZo
	 W1lndxMAmtUoD33c6xXCwAIQ1Pu3amouQWkzGrlw+dOQX4q13EEh+ew4PdYe023s1Q
	 GKfcewBRej5kE00wSojg8w0OTsvGqX70mDnn5PMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfEULl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:41:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43876 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEULl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:41:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so1919261pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n5dWQ3Ja5NO1lr47hpp2L5Kch8Dt+AsS9vYvgJKkvHk=;
        b=RX9dvSWsMT0l7VAW/j4tU2p4YOSU8QnbSoiM3l169YXHbFcQ1uK9668GmV+AwA/+u5
         ifhijxtDu7dfAS8sApbydMxP3I8eFKYT1/R/ziLipq7syDiLTsOdFZabpJw6Ag1HbVLH
         fTUPLUZJdQLg0HmFKSmMFBBKRSh0BJClZUpMspvYbpltnQ2FUCKbc98/YRG0scflh6fY
         HXoqWSLaE5eY9Q3dPj8fAr15H9lG/7A1d1xZhitqo2W/11qdbbR3hGgLfq/bMdYQFijz
         GUHTdtmMwo3x9/r5tyS4JCsKbTOv6hMj39iRmwt5DWMndG4vJRdrTaeokcaEQZtE0Xit
         MIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=n5dWQ3Ja5NO1lr47hpp2L5Kch8Dt+AsS9vYvgJKkvHk=;
        b=JG2PPNsiKJHb7n7+M/kzimuWuymXWDiFwwZcQl4fU4y3HS9+H/15iZ0XKH/iQ5050M
         Fw7hP7ZwQfQhj03Jp9JDNXZtoGxuVa6TFf+gBPLrLUdSaBrF+2cMK+bcgs7VXaYP9Pmm
         B1ulBNtCUsKfJwqYBnFlvseX/hW0aRorVwDpXKvNRh+yKfPqjGTo6dNyK3hu+moyC5me
         QMeR3qz7w+rYSI8iB/iLozW3uveZIfjM/SntkFMzWe8edHrTQoKLZRDJ5UrpM1SkS+/O
         MjxefuXMaxCGZZUeptkLZoFEIKRgE7hX1GTvr36sMsA9a7Gb2A5IxAv0N9DgJBDwTpfJ
         9zXA==
X-Gm-Message-State: APjAAAUoTid92X6jBN22Y85jvDfcLtFzk6m2VNiXdWAgMYGHZdoq+uAH
        8ukuL+30RioNFhCf02F7F68=
X-Google-Smtp-Source: APXvYqxnxlMNwKQPfcTH3sQMedqBDlG7IiYvyS99EhYiMtaSNQNsgVFblj9Xg8+PqjERzjJTGTv/0g==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr64532589pgs.343.1558438886922;
        Tue, 21 May 2019 04:41:26 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e12sm38745456pfl.122.2019.05.21.04.41.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 04:41:25 -0700 (PDT)
Date:   Tue, 21 May 2019 20:41:20 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian@brauner.io>
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
Message-ID: <20190521114120.GJ219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com>
 <20190521113029.76iopljdicymghvq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521113029.76iopljdicymghvq@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:30:32PM +0200, Christian Brauner wrote:
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

Okay. I will change the API name at next revision.
Thanks.
