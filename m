Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CACC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBF2206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erJC+eve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfG3Izx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:55:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfG3Izw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zznkWHyAKSXlGFNMbyU8eVLvlz6q4WNgef8Ep3PFvSE=; b=erJC+evedu1Yk9SO+fIlz72Le
        4BHzk/dhU80gHYoDsyVAEqAiL6MNsJ+cE6NdHKOK4GwW5Eg6jIrRXrgPT/NW4SeKoaFoWr6r58/Iy
        8OA9RiLYTtuUfQxZ4Z4pt40NQcbnQ8WekbN5y20M4ZjAGDYjp8GXXjeXEEziJdb5GAUqmZa4twudj
        ol7RVJXQGZp+P3pdPGg2h3dcriZ/taz/i4g43LHLppXlzrriRBIjRmvlh2n6aSvxvZ9fmjC9cDAD2
        lzIHbx4S3uLt5fSnDoRoR24uzzxOPAWYORGStZeqoXZn7bzFWT0fIWFEgymacNJBDRCOD94uI/Kl4
        BAc7MN0yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNv4-0005fc-U6; Tue, 30 Jul 2019 08:55:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA22420AFFE9E; Tue, 30 Jul 2019 10:55:41 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:55:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 04/14] sched,fair: move runnable_load_avg to cfs_rq
Message-ID: <20190730085541.GU31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-5-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-5-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:38PM -0400, Rik van Riel wrote:
> Since only the root cfs_rq runnable_load_avg field is used any more,
> we can move the field from struct sched_avg, which every sched_entity
> has one of, directly into the struct cfs_rq, of which we have way fewer.
> 
> No functional changes.
> 
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

I think he's praying on space in that cacheline ;-)
