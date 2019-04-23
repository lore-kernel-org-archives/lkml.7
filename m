Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A607C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B09217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gAJNovF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfDWQS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34377 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfDWQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:55 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so13073871ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gF03tPu44e7kldOb1nXs+YXmafLRpdS0s/ocQ3uC+Ys=;
        b=gAJNovF6M+Betf51nwMmAUiheUbHJJfItrRh7I9mix91Y2QA+l4djmnTQPo8w9kXqf
         yt2pmhHreL5OBL/ZfXFZJS/T9A+yBZI23le1m9QSIOpZDHXeaSVYALJNuqB2+AxiD2nM
         rPxA8Wh5VfherT1z+ZqdMG5aSHRFwq2Nir8xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gF03tPu44e7kldOb1nXs+YXmafLRpdS0s/ocQ3uC+Ys=;
        b=LkgVq/GVwQh3GZFVEKAKVsbA7HyQpDvYZRk/X1TbQ3QLMk3QFvZFb01V91eAM7/zO5
         /ufW+vhWrlGVfk6D0waWDwP2WncVr/IjqwZ9Sc284Hz1VbqQ2R+7qqpHn4dsq1Dzj8He
         /PZpoRjb+LVzXbRZgi39uQAV3rsQDuMgMLRJMw/dK3V7+OuHarJuIdcKiEORDiEptypx
         fj+5KenTmsqK9HvuTiPHoLqK4tXzTcoQYDxpvFHpfvfoaXKX4S6o1P2VKcxIVud9hr2s
         Sco9NcL93d3kvnoXHrU/atPTDxMl1cEO011jKE2Hg7upZQs/e1Yy/HvjT6Rqfb71DBVF
         utKA==
X-Gm-Message-State: APjAAAWbj1oT5v9d9XDJDHlmDwePeCYGYGNFT8Ema2DyiYkP7MkxOuYp
        TqgRELlXHyIdVp0Eu+Oiqn8iZQ==
X-Google-Smtp-Source: APXvYqx5Ng5wN27w+5xuK0HvOlLPDUtzXilPEjk2oBojQ1nzlOAOL4RBxhiuUkh61FZFwzf3zIWlTQ==
X-Received: by 2002:a5d:9cd5:: with SMTP id w21mr1494316iow.298.1556036335053;
        Tue, 23 Apr 2019 09:18:55 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id e8sm7672894itc.23.2019.04.23.09.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:54 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 14/17] sched/fair: Add a few assertions
Date:   Tue, 23 Apr 2019 16:18:19 +0000
Message-Id: <61e1213f85d1087d9b7a28e207223df29930432d.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45d86b862750..08812fe7e1d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6209,6 +6209,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target))
 		return target;
 
@@ -6636,8 +6641,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6648,6 +6651,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
 
-- 
2.17.1

