Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB8C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B92E21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfGVM2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:28:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50502 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfGVM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:28:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so35001901wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 05:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6/eI+1bfxhgnjF0+OZA0BlRzZcPL9vx2FzAtVqZorc=;
        b=p8HZHP5ed3h2csJPlM746p0vjLQ682PX/pU4+qqZMqihui8rg3UOuFccyl87xrgICo
         g1heMd+uj3Pa2Mf6gYmsM8L5zZCVIdCXDfnh/btx/QtUiUeqVUDop1cxETcMt5xCy2+P
         Zgh8bxRxbqXAQ28TZpuPawgvsjGj2GFVU4s0JMON9kQBcLXMJJ79jjjl3IGCv0Y7cNZj
         nWJPh3GIZt3au0/jRCiEHBZAD+pmRblzFJS9L5kwCyVF8UH+5yGqW3UWw1H5Dcx+lbdK
         lMIPLnDwtfdbkCZeORDvmPf52/kPpPXqicqlURRJit54DRw4c8vOEM//DCRUPkIvMXHN
         t3aA==
X-Gm-Message-State: APjAAAXIGPaxbrkVMMCtIo7ae2PxyMHmekD8/2IZjEjr6EdMaGrEUdO6
        b0pp4bL1bvuIDnb1OSIzlNFVpA==
X-Google-Smtp-Source: APXvYqxlnx12U06nxALU+ypFMTNO8C+4v1VLcbEHRpfOkBv18csOs1A7a/44UULrCDehw/7w3JL4iw==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr59725677wmb.173.1563798511297;
        Mon, 22 Jul 2019 05:28:31 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id w25sm37202326wmk.18.2019.07.22.05.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 05:28:30 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:28:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 4/8] sched/deadline: Fix bandwidth accounting at all
 levels after offline migration
Message-ID: <20190722122828.GG25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-5-juri.lelli@redhat.com>
 <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da6abab-00ff-9bb4-f24b-0bf5dfcd4c35@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/19 13:07, Dietmar Eggemann wrote:
> On 7/19/19 3:59 PM, Juri Lelli wrote:
> 
> [...]
> 
> > @@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
> >  		double_lock_balance(rq, later_rq);
> >  	}
> >  
> > +	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
> > +		/*
> > +		 * Inactive timer is armed (or callback is running, but
> > +		 * waiting for us to release rq locks). In any case, when it
> > +		 * will file (or continue), it will see running_bw of this
> 
> s/file/fire ?

Yep.

> > +		 * task migrated to later_rq (and correctly handle it).
> 
> Is this because of dl_task_timer()->enqueue_task_dl()->task_contending()
> setting dl_se->dl_non_contending = 0 ?

No, this is related to inactive_task_timer() callback. Since the task is
migrated (by this function calling set_task_cpu()) because a CPU hotplug
operation happened, we need to reflect this w.r.t. running_bw, or
inactive_task_timer() might sub from the new CPU and cause running_bw to
underflow.

Thanks,

Juri
