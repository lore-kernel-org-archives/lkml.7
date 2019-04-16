Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0467AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D32064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+P0FnuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfDPSjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbfDPSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so28433130wrw.13;
        Tue, 16 Apr 2019 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s5cszzwLAP8znv7Qr2CcXYQjPwLeD7Vj8g8GMf0w+tc=;
        b=r+P0FnuOchgesYi7zaQs3nOnZnbqR7pxehruBlwqOV2kB3sdf1Zo1eZlkOgywXzH0p
         P3Rcmu/Ei6MiT2wXbds9kZHdJILm2ebNk02u/+aRPB8SsAow0/ecI/0k8JNn1txzMULQ
         c3DAdrdLy+gYFM8SrLaEgxp10ULtZBY4hzIZLO9/7V9Zfh68aQu7KHl62+Q7WNKMJcn4
         SFeltzGeACTEpO0JDflyZS57CfVWvcjeOGSFIS6l3cS0gwa4QW4OqJIk6ZNTxtJ+rBTK
         seAFM+ChOFs8jLOlPUUAT2wtCK+iYpMu+ACHTVtVwf1Ne3GrGBWvms1Vvtlt9F8Jl0fu
         ipGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5cszzwLAP8znv7Qr2CcXYQjPwLeD7Vj8g8GMf0w+tc=;
        b=ST1oTMYcXt6JBoJMgtTIa5aUg/L+JxeFLnCdvXWigjF97aWDKxuQlCan1fwIZLGMmk
         QQrEO6meixEilwIONWPI5WHnb9dOUFANU9pMF/fwDiRV0xytgcaGT+G3k+UQ7oFvP2Km
         bljscGJspFWaLbfOI3By3Q5SezSGv0+hm1L3Z9CMGZQyJwenaJFHe4i6Is3oBGps4VpU
         2K8g2yKLW9hgc8Q9GOO2fqu9bQYxe5DH3S0Ys2vsAVNeMLQ1/4sRMQX5Hfj8/DJQUXwT
         AX+tlxFvAdRftvvUPXUIj9LyI9lWhf9vD+/aGZ8oZA72Ub+rfUE+sr4+cUMe5dTZlTs5
         iiPg==
X-Gm-Message-State: APjAAAWInEqddzq60irDKsXxrnM2Nd8GpSOJ26A6IEkGTZllWDW2rP4f
        G3JJOtiyYrJb0WrAE8N54h3s+ndr
X-Google-Smtp-Source: APXvYqxoqsjmjbgSWUA5N0LWJJAdKBY1AInFWDzqfl5eHaZt6YxgAMrEKzSNU4vTXFEq6ElNQBx62A==
X-Received: by 2002:adf:ee0e:: with SMTP id y14mr47332073wrn.21.1555439932999;
        Tue, 16 Apr 2019 11:38:52 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:52 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] drm/ttm: remove the backing store if no placement is given
Date:   Tue, 16 Apr 2019 20:38:36 +0200
Message-Id: <20190416183841.1577-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pipeline removal of the BOs backing store when no placement is given
during validation.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 41d07faa2eae..8e7e7caee9d5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1161,6 +1161,18 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 	uint32_t new_flags;
 
 	reservation_object_assert_held(bo->resv);
+
+	/*
+	 * Remove the backing store if no placement is given.
+	 */
+	if (!placement->num_placement && !placement->num_busy_placement) {
+		ret = ttm_bo_pipeline_gutting(bo);
+		if (ret)
+			return ret;
+
+		return ttm_tt_create(bo, false);
+	}
+
 	/*
 	 * Check whether we need to move buffer.
 	 */
-- 
2.17.1

