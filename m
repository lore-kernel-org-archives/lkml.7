Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68052C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5D20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577089292;
	bh=CI4damfoVOqesRhxTqcMsarysNXofJvnDHFVbybcD04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qoX3UqWhvvWwApMXJn/JYPIVAg3qwig+GFlQr8vTnxEqv59y37d08yuj0gQ0jtZ5I
	 JjU9iErxIiy7rgn5RK9ke0wRJDi8F/HK2hjPMS6HOmfTrdzaaYxENCqi30tX+9ZLhQ
	 bZIVz2fj26Cw8EvBdoY0Cnn0TakDTF/TykspvfYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLWIVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfLWIV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:26 -0500
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455C520709;
        Mon, 23 Dec 2019 08:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577089285;
        bh=CI4damfoVOqesRhxTqcMsarysNXofJvnDHFVbybcD04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRMHerIt/URp/OzCxUrh2EDmUXemsUcaWIUOiiLH1WpdG/7lAOapzpbXBzzY4aYtS
         MOyp2ktirqjyJhppwNO9pcU185y5CBgikxH83s5ZFqV22jH7Lw22EZEEbQeFT2+h3t
         Y+uVEnCc3byuX6CRprvEp0rJykeo6zISXtRdFXeg=
From:   Andy Lutomirski <luto@kernel.org>
To:     Ted Ts'o <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 8/8] random: Remove kernel.random.read_wakeup_threshold
Date:   Mon, 23 Dec 2019 00:20:51 -0800
Message-Id: <a74ed2cf0b5a5451428a246a9239f5bc4e29358f.1577088521.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
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
index 920bf771e3e1..2a6818cae2d6 100644
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
@@ -2053,8 +2047,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 
 #include <linux/sysctl.h>
 
-static int min_read_thresh = 8, min_write_thresh;
-static int max_read_thresh = OUTPUT_POOL_WORDS * 32;
+static int min_write_thresh;
 static int max_write_thresh = INPUT_POOL_WORDS * 32;
 static int random_min_urandom_seed = 60;
 static char sysctl_bootid[16];
@@ -2129,15 +2122,6 @@ struct ctl_table random_table[] = {
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
2.23.0

