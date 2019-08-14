Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C094C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD621721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B5pmU59y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfHNUUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:20:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46642 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfHNUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:20:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id z51so323567edz.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGoYUnhBV7TeB+3l4wceLC9ZPh9ISIJNJOmyRzHIbHM=;
        b=B5pmU59ycnYBpryQhhG1Z3DbeM8Nqe5M8v1SwTte2yz8M8LB54A/UjWXYoWpYTn2Uv
         5wXLGfAUtYZN5x4CsUBfceRVwXq/4IjhgUmLTFyUKguhiSbuw71qyrATlnjMjT5+NMfu
         Y1nD5IwF07+NuCcwz0U1msvMGB0mJkgxThOFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGoYUnhBV7TeB+3l4wceLC9ZPh9ISIJNJOmyRzHIbHM=;
        b=KY4BaOakB/2SNROMXZm0OA+Hw9n6+EIeECzTYvfeYQv8mhlKL83N6Qtn0sjD9xg67S
         b7fZRDyrVDLRnPqOOHipKHLzNxvQBNV4I+/7oxH202UwfU19qpFdzD8Hnl8Jpjnd74SC
         cbp7y3kaX0qZ05QiHozro1KqOcQOw5V2qY2aq90aQATvIpomd10ERpQm4fdA34fnGeAt
         8nvbZ8+y1JyrPispMx/80ifeI5gZMiJjxH98Clrzs5K3hczpZZha9ax4W4GekqzSpxFl
         6wQM1Ljq8MgTJ/MpYirKNsfYr7BvmkvniOOptPBSFsQXAbIKa8UCTyqchUOEhIEv2UVg
         d5KQ==
X-Gm-Message-State: APjAAAW0um5zMZGqC+ZnTbhegMUrjayRcUqb+Yo3MeENTBdZWxxBYuOR
        EPGQRcwsoy0Abue61Zd6Nlw8SnCt+6tFRQ==
X-Google-Smtp-Source: APXvYqwaJ7x0tLnRLHwbItm2wgIoNWmNw2/2hrhii9cO7U6X/gWZx95a1UP7+c/DHPfmXSg1sNEoMQ==
X-Received: by 2002:a17:906:1e85:: with SMTP id e5mr1324797ejj.200.1565814035124;
        Wed, 14 Aug 2019 13:20:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ns22sm84342ejb.9.2019.08.14.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:20:34 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/5] mm: Check if mmu notifier callbacks are allowed to fail
Date:   Wed, 14 Aug 2019 22:20:23 +0200
Message-Id: <20190814202027.18735-2-daniel.vetter@ffwll.ch>
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

Just a bit of paranoia, since if we start pushing this deep into
callchains it's hard to spot all places where an mmu notifier
implementation might fail when it's not allowed to.

Inspired by some confusion we had discussing i915 mmu notifiers and
whether we could use the newly-introduced return value to handle some
corner cases. Until we realized that these are only for when a task
has been killed by the oom reaper.

An alternative approach would be to split the callback into two
versions, one with the int return value, and the other with void
return value like in older kernels. But that's a lot more churn for
fairly little gain I think.

Summary from the m-l discussion on why we want something at warning
level: This allows automated tooling in CI to catch bugs without
humans having to look at everything. If we just upgrade the existing
pr_info to a pr_warn, then we'll have false positives. And as-is, no
one will ever spot the problem since it's lost in the massive amounts
of overall dmesg noise.

v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
the problematic case (Michal Hocko).

v3: Rebase on top of Glisse's arg rework.

v4: More rebase on top of Glisse reworking everything.

v5: Fixup rebase damage and also catch failures != EAGAIN for
!blockable (Jason). Also go back to WARN_ON as requested by Jason, so
automatic checkers can easily catch bugs by setting panic_on_warn.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index b5670620aea0..16f1cbc775d0 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -179,6 +179,8 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 					mn->ops->invalidate_range_start, _ret,
 					!mmu_notifier_range_blockable(range) ? "non-" : "");
+				WARN_ON(mmu_notifier_range_blockable(range) ||
+					ret != -EAGAIN);
 				ret = _ret;
 			}
 		}
-- 
2.22.0

