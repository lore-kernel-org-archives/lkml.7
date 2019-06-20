Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A78C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3402083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qec8xwRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfFTLhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:37:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:37:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1434489pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yKEd9HhmnRHv6Rm1Z2wKDw4689WjPwOMThOJVzvOy/c=;
        b=qec8xwRLzv6PCLePGLq6o3kLWxuqXbvRk2pU5KdcEVn7lqbHvJgcr9o62N3nKfX5LS
         XVZxfs5+YfGyi/Qcy61zZo9cM+x1nsMc/ojWVwjlp7WFF/DSpwOMCHQguDfuPOknX1d1
         PemjNpDiNArNkcruyUqG0TxlvghyUGgeKg7fbm8YdqOxYb/aMv/RqtL5MGeNacnrRjuZ
         3g6j6hYSWq3syGvdgWN3IJCPNXMo9NE5aPERrAg3npu0slFlxwFFWO3VB4kh6BExr+nP
         tyIYHVBQyoXWZRR0I0A6VTb0rJX7lzQGclP8oRqz0B+BGpXEhCp+5Zo3XcTNv99lXec2
         XUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yKEd9HhmnRHv6Rm1Z2wKDw4689WjPwOMThOJVzvOy/c=;
        b=P5GU7afGo79rIFhPOJ4S82bb7Ok9cG/g8PYVCb5NRE/mGYAnWOZh0O9rEnN5sHQaYe
         5GJNJswSybLbyIiKSydPeGr+RopzngSR7tIc0qaKwpKhr/xADlwnceum6c8pCPFGm7Jm
         8y7NKLs1tmBCC9Aa/lxM/Lyux0Ipwn6ytDlq7Rs25tb+sz/DesMs+b2zcD55DGh+HWEh
         E3atrxSVchDI8BSP40GWRwpvv6CskutKVB7xaEN2UHa27RMCb5tBKQAgWSC1KldQFwwj
         rwCp+POWqT9oqnWjEIx7+C6dPzvAx6Iq87Yj4+aMAVvwEr77cGayVmtpfLnfQqIsTrUu
         KCsg==
X-Gm-Message-State: APjAAAWTuXsUuoIcnbr/4ywF207KKPUiLnElPIfAmeubAZSsU5Po1w3h
        Slj5OJdQabCAAyT88IK3NTiHYB2e
X-Google-Smtp-Source: APXvYqwjaUcVzVmx6ohU8R4kjmGPBYdUa4hiS8O8pa7HWvW5/CD4oKSniGR56GdOJ4G4ADwHGJ4uzQ==
X-Received: by 2002:a63:e953:: with SMTP id q19mr12669691pgj.313.1561030620385;
        Thu, 20 Jun 2019 04:37:00 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id h6sm6386065pjs.2.2019.06.20.04.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 04:36:59 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] sched/isolation: Prefer housekeeping cpu in local node
Date:   Thu, 20 Jun 2019 19:36:54 +0800
Message-Id: <1561030614-17026-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

In real product setup, there will be houseeking cpus in each nodes, it 
is prefer to do housekeeping from local node, fallback to global online 
cpumask if failed to find houseeking cpu from local node.

Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/isolation.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 123ea07..9eb6805 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -16,9 +16,16 @@ static unsigned int housekeeping_flags;
 
 int housekeeping_any_cpu(enum hk_flags flags)
 {
+	int cpu;
+
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
-			return cpumask_any_and(housekeeping_mask, cpu_online_mask);
+		if (housekeeping_flags & flags) {
+			cpu = cpumask_any_and(housekeeping_mask, cpu_cpu_mask(smp_processor_id()));
+			if (cpu < nr_cpu_ids)
+				return cpu;
+			else
+				return cpumask_any_and(housekeeping_mask, cpu_online_mask);
+		}
 	return smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
-- 
2.7.4

