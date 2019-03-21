Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5DD21925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="N6+xUhNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfCUVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:20:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46435 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCUVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:20:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id s81so4498710qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoPTjNoQH9P11AzxV7hz4O05Uw6lZyZ5WaH3L3lcp7M=;
        b=N6+xUhNsZV8o/bZUVTzWyjFPLjwKh9+4ra4G64HIh6y86G5EHbnCLKoRzQ860dt1L9
         jtOJV2j+W5y+Ffl3VS6Cj0YrBBqMBsKM9yb7hSXkLWeNP+YxQEH1N2t3UadmKM9EXM1D
         QNm/0w6a49VY/b/CRLvkF4yRnBGlFHUaK/+a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoPTjNoQH9P11AzxV7hz4O05Uw6lZyZ5WaH3L3lcp7M=;
        b=je3eFKw7nnU0w9StLWDjLVbrLDMaAgbVIG3Fc/ZRquGjv/H1F5Y2FoprCVbd7PlngW
         86Kjyvwdy2fC0Vj12cM5cLai8TmffY0eYY/jWz+m+7XOa/KCQv3HgTDawWJSD3My7w9P
         pjhvLxNL2Sat3Jd1DIhtada0p7DacFTnDNJ8taBtySXr5e8V+NQ0n87W+HGhezLx+Ygw
         BsxLzel1PkuK8bGpXxo1uViVlkoU6UaiVG8URcbEdLKZFyHxvOiVpFXxVdK8jwKMEhdM
         FEhjG/EH6LC1mcHdSwJ8usxKt4bA2DHTdGN2TmP9Hp1k2pscgpQyuzSD3T8Xl8iIuiuN
         yo1g==
X-Gm-Message-State: APjAAAW1UE1TlK89TWmHlJP9JmGQxBAsr33YmKgyUeu/L54e8YoVHLCB
        /0lWWz8JagqjaBx/IEFWeIHDrw==
X-Google-Smtp-Source: APXvYqxzmoAU6I9Uob/gpeBsBt5EXvRdm37Mb7aOm2vn3MiGb82tpSryxMvtqn74ETBuoLbgyNMNyQ==
X-Received: by 2002:a37:6748:: with SMTP id b69mr4766483qkc.79.1553203254239;
        Thu, 21 Mar 2019 14:20:54 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id n70sm312138qkn.5.2019.03.21.14.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 14:20:53 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Date:   Thu, 21 Mar 2019 17:20:17 -0400
Message-Id: <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
References: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:31 PM Subhra Mazumdar <subhra.mazumdar@oracle.com>
wrote:
> On 3/18/19 8:41 AM, Julien Desfossez wrote:
> > The case where we try to acquire the lock on 2 runqueues belonging to 2
> > different cores requires the rq_lockp wrapper as well otherwise we
> > frequently deadlock in there.
> >
> > This fixes the crash reported in
> > 1552577311-8218-1-git-send-email-jdesfossez@digitalocean.com
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 76fee56..71bb71f 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2078,7 +2078,7 @@ static inline void double_rq_lock(struct rq *rq1,
> struct rq *rq2)
> >               raw_spin_lock(rq_lockp(rq1));
> >               __acquire(rq2->lock);   /* Fake it out ;) */
> >       } else {
> > -             if (rq1 < rq2) {
> > +             if (rq_lockp(rq1) < rq_lockp(rq2)) {
> >                       raw_spin_lock(rq_lockp(rq1));
> >                       raw_spin_lock_nested(rq_lockp(rq2),
> SINGLE_DEPTH_NESTING);
> >               } else {
> With this fix and my previous NULL pointer fix my stress tests are
> surviving. I
> re-ran my 2 DB instance setup on 44 core 2 socket system by putting each DB
> instance in separate core scheduling group. The numbers look much worse
> now.
>
> users  baseline  %stdev  %idle  core_sched  %stdev %idle
> 16     1         0.3     66     -73.4%      136.8 82
> 24     1         1.6     54     -95.8%      133.2 81
> 32     1         1.5     42     -97.5%      124.3 89

We are also seeing a performance degradation of about 83% on the throughput
of 2 MySQL VMs under a stress test (12 vcpus, 32GB of RAM). The server has 2
NUMA nodes, each with 18 cores (so a total of 72 hardware threads). Each
MySQL VM is pinned to a different NUMA node. The clients for the stress
tests are running on a separate physical machine, each client runs 48 query
threads. Only the MySQL VMs use core scheduling (all vcpus and emulator
threads). Overall the server is 90% idle when the 2 VMs use core scheduling,
and 75% when they don’t.

The rate of preemption vs normal “switch out” is about 1% with and without
core scheduling enabled, but the overall rate of sched_switch is 5 times
higher without core scheduling which suggests some heavy contention in the
scheduling path.

On further investigation, we could see that the contention is mostly in the
way rq locks are taken. With this patchset, we lock the whole core if
cpu.tag is set for at least one cgroup. Due to this, __schedule() is more or
less serialized for the core and that attributes to the performance loss
that we are seeing. We also saw that newidle_balance() takes considerably
long time in load_balance() due to the rq spinlock contention. Do you think
it would help if the core-wide locking was only performed when absolutely
needed ?

In terms of isolation, we measured the time a thread spends co-scheduled
with either a thread from the same group, the idle thread or a thread from
another group. This is what we see for 60 seconds of a specific busy VM
pinned to a whole NUMA node (all its threads):

no core scheduling:
- local neighbors (19.989 % of process runtime)
- idle neighbors (47.197 % of process runtime)
- foreign neighbors (22.811 % of process runtime)

core scheduling enabled:
- local neighbors (6.763 % of process runtime)
- idle neighbors (93.064 % of process runtime)
- foreign neighbors (0.236 % of process runtime)

As a separate test, we tried to pin all the vcpu threads to a set of cores
(6 cores for 12 vcpus):
no core scheduling:
- local neighbors (88.299 % of process runtime)
- idle neighbors (9.334 % of process runtime)
- foreign neighbors (0.197 % of process runtime)

core scheduling enabled:
- local neighbors (84.570 % of process runtime)
- idle neighbors (15.195 % of process runtime)
- foreign neighbors (0.257 % of process runtime)

Thanks,

Julien
