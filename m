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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC1AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0720880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIfFA/lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbfGPQog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:44:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfGPQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:44:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so10385291plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rb6z0J3PnQNVPmOTs37Tflmgb6ZXxYF+gFUGTKgihdQ=;
        b=KIfFA/lE08lYJlpZaOeKEpNHMdJmBcI/Rdit44CXjk9OkyMhhGLdG5UBq8epzlm8bj
         ptjHK+IPA2iaF0Hr1jGnU6aMHQtkoZ1q15W6sTsheinHenMfRYr2W9LO5EoBUeVSd7pj
         0Ug7z9PwL9TZQRvfXf2okOT4CBOvHsjgRKlV9byJ6PUBqKj/D4p2jkpmPquO2U1jh/IF
         cxU9LZQ0pPRF7COOUriw86shNoalNtUJDqa0VICFYSF59B4XuaHdn2f24Dy9OjlUfV+L
         byEfj4ULxRNvtLBtRz4r5VsPWHMV21S0nzNajZ+/kRX1pwECo3ZmIKfRpf6723slxf3F
         f8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rb6z0J3PnQNVPmOTs37Tflmgb6ZXxYF+gFUGTKgihdQ=;
        b=Anvp4qGF2MRtU9x0ZzSKdz23Yvspvuh4XDTk0A1FfkL9PbQd8e09EuV7lbq+kR+N3q
         ADUdl+Te5BRwAhrCBnJoFdAdt/v+UCQytfgAU00NoH4O+LfA/1ryRWe8VwHiONCCqG49
         UYZjxVPuAflUL8GBcvicLLAcrHtMl2h2TmikkHibtHreC6eqa+pr+Bd5+Cs5I5eTFIKz
         3QEpJg/cbHS1NbbobJfwnARA+Nfnxz2N7YQzjhwFpAC03yDcxtBarIS9VTGiLwT16pE5
         h/D1nSNrkv3OfYbBAHlF3XWXFfw6lRC+1arnYJcDq8K3Y6TczzLj0NHuxBBa2BjXH6ub
         qRxQ==
X-Gm-Message-State: APjAAAV3Dz/mLhlpx9w0ox0PdN2S3TgRHAhkJ0fSx/tYvKbVDVf1VLpk
        4JvE5qTFias/lZ0L/pIJhks=
X-Google-Smtp-Source: APXvYqxTAsYzSCitipMj3Cnq0cvgAncM8UVtX6Ejrg+BX45WfDVl8GCsx0zL734z9ppZ7Wol6eewNA==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr36404429plb.264.1563295475103;
        Tue, 16 Jul 2019 09:44:35 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id s66sm22096485pfs.8.2019.07.16.09.44.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:44:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/gem: don't force writecombine mmap'ing
Date:   Tue, 16 Jul 2019 09:42:14 -0700
Message-Id: <20190716164221.15436-1-robdclark@gmail.com>
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

This is necessary for the next patch to fix VGEM brokenness on arm.

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

