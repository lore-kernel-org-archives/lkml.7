Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D269FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866820866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9EOvdp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgACNUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:20:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:20:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so42404584wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C3KbUwwGr1Cb8XkzCAZ3aK+ePPWFuPeAubzbR4jFmKM=;
        b=f9EOvdp1hfOh4h7Mj3m+BABI9zxxknG65AeyVIc2uxjPdSOBnoPN0qrYLkEj3HFCm6
         qCIJV7yD0ThJm/tCuLhK41AY539uXplPSODQZ50NjqCKTxfCtRXaMYpaZyj3dJJy1wzr
         sB9pLRr3IDlw0l1gH5Xh6HkDlOCU1lvdsWhkk7NojJz6mGNx46XCkaLqE/4fGIW0otqD
         sV+oQqrin1/fzrUanNlBNN/WmgNSj9qk7pROVAQYjD5VZoxnRrqkuhdpFR8sRxs+AMat
         HTb52hvrt7jN+H+VPe3iOBv46qdDr3FGM7xQOTt4tdNixZv6wctOkDmUlmXcZATcIoqi
         ct1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C3KbUwwGr1Cb8XkzCAZ3aK+ePPWFuPeAubzbR4jFmKM=;
        b=Cx9l+jHspdDqWWSh2HX9aYfmTP1kB/NO1L0nQjuw6KrIN3HppcjeqQIam24cwi9bFX
         o8y/gowig1y+EC5ptcG/QSgfcxEFpRRs4Oo5FQzQ31nAQeQeXXO2au9auBW8jGjMvr4C
         psYvlf8qLXAqDIlRjp/zbZIj1cFdyV9NNYMeVNfIPC/K0TCK0HcIGm0K7djxMxKPNmlm
         MvOAJlbwVZmB05cC8tPkfdagXmgd+DaF2Te+aKDBIsOsv184ER3HTfFrMJz77oy/m4N5
         CK3+TSMyuKwHeU9A6UftZja49xIOzHkY1Dg8cnx9ZcSW3uAEgKdEwD6iu5MMCJgQ20xw
         Uu+w==
X-Gm-Message-State: APjAAAUI5MzD38hubOwsiNoSl+Gw72W9JSUghkCZAvsI0exBJxurIHcP
        ho43g2WgLNH64ZbPG/qchZA=
X-Google-Smtp-Source: APXvYqwnJHsZPsrZYEVhI9w8MF5FKbXpJta6dTpqi48+Tm2334oPH0Lh3xrr68U9hZaqCzfvspOqgw==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr848408wrn.356.1578057639964;
        Fri, 03 Jan 2020 05:20:39 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id w8sm10645840wmd.2.2020.01.03.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 05:20:39 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: remove unnecessary braces around conditionals.
Date:   Fri,  3 Jan 2020 16:20:35 +0300
Message-Id: <20200103132035.27008-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As single statement conditionals do not need to be wrapped around
braces, the unnecessary braces can be removed.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     |  3 +--
 drivers/gpu/drm/radeon/atombios_dp.c       |  3 +--
 drivers/gpu/drm/radeon/atombios_encoders.c |  9 ++++-----
 drivers/gpu/drm/radeon/radeon_connectors.c |  4 ++--
 drivers/gpu/drm/radeon/radeon_vce.c        |  4 ++--
 drivers/gpu/drm/radeon/radeon_vm.c         | 16 ++++++++--------
 6 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index da2c9e295408..be583695427a 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -244,9 +244,8 @@ static void atombios_blank_crtc(struct drm_crtc *crtc, int state)
 
 	atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
 
-	if (ASIC_IS_DCE8(rdev)) {
+	if (ASIC_IS_DCE8(rdev))
 		WREG32(vga_control_regs[radeon_crtc->crtc_id], vga_control);
-	}
 }
 
 static void atombios_powergate_crtc(struct drm_crtc *crtc, int state)
diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
index 6f38375c77c8..39b342b5c495 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -816,9 +816,8 @@ void radeon_dp_link_train(struct drm_encoder *encoder,
 	dp_info.use_dpencoder = true;
 	index = GetIndexIntoMasterTable(COMMAND, DPEncoderService);
 	if (atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev)) {
-		if (crev > 1) {
+		if (crev > 1)
 			dp_info.use_dpencoder = false;
-		}
 	}
 
 	dp_info.enc_id = 0;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 2a7be5d5e7e6..cc5ee1b3af84 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1885,11 +1885,10 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
 			if (ASIC_IS_AVIVO(rdev))
 				args.v1.ucCRTC = radeon_crtc->crtc_id;
 			else {
-				if (radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1) {
+				if (radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1)
 					args.v1.ucCRTC = radeon_crtc->crtc_id;
-				} else {
+				else
 					args.v1.ucCRTC = radeon_crtc->crtc_id << 2;
-				}
 			}
 			switch (radeon_encoder->encoder_id) {
 			case ENCODER_OBJECT_ID_INTERNAL_TMDS1:
@@ -2234,9 +2233,9 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 		DRM_ERROR("Got encoder index incorrect - returning 0\n");
 		return 0;
 	}
-	if (rdev->mode_info.active_encoders & (1 << enc_idx)) {
+	if (rdev->mode_info.active_encoders & (1 << enc_idx))
 		DRM_ERROR("chosen encoder in use %d\n", enc_idx);
-	}
+
 	rdev->mode_info.active_encoders |= (1 << enc_idx);
 	return enc_idx;
 }
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 90d2f732affb..fe12d9d91d7a 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -700,9 +700,9 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 			else
 				ret = radeon_legacy_get_tmds_info_from_combios(radeon_encoder, tmds);
 		}
-		if (val == 1 || !ret) {
+		if (val == 1 || !ret)
 			radeon_legacy_get_tmds_info_from_table(radeon_encoder, tmds);
-		}
+
 		radeon_property_change_mode(&radeon_encoder->base);
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 59db54ace428..5e8006444704 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -388,9 +388,9 @@ int radeon_vce_get_create_msg(struct radeon_device *rdev, int ring,
 		ib.ptr[i] = cpu_to_le32(0x0);
 
 	r = radeon_ib_schedule(rdev, &ib, NULL, false);
-	if (r) {
+	if (r)
 		DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
-	}
+
 
 	if (fence)
 		*fence = radeon_fence_ref(ib.fence);
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index e0ad547786e8..f60fae0aed11 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -296,9 +296,9 @@ struct radeon_bo_va *radeon_vm_bo_find(struct radeon_vm *vm,
 	struct radeon_bo_va *bo_va;
 
 	list_for_each_entry(bo_va, &bo->va, bo_list) {
-		if (bo_va->vm == vm) {
+		if (bo_va->vm == vm)
 			return bo_va;
-		}
+
 	}
 	return NULL;
 }
@@ -323,9 +323,9 @@ struct radeon_bo_va *radeon_vm_bo_add(struct radeon_device *rdev,
 	struct radeon_bo_va *bo_va;
 
 	bo_va = kzalloc(sizeof(struct radeon_bo_va), GFP_KERNEL);
-	if (bo_va == NULL) {
+	if (bo_va == NULL)
 		return NULL;
-	}
+
 	bo_va->vm = vm;
 	bo_va->bo = bo;
 	bo_va->it.start = 0;
@@ -947,9 +947,9 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 
 	if (mem) {
 		addr = (u64)mem->start << PAGE_SHIFT;
-		if (mem->mem_type != TTM_PL_SYSTEM) {
+		if (mem->mem_type != TTM_PL_SYSTEM)
 			bo_va->flags |= RADEON_VM_PAGE_VALID;
-		}
+
 		if (mem->mem_type == TTM_PL_TT) {
 			bo_va->flags |= RADEON_VM_PAGE_SYSTEM;
 			if (!(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
@@ -1233,9 +1233,9 @@ void radeon_vm_fini(struct radeon_device *rdev, struct radeon_vm *vm)
 	struct radeon_bo_va *bo_va, *tmp;
 	int i, r;
 
-	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
+	if (!RB_EMPTY_ROOT(&vm->va.rb_root))
 		dev_err(rdev->dev, "still active bo inside vm\n");
-	}
+
 	rbtree_postorder_for_each_entry_safe(bo_va, tmp,
 					     &vm->va.rb_root, it.rb) {
 		interval_tree_remove(&bo_va->it, &vm->va);
-- 
2.17.1

