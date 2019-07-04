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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD492218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCN1JcMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGDFxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:53:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38372 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGDFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:53:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so4240539edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFilk8inpqvXAk/7VOioDwq9okahAA+X1lVqweKxXoM=;
        b=vCN1JcMzPAY7/Tw39bVm1VyNdiPyea2R/hAHBGg6shiqhSTCl0vi3Fl/k0P9ZPWtcD
         fN844ICxUa05ilb7O1NX/2dcpDqQL/jQ0gQfQllMkkIfELHz0yoH7vMgqdu5Wku6NOqC
         jf0Aa0bV61JmAVZywNGeLDvFspJm3OCxmk4cU+Cvv5Wx5H8F0nMiEWqrN3eRTdPaA+gT
         Pf1ZLivIL5jjW+ZwA0LAjBQW6Ck4+zb7miSThxstmVBFe3dDr6kNEoN6LAsmF7OTbEll
         79ujDc0k9FWhs9XDHg6DgYsXkvTrF49NWoNduURhAkLkzNhyFtLfpU0QTbrqWMuOLcxC
         OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFilk8inpqvXAk/7VOioDwq9okahAA+X1lVqweKxXoM=;
        b=NixpfT6TCslryuCJdiTNX2giHYX2MmZS54jVBMPsWJMPQzLawKjhErqvhytnfuq45t
         5icb1DtBpF9tPVEWH6jvYj0yGSoKcEAKAzRHFdv7Flg1Zo0hOkWoMKTeLNlHzlwLfTXj
         qS4AnU2vsKfXm5qJ3XBwFtWtXXUfiNpdTr6htXyk4wm8AZY2EGDVtlHXj4PQ/dgqGyFp
         4Btb4lf/QSCaUzDlGo5FFNg1s4hOftJEK9CfMuTIZ7Y3S/AxwQyPQAcfPTmBse5y0Xly
         gd4gHmUaIWP2peuPzF2oKuGYx8YH2Jm5Dg/JwMvDYaajvP/xe1Ks6YseICWtCVkNhUuv
         BleQ==
X-Gm-Message-State: APjAAAUujn5TXGYBKxUcnE38zULuptZ3OFfO/+u4Mr/vMlGJEQTkYKgk
        Tj3IwcmcD9ekBVMhvglfep8=
X-Google-Smtp-Source: APXvYqxrxXJqrMJF2LmfwiNUZ/GEweI6LA1cX8k67/CpoxPX7tAyR0f2GpL/tEM3wB3rH5vK7MV5Yw==
X-Received: by 2002:a17:906:7c8d:: with SMTP id w13mr37316234ejo.264.1562219578844;
        Wed, 03 Jul 2019 22:52:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:58 -0700 (PDT)
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
Subject: [PATCH 7/7] drm/amd/powerplay: Zero initialize current_rpm in vega20_get_fan_speed_percent
Date:   Wed,  3 Jul 2019 22:52:18 -0700
Message-Id: <20190704055217.45860-8-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns (trimmed for brevity):

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: warning:
variable 'current_rpm' is used uninitialized whenever '?:' condition is
false [-Wsometimes-uninitialized]
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

smu_get_current_rpm expands to a ternary operator conditional on
smu->funcs->get_current_rpm being not NULL. When this is false,
current_rpm will be uninitialized. Zero initialize current_rpm to
avoid using random stack values if that ever happens.

Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
Link: https://github.com/ClangBuiltLinux/linux/issues/588
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index e62dd6919b24..e37b39987587 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3016,8 +3016,7 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
 					uint32_t *speed)
 {
 	int ret = 0;
-	uint32_t percent = 0;
-	uint32_t current_rpm;
+	uint32_t current_rpm = 0, percent = 0;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	ret = smu_get_current_rpm(smu, &current_rpm);
-- 
2.22.0

