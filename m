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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987C1C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570D9206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUmEeelp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfGPVkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:40:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33841 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:40:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3852650pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oew0rHc9LPVEYVoKj5FLWcwETCU8bWgVAiMOY+m8rQs=;
        b=cUmEeelpLLzt9uU8Kc5mtrmDCofKp6X62YT8kg/ywsuaaY8eOtghanE3divC3APozs
         zMV9jm3NA63gOSuu1qez7JLtbuX3jNGjtG1WOsP/e15FGrjLeXocrvK2uwbZLoEBTgE2
         Rzm/RXF2QeCU7EKIKsNnrCjUKiehEqvPsoqntBznIBgG+GAdeBwmIZuXfjiQqJDTMfsC
         HoWWGDkZx63oyErc2+yq2911qfeYNM4u7m4u01zirPyN0QqnGd9Kg9QyFzDhbPLczZDy
         ltsboE+bBTErk6of4euwNt+WJMu9sGGruYa+sS9s6DBd8A3MklOaO07qzZWB60JrUjkt
         pkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oew0rHc9LPVEYVoKj5FLWcwETCU8bWgVAiMOY+m8rQs=;
        b=ijCpNly1VZKzw/jH97mV51hQGVFLgB7BsGg2+o7SY33o8YHPUVd5SuicXpuSM5hqOR
         5RuiUKthW+IfmDhkumyrrc8PtnpOou6WCk+npe+niYsDVQIclO5Cs3eKdS1BqH9+FVdR
         WxzVDISEmduMF1nvA8B4Ewp+hwzq7rJ4eXH13rIh2VfGbYS4its1CNn8/4aO/xyzs9Yy
         Wpr2ge7z3BZG0Z6IBo3hyYOGHhYR1MXP/av8PAh56ILcltCyekiFiF22IKYVCqV4JQsI
         Ssmph7hnaHi0kZdw2TXxxzECVsa+WStcxAXGsVzkmcpzVPfmeFWLDZE35A4KddWRqkQ9
         /UAg==
X-Gm-Message-State: APjAAAVFDY48o9LHp5qKaidTlzuA/zoQmVXDuOsOt73ySDh737u2jgBg
        P8pvmHNbuwX4nRXWbd/U4wY=
X-Google-Smtp-Source: APXvYqx+31ux3AoWLdoZRzOA2Sk4B6TvHUXDsOvZ3wbk2EHT9+znE5RnV6rR626W6uSBer+MHEIXzw==
X-Received: by 2002:a63:c1c:: with SMTP id b28mr4522700pgl.354.1563313200857;
        Tue, 16 Jul 2019 14:40:00 -0700 (PDT)
Received: from localhost ([100.118.89.203])
        by smtp.gmail.com with ESMTPSA id o95sm18933486pjb.4.2019.07.16.14.39.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 14:40:00 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] drm/gem: don't force writecombine mmap'ing
Date:   Tue, 16 Jul 2019 14:37:40 -0700
Message-Id: <20190716213746.4670-1-robdclark@gmail.com>
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

v3: rebased on drm-tip

 drivers/gpu/drm/drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e6c12c6ec728..84689ccae885 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1109,7 +1109,7 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = obj;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* Take a ref for this mapping of the object, so that the fault
-- 
2.21.0

