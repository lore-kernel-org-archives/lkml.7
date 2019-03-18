Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFDF217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALvay8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCRI5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42831 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfCRI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id b2so10894430pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a28sVP+44q7iWCcjuw3hwp2P++bKgYYvw2MgXjP7Hz8=;
        b=WALvay8TF29d6RStO9aJvOGN2gEAf/t1teJIDI5Cdg4+cW8zUg2wf2O4v1I51xezRp
         qEOEUNwjk76d+E4Hx4zbJtex8OYGxhq1+fC+IN5nvArrlD24ZrGaiMCTkWI1VkJNqPBW
         7N7nBqxpG203906AM+NYbwsNKOh4CtXt2z7FH8nHXV51fluhr4kV8HV5D35x+/4mBj9A
         ECIBGf4lLQW3JrWQNbVVH7uFq2mQHYbaHYjj+9XVwbydQbfcnh7vObRf4hDnFOthY8m8
         p6SG2VbWjOvoZ+AC/F2+ubyn80iAoy9GBijZULUuw/8pWc43zqDpc3CRblLB2dhXCAqG
         vl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a28sVP+44q7iWCcjuw3hwp2P++bKgYYvw2MgXjP7Hz8=;
        b=ZBH0MaVgdwkO/ckQJ1O9YHIq15VDIPNPWDJpDVxg+teTWWN26JfJ9jmWhGduOoJLh+
         y4kYnGy/uf8zq2IcucEyAGzCK3QgE56N1sP74KIZ7Rsu4u2s5JPW9Mn5l5zNox9C5/Ts
         Og594mzHWh44QbV0itum2q+uqTFAH1+RJdXauXTfHnD7nAcW5mdv5ca4/Pv/uV5Ngilc
         VRqawcpp3GjSZuhMaTLsJmhWMXdwQQgFxp4Gei66MFBaEGkEnor1u62LON2mvC1rvlOb
         v4vCvgt5B2DllOX5pHExlXeoT1Hyz9Au9TEZLpeAoozFi1xjYsfdXdSVm2Y+iDpcL5Ru
         mi7A==
X-Gm-Message-State: APjAAAXfl0uAnM7c/7ntX9gp6n5g7G8v2dWnhGtUmEXTviFqxJzuCDKV
        fc+Bmh5lVFRq2A1hgAdxZB0=
X-Google-Smtp-Source: APXvYqxP9hi4PR/pPgF+fZ9v1QeBzUnkx8fw/aa7I2yvenOw8h9kS9JD8QiVj/GwglbvIThETLpFmg==
X-Received: by 2002:a65:410a:: with SMTP id w10mr16289028pgp.206.1552899471948;
        Mon, 18 Mar 2019 01:57:51 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:51 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 03/19] locking/lockdep: Adjust lock usage bit character checks
Date:   Mon, 18 Mar 2019 16:57:17 +0800
Message-Id: <20190318085733.3143-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock usage bit characters are defined and determined with tricks. Use a
macro and add some explanation to make it a bit clearer. Then adjust the
logic to check the usage, which optimizes the code a bit.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 21 ++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1c5e947..d5b66cf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -514,15 +514,26 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
+	/*
+	 * The usage character defaults to '.' (i.e., irqs disabled and not in
+	 * irq context), which is the safest usage category.
+	 */
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + 2))
+	/*
+	 * The order of the following usage checks matters, which will
+	 * result in the outcome character as follows:
+	 *
+	 * - '+': irq is enabled and not in irq context
+	 * - '-': in irq context and irq is disabled
+	 * - '?': in irq context and irq is enabled
+	 */
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_TO_ENABLED_STEP)) {
 		c = '+';
-	if (class->usage_mask & lock_flag(bit)) {
-		c = '-';
-		if (class->usage_mask & lock_flag(bit + 2))
+		if (class->usage_mask & lock_flag(bit))
 			c = '?';
-	}
+	} else if (class->usage_mask & lock_flag(bit))
+		c = '-';
 
 	return c;
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index d4c1974..2fd31d5 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -25,6 +25,7 @@ enum lock_usage_bit {
 #define LOCK_USAGE_READ_MASK 1
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+#define LOCK_USAGE_TO_ENABLED_STEP 2
 
 /*
  * Usage-state bitmasks:
-- 
1.8.3.1

