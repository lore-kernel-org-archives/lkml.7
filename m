Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26461C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED58F23AC7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H3IaTIIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfHTITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:19:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33394 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfHTITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:19:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id s15so5349726edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRs5HpBA3qSqFe5qnt1LL6h0B7I2hzSM+r7A2DpfdeU=;
        b=H3IaTIIKcnZxd8XaCn8QCH9mcrNGjOx/ak2ybd66H0ki331clYHFNQzkO0bKWcuXsr
         Mq6+jU/jrdI7HQWeHyhaTDSfFkUDTPsmPa++H2SDWnl1ZAvHNh4YpUIn825O4i0/plh8
         z09eHCYqJKERfRBDZg/Pr+cpNjod1qv2vMJ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRs5HpBA3qSqFe5qnt1LL6h0B7I2hzSM+r7A2DpfdeU=;
        b=DjL3cxSFzyAS9ww6tiZ0CMWuzbzP3r3nvMbPL223Ma+hw3ZYWsl+2+b1Ou3PMllYjh
         aD8GdsGBbIsA6lteqnLPW6KN2I59nuRfYQ7k5fsYdX4T2tRTSWr2Uk7cuPQ9fKpWNqrZ
         x4hbrwBzSXunZKewMCUOfa9su0dIc+jE0NwyS1qhVuntzUvGIyh0wNSEZ6wsYCkkLbaA
         77FUcGW9sVI/etH3h6Llm3U6m/uM2t4VSB/VUe8X5U12dW0E7o2llFgANrtP+a8KI6bT
         xP9Dpm1Rokaaim6NCgG48jOiVBJDxE48Nxz3G69CNgH+aE5r9tEtmMJBWkrZo4T6OF8y
         pj/g==
X-Gm-Message-State: APjAAAXW4Hc9IydreQRGPOsD273iTsbnJEx93SxPWNUsVE1ArBJ+srIs
        tAVTR481jgAqoPVLp2QFvCkgD2drm1oB2A==
X-Google-Smtp-Source: APXvYqzwk/VVcEGb/uEJb+MjHFqWnLqThVvSK3PFeDiC0L0cxhC/+XJhzn783w4kD3r5dKVWby8hcQ==
X-Received: by 2002:aa7:c498:: with SMTP id m24mr12784881edq.277.1566289150887;
        Tue, 20 Aug 2019 01:19:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id fj15sm2469623ejb.78.2019.08.20.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:10 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
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
Subject: [PATCH 2/4] mm, notifier: Prime lockdep
Date:   Tue, 20 Aug 2019 10:19:00 +0200
Message-Id: <20190820081902.24815-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
References: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to teach lockdep that mmu notifiers can be called from direct
reclaim paths, since on many CI systems load might never reach that
level (e.g. when just running fuzzer or small functional tests).

Motivated by a discussion with Jason.

I've put the annotation into mmu_notifier_register since only when we
have mmu notifiers registered is there any point in teaching lockdep
about them. Also, we already have a kmalloc(, GFP_KERNEL), so this is
safe.

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
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index d12e3079e7a4..538d3bb87f9b 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -256,6 +256,13 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
 
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		fs_reclaim_acquire(GFP_KERNEL);
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+		fs_reclaim_release(GFP_KERNEL);
+	}
+
 	ret = -ENOMEM;
 	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
 	if (unlikely(!mmu_notifier_mm))
-- 
2.23.0.rc1

