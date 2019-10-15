Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECD6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DF521848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sN/Ft3Ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJOLe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:34:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfJOLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7d+YQreqBRQcsvWljBKB/AzEl5GFMHHwN18g6igEwNw=; b=sN/Ft3IhQzmxh45kbR92yKOo5
        EnYSTlo9vfW1kf5pnpfBMI0nBrmJ5AtYnLayFf9EB5d4/g8aWEOSuy6yMps3X8IdHXkqBzwpewPWY
        8R6wv3mCFVry4AzP4r1g50N6mDeCkmS4xXyrv/WP/Ml/0bEKeMjI8MB28cZek9QVuR+cIjQjn7wXj
        G2geyvHmoP7wcAhn9W7qRZlqZBuk9I79dVIgVvz7adLPteFHQjr4fLGtmkaIohCh9ZQAgVg7bFq3v
        8MjFW6u7Q77CTuWFzEGdCk3zhgXSYNH3q7Cki6Zv7mVG8qbKbtAopnQHCejX7I8B8uxhBPReAw6YB
        PD/IiZj6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKL5h-0002gr-PP; Tue, 15 Oct 2019 11:34:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7ACF2303807;
        Tue, 15 Oct 2019 13:33:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9F612023039A; Tue, 15 Oct 2019 13:34:10 +0200 (CEST)
Date:   Tue, 15 Oct 2019 13:34:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        seto.hidetoshi@jp.fujitsu.com, qperret@google.com
Subject: Re: [PATCH] sched/topology: Don't set SD_BALANCE_WAKE on cpuset
 domain relax
Message-ID: <20191015113410.GG2311@hirez.programming.kicks-ass.net>
References: <20191014164408.32596-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014164408.32596-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 05:44:08PM +0100, Valentin Schneider wrote:
> As pointed out in commit
> 
>   182a85f8a119 ("sched: Disable wakeup balancing")
> 
> SD_BALANCE_WAKE is a tad too aggressive, and is usually left unset.
> 
> However, it turns out cpuset domain relaxation will unconditionally set it
> on domains below the relaxation level. This made sense back when
> SD_BALANCE_WAKE was set unconditionally, but it no longer is the case.
> 
> We can improve things slightly by noticing that set_domain_attribute() is
> always called after sd_init(), so rather than setting flags we can rely on
> whatever sd_init() is doing and only clear certain flags when above the
> relaxation level.
> 
> While at it, slightly clean up the function and flip the relax level
> check to be more human readable.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> I was tempted to put a
> 
> Fixes: 182a85f8a119 ("sched: Disable wakeup balancing")
> 
> but the SD setup code back then was a mess of SD_INIT() macros which I'm
> not familiar with. It *looks* like the sequence was roughly the same as it
> is now (i.e. set up domain flags, *then* call set_domain_attribute()) but
> I'm not completely sure.

This 'relax' thing is on my list of regrets. It is a terrible thing that
should never have existed.

Are you actually using it or did you just stumble upon it while looking
around there?
