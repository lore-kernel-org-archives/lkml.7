Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1E42189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knXHCJL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfGDFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:53:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42297 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGDFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so4215483edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8j4/lfObWKsySJXHjiTJhYwv3YoOUa3RyuF9b2OiCM=;
        b=knXHCJL6QcZzMVgVNUiZIanYTejfXIDYg2v2DTquN8FlJf1PUoIPvsEtxcfPAoYlHC
         UEoUo//wjy3wqe8hDRPSZlJm6o1NaokVDYHJZqYjtg/2Ll4hDOsP50MQs1ObKlZlKGdK
         vlKr9Og8jwfSHADn/MqQXE17Mt2OCsbSNbCM0qFPR8cmCbdgSVqfGkXq81DMswrni7wT
         CmzUNIMVIm0tuj8dkJJddCMCVOSE8ziuHNXVRz7m0TdgV1bqSextCYzGeA+MMtXNZziH
         m37DPf7guudTsok5GLEYP0pgKsKJYisHc7u9FSdNVi8gu48ggzD9wWuDqyvQ5Xr4vPaU
         NTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8j4/lfObWKsySJXHjiTJhYwv3YoOUa3RyuF9b2OiCM=;
        b=Uge13VHPE9lMaI/wL+e0k4mO/9OYYpbrnt1C7yNLTvU2IGsSOQf2PZdqWZ+nxxkwmS
         84qIwm2O2h20IV3XNgX7pc8I2NZfosWSZWT5XiGXxC6OFGJ8A3OiQfymDfmz1DPL+h3/
         yYxrHcnIOkg09vYzAzgwR2eXkEaTuXfISqBLtllvVS47BhPlxNnuMN+3wcsepPACvxwL
         zpgMzRd/vCuLBO/OIa9DO41z42xwNXUuKpRhuoMyIxiBP8Mc4OiPsITq8QlTnVWQ9S/M
         Ez2TwrVjf6VNs5yuzPmS/t+Pi8Y4tFosYkvSITn31/BlxfgoNRrZ3CKb6Akh1RhSAu97
         YeEQ==
X-Gm-Message-State: APjAAAVXkNh11OX+/CF7EXffcxTgYb2DyIIRvQ9xSJQfOnR//RdP7iCc
        iO0epXKqL6v0PjZqMlIuHLM=
X-Google-Smtp-Source: APXvYqyEV4E8nukKV6omo3iH8YCRstVAvf1CQz8Y0UriutmKpBEO8S4OT87MNMKrRaN3/rlsXae2Kw==
X-Received: by 2002:aa7:d68e:: with SMTP id d14mr46710516edr.253.1562219576755;
        Wed, 03 Jul 2019 22:52:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 6/7] drm/amd/powerplay: Use proper enums in vega20_print_clk_levels
Date:   Wed,  3 Jul 2019 22:52:17 -0700
Message-Id: <20190704055217.45860-7-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39: warning:
implicit conversion from enumeration type 'PPCLK_e' to different
enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~

The values are mapped one to one in vega20_get_smu_clk_index so just use
the proper enums here.

Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
Link: https://github.com/ClangBuiltLinux/linux/issues/587
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 0f14fe14ecd8..e62dd6919b24 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current socclk Failed!");
 			return ret;
@@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_FCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current fclk Failed!");
 			return ret;
@@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
+		ret = smu_get_current_clk_freq(smu, SMU_DCEFCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current dcefclk Failed!");
 			return ret;
-- 
2.22.0

