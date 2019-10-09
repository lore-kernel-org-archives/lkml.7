Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E966ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4C7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJIH1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:27:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJIH1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:27:51 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7350F3C919
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 07:27:51 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l3so630862wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3ctLAkDmDk4H9Vzce0MbfQbAf3ONKICSRZRd0TvwbI=;
        b=gTE4WgGmGth7XeloSCgy5RL8NmhNbjxkQuU4SVCmHQ4HZxD++ozAjuhggW9sGUnACn
         SzPW+hLYIyVLGFTMZShNogLlrNeeFfZtqT10lGH6nbmbCbu0XngcR3bfyX+Tg8saMa1z
         VkmYJ3JF4jdmKK6S/7uMdCEhdaEvcR+YwsPJeU2BUun6j1pDRdumMusC9IL9gdabyko3
         V230J3n/nCmjZyQ/ktumi8AqM0ObgJPj2w7/uWfWuoo9NguhPlL35d8St3LTnBN7/5MB
         3PA5iPOe9OIhLyqoPcnpB6SO3Uq3+HNPIB3NbURGEH5tgmiNdPmop8d/hSQSH+mOUl7O
         OIBg==
X-Gm-Message-State: APjAAAWvM3LVk3UHAtSfGzAbOqTd/U8Wg+/bHoiB4Y3i/CYmIFxN5AYb
        xxbxnyU7cQXHVj8Qsc3AujHc7mt9KmTBf0mzzPJnYsOPp9DxBRpDnDCJmIwONlWHcxBN91TwMG0
        GYBXLgCmPDCICfTS7UJtvpaRi
X-Received: by 2002:a5d:570a:: with SMTP id a10mr1640525wrv.390.1570606069999;
        Wed, 09 Oct 2019 00:27:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpETF4zPjoRa/BV6XbBVzCljbXbz1SV9x8l4rSuwka8u/hN9kkewPDGRcLoyTYWYDrfuD7cg==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr1640505wrv.390.1570606069655;
        Wed, 09 Oct 2019 00:27:49 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id d4sm1152020wrq.22.2019.10.09.00.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 00:27:47 -0700 (PDT)
Date:   Wed, 9 Oct 2019 09:27:45 +0200
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
Message-ID: <20191009072745.GI19588@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
 <20190927081141.GB31660@localhost.localdomain>
 <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
 <20190930071233.GE31660@localhost.localdomain>
 <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
 <20191001085209.GA6481@localhost.localdomain>
 <a1098e5f95a1ab202fdf79a73aedfeeb8e02dd47.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1098e5f95a1ab202fdf79a73aedfeeb8e02dd47.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 01:25, Scott Wood wrote:
> On Tue, 2019-10-01 at 10:52 +0200, Juri Lelli wrote:
> > On 30/09/19 11:24, Scott Wood wrote:
> > > On Mon, 2019-09-30 at 09:12 +0200, Juri Lelli wrote:
> > 
> > [...]
> > 
> > > > Hummm, I was actually more worried about the fact that we call
> > > > free_old_
> > > > cpuset_bw_dl() only if p->state != TASK_WAKING.
> > > 
> > > Oh, right. :-P  Not sure what I had in mind there; we want to call it
> > > regardless.
> > > 
> > > I assume we need rq->lock in free_old_cpuset_bw_dl()?  So something like
> > 
> > I think we can do with rcu_read_lock_sched() (see dl_task_can_attach()).
> 
> RCU will keep dl_bw from being freed under us (we're implicitly in an RCU
> sched read section due to atomic context).  It won't stop rq->rd from
> changing, but that could have happened before we took rq->lock.  If the cpu
> the task was running on was removed from the cpuset, and that raced with the
> task being moved to a different cpuset, couldn't we end up erroneously
> subtracting from the cpu's new root domain (or failing to subtract at all if
> the old cpu's new cpuset happens to be the task's new cpuset)?  I don't see
> anything that forces tasks off of the cpu when a cpu is removed from a
> cpuset (though maybe I'm not looking in the right place), so the race window
> could be quite large.  In any case, that's an existing problem that's not
> going to get solved in this patchset.

OK. So, mainline has got cpuset_read_lock() which should be enough to
guard against changes to rd(s).

I agree that rq->lock is needed here.

Thanks,

Juri
