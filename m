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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A129CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3021882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQATCgtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfGDFwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:52:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46037 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfGDFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so4211364edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxMo/C25wB83HiqtqBaJ+h1T1C9R56SSMfKIkNntuQI=;
        b=jQATCgtOv2HJtkUCqDOPMinhGgPxktLL4vFCkiFilIKe4DwLFtLJLsuqwxtwTGEgug
         HV+Q7GToIpxKN9fX8pTqXyfzD9qZy067CiHz5gG25FLmcsKKrjmO4W3eaqyd6rqRaPYH
         kj4VKB5pYSSi9XEKcvl/4OhTAAwI3MdGgbCRAvft2gYSBqIcFCuYQoLYLaa4acpNp1w0
         q4O5vZRPtp9fNJkxfnAoHTBsszmoW+UxmbnE0UjdbKJxrWXgCJjaEKj5lAYy1ZpH+cNK
         8VWUEIo+M6B7WrGUGc+YSVYIDNJSlCtWX4a0/5vOqlU/A9UkZb5gLYokQBycB0icAxqO
         vCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxMo/C25wB83HiqtqBaJ+h1T1C9R56SSMfKIkNntuQI=;
        b=o/6iDB4R4KSXDIZviO9xBOiXIVIYjBbNL5inIim/e7jdFhJDzJxzOtUb/C97tNKoU7
         0Tc0wsyQcWF2WbNLRnB2cZIRypbv7sd9bPFv7l1DovVqeqFgvTuYiRBOygq3WT402qr2
         pN7HDxHmvH6/CLy9dr/HA2CPy1ci86OdrXGvDYnMnVUNVc7FWo35xr1+rKJNkgCaeVNd
         XUc8/YxZtK+Ta7B/PBbIeke2pW53HDTl2L+kyTYW59pUcnwNe6psf3R5JJ+fAuwdrcAz
         ViUA9M8EAm+vJVIYjzor177zg5eDMcQfbsXNETEphAZ8GrPPCaUikaYbJoUumaLJjTUD
         DF1A==
X-Gm-Message-State: APjAAAXWLk/0qxYXfJ5y2Ls4kqkSEFp7QwJqM2eJakt3jyKQo8WbbiJP
        zXfvnxAEO6Tlfh0k0OWh7gI=
X-Google-Smtp-Source: APXvYqzBi7OSwL7lr/m4iyTwfj6jyXpGc54w1FJdJua28+Xm3PLKgCoq/7MjNenqFHzRM1qatIcOiQ==
X-Received: by 2002:a50:f4dd:: with SMTP id v29mr46606079edm.246.1562219570715;
        Wed, 03 Jul 2019 22:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:50 -0700 (PDT)
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
Subject: [PATCH 3/7] drm/amd/powerplay: Use proper enums in smu_adjust_power_state_dynamic
Date:   Wed,  3 Jul 2019 22:52:14 -0700
Message-Id: <20190704055217.45860-4-natechancellor@gmail.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/amdgpu_smu.c:1374:30: warning:
implicit conversion from enumeration type 'enum pp_clock_type' to
different enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                        smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/amdgpu_smu.c:1375:30: warning:
implicit conversion from enumeration type 'enum pp_clock_type' to
different enumeration type 'enum smu_clk_type' [-Wenum-conversion]
                        smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~

This appears to be a copy and paste fail from when this was a call to
vega20_force_clk_levels.

Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/584
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 31152d495f69..e897469f7431 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1371,8 +1371,8 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 							 &soc_mask);
 			if (ret)
 				return ret;
-			smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
-			smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
+			smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
+			smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
 			break;
 
 		case AMD_DPM_FORCED_LEVEL_MANUAL:
-- 
2.22.0

