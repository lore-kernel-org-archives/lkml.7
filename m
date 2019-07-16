Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8BDC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E82145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlimn4TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfGPRpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:45:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41470 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:45:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so10435233pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xhvxxodyt4FVnA+Q4PptUiZxNmKTKZXnvXrsa2hJq/o=;
        b=mlimn4TLRvW/lqjE5coN8thyz8i9X1tiCMaNdAFPB/0qvOyooTYEfXXXG4+yFGsgDW
         +YfqxLFliWAsIcSE14CkOb6NQYkgIreCHQOSuiTEVluUu6oZgsfO4ZxXxNpA0Nob9avD
         Ts1pCcQaQMALo0p6x0WOMlXoEKAIlo/vxHCbaOs5UjJQYEx/S402jWpC5JAjchqkbIMn
         1+gGiHhCvzyfPrVegyPK/FEhwzEUfWClX2kBC/vQZOkWuXUbqI/s2WUZcvJRwBfbfANO
         xiOeWvdsPLkBhRbiKEVwmjyWo5D1Xb5+McYTgNjFX0aMeZyJp0XPn0UQNqRpGtg8UwLM
         V3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xhvxxodyt4FVnA+Q4PptUiZxNmKTKZXnvXrsa2hJq/o=;
        b=oHei+bqGLnfcXx+r7Yz1Ao5UHtXroK2ZhS97tNS4N2IdN6ldCrhgRQnIOMbJdNPqMW
         IoubOzGBW6J0n1y6u6BP+/MAGa4mNfr6wiTJ3Vr4vWMTi44CRVXgcQ9FRAZfrDzrVbp7
         S43CmmjoK61qGAEo42QLXiIzPElsFtE3yIImaChqjd61+zS4hLaSoAk+d4BHSNDyrPzP
         BRIL3UaPlDrHeE5zfHQtpDi2vbUoMq/DmXh7kx4/3WdjqXRQPCNfXNQU0FtxRkynoWtG
         gjLzZRMdwmGHxDj+Bm5eicryVfHcrWQKrEBnBHn7vj+ZyeTK2J5F4LwZMn0bIHzYMZim
         AZlQ==
X-Gm-Message-State: APjAAAUtFxIHU3+ndJbr/3FSsQl9+lu4HmvDUd/vv/MdEZnF3Pd5Klip
        +DTojr6MVE9sDzLr7Pu/8rQ=
X-Google-Smtp-Source: APXvYqyvLxSlL5GDt6wdl98KfA3lI5LIyr/lONf5ccilGqUx3VHCMUUVQyBqHX3SfEBLwglwuoop9A==
X-Received: by 2002:a17:902:3081:: with SMTP id v1mr38149628plb.169.1563299149369;
        Tue, 16 Jul 2019 10:45:49 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id g62sm21681297pje.11.2019.07.16.10.45.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:45:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/gem: don't force writecombine mmap'ing
Date:   Tue, 16 Jul 2019 10:43:21 -0700
Message-Id: <20190716174331.7371-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The driver should be in control of this.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
It is possible that this was masking bugs (ie. not setting appropriate
pgprot) in drivers.  I don't have a particularly good idea for tracking
those down (since I don't have the hw for most drivers).  Unless someone
has a better idea, maybe land this and let driver maintainers fix any
potential fallout in their drivers?

This is necessary for the last patch to fix VGEM brokenness on arm.

 drivers/gpu/drm/drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 8a55f71325b1..7d6242cc69f2 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1110,7 +1110,7 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = obj;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* Take a ref for this mapping of the object, so that the fault
-- 
2.21.0

