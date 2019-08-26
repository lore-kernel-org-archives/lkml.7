Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA52186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jWs+/c0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbfHZUO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:14:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44235 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbfHZUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:14:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id a21so28152545edt.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43MMkU2nAs7jtnMnw+TAIk5AMkJWGIqIB3w6SHg2dOA=;
        b=jWs+/c0l0gQqLqnonUguMXmcEgRnSUc9uFPRnBjVNs1Nfg/BKnOJH3T6iKhSC9eb6q
         dpAfCEkDXZ40OJ02lIV0O9i7OYhqlEmJrKDApByW1yfFG3TBOGtD29nnDadAmOX0w/3a
         ohtG4NM02aYnLMkZ4fScN1kWA5UKzPn2mVZA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43MMkU2nAs7jtnMnw+TAIk5AMkJWGIqIB3w6SHg2dOA=;
        b=RpoTu2+Nt+TItN7ERd2EdI2joAkobYi76cNXHFpb/5zpE2PERIUVDpDQrJ1zW1kw/8
         saRxl8XqfuRixDlxWa2kbh15rNrHmYg+4ytcnwTbqCtML5IlX684429oMjK4JdNAgEgQ
         OXa+vgJWKHiSIylFWitW7J9Qs5UUDRg+Bao4KU3mn3jPxf6bfkFzgUSvaEH3CfJ3hR6t
         dLn+rzVGE4hNTVFiDS/1cOKfQdI8+j167KJ9FtAbjfOkNTZZ2C5+HzlAzfi6kn8WSwIv
         KL5Xg2mo4K6+X/aTGtmWcLudz6SeTVVv13lw+GkZJRo5Beek1NQ6wNbjxzRkuScbdIW5
         1sXg==
X-Gm-Message-State: APjAAAUAuKqeFfm65QQziHOUWK/x+PhX7jSMK9DeUL5nfYEF+oqa/hfp
        r5tX1GEruZbAeh9RerLorL/f2m4xsa3XYA==
X-Google-Smtp-Source: APXvYqz1alL5dlGwBBuOouoL2tngfggzrmMx20gafiZ6V+aQeNinylzwLOpzJO1HhOF4TDXl6u3nsA==
X-Received: by 2002:a50:d0cc:: with SMTP id g12mr19859322edf.201.1566850474445;
        Mon, 26 Aug 2019 13:14:34 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j25sm3000780ejb.49.2019.08.26.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:14:33 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 2/5] mm, notifier: Prime lockdep
Date:   Mon, 26 Aug 2019 22:14:22 +0200
Message-Id: <20190826201425.17547-3-daniel.vetter@ffwll.ch>
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
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index d48d3b2abd68..0523555933c9 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -259,6 +259,13 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		fs_reclaim_acquire(GFP_KERNEL);
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+		fs_reclaim_release(GFP_KERNEL);
+	}
+
 	mn->mm = mm;
 	mn->users = 1;
 
-- 
2.23.0

