Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8144C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DE0217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="edZJ5WVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfC2NgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:36:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33092 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfC2NgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:36:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so2579395qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1txVTy3BOE9RrAQOHROueECHiNKVow0rjE1tqZzri8=;
        b=edZJ5WVDkeGbq9qGwKJMm/P14wVFpzffdrp6AH+byPvF4Waznp7jF3ai0ocpjRWHzm
         6ug1C0Ef/fqBMtLAtnTpWl8FgwYkzWKRHPD/ibNRrW52o2/VqUOedTwOizsLiC1mCQk0
         l1XZdYsO0Cj8YMFGK3WZJwOwiA5pcdj7rNfoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1txVTy3BOE9RrAQOHROueECHiNKVow0rjE1tqZzri8=;
        b=k4ITeLnpjGk+fkS9uc8ez5qmD/5bX2TKilkF0B59AT7hQimk3Z15B9PojZSwrxHQ8C
         YSDry0QRsDNYkMCdcDqsiKGsfeoGxhduZslj6PUy596WYk6g55qtgo8+SpfHMotOaqda
         zQ81qoQDWmVpK+SGBv5vTN7iYJ4IOFmcCowzih85yYyske7GBI4+V8SAA1GPiZrTqlE6
         a0SsSg37SCXuD9F8udCIYdfHMOc+vxi57dS6tgmfwoYGjghpcl44aXEB+SduUnyRo3Rm
         Ebk6mBhqr+ryxGt1O6IX3/OHoR3x27znISXdeqyva3F7jP96Oekfhz1fehpYMEUQqhAj
         uU7g==
X-Gm-Message-State: APjAAAXA4a0Q8SxCdzanpjUO/0TH0oklYwJazY/5b6fisbmRCReKzQMk
        fboa2/gwZeS3OX479ZMCiND/8bZLU8mIVA==
X-Google-Smtp-Source: APXvYqwqcjERvHt8sA2pypaI2yfx1AgUedR/UTptKBmeo4fUreYwDE/r3eNnglC40/DQFlYilz78lA==
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr29291027qto.349.1553866559813;
        Fri, 29 Mar 2019 06:35:59 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id c84sm1109050qke.0.2019.03.29.06.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 06:35:58 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Date:   Fri, 29 Mar 2019 09:35:27 -0400
Message-Id: <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
References: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:09 PM Subhra Mazumdar <subhra.mazumdar@oracle.com>
wrote:
> Is the core wide lock primarily responsible for the regression? I ran
> upto patch
> 12 which also has the core wide lock for tagged cgroups and also calls
> newidle_balance() from pick_next_task(). I don't see any regression.  Of
> course
> the core sched version of pick_next_task() may be doing more but
> comparing with
> the __pick_next_task() it doesn't look too horrible.

On further testing and investigation, we also agree that spinlock contention
is not the major cause for the regression, but we feel that it should be one
of the major contributing factors to this performance loss.

To reduce the scope of the investigation of the performance regression, we
designed a couple of smaller test cases (compared to big VMs running complex
benchmarks) and it turns out the test case that is most impacted is a simple
disk write-intensive case (up to 99% performance drop). CPU-intensive and
scheduler-intensive tests (perf bench sched) behave pretty well.

On the same server we used before (2x18 cores, 72 hardware threads), with
all the non-essential services disabled, we setup a cpuset of 4 cores (8
hardware threads) and ran sysbench fileio on a dedicated drive (no RAID).
With sysbench running with 8 threads in this cpuset without core scheduling,
we get about 155.23 MiB/s in sequential write. If we enable the tag, we drop
to 0.25 MiB/s. Interestingly, even with 4 threads, we see the same kind of
performance drop.

Command used:

sysbench --test=fileio prepare
cgexec -g cpu,cpuset:test sysbench --threads=4 --test=fileio \
--file-test-mode=seqwr run

If we run this with the data in a ramdisk instead of a real drive, we don’t
notice any drop. The amount of performance drops depends a bit depending on
the machine, but it’s always significant.

We spent a lot of time in the trace and noticed that a couple times during
every run, the sysbench worker threads are waiting for IO sometimes up to 4
seconds, all the threads wait for the same duration, and during that time we
don’t see any block-related softirq coming in. As soon as the interrupt is
processed, sysbench gets woken up immediately. This long wait never happens
without the core scheduling. So we are trying to see if there is a place
where the interrupts are disabled for an extended period of time. The
irqsoff tracer doesn’t seem to pick it up.

Any thoughts about that ?
