Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62582053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWBplqGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH2IcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33243 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so1591380pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beN/1HqGmBYk8ed7VYMK+GnR0j/QGkzSjGXWJHlh76c=;
        b=vWBplqGZihCL4YgrsF7BRUaW+ALkNr4bx2tO/MwAfxS8/5oj65KdFoXrqmBL0O0Zy3
         o1GLm17WhLujRAS1j52P499GqiJuArJC++hVZ56MU1V5SLQZG4GSUBhc/44Fv/CJj3Xg
         Ux+Vy7Ifn8aQSj+Fj2cxUYZdos6bgy+fo+gqgHDuK+oqv2mo6BgsU9Dl4lWLQoNTsU7L
         +K7XvAR0q6wf2Mdp+cFYHzuC8RwJ9p+C2W6FpKqhBcvDu/NBmpxS/pNPTBFToIgB0D+V
         UQzc3RGVrRtCwXRfeRj9FSgZN6b+wFuaf6J1IyODG/nFA/GYFYOvDBxxwcovzO6UDQm8
         jx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beN/1HqGmBYk8ed7VYMK+GnR0j/QGkzSjGXWJHlh76c=;
        b=huAzwgHbBVhvtcQxBTfuijfGh2S/LbP5NQw2u82udNkg3R62b4PqwbBZqYado+NMZ2
         BHrWmp7ZTYsgwvqPgVH6RhT9zQPbOmpFw2FYy526Le0ltNVt7iJcZ7I8fc39KUgAyHGC
         PSw+XMUzHiCvTny5KRZGBRWpf35Aj8ywqcVUQIuIo0Yo4HrSbBYNq1xUK58zuIh5Kpji
         YNOhJOViWMA8o3MHB+D+bhwvwKYetF7EFOWvcl/d1ye4H8DhDSFyQ66v4bRWVLvRHpyl
         Z6+VpMbhStfMyQZE1neJiGeXhTrSLFsFxdK3RcPdrQqbO5EcKhSJjw1oRdiOBs2da5dA
         c6YQ==
X-Gm-Message-State: APjAAAWpZ6sgZQmZSlZ5TfJlRn0fXrZoRnarGtdpdhpyL+VQwRgH1WaE
        hlVHXZdVcZNtAxD4yH2WcI8=
X-Google-Smtp-Source: APXvYqwk9txNfixqVGUDoN/P7RzF7pLm03bWYFTqPu0xZsLmCu1OT3xG793/iOmgzErpaI+jxklAIA==
X-Received: by 2002:a17:90a:c70e:: with SMTP id o14mr8638948pjt.56.1567067529746;
        Thu, 29 Aug 2019 01:32:09 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:09 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 06/30] locking/lockdep: Update comments in struct lock_list and held_lock
Date:   Thu, 29 Aug 2019 16:31:08 +0800
Message-Id: <20190829083132.22394-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments regarding initial chain key and BFS are outdated, so update them.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index d7bec61..0246a70 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -195,8 +195,7 @@ struct lock_list {
 	int				distance;
 
 	/*
-	 * The parent field is used to implement breadth-first search, and the
-	 * bit 0 is reused to indicate if the lock has been accessed in BFS.
+	 * The parent field is used to implement breadth-first search.
 	 */
 	struct lock_list		*parent;
 };
@@ -239,7 +238,7 @@ struct held_lock {
 	 * as likely as possible - hence the 64-bit width.
 	 *
 	 * The task struct holds the current hash value (initialized
-	 * with zero), here we store the previous hash value:
+	 * with INITIAL_CHAIN_KEY), here we store the previous hash value:
 	 */
 	u64				prev_chain_key;
 	unsigned long			acquire_ip;
@@ -258,12 +257,12 @@ struct held_lock {
 	/*
 	 * The lock-stack is unified in that the lock chains of interrupt
 	 * contexts nest ontop of process context chains, but we 'separate'
-	 * the hashes by starting with 0 if we cross into an interrupt
-	 * context, and we also keep do not add cross-context lock
-	 * dependencies - the lock usage graph walking covers that area
-	 * anyway, and we'd just unnecessarily increase the number of
-	 * dependencies otherwise. [Note: hardirq and softirq contexts
-	 * are separated from each other too.]
+	 * the hashes by starting with a new chain if we cross into an
+	 * interrupt context, and we also keep not adding cross-context
+	 * lock dependencies - the lock usage graph walking covers that
+	 * area anyway, and we'd just unnecessarily increase the number
+	 * of dependencies otherwise. [Note: hardirq and softirq
+	 * contexts are separated from each other too.]
 	 *
 	 * The following field is used to detect when we cross into an
 	 * interrupt context:
-- 
1.8.3.1

