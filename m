Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14241C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB983206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575962966;
	bh=7PaoMbw8DXZuNsn69EG/2iVJPCVtSP6JzO7GynwwpEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaIjVR2Ublnd7p4qEyPT00HxUHkcoPCIRuHPa9xo1LKwM9kBiej+yVxnr3WDJ62F4
	 3nS5kYaTxfNJ/XN36cLTxUAMemYqD8vcz5uPOnvPIYBIqHjr52rgGPK36dIS+yB7Qg
	 EGz1XlL4KkcB6L0Mkn08YMMTWEP7rP/SYInyPGD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLJH3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:29:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40868 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLJH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:29:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so1895243wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUegOWtwo/Xpa7XjHQhb0MWZL8xae75Y9KB73ciRd34=;
        b=Eizy5WFyH+hEmBLySNdhoYqtEVcc59WousOGlclbMWx1yeUC7R4Yi80YH5R7zHwyI2
         kOJVXGdHAo9wYMBbqlFzh0AIdlBaIBldDOvB/YGjfYyZ3EvNIevK1Rvfg7rrBilqSWlI
         Mc6NK+98QHiXlaqjA3jXl58fP25anS3Z8lLEvxIL+sjKJJOEnXzmVtblk+dY+Rvq5N+s
         VCa3SwC4/fAYu4Pt2Z3DCrSR3mFjcr2RkOZMvpj2yP+moNMyWb9FpQDQwKWH1nyeay9n
         ENZGKoKjctIBoE29z+axVlW5M8+ZnXgNJkIB6eQ6fzsOi1YAONSI4DtZ8w18Q59/8IEW
         jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUegOWtwo/Xpa7XjHQhb0MWZL8xae75Y9KB73ciRd34=;
        b=jwt7GOkIN5b13KxcQGMvvIINQMk0PiyR8muLin66GPR+Ge/0vBYVMMDsAQLsCemzrk
         bbTMH5S9v3TbOITNfKKQl01YVYUl2dQS/MC/ZPpVpITD/gpxi3oWpDxmVtdXWlBovYSQ
         51LDziMxU9rVucdL/z8a4CXPO2V+DSAxmy+CGe7irQ7neSfv2AwnqHquFJ6Ie+Bsg/l0
         y1wHcTT7FXxX9BQGYoidn5pBTU1qRVgKJuHuUJEFh61bcumrkHn3DAgtyy89F+cBjB+w
         R4kaVoaw8hgrSaaVq+aFub+tbO53rYYi+FbH2d9YG0zyYA4PTG3kTDW5nnOW81mdmU3D
         q+DQ==
X-Gm-Message-State: APjAAAWufrh+XMTwdOxGrLs0YFQTbScs2J/48RtRGivUC26dUaiPRgOz
        C0Icrefl36BtjPe6fntwt8s=
X-Google-Smtp-Source: APXvYqwlx02TXsoXM90p8B+6nGPf20KbMNaHmI0NDB7EcdalOAFnpeOgrhJiwGRIFMa1hXbxKCfgVA==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr1302825wmc.108.1575962963558;
        Mon, 09 Dec 2019 23:29:23 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v17sm2177576wrt.91.2019.12.09.23.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 23:29:23 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:29:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
Message-ID: <20191210072921.GB114501@gmail.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
 <20191209120852.GA5388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209120852.GA5388@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> > long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry, int state)
> > {
> >         unsigned long flags;
> >         long ret = 0;
> >
> >         spin_lock_irqsave(&wq_head->lock, flags);
> >         if (signal_pending_state(state, current)) {
> >                 /*
> >                  * Exclusive waiter must not fail if it was selected by wakeup,
> >                  * it should "consume" the condition we were waiting for.
> >                  *
> >                  * The caller will recheck the condition and return success if
> >                  * we were already woken up, we can not miss the event because
> >                  * wakeup locks/unlocks the same wq_head->lock.
> >                  *
> >                  * But we need to ensure that set-condition + wakeup after that
> >                  * can't see us, it should wake up another exclusive waiter if
> >                  * we fail.
> >                  */
> >                 list_del_init(&wq_entry->entry);
> >                 ret = -ERESTARTSYS;
> 
> ...
> 
> > I think we can indeed lose an exclusive event here, despite the comment
> > that argues that we shouldn't: if we were already removed from the list
> 
> If we were already removed from the list and condition is true, we can't
> miss it, ret = -ERESTARTSYS won't be used. This is what this part of the
> comment above
> 
> 	 * The caller will recheck the condition and return success if
> 	 * we were already woken up, we can not miss the event because
> 	 * wakeup locks/unlocks the same wq_head->lock.
> 
> tries to explain.

Yeah, indeed - it assumes that the condition is stable from wakeup to 
wakee running - which as Linus said it must be, because otherwise 
exclusive waiters couldn't reliably exit the wait loop.

So there's no bug. How about the clarifying comment below?

Thanks,

	Ingo

 kernel/sched/wait.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index ba059fbfc53a..6783bac00b5c 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -290,6 +290,11 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 		 * But we need to ensure that set-condition + wakeup after that
 		 * can't see us, it should wake up another exclusive waiter if
 		 * we fail.
+		 *
+		 * In other words, if an exclusive waiter got here, then the
+		 * waitqueue condition is and stays true and we are guaranteed
+		 * to exit the waitqueue loop and will ignore the -ERESTARTSYS
+		 * and return success.
 		 */
 		list_del_init(&wq_entry->entry);
 		ret = -ERESTARTSYS;
