Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5684FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87C2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZR7YFFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfJNA6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42757 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfJNA6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so14444226qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKxSPMl7EPM6ok8Zx7OEY5cb3mUO9ZZjqXNAqG0TCKE=;
        b=UZR7YFFWzMKcXxJ9dqs7MxnGNzG8a7Oahd6jRqFl17qBcCT2ZZTsf+ArewfUbYNN+w
         Ie8AcxY33Y6pyzpr/3teLmy1IwRmU7b0QhxBlBYeo9FkFGYVz8h8y1wOlMNtR3eiV+1n
         vDDQAAfmtw6It/CQwfDk/a7jXhEmgp3zCroGxG4kG3abDt+C67s+xYPDcAh+895sxAyE
         L3oG7HBa4PHAEqOvkm9oaysZ4yty+HdaN/tt9fy7iBthAPqEJwqyuuCVotRANKOGRYlv
         kB8pXhZfN5NWRpQ7hyyiMivjBtviVDArOVvvwojB6OQrJ57+co6nbh9wnGh9OjsD2EUG
         lCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKxSPMl7EPM6ok8Zx7OEY5cb3mUO9ZZjqXNAqG0TCKE=;
        b=izSqWoTALjHowtHc15XrWoQ/Ih4ewwzi0VrtaFavG2D2soh9LM4WBuumgrU0QXOtsN
         bW1JzQ9nJRhmSsG3bcR5WWOMGhupOy24zBivDklICWOcoFuKke3SiuYU+LPC5ef7ZTBm
         ZuNHPsvoQjhMJJF/wSIXgH0ZNvNOGOkqdFWlVq6naJWESfQnsbnDMutE6BUgPT0g1Hw5
         aLtgofSeZ7hZx4EQNA16dC9OxTeJZoGhKiLXgQYhQnGid8kG/m+v8Py3ONkRn4vi/Isg
         D3KElhji/atRPygOTw7tQscn0NNF4Gvtj5hFvWnaJpISJ6FV8nuOc968tF8txRTVs737
         RdXA==
X-Gm-Message-State: APjAAAWFVILKG4NxAiNmyVlNA/+qRbUO+RGZ7CHiV2jIL0uqs/aN6+GB
        6T+VRhAZ2CEhTrUL4nSJM+tezg==
X-Google-Smtp-Source: APXvYqx6Lo7b4yVbMo3zT9febFp/gUbIO/8Vp0hLvgC9m6iRfNe9f8FEA0EtCCuRs3mMgZnJHYdDhQ==
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr27017261qkh.91.1571014712537;
        Sun, 13 Oct 2019 17:58:32 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:31 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 4/7] sched/fair: Enable CFS periodic tick to update thermal pressure
Date:   Sun, 13 Oct 2019 20:58:22 -0400
Message-Id: <1571014705-19646-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in CFS periodic tick to trigger the process of
computing average thermal pressure for a cpu.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83ab35e..fe7c165 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "thermal.h"
 
 #include <trace/events/sched.h>
 
@@ -7566,6 +7567,8 @@ static void update_blocked_averages(int cpu)
 		done = false;
 
 	update_blocked_load_status(rq, !done);
+
+	update_periodic_maxcap(rq);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -9925,6 +9928,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	update_periodic_maxcap(rq);
 }
 
 /*
-- 
2.1.4

