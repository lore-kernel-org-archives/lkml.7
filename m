Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83083C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E020700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="OH/2Y1Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDCUQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:16:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42808 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:16:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so546463qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iIyyuflinUSu2TGtWtUUuII6raHAMEfQ6ZDNckyaZJ4=;
        b=OH/2Y1Oq/pbD2iVL4xF6ciMOmxwtkpyLhCqMqKRHyXwCXg6kRlwmLlLuHuU1Y1ILLh
         JQb461Yz79vaLiJL98bSyueNhvLpJONoeTdX7Ir+Ah1MIKv76Cn1pN30EsE6+D0IvB83
         U8lsgwGJYT5Uok1J9YdUGHl7ryojQYFqBvXcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iIyyuflinUSu2TGtWtUUuII6raHAMEfQ6ZDNckyaZJ4=;
        b=ed0WwhBruVYXdlA7SkmViZkXUgQ7kV0Jy1zC2+NdZkOB7moZJ61fTsNQvDgsxbelxd
         51eThtKSwzhxVICBDvUaIRASAe4tmTPLPkO3IRLtToOmjH2B4sx+HBDSW0UQaYaBhOsJ
         MLmGPD7NM0SNixhxA04zqTXFVaQbFfulmjJFb5npQFKhqvis6B1tt/FW7IgVzLCT50eO
         xHybQFyyynq8Sifv1/3B78AIF7SDJfDelk8rmcLj2Ql9i1/Iv3ShHzX83MI0VJjP55+y
         v49OuIyBs7d/85dDWwSNxEeREjsTllhv3idrD3TaZCq6HBFGrxC1N4ZcSW9iAg3RlvQF
         AjHg==
X-Gm-Message-State: APjAAAUIj8/ZSIXP2gSBYuYBBpyktYS5SP+brmg5G8IrnKFbdvMqwl8g
        vliI7ho8LDf/5TmQkhIJH/LAJQ==
X-Google-Smtp-Source: APXvYqwE41iHOttcRrUGZvpDfEH59eG077wvqPUptPXiviGxUgo4LHA0N+lqPIe9Ge3kR+C5JOZQWA==
X-Received: by 2002:ac8:3861:: with SMTP id r30mr1789425qtb.122.1554322607424;
        Wed, 03 Apr 2019 13:16:47 -0700 (PDT)
Received: from sinkpad ([158.106.193.162])
        by smtp.gmail.com with ESMTPSA id a188sm2648470qkf.34.2019.04.03.13.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:16:46 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:16:34 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190403201634.GA4192@sinkpad>
References: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
 <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
 <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
 <cd11cde9-4aed-b02f-cae5-170bb6fa686b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd11cde9-4aed-b02f-cae5-170bb6fa686b@oracle.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>Is the core wide lock primarily responsible for the regression? I ran
> >>>upto patch
> >>>12 which also has the core wide lock for tagged cgroups and also calls
> >>>newidle_balance() from pick_next_task(). I don't see any regression. 
> >>>Of
> >>>course
> >>>the core sched version of pick_next_task() may be doing more but
> >>>comparing with
> >>>the __pick_next_task() it doesn't look too horrible.
> >>On further testing and investigation, we also agree that spinlock
> >>contention
> >>is not the major cause for the regression, but we feel that it should be
> >>one
> >>of the major contributing factors to this performance loss.
> >>
> >>
> >I finally did some code bisection and found the following lines are
> >basically responsible for the regression. Commenting them out I don't see
> >the regressions. Can you confirm? I am yet to figure if this is needed for
> >the correctness of core scheduling and if so can we do this better?
> >
> >-------->8-------------
> >
> >diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >index fe3918c..3b3388a 100644
> >--- a/kernel/sched/core.c
> >+++ b/kernel/sched/core.c
> >@@ -3741,8 +3741,8 @@ pick_next_task(struct rq *rq, struct task_struct
> >*prev, struct rq_flags *rf)
> >                                 * If there weren't no cookies; we don't
> >need
> >                                 * to bother with the other siblings.
> >*/
> >-                               if (i == cpu && !rq->core->core_cookie)
> >-                                       goto next_class;
> >+                               //if (i == cpu && !rq->core->core_cookie)
> >+                                       //goto next_class;
> >
> >continue;
> >                        }
> AFAICT this condition is not needed for correctness as cookie matching will
> sill be enforced. Peter any thoughts? I get the following numbers with 1 DB
> and 2 DB instance.
> 
> 1 DB instance
> users  baseline   %idle  core_sched %idle
> 16     1          84     -5.5% 84
> 24     1          76     -5% 76
> 32     1          69     -0.45% 69
> 
> 2 DB instance
> users  baseline   %idle  core_sched %idle
> 16     1          66     -23.8% 69
> 24     1          54     -3.1% 57
> 32     1          42     -21.1%      48

We tried to comment those lines and it doesn’t seem to get rid of the
performance regression we are seeing.
Can you elaborate a bit more about the test you are performing, what kind of
resources it uses ?
Can you also try to replicate our test and see if you see the same problem ?

cgcreate -g cpu,cpuset:set1
cat /sys/devices/system/cpu/cpu{0,2,4,6}/topology/thread_siblings_list 
0,36
2,38
4,40
6,42

echo "0,2,4,6,36,38,40,42" | sudo tee /sys/fs/cgroup/cpuset/set1/cpuset.cpus
echo 0 | sudo tee /sys/fs/cgroup/cpuset/set1/cpuset.mems

echo 1 | sudo tee /sys/fs/cgroup/cpu,cpuacct/set1/cpu.tag

sysbench --test=fileio prepare
cgexec -g cpu,cpuset:set1 sysbench --threads=4 --test=fileio \
--file-test-mode=seqwr run

The reason we create a cpuset is to narrow down the investigation to just 4
cores on a highly powerful machine. It might not be needed if testing on a
smaller machine.

Julien
