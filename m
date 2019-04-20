Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB2C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B56C208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555745424;
	bh=nMvh+OhOYCusCUAq3Ux5BqPzfIKsjhoCXwXi5+nqGMc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=E0vQGl8LyKZryqLoQ9tHcN3FPohhp9D7eCuoM7B7a8O54icH1hhZyWkyR7eZwbIRQ
	 pSOkuZwLdkrejACzMEhlXhFhup6OKio1i1/GhheC31RoSJmlDjEC8YMSCsfj3PNxRQ
	 +S/72hQd9NVfq5nYkcip9VvtEqYDTClCG6CyrCC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfDTHaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:30:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38162 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:30:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id f14so8759428wrj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TEyICMFhYvLpm0mr+NlkDcisIgmEMBnliccFB6MuaFw=;
        b=MERiTzr8F1DEM2kyI7bavXHnxaGrD84p9ITrjaRzvVp97lRo4u7Cbtchm0BOrXVVxw
         Diw9Hp5OneWF+K93SX6UTBGbhv+mhJXkAgwNwPtXaBBw7oPc508UP+ZysY8Cmo4nmTMg
         iMLZpttus53WtbxMCgbEb2ufiLCjh228JaNXxU97Ptt2W5TIijS3QhURsW01Oz7R+yRx
         ifkgXEEi+/92wtbknIQNe65+17OwOEs/y+VcYoA7QOnB24bUZUw+JwgEfWlZj4atkIIe
         VRS15/8pk+FlO5PfdwKS12nKwG3Ub4ioO2EAXMm4TmHHDVpetfuLSAkkQfUuUDZszfCj
         OceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=TEyICMFhYvLpm0mr+NlkDcisIgmEMBnliccFB6MuaFw=;
        b=XoQ/pBfk/kc8JPcHH/P5ctqOxmeOwDTgWlhFDSBYCJMq/gfpHMwh+XgHTblp6QKx4f
         amvJnL8Er/w1vPK2tF8U7YBcAG13+pn6WqgcC+3WRyWGqgA3iIFt7KWb4WNVtOanyQcs
         Aiq6xxJdlDhD0hfBArhsyeDdI+5fW8kTKQBOcg6QjFuajsmWkUDC45P4gxWKS/v1c1tU
         UOihV/3DydxrR+Gu+cUXiJxkQ4dwsr6E1YjGOpQUIiroDDRxaaUyVyvH93g60PpMNjbr
         W/anICdkohfSDWFDT1coCwaqc+uBC+LWEFZ019w0ZBR8MfF5PnmYvfjR7q7gR63fTN30
         DWdg==
X-Gm-Message-State: APjAAAVFlzQtfY/00vneyDlAWqvmpUKGDoQwqrm1A/Ec2WDONJdMsBm9
        fixPiEq5f6WY1GHpYKScJ64GfgZT
X-Google-Smtp-Source: APXvYqyjXQzpQQ0ojH7L2++S84YEx6pEFoeHHgiB/haZgpHzbEYUTfo8L63BbQFtYhq/O9YcbRmkcg==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr5629354wrp.268.1555745420898;
        Sat, 20 Apr 2019 00:30:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j11sm7427951wrw.85.2019.04.20.00.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:30:20 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:30:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] locking fixes
Message-ID: <20190420073018.GA127076@gmail.com>
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

   # HEAD: b50776ae011cfd26df3cc2b4af8b2dc3b683e553 locking/atomics: Don't assume that scripts are executable

A lockdep warning fix and a script execution fix when atomics are 
generated.

 Thanks,

	Ingo

------------------>
Andrew Morton (1):
      locking/atomics: Don't assume that scripts are executable

Bart Van Assche (1):
      locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again


 kernel/locking/lockdep.c      | 9 +++++----
 scripts/atomic/gen-atomics.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e16766ff184b..e221be724fe8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4907,8 +4907,9 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	if (!graph_lock())
+		goto out_irq;
+
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4920,8 +4921,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
-	arch_spin_unlock(&lockdep_lock);
+	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 27400b0cd732..000dc6437893 100644
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -13,7 +13,7 @@ gen-atomic-long.sh              asm-generic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
 while read script header; do
-	${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
+	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
 	HASH="$(sha1sum ${LINUXDIR}/include/${header})"
 	HASH="${HASH%% *}"
 	printf "// %s\n" "${HASH}" >> ${LINUXDIR}/include/${header}
