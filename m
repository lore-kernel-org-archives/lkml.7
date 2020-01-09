Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE2C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2EB20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578607143;
	bh=iksyQYS7VMr3jaeVMQa6xCLTdh3g3ItUiFNgJFWUQCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WLxCogOGZPCM8Ivxc49AOFNT6UR79jR6krpexbG/LXsJlsnfIhdf1xJE/Ub73u6Dj
	 3J0ZvbNFxJ+Qn+M0pnihWb2Xqwd1ABqVmKQ8Ag5W9fVMJ0+cKxWMq+iUgHs11lN1fp
	 nntTfnA6wyfh9QXXUln6gE5+7N0BU/xaMvKi69uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgAIV7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:59:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37077 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIV7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:59:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so9103627wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kDXENq3pxHwGmYQcpY44U06RWM91Gjk8kdFmevm8mzA=;
        b=H/xdaF0PIHHzjgtIZ1gEuz+tfGmmH6OeA32peKrFWcH2bqk/BfVjpxUmNDmMNxqsAP
         LxLjRVVc1u6zkwn5gyRSGg6TY78qhmYhIV1Xdywr8Nt9/wmZyBX4nsMBWiLQyE3JrlaG
         KbAk/ooi3r2s+6pI8MTbcR170eW1bB4m3Nqjhln+h2kNNpDsVlb8Y2ctlTwBWOPXqVlc
         xGOMlNyqLUk2Dmv9whBFKYaVnBSsUnvTZPk4buHi5boSq4tHg2B0/e5STESf0JQhp9HC
         Olf5Fg4wq4Frxg6MrMFEpPI59x0qhBl5FD8zQFkbvQp3DWLcB9B+CA8fHH0a1noAUUg0
         IdRA==
X-Gm-Message-State: APjAAAWoZ25momevLPKFg/gGJ76oAkL2LwwGCX3aMQOgaGBN7GL38pGu
        okgTHxEYxLAwd50EwBE5fS4=
X-Google-Smtp-Source: APXvYqwxykAeg3qT/6OmUUL8ATOvGkTLMyDiwE8iGhHAiZGVPFqAjT/O1ElElTdyAQ7hDmpmYDah0g==
X-Received: by 2002:adf:e683:: with SMTP id r3mr12837384wrm.38.1578607140530;
        Thu, 09 Jan 2020 13:59:00 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id k7sm4068539wmi.19.2020.01.09.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:58:58 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:58:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109215858.GD23620@dhcp22.suse.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz>
 <20200109214604.nfzsksyv3okj3ec2@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109214604.nfzsksyv3okj3ec2@shells.gnugeneration.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 13:46:04, Vito Caputo wrote:
> On Thu, Jan 09, 2020 at 10:03:07PM +0100, Pavel Machek wrote:
> > On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> > > On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > I updated my userspace to x86-64, and now chromium likes to eat all
> > > > the memory and bring the system to standstill.
> > > > 
> > > > Unfortunately, OOM killer does not react:
> > > > 
> > > > I'm now running "ps aux", and it prints one line every 20 seconds or
> > > > more. Do we agree that is "unusable" system? I attempted to do kill
> > > > from other session.
> > > 
> > > Does sysrq+f help?
> > 
> > May try that next time.
> > 
> > > > Do we agree that OOM killer should have reacted way sooner?
> > > 
> > > This is impossible to answer without knowing what was going on at the
> > > time. Was the system threshing over page cache/swap? In other words, is
> > > the system completely out of memory or refaulting the working set all
> > > the time because it doesn't fit into memory?
> > 
> > Swap was full, so "completely out of memory", I guess. Chromium does
> > that fairly often :-(.
> > 
> 
> Have you considered restricting its memory limits a la `ulimit -m`?

The kernel ignores RLIMIT_RSS. Unless the browser takes it into
consideration then I do not see how that would help.

> I've taken to running browsers in nspawn containers for general
> isolation improvements, but this also makes it easy to set cgroup
> resource limits like memcg.  i.e. --property MemoryMax=2G

Yes, this should help to isolate the problem.

> This prevents the browser from bogging down the entire system, but it
> doesn't prevent thrashing before FF OOMs within its control group.
> 
> I do feel there's a problem with the kernel's reclaim algorithm, it
> seems far too willing to evict file-backed pages that are recently in
> use.

It is true that the memory reclaim is quite page cache reclaim biased
unless there is very small amount of the page cache. Page cache refault
is considered during the reclaim but I am afraid that there are still
corner cases where the workload might end up threshing. Be it on the
page cache or the anonymous memory depending on the workload. Anyway
getting data from real workloads is always good so that we can think on
improving existing heuristics.

-- 
Michal Hocko
SUSE Labs
