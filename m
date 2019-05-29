Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F9BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B5227B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="WoUU5BDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfE2Uhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33080 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfE2UhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:12 -0400
Received: by mail-it1-f195.google.com with SMTP id j17so6406011itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KzPbPNVLoJ8an2+oYL5vGfNCfG5XqaXXUNgMrwuKiOo=;
        b=WoUU5BDEvs4yWSWNELCK6SxUxlulNoGviYValPkmslZNFRePfn0gbEdnIJXXFj4uan
         4EJ9o4CMGtR6T3Z1ti9355Q+xjyDNp4OMwyyioBEWi1VTcRvL+sqruNMzgaXEJYs6fZp
         cvT/qN/NwYqq/N2vxq+zQKX8+bQ3To0P8Dc0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KzPbPNVLoJ8an2+oYL5vGfNCfG5XqaXXUNgMrwuKiOo=;
        b=R0UlnpV7lOd4p8nQ3vdu8dOptS2I884OYYrACtQV8JeJ0HNlhN5Ptcs3brJToYYZME
         6SR3EscHWzySG9DE25yZHuEhhPHzvlT6deQKndxu9haT9/by4F+ScH3oFwDs8O5biuil
         zz6qbt463Vo+ff+/aM9pIMa+Nme7kBqW/CQMlodltNmIMjEeosmra5nkVOvFJmQhQEbX
         7M1AIoM/61cFF56a81L7jKHmWZiNh5LYrprrL2Or06YKiQihXRlsy0RCQIMA4LtlBrqb
         xYQisRjBmLutSMxFIXdAZRaSIaHbM04ZPhfm+vK/MmZLNCOYLaO2vSzItbPK20XnIAJw
         j2RQ==
X-Gm-Message-State: APjAAAVHyqt26DvbsamMRzwzV2h7l7eNnChYw/ZnBYQG/5g2f9Ch5Z1K
        8Qz39hiroOMebQC6ZA+YU11M0Q==
X-Google-Smtp-Source: APXvYqza4UPUOTOMLkMTlvDr3GV01DGi3xQqYQecq93DjA/40Q/xXcha+ACKXOpcs2cTVyqABcS7Jw==
X-Received: by 2002:a24:b948:: with SMTP id k8mr148646iti.29.1559162231211;
        Wed, 29 May 2019 13:37:11 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id j11sm196937itj.11.2019.05.29.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:10 -0700 (PDT)
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
Subject: [RFC PATCH v3 14/16] sched/fair: Add a few assertions
Date:   Wed, 29 May 2019 20:36:50 +0000
Message-Id: <09fc702d6f38b8d75318ca863e48b102a64008ba.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
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
index d8a107aea69b..26d29126d6a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6192,6 +6192,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target))
 		return target;
 
@@ -6619,8 +6624,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6631,6 +6634,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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

