Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275B92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfCSSOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:14:46 -0400
Received: from pinero.vault24.org ([69.164.212.126]:48300 "EHLO
        pinero.vault24.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfCSSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:14:46 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 14:14:46 EDT
Received: from feynman.vault24.org (feynman.vault24.org [IPv6:2001:470:1f11:7b5::14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by pinero.vault24.org (Postfix) with ESMTPS id 9A7D0603D;
        Tue, 19 Mar 2019 14:08:42 -0400 (EDT)
Received: by feynman.vault24.org (Postfix, from userid 1000)
        id DE566302DD18; Tue, 19 Mar 2019 14:08:41 -0400 (EDT)
From:   Jon DeVree <nuxi@vault24.org>
To:     linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, Jason@zx2c4.com, Jon DeVree <nuxi@vault24.org>
Subject: [PATCH] random: fix CRNG initialization when random.trust_cpu=1
Date:   Tue, 19 Mar 2019 13:28:47 -0400
Message-Id: <20190319172846.30741-1-nuxi@vault24.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system boots with random.trust_cpu=1 it doesn't initialize the
per-NUMA CRNGs because it skips the rest of the CRNG startup code. This
means that the code from 1e7f583af67b ("random: make /dev/urandom scalable
for silly userspace programs") is not used when random.trust_cpu=1.

crash> dmesg | grep random:
[    0.000000] random: get_random_bytes called from start_kernel+0x94/0x530 with crng_init=0
[    0.314029] random: crng done (trusting CPU's manufacturer)
crash> print crng_node_pool
$6 = (struct crng_state **) 0x0

After adding the missing call to numa_crng_init() the per-NUMA CRNGs are
initialized again:

crash> dmesg | grep random:
[    0.000000] random: get_random_bytes called from start_kernel+0x94/0x530 with crng_init=0
[    0.314031] random: crng done (trusting CPU's manufacturer)
crash> print crng_node_pool
$1 = (struct crng_state **) 0xffff9a915f4014a0

The call to invalidate_batched_entropy() was also missing. This is
important for architectures like PPC and S390 which only have the
arch_get_random_seed_* functions.

Fixes: 39a8883a2b98 ("random: add a config option to trust the CPU's hwrng")
Signed-off-by: Jon DeVree <nuxi@vault24.org>
---
 drivers/char/random.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6d1c..d4d45ccfeefc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -777,6 +777,7 @@ static struct crng_state **crng_node_pool __read_mostly;
 #endif
 
 static void invalidate_batched_entropy(void);
+static void numa_crng_init(void);
 
 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
 static int __init parse_trust_cpu(char *arg)
@@ -805,7 +806,9 @@ static void crng_initialize(struct crng_state *crng)
 		}
 		crng->state[i] ^= rv;
 	}
-	if (trust_cpu && arch_init) {
+	if (trust_cpu && arch_init && crng == &primary_crng) {
+		invalidate_batched_entropy();
+		numa_crng_init();
 		crng_init = 2;
 		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
 	}
-- 
2.20.1

