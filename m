Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8A2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJgOo0aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfGPQrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:47:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38881 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGPQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:47:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so10399057plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsJY7Tj55Ay2SJtdNoNPmO3/SlrZD7SizoCm9UXpp50=;
        b=ZJgOo0aPZ5O0N0+21Je0obxlaf1FaJT3cv7gM8x1kbGuErDXE66IS718/79YsniIMC
         JkD/a0C49E5DiaULB8NAGz4S8hPSyLvlkfCyBR7L5Xdq9pKY3cfBJvxR5rQdH8CN4jfd
         096nCgykKR1hJHdZbXuaIiOxaH27fAm8d/X9StbT12ZzEGLrr0xKC8aASBB96Bhognyl
         bDN4tz6wkQGm8j6sSVSyUXAscYYPe1TAr3OLWP86ylZATpU/Tpg4DrRWGW9MWZvLCPwf
         oix5USpYNgIvTdqTjiHeFgb0dy1CSLYzgmAFpEKV0mYWVBjVSG9xTZFdFU6t78mAMUeL
         JpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsJY7Tj55Ay2SJtdNoNPmO3/SlrZD7SizoCm9UXpp50=;
        b=XPozc3lBxdlW9WVfmqpWczS5DbX1jF4AeOmWgd30w3IfmO80+/aOkR27OwtPezpbbW
         DmkmmqBG9yfVOX9KHkZ6m1j4pcqUyIrihznL6iwCWN6j5nPLrkTCNa403qVHM9XRrCeX
         P79AFYLRiLhemQI7HzB8iCUTE4e2xYTXW5nS1E2qtvjB2zVzMoxKkSBMCWPmR9k+vQD0
         zW1zZQiDRXkg1NAAdsykB+WOVyM4zNswER4elhikeueZZEbG9sOMg42gJf1VNgRIDgql
         YVkZ3EdKfWsT7UrSLH8SAd8glkV/lnS6ZbXxlCRc6FXMpZRG4Ol2f5Syh5JEfnyC6NPs
         qVvg==
X-Gm-Message-State: APjAAAWBXgCe3n4CLulBJPuadQkG2laK5pmbbSUwRnRALtzTqBuKrYCF
        GKB6T/5t+UKBSlZg7dhr7xU=
X-Google-Smtp-Source: APXvYqxx58u4o7rwwUHy17q7VwUZtLQpEcWyLBBigW/uYXoO5pGow+PXNKPST0LfhDn2AXvduU0srQ==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr38198430ple.29.1563295634805;
        Tue, 16 Jul 2019 09:47:14 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id r18sm5762642pfg.77.2019.07.16.09.47.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:47:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/vgem: use normal cached mmap'ings
Date:   Tue, 16 Jul 2019 09:42:15 -0700
Message-Id: <20190716164221.15436-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190716164221.15436-1-robdclark@gmail.com>
References: <20190716164221.15436-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Since there is no real device associated with vgem, it is impossible to
end up with appropriate dev->dma_ops, meaning that we have no way to
invalidate the shmem pages allocated by vgem.  So, at least on platforms
without drm_cflush_pages(), we end up with corruption when cache lines
from previous usage of vgem bo pages get evicted to memory.

The only sane option is to use cached mappings.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Possibly we could dma_sync_*_for_{device,cpu}() on dmabuf attach/detach,
although the ->gem_prime_{pin,unpin}() API isn't quite ideal for that as
it is.  And that doesn't really help for drivers that don't attach/
detach for each use.

But AFAICT vgem is mainly used for dmabuf testing, so maybe we don't
need to care too much about use of cached mmap'ings.

 drivers/gpu/drm/vgem/vgem_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 11a8f99ba18c..ccf0c3fbd586 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -259,9 +259,6 @@ static int vgem_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	/* Keep the WC mmaping set by drm_gem_mmap() but our pages
-	 * are ordinary and not special.
-	 */
 	vma->vm_flags = flags | VM_DONTEXPAND | VM_DONTDUMP;
 	return 0;
 }
@@ -382,7 +379,7 @@ static void *vgem_prime_vmap(struct drm_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
+	return vmap(pages, n_pages, 0, PAGE_KERNEL);
 }
 
 static void vgem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
@@ -411,7 +408,7 @@ static int vgem_prime_mmap(struct drm_gem_object *obj,
 	fput(vma->vm_file);
 	vma->vm_file = get_file(obj->filp);
 	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	return 0;
 }
-- 
2.21.0

