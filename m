Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33278CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568F208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="OLc4PtHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfJ3Sea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34362 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfJ3SeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id d192so1203868ywa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cJyRbleLwiHo0wJViOBsze9IwthH4NQ1gXdn+1ViqSA=;
        b=OLc4PtHh3QFFGzqUzAt19Tv+zExtPx9Kg2r0U3WWiRZ/0kegJ11A13LA+jPL4dldKO
         uzziV8jJRqqp9zPpbYP60frlmah+DKb39By1dnXVK56RVi3i0ybdDVz6z9JLcog9+Kv5
         6PTIw78WVM0Sl1/Mm1dq1d4TWpFvuUiD2GJo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cJyRbleLwiHo0wJViOBsze9IwthH4NQ1gXdn+1ViqSA=;
        b=IYsiN9UTSVBqTewhjEzTAM4KSI+WqGf0WuZ/1LNZ9AihIQxOPaMd8h9NfSJD+5qE4K
         Rbahl6Gn3z8YrVzAmZ+LnuHuDPHIN8N8GFQfBhCMUVcrLsf6NQ3mPBljd2x7+axBPv2u
         x9cN83gx81c8ZrqYqDiNGGKtYh3na8Oy3t5NvWqxpGDmgUrdlN8Z34Ba45WKW1QW8j7m
         qYFkSkUEIn0PP8NQkWicp+rf/fOyvPkJXourM/cU6rG0sDRsaSLQbJ11XpQSZ3EDnHA5
         y6ih7V1Ed2It38OdIaauLB3PjKWS8w8+La9mkLu+WEi/c9RqyocpDdc+OKwH/fOWSjRq
         Sgvw==
X-Gm-Message-State: APjAAAUggxcrIXCE+k3ADpbVPgFZi1TuC23SMp4jMiQk10MTlJm2ehuP
        IZAlFboSEsnfq0XIgwXYuWJp/A==
X-Google-Smtp-Source: APXvYqwIXkLd9KWV3wzecGEdXt74WOiBQ1y6hP7x4UEF1nJh0TDgih9kth5Wb1QDF2YxAXN2eGcAug==
X-Received: by 2002:a81:a141:: with SMTP id y62mr844268ywg.376.1572460464758;
        Wed, 30 Oct 2019 11:34:24 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id k34sm382744ywh.49.2019.10.30.11.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:24 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 14/19] sched/fair: Add a few assertions
Date:   Wed, 30 Oct 2019 18:33:27 +0000
Message-Id: <95872a66360f949c4c862145a009b22099669b14.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3b7e8ba1420..840d27628d36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5984,6 +5984,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target))
 		return target;
 
@@ -6439,8 +6444,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6451,6 +6454,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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

