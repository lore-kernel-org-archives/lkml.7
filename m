Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6608C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969C820863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCSRpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:45:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:45:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so857594pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUFGfLG29A75veuqIZweVMZkiXE7Q0ff+BQ3wRQhS1A=;
        b=ZFFsTsyn1XP7ltfptrw5gxX/I/FY3X83rhdBXxejFAriPjEbpBsK20nOBUXU5HDzft
         mJ7oFmrgcS+4Ngq1gY9LVeRf6deOJ3gXd4X5wcl25K8NMD4p8G1087B3VSiIZT2zm6Br
         lO6EHTqkJ6hN52G31lATIkopFBcxAlNHtOhN7t72AM9RLaIrN8+TQUA8cMUogQGIlQc3
         w5hiNi+tzaC5oK23/BwBtG9HL0tRcgqKp82un3wOckXFq2XseJcpeD2l3s+5THzqF0gl
         cNT6qty0dF232fgzw87GASA5fkSMcnH/4wLVIypXjrUQoISO42ZRPmdm5rwAOKsACeiZ
         v5+Q==
X-Gm-Message-State: APjAAAUnvYcg8abEjyAZf8sI4Zr67GBHQN792dzbgmXW8kgXakkuzzdp
        JlLm2t+XoIvwEo85iXstl/I=
X-Google-Smtp-Source: APXvYqy67enyhyWwkK64ocxpnWZ1SskNFq6xA3VBNNLjFcsP3if3JKHyJaa0VZqnmOxQYeWFx9ZEOQ==
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr3316637pll.65.1553017517250;
        Tue, 19 Mar 2019 10:45:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z6sm61364315pgo.31.2019.03.19.10.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:45:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] kernel/workqueue: Document wq_worker_last_func() argument
Date:   Tue, 19 Mar 2019 10:45:09 -0700
Message-Id: <20190319174509.95910-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that the following warning is reported when building
with W=1:

kernel/workqueue.c:938: warning: Function parameter or member 'task' not described in 'wq_worker_last_func'

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ddee541ea97a..723964a566b1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -913,6 +913,7 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
 
 /**
  * wq_worker_last_func - retrieve worker's last work function
+ * @task: Task to retrieve last work function of.
  *
  * Determine the last function a worker executed. This is called from
  * the scheduler to get a worker's last known identity.
-- 
2.21.0.155.ge902e9bcae20

