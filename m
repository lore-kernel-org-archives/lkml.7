Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D45C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FED21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="MalzMoAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440318AbfFLQdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:33:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42192 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437983AbfFLQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:33:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so19154639qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zBrNd1uYidSfD9I+qTo/PD9aW/Xy1RzqoQq/bRnt2Q4=;
        b=MalzMoALHWzRuLtvxnxmG35ccZVP+ZlPQyrZt39IxboK5uGZzLakApBh79dt0y8Qfl
         JIiQGF+YQliZ15W8klo+lSvE5YptH79D2MvH8e3pxHQPVAzKQYsGBK6xkYVL/ybU4Dba
         wmd1Bt9ue/Up8h8BwNfm/OVz7rIRjNeJu5QY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zBrNd1uYidSfD9I+qTo/PD9aW/Xy1RzqoQq/bRnt2Q4=;
        b=jVmu37mTULm9IkRfPWZ0zsPdvi5Zf9w44iwR0vds4IGnCmKzi8AOp8aSKSZKK6BwdS
         71swB3pCV/iU0Aj4JwFpgkKPiOPrtQiLWiQw7LcnssFghxi7OG6gn9mI5FfSZrREQY5I
         TYsqM/InmZQ46KESPthXxRz8WpyHwFi+j1XnUQeB9f76cFTk/2pxurEndyiyOiTiSp/4
         m6yyNsSmI8JTGYaT5tDfXcF39vyfKgDsdu14XtP1oeFogsSgAnwTGm/BIXewf+qdSqup
         wlspt8wj1bGRd7F3eAGl0UA57fUVQOJigh6VykNsZNOxhGdwgM7VoyZUbzfCE0a7pvIc
         AulA==
X-Gm-Message-State: APjAAAVVzuRWmI5e7YncbRKEP8Sr3+S8ZcFleFAYtKDZzjaOQ74Gkup4
        BjQjjaNmU41aOiyJfcOBLgZuDA==
X-Google-Smtp-Source: APXvYqxCCCQZDF/gn2t2dmXhhUpPIr+AmSV1KmxdwoeM5xlYuryGVhPFkM+ubHw2h4t1UKjXibj8hA==
X-Received: by 2002:ac8:2bdc:: with SMTP id n28mr33615988qtn.197.1560357229124;
        Wed, 12 Jun 2019 09:33:49 -0700 (PDT)
Received: from sinkpad (modemcable060.224-21-96.mc.videotron.ca. [96.21.224.60])
        by smtp.gmail.com with ESMTPSA id r5sm85640qkc.42.2019.06.12.09.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:33:47 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:33:45 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190612163345.GB26997@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606152637.GA5703@sinkpad>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reading more traces and trying to understand why only untagged
tasks are starving when there are cpu-intensive tasks running on the
same set of CPUs, we noticed a difference in behavior in ‘pick_task’. In
the case where ‘core_cookie’ is 0, we are supposed to only prefer the
tagged task if it’s priority is higher, but when the priorities are
equal we prefer it as well which causes the starving. ‘pick_task’ is
biased toward selecting its first parameter in case of equality which in
this case was the ‘class_pick’ instead of ‘max’. Reversing the order of
the parameter solves this issue and matches the expected behavior.

So we can get rid of this vruntime_boost concept.

We have tested the fix below and it seems to work well with
tagged/untagged tasks.

Here are our initial test results. When core scheduling is enabled,
each VM (and associated vhost threads) are in their own cgroup/tag.

1 12-vcpu VM MySQL TPC-C benchmark (IO + CPU) with 96 mostly-idle 1-vcpu
VMs on each NUMA node (72 logical CPUs total with SMT on):
+-------------+----------+--------------+------------+--------+
|             | baseline | coresched    | coresched  | nosmt  |
|             | no tag   | VMs tagged   | VMs tagged | no tag |
|             | v5.1.5   | no stall fix | stall fix  |        |
+-------------+----------+--------------+------------+--------+
|average TPS  | 1474     | 1289         | 1264       | 1339   |
|stdev        | 48       | 12           | 17         | 24     |
|overhead     | N/A      | -12%         | -14%       | -9%    |
+-------------+----------+--------------+------------+--------+

3 12-vcpu VMs running linpack (cpu-intensive), all pinned on the same
NUMA node (36 logical CPUs with SMT enabled on that NUMA node):
+---------------+----------+--------------+-----------+--------+
|               | baseline | coresched    | coresched | nosmt  |
|               | no tag   | VMs tagged   | VMs tagged| no tag |
|               | v5.1.5   | no stall fix | stall fix |        |
+---------------+----------+--------------+-----------+--------+
|average gflops | 177.9    | 171.3        | 172.7     | 81.9   |
|stdev          | 2.6      | 10.6         | 6.4       | 8.1    |
|overhead       | N/A      | -3.7%        | -2.9%     | -53.9% |
+---------------+----------+--------------+-----------+--------+

This fix can be toggled dynamically with the ‘CORESCHED_STALL_FIX’
sched_feature so it’s easy to test before/after (it is disabled by
default).

The up-to-date git tree can also be found here in case it’s easier to
follow:
https://github.com/digitalocean/linux-coresched/commits/vpillai/coresched-v3-v5.1.5-test

Feedback welcome !

Thanks,

Julien

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e79421..26fea68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3668,8 +3668,10 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
                 * If class_pick is tagged, return it only if it has
                 * higher priority than max.
                 */
-               if (max && class_pick->core_cookie &&
-                   prio_less(class_pick, max))
+               bool max_is_higher = sched_feat(CORESCHED_STALL_FIX) ?
+                                    max && !prio_less(max, class_pick) :
+                                    max && prio_less(class_pick, max);
+               if (class_pick->core_cookie && max_is_higher)
                        return idle_sched_class.pick_task(rq);
 
                return class_pick;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 858589b..332a092 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,9 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+
+/*
+ * Prevent task stall due to vruntime comparison limitation across
+ * cpus.
+ */
+SCHED_FEAT(CORESCHED_STALL_FIX, false)
