Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F319C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22622CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHKWp2j/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfH3LY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:24:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfH3LY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w9NpHDvZswYlJ5Fs4E2FqZnF/6v0A8GGtt4gKfFQpIw=; b=CHKWp2j/nReIumye5xkrMf9J7
        Q6qioDTHE2xCq1kiLrnuy9h6aEQ2riPP8SATstXTK3P1lMhiFK5zkAiDp+VXWra29bH6/TbHMuq/u
        AhWErv+T8F2qK/cZGddWtCt2h/PKyCm3kQhMeNKQIFztyg2d0EbSC1FZOSEzvxyUSBE0ZQQOAzW2L
        FseLouCFe9lQrbUraanu3SAfvpvgvv+59a52xvy4RAspJpRbDfpQKF6rYpJC3ITL8IJ55sWw13It/
        Cbs4VdrMPQfuwO1uqkerAi1xHFsrN592tv/RkfMFYoHkZor5531EqOQ1xMv7KDDASG/MR80t9AN5g
        NtEvYf0eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3f1E-0006dq-9u; Fri, 30 Aug 2019 11:24:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29C02300489;
        Fri, 30 Aug 2019 13:24:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC70B20BAA484; Fri, 30 Aug 2019 13:24:37 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:24:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190830112437.GD2369@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
 <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
 <20190808092744.GI29310@localhost.localdomain>
 <20190808094546.GJ29310@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808094546.GJ29310@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:45:46AM +0200, Juri Lelli wrote:
> I'd like to take this last sentence back, I was able to run a few boot +
> hackbench + shutdown cycles with the following applied (guess too much
> debug printks around before).

I've changed that slightly; the merged delta looks like:


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3913,6 +3913,13 @@ pick_next_task(struct rq *rq, struct tas
 		if (unlikely(!p))
 			p = idle_sched_class.pick_next_task(rq, prev, rf);
 
+		/*
+		 * This is the fast path; it cannot be a DL server pick;
+		 * therefore even if @p == @prev, ->server must be NULL.
+		 */
+		if (prev->server)
+			p->server = NULL;
+
 		return p;
 	}
 
@@ -3925,13 +3932,18 @@ pick_next_task(struct rq *rq, struct tas
 	if (!rq->nr_running)
 		newidle_balance(rq, rf);
 
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->server.
+	 */
+	if (prev->server)
+		prev->server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
-		if (p) {
-			if (p->sched_class == class && p->server)
-				p->server = NULL;
+		if (p)
 			return p;
-		}
 	}
 
 	/* The idle class should always have a runnable task: */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1312,6 +1312,10 @@ void dl_server_update(struct sched_dl_en
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	if (!dl_server(dl_se)) {
+		dl_se->dl_server = 1;
+		setup_new_dl_entity(dl_se);
+	}
 	enqueue_dl_entity(dl_se, dl_se, ENQUEUE_WAKEUP);
 }
 
@@ -1324,12 +1328,9 @@ void dl_server_init(struct sched_dl_enti
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick)
 {
-	dl_se->dl_server = 1;
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick = pick;
-
-	setup_new_dl_entity(dl_se);
 }
 
 /*
@@ -2855,6 +2856,7 @@ static void __dl_clear_params(struct sch
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+	dl_se->dl_server		= 0;
 }
 
 void init_dl_entity(struct sched_dl_entity *dl_se)
