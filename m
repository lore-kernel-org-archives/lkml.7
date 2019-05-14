Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE0820850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ApS8spas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfENMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:32:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfENMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nfiJ0fErHzHqOsAL1Bf0v65xMLNpccKN1AMUIPQ9zQQ=; b=ApS8spaseaHDNS0GgWddD2fg5
        MZjkWzEW1lH3hQUDR4oHhkzTnhajGs4GnvqvWP5ZqJ91TbFJ/7oo7R29lPVcg9tnoCd08Kb3vcxvu
        F1BI0C5v7NAjrW2JSx8WGqfu3d9dgvP42cvYyF7ogjDsaM3B2J3HkEnOrnZBLqUhnVBoiX7oD75uV
        JRM4XWPWTG/QXB62FhFlvl/qAz7L926hWZStSkti1x+r/jjtsaU8fX2YsnujXm1hmUnLFzVO9cPXX
        S3qh7EHzkv2BQKGepStVT2pZh00ZPceNSXBVT+0e9FQ10FdZy9Svb+94MO3qw5NOx7ZYi0WYWXTCf
        dUYkv5NCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQWbP-000358-Bw; Tue, 14 May 2019 12:32:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8FCB2029F877; Tue, 14 May 2019 14:32:13 +0200 (CEST)
Date:   Tue, 14 May 2019 14:32:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC Patch] perf_event: fix a cgroup switch warning
Message-ID: <20190514123213.GR2589@hirez.programming.kicks-ass.net>
References: <20190514002747.7047-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514002747.7047-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:27:47PM -0700, Cong Wang wrote:
> We have been consistently triggering the warning
> WARN_ON_ONCE(cpuctx->cgrp) in perf_cgroup_switch() for a rather
> long time, although we still have no clue on how to reproduce it.
> 
> Looking into the code, it seems the only possibility here is that
> the process calling perf_event_open() with a cgroup target exits
> before the process in the target cgroup exits but after it gains
> CPU to run. This is because we use the atomic counter
> perf_cgroup_events as an indication of whether cgroup perf event
> has enabled or not, which is inaccurate, illustrated as below:
> 
> CPU 0					CPU 1
> // open perf events with a cgroup
> // target for all CPU's
> perf_event_open():
>   account_event_cpu()
>   // perf_cgroup_events == 1
> 				// Schedule in a process in the target cgroup
> 				perf_cgroup_switch()
> perf_event_release_kernel():
>   unaccount_event_cpu()
>   // perf_cgroup_events == 0
> 				// schedule out
> 				// but perf_cgroup_sched_out() is skipped
> 				// cpuctx->cgrp left as non-NULL

				which implies we observed:
				'perf_cgroup_events == 0'

> 				// schedule in another process
> 				perf_cgroup_switch() // WARN triggerred

				which implies we observed:
				'perf_cgroup_events == 1'


Which is impossible. It _might_ have been possible if the out and in
happened on different CPUs. But then I'm not sure that is enough to
trigger the problem.

> The proposed fix is kinda ugly,

Yes :-)

> Suggestions? Thoughts?

At perf_event_release time, when it is the last cgroup event, there
should not be any cgroup events running anymore, so ideally
perf_cgroup_switch() would not set state.

Furthermore; list_update_cgroup_event() will actually clear cpuctx->cgrp
on removal of the last cgroup event.

Also; perf_cgroup_switch() will WARN when there are not in fact any
cgroup events at all. I would expect that WARN to trigger too in your
scneario. But you're not seeing that?

I do however note that that check seems racy; we do that without holding
the ctx_lock.





