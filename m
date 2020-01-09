Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373CC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1E20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7n3Me2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAIJmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:42:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35564 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgAIJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:42:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2059117wmb.0;
        Thu, 09 Jan 2020 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x/rJsrzAFN1SHOY1ywcZnWjYD9yWmdldMlh5f03XRYg=;
        b=l7n3Me2CEVGR8p5a6YW0NNtdcTDn9ZDVgj4YDu6Cl4Kif/Plbh9xiOT5YRyZ7xRTe1
         E5H3y4vlS/PAPJvfMTXpBk7W1aX0vf/JSBniLv5yMnE9WtvQAA5zv0ZjGsDZQO8ZOXs1
         xmDE5aMNv6e/0tWG4RgYVIqEUor25w0M+2Pch+0E8c45C3X/HU5G+To1CTwW5J3cLYA/
         SjHjxo84gnQgT16WkbPApY15KlgcBvYHOCTq/SggQUSf2/b9jhpcyvU5VQINfyabWHfH
         5bJkNepes33nKKUn5T5Ifoke5iVS9EI7IQZKz+z2uv9Js1rr8hlL0ALfEMeOzCIDvr7L
         pYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x/rJsrzAFN1SHOY1ywcZnWjYD9yWmdldMlh5f03XRYg=;
        b=YcsWhqmgClmQ3y9TPnUyRWASYK16GJunnY4wTe2ksdDPEaLYyejO7hvX5uNI6Lx1YE
         QHQZ+19gAXrjnMMWw2tuII1FETnkP4zn4GgnhFZw6Jf4wLRw4DG/kjydtDpjnKTtNRgZ
         wAEemDvvWol8sIbQgfOrfAYYrp+THAj6JBESm8wysZ1NnsfosDZtMv6hZOSnlptVI5sB
         XfZV4duH1YS0vl+8T23uMFwkQ62q7GAtD1XPQQbYCfdNoN63gNVhS62u4PvDQVslw1ya
         RSoubQC9QZy2HmQVm3hjSc7QGXF2R9n7hp7EJ/WPFhBcs7oqzzu/I8TBnuJuw8I/hnwW
         9DqQ==
X-Gm-Message-State: APjAAAURraVC/jW4ExuYqWiwTTAd3icnf067d9B/DwH/aAMwzX7F7+pa
        nQ619vgqr3nuNyTrrkeGcbI=
X-Google-Smtp-Source: APXvYqzutBXNb9l/OLivyPXT06DnycTvFXLnYG/Z5uxCovB+J7j2p4azD6X6kG/WwBfIrjj1YXBhog==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr3920334wmg.159.1578562953501;
        Thu, 09 Jan 2020 01:42:33 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id y7sm3219435wmd.1.2020.01.09.01.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:42:33 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm: use BUG_ON macro for debugging.
Date:   Thu,  9 Jan 2020 12:42:26 +0300
Message-Id: <20200109094226.4967-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the if statement only checks for the value of the offset_name
variable, it can be replaced by the more conscise BUG_ON macro for error
reporting.

v2: format expression to less than 80 characters for each line.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c7441fb8313e..d1843abc3ac7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -315,10 +315,8 @@ OUT_PKT7(struct msm_ringbuffer *ring, uint8_t opcode, uint16_t cnt)
 static inline bool adreno_reg_check(struct adreno_gpu *gpu,
 		enum adreno_regs offset_name)
 {
-	if (offset_name >= REG_ADRENO_REGISTER_MAX ||
-			!gpu->reg_offsets[offset_name]) {
-		BUG();
-	}
+	BUG_ON(offset_name >= REG_ADRENO_REGISTER_MAX ||
+	       !gpu->reg_offsets[offset_name]);
 
 	/*
 	 * REG_SKIP is a special value that tell us that the register in
-- 
2.17.1

