Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C2C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA4B208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m64294M5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbfFKNxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:53:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfFKNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Z1K0pqSzBttttrMPRvxIs3/iBm85Id+JwYvBIOcrVU=; b=m64294M5AeaXMyuBlgeH2OCIX
        6orjCajVoCCCVhB7Y8H4jM4Z2CtlCiAwV4eKdSr9Ui97b+cR4FGuaWpoZOzd8X24W3W2M8Ge1MIRW
        8dX48CbINHs/H13f4WQQ3uh2A3h0eQ4MCczBl6k9C6dUZq+jABSL6ZInEVpqjHZNe3FQqqj94mecO
        DYpfu8ZPWqvgcKTiapHwdagULaIBAxmT/a3TzWSjEtsPUQoL+/MKZuWwVpODPcg2xd3uewE3FhHad
        NgkrYFTY2P9qzrY3dRz2jHlgCpdd5cZ3klHlQD93vG2qkQoFEXC9iSnT0o3qfy3l8fs79pjjYOz6q
        hfuKSKPGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hahDL-0003N7-RU; Tue, 11 Jun 2019 13:53:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C477B20236A42; Tue, 11 Jun 2019 15:53:25 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:53:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bsegall@google.com
Cc:     linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611135325.GY3436@hirez.programming.kicks-ass.net>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:21:01AM -0700, bsegall@google.com wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index efa686eeff26..60219acda94b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -356,6 +356,7 @@ struct cfs_bandwidth {
>  	u64			throttled_time;
>  
>  	bool                    distribute_running;
> +	bool                    slack_started;
>  #endif
>  };

I'm thinking we can this instead? afaict both idle and period_active are
already effecitively booleans and don't need the full 16 bits.

--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -338,8 +338,10 @@ struct cfs_bandwidth {
 	u64			runtime_expires;
 	int			expires_seq;
 
-	short			idle;
-	short			period_active;
+	u8			idle;
+	u8			period_active;
+	u8			distribute_running;
+	u8			slack_started;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
@@ -348,9 +350,6 @@ struct cfs_bandwidth {
 	int			nr_periods;
 	int			nr_throttled;
 	u64			throttled_time;
-
-	bool                    distribute_running;
-	bool                    slack_started;
 #endif
 };
 
