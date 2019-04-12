Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C754FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0C320850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555070029;
	bh=BBWxqSUKvGu+zF0amZykm+yWObgNQ0w01SmKUypKihs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Kl6wGU4u1vG41iMuMppbleXSyw/uFr6O83Bua0GwjNMTdZppf43zw48PCwoB3dQHL
	 fiJ4vvfNOXS+bLPdP/nyXDPkM4FsGYSegc9bSBPvigBGgEv9UT5LOSW7keg0K4jWhi
	 uyepMZcVEEvaAw29dcW8+EVYreXZxD2xHDT/7ZG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDLLxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:53:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35292 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfDLLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:53:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so11571843wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L5OuQUeyyanltNX+zXgmPrMrzZc/xfkeda6HHF2VI+8=;
        b=FaNOFZ4xGQwiLab0Z2n8J7+3SqrDH3be5D31wRhjVRS1+GQk9ejmEPB6uByk1D6P22
         p69gFd9ne+vbDU1P3fSOk0koEfzB3+JEnH7/Iosn5imHX4vKcZS5CkWpPcA5OGciHPYX
         1CNUULw5OXHRzeiHuvQByLpwt7bTl71A4rHxDr2BlyEbs4ykns+5dWWln4rUx0IVfG2W
         9zIXeOBYXKLXQCV8MFd+CY4NMJWuhuIg2Rh5lFnkjyYYwb7ZpZQqhu6XRbUt6tGk93ij
         8nRV7P5IGU3o0vpp2Zy2W9BDmNvU0DGjdMyIF3FMjclkL2TrTBCeJFEzJjgnM/VvCTLQ
         3Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=L5OuQUeyyanltNX+zXgmPrMrzZc/xfkeda6HHF2VI+8=;
        b=O2R0dvg1TzoYNIAWqvelrtFSQqaFrOmMdnYitysDKTQZPJ+Ng/4gnOm6eyTS/OEQof
         cbswbcUwKJ3aQc+kGJC3pqqBOjApkbSxgTWTE5u18u7hjpjf9pZw0tS89qO3+9yQsltq
         UWzpmd22JkWEwfp2qSN9o/zG8fcnzdY8clrRTU8b5zxJWTJY6/So+klBA2+HBtOW7pwW
         wkMCUgYgJJeniw59GQovc1YUNOEYIw3fQxoKwv2i/wUnFKXpUi0i5/rCgfLYIYb7OQgR
         wVeWBRa8r9yabH3zH4rZv7Cse6WhQm5fuO7VQjuYDnwBpXgoEe9l/bP8adf6mE/jac29
         9+mg==
X-Gm-Message-State: APjAAAW7N5bOuO2JaaX1up6idh3PEiq0wNyxgMa+uzTougT+QZIb0kap
        THepL4XLF3eBClVwvB2W2/w=
X-Google-Smtp-Source: APXvYqyPVCuxK7z0v7SvIrMW6hxOzlW7TXZMWcPSchQzmbgjMZ0OSjjmF92OnTDvejjR7qnM5jWk5g==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr7503516wrp.197.1555070026141;
        Fri, 12 Apr 2019 04:53:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q17sm33686717wrw.70.2019.04.12.04.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 04:53:45 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:53:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fix
Message-ID: <20190412115343.GA125948@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 90c1cba2b3b3851c151229f61801919b2904d437 locking/lockdep: Zap lock classes even with lock debugging disabled

Fixes a crash when accessing /proc/lockdep.

 Thanks,

	Ingo

------------------>
Bart Van Assche (1):
      locking/lockdep: Zap lock classes even with lock debugging disabled


 kernel/locking/lockdep.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..e16766ff184b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4689,8 +4689,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4702,8 +4702,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
@@ -4744,21 +4744,17 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
-	int locked;
 
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	locked = graph_lock();
-	if (!locked)
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4911,9 +4907,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4925,8 +4920,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
