Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A42C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251A217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LuKoXVvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfKFJPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:15:13 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:40242 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sVdTflIE+iXOvcN6Wo
        Co4qaadEnEkJvxlkUvIsF0664=; b=LuKoXVvYBTHDB35390tz/PmzS63L14Czxp
        YffOwccsl12O3nTXjjBNyxg1uUOghBPiyU4jOs/3x/3/eAfI/4nsDVEg8E85ko55
        Uxigc19ZUFHZy0yBILc9qstlxkVmXQTLDCnia55Ax4zKX4UO8m0mFrWuqim1tRWe
        zxuTErRKQ=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgCXOxEGj8Jd3sZmBA--.31S3;
        Wed, 06 Nov 2019 17:14:48 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] drm/amdgpu: fix potential double drop fence reference
Date:   Wed,  6 Nov 2019 17:14:45 +0800
Message-Id: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GtxpCgCXOxEGj8Jd3sZmBA--.31S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWfKF1xur1kCrW8Zr47urg_yoWDCwb_uF
        WUXFn3Cw13CFn0gF17Zr45Za9rt345Za1kWr1ft39YyryUZ3yjq34Uurn5Xa18uayxWasr
        X3WqgFyYkwnrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjXdb7UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAhlclSIdIDGYwAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The object fence is not set to NULL after its reference is dropped. As a
result, its reference may be dropped again if error occurs after that,
which may lead to a use after free bug. To avoid the issue, fence is
explicitly set to NULL after dropping its reference.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index b66d29d5ffa2..b158230af8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -138,6 +138,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		}
 
 		dma_fence_put(fence);
+		fence = NULL;
 
 		r = amdgpu_bo_kmap(vram_obj, &vram_map);
 		if (r) {
@@ -183,6 +184,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		}
 
 		dma_fence_put(fence);
+		fence = NULL;
 
 		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
 		if (r) {
-- 
2.7.4

