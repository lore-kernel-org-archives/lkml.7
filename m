Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF63C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1604216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dtTpZc1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfHNUUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:20:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33886 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfHNUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:20:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so385352edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5KwhaOsa05mLs5dKsxyaJ8nPNTkq9L0E7PVwxBUg2k=;
        b=dtTpZc1TP3phfJWfjZ0TTcGZDEkgZeTx7+tiSVp14czRexPyqDM1gnaVtyCL269PpM
         uyr+QykzpH67/lUTpJRJ4qgJstssFYUgdSFMP71ckMZGGA6c+b2mIUyn+RNlKV5QMWnf
         BWavURm9nkk5uzc5rKnkwSgXxYm3JJg1jMKeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5KwhaOsa05mLs5dKsxyaJ8nPNTkq9L0E7PVwxBUg2k=;
        b=hYA+jhMCu3PXKjjlBYBhUg5E5RgR4LT1UzY+3gFQyjfr/x/FS9c/ylAPkLalFAxwIH
         NtgpzQ35+2OccQZv8thrKI58bP9yDm9KtB28RXiHpY65fPgLDQWuketR27nuWdx2M1Fl
         CwbrAwVG7YoRm5h0sOpQZmerEW6yEdede7KCKom1ppdduOMvI+PuOzDcwtVwpH5Imp/W
         Ds08wvD3QU0wd/iM/1Tl1g7CHUa6T4+AtEqnNciGyBNMyqAlNHQGXIws13krbcLO160p
         gatD/MGo1l4JxcrOtUi5bMg3GS2JXhR67H30ehsObQzNNV3gWx9eG5rsMnW3UaFShBCz
         Oc8A==
X-Gm-Message-State: APjAAAWxM0p6mH0tOVnsnI5cx34GY4DacWBD/hHhOJOj+CqndVfD8XXQ
        3ZFK+aVEQZvpu9iaJYyBxbua1gLiYYtRoA==
X-Google-Smtp-Source: APXvYqwr2QYX0Cwtm9mM9vEmD8lUn0css8IRklo25E0smQh544dGM+PTj5A8hH3aTQAPYL0Qh4N4uw==
X-Received: by 2002:a17:907:390:: with SMTP id ss16mr1324369ejb.46.1565814039028;
        Wed, 14 Aug 2019 13:20:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ns22sm84342ejb.9.2019.08.14.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:20:38 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4/5] mm, notifier: Add a lockdep map for invalidate_range_start
Date:   Wed, 14 Aug 2019 22:20:26 +0200
Message-Id: <20190814202027.18735-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
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

Cc: Jason Gunthorpe <jgg@ziepe.ca>
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
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
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
index 43a76d030164..331e43ce6f3c 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -21,6 +21,13 @@
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
2.22.0

