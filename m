Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C342064B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF1Oys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:54:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60221 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1Oys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:54:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgsGx-0001bA-Dj; Fri, 28 Jun 2019 14:54:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Philip Cox <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: fix a missing break in a switch statement
Date:   Fri, 28 Jun 2019 15:54:43 +0100
Message-Id: <20190628145443.9754-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently for the CHIP_RAVEN case there is a missing break
causing the code to fall through to the new CHIP_NAVI10 case.
Fix this by adding in the missing break statement.

Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 792371442195..4e3fc284f6ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -668,6 +668,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	case CHIP_RAVEN:
 		pcache_info = raven_cache_info;
 		num_of_cache_types = ARRAY_SIZE(raven_cache_info);
+		break;
 	case CHIP_NAVI10:
 		pcache_info = navi10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
-- 
2.20.1

