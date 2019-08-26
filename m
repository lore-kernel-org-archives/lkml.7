Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197F2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QViZPMOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfHZUOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:14:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbfHZUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:14:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id w5so28140350edl.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUhdeRpbg8gRloy4w33VnXTSeooO5sqpvDT0wx5DMzY=;
        b=QViZPMOCt4TCBDSlKAVCdrC+U37mohUaGpt7t54fKUAJnII/M30PJe3HVgsMvO32I/
         JHmsQisAEo+uwv1GVmUHudMfC1x01ExLcWbO28gdRMZiZ/4jYiOIUrGZ6L9+5vRcVnku
         F9YxwgBgX7xnEA70Wp+hl/fz9/FJFtPM7Z4dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUhdeRpbg8gRloy4w33VnXTSeooO5sqpvDT0wx5DMzY=;
        b=M4l1Ax+3+DTvfn2bx/o+hTJwZeqqfYhYnDXQBiL/2HFaPJdUdkO/kHvMxn4uNJQtBd
         dVwnH0EUWXtMGwVeubj1Z+K1goR0NesvkTlnw7dWwflFHFWlj+MwX0CdDCybeLwPTrmc
         FTJlFzDJRAKjLYO0iNF0kEaa1OS2U2SM/9QtlghRqI/PxrPI6Cfx+pATviqWcHTT9JNu
         W9w9x1aeVi89FwSUpnu/NzGjoG+++hJka3gKdI/P9wbc3lIPeyKRH8Bz3vD4cIcqMVKK
         IdTGuU/iA9a+RKdxfIBSvlB0d5EpzJuEFETUsB+Vrvzup78etFSDDBjIJnb3LtLh9UYo
         h5qw==
X-Gm-Message-State: APjAAAWHmn5AMTzfuNxLQKbzsrwN6D+8+KMIDKkabOaCkcrEGnInd9p5
        X5yEkbgPgKL1o5egD77ZiK1QZQxt8MtKoA==
X-Google-Smtp-Source: APXvYqwQX5rJn4xiT0PzmoOjk8RceDZHB/u+ViHnJA99I4EPasO1Ql6cGV43P/XDRPUyqHKPLLvlzQ==
X-Received: by 2002:aa7:c552:: with SMTP id s18mr21104247edr.0.1566850478492;
        Mon, 26 Aug 2019 13:14:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j25sm3000780ejb.49.2019.08.26.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:14:37 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5/5] mm, notifier: annotate with might_sleep()
Date:   Mon, 26 Aug 2019 22:14:25 +0200
Message-Id: <20190826201425.17547-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mmu notifiers don't exist for more processes, but could block in
interesting places, add some annotations. This should help make sure
core mm keeps up its end of the mmu notifier contract.

The checks here are outside of all notifier checks because of that.
They compile away without CONFIG_DEBUG_ATOMIC_SLEEP.

Suggested by Jason.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/mmu_notifier.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 3f9829a1f32e..8b71813417e7 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -345,6 +345,8 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
+	might_sleep();
+
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (mm_has_notifiers(range->mm)) {
 		range->flags |= MMU_NOTIFIER_RANGE_BLOCKABLE;
@@ -368,6 +370,9 @@ mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 static inline void
 mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range)
 {
+	if (mmu_notifier_range_blockable(range))
+		might_sleep();
+
 	if (mm_has_notifiers(range->mm))
 		__mmu_notifier_invalidate_range_end(range, false);
 }
-- 
2.23.0

