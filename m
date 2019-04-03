Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7304A2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfDCIrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbfDCIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so7142321wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+ir4YCFGUuL4nG4lvHNGktfjYXlGeFZkIZBdUcRPak=;
        b=k40qB0q9pdOi0x2wuLux+AtEnOU+sGPFQ7r13jKiU4GlHpGnVRHzOfAoPiryghSimc
         yoAiW3+aGD7ySHMwVidO8YuFYDtQK0BqCsdYo0aU5UCZabEFIywSrh0JzevddwtDrCfo
         F5pEd6qwFOn6hkQLMnZi0ye9wuZGrfqXiY/KFZ+VQpsOEZcSpuNBrsikthCmrVoSSyk3
         h0nBvHo+Tu7hIbI7VIU567uFwzW7qpFfr382c56pVJuhv21l7GHOb8k/Qeu1xmIlN0ZY
         K+OVXc+huhRKSrGMQNDK8xQgpMZSMazvm/Cvlny5rV0J9zzf6xMFpIgMSd0O8mrXiLLK
         zncw==
X-Gm-Message-State: APjAAAUfY5MbBpbOu/zgddrXY0utArrHItpbwtkn16M2O50fHvU3CxFm
        MENOHRmqqcA/droih7SDL6cg+A==
X-Google-Smtp-Source: APXvYqzR2bq2d24o1LkSOipZul7e/jCC9PjtdjXkDFi8oFC16l3MUZqJKclaUY9X6W3+ZKonx+R7bw==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr47882430wrr.269.1554281238937;
        Wed, 03 Apr 2019 01:47:18 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o2sm12258081wrs.89.2019.04.03.01.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:18 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v7 6/7] cgroup/cpuset: Use cpuset_mutex to protect seq_show operations
Date:   Wed,  3 Apr 2019 10:46:49 +0200
Message-Id: <20190403084650.4414-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190403084650.4414-1-juri.lelli@redhat.com>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuset_common_seq_show operations atomicity is currently guarded by
callback_lock. Since these operations are initiated by userspace holding
a raw_spin_lock is not wise.

Convert the function to use cpuset_mutex to fix the problem.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cb5ff6ca5d2c..91ef48bbc08d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2444,7 +2444,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	raw_spin_lock_irq(&callback_lock);
+	mutex_lock(&cpuset_mutex);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -2466,7 +2466,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	raw_spin_unlock_irq(&callback_lock);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
-- 
2.17.2

