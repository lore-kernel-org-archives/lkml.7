Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E42020830
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMzlih3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCTDdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:33:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46718 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCTDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:33:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so668305pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2sJe92bhnpO9W3zP6D6Lfh7Em54TgNNN+e+i4jBa+9c=;
        b=eMzlih3kUT+ThDkBVS0KVtCIsvnexBC/s9m2Dsz5GuiQmJrzofi5TtXGujFZoxTuaP
         13GpTrLSoX93LN5L3pgrWT396Yh5N2EnuCImdue8cokb/HOvGxKL9KMW7PqHPYARg8UO
         QtLRKcsDc0bDFkpW4XQ62DyXMy5rvnRyy2KIxLYlmqcy4b9parY6+8ikkgH0KwtijfBw
         AloS8B3UP92JnKaBy7GmAdcO7dUSmC/NtAv4reFbQ956dvQpFUxyR+KvPEbkdYB18Ivw
         Gai/+A7yeeGbM/qpAWFy1SYbDn2/73MC7HVKAX38TtEyL1FV+0OnHsCd+cRrROwK1VRd
         jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2sJe92bhnpO9W3zP6D6Lfh7Em54TgNNN+e+i4jBa+9c=;
        b=YiOrKhgP9/34eswTjs2x5vavbVH1kubggDVljtgrmpQxHTDYQyaifM2OnWDnw9/uop
         vy8arPvVgwAUmZm7upFbWDnVMJUgaQaXn9/364Qt1wznuBxiRTvebkL1wD3eO+/7cbSD
         KVFVziqzi16JsowEekWiXrFXDcdPsn4TvuXZ0VaRgpUvq6JcL8D6vXoyPdO1OgttzGh/
         Mh+tdqzby5+PeSK81Q7ww7bzJMBpEsVc1hxGZ527DzdxpVdlWoQsL8E4Jo8BIt5brgQm
         xcO8Gloxk2W/qcK/LyA8GnKfL6tE/3d0VQAU4OtnW2bqNnSgEnI7HwLPlSBZATVLS4l9
         BGXA==
X-Gm-Message-State: APjAAAUxepDOcm2H27CLfI2gCk2DMvfRihd6llZFYqTZ6uu44kCLNtAn
        kPy1LZcrbtsYMzIdyrGaCjc=
X-Google-Smtp-Source: APXvYqy+a9yMx9TqWMBRExGNZpydCo9mA7f4UEIkaHVs2JmoPaTiktj+eKX4iAtsb/cZKfPd/J7GsQ==
X-Received: by 2002:a65:60da:: with SMTP id r26mr5194564pgv.294.1553052799196;
        Tue, 19 Mar 2019 20:33:19 -0700 (PDT)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id v18sm566909pfm.165.2019.03.19.20.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 20:33:18 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: Adjust comments for force_qs_rnp
Date:   Wed, 20 Mar 2019 03:33:00 +0000
Message-Id: <1553052780-3789-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, threads blocked on offlining CPUS are migrated to root
rcu_node, so there is a need to initiate RCU priority boosting on root
rcu_node,

Current RCU does not migrate blocked tasks even if all corresponding CPUs
offline. 
commit d19fb8d1f3f6 ("rcu: Don't migrate blocked tasks even if all corresponding CPUs offline")'

Consequently, rcu does not initiate RCU priority boosting on root rcu_node.
commit 1be0085b515e ("rcu: Don't initiate RCU priority boosting on root rcu_node")'

So I think the comments for force_qs_rnp should be adjusted.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acd6ccf..efddffb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2548,9 +2548,9 @@ void rcu_sched_clock_irq(int user)
 }
 
 /*
- * Scan the leaf rcu_node structures, processing dyntick state for any that
- * have not yet encountered a quiescent state, using the function specified.
- * Also initiate boosting for any threads blocked on the root rcu_node.
+ * Scan the leaf rcu_node structures, initiating boost for any threads blocked
+ * on them, processing dyntick state for any that have not yet encountered a
+ * quiescent state, using the function specified.
  *
  * The caller must have suppressed start of new grace periods.
  */
-- 
2.1.4

