Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B41CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0F206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096012;
	bh=u6ttZt08jQnzk4Wup1RwDZdEm8jljIDsIIRQgxg/WvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBTgDFT6FZS0RnnghVTeV/y0PEVOnTTCW18PugHscF1AAkOD2B6J0zY1c9VzytEyT
	 JDA258VfFldHcKgSb+NwOjvbxSKadmyLrcD5RGyC9Yxitk8QQpuN7e3Kzt/IuPqxOR
	 69Zw1caF0Oy7hw1Cok5UiPvBFL9VgM6n1T+bXcdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfJZNUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfJZNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102782070B;
        Sat, 26 Oct 2019 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096001;
        bh=u6ttZt08jQnzk4Wup1RwDZdEm8jljIDsIIRQgxg/WvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HE6v6Mqm84HMkgRPzhjKKjbF63/9n72IdIA8Rjx96QL6qCDChbgwwEOCYUoOOi+Xe
         ttpCGJUfLMBVl7a5dnhD+lOiiJ+i1WkMIjRzxchrvbHC6rgPB/eCZyyneSv7wrMI0C
         8iBhGCccne/7UP8gUQhgZkAWLP8AsQiH+MSPmY4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Robert Strube <rstrube@gmail.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 26/59] drm/amdgpu/powerplay: fix typo in mvdd table setup
Date:   Sat, 26 Oct 2019 09:18:37 -0400
Message-Id: <20191026131910.3435-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 598c30dbcc9434706f29a085a8eba4730573bcc2 ]

Polaris and vegam use count for the value rather than
level.  This looks like a copy paste typo from when
the code was adapted from previous asics.

I'm not sure that the SMU actually uses this value, so
I don't know that it actually is a bug per se.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=108609
Reported-by: Robert Strube <rstrube@gmail.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 0dbca38658514..576db0c6b52b7 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -654,7 +654,7 @@ static int polaris10_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
 			count = SMU_MAX_SMIO_LEVELS;
 		for (level = 0; level < count; level++) {
 			table->SmioTable2.Pattern[level].Voltage =
-				PP_HOST_TO_SMC_US(data->mvdd_voltage_table.entries[count].value * VOLTAGE_SCALE);
+				PP_HOST_TO_SMC_US(data->mvdd_voltage_table.entries[level].value * VOLTAGE_SCALE);
 			/* Index into DpmTable.Smio. Drive bits from Smio entry to get this voltage level.*/
 			table->SmioTable2.Pattern[level].Smio =
 				(uint8_t) level;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 59113fdd1c1c1..bc05e97b1bf19 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -457,7 +457,7 @@ static int vegam_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
 			count = SMU_MAX_SMIO_LEVELS;
 		for (level = 0; level < count; level++) {
 			table->SmioTable2.Pattern[level].Voltage = PP_HOST_TO_SMC_US(
-					data->mvdd_voltage_table.entries[count].value * VOLTAGE_SCALE);
+					data->mvdd_voltage_table.entries[level].value * VOLTAGE_SCALE);
 			/* Index into DpmTable.Smio. Drive bits from Smio entry to get this voltage level.*/
 			table->SmioTable2.Pattern[level].Smio =
 				(uint8_t) level;
-- 
2.20.1

