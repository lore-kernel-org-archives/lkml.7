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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9EC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0622187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG9RW5e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgAGPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:13:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:13:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so54355852wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AsRjqmSddZiXaJNHfNW43Wmc9oWEosMDJEk7wL2FDo=;
        b=YG9RW5e5joOPxoDvG6pcPCuwA5GGyBjDMtnNvp5f/ELEqUTKtwEnKSr1KC+XJFYnOz
         eT7E63bexxp0XZrUJ7aiQmVw4+tESSdP8UGAtPPdMAd8MIsxcnj7Jpfa84Ylv2YVUfyI
         c4TWnoRmaxbmfDYTVMg9WesEKPmYIj/cGE2Te8+GVnCh65PxuyOpD2RB5Br2kaIp/7WR
         niPNBhOheVKA5BYpw6IgR3f7mEX3tQ0SA5enxIkkxMlPPLqDXeFFzfw9UBEKMlGYJxNE
         rEaYaJ03vbvyNC9QVg1X5uyeULhRyfa3dIYEu1t5jQx8ZsDRySrovW7EtZ03T6je8LH8
         aEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AsRjqmSddZiXaJNHfNW43Wmc9oWEosMDJEk7wL2FDo=;
        b=mo8h6e5oTxub5jkUkDSwb6QkRNFo82xGkUiq91gB8rcMpAEKftRL4RiF0pQVV/toDN
         yDvalGMWk8xS7pEdEMU38Ld6P/xMstG2F6elwTXShF1bHU2PoxvAbnTjGOwM1JK6qMIA
         5oCD3VBsViUMYCYr67IuVDM9j39WNvMFn7+NWag3hKt2+yNLub5B41c8jYh/YyrxHn3H
         B5HeGdDPmVQCg6OqPCADJxylIOCX+hYJU4UOxVI1qV38/4kbCj2x3ijdMjgTGRfPvCGI
         Qt+jRqfnD5JoEbgRyylk4+BFWpv5KpYcoVTt6h7iJ5djCuDTxFSrdofXx5qdonLMfily
         yBCA==
X-Gm-Message-State: APjAAAVKHjZjiLUMreylvGVUVm7c2Anwj4YjFFAT4i4c6AewGL8rbuQT
        m8XK/WsdK6HYTE3Bxi6ldiI=
X-Google-Smtp-Source: APXvYqw9no5TtCcHAL2JCCdsE234J86HIbQroWZ5MeM6G0gn2jqlCqz9Gj/EcaDxk+UmLF3m63z07Q==
X-Received: by 2002:adf:e984:: with SMTP id h4mr107119108wrm.275.1578410030242;
        Tue, 07 Jan 2020 07:13:50 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id c4sm27076664wml.7.2020.01.07.07.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:13:49 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/i915: convert to using new struct drm_device logging macros
Date:   Tue,  7 Jan 2020 18:13:32 +0300
Message-Id: <ae253ecf3ca878fae7f1f246d75c2136fb6bd72c.1578409433.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578409433.git.wambui.karugax@gmail.com>
References: <cover.1578409433.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of printk based debugging macros with the struct
drm_device based logging macros in i915/intel_sideband.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_sideband.c | 29 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_sideband.c b/drivers/gpu/drm/i915/intel_sideband.c
index e06b35b844a0..cbfb7171d62d 100644
--- a/drivers/gpu/drm/i915/intel_sideband.c
+++ b/drivers/gpu/drm/i915/intel_sideband.c
@@ -105,8 +105,8 @@ static int vlv_sideband_rw(struct drm_i915_private *i915,
 	if (intel_wait_for_register(uncore,
 				    VLV_IOSF_DOORBELL_REQ, IOSF_SB_BUSY, 0,
 				    5)) {
-		DRM_DEBUG_DRIVER("IOSF sideband idle wait (%s) timed out\n",
-				 is_read ? "read" : "write");
+		drm_dbg(&i915->drm, "IOSF sideband idle wait (%s) timed out\n",
+			is_read ? "read" : "write");
 		return -EAGAIN;
 	}
 
@@ -129,8 +129,8 @@ static int vlv_sideband_rw(struct drm_i915_private *i915,
 			*val = intel_uncore_read_fw(uncore, VLV_IOSF_DATA);
 		err = 0;
 	} else {
-		DRM_DEBUG_DRIVER("IOSF sideband finish wait (%s) timed out\n",
-				 is_read ? "read" : "write");
+		drm_dbg(&i915->drm, "IOSF sideband finish wait (%s) timed out\n",
+			is_read ? "read" : "write");
 		err = -ETIMEDOUT;
 	}
 
@@ -283,7 +283,8 @@ static int intel_sbi_rw(struct drm_i915_private *i915, u16 reg,
 	if (intel_wait_for_register_fw(uncore,
 				       SBI_CTL_STAT, SBI_BUSY, 0,
 				       100)) {
-		DRM_ERROR("timeout waiting for SBI to become ready\n");
+		drm_err(&i915->drm,
+			"timeout waiting for SBI to become ready\n");
 		return -EBUSY;
 	}
 
@@ -301,12 +302,13 @@ static int intel_sbi_rw(struct drm_i915_private *i915, u16 reg,
 	if (__intel_wait_for_register_fw(uncore,
 					 SBI_CTL_STAT, SBI_BUSY, 0,
 					 100, 100, &cmd)) {
-		DRM_ERROR("timeout waiting for SBI to complete read\n");
+		drm_err(&i915->drm,
+			"timeout waiting for SBI to complete read\n");
 		return -ETIMEDOUT;
 	}
 
 	if (cmd & SBI_RESPONSE_FAIL) {
-		DRM_ERROR("error during SBI read of reg %x\n", reg);
+		drm_err(&i915->drm, "error during SBI read of reg %x\n", reg);
 		return -ENXIO;
 	}
 
@@ -426,8 +428,9 @@ int sandybridge_pcode_read(struct drm_i915_private *i915, u32 mbox,
 	mutex_unlock(&i915->sb_lock);
 
 	if (err) {
-		DRM_DEBUG_DRIVER("warning: pcode (read from mbox %x) mailbox access failed for %ps: %d\n",
-				 mbox, __builtin_return_address(0), err);
+		drm_dbg(&i915->drm,
+			"warning: pcode (read from mbox %x) mailbox access failed for %ps: %d\n",
+			mbox, __builtin_return_address(0), err);
 	}
 
 	return err;
@@ -447,8 +450,9 @@ int sandybridge_pcode_write_timeout(struct drm_i915_private *i915,
 	mutex_unlock(&i915->sb_lock);
 
 	if (err) {
-		DRM_DEBUG_DRIVER("warning: pcode (write of 0x%08x to mbox %x) mailbox access failed for %ps: %d\n",
-				 val, mbox, __builtin_return_address(0), err);
+		drm_dbg(&i915->drm,
+			"warning: pcode (write of 0x%08x to mbox %x) mailbox access failed for %ps: %d\n",
+			val, mbox, __builtin_return_address(0), err);
 	}
 
 	return err;
@@ -519,7 +523,8 @@ int skl_pcode_request(struct drm_i915_private *i915, u32 mbox, u32 request,
 	 * requests, and for any quirks of the PCODE firmware that delays
 	 * the request completion.
 	 */
-	DRM_DEBUG_KMS("PCODE timeout, retrying with preemption disabled\n");
+	drm_dbg_kms(&i915->drm,
+		    "PCODE timeout, retrying with preemption disabled\n");
 	WARN_ON_ONCE(timeout_base_ms > 3);
 	preempt_disable();
 	ret = wait_for_atomic(COND, 50);
-- 
2.24.1

