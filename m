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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADDC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB69021882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km5gFDAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfGDFwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:52:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36529 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfGDFwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so4246514edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzHsVfpI34IYG5D0jQtkbgHPoBjsvNWNqyndhQSAU9M=;
        b=Km5gFDAIGiqRxX8AZ+jvqa6iEfdaxMBPKdgoPBf4kY9yM68/OKn8OsBp8g0DiCIsxX
         +WNqxpotA864maNIE1jUYuKd5icSwIXwdwge1btb9P6GHrkQxzXVIWpaSK3im63cZ7r5
         boQG+kz8yZe8kMaIfHCD+pbFgPU3SS7tWpjQPjc4zhpNZZlMP+n9gY+KEbEMrSN1e183
         7/X77+kGmZ+sLVOz+BFJfSqd6TV9BC1Kbq45CZcaw63RV1aRRvKdFXyQajIta+j7ZMGS
         nWAs59N930jc6q6LZzoOjRwMvJWYiYi0waGWikb+IYsEXFD0Pi9bgSHi3inhu3nG8giT
         lNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzHsVfpI34IYG5D0jQtkbgHPoBjsvNWNqyndhQSAU9M=;
        b=dy6Ijf3ixUcaBtHQYeBCFCE1wC/inQcy/uDHbRranaPYGFD5fiRGvTzKW7n3ceAJRD
         lMpGmQ7DEQ0pdtUaqfO6t6LMrLI1v07ZE/FdMBOtAgyudOVX7Yog4LBzQnofkIx2n0aN
         kUs8jaGVSv1eoKjl+IVkJQ7jIt4fn8XVoBx6XBXP4U4z1hX//TGvmGVCqMDVdOsuLrAR
         iWonhCpE2l+/N+v2+hP9UgB1RFXRLgaQ32W/eANzagdRlSrPXbD3votRFH2Tk6SBAyl0
         /xFrT0KAdYv6AKM006thGsoAkPRFuZbP79mROiv+NwRU/XVfx5HrMxEE3cw8sofkW60E
         JU6w==
X-Gm-Message-State: APjAAAXsKBMOJiRDmp1vZe7e5xzfctRQRWXxANowqvpYD1Ab6ISLf3kY
        UJJARHo4wgQO9Omd5i9ZaAuGgzqpOFD4sA==
X-Google-Smtp-Source: APXvYqwFYrv5eXZXck3JkVT8qdGEMw5ozUGNhEk+KRFvqZ4OkLwZGS9mGnTiQdTrdefs/dFt8Tq6mA==
X-Received: by 2002:a17:906:9416:: with SMTP id q22mr37733050ejx.153.1562219568656;
        Wed, 03 Jul 2019 22:52:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:48 -0700 (PDT)
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
Subject: [PATCH 2/7] drm/amd/powerplay: Use memset to initialize metrics structs
Date:   Wed,  3 Jul 2019 22:52:13 -0700
Message-Id: <20190704055217.45860-3-natechancellor@gmail.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:601:33: warning:
suggest braces around initialization of subobject [-Wmissing-braces]
        static SmuMetrics_t metrics = {0};
                                       ^
                                       {}
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:905:26: warning:
suggest braces around initialization of subobject [-Wmissing-braces]
        SmuMetrics_t metrics = {0};
                                ^
                                {}
2 warnings generated.

One way to fix these warnings is to add additional braces like clang
suggests; however, there has been a bit of push back from some
maintainers[1][2], who just prefer memset as it is unambiguous, doesn't
depend on a particular compiler version[3], and properly initializes all
subobjects. Do that here so there are no more warnings.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
[3]: https://lore.kernel.org/lkml/20181116150432.2408a075@redhat.com/

Fixes: 98e1a543c7b1 ("drm/amd/powerplay: add function get current clock freq interface for navi10")
Fixes: ab43c4bf1cc8 ("drm/amd/powerplay: fix fan speed show error (for hwmon pwm)")
Link: https://github.com/ClangBuiltLinux/linux/issues/583
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index e00397f84b2f..f5d2ada05bc6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -598,12 +598,14 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	static SmuMetrics_t metrics = {0};
+	static SmuMetrics_t metrics;
 	int ret = 0, clk_id = 0;
 
 	if (!value)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, (void *)&metrics, false);
 	if (ret)
 		return ret;
@@ -902,12 +904,14 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 
 static int navi10_get_fan_speed(struct smu_context *smu, uint16_t *value)
 {
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS,
 			       (void *)&metrics, false);
 	if (ret)
-- 
2.22.0

