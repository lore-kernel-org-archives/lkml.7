Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C26CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQDZIhFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ3NtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:49:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3NtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2hu8C/OlAF3UH78qpfVOcPr9SOx8LcpHWXFVL8G1r8Q=; b=NQDZIhFxSbs2gs8rfDITE4u9T
        58DTiOUQJvIYlPWr9J3GQRXq6hy8jX6TbWXILOfJ2nHA20JV3hv6Kg81aPH5NKhUmvRWHWkLO3kHb
        A68VaPpc7JM2A1hgrR0aG/QQf4UPzDqAizcdTYtJO1+ZPOVU+PJJf8MYqrwi1AUYBgDwQpNDvSBBL
        K4dAl4blYxXpVud/HF1C1jhtpYVvWyr1Y7s+BHmM5U7zUeShTrGSv5zW4VYwwyWwQx7nvdOooZ+0w
        B19hKVp4tJ4FeZZVJ6UJ5X7R5kTf/xJbXZKthx7w/D4Kgd4xdyGpWs+evHH87u8Lbw7etA5XTnWgX
        /iPrS+tng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPoLQ-00058L-NB; Wed, 30 Oct 2019 13:49:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4904D3006D0;
        Wed, 30 Oct 2019 14:48:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F08C2B435A44; Wed, 30 Oct 2019 14:49:01 +0100 (CET)
Date:   Wed, 30 Oct 2019 14:49:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, dsmythies@telus.net
Subject: Re: [PATCH] sched/pelt: fix update of blocked pelt ordering
Message-ID: <20191030134901.GP4131@hirez.programming.kicks-ass.net>
References: <1572434309-32512-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572434309-32512-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:18:29PM +0100, Vincent Guittot wrote:
> update_cfs_rq_load_avg() can call cpufreq_update_util() to trigger an
> update of the frequency. Make sure that RT, DL and IRQ pelt signals have
> been updated before calling cpufreq
> 
> Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
> Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
> Fixes: 91c27493e78d ("sched/irq: Add IRQ utilization tracking")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
