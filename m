Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29902075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyTu6197"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLII57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:57:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37141 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLII57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:57:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so6872599pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ5N7Jirljd8jLW/XZ0r9Y6/RYhfpOU7K02lJrm8fcM=;
        b=hyTu61975irxP9bn3UGpHOHL7Qkqq2SiDtYV1LljIZxPR4gjdO3lptLg+X/x+wliZH
         BTJQzbrVJVz4CPFBoTH9tiSABZP0AlTPHR/CeOFh4gJbHRaGrFcpj/a9g5tUVCY8eBa7
         ZMPetM3GCqq86RyqQINuYvmXgs5QsApn6Wnly7dRViLvYYhZ0s9jZGOKYylPiZBf0ecA
         jWzM9moE/+x5LC3WPSap+UFuO7FjcLm3Ic8mplwUZ3J9XGmunxAKzRsigc62QIb1V9Pz
         y4pUa4wKyQ6Fw6Uel00Qnr03YCGa57TfCGk4aoHrSh4NlBvzNt3ndGZP1OQRocZBrfNy
         i/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ5N7Jirljd8jLW/XZ0r9Y6/RYhfpOU7K02lJrm8fcM=;
        b=exiEbN5OqYRVH1HW+EAi6xf6tHrDD97F9H3Gg9Zb+GQgoWbRaZ+eJr1LCeoCzxj8Ce
         iJof/DafjiqmV8goxY+L+1SAX886NDIKIpJQA+sp2yx/oj++uG4hbjqA0uTdNjzKVDuX
         wvyEKkDNN+smSXdzmB4j5GBy3zhx2acEJMl9fAzCGFmUFCLu7aopgv/ie/5s/8szgzUt
         dTIZz7oh1rn69Lx3ARkCAsFGOzHRYQNvZx8APGSwLLSK3eM8ciqdR2D8RXb5RXklNKtd
         uegNsDKXslb2qiAifLiVTuilXWYM78bPXZTIec74hRSJJ9RL4n3Fb2jK7Sgm9bpyOsCX
         TQfA==
X-Gm-Message-State: APjAAAVcuKzX26Wx2lR4gsqbvsTT5JLiwdxCfXvZcKos/j1TfMpH+3U/
        0vmsntFL1VBOlfWWV9jU8PI=
X-Google-Smtp-Source: APXvYqxd0SLOgya+bYBtfx1iTPjygnm9SV9Zl27E66O0G+xP4k1tbXOpBXnX4FXOFh4aSizzxJonSQ==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr28498150pfg.23.1575881879038;
        Mon, 09 Dec 2019 00:57:59 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o17sm3474228pjq.1.2019.12.09.00.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:57:58 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/gma500: add a missed gma_power_end in error path
Date:   Mon,  9 Dec 2019 16:57:47 +0800
Message-Id: <20191209085747.16057-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oaktrail_lvds_mode_set() misses a gma_power_end() in an error path.
Add the call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/gma500/oaktrail_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 7390403ea1b7..582e09597500 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -117,6 +117,7 @@ static void oaktrail_lvds_mode_set(struct drm_encoder *encoder,
 
 	if (!connector) {
 		DRM_ERROR("Couldn't find connector when setting mode");
+		gma_power_end(dev);
 		return;
 	}
 
-- 
2.24.0

