Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2206FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064D208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRQGQ5jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfFGSZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:25:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45300 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfFGSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:25:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so1561017pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYDK/Ml86HIhaRKgcJ0KAZsOK3HoGoEVF0ppDC3vBHQ=;
        b=tRQGQ5joW60QtHDuDrLQHqq5eVItuVck7bLS4zIqlX27xGUcs4TWiBC0OIsnO3dOXH
         ctVS3ATtee3nPXBST79kg/ZmAyJ3JT98smksa2W53bQ4x6F1bl58W9oqOc9KsmYpsNGY
         7zCYn828vB/CFcr8njOUcpysbo4/0+ShiYb5KfoRxqmQK5F310s7WbLVxkeRcNql9ZgK
         F0xBYsqmQca0Lu67OHJ3/s+OsU3N3wQp4U2NNKl+uvAECSKxUb92zEhw6ngH0o5V+dRb
         MDeoOsoCDKbwjCyGnisAMNcSy7L31onhIoFSXFKZLooacSy/a6X5io3G/bow2GIK17zq
         PgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYDK/Ml86HIhaRKgcJ0KAZsOK3HoGoEVF0ppDC3vBHQ=;
        b=XuBggn5jZ2sHAfDu2Q2V8WVyjhPHxI+3OOyR0mBKhy8pVTOEHwyD4NVTPsSua7lqSg
         T7gakbtukdpbDYE9aSEOu1qYBDQPLophawfrQpmzJucoo0NhhWP8AnBfWXaavM+G+HFk
         ENgKsU6wEDKU0i+fP4G115UhejAvADT0bUqyxkLlWrk38djcHmuTFZF/nn5jF/tfvmVY
         lGDGRLru4fl8233X2S83rBIQ59vmqj9NnKwH2w3Og6ZwKmHMeuVGQQ8BETYSGPpe0BFN
         zipU2IicaRWH0C+66whMVYnoO8X8DpWMqkExCML9Y5w2T3e7aBkrWr4YvCXtr49UjTbH
         krbg==
X-Gm-Message-State: APjAAAXe+PMHuAFKzn+s5odcE70YPLtkoh2hOnaPh7ppNYv39IxAQaod
        6c5UdU9rcsG5FAhZ9eWVOvWR3tjlaG8=
X-Google-Smtp-Source: APXvYqyhamZXLeEnC61AUK7F7JoqkTYdVzAS4jUUiLzWQsguRJE22748uHI0ZREwmJs5j4p+gzcq8w==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr4261357pgi.28.1559931929519;
        Fri, 07 Jun 2019 11:25:29 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q1sm6066226pfb.156.2019.06.07.11.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:25:29 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/5] random: Add and use pr_fmt()
Date:   Fri,  7 Jun 2019 14:25:15 -0400
Message-Id: <20190607182517.28266-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix all printk/pr_<level> messages with "random: " to make the
logging a bit more consistent.

Miscellanea:

o Convert a printks to pr_notice
o Whitespace to align to open parentheses
o Remove embedded "random: " from pr_* as pr_fmt adds it

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/random.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d714a458f088..f0c834af14a8 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -307,6 +307,8 @@
  * Eastlake, Steve Crocker, and Jeff Schiller.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/utsname.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -760,7 +762,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	}
 
 	if (WARN_ON(entropy_count < 0)) {
-		pr_warn("random: negative entropy/overflow: pool %s count %d\n",
+		pr_warn("negative entropy/overflow: pool %s count %d\n",
 			r->name, entropy_count);
 		entropy_count = 0;
 	} else if (entropy_count > pool_size)
@@ -883,7 +885,7 @@ static void crng_initialize(struct crng_state *crng)
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
+		pr_notice("crng done (trusting CPU's manufacturer)\n");
 	}
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
@@ -946,7 +948,7 @@ static int crng_fast_load(const char *cp, size_t len)
 		invalidate_batched_entropy();
 		crng_init = 1;
 		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: fast init done\n");
+		pr_notice("fast init done\n");
 	}
 	return 1;
 }
@@ -1031,15 +1033,15 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
-		pr_notice("random: crng init done\n");
+		pr_notice("crng init done\n");
 		if (unseeded_warning.missed) {
-			pr_notice("random: %d get_random_xx warning(s) missed "
+			pr_notice("%d get_random_xx warning(s) missed "
 				  "due to ratelimiting\n",
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
 		if (urandom_warning.missed) {
-			pr_notice("random: %d urandom warning(s) missed "
+			pr_notice("%d urandom warning(s) missed "
 				  "due to ratelimiting\n",
 				  urandom_warning.missed);
 			urandom_warning.missed = 0;
@@ -1463,7 +1465,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 		ibytes = 0;
 
 	if (WARN_ON(entropy_count < 0)) {
-		pr_warn("random: negative entropy count: pool %s count %d\n",
+		pr_warn("negative entropy count: pool %s count %d\n",
 			r->name, entropy_count);
 		entropy_count = 0;
 	}
@@ -1682,7 +1684,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 	print_once = true;
 #endif
 	if (__ratelimit(&unseeded_warning))
-		pr_notice("random: %s called from %pS with crng_init=%d\n",
+		pr_notice("%s called from %pS with crng_init=%d\n",
 			  func_name, caller, crng_init);
 }
 
@@ -1964,9 +1966,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
 		if (__ratelimit(&urandom_warning))
-			printk(KERN_NOTICE "random: %s: uninitialized "
-			       "urandom read (%zd bytes read)\n",
-			       current->comm, nbytes);
+			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
+				  current->comm, nbytes);
 		spin_lock_irqsave(&primary_crng.lock, flags);
 		crng_init_cnt = 0;
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
-- 
2.17.0

