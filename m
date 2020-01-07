Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB8C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOgpqVCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgAGPNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:13:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:13:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so41763973wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLtZU9HpYzbZmbVfIezeBKYweFkIIWAJULqKJXUB1GQ=;
        b=pOgpqVCfAihCsGgxWXBFJrVrMFZ9DscVFJmr2f3mWWZ2ESHLCeSot0A1QT2Zwqq1uB
         JNVqx1wn1BCTOfYgSzizUhF8MB+89T5xL98+9IZ2l/Onwblv6Ah+1ft45QJHqzzFz16r
         GVF8QBDWDjHomkdoBQc725ggvIXrYsB3SiB+IfjEjR+CMGv8l/XffFFMmcO1WTp9OBx8
         GMb0G1IzIzYGpsm6WXuSx2J3shOJyrSZ5yISE4r+W/aPrXP8OSa6C2CJfUQ3McQS6CA+
         /ND4N2huk0YC/gN9PP0Yz1yKYfh9ZT8E1/yJfyBTsqRFEzE9kYXc7r27UIRUpQqkWqMR
         VKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLtZU9HpYzbZmbVfIezeBKYweFkIIWAJULqKJXUB1GQ=;
        b=eFZvTRI+Gwww7hFBEOuAc38mNMr4FXxM8ovf0r4JtY9hmpqIqFQe2Y75As2nSsUAmM
         uzaYYt4zNGZL8P5lyVjQdI2d7Z7ac96EJHmy6HTA4K5yI69/+RGm/AKmZZtajNWv2QAq
         yG+1ElRHQC5rFP5WDlDGUpP49TTZvBxKI5DXVracvUYnkAjeMoItJkNwo++Vzyz+f3Jo
         DGEA8meLS7ELvvvqRwHba1f0eC+EfZVyXsj26GoZbXpxO23BUEBbi1zAo5+4Qf2+g4oz
         Ax9iTDGCNkt2SeZ0/4dB6Bry17b3uP/UpKf25BJemgQL0rv37nIpjBOHPDfGlZ3i4cA9
         HizA==
X-Gm-Message-State: APjAAAW8fvvlCqqEp3kbsaJFYfYt4fkiaE4h7Eky5oBDMaLqy8Tt0hNb
        yGxOOVtpiAm/h+XnUzDWMtw=
X-Google-Smtp-Source: APXvYqxLU5z597JDDpIE9gTOoWpNCkFxLMEVVes6q2jNqnwwYs0Oatc3uIdlFLLqxZcWWW48Qbl5dw==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr109350909wru.40.1578410027672;
        Tue, 07 Jan 2020 07:13:47 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id c4sm27076664wml.7.2020.01.07.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:13:47 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/i915: use new struct drm_device based logging macros.
Date:   Tue,  7 Jan 2020 18:13:31 +0300
Message-Id: <7f3df2575ab41a052b7beea86ecc5385edf6f6da.1578409433.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578409433.git.wambui.karugax@gmail.com>
References: <cover.1578409433.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace instances of printk based logging macros with the new
struct drm_device logging macros in i915/intel_region_lmem.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_region_lmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_region_lmem.c b/drivers/gpu/drm/i915/intel_region_lmem.c
index e6a6b571dad4..14b59b899c9b 100644
--- a/drivers/gpu/drm/i915/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/intel_region_lmem.c
@@ -125,10 +125,12 @@ intel_setup_fake_lmem(struct drm_i915_private *i915)
 					 io_start,
 					 &intel_region_lmem_ops);
 	if (!IS_ERR(mem)) {
-		DRM_INFO("Intel graphics fake LMEM: %pR\n", &mem->region);
-		DRM_INFO("Intel graphics fake LMEM IO start: %llx\n",
-			 (u64)mem->io_start);
-		DRM_INFO("Intel graphics fake LMEM size: %llx\n",
+		drm_info(&i915->drm, "Intel graphics fake LMEM: %pR\n",
+			 &mem->region);
+		drm_info(&i915->drm,
+			 "Intel graphics fake LMEM IO start: %llx\n",
+			(u64)mem->io_start);
+		drm_info(&i915->drm, "Intel graphics fake LMEM size: %llx\n",
 			 (u64)resource_size(&mem->region));
 	}
 
-- 
2.24.1

