Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25941216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QQneGltV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfHNUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:20:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38821 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfHNUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:20:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so363924edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDjwUmcwSXAq578UY4c9Vj0FS6SCgLfjeiZG1PLwBhc=;
        b=QQneGltVZyDVKndymgf/V07Lz/mVu4xKZlufq/IsuBlC5+1QN4bp7NWpobW8CC1rIF
         qIF8ZHgfa3ZzNQCa9U+7EASFdi6fg9QrXsipXLij2jwCn91t6FCHDSnO4dCluu2ktfVm
         26tp0nC+Bvb3QHNr2PBbwL8HmhMnTo4N7ChVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDjwUmcwSXAq578UY4c9Vj0FS6SCgLfjeiZG1PLwBhc=;
        b=XpTWyUoqycsdM/AHaBZopF07WJscY9jdJMo2J0B8Wo8JJfa0WMt5C4CEx2e4UBJoPh
         ygGRhpVk1eRgreT4hduirnPdxw9OrNr6U+4RS1bvAIew6QbLzEJDQNFDZyHVzSkx38W1
         CoAH7cyqBhOgZPtgDbbe3pL0MJzkqu3iCyGfLgk28sju5M3DUHcosluuHtZkv0VzuC2f
         X9qhHsIPfmquVDfMZI1PqVic6ET1HSalExACVCTVdAlZxCK4iRbkH3ueSka9Ib672fM6
         jCkIwMvbcYAawlfNqqtkjnR/RC91sBflvGUw0LZuprCMOD/mejrAIEBOjl0NaTxpspo1
         mD9Q==
X-Gm-Message-State: APjAAAV4io5NlqcdnRoH9wTgkJPu5ABYX00dIvVDQg76I5FWqN1+8guO
        v1wHv8ZK2zoQsd5jxLiF5/5tNJozO3neWA==
X-Google-Smtp-Source: APXvYqzQoXvD/5/BVfPi68WzUkMpSm1CHWB0tkEH2JnEfPgw2NOD1Bv5GUgUamH3qvvNe7OEQP+Ihw==
X-Received: by 2002:a17:906:81cb:: with SMTP id e11mr1305807ejx.37.1565814037763;
        Wed, 14 Aug 2019 13:20:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ns22sm84342ejb.9.2019.08.14.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:20:37 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/5] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Wed, 14 Aug 2019 22:20:25 +0200
Message-Id: <20190814202027.18735-4-daniel.vetter@ffwll.ch>
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

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 16f1cbc775d0..43a76d030164 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -174,7 +174,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
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
2.22.0

