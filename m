Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A4C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9F20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wbCjzFXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgAGKLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:11:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=71YTHE2SxkQte5Ih4VB8vKNNOje4NwvaBBWwBAvETq4=; b=wbCjzFXmzPpPKGJq23+eCErPc
        25KAySIlI1k7SSMfqzwbmTlkfY0F6BrPQ02qX0rxgLhFj/RmssKiOzBZpT11PJpGqp2briE4v8/q8
        cQPNC9yuir9e/FcIkSO+j4dAY3mFfkdXs8gNgY43674RoT/7PqF1Cl6w9cFPqFC0Mte3oNF8+S451
        ADdXWcYxqE2F/2q6ZAeqYNyP8TsqmYhysJ+VEYxfiLtjTzcCR1LxawWeE5sFSBYw4TGZMxVDkAE33
        /2ERp1huFEVNE8Pnh3VvdKSbGx2OMTbigHdH595ie/gHXgrscaDzuOKMC6pxowyjzPgMlYt/EOVo9
        fDYq4wUcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iolpB-0005HG-1z; Tue, 07 Jan 2020 10:10:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9410930025A;
        Tue,  7 Jan 2020 11:09:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 152102B5FB0B6; Tue,  7 Jan 2020 11:10:55 +0100 (CET)
Date:   Tue, 7 Jan 2020 11:10:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Doug Smythies <dsmythies@telus.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Fix a bug in propagating uclamp value in
 new cgroups
Message-ID: <20200107101055.GX2844@hirez.programming.kicks-ass.net>
References: <20191224115405.30622-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224115405.30622-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 11:54:04AM +0000, Qais Yousef wrote:
> When a new cgroup is created, the effective uclamp value wasn't updated
> with a call to cpu_util_update_eff() that looks at the hierarchy and
> update to the most restrictive values.
> 
> Fix it by ensuring to call cpu_util_update_eff() when a new cgroup
> becomes online.
> 
> Without this change, the newly created cgroup uses the default
> root_task_group uclamp values, which is 1024 for both uclamp_{min, max},
> which will cause the rq to to be clamped to max, hence cause the
> system to run at max frequency.
> 
> The problem was observed on Ubuntu server and was reproduced on Debian
> and Buildroot rootfs.
> 
> By default, Ubuntu and Debian create a cpu controller cgroup hierarchy
> and add all tasks to it - which creates enough noise to keep the rq
> uclamp value at max most of the time. Imitating this behavior makes the
> problem visible in Buildroot too which otherwise looks fine since it's a
> minimal userspace.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> Fixes: 0b60ba2dd342 ("sched/uclamp: Propagate parent clamps")
> Link: https://lore.kernel.org/lkml/000701d5b965$361b6c60$a2524520$@net/
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Thanks!
