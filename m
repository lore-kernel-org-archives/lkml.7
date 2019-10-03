Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3255C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FF920659
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119655;
	bh=4aQFDbSQL+d9zrO7he+q/JybfPW4JziCkkso1/CsaKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I8Slt8ezKhdkjsGhoOObLyjUa/I5GZnRpIGbyeSO8gn8Ne/RTmBLVJvy/cu8f/cTn
	 FP0R1KvJDrWgZJk69Vp8bJE255c+c/y5qOnZCI3Ku60IEEE2eoub+/eCIZfjAU13p0
	 MCvtei6ocxITuQesur9E6phiAYPadLt9PL0YH3AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbfJCQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390007AbfJCQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:20:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A5F20865;
        Thu,  3 Oct 2019 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119650;
        bh=4aQFDbSQL+d9zrO7he+q/JybfPW4JziCkkso1/CsaKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELHSB/tVbnEhWENN1QK50/YhXbwxZJuiu+795ePBgAD5C02h4+csmMQp/UG/pYrGQ
         tQIeL1Wii7rVN5/o/rtoU3hhCC2tXrpnsQe6O6DMYUi4D+sagwyEe+TjMfcS0ypRpa
         MgEWZPpqyc07nmi8pqSynKvWmF8JWNT0ftEV0JW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Ahzo <Ahzo@tutanota.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/211] drm/amd/powerplay/smu7: enforce minimal VBITimeout (v2)
Date:   Thu,  3 Oct 2019 17:53:27 +0200
Message-Id: <20191003154519.506509425@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahzo <Ahzo@tutanota.com>

[ Upstream commit f659bb6dae58c113805f92822e4c16ddd3156b79 ]

This fixes screen corruption/flickering on 75 Hz displays.

v2: make print statement debug only (Alex)

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=102646
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Ahzo <Ahzo@tutanota.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index b52ccab428a9e..c7c505095402d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4052,6 +4052,11 @@ static int smu7_program_display_gap(struct pp_hwmgr *hwmgr)
 
 	data->frame_time_x2 = frame_time_in_us * 2 / 100;
 
+	if (data->frame_time_x2 < 280) {
+		pr_debug("%s: enforce minimal VBITimeout: %d -> 280\n", __func__, data->frame_time_x2);
+		data->frame_time_x2 = 280;
+	}
+
 	display_gap2 = pre_vbi_time_in_us * (ref_clock / 100);
 
 	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_DISPLAY_GAP_CNTL2, display_gap2);
-- 
2.20.1



