Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E5DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702D20679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhKMGXay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfKWTYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:24:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33224 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfKWTYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 14:24:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id q23so3328426otn.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsgedYWGcDm2gsEfcO7YvCurfXqqqHvXcUgzb0SkXvE=;
        b=DhKMGXayoU1zJxSIN7PkHAQmyyS8DnDHS7/rwmIF0HY9CQKJILJSswS3cBOGUI5NDc
         9lhNTEM+kKggalT3TCnneA5sSEwHd64La89Ae5uykGkOwYJE3I7R1TFu6WdeDr1DNMaT
         fgn+8778RSBtUsx0IKwlxFUbHomEhtxV27VE5J+/MnPm7ydJ+SUiHn+3xpqxSmWvTG1u
         ONFp8keGdHAQ3U8sUG9c36yNc3uAur0l+tLT3dOPUpGgQbRZRPmWLcmGNARcriPrAh1I
         5jQYTtmoVWAqJ5poW41jeLvrqUMxApWUUAJGzUI81gNAUaZQTiKyWv9350ti8vjQaUgv
         U+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsgedYWGcDm2gsEfcO7YvCurfXqqqHvXcUgzb0SkXvE=;
        b=tDf37f/wE9lgCKkEzocGDYphQkDNwx2Rrxm0USeBBXn6TzETabxi85+m/YFhRVmP0H
         nJeSFEuiMUEmQhkYreUFdnRUQvXbngQWPsLkS1Xy8jURpuPgV27Rt+e1oYsH6sGw6Gz1
         LV516pRkPG3VgqOFtfSnuau0sXqFAn1OvpV8agHJfU1Oa271/6gd0UITMQoo2ttk6tvc
         BnP7Of+SK+YL9PD+EQAc3Rlfx/UzScg1jwu2wUaXo+fYOievKOeIEa+rUziBVnCYBVd0
         cYwxCV7+z3G4hFAOfbSDzLTS0CGMxCvtSeMuVFd8geHNhZgH+fUve3gPA72UQKWrwnl+
         Vajg==
X-Gm-Message-State: APjAAAXaMQqZ3kp9SLJ9OViZ781SpGb4mJjHIrwOXNh4AHtcEZ34gGcy
        JsURvJ984VVyS10Rjziv9pE=
X-Google-Smtp-Source: APXvYqx1fpWBPu6g4gMwvZ8c8rzxDBf/2LNZhYGwrIsO/l49CfLoBbqhpoW6unLQv+Bq31U044WiOA==
X-Received: by 2002:a9d:37cb:: with SMTP id x69mr14555138otb.90.1574537057333;
        Sat, 23 Nov 2019 11:24:17 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id i12sm549134ota.10.2019.11.23.11.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 11:24:16 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Leo Liu <leo.liu@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Ensure ret is always initialized when using SOC15_WAIT_ON_RREG
Date:   Sat, 23 Nov 2019 12:23:36 -0700
Message-Id: <20191123192336.11678-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0f3cd3191cd ("drm/amdgpu: remove unnecessary JPEG2.0 code from
VCN2.0") introduced a new clang warning in the vcn_v2_0_stop function:

../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: warning: variable 'r'
is used uninitialized whenever 'while' loop exits because its condition
is false [-Wsometimes-uninitialized]
        SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
expanded from macro 'SOC15_WAIT_ON_RREG'
                while ((tmp_ & (mask)) != (expected_value)) {   \
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1083:6: note: uninitialized use
occurs here
        if (r)
            ^
../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: note: remove the
condition if it is always true
        SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
        ^
../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
expanded from macro 'SOC15_WAIT_ON_RREG'
                while ((tmp_ & (mask)) != (expected_value)) {   \
                       ^
../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1072:7: note: initialize the
variable 'r' to silence this warning
        int r;
             ^
              = 0
1 warning generated.

To prevent warnings like this from happening in the future, make the
SOC15_WAIT_ON_RREG macro initialize its ret variable before the while
loop that can time out. This macro's return value is always checked so
it should set ret in both the success and fail path.

Link: https://github.com/ClangBuiltLinux/linux/issues/776
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 839f186e1182..19e870c79896 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -52,6 +52,7 @@
 		uint32_t old_ = 0;	\
 		uint32_t tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
 		uint32_t loop = adev->usec_timeout;		\
+		ret = 0;					\
 		while ((tmp_ & (mask)) != (expected_value)) {	\
 			if (old_ != tmp_) {			\
 				loop = adev->usec_timeout;	\
-- 
2.24.0

