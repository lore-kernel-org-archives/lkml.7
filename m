Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2892087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556375972;
	bh=AmoIFQ+GhS+7mHTafWqvhQNfeqC/3ErZhjHMPeHdTsw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=v3jddkxyGfbOvLST6xJc6wit1xSKpDQG4s7lnG/KS+w1W+nRVNFgoVSWcMYRWYLNn
	 XXs2Fnqh0cbBqFnFpcH/b+IE96rIWozfShufBor78VCK/EWu3ueKahj0mNe2eRZWYj
	 dq6sAFMeKsSVFgn5Tk+4w3lJ1wapm+AAkV0YyD6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfD0Ojb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:39:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD0Ojb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:39:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so8554862wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rUaQcyzs+GfjBwEyjZgWrQw15mZR2ShGE9KX/a1PyP8=;
        b=lmLN8xM9lNurDXNlLEGDtV3qWb8yxGGI1VXdbBdlAJFHgShKsGyxzrx4cQZ0vahbU+
         axd6TqCmvUa3GnY8CGnZ1JoXYOurMiTrHYgkAOsnyIc8BUk93LpLll3S6KvYxbgUeP+9
         aPQT07KvDzm5a8IWxo9JJxxriHR0j55Vd2j95I0yjbi0sES/3zbk/7esqXbfj6fr6hTj
         vwfGKSAyOSz0FhvofjwtDKHrEGjV1r92rcFO0MEcmolgUzdlQ0QTaefJ2b7u6dgEGP45
         FFDgGOnMlhtGpbgdCRa12kP3eCUCjFchWOlLWm4HSzK7s8W3y+tiKD0DnpiE7PsZ5YYG
         +dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rUaQcyzs+GfjBwEyjZgWrQw15mZR2ShGE9KX/a1PyP8=;
        b=Y4n1gEe5XVxjQ5IMxp+HQPqb/mWbk+Bc2q6bAX4XKikjooBcCgZINiTdXa3JEKj7Ko
         kdriPiTZVYWSCCRsRamPqDm3DAVFtKgNOcGV9Giixzqjhj3298Sw22rU19fETSAQccGd
         DvfoIMYVORwvDmBlY2yVUS1QCXRCpOb4vDrEAdnsvJmP2QkpyXRQS4fcBnV1EIcKofOL
         9sZtxAn3/Qwq4MWdttYHC3C4+Sv9VsjABXiyYgRaQNXcxozDJMKs+GALV+EdFiTZazRg
         JQ0KW+2KrT0Yd97WsFvpDXAbu5/ho9B95Gj5H0+JG/KCbXoM+ecJTVSx+WtiqygpO6qH
         16XA==
X-Gm-Message-State: APjAAAWpI6yLVPowADvO6FexEbYjBqaIbinPz1J7YHxMmrKzJQEu8QSO
        bjCsCKd2TjkQTKo/CMGqALHzKMgo
X-Google-Smtp-Source: APXvYqxIRwM4Ssi/FBTt0UAo0unbJ/GfzDUvPS7EK2/aZ189PdR4GMmO176yqT6jkM5gZteiIM4UWQ==
X-Received: by 2002:a1c:4905:: with SMTP id w5mr1707897wma.88.1556375969432;
        Sat, 27 Apr 2019 07:39:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o4sm37551151wmo.20.2019.04.27.07.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 07:39:28 -0700 (PDT)
Date:   Sat, 27 Apr 2019 16:39:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20190427143926.GA56189@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: a860fa7b96e1a1c974556327aa1aee852d434c21 sched/numa: Fix a possible divide-by-zero

Fix a division by zero bug that can trigger in the NUMA placement code.

 Thanks,

	Ingo

------------------>
Xie XiuQi (1):
      sched/numa: Fix a possible divide-by-zero


 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4d9e14bf138..35f3ea375084 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
 	if (p->last_task_numa_placement) {
 		delta = runtime - p->last_sum_exec_runtime;
 		*period = now - p->last_task_numa_placement;
+
+		/* Avoid time going backwards, prevent potential divide error: */
+		if (unlikely((s64)*period < 0))
+			*period = 0;
 	} else {
 		delta = p->se.avg.load_sum;
 		*period = LOAD_AVG_MAX;
