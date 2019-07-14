Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1030C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBD720896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563104187;
	bh=4l3uVT+ZIf17Tv+z3K6uY8G9BOWO9nEk+Xu/nPK1EZo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=l6Th1uh5adOUol4E4gAY/lL84lwQQ5u9QyAw+5F573OIHttwQigVA81C/54NQQgFN
	 JrghwnFKKdN40skuUG+6L5YhpfMscVgzfG2FdrQPxtt/sjFjBZs6PAMvWSgKEf8Ubl
	 EGE1kN1Zl8w4HuM2K36oq+Aspd4Ml0vj9GcSrWEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfGNLg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 07:36:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 07:36:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so12263184wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rf5iSFO1KGeSGMDdAu8Z9f2JnlMejUYjd5sd/s9I7i4=;
        b=DGY8fbzUy0ceXz4XK73bwycVAzWAWPdN1mB+qfycnoZlnXSM4VYoHUjkKsmgb9BAU0
         7w+6EuZArdli3Hzt8t3Fhk2or1bUBGV/l0g61sGJg+AGRTGB1Qz5/tqWoaqEpLnXSqOi
         /Q5qorJJ7cfVIBRhQHdCrVnueHPKrmlluXSENsPLR7BvQeYfrb67XZ3QWd+inufH90cf
         S6fP8zDVJQutHRwowg1Lwg+5Z4zMSY0Pmg2qKOUv91xcxCGwhPCYPQ0pTI6zNgt96evf
         9/Pk78c1yy3u2MineBNtR9TlxFst+Q/aavgyecWHucNEwFlIy8M89FkevAB0Jgp5OKDK
         o8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rf5iSFO1KGeSGMDdAu8Z9f2JnlMejUYjd5sd/s9I7i4=;
        b=mIAdRS4PAWa793kHdVDvwDZ5XPPxJAa/hFQsqUd3VTfiQffzVzV38Y+bwo7yLIZLpH
         Yj27glg7DaYR1oKXu+5K4Wxl5MRDqQtS8B4/+kgcriPqK4QbBEBynnVU8l0WzUwm/Bpw
         8fGCCCIjn9N+8IxLnO6fVuuF6IE2ctJWMmbi6ppqrOzWdeqIRkgXuw+nV8ibbfeQVGmX
         ssJbzdHpw2KUW0Mo1avXR9H3W5H5qnHn9MeOsKaWRDHrllylJ3y6doolXOZzskeLU8se
         lxS8k3MYBvdxOmsjIJwaRqIVT1J+SgnU0AG2WULKkRTKIUHn38Ail4ui3KDZu8WNMbux
         3c2g==
X-Gm-Message-State: APjAAAU+FOPB+KIS5hpGhBvgMCwWSD/2Biwg29qY/4XSge3aOfvHz5bi
        nSmv48stSkrK2cHzVpckh3NDggxz
X-Google-Smtp-Source: APXvYqy1YSF6YX1xN0jOwfl3xGLGLJlTuYbveVkdggE2KWvRxbrxrwTQ2YFXAHjlH18LS2/ZAkQ06A==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr19624581wmf.51.1563104183620;
        Sun, 14 Jul 2019 04:36:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c1sm27693770wrh.1.2019.07.14.04.36.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 04:36:23 -0700 (PDT)
Date:   Sun, 14 Jul 2019 13:36:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fix
Message-ID: <20190714113621.GA58788@gmail.com>
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

   # HEAD: 68d41d8c94a31dfb8233ab90b9baf41a2ed2da68 locking/lockdep: Fix lock used or unused stats error

A single fix for a locking statistics bug.

 Thanks,

	Ingo

------------------>
Yuyang Du (1):
      locking/lockdep: Fix lock used or unused stats error


 kernel/locking/lockdep_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec645d8b..65b6a1600c8f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -210,6 +210,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      nr_hardirq_read_safe = 0, nr_hardirq_read_unsafe = 0,
 		      sum_forward_deps = 0;
 
+#ifdef CONFIG_PROVE_LOCKING
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
@@ -241,12 +242,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ_READ)
 			nr_hardirq_read_unsafe++;
 
-#ifdef CONFIG_PROVE_LOCKING
 		sum_forward_deps += lockdep_count_forward_deps(class);
-#endif
 	}
 #ifdef CONFIG_DEBUG_LOCKDEP
 	DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused);
+#endif
+
 #endif
 	seq_printf(m, " lock-classes:                  %11lu [max: %lu]\n",
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
