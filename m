Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF66C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C257323AC7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="k0TQLN1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfHTITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:19:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbfHTITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:19:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so2377463edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZjzrRlZLlBFvOCMrk8fj5ec19AHD7NWtYEFTJfXwxg=;
        b=k0TQLN1Nox1/M2ISzbAc4zHTlgcsKT0BXPGsZZPpOBqREaDXPeFdyc1XMaGAKvIGx9
         QxjK/4tpciokI/Wa88F954/rhr+3602xdbDv1jh7RSBhbC+T9zEzICLRcmUaOI2umUXJ
         dsXauR/20FNGp0zT6Wb3KfuJRD0AlIWDKNULA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZjzrRlZLlBFvOCMrk8fj5ec19AHD7NWtYEFTJfXwxg=;
        b=mkzhQxdTCyEntjyNncKF93Po5mRWED85VQUFcRKeAe+CAxUWMLW1/yZWbRKp83Eh9a
         c429sOccJdOEQnPCLfaWeuIuVUOomDWqWuAXfaS1qogefBCGUYkNg6eDQ1cPJPVffn7i
         7W4Q6EYUaQROX7TF5vMO56WW+K9yj7vNnOyY8QON5HF9DU9YVykQpFqh6BsTyqohpVoq
         zx5Iu+TECZLPKHMIsh0xRoVldygvaYm0u2Mm2vXzl21J9MKLjB8mvZ5JKD48ZWYTxPgD
         oKkdTSZETkOckrT5KOvxeYyIMoo2udzUALivq8uvwlYK9vpgPIAIJCLwsk0F8lJO449q
         PAQA==
X-Gm-Message-State: APjAAAUJm9T/53j0NtW+ATcnZNCkFfvYtg3OVoRxdi7HeV2dUVfpFWOv
        PA/EXOH7UDxHnbNl3RQFBaj2K5FAQN781w==
X-Google-Smtp-Source: APXvYqwpUTAeK0tqJjN6py6Pg1Ep5nMFRaQeoDTkIIz0n/eBEVwxM4rYPXYBIaOECS38AYG5tsgjYg==
X-Received: by 2002:a17:906:f2d0:: with SMTP id gz16mr24236150ejb.21.1566289153507;
        Tue, 20 Aug 2019 01:19:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id fj15sm2469623ejb.78.2019.08.20.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:12 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
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
Subject: [PATCH 4/4] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Tue, 20 Aug 2019 10:19:02 +0200
Message-Id: <20190820081902.24815-5-daniel.vetter@ffwll.ch>
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
index 538d3bb87f9b..856636d06ee0 100644
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
-- 
2.23.0.rc1

