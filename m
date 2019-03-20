Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DDB2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEYYZsCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCTBAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:00:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43817 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfCTBAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:00:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id m35so489638ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOVvWiIbvkv3BPkmEu5aKRdzm0rTvaqyGu0VcKq2UcI=;
        b=cEYYZsCyS1qFITS10aeYQGv12nLdcVypBSXszAFRudBZcrngMqMKv88nZjzsRdTopO
         3kaGYJ5FEZua+pkofNmRA9Fb8hJ0DbU7T5M5626ypc6Np2H+phLAu0JPh24b8CSLOHIl
         +5JqIL2SqlFEp3PhTiNcKwabQuUc8oYMpe0bfKjH1++6wNyztD7oI5qDo+7BdAhIZ0iN
         BZ40JQJGho8f9NVLq/KqoQ2UXSUiAkPO1KQwGoSUIzzHdN8spzsKBFtMZ65OrBhgVNGO
         GihfLC1vWn+e8vNM5KeLsQPLZnjXya5rs2gHf79o66Elny61l4wd+xhDxkEneuhsuDRN
         er9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOVvWiIbvkv3BPkmEu5aKRdzm0rTvaqyGu0VcKq2UcI=;
        b=YSqkbUdm9c/wXbSAypPVgXAwAq+WLqHAjsCtOgy58yp+TBhODtgmcFI0G17Dl0f0zz
         VipM5VFrBfEizknIhisVT8WAHCmIAQv97gLSiqyUGBPISNpwGgRyay9KLlqJsO5JxuKo
         3Ri1RHsr4LHwbA0Ylu2718Og22lAYwwjPT/ka+yANR24pE9Et2nf4x5gVLuTAtVj1rmU
         WyRepKoUj2xCJ7yh84QivrG3SaTC4s9wpn1bmdl1iZsm9+ytxIS36l9jad6F8odZy6xt
         tOhJapURXAqPvlDFMDqqGK5o2blhRxtvG8D/e7rS0lw2qhLFVTi1cRBY1/Mb1aOo0mKp
         y+1g==
X-Gm-Message-State: APjAAAV0Pyx7z5VGONJKZ2MMxJG7LDTzTGYNqmLifWUBAOTjBBXhIN82
        T4j4l0sVuNT+my9nkzfIGnMEYXR90Gc=
X-Google-Smtp-Source: APXvYqw+0mNOdD9OpPVjAEqf4P5SvmzDL0Bd5kC8hWfVjlV0PafbkpAPkpVICZ6XFMVW7UdFkIIxww==
X-Received: by 2002:aa7:d406:: with SMTP id z6mr929570edq.197.1553043602763;
        Tue, 19 Mar 2019 18:00:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g2sm163296edi.76.2019.03.19.18.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 18:00:02 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Zero initialize num_of_levels in vega20_set_single_dpm_table
Date:   Tue, 19 Mar 2019 17:58:42 -0700
Message-Id: <20190320005842.25383-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: warning:
variable 'num_of_levels' is used uninitialized whenever '?:' condition
is false [-Wsometimes-uninitialized]
        smu_read_smc_arg(smu, &num_of_levels);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:457:7: note:
uninitialized use occurs here
        if (!num_of_levels) {
             ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: note: remove
the '?:' if its condition is always true
        smu_read_smc_arg(smu, &num_of_levels);
        ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:446:27: note:
initialize the variable 'num_of_levels' to silence this warning
        uint32_t i, num_of_levels, clk;
                                 ^
                                  = 0
1 warning generated.

The if statement it mentions as potentially problematic is currently
always true because the read_smc_arg callback is assigned at the
bottom of this file but Clang can't tell that. If the callback were
ever to disappear, num_of_levels would never be initialized. Just
zero initialize it to ensure that the intent behind this code
remains the same.

Fixes: 870b996f955f ("drm/amd/powerplay: set defalut dpm table for smu")
Link: https://github.com/ClangBuiltLinux/linux/issues/425
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 7e9e8ad9a300..41e6f49c9cb6 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -443,7 +443,7 @@ vega20_set_single_dpm_table(struct smu_context *smu,
 			    PPCLK_e clk_id)
 {
 	int ret = 0;
-	uint32_t i, num_of_levels, clk;
+	uint32_t i, num_of_levels = 0, clk;
 
 	ret = smu_send_smc_msg_with_param(smu,
 			SMU_MSG_GetDpmFreqByIndex,
-- 
2.21.0

