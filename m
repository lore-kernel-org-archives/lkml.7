Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F5FC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155783;
	bh=PAUvR3Wb9ZgDXvvdn3Knt6Ky3jXq/dkf1xIHL5qQzN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FFf/7sDGnqFOUIqKuxYtju5rusemWvsrf/NoDsj2A0nCSiTx8IZBhuSJUK8/6Cl/Q
	 2WfXu3WUwvgBRfrXmiktSEEDrudVT3FOyyCIJxm5MZTAg6BbQC/YPtu7Ea+qChk5S0
	 Yd9E9n5g5w0ko2aqUsqMUIh9QOdxcunm9230LHAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEFPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfEFPQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:16:20 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC7D2053B;
        Mon,  6 May 2019 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557155780;
        bh=PAUvR3Wb9ZgDXvvdn3Knt6Ky3jXq/dkf1xIHL5qQzN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07Mu5sKBKQ89GPgcRr/fFMGvEhchgNlu0LlC1/YEkesH/uGsoYB4XEwMkBjGeM5CA
         ymfGWjx6/Ng9dkUCt6ZCoeDuh7copZPALyal5AwpZSj88CS5qLXkDvK3gg5aIBONOv
         E64CAT5DxaeaN8DoefCPiCkiz7u7VD9HJuJUph6E=
Date:   Mon, 6 May 2019 17:16:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     fweisbec@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
Message-ID: <20190506151615.GA14529@lenoir>
References: <20190411033448.20842-5-npiggin@gmail.com>
 <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
 <20190504002733.GB19076@lenoir>
 <1556952021.2xpa7joi2y.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556952021.2xpa7joi2y.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 04:59:12PM +1000, Nicholas Piggin wrote:
> Frederic Weisbecker's on May 4, 2019 10:27 am:
> > On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Piggin wrote:
> >> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
> >> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c1940473a1253d6c
> >> Author:     Nicholas Piggin <npiggin@gmail.com>
> >> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
> >> Committer:  Ingo Molnar <mingo@kernel.org>
> >> CommitDate: Fri, 3 May 2019 19:42:58 +0200
> >> 
> >> sched/isolation: Require a present CPU in housekeeping mask
> >> 
> >> During housekeeping mask setup, currently a possible CPU is required.
> >> That does not guarantee the CPU would be available at boot time, so
> >> check to ensure that at least one present CPU is in the mask.
> > 
> > I have a doubt about the requirements and semantics of cpu_present_mask.
> > IIUC a present CPU means that it is physically plugged in (from ACPI
> > perspective) but might not be logically plugged in (set on cpu_online_mask).
> 
> Right, a superset of cpu_possible_mask, subset of cpu_online_mask. It 
> means that CPU can be brought online at any time.
> 
> > But do we have the guarantee that a present CPU _will_ be online at least once
> > right after the boot? After all, kernel parameters such as "maxcpus=" can prevent
> > from turning some CPUs on. I guess there are even more creative ways to achieve
> > that.
> > 
> > In any case we really require the housekeeper to be forced online. Perhaps
> > I missed that enforcement somewhere in the patchset?
> 
> No I think you're right, that may be able to boot without anything in
> the housekeeping mask. Maybe we can just cpu_up() a CPU in the 
> housekeeping mask with a warning that it has overidden their SMP
> command line option. I'll take a look at it.

But then what if cpu_up() fails? In this case I can think of only two
answers:

* Force the boot CPU as the housekeeper.
* Rollback the whole thing: nohz and all isolation.

The second solution looks sane to me. After all if the user doesn't
include CPU 0 in the housekeeping set, forcing it isn't going to
help much.

But that means we must enhance the isolation code (nohz included)
to be able to dynamically add/del CPUs to the houseeeping/isolation
set. That's not going to be easy but it's a necessary evolution
of that subsystem since we want to drive it through cpusets.

I should start working on that.
