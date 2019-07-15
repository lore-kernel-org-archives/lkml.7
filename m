Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A42206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNA2kjGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfGOLns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:43:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40987 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:43:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so8126440pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C0fjdopnLQ/4XRxvrGWgg1WnG5V3U1P1HH2GQHIbWCw=;
        b=JNA2kjGCPtUcqzmfIYLCGAnyt6Fw8N62mZU6OHEB1L1Ctq8yKC42XkJ35VW6Z2hbUW
         mKPFd1dhG9VueCUY+YyH2C/7IX/zI2n9bY/kimX4zmAjbsTj/C7w42TwMbNyv+cMUyTb
         M6aQxhiUSyoagsGG9jHaD0KzNZJcFgS0pDbvuhBdXBLMsmj9YR//voSp7S4aDP/NTxOr
         vQlH5Qs4DZPFa9SDHVwFkAGjLU0/e3+BtCflurhKnH0RqeOu+FHlhA3gPfSW+62hf+y/
         I3aLm0JvPkwYd/EjM51PGhHiD/JrdDE/IQsrA/60RgYzeDaXM1mvTgJLshoFAFrukseM
         ivXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C0fjdopnLQ/4XRxvrGWgg1WnG5V3U1P1HH2GQHIbWCw=;
        b=NSyQ8+wDbzKXFCsEO4VjDYV1LbO7vqcBSfCLPrbeCZcgmr9ZmaasK+NxKuNGK3csNW
         U29McoQO7Km2cLympIkgkEuv5nEtFar3riQIibyW9ZgJHCo8pT9e8aYhoDzD5ZTfQ0wQ
         9sYUt8khv9BKt/2XrA102dJm5bVpuHWPss/wy9lzpEQ1eHgRrXnGPyGftnHzsv6E/bbj
         WJbeuavhiFu18pDuok1mGCW6vH98tX4wk4R7oHH+xo6P6krS+h7ZfXQ3IPcb6AlGarSE
         6O1v3qPi9AuDi557Ep81S7uSXaOn2xdq2NeU1dl2o7YMS3WcfBeBrXzyGxtX0FqucSlT
         0elA==
X-Gm-Message-State: APjAAAXIGHJ325/7PYWL/p8hPTB2bNHzXWdNcZUXKmJ8nvBENWRRZiIx
        Kqb98iYGG20wg5bmAkwpPek=
X-Google-Smtp-Source: APXvYqyuJna6D05VcCwk1rUi2rLdU30VgksXKoiFT/0HseqFHhm+JExT0uKnEZ444uE3xcPM4/aNJA==
X-Received: by 2002:a17:902:28c9:: with SMTP id f67mr28299180plb.19.1563191026650;
        Mon, 15 Jul 2019 04:43:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u97sm16400840pjb.26.2019.07.15.04.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 04:43:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] drm/amd/powerplay: remove redundant memset
Date:   Mon, 15 Jul 2019 19:43:32 +0800
Message-Id: <20190715114332.24634-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc has already zeroed the memory.
So the memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 8fafcbdb1dfd..0fb6066997b2 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct smu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;
 
-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings));
 	od8_settings = (struct vega20_od8_settings *)table_context->od8_settings;
 
 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
-- 
2.11.0

