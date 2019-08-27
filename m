Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7176C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F712186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfH0Jdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:33:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfH0Jdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:33:41 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2Xr6-0000tY-V0; Tue, 27 Aug 2019 09:33:37 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/amdgpu: Add APTX quirk for Dell Latitude 5495
Date:   Tue, 27 Aug 2019 17:33:32 +0800
Message-Id: <20190827093332.18096-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needs ATPX rather than _PR3 to really turn off the dGPU. This can save
~5W when dGPU is runtime-suspended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 92b11de19581..354c8b6106dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -575,6 +575,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x699f, 0x1028, 0x0814, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1025, 0x125A, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x17AA, 0x3806, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
-- 
2.17.1

