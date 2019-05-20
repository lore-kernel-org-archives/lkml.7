Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C40C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A729D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HKq8Duys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfETVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:39:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36726 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:39:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so26000833edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DucpRdkRgOoCBrOy6KiJUJJfWEr/7+ZCIIaJ4AvhfB0=;
        b=HKq8DuysKW6hx7l8Yig0NV9UpMzIOK98ALTyHYlWExOE6Pc4XsceN9CwZTMEZ+y6cw
         Cotb3dp0LmPi/TnfsGu9Mc8wGpsj9yCkmJXIekv1AWGWZdRazvo+2R7pulay1RKnKq5x
         V5EN38iDPb1UvcB2ERZ4RtefPoEDwb5qTXLcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DucpRdkRgOoCBrOy6KiJUJJfWEr/7+ZCIIaJ4AvhfB0=;
        b=RM4w8HhJxQORjhX3kk86iwaZQhxkGjgRnHuHwZvolMKBS8krNwkmuLIV4/ZI5/0B7l
         UfTp9qcpJBh20SuOG2PG1tuK1/rE7RSuhUqzCOyBba8HV/FemT8wQScFJNeYV4M3HI7j
         2P5/CMzYEu4045n1NmaJ0BZ22UOQtyHgV/snQ2w61nhJdKJgero3SXKmwftp7YIJyHCf
         kSefQSINgdkCw3XYmPUmzN/et06DI9giY0bPCcvqJ4xGd6zuRWsi5JUF3XKHyxBNe3PX
         ++M+IHglfP9SM84npR8IY9e0AHplV4nEZszbRGDVsrqKOLLm1Vv9TlWeD/y1LcOxPq9N
         hMDw==
X-Gm-Message-State: APjAAAXfnu0eB8cGkCd/j2W09+4WOrrcHjVlAFaqx0qHptvHZuYvfSDg
        WUYKz4Jdi9TpM9xevzGBaON8OA==
X-Google-Smtp-Source: APXvYqzzZ2kpVp8haHdbToY3y03B93IZ2fARLhOO1vyR6C1AaG3mgxQcALaUAvLZsqLVYAWfP3KDjg==
X-Received: by 2002:a50:b865:: with SMTP id k34mr79563563ede.16.1558388391895;
        Mon, 20 May 2019 14:39:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v27sm3285772eja.68.2019.05.20.14.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 14:39:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to fail
Date:   Mon, 20 May 2019 23:39:42 +0200
Message-Id: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ee36068077b6..c05e406a7cd7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -181,6 +181,9 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 					mn->ops->invalidate_range_start, _ret,
 					!mmu_notifier_range_blockable(range) ? "non-" : "");
+				if (!mmu_notifier_range_blockable(range))
+					pr_warn("%pS callback failure not allowed\n",
+						mn->ops->invalidate_range_start);
 				ret = _ret;
 			}
 		}
-- 
2.20.1

