Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCDC32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B564214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfHALPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:15:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44571 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfHALPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:15:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ht93d-0007Ka-WF; Thu, 01 Aug 2019 11:15:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper bounds limit checks
Date:   Thu,  1 Aug 2019 12:15:41 +0100
Message-Id: <20190801111541.13627-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances of off-by-one upper bound checking of indexes
causing potential out-of-bounds array reads. Fix these.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: cb33363d0e85 ("drm/amd/powerplay: add smu feature name support")
Fixes: 6b294793e384 ("drm/amd/powerplay: add smu message name support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d029a99e600e..b64113740eb5 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -38,7 +38,7 @@ static const char* __smu_message_names[] = {
 
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
 {
-	if (type < 0 || type > SMU_MSG_MAX_COUNT)
+	if (type < 0 || type >= SMU_MSG_MAX_COUNT)
 		return "unknown smu message";
 	return __smu_message_names[type];
 }
@@ -51,7 +51,7 @@ static const char* __smu_feature_names[] = {
 
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
 {
-	if (feature < 0 || feature > SMU_FEATURE_COUNT)
+	if (feature < 0 || feature >= SMU_FEATURE_COUNT)
 		return "unknown smu feature";
 	return __smu_feature_names[feature];
 }
-- 
2.20.1

