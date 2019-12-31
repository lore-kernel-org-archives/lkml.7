Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD82205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTVkJzzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLaU4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 15:56:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34189 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaU4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 15:56:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so36012513edw.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Z+jvCslck9jvZyqIDORlvWYlx3m5W/qD1J93hFFm1XI=;
        b=vTVkJzzZyTHRnHwXoQ+eaVI3+LJyxV952KBN+N+Q/ZpyUXtN/8gNFsObt12NPIwVo4
         uZRpH8xALxFjZQKvaSGKY3I2tfoT73sv+Lqes0GyJjlJkfh5ZH3ckmHEfnJyWvDTFuUa
         f+BgxgScMy8o1UaqUz6y943UUrImEa7YrILZITWYD7glhutNyPO4MSNw2qYkmnZlqhhh
         tao2d9IOAcF238DT0AegtIKHWs2+moRepni8WZS2g/1M+PLIx+LkkZXkKMzA64o7atbb
         uGXqQOOB4R9PftsHT44ao8N/+mmH25ApN4MS4UXykKwVqW2dpLUeouVrmUCg9gs9qRWD
         sJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Z+jvCslck9jvZyqIDORlvWYlx3m5W/qD1J93hFFm1XI=;
        b=LkyMHOpKeJT4yT5JszNh7arSOg2dBaSKZ0PJLMQcWuYAY5TzYAcc1GcYUt2Xz4sgEn
         2BSpkWE2RRmqDlNHbTgRZnj5NqyBkxHiAUGaI+1o7tD7DIlftaqVp4vmcvSZzw/jLxO8
         BrpAJ7jSKsy7ozzb7bnM2//pU1k6iWL831RklqwFFcI3Rl0KVfkn/5hoj91G1wa/vO1c
         r0IRBMCVwWXmixPN6WqKyGlcAzAF3DiyMnEzxzJv3bbrhKBlx4GntgH2k/89henunF5g
         5kg4REwV/Blv4GOqFulC6efNLE0flyAH/0m4G0nri6atACL2iRPHcI1Xv5Tz98VOvdea
         OLOg==
X-Gm-Message-State: APjAAAWg66XuBxzsyU0+lJLF23ciTo3Hirp/fEu7vuKV1khYrzs3JJhf
        GTIe4yug5Avc+h+JkcnoSxQ=
X-Google-Smtp-Source: APXvYqxJ3dpj0n5GpU6dZRMCRgNpsDhzBQryxTk7/n7qJ79bFKRe5XPY0TwPd5dLwuEVv4yJNJ7lhQ==
X-Received: by 2002:a05:6402:609:: with SMTP id n9mr79544990edv.305.1577825771379;
        Tue, 31 Dec 2019 12:56:11 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id r9sm6341288ejx.31.2019.12.31.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 12:56:10 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: remove set but unused variable.
Date:   Tue, 31 Dec 2019 23:56:07 +0300
Message-Id: <20191231205607.1005-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable `pclks` is defined and set but not used and can
therefore be removed.
Issue found by coccinelle.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index 362495535e69..f607a04d262d 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -54,7 +54,7 @@ static void
 nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
 {
 	int pagemiss, cas, width, bpp;
-	int nvclks, mclks, pclks, crtpagemiss;
+	int nvclks, mclks, crtpagemiss;
 	int found, mclk_extra, mclk_loop, cbs, m1, p1;
 	int mclk_freq, pclk_freq, nvclk_freq;
 	int us_m, us_n, us_p, crtc_drain_rate;
@@ -69,7 +69,6 @@ nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
 	bpp = arb->bpp;
 	cbs = 128;
 
-	pclks = 2;
 	nvclks = 10;
 	mclks = 13 + cas;
 	mclk_extra = 3;
-- 
2.17.1

