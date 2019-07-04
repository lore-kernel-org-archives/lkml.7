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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A895C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21F5218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X31O77dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfGDFw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:52:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38361 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfGDFwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so4240363edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sk7x/uIvEdvnOhCPEBQK8xnGMTAhDlc8g18Tgsd50+s=;
        b=X31O77djkxsK14FGB/XNRtzgI/6Xi8+vcGgZzqR51BVRF9R51PjC4m7RTkRWKcpRVq
         oPNOSfHC1eU7T7y0WBDld+PMP6AJtu7YVdUufwqCvWNVJiQzSh82vqi8FwY6nr4ACp6i
         0MBcMyaocwVoW5Hl2mINO8yaxMGY3K/+XDt7GyXma1BG7pLVDvHvAjQeSX3FvSXBIWVZ
         RQX28ykaX5qfvfFJTYtHXVUD5etlX5vXudvbKTqeIxYUhDpfHDsjUwuF6tzv4m2MQvvI
         RzNt6/5acyN/+BA+HP+S43FWgIJYFUGFJNZxkjfCcoWKbu+ID32EBPX6qhOQWudpIosv
         kzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sk7x/uIvEdvnOhCPEBQK8xnGMTAhDlc8g18Tgsd50+s=;
        b=h0xiBBLAy4MmMvCWf4Lp+sBaAz3XQ+eeE7A/ztkyHiW/jGeZqYFMeVqT9kgefhA/cO
         tl6xMnMGVWZ5Dnn1yMaTFDX3UaaYB9iOkLex0qb/1jAcE8faVDX5kPoBGYIyi3veCsja
         DsdJCVM6sIzOAJE+I+oHPBM8nWw2lzPy6wxSFHnYN8qZctB1S1udCzWltkmObwKwqpLB
         epXPTTQe7BJC6mNxFx04s++3LeCFfQFTASIOSClmr4U9jKCtEWtuWW/2/IjChdQHtCZn
         cipAX5aEv2ojcdPQqFMvVNQfwVJbbg4vxUAeOvNHtKL2oV/yJME/r8hucuKx5ZqjQCIn
         LnYg==
X-Gm-Message-State: APjAAAUaooUXGr0gY9QYmcAOSrTM8tdxwHvC0RRr3VN5Z2vd3Cz5zpqt
        YuAdONaI74AyXdCMFqP7TPY=
X-Google-Smtp-Source: APXvYqwCKPS2hEek618wWEP0KFmsaYwMHuJ0lWVI6Mz4KIFr5ilCUyX+l2b0RP8EIu445RFt+d9oKw==
X-Received: by 2002:a17:906:edd7:: with SMTP id sb23mr28250772ejb.309.1562219572730;
        Wed, 03 Jul 2019 22:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:52 -0700 (PDT)
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
Subject: [PATCH 4/7] drm/amd/powerplay: Zero initialize freq in smu_v11_0_get_current_clk_freq
Date:   Wed,  3 Jul 2019 22:52:15 -0700
Message-Id: <20190704055217.45860-5-natechancellor@gmail.com>
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

drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1098:10: warning:
variable 'freq' is used uninitialized whenever '?:' condition is false
[-Wsometimes-uninitialized]
                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If get_current_clk_freq_by_table is ever NULL, freq will fail to be
properly initialized. Zero initialize it to avoid using uninitialized
stack values.

smu_get_current_clk_freq_by_table expands to a ternary operator
conditional on smu->funcs->get_current_clk_freq_by_table being not NULL.
When this is false, freq will be uninitialized. Zero initialize freq to
avoid using random stack values if that ever happens.

Fixes: e36182490dec ("drm/amd/powerplay: fix dpm freq unit error (10KHz -> Mhz)")
Link: https://github.com/ClangBuiltLinux/linux/issues/585
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 632a20587c8b..a6f8cd6df7f1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1088,7 +1088,7 @@ static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 					  uint32_t *value)
 {
 	int ret = 0;
-	uint32_t freq;
+	uint32_t freq = 0;
 
 	if (clk_id >= SMU_CLK_COUNT || !value)
 		return -EINVAL;
-- 
2.22.0

