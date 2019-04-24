Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E066C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD462175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwEJaRe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfDXKVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32980 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfDXKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so9088683pfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUEct94p4z81CQV2J6aNaopGzv72/XIcnPlSHDyz/ug=;
        b=XwEJaRe+P/Z4RllgeTSO8LC/Qq8yXUNfp+e+7bJTlmxs0hL+01CYB8KJKR7VkZWGCv
         sBifeQvofHzXrl0qiJQHoaIo57KqFRtCh4VHWeIshei+RMa/NNyG2izMcDMUwYRIDhmc
         zurWe2Ps/rm0RlmGX2ef0kTBVwKh2tH98PreAu2fgwNWFhNfT235zl0aN3lzW3woBF8E
         YlM9iqGNgKmQlVEcdFE7it9UOwsgnIRvdDMJ2Qdh8aJK7z380VN3RmCDwhE+HMFT0lDL
         2BAh7PiRqoJaO/HIxLvDyqdrhx/ukTkORjNgUBOeGDEam2kbxAI8AMaGyTBnbqO36xKJ
         2GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUEct94p4z81CQV2J6aNaopGzv72/XIcnPlSHDyz/ug=;
        b=rl6+Ys01GC1jEpI3sCiiofVUdpNx7JZ9dPCdOWtarFj5VsLMHMem/16d3QdpEAqOxN
         GxKPQiSig4MvMJbu6H9AdyTxYgltz8As3InsdkGq8tF6UDgGcuzLHFu3gRXvVQRpI9EC
         Z5av31RUyUyiQImlFHJfEKUhSh9H+sB4/9/epPNBsZjN5vNMRShegoaDcf523ii8ugyc
         xAf/nafpFQGGBh6vdGWjx9blr3a3r1rJqU5CnbefLngIdXPylrDQD+63onoWdk1XNlH8
         hv6Df9Z357Z6gnypEsRMUHTnBHfcZ94JceIk/taaBXarjPF/68n069A9Vor6+RZhm4Bn
         tEuA==
X-Gm-Message-State: APjAAAVzdSQ78ZRy9DnZ6OcSHZcjzPXEHmLz7qvDPmcjdm3JUWkk+E7W
        Jq7YZpFtpynyuFtaEsgrakI=
X-Google-Smtp-Source: APXvYqwFB5TrTc4izy7Kg6i9VstCEBeJlXn+AXro//Do9T18NJWdAC5E55N1ZoTQvYpV4T6EV2PFAA==
X-Received: by 2002:a63:ed4e:: with SMTP id m14mr30489203pgk.182.1556101298886;
        Wed, 24 Apr 2019 03:21:38 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:38 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 23/28] locking/lockdep: Update irqsafe lock bitmaps
Date:   Wed, 24 Apr 2019 18:19:29 +0800
Message-Id: <20190424101934.51535-24-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitmaps keep track of which locks are irqsafe. Update the bitmaps
when there is new irqsafe usage and when an irqsafe lock is zapped.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 291cc9c..1b78216 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3107,6 +3107,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	int excl_bit = exclusive_bit(new_bit);
 	int read = new_bit & LOCK_USAGE_READ_MASK;
 	int dir = new_bit & LOCK_USAGE_DIR_MASK;
+	struct lock_class *lock = hlock_class(this);
 
 	/*
 	 * mark USED_IN has to look forwards -- to ensure no dependency
@@ -3119,6 +3120,25 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 		check_usage_backwards : check_usage_forwards;
 
 	/*
+	 * The bit is already marked so that we update the bitmaps
+	 * before validation.
+	 */
+	if (!dir) {
+		unsigned long *bitmaps[4] = {
+			lock_classes_hardirq_safe,
+			lock_classes_hardirq_safe_read,
+			lock_classes_softirq_safe,
+			lock_classes_softirq_safe_read
+		};
+		int index = (new_bit >> 2) << 1;
+
+		if (read)
+		       index += 1;
+
+		__set_bit(lock - lock_classes, bitmaps[index]);
+	}
+
+	/*
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
@@ -3146,7 +3166,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 			return 0;
 	}
 
-	if (state_verbose(new_bit, hlock_class(this)))
+	if (state_verbose(new_bit, lock))
 		return 2;
 
 	return 1;
@@ -4650,6 +4670,22 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 	}
 }
 
+static inline void remove_irqsafe_lock_bitmap(struct lock_class *class)
+{
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+	unsigned long usage = class->usage_mask;
+
+	if (usage & LOCKF_USED_IN_HARDIRQ)
+		__clear_bit(class - lock_classes, lock_classes_hardirq_safe);
+	if (usage & LOCKF_USED_IN_HARDIRQ_READ)
+		__clear_bit(class - lock_classes, lock_classes_hardirq_safe_read);
+	if (usage & LOCKF_USED_IN_SOFTIRQ)
+		__clear_bit(class - lock_classes, lock_classes_softirq_safe);
+	if (usage & LOCKF_USED_IN_SOFTIRQ_READ)
+		__clear_bit(class - lock_classes, lock_classes_softirq_safe_read);
+#endif
+}
+
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
@@ -4680,6 +4716,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		WRITE_ONCE(class->name, NULL);
 		nr_lock_classes--;
 		__clear_bit(class - lock_classes, lock_classes_in_use);
+		remove_irqsafe_lock_bitmap(class);
 	} else {
 		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
 			  class->name);
-- 
1.8.3.1

