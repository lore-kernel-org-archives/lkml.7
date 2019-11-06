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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B2C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FF4217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n1I8rIIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfKFJxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:53:38 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:58488 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfKFJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=GuSX7DsLSoatQP2nsn
        2ObQ5BXs4qfIxJlA/iMyeHF5Q=; b=n1I8rIIqQQ8aM0wOQQsICihs4L8tOLFpV1
        GSEwHTbgS/85UBfLAcT/LoJ2efWFshsxwNupaWQeLgKHgrGwZQwFYdbbgRuELNum
        Ui1QH7W/3jZPPnrb2AGf3+Xfk+g/tRjZ1b/4yNXrtRPAFlfvwA21+/VBXLMiTb9w
        +dn80pFzo=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgC3ag4LmMJdJKR2KA--.242S3;
        Wed, 06 Nov 2019 17:53:17 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] drm/amdgpu: fix double reference dropping
Date:   Wed,  6 Nov 2019 17:53:14 +0800
Message-Id: <1573033994-17102-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgC3ag4LmMJdJKR2KA--.242S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1DZr18ur4fZF4fuF1xKrg_yoW3KrX_ua
        y8Jr1kXr1ayFnFgr12yrs8Zrn5tFy5ZrZ5Gr13twsYyryUZ3yjy34DZr4rX3Wxu3ZF9asI
        g3W2gF1akwn3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjXdb7UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVA1lclUMK-VKwgAAsB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After dropping the reference of object fence in the loop, it should be
set to NULL to protecting dropping its reference again outside the loop.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 649e68c4479b..3174093f35f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -47,6 +47,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 		dma_fence_put(fence);
+		fence = NULL;
 	}
 	end_jiffies = jiffies;
 	r = jiffies_to_msecs(end_jiffies - start_jiffies);
-- 
2.7.4

