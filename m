Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CFBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE3F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYXFy0JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfC0Qco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:32:44 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:39273 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfC0Qcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:32:43 -0400
Received: by mail-ot1-f73.google.com with SMTP id j13so10510670otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mWQ50fSmdcss6uPvu3TD2/x6Wo1xaH/+s9r9k1OxvNk=;
        b=HYXFy0JIAU6pq25Br8R7JmIAs4cZ2D8La29RTRHdQvL0V5ivqP4VfFRcxuJAsta055
         QlI3H8xShgY7ky/KgxW/XsFfZ6iIVq9a8YJDwmNzDvav4vhShjPEz95aAX1VzrJoCnxl
         rdzMpHzrDnbrNBaPb8ZbD6W/XjqBj1x6PkYZ9uzd+8WW3owCyShqbd62hPuZ7Z/36rnM
         NX36ykHJfvJ1nx6FZomAUokUit5ZUXZkc3M1THbzC3fYiW71tYZdSdxu+A66j5oo/XK2
         8mPXfjqarBn58iXi1xRXI5nKnNBgFWo4ptr7v39AeLz5AFAVxBt0i4htd98dXLppnSrY
         yWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mWQ50fSmdcss6uPvu3TD2/x6Wo1xaH/+s9r9k1OxvNk=;
        b=H1Yt30Pgws8GYXCdVLK3Yp5IM3fgrMG5LUh2Co0eCFv4qgjeyqVmCBfRndafybp8+o
         itSXLR1TrHSXvWjWeBUEKcWQSFgSTjhCpbtKnV2UPoUZqmPjMC1bGUZlKBvTu/zsKLpv
         uASBSvum62ljPyUJuIX5yGtRWhmSkRQUSQ5RMTCViNVanfNUlcoHonMKY2zctOIKgt+i
         p2dJN4Y7/vCJr/uwLgcH3wMLOQv/EUI5fT0G5TtrBpqoxYnOSz2SkZN+HibsSKcEl24H
         E7UPtg8BktzHSzHOchG8E21gSQF6TXbmccR4g+DQ5gln/mu/VfGktXzvSdL/BCfb9hnG
         i6Fg==
X-Gm-Message-State: APjAAAX9RL739xuTYoF8DqeFVEXjKlfoOztIL79DU9LOFtzdseIabGNp
        9i8UMYYP2NfJbyGYuAxNXvdH56J6Og==
X-Google-Smtp-Source: APXvYqy5TEquhbSrpHz4SoroyPnJXG1Gl2+CHA1MgTGupBopgOKUqqSSkFlrEYWafqE16qKYBZ1PM9QqIg==
X-Received: by 2002:aca:e143:: with SMTP id y64mr684688oig.39.1553704362695;
 Wed, 27 Mar 2019 09:32:42 -0700 (PDT)
Date:   Wed, 27 Mar 2019 17:32:38 +0100
Message-Id: <20190327163238.237413-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] drm/ttm: fix out-of-bounds read in ttm_put_pages()
From:   Jann Horn <jannh@google.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>, jannh@google.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ttm_put_pages() tries to figure out whether it's dealing with
transparent hugepages, it just reads past the bounds of the pages array
without a check; instead, when the end of the array is reached, treat that
as "we don't have enough pages left for a hugepage, so this isn't a
hugepage".


This was discovered by booting a libvirt VM with QXL graphics, which causes
a KASAN splat. When I add the following line at the start of
ttm_page_pool_get_pages():

    pr_warn("ttm_put_pages(0x%lx, 0x%x)\n", (unsigned long)pages, npages);

I get this dmesg output:

[TTM] ttm_put_pages(0xffff8881e68c7ac0, 0x1)
[...]
==================================================================
[...]
BUG: KASAN: slab-out-of-bounds in ttm_put_pages+0x5a0/0x680
Read of size 8 at addr ffff8881e68c7ac8 by task kworker/3:2/189
[...]
CPU: 3 PID: 189 Comm: kworker/3:2 Not tainted 5.1.0-rc2+ #337
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[...]
Call Trace:
[...]
 kasan_report+0x14e/0x192
[...]
 ttm_put_pages+0x5a0/0x680
[...]
 ttm_pool_unpopulate_helper+0xcb/0xf0
 ttm_tt_destroy.part.11+0x80/0x90
 ttm_bo_cleanup_memtype_use+0x5f/0xe0
 ttm_bo_cleanup_refs+0x262/0x2a0
 ttm_bo_delayed_delete+0x2cb/0x2f0
[...]
 ttm_bo_delayed_workqueue+0x17/0x50
 process_one_work+0x452/0x7d0
 worker_thread+0x69/0x690
 ? process_one_work+0x7d0/0x7d0
 kthread+0x1ac/0x1d0
 ? kthread_park+0xb0/0xb0
 ret_from_fork+0x1f/0x30

Allocated by task 189:
 __kasan_kmalloc.constprop.9+0xa0/0xd0
 __kmalloc_node+0x132/0x320
 ttm_tt_init+0xc2/0x120
 qxl_ttm_tt_create+0x77/0xa0
 ttm_tt_create+0x90/0xf0
 ttm_bo_handle_move_mem+0xc14/0xca0
 ttm_bo_evict+0x240/0x540
 ttm_mem_evict_first+0x240/0x2f0
 ttm_bo_mem_space+0x492/0x660
 ttm_bo_validate+0x18b/0x220
 ttm_bo_init_reserved+0x603/0x6a0
 ttm_bo_init+0xc7/0x1b0
 qxl_bo_create+0x185/0x200
 qxl_alloc_bo_reserved+0x7e/0x100
 qxl_image_alloc_objects+0xdf/0x1a0
 qxl_draw_dirty_fb+0x2ec/0x9bc
 qxl_framebuffer_surface_dirty+0x15c/0x1f0
 drm_fb_helper_dirty_work+0x25e/0x2a0
 process_one_work+0x452/0x7d0
 worker_thread+0x69/0x690
 kthread+0x1ac/0x1d0
 ret_from_fork+0x1f/0x30
[...]
The buggy address belongs to the object at ffff8881e68c7ac0
                which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
                8-byte region [ffff8881e68c7ac0, ffff8881e68c7ac8)
[...]

Fixes: 5c42c64f7d54 ("drm/ttm: fix the fix for huge compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I've tested that this makes the KASAN splat go away for me.
I'm not very familiar with the graphics subsystem though,
so it might well be that I've completely misdiagnosed what
the root cause is.

 drivers/gpu/drm/ttm/ttm_page_alloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index f841accc2c00..68912664a6df 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -731,9 +731,12 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			if (!(flags & TTM_PAGE_FLAG_DMA32)) {
-				for (j = 0; j < HPAGE_PMD_NR; ++j)
+				for (j = 0; j < HPAGE_PMD_NR; ++j) {
+					if (i + j >= npages)
+						break;
 					if (p++ != pages[i + j])
-					    break;
+						break;
+				}
 
 				if (j == HPAGE_PMD_NR)
 					order = HPAGE_PMD_ORDER;
@@ -766,9 +769,12 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
 			if (!p)
 				break;
 
-			for (j = 0; j < HPAGE_PMD_NR; ++j)
+			for (j = 0; j < HPAGE_PMD_NR; ++j) {
+				if (i + j >= npages)
+					break;
 				if (p++ != pages[i + j])
 				    break;
+			}
 
 			if (j != HPAGE_PMD_NR)
 				break;
-- 
2.21.0.392.gf8f6787159e-goog

