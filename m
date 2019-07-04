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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA1218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4pPML7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGDFxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:53:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44480 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfGDFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so4211373edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmo/DU9O/dE2Ko7+mstCaxZb9Z4EJlYbcBOkNgkpK1k=;
        b=h4pPML7bpwzuyJMgCJJPLfaCa1fcpe2uwIemczJvh0g5BTf8HA7EEUrIOPplYLMn2s
         5GcqKLwtmMJfn4TrJEAtylyNk/mCSNS+eeR1bCXKwQUrjlheeZFdAnAT+GDa8ixxcVht
         qAa8Hn5WmQWS5V2oEz7Yac6nj/+qu0ik70lcyRS3fieiHAJO0g53xPtRb9bNgsAfTCrZ
         08rntxyq37gI3RE4TzGKUuP7X8gWfSIh8jKVyb9PMVOCVX03T1/SBkgN+VvSb+sTxso3
         5HZaTwoSos6OVm14j4fNu6+Dz219kOPNpvSBM6QZTNzPQQeDrKwtWUWR/KCVbjifQ8u3
         gZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmo/DU9O/dE2Ko7+mstCaxZb9Z4EJlYbcBOkNgkpK1k=;
        b=ecwnj53iWdDl4Txbc2D2swIiuVla9pGjyErHYUuCOQlyyUmnchcFdHCqA0MnKfZqoM
         DDqmE2OsMiJS3Nyo6s8+8RMP4ebeXvFBwWB1moFB8hP8QRxicwDi4vvY2HJdBNINjfFE
         DOeSj/0X0FFgFaG2QulzKcfJr26uBFbvkewKqfPNNaX99u/sgNEJxwh5wvT98K/83Rlv
         R+aK4jKpb5JpQPIna5+yd4WmatbhxK/KIo3NyZY2xoHk2hVoIZUiWCYtiaKQ/cOknmBP
         BCdx54j1Y9Lity97KQcWxZGNmmIIYJ9eUI6NFM8UoRPI2i3SCxn/03z3CzyuF+Zicx48
         C3Yg==
X-Gm-Message-State: APjAAAUmd20/oMEXHeLKLkZqkWgjz52VDoChIdgeMboDS5oTP4T3AuuK
        8t+ISWC49nVkT0dmHJgSRIg=
X-Google-Smtp-Source: APXvYqwLymzXqhyTyIpMejt6YiRteUU5daBG+29a56wz496qKMJIhAQ/F0d1eJQEct7PYQ3sWdYE9Q==
X-Received: by 2002:a05:6402:12d2:: with SMTP id k18mr46093602edx.197.1562219574837;
        Wed, 03 Jul 2019 22:52:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:54 -0700 (PDT)
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
Subject: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
Date:   Wed,  3 Jul 2019 22:52:16 -0700
Message-Id: <20190704055217.45860-6-natechancellor@gmail.com>
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

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
warning: implicit conversion from enumeration type 'enum smu_clk_type'
to different enumeration type 'enum amd_pp_clock_type'
[-Wenum-conversion]
                                        dc_to_smu_clock_type(clk_type),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
warning: implicit conversion from enumeration type 'enum
amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
[-Wenum-conversion]
                                        dc_to_pp_clock_type(clk_type),
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are functions to properly convert between all of these types, use
them so there are no longer any warnings.

Fixes: a43913ea50a5 ("drm/amd/powerplay: add function get_clock_by_type_with_latency for navi10")
Fixes: e5e4e22391c2 ("drm/amd/powerplay: add interface to get clock by type with latency for display (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/586
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index eac09bfe3be2..0f76cfff9d9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -333,7 +333,7 @@ bool dm_pp_get_clock_levels_by_type(
 		}
 	} else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {
 		if (smu_get_clock_by_type(&adev->smu,
-					  dc_to_smu_clock_type(clk_type),
+					  dc_to_pp_clock_type(clk_type),
 					  &pp_clks)) {
 			get_default_clock_levels(clk_type, dc_clks);
 			return true;
@@ -418,7 +418,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 			return false;
 	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
 		if (smu_get_clock_by_type_with_latency(&adev->smu,
-						       dc_to_pp_clock_type(clk_type),
+						       dc_to_smu_clock_type(clk_type),
 						       &pp_clks))
 			return false;
 	}
-- 
2.22.0

