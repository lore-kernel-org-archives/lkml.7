Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B5C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689072173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HE+2jI9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfETVj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:39:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35065 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfETVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:39:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so26016359edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXUjiROiFGqrcZrxiXfMd6x0O70wFn+SjDBkygnZtOE=;
        b=HE+2jI9yKoWCqEtPmGEmHm4ylYNZon4lbb4PF4NHS53IZxF8pOEgpY8SO8PWwjK/yd
         Kr/K3az9UYI2fpQ8PMsRr6OEK8DOagVNchYQwPKerYeVImZ6A8MUoeqdUStHHSrf9OL7
         JAAzKQQ0avwTjuYS01lKURpWOQUYPaK/I6Hmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXUjiROiFGqrcZrxiXfMd6x0O70wFn+SjDBkygnZtOE=;
        b=J+MlbKiPt4nW/1wOg514gzorK17x9tLln92Zngyop5xX1gb2q++Oz0MMUJFqf0+SUM
         Em0ZVfSfxi+ZzR/cZX6r0iUbuAZo8D3AWS6pH5sIxzh+J4XaNJmd0eCmC9yiq0tNzCp9
         zz22mbjglHEPXmm2AraW0OD9IuuVdPlOtxS3dIicz8CXWWimWgOG4J5wF7xRwMyb0gR9
         xpLtrVzg68CNMvtpDsDhTeBRw+/F0jpNeDv+xfjQNjWTcLgQ0s83DCIBM2EnkN+6U7of
         qe0Wk2XB87/hPKSVydibb3abI9ZbkPaWZ6dgIlKa/fASXsBr3E+LVHbYz/jwv5hVUq3o
         drNg==
X-Gm-Message-State: APjAAAX/ZFPu5PQBe2ZEmxKQwqbWYojKH0nFxfZxTtbF4ddyAyolV2eS
        JpF0fjrZP19T1gRB/VYeQva1VA==
X-Google-Smtp-Source: APXvYqz2Kva8jHAMyBKyLi3aGikci686nvq4u0U8stYOPI/ZCt3pyHtCQHVoinWV1c/CI2ko59Od2g==
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr1630714ejv.116.1558388395426;
        Mon, 20 May 2019 14:39:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v27sm3285772eja.68.2019.05.20.14.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 14:39:54 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/4] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Mon, 20 May 2019 23:39:44 +0200
Message-Id: <20190520213945.17046-3-daniel.vetter@ffwll.ch>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index c05e406a7cd7..a09e737711d5 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -176,7 +176,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
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
-- 
2.20.1

