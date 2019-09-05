Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B51C2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVHezsn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfIEMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:32:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732410AbfIEMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:32:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so2601920wrr.0;
        Thu, 05 Sep 2019 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuzP+vnCO2xAl32UsUr1yZq/4EL5LN563c95drnPuDA=;
        b=YVHezsn8/40byllVUiMPUITf/cYMaBIGTm+rn+siVdtZq7jfAbSg54rrCLxSIfZImr
         qQu4WCFZdnotEBEJbisjCiY+i/D+GCLb3ZDxVSo0fj1NAzoEP1NHviR8krHYR28cHY4y
         HUgLTkdrkBDhYMxe58zH3odBfm0gQW4OAOofSJ8+nLQnLTUrkve4352kKie9+pD9vefQ
         w6Yur/wqZtUMjub7iHlynuc0UO/HmKG9gVgpSJR52Br+rOkNs7Jq0GuCuWjjuFUyMStm
         lMzdOzTZu6H3r+bEVzrCjsr3mUJZc2ZSkp4JuTitJbPKMyCTLUfme2l3NXI0TPgYzZzz
         thoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xuzP+vnCO2xAl32UsUr1yZq/4EL5LN563c95drnPuDA=;
        b=QoPMwnwcGw+i2/5q+pUDTjbBhmNuSfdfPkE+U5iGVCQMfrm0ll447H3EWZoTjuMv+j
         CSkjTEFims45qr5/uzBG5ZkA0K/pIbfrtMAEpRanj56Ej6cXP8sg8Dvur3Nmo7O6Wn2J
         2TR8qRGJsl/nflmIcCT2on5I/uW6ygmSghfuVoKxqGR29jvEGZk7bntEqe9LaEP6CHzz
         DD2BWpN1sH41dKBTCHFr/7VfB2mIANxPKfadIEtpMy7SDbvfdzu3ijOfpORVL5L8tTfb
         xiN0I0eApg7nCHVdcPkqPlkDqyWi7oPKrqpYUfQxwpgOcibhGrWqmt6BpBEkd+joGwXI
         7POg==
X-Gm-Message-State: APjAAAWrLcXnht3KO+D0kYmt9ZMOeldco4kYfofPBBp+t+pN6YgB5Zql
        8luoTmpN7RM4pOiXfRBLcOU=
X-Google-Smtp-Source: APXvYqyY5+R3jS7MmxUz3+8/IxXEe+qctgB4B9IZRZ+7x6oJRXKgAiEdvgW/q9wKkCY06WzNP26bjA==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr2323071wru.162.1567686724272;
        Thu, 05 Sep 2019 05:32:04 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id t203sm3184535wmf.42.2019.09.05.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:32:03 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: Move static keyword to the front of declaration
Date:   Thu,  5 Sep 2019 14:32:02 +0200
Message-Id: <20190905123202.28001-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of modes,
and resolve the following compiler warning that can be seen
when building with warnings enabled (W=1):

drivers/gpu/drm/exynos/exynos_mixer.c:1074:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 drivers/gpu/drm/exynos/exynos_mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7b24338fad3c..6cfdb95fef2f 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1069,9 +1069,9 @@ static bool mixer_mode_fixup(struct exynos_drm_crtc *crtc,
 	struct mixer_context *ctx = crtc->ctx;
 	int width = mode->hdisplay, height = mode->vdisplay, i;
 
-	struct {
+	static const struct {
 		int hdisplay, vdisplay, htotal, vtotal, scan_val;
-	} static const modes[] = {
+	} modes[] = {
 		{ 720, 480, 858, 525, MXR_CFG_SCAN_NTSC | MXR_CFG_SCAN_SD },
 		{ 720, 576, 864, 625, MXR_CFG_SCAN_PAL | MXR_CFG_SCAN_SD },
 		{ 1280, 720, 1650, 750, MXR_CFG_SCAN_HD_720 | MXR_CFG_SCAN_HD },
-- 
2.22.1

