Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFA420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qO1EBngv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCSPho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:37:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vpnb2AMxvNgluY7lzcdhoE5yoHvclf4Jh9el29LaULE=; b=qO1EBngv7evdNHD5cKO8j69nP
        unZzGDBk8VCPnHHpvyuSBNSPK16EDdyVDsMKO98Dd0RlnNC7/wtT6eVephmSl6tjTPLQhlyVgn8Ip
        UvW+lPrE/sQFca+tpHPlqOB1VudF5L4VBB/pM7YR11njZy2SH7CJDJxgp/CR0QF54wIMO/k5fqM8b
        wuSsCpnKI2Et66HxKzCLAUV1+DHDhAWpXM90NEej+kYNb5P1PMp/U6obJyxpQJkCZCZ/ejPhPNV7k
        RRDZSrqvx2xErLGN0SwHVbGvmBtHfl9+NnPvqKiddaqvLZU8sQnt0iFQxV0Hkam+RrfNqcm3Ed0pq
        Z0Nbwm1Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Go7-0001lq-8f; Tue, 19 Mar 2019 15:37:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC97025E45416; Tue, 19 Mar 2019 16:37:37 +0100 (CET)
Date:   Tue, 19 Mar 2019 16:37:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Do not re-read h_load_next during hierarchical
 load calculation v2
Message-ID: <20190319153737.GK5996@hirez.programming.kicks-ass.net>
References: <20190319123610.nsivgf3mjbjjesxb@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319123610.nsivgf3mjbjjesxb@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:36:10PM +0000, Mel Gorman wrote:
> Changelog since v1
> o Use WRITE_ONCE
> o Add Fixes:
> o Add reviewed-by for the READ_ONCE part as I considered it to still be
>   ok even after the WRITE_ONCE
> 
> A NULL pointer dereference bug was reported on a distribution kernel but
> the same issue should be present on mainline kernel. It occured on s390
> but should not be arch-specific.  A partial oops looks like
> 
> [775277.408564] Unable to handle kernel pointer dereference in virtual kernel address space
> ...
> [775277.408759] Call Trace:
> [775277.408763] ([<0002c11c56899c61>] 0x2c11c56899c61)
> [775277.408766]  [<0000000000177bb4>] try_to_wake_up+0xfc/0x450
> [775277.408773]  [<000003ff81ede872>] vhost_poll_wakeup+0x3a/0x50 [vhost]
> [775277.408777]  [<0000000000194ae4>] __wake_up_common+0xbc/0x178
> [775277.408779]  [<0000000000194f86>] __wake_up_common_lock+0x9e/0x160
> [775277.408780]  [<00000000001950de>] __wake_up_sync_key+0x4e/0x60
> [775277.408785]  [<00000000005d911e>] sock_def_readable+0x5e/0x98
> 
> The bug hits any time between 1 hour to 3 days. The dereference occurs
> in update_cfs_rq_h_load when accumulating h_load. The problem is that
> cfq_rq->h_load_next is not protected by any locking and can be updated
> by parallel calls to task_h_load. Depending on the compiler, code may be
> generated that re-reads cfq_rq->h_load_next after the check for NULL and
> then oops when reading se->avg.load_avg. The dissassembly showed that it
> was possible to reread h_load_next after the check for NULL.
> 
> While this does not appear to be an issue for later compilers, it's still
> an accident if the correct code is generated. Full locking in this path
> would have high overhead so this patch uses READ_ONCE to read h_load_next
> only once and check for NULL before dereferencing. It was confirmed that
> there were no further oops after 10 days of testing.
> 
> As Peter pointed out, it is also necessary to use WRITE_ONCE to avoid any
> potential problems with store tearing.
> 
> Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
> [peterz@infradead.org: Use WRITE_ONCE to protect against store tearing]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: stable@vger.kernel.org

Thanks!
