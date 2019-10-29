Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65958CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FE92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqLJV3Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfJ2Jb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:31:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ2JbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:31:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id f19so9100851pgn.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=txAPXdJ8stnijK3huaH5XUL/OJYG8SXMeJCslR1oQVM=;
        b=UqLJV3Ls1jbfBVINd2HJLoteJ8hWHMZWjc71Z+OXUxFkuCSArvO/0QALSIs/F7Q3/N
         kejkUlKOgauckWpJgXBO1IwYD2psmAOTL6VjixJNTDIShyrL/Q/pnQjfIFIWZdBkR/K0
         eIjUAKLwXJqNyBaXotoO7Nn+Uhgw9ll1PB/DNlqPcUh1ntN4t+bnoCzRHbB5i/8IeGaK
         VFQuG+E3pYfxdaoZ1/zMvwGJoDCWsMNbWwdHA36LBvkzIGw29zSzhfdRj63Nwjof5Ngd
         bDCtRoPK/bJevJOXJafB3MtyzaNSUKtx3AZZatKOaKWke93NqnToiqGJCPXoppKz8EtX
         WSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=txAPXdJ8stnijK3huaH5XUL/OJYG8SXMeJCslR1oQVM=;
        b=mxzEQAwxKfAyRV5lW2XM7LKgklzWZ3TYm1dUPsZideiJhfK7UNlBSGhT9P0AC0pw/p
         GVJiH2+rGJeLwsu1vKsdi9WwIOIfDGmP8UjMcDUiKWD9IpicZpkS43wbm+6pgLihzvAa
         95weXTPlUxk6rrJST+hkxKASQcGsNNhSjt3OT0dGUvZWtF9cYmgFZwxQqmKKP++1aSJl
         kUZxrmcUxfrzqt0t/O0oJNwQmDC39AGP9Fk5Psiy/wwv+wuUFILLp+NFoZJqraqQDlbK
         rQCadQ2PI4xyrcyjkXFCF6xRLFZ3gB8cx9XEZugmYam0vAHFAy5moSYTT+DCgHKfSHvz
         mRmg==
X-Gm-Message-State: APjAAAU3vO9YsJSszZN1VisTdXdUhO/y7i+V+7W974veIQbzkGWFr8tY
        Ldl9Sw9n5hYvzEMj75rqFCx+r/Cr++E=
X-Google-Smtp-Source: APXvYqzHggY6K7m/rToJM2IcNrRqcphD4vk4uy9oAIQxFhjSWHhjoteTYyTQBncDTeTGIfKEK9OrDg==
X-Received: by 2002:a63:540c:: with SMTP id i12mr16483754pgb.322.1572341483125;
        Tue, 29 Oct 2019 02:31:23 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-103-217.windriver.com. [147.11.103.217])
        by smtp.gmail.com with ESMTPSA id x70sm16898484pfd.132.2019.10.29.02.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 02:31:22 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] dump_stack: Avoid the livelock of the dump_lock
Date:   Tue, 29 Oct 2019 17:24:23 +0800
Message-Id: <20191029092423.17825-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, we uses the atomic_cmpxchg() to serialize the
output of the dump_stack(), but this implementation suffers the
thundering herd problem. We have observed such kind of livelock on a
Marvell cn96xx board(24 cpus) when heavily using the dump_stack() in
a kprobe handler. Actually we can use a spinlock here and leverage the
implementation of the spinlock(either ticket or queued spinlock) to
mediate such kind of livelock. Since the dump_stack() runs with the
irq disabled, so use the raw_spinlock_t to make it safe for rt kernel.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 lib/dump_stack.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..fa971f75f1e2 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -83,37 +83,35 @@ static void __dump_stack(void)
  * Architectures can override this implementation by implementing its own.
  */
 #ifdef CONFIG_SMP
-static atomic_t dump_lock = ATOMIC_INIT(-1);
+static DEFINE_RAW_SPINLOCK(dump_lock);
+static int dump_cpu = -1;
 
 asmlinkage __visible void dump_stack(void)
 {
 	unsigned long flags;
 	int was_locked;
-	int old;
 	int cpu;
 
 	/*
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-retry:
 	local_irq_save(flags);
 	cpu = smp_processor_id();
-	old = atomic_cmpxchg(&dump_lock, -1, cpu);
-	if (old == -1) {
+
+	if (READ_ONCE(dump_cpu) != cpu) {
+		raw_spin_lock(&dump_lock);
+		dump_cpu = cpu;
 		was_locked = 0;
-	} else if (old == cpu) {
+	} else
 		was_locked = 1;
-	} else {
-		local_irq_restore(flags);
-		cpu_relax();
-		goto retry;
-	}
 
 	__dump_stack();
 
-	if (!was_locked)
-		atomic_set(&dump_lock, -1);
+	if (!was_locked) {
+		dump_cpu = -1;
+		raw_spin_unlock(&dump_lock);
+	}
 
 	local_irq_restore(flags);
 }
-- 
2.14.4

