Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1CEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B072173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lD66uZtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfETVj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:39:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44999 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfETVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:39:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so25925908edm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWxZTOU32QqeCUWxSxBPbL225yVTtI+hlaFCbsgM9zc=;
        b=lD66uZtMoIMvvSsmt5W9Ap+FV3+sBqSE3BFc0cEJ684d/bm9E2HP1JXq7mSRH9YW4v
         nkbstF3kFQkxqWWqyv6BlV3/MFaD+qTRyQzGtP0efOBVs1Kb0ZlKW4eRerQFHNS9iDrt
         TmWczlsEj0ymWwKCv4nAMDK83tVqOnaVQm3Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWxZTOU32QqeCUWxSxBPbL225yVTtI+hlaFCbsgM9zc=;
        b=V7CH3OEV4+OQ/fKHzoOOOXLurONjSDF/tqVV8Y0s8v/ilmi+NrC0LtpA4MrH9liBIm
         yYThYHx+yl/z3OUvKP9uMSNYukyu1MqPuyJPtn1kkFwnLxLxaEl/d40JiOY4Mmi5dQWC
         sSzM8uUz3PXWQMfKjIVluhSAdKAkl6wTos39yIQjButaM2VKSNTL+kRfUu8SRUb613NU
         plypvUivB9CxccFFubAwIGnymAfSrT8YRCjxAhIhW3qzYWpGF4xdsk3/InStEDMtmSBv
         3BxP4/x77dbpUdZ6QJdKC83PCTrqdrmw8w9YyVEeYQDuAzrgiASiitg6q2saqdQn1TdH
         7RgQ==
X-Gm-Message-State: APjAAAXwJrAuKfxD/9nIfGKktR6v5qvgar314Z4jMGjFsoektiM5Fck/
        GeY+pPuXCIHq2UL3iIi5JjsJiA==
X-Google-Smtp-Source: APXvYqx80jEeRT18HZXVIF2BoTYuZwcSTE9+LxH0PFGQif7m2Gu96O3Mba57kRuyzhiZzeoU6L992A==
X-Received: by 2002:a17:906:5390:: with SMTP id g16mr53949638ejo.12.1558388396676;
        Mon, 20 May 2019 14:39:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v27sm3285772eja.68.2019.05.20.14.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 14:39:56 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4/4] mm, notifier: Add a lockdep map for invalidate_range_start
Date:   Mon, 20 May 2019 23:39:45 +0200
Message-Id: <20190520213945.17046-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a similar idea to the fs_reclaim fake lockdep lock. It's
fairly easy to provoke a specific notifier to be run on a specific
range: Just prep it, and then munmap() it.

A bit harder, but still doable, is to provoke the mmu notifiers for
all the various callchains that might lead to them. But both at the
same time is really hard to reliable hit, especially when you want to
exercise paths like direct reclaim or compaction, where it's not
easy to control what exactly will be unmapped.

By introducing a lockdep map to tie them all together we allow lockdep
to see a lot more dependencies, without having to actually hit them
in a single challchain while testing.

Aside: Since I typed this to test i915 mmu notifiers I've only rolled
this out for the invaliate_range_start callback. If there's
interest, we should probably roll this out to all of them. But my
undestanding of core mm is seriously lacking, and I'm not clear on
whether we need a lockdep map for each callback, or whether some can
be shared.

v2: Use lock_map_acquire/release() like fs_reclaim, to avoid confusion
with this being a real mutex (Chris Wilson).

v3: Rebase on top of Glisse's arg rework.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/mmu_notifier.h | 6 ++++++
 mm/mmu_notifier.c            | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b6c004bd9f6a..9dd38c32fc53 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -42,6 +42,10 @@ enum mmu_notifier_event {
 
 #ifdef CONFIG_MMU_NOTIFIER
 
+#ifdef CONFIG_LOCKDEP
+extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
+#endif
+
 /*
  * The mmu notifier_mm structure is allocated and installed in
  * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
@@ -310,10 +314,12 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (mm_has_notifiers(range->mm)) {
 		range->flags |= MMU_NOTIFIER_RANGE_BLOCKABLE;
 		__mmu_notifier_invalidate_range_start(range);
 	}
+	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
 static inline int
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a09e737711d5..33bdaddfb9b1 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -23,6 +23,13 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
+#ifdef CONFIG_LOCKDEP
+struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
+	.name = "mmu_notifier_invalidate_range_start"
+};
+EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start_map);
+#endif
+
 /*
  * This function allows mmu_notifier::release callback to delay a call to
  * a function that will free appropriate resources. The function must be
-- 
2.20.1

