Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09F2222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9bZ9lLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKHO2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:28:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53167 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKHO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:28:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id c17so6395584wmk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+I/9TWym/x4PN0S8rVHcHTbhmDpS2CukgYGOo7Cy7UA=;
        b=m9bZ9lLiYoYRvTXOjhQB6ZnAE8ibU8dtkFrBQmj8A0I/gs634KYfdKW+fUFClufVsE
         1O0NMwqKo1fD6qc+lL1cm3P+BWSRXDEuI31D8QNXFYMLHp3+cqRYwNF0syMD6CLqihm+
         RgTn648Wc5AnzuqDAZ1CiLv2iuCNYe1dsNGHVjKeQ9SNrlrAFB3ha7b2H1w8T+FRazAg
         KTOd+7oH/OpWR2uyg6lyjMbj1RD6mxmWUiUpczsTQOpc8wpc2PEjxOqxGpw8PCMwZ47M
         eSb9qHjP9CeQDW1BWSXIWEEEA1xVdKLeHQCWgePcK8cAtLkh+7+EPkia+vNSdEXxwbRH
         hDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+I/9TWym/x4PN0S8rVHcHTbhmDpS2CukgYGOo7Cy7UA=;
        b=NqY+BTDh456039nOlyuKTXXiRckCLi4V2H9hOyChJV1oJEGpHijybI8nbfgKMEPWOv
         Tglw/fEzxs4zdYESR8MT1EquZoo8a57mZES/o6FU47DRdcWc48/Sp/ouANP8y6UK5x9O
         th1G5YDnBqoWlVP2IthcLVcq+OaGiotnBu7kIW/0XnseUeP0W/j1P7N69NGkkYN1SdLS
         0LTOVKUdq3yV6BMB4v2WpskbZw+6E1cImcCZ02NVQV+cDoq9hfsMym1H6+1Tq7gd+6Kc
         Jjf8qDwcevfZ6FtB0AOZZygpgpoaV5KdryeMb2NpEDk5NI/dHFY02dBvI2ltXrNqFY+g
         fj6g==
X-Gm-Message-State: APjAAAVS0i796SsMUCPPBIhnvaQn+fef6PoaCsTB1tUhxsqji7xmxt8S
        ftb14lhTL1hbJ/AIjV59XTJL4A==
X-Google-Smtp-Source: APXvYqzkl8NvhGQ2YTQzPNV8/Or+oh3AHAwZ9Yte6+mTECBLB5Lynq/unS9VlaGw3Nma1GQ7H1FgqA==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr7977678wmi.173.1573223327650;
        Fri, 08 Nov 2019 06:28:47 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id r3sm8012319wre.29.2019.11.08.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 06:28:47 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:28:43 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH 1/7] sched: Fix pick_next_task() vs change pattern race
Message-ID: <20191108142843.GA123156@google.com>
References: <20191108131553.027892369@infradead.org>
 <20191108131909.428842459@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108131909.428842459@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Nov 2019 at 14:15:54 (+0100), Peter Zijlstra wrote:
> Commit 67692435c411 ("sched: Rework pick_next_task() slow-path")
> inadvertly introduced a race because it changed a previously
> unexplored dependency between dropping the rq->lock and
> sched_class::put_prev_task().
> 
> The comments about dropping rq->lock, in for example
> newidle_balance(), only mentions the task being current and ->on_cpu
> being set. But when we look at the 'change' pattern (in for example
> sched_setnuma()):
> 
> 	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
> 	running = task_current(rq, p); /* rq->curr == p */
> 
> 	if (queued)
> 		dequeue_task(...);
> 	if (running)
> 		put_prev_task(...);
> 
> 	/* change task properties */
> 
> 	if (queued)
> 		enqueue_task(...);
> 	if (running)
> 		set_next_task(...);
> 
> It becomes obvious that if we do this after put_prev_task() has
> already been called on @p, things go sideways. This is exactly what
> the commit in question allows to happen when it does:
> 
> 	prev->sched_class->put_prev_task(rq, prev, rf);
> 	if (!rq->nr_running)
> 		newidle_balance(rq, rf);
> 
> The newidle_balance() call will drop rq->lock after we've called
> put_prev_task() and that allows the above 'change' pattern to
> interleave and mess up the state.
> 
> Furthermore, it turns out we lost the RT-pull when we put the last DL
> task.
> 
> Fix both problems by extracting the balancing from put_prev_task() and
> doing a multi-class balance() pass before put_prev_task().
> 
> Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The reproducer that triggered in 30sec or so has now been running for
3 hours:

   Tested-by: Quentin Perret <qperret@google.com>

Thanks for fix,
Quentin
