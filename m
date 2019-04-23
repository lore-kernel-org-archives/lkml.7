Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B258220684
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PQ3PhRYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfDWQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51776 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfDWQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:58 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so1150785itk.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fgeFoIILT4xE7cfwH2FoP4Bn5blNU711c0erOTBmHAw=;
        b=PQ3PhRYDGiKjNlIcEvNAHIJByNS4XlRIIKfqT8Qf//bFnrO9dYT90uQTI4ZQ1qceYX
         rlEOpILilLWrPRmWnIsbwBVbqyXFb2FpbGv+61KCNkTIfqpzAWJspnRPTj+ULyFBYl81
         AzraqW0zPFRfNscbHnec65SHJqrvjBm3I5e/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fgeFoIILT4xE7cfwH2FoP4Bn5blNU711c0erOTBmHAw=;
        b=kOWjRrrdsh6+sNOrvlIViyThA/zWrVu3yb9IF2Wb+hOeukzF1XTkP2+G9g+iMhLMPM
         wW28asuwLA3URnn7+OfNHoPp1YbHi15BX2UGc/5ocIvJ4UKyYtQjQHCCv1oLFRvYPRPZ
         3bCaSB0tKFLViZmxFVP9qG5zDWcZhMX7BGDTnyhoZhNqh2ofa+VhxHTEtTmbLwWh6wAN
         cYO8F6RYNRgQWYeP27A5QXvXiwO7Sgb0+bEhLi7sQWoYQwE9MqMoVx2goJ3XLE0HwzsX
         yZzP94EpkPK3vZWwTa9F5V0k69RFb3G14eJ6H2+gbvqPY4IIY1a2PrpARtlyAIshDJjU
         gDHg==
X-Gm-Message-State: APjAAAVRzYttAuV+ygRqaZ2A7ULPkD803t7bNwx0ZiSVEwqTDH1VOShu
        Kxwy4fFTgpTIKIAkLk8H21cd0Q==
X-Google-Smtp-Source: APXvYqwszWfLTRB2s+G3bEXTBtmfOcin7n4KUj97wsYH4PW7xRpa2S/sol8kARF/jm/R3rZZpO5lXg==
X-Received: by 2002:a24:a505:: with SMTP id k5mr2722258itf.160.1556036337159;
        Tue, 23 Apr 2019 09:18:57 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id x187sm7510452itb.39.2019.04.23.09.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:56 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 16/17] sched: Wake up sibling if it has something to run
Date:   Tue, 23 Apr 2019 16:18:21 +0000
Message-Id: <a0132b8ffb5b37a5f8e242a5ac9e3a0a5ecc5f8e.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During core scheduling, it can happen that the current rq selects a
non-tagged process while the sibling might be idling even though it
had something to run (because the sibling selected idle to match the
tagged process in previous tag matching iteration). We need to wake up
the sibling if such a situation arise.

Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8f5ec641d0a..0e3c51a1b54a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3775,6 +3775,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
 				next = p;
+				rq->core_pick = NULL;
+ 
+				/*
+				 * If the sibling is idling, we might want to wake it
+				 * so that it can check for any runnable tasks that did
+				 * not get a chance to run due to previous task matching.
+				 */
+				for_each_cpu(j, smt_mask) {
+					struct rq *rq_j = cpu_rq(j);
+					rq_j->core_pick = NULL;
+					if (j != cpu &&
+					    is_idle_task(rq_j->curr) && rq_j->nr_running) {
+						resched_curr(rq_j);
+					}
+				}
 				goto done;
 			}
 
-- 
2.17.1

