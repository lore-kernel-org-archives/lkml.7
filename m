Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A32146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYmI4zfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCUH5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so3760927pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICV2JCxGUwQgyY5us2Dfx+UwHNzy7pzqiOTFmEju5+U=;
        b=oYmI4zfb1cxnU261zWYaMpQF8GXOawcb4RSwTUQtL5CZzd+VrWsbNBewI3j8YUkuB3
         UgCvuAkyqWCjXD2FEa7QJpbjeeEVm0JvymTBe2SNcTGpMrLvR/p/Odl9jnPRKgpC+1AA
         wCdzz/UBSb6fKbsE/MIBOEYsIVYAMN1Uf4qYjeG+Q/rS/IuIfARIKP4/Zwh/JHL0KNd5
         /7wewuFOPk6YI7pYGVFDiNYtr9Zfv7LpAVhiZys3WPVM1UC9yDOKNMXXYbUOgQy46+/o
         YhyHGRALpI0cDuAS+wdMglbpjjkT+P/gY40WYRbCh4OpvfZYm9WyUSx2POWE8V+b+QBz
         x9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICV2JCxGUwQgyY5us2Dfx+UwHNzy7pzqiOTFmEju5+U=;
        b=b+tTkyuIw6dqvayyE3nCaoTu9zTh/1p7KfBuYfTffqQlPAXmk+OgBNdQ9Zhkd0K/ID
         a3P7RPF5U82YXEajQOPgvpsvKxBcc/3dKUViN3w81dEB2yWsGdp3+tMHnfGzANUVL1IE
         36e3Mc4lsoU5LtqodA2QiHiAyOrzrHXIPY7r76RwD/cZntnVeJuENWJxzKhGsru0xOFE
         /ihu41HuqcQ/hGIBTF7KaTMNF1wC/V0DwxmXxVEUuFnYkPr+2Y2cZzMUyxRG9VQc37YK
         +l2BaZBiIx+T+3gslc/QyVEMfEaLxXOSABIFkoI7dzeFO3sHwsWMMZWA3J2PL8EsvKXO
         KL1g==
X-Gm-Message-State: APjAAAWAU1+dUFBwAYnzpZPwophpX6k1O2KJMFu2xP0zpkB6GTJ0PACg
        Cll22b5XS3meeHkFfjFIP18=
X-Google-Smtp-Source: APXvYqyGp7/bsb5rhMH45JuranEKat/rAWpQDq2PRXRvGSgw6+UiT+sPlX/Z071E1/PL6NNR87Xmuw==
X-Received: by 2002:a17:902:758f:: with SMTP id j15mr2179990pll.211.1553155062430;
        Thu, 21 Mar 2019 00:57:42 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:41 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 03/18] locking/lockdep: Adjust lock usage bit character checks
Date:   Thu, 21 Mar 2019 15:57:10 +0800
Message-Id: <20190321075725.14054-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
index 41137ad..db0473d 100644
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

