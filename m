Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB84C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17BD2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392939AbfIFJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390186AbfIFJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:36:22 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A67785A07
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 09:36:22 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id j11so865416wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQbWytPIguw6envSGQcteTUy1ypWtSImNh1vUe/FzHc=;
        b=WWih3HPaI1Euzv0h6HtfI3fCsXOZbdPbtxWbDk6MINxpZazIcu9SKkWNoMgdPXOex9
         nwR0PJMJyIOgLtk918YIcRRg4G/uTiKZY4UgAtxD/5wvyYPNTDN9D5pp7tdd3BEHNJvp
         lEdZkPYTRUkxtTlZtRGtdTdJmANZxzKiLUc0FdNmEg+6UEOZBMBY4XIxjSKI7sqYyveg
         x77g8ia4F97UBu6Jb1bWFggfstY3nTwbtjHYwHT+OO/O9r5w1PjDRATxS3THwLveh75O
         SYHd6dISRefSBqxY7+UrYlHCoUt4AKz42nuDt1Su56lEI2qTQrpI0PADG9CnG17loIQn
         q0Tg==
X-Gm-Message-State: APjAAAWgZ6ticqsXUkoPdssx9TUX5qdtUnqq4lQw9dehCDr0GCreFJRc
        g7HUpD5hYHbG9ThwA1/GH5wtw8lxSEjiQogXRbVe+vGV7xw6ApVBvQ61pluvy3VhFF+V3vM3N21
        qBf0/4grdFtgFRxVlBdtvJToe
X-Received: by 2002:adf:bc84:: with SMTP id g4mr6328611wrh.135.1567762580440;
        Fri, 06 Sep 2019 02:36:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6ebR9hrhq3EGuynkS1TchFhmUwJGYBqce99rDFIJYYTrRE5FvAjm0d4WEOQTKJkXMSlu+Yg==
X-Received: by 2002:adf:bc84:: with SMTP id g4mr6328592wrh.135.1567762580091;
        Fri, 06 Sep 2019 02:36:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c09:8c01:a3c8:c747:f7af:a580])
        by smtp.gmail.com with ESMTPSA id q14sm11184622wrc.77.2019.09.06.02.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 02:36:19 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:36:16 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190906093616.GK5158@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
 <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
 <20190808092744.GI29310@localhost.localdomain>
 <20190808094546.GJ29310@localhost.localdomain>
 <20190830112437.GD2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830112437.GD2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/08/19 13:24, Peter Zijlstra wrote:
> On Thu, Aug 08, 2019 at 11:45:46AM +0200, Juri Lelli wrote:
> > I'd like to take this last sentence back, I was able to run a few boot +
> > hackbench + shutdown cycles with the following applied (guess too much
> > debug printks around before).
> 
> I've changed that slightly; the merged delta looks like:

It looks like I had to further apply what follows on top of your latest
wip-deadline branch (d3138279c7f3) to make kvm boot.

--->8---
 kernel/fork.c       | 2 ++
 kernel/sched/core.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..4f404fe1d9ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1983,6 +1983,8 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io_avg	= 0;
 #endif
 
+	p->server = NULL;
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fd2a8c68daf..d72579b93a9f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3917,8 +3917,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->server must be NULL.
 		 */
-		if (prev->server)
-			p->server = NULL;
+		p->server = NULL;
 
 		return p;
 	}
