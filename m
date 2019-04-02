Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E11C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050EE20833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiUeC1pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfDBHm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:42:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52724 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDBHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E4n2sKfSEakWUm83jfuhlyJ9zWPyjtzISg50uSuJj78=; b=SiUeC1pEGv/N5PrbqaEABcL3at
        PRh+H+9teoF1Qe/D+vYTwz0samqR66qjUbTlE3oUHN92oi3IC7Q8OHUD7U+d1Z3vWZkBMoE/OKH3I
        t6j+HiFeEQJVS7eTQdPgToWk+g3teb2RIT+GNMOGABQhL9EyArKbs93AhjsZDtpEtX+qbB5LNtLX8
        m/TdkNQrXDwVKHLuEbxsri7565BtqK4rqBDNVrQdQTr452OnInkI8KfcfasBbCiU88vul6WTEG9p1
        iKuqqnG7a65/HyBOOBV9D3S6HjucYlCsKG74oQDqCk3RB0nLE2JuYBzhrqBL6bS03tuvY78bpkWQB
        ucwqHdAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBE45-0000BF-Pf; Tue, 02 Apr 2019 07:42:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E85FC2020F08E; Tue,  2 Apr 2019 09:42:35 +0200 (CEST)
Date:   Tue, 2 Apr 2019 09:42:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190402074235.GI12232@hirez.programming.kicks-ass.net>
References: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
 <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
 <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:23:14PM -0700, Subhra Mazumdar wrote:
> 
> On 3/29/19 6:35 AM, Julien Desfossez wrote:
> > On Fri, Mar 22, 2019 at 8:09 PM Subhra Mazumdar <subhra.mazumdar@oracle.com>
> > wrote:
> > > Is the core wide lock primarily responsible for the regression? I ran
> > > upto patch
> > > 12 which also has the core wide lock for tagged cgroups and also calls
> > > newidle_balance() from pick_next_task(). I don't see any regression.  Of
> > > course
> > > the core sched version of pick_next_task() may be doing more but
> > > comparing with
> > > the __pick_next_task() it doesn't look too horrible.
> > On further testing and investigation, we also agree that spinlock contention
> > is not the major cause for the regression, but we feel that it should be one
> > of the major contributing factors to this performance loss.
> > 
> > 
> I finally did some code bisection and found the following lines are
> basically responsible for the regression. Commenting them out I don't see
> the regressions. Can you confirm? I am yet to figure if this is needed for
> the correctness of core scheduling and if so can we do this better?

It was meant to be an optimization; specifically, when no cookie was
set, don't bother to schedule the sibling(s).

> -------->8-------------
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe3918c..3b3388a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3741,8 +3741,8 @@ pick_next_task(struct rq *rq, struct task_struct
> *prev, struct rq_flags *rf)
>                                  * If there weren't no cookies; we don't
> need
>                                  * to bother with the other siblings.
> */
> -                               if (i == cpu && !rq->core->core_cookie)
> -                                       goto next_class;
> +                               //if (i == cpu && !rq->core->core_cookie)
> +                                       //goto next_class;
> 
> continue;
>                         }
