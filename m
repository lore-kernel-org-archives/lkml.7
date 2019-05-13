Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E72C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A920989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzC/5mp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfEMJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:15:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41049 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfEMJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so6451095pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TobEgud37AkGtwOzepZXi6SMrPv78tbjIgOahu678e4=;
        b=nzC/5mp4R12YfKsXBdkXjp/pMF2No3/DKiw6YJMyiBnuLgMxkPNtsIRMHcW1zlea5X
         7UqPQCVccqlCIUGYGdOcOUFn6hVzNn6euXGC7QyYYt4gXTlsfC9eo8M6uZLbm2ZIcaRh
         /Ap7fGt3q5GxAoDuKFCLxgOrgIsE/eQVv0X7WZ55NlMfcymxtkIb1p+Uqj71PE1sSY6b
         4jWL/6AEATSKzeIZerx7kfPsh5DRnIBlpm/n5tKStXJcuh+gfw7EbrQpFmn1yUyShTWt
         b0xRugDNpcblCWDES3OJvVxdW7r/Gbeu5jBcpj51NENjWhlHteTwnTfk5CgGn2GonIor
         y1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TobEgud37AkGtwOzepZXi6SMrPv78tbjIgOahu678e4=;
        b=QVUdX60To6bpdlqFzzZzN1N4bRYmf//ZxgblxOfBg7X6ZB5xWQgubroXw87P10UlbL
         axfWmgF/OTMMDJax4q5LFE000LMvhVeqbVT1ivOVQhtpY+vJt1jXd6hKSA12b+kQGSUC
         /PC2HuGzAzE9FY1G46PuM5DsXcecfI6he+4vu05THEevvsY3tZrRFAWEFKqzM1Iuw5cf
         FQ1OlS5CpDt2WPFfATdBwPZd2suQBzs7/OwGsQKKobQHMO90etQthN5rU+HdPKrp5iAS
         pTbYTZPgFEVfQrHhvIUPoNmI7Bh6lM3TSJfob2BIN0HwU30ndIe3HKJpRnp1tjRqF1CD
         npug==
X-Gm-Message-State: APjAAAUlNeKfLAhs69ybZUX+xL7rgkt3EInR46sgoV/TSlViT1mCB7vy
        31OHBeatQA8tJIvRXLEoxXY=
X-Google-Smtp-Source: APXvYqyTbq/Wr6EUR0i+iB22ZupBhh4NVmE65Q13SyIaRVMEgml42iqebzxneFl/9sUFKS0D6JyNDw==
X-Received: by 2002:a63:8149:: with SMTP id t70mr30013740pgd.134.1557738807199;
        Mon, 13 May 2019 02:13:27 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:26 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 03/17] locking/lockdep: Add helper functions to operate on the searched path
Date:   Mon, 13 May 2019 17:11:49 +0800
Message-Id: <20190513091203.7299-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - find_lock_in_path() tries to find whether a lock class is in the path.

 - find_next_dep_in_path() returns the next dependency after a
   given dependency in the path.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4091002..0617375 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1365,6 +1365,37 @@ static inline int get_lock_depth(struct lock_list *child)
 }
 
 /*
+ * Return the dependency if @lock is in the path, otherwise NULL.
+ */
+static inline struct lock_list *
+find_lock_in_path(struct lock_class *lock, struct lock_list *target)
+{
+	while ((target = get_lock_parent(target)))
+		if (target->class == lock)
+			return target;
+
+	return NULL;
+}
+
+/*
+ * Walk back to the next dependency after @source from @target. Note
+ * that @source must be in the path, and @source can not be the same as
+ * @target, otherwise this is going to fail and reutrn NULL.
+ */
+static inline struct lock_list *
+find_next_dep_in_path(struct lock_list *source, struct lock_list *target)
+{
+	while (get_lock_parent(target) != source) {
+		target = get_lock_parent(target);
+
+		if (!target)
+			break;
+	}
+
+	return target;
+}
+
+/*
  * Return the forward or backward dependency list.
  *
  * @lock:   the lock_list to get its class's dependency list
-- 
1.8.3.1

