Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F137CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA18B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="foQ6mlL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDISjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:39:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35363 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDISjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:39:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id a71so10931882qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvkQKdekOqJ4rygDyo9HwPn79tq0rdGXoEw1ROV5kgM=;
        b=foQ6mlL5NR9ljclb8177sgdcjxZ0TnMVVrw/pOH56UH9xeRFYQlypgb7mIEV5ezwdz
         BDk7+rDdIAYn5N07VLMqKKW1yRYeSTfIF66vVz15RUPZTRUhqaMJ7lPx5F1F/CkPAO/+
         phTHxjNyUzx9b8gMP9RiFpo5ekf9brPSUO260=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvkQKdekOqJ4rygDyo9HwPn79tq0rdGXoEw1ROV5kgM=;
        b=SnqNHZadTuDii9Jkjodtfcdg/c2qHRBsenh42q8TvDcDY3rwLYTi4/aSeny4Y61LNi
         Ld386x8znsnh6V6b9gq2kGMNTTJkiWwjF8SZIrGToET/e+zCkM1gfuNVfVOYRgPCP+ep
         7YIbJ84f3q01DMV4lIa0SB0rvMgag3tEBLRFovMGOPExNbYAz2m4PQpu7PsS7LRPEYrV
         49uiGmIXu8gbnsFFbYEefT1V4j2a7GeSbKYfV7PYlazd4tkrlzy5wKlGAQOzgd2HJIcc
         ILRKDCh66QIiTLxELDiUfVFSRk0DA/jxykcmu/1N7cZ9mAZ+QJujMAHyDKT81SXTAHUi
         82Vg==
X-Gm-Message-State: APjAAAW44STkuichTC0JN52BB+hWHJYbno7uZIypGpH9tjGJ/sk05J+L
        cb2SUdvGTC86UYQQGR9W1uc70P1ELTQ=
X-Google-Smtp-Source: APXvYqxKLGN+9kEU1/oJ2Irz11WBYi2j5ZtLOtcekBlBhqLdMi2YiU0QwmVoJFQWDD9WzI2WD/kTPg==
X-Received: by 2002:a05:620a:1281:: with SMTP id w1mr30184179qki.7.1554835172072;
        Tue, 09 Apr 2019 11:39:32 -0700 (PDT)
Received: from [192.168.1.240] (modemcable077.38-81-70.mc.videotron.ca. [70.81.38.77])
        by smtp.gmail.com with ESMTPSA id n201sm18362745qka.10.2019.04.09.11.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Apr 2019 11:39:31 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and scheduling.
Date:   Tue,  9 Apr 2019 14:38:55 -0400
Message-Id: <1554835135-11814-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190218173514.667598558@infradead.org>
References: <20190218173514.667598558@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the source of the major performance regression we discussed
previously. It turns out there was a pattern where a task (a kworker in this
case) could be woken up, but the core could still end up idle before that
task had a chance to run.

Example sequence, cpu0 and cpu1 and siblings on the same core, task1 and
task2 are in the same cgroup with the tag enabled (each following line
happens in the increasing order of time):
- task1 running on cpu0, task2 running on cpu1
- sched_waking(kworker/0, target_cpu=cpu0)
- task1 scheduled out of cpu0
- kworker/0 cannot run on cpu0 because of task2 is still running on cpu1
  cpu0 is idle
- task2 scheduled out of cpu1
- cpu1 doesn’t select kworker/0 for cpu0, because the optimization path ends
  the task selection if core_cookie is NULL for currently selected process
  and the cpu1’s runqueue.
- cpu1 is idle
--> both siblings are idle but kworker/0 is still in the run queue of cpu0.
    Cpu0 may stay idle for longer if it goes deep idle.

With the fix below, we ensure to send an IPI to the sibling if it is idle
and has tasks waiting in its runqueue.
This fixes the performance issue we were seeing.

Now here is what we can measure with a disk write-intensive benchmark:
- no performance impact with enabling core scheduling without any tagged
  task,
- 5% overhead if one tagged task is competing with an untagged task,
- 10% overhead if 2 tasks tagged with a different tag are competing
  against each other.

We are starting more scaling tests, but this is very encouraging !


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1fa10561279..02c862a5e973 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3779,7 +3779,22 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 				trace_printk("unconstrained pick: %s/%d %lx\n",
 						next->comm, next->pid, next->core_cookie);
+				rq->core_pick = NULL;
 
+				/*
+				 * If the sibling is idling, we might want to wake it
+				 * so that it can check for any runnable but blocked tasks 
+				 * due to previous task matching.
+				 */
+				for_each_cpu(j, smt_mask) {
+					struct rq *rq_j = cpu_rq(j);
+					rq_j->core_pick = NULL;
+					if (j != cpu && is_idle_task(rq_j->curr) && rq_j->nr_running) {
+						resched_curr(rq_j);
+						trace_printk("IPI(%d->%d[%d]) idle preempt\n",
+							     cpu, j, rq_j->nr_running);
+					}
+				}
 				goto done;
 			}
 
