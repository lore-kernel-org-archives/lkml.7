Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C86C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C052186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eqf/zxHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfHZUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:14:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33859 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbfHZUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:14:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so28185129edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bew81wZtU1Y0ks/RIjoWK2FqRSw2UObINLTLlREzuuI=;
        b=eqf/zxHzmkxFzdusChJdtOxtD1T//2StyL+3IeJkwUOueNAgekF2+ClgnH/jmo0xK7
         qr4GW3Irit/IupsG1Na0ULH20pR7piGumm9IQOHaYtrHyUARGCU3fZukTvNoWL+1YqKl
         pT4WlAHyRMSIzeLbFjs0YtZDoFJZPwP/EgQ5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bew81wZtU1Y0ks/RIjoWK2FqRSw2UObINLTLlREzuuI=;
        b=oZHuZb3I08VEbm1HlurGe5aFQji7jl0Wx7dlk/KqoC6dZWqL6j+r3p5IuTW9B/i0Pf
         6MDwyKacVGOtQ30rpTNq0p/W/aoxpYoBjeRnpFJap3wqiwlF3/1jhf+JQNouhQBqR7Kn
         zNYyg6ZGi5gCtEEXNIILrUtSUV0kCE0OmSaWNIOvDiyblWwMSTI4bTaoULR+8DrXZ8fO
         twnHUOB2H3ohXUGK0gKZ6oL1sYxz7vwL5qMnDPMPydRa4cyPm78oIbmVtz+FJVemxJLp
         NMMjEDCzvmlMFvo1YKIDqoCZnzv7VKUtXGfdSpeJHpB9Bsp48A6sjF7E4WWq058T+IIZ
         CKMQ==
X-Gm-Message-State: APjAAAXGEZZCegp9BurDrLUa8BoAGIQ2K/qoYYJH6pGPsdVoWrmDnqaE
        ZFwqqVqxf6mr8/ayuBnyGKmAIhzYzvCqMg==
X-Google-Smtp-Source: APXvYqw8z9afSvhgONVa7l2XkwoZjbx6t7Y2tVjSzj6EiE5l88NiQj8YRIrJNGWJ+8ua4BQqqD4zVA==
X-Received: by 2002:a17:907:207a:: with SMTP id qp26mr18160870ejb.12.1566850477119;
        Mon, 26 Aug 2019 13:14:37 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j25sm3000780ejb.49.2019.08.26.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:14:36 -0700 (PDT)
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
Subject: [PATCH 4/5] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Mon, 26 Aug 2019 22:14:24 +0200
Message-Id: <20190826201425.17547-5-daniel.vetter@ffwll.ch>
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

We need to make sure implementations don't cheat and don't have a
possible schedule/blocking point deeply burried where review can't
catch it.

I'm not sure whether this is the best way to make sure all the
might_sleep() callsites trigger, and it's a bit ugly in the code flow.
But it gets the job done.

Inspired by an i915 patch series which did exactly that, because the
rules haven't been entirely clear to us.

v2: Use the shiny new non_block_start/end annotations instead of
abusing preempt_disable/enable.

v3: Rebase on top of Glisse's arg rework.

v4: Rebase on top of more Glisse rework.

v5: Also annotate invalidate_range_end in the same style. I hope I got
Jason's request for this right.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Reviewed-by: Christian König <christian.koenig@amd.com> (v1)
Reviewed-by: Jérôme Glisse <jglisse@redhat.com> (v4)
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 0523555933c9..b17f3fd3779b 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -181,7 +181,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
 		if (mn->ops->invalidate_range_start) {
-			int _ret = mn->ops->invalidate_range_start(mn, range);
+			int _ret;
+
+			if (!mmu_notifier_range_blockable(range))
+				non_block_start();
+			_ret = mn->ops->invalidate_range_start(mn, range);
+			if (!mmu_notifier_range_blockable(range))
+				non_block_end();
 			if (_ret) {
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 					mn->ops->invalidate_range_start, _ret,
@@ -224,8 +230,13 @@ void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 			mn->ops->invalidate_range(mn, range->mm,
 						  range->start,
 						  range->end);
-		if (mn->ops->invalidate_range_end)
+		if (mn->ops->invalidate_range_end) {
+			if (!mmu_notifier_range_blockable(range))
+				non_block_start();
 			mn->ops->invalidate_range_end(mn, range);
+			if (!mmu_notifier_range_blockable(range))
+				non_block_end();
+		}
 	}
 	srcu_read_unlock(&srcu, id);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-- 
2.23.0

