Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC1AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11FA21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567127520;
	bh=48YHBcgZFu1F8D2WFbpxkLRezHZiaeSa/tHcV9zv9WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWk2csoF4keBX/ywLWQuQ7ysFOIJ6N59GkXY2Ignfe5ENId3Pl8gxkNuCxInJG49T
	 7IKg3yHDIPvl+mdNAeMCamQR4bRINeVMFT1bpdm7HjlEP5hRRCPBhXI4Z25XuCKPyE
	 5QWVr5JOSXwzlv4MmHbmWVJ4uo/k0hRjVmktkMO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3BL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfH3BLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:11:49 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A23121897;
        Fri, 30 Aug 2019 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567127509;
        bh=48YHBcgZFu1F8D2WFbpxkLRezHZiaeSa/tHcV9zv9WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOVsBUWVbxWdj3EtG+YHfqyQ239X/ca99PNP8wqsrZYAMshO++2Db2M2lUVb3O/T5
         Zphjbz9oVxYbsGOccg4irBhJR4NVINx6iUBK6AeRX04TPAu9mq3X6xxM1UYRYwRSZd
         j96X/AWct5j5eP+Co1FIWxcx85zG6AQ6552KCXJ0=
From:   Andy Lutomirski <luto@kernel.org>
To:     Theodore Tso <tytso@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 7/7] random: Remove kernel.random.read_wakeup_threshold
Date:   Thu, 29 Aug 2019 18:11:42 -0700
Message-Id: <49f02ca58d95d1036ecc21c98ee544ddac5511ed.1567126741.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has no effect any more, so remove it.  We can revert this if
there is some user code that expects to be able to set this sysctl.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/char/random.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 99fea5cc29a8..2a284f30cac4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -369,12 +369,6 @@
 #define ENTROPY_SHIFT 3
 #define ENTROPY_BITS(r) ((r)->entropy_count >> ENTROPY_SHIFT)
 
-/*
- * The minimum number of bits of entropy before we wake up a read on
- * /dev/random.  Should be enough to do a significant reseed.
- */
-static int random_read_wakeup_bits = 64;
-
 /*
  * If the entropy count falls under this number of bits, then we
  * should wake up processes which are selecting or polling on write
@@ -1982,8 +1976,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 
 #include <linux/sysctl.h>
 
-static int min_read_thresh = 8, min_write_thresh;
-static int max_read_thresh = OUTPUT_POOL_WORDS * 32;
+static int min_write_thresh;
 static int max_write_thresh = INPUT_POOL_WORDS * 32;
 static int random_min_urandom_seed = 60;
 static char sysctl_bootid[16];
@@ -2058,15 +2051,6 @@ struct ctl_table random_table[] = {
 		.proc_handler	= proc_do_entropy,
 		.data		= &input_pool.entropy_count,
 	},
-	{
-		.procname	= "read_wakeup_threshold",
-		.data		= &random_read_wakeup_bits,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_read_thresh,
-		.extra2		= &max_read_thresh,
-	},
 	{
 		.procname	= "write_wakeup_threshold",
 		.data		= &random_write_wakeup_bits,
-- 
2.21.0

