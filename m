Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702320863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCSRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:40:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38785 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:40:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so14199594pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o5e0Ylgg/Fq77oBmrsvYmEc2QgWz3/mZPyQr/COrHM4=;
        b=a/0HChMU5RN68xGINjRfrcJnrK6FJ6C0gXdeHWfY/CDXQPc2281nnCYrGcy95j5XQp
         stDBhVrb0oNdqtucV6/9HZ39aPEwDln9eWfShlo1BJvCImuI4QyXuo0CTeaEX1kRmx98
         RXnw57NRbI3ww43VsG3/ZH2u1TKjG2TsufvJ9pmmTACg8D/vELT5NT/TEymJWzy4VmVm
         8xYT7YWlNiKE1+hdvQCXxaPDhUoqocEUPBD1UdRCpVoXtKjK644uWa26sAIRhtRWRNgR
         Jlvd68L5CorjqzatxNBBgOzJpsYllIXIaVAc2VCRoBHGCPwgLDpNRkJRiIQSKdFEK/xu
         A35Q==
X-Gm-Message-State: APjAAAWcQ0MNqvqSQjUQ+ngry/KZ407pK3xKg2mtDBh67ntEqObYFWHr
        nI6uosDM8R/BUc5usTq9Rzk=
X-Google-Smtp-Source: APXvYqwO0eWEVqx5ZTcHruvbAhh9KoyCL26G1pqK/3LbwCo50PaRUiBS5N0i1z5JqQdeEQTUzvoAyw==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr3591052pfi.138.1553017256333;
        Tue, 19 Mar 2019 10:40:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j24sm23098347pgl.58.2019.03.19.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:40:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] kernel/workqueue: Verify alloc_workqueue() argument list consistency
Date:   Tue, 19 Mar 2019 10:40:47 -0700
Message-Id: <20190319174047.89815-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that gcc reports the following warning when building
with W=1:

kernel/workqueue.c:4250:2: warning: function alloc_workqueue might be a candidate for gnu_printf format attribute [-Wsuggest-attribute=format]
  vsnprintf(wq->name, sizeof(wq->name), fmt, args);

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/workqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d59525fca4d3..30737b5183c0 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -404,6 +404,7 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
+__printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...);
-- 
2.21.0.155.ge902e9bcae20

