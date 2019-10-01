Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28569ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07739218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbfJAIwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJAIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:52:15 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1AB411A1F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 08:52:14 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o8so1100626wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3xlO7TaHFHwT8jXasdq8AJJ7zol/7iECMT7Y59gYD4=;
        b=IstFMBQ0bDN3myWToUKErPQB/JW/V0Vhq91Imifn639PdgUN7WKfQ877vmwer75w42
         OsLUu5PqO8WHkfmAesZ22vZBoM59KoWEthdkk/tC5j69ouWZQXZHet2JxZOicxdXbwmS
         X88wfy+pkWOScjKhFTh2M3OesZf3xus7y9jZoctKt+Vw/DithKyclG3ZVX0QjCtCQg5N
         crB1myir7q5LUYGhrvJsNelHCUofYckNNn/s9wZgfct9xMCBa9Y3x2ylXsqBjHSEgc7k
         2nvjho+Ah1S7kN92qPbgu6Ww8r4Lua5uTcWbZSM5S3z46P7Ay1K+qKnzfbtOnMcEOxFQ
         Q6NQ==
X-Gm-Message-State: APjAAAVUBlKGONUQyUcA7mXqZ5Ey+WW89lrV2GEqv71gzjgHGkbPMoEi
        yimri/+pSW2YDRYrsSfyC739Qzikf6DtHi2Nf0am70qqno9FvcckPS59TGsdRqTwaTgN19u5VIJ
        gTLE6BrorSFWO3pm1P1oPwXgq
X-Received: by 2002:a5d:618a:: with SMTP id j10mr15928540wru.168.1569919933395;
        Tue, 01 Oct 2019 01:52:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8/49hwt2vzb8oiIwuAd5CNWC+ld9UCGKlur/R2FDoiRZ1Smkn0sdEc93OBCQpH+pqgjCyOQ==
X-Received: by 2002:a5d:618a:: with SMTP id j10mr15928494wru.168.1569919932875;
        Tue, 01 Oct 2019 01:52:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id y186sm4810444wmb.41.2019.10.01.01.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 01:52:11 -0700 (PDT)
Date:   Tue, 1 Oct 2019 10:52:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20191001085209.GA6481@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
 <20190927081141.GB31660@localhost.localdomain>
 <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
 <20190930071233.GE31660@localhost.localdomain>
 <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/19 11:24, Scott Wood wrote:
> On Mon, 2019-09-30 at 09:12 +0200, Juri Lelli wrote:

[...]

> > Hummm, I was actually more worried about the fact that we call free_old_
> > cpuset_bw_dl() only if p->state != TASK_WAKING.
> 
> Oh, right. :-P  Not sure what I had in mind there; we want to call it
> regardless.
> 
> I assume we need rq->lock in free_old_cpuset_bw_dl()?  So something like

I think we can do with rcu_read_lock_sched() (see dl_task_can_attach()).

> this:
> 
> 	if (p->state == TASK_WAITING)
> 		raw_spin_lock(&rq->lock);
> 	free_old_cpuset_bw_dl(rq, p);
> 	if (p->state != TASK_WAITING)
> 		return;
> 
> 	if (p->dl.dl_non_contending) {
> 	....	
> 
> BTW, is the full cpumask_intersects() necessary or would it suffice to see
> that the new cpu is not in the old span?

Checking new cpu only should be OK.

Thanks,

Juri
