Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69CCC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F9620830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAMsPgBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfIMFvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 01:51:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfIMFvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 01:51:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id t3so1313263wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXC2JSeYDwfRzTDWTmvulHeraPlQ3lge32wRaYjTBZI=;
        b=pAMsPgBcYtBzJAqYVIgj1LP8nysURYvTGbxAXtyPU4cqugH9uJT1fgMdCaKcf6wrcv
         JkT2w42BprXACBM/JShBo/c0CgiThyWdqM35FSKY5pUoEpxFqsTjEqqxLsggPrx4fkgV
         0cx+8EMqqUL40BkxCgOKSDPAu0ErLvO/CR5IzsqotQVUSYMyVN27g+o/gHIhWvEvOozz
         YOfc3g8exQWaOLRnCrRgy8fVnQs/CesWfvBN+whWJzIzwlYvhrhyZn+hm2/DpMpo4A6/
         axvvWeXlF8at7OsBUlDh11dX3igTLwuWDv64I5FlNg6Zdr4QdlymDHmuS5gVnueKq6zy
         gxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXC2JSeYDwfRzTDWTmvulHeraPlQ3lge32wRaYjTBZI=;
        b=ZJDZI2Hbn9ZLqvGe3ALuCge7mvA0kfkAKhvD8XfKL0J8zq98WEv1a/nmcEML35Y+Ap
         cNHIqhOVuK/e184KVGnaPPLgDuAaOhtuzLR2OcWDcz3Hmklv4tGgU0NAjkM3SHKWeB+8
         RVN3dx5Y+xwkQxFaZptSRVU+LW5r7TPICHo+RN5vUJEULrh+rOAganZOMXguhF12Gm1Z
         LCinXOhnjxlm94b6rlmitz6oac0rEexIVPYkSEhxJ8tAQRlUJvMOPw1q9efdy6j09lpB
         x0mt5fA6Zxvjj9YyR/UlZs6CTw7MIEFznZwDgzcYRORoC0AMRuK76Rtf4LOp9SgX4+7Y
         JCyg==
X-Gm-Message-State: APjAAAVmsPWUtZdLHEyGW0TXEA3mFJkRGhY7V7uEtdKI99haGvbKV9l9
        rOICDDrxxlvisbHJmgm7KHKOqVAq
X-Google-Smtp-Source: APXvYqyPuytCs7qgPT8aDxXS0ADHQ+Ao/igSxMfV2CjGE2qnx7wAaeoyMX0W1A8Z/HLqtS4yG8snFA==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr1751035wmh.2.1568353879564;
        Thu, 12 Sep 2019 22:51:19 -0700 (PDT)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id h125sm2429279wmf.31.2019.09.12.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 22:51:18 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/etnaviv: print MMU exception cause
Date:   Fri, 13 Sep 2019 07:50:37 +0200
Message-Id: <20190913055052.25599-2-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190913055052.25599-1-christian.gmeiner@gmail.com>
References: <20190913055052.25599-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might be useful when debugging MMU exceptions.

Changes in V2:
 - Use a static array of string for error message as suggested
   by Lucas Stach.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d47d1a8e0219..b8cd85153fe0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1351,6 +1351,15 @@ static void sync_point_worker(struct work_struct *work)
 
 static void dump_mmu_fault(struct etnaviv_gpu *gpu)
 {
+	static const char *errors[] = {
+		"slave not present",
+		"page not present",
+		"write violation",
+		"out of bound",
+		"read security violation",
+		"write security violation",
+	};
+
 	u32 status_reg, status;
 	int i;
 
@@ -1364,10 +1373,16 @@ static void dump_mmu_fault(struct etnaviv_gpu *gpu)
 
 	for (i = 0; i < 4; i++) {
 		u32 address_reg;
+		const char *error = "unknown state";
 
 		if (!(status & (VIVS_MMUv2_STATUS_EXCEPTION0__MASK << (i * 4))))
 			continue;
 
+		if (status < ARRAY_SIZE(errors))
+			error = errors[status];
+
+		dev_err_ratelimited(gpu->dev, "MMU %d %s\n", i, error);
+
 		if (gpu->sec_mode == ETNA_SEC_NONE)
 			address_reg = VIVS_MMUv2_EXCEPTION_ADDR(i);
 		else
-- 
2.21.0

