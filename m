Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BB72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="RBjyUZwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgAGT0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:26:06 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37392 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:26:05 -0500
Received: by mail-yw1-f67.google.com with SMTP id z7so224705ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQjRs3gNjU2oRCRkkGnPvWhg7epwoT3OSGkU89AkxDQ=;
        b=RBjyUZwp3oCaYSH4lBnXhf98sJuriMFFB8O7XKfK7ldWb6ngmv2f9qtFr6pCkkxgGw
         7CXrDYukjNwKP67z0Lw1byh8GcFRee92q4Li3sqQ/YUX/yWYSTzzPS0CWi7nplUTz0tb
         Jc7R/IvQnQExyScOkuyYIt2H8ViWXed3K25ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQjRs3gNjU2oRCRkkGnPvWhg7epwoT3OSGkU89AkxDQ=;
        b=mz5sVg4eO/SpCg5Q8m3LMQFP5nRWcsHw29FCnLT/OfWqWu91ooxeOKCRItVSIDk039
         iJnUkB6J8jtsKN3J+iYTnLEAE8LcPIJxoqYuGNF6iapPiKw5b4DymiTmO46KSShMIE68
         WYBhiQqcrHKScPxIFPoBNeN/dZRaTH+iLS4ivzrNDr75N/4AXTs1WAdZzEZMbqdi1rQJ
         HQzPEVy7FEB6bIm3Q3OirZEaYzHJ5DIUYhZAUShuGCCZeIF9g2qOYW7MuoegPZma9jW5
         LprJa4T/KCcjzyC+DHLLeWeTMN7eGWpsFE3SSldvMoWXGNrSyhc7SX0FAXh5VR0Fs/Zo
         gtPA==
X-Gm-Message-State: APjAAAX0kWEnxG3p0bedYmLdLORjB7ojMsHOR/0RNIFkD5TXTM/ECwrg
        cZWticP88r4ePZlOB+z/2+dKvh6h3TUc
X-Google-Smtp-Source: APXvYqxUxZ+QGpsSnWO2wfDZLiBGzqQSyJZLkZZl9iPaevdfkH2M+Sp/oQ3CIezE7wg13+qNsbCYpQ==
X-Received: by 2002:a81:9c14:: with SMTP id m20mr702845ywa.143.1578425164670;
        Tue, 07 Jan 2020 11:26:04 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
        by smtp.gmail.com with ESMTPSA id e131sm229025ywb.81.2020.01.07.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:26:04 -0800 (PST)
From:   Tianlin Li <tli@digitalocean.com>
To:     kernel-hardening@lists.openwall.com, keescook@chromium.org
Cc:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tianlin Li <tli@digitalocean.com>
Subject: [PATCH 1/2] drm/radeon: have the callers of set_memory_*() check the return value
Date:   Tue,  7 Jan 2020 13:25:54 -0600
Message-Id: <20200107192555.20606-2-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107192555.20606-1-tli@digitalocean.com>
References: <20200107192555.20606-1-tli@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have the callers of set_memory_*() in drm/radeon check the return value.
Change the return type of the callers properly. 

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
 drivers/gpu/drm/radeon/radeon.h      |  2 +-
 drivers/gpu/drm/radeon/radeon_gart.c | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 30e32adc1fc6..a23e58397293 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -661,7 +661,7 @@ struct radeon_gart {
 };
 
 int radeon_gart_table_ram_alloc(struct radeon_device *rdev);
-void radeon_gart_table_ram_free(struct radeon_device *rdev);
+int radeon_gart_table_ram_free(struct radeon_device *rdev);
 int radeon_gart_table_vram_alloc(struct radeon_device *rdev);
 void radeon_gart_table_vram_free(struct radeon_device *rdev);
 int radeon_gart_table_vram_pin(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index d4d3778d0a98..59039ab602e8 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -71,6 +71,7 @@
 int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 {
 	void *ptr;
+	int ret;
 
 	ptr = pci_alloc_consistent(rdev->pdev, rdev->gart.table_size,
 				   &rdev->gart.table_addr);
@@ -80,8 +81,16 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_uc((unsigned long)ptr,
+		ret = set_memory_uc((unsigned long)ptr,
 			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (ret) {
+			pci_free_consistent(rdev->pdev, rdev->gart.table_size,
+						(void *)rdev->gart.ptr,
+						rdev->gart.table_addr);
+			rdev->gart.ptr = NULL;
+			rdev->gart.table_addr = 0;
+			return ret;
+		}
 	}
 #endif
 	rdev->gart.ptr = ptr;
@@ -98,16 +107,20 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
  * (r1xx-r3xx, non-pcie r4xx, rs400).  These asics require the
  * gart table to be in system memory.
  */
-void radeon_gart_table_ram_free(struct radeon_device *rdev)
+int radeon_gart_table_ram_free(struct radeon_device *rdev)
 {
+	int ret;
+
 	if (rdev->gart.ptr == NULL) {
-		return;
+		return 0;
 	}
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_wb((unsigned long)rdev->gart.ptr,
+		ret = set_memory_wb((unsigned long)rdev->gart.ptr,
 			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (ret)
+			return ret;
 	}
 #endif
 	pci_free_consistent(rdev->pdev, rdev->gart.table_size,
@@ -115,6 +128,7 @@ void radeon_gart_table_ram_free(struct radeon_device *rdev)
 			    rdev->gart.table_addr);
 	rdev->gart.ptr = NULL;
 	rdev->gart.table_addr = 0;
+	return 0;
 }
 
 /**
-- 
2.17.1

