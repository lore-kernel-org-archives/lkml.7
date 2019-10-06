Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD3C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDC920862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383688;
	bh=0QVKQtbYTzc53uwo95bKg2rV7mwigxbBZrR2N+aprkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YXflUzkqIZr0yZZ/D1trrgpL3yXkrcSuoh8RDNTv/ZjnIlJuTMb1Z1o+HmDCdg2Fk
	 qimEnLnJ5noopj80+sm3+KzqGkQFlj+e05g1xLUqV5hHARAGGgcoSE+Aluvt0YrBlv
	 55UrPxWaZpG9OY+3BessGjR4NrUEtW1KrBPjyXfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfJFRl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731190AbfJFRlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:41:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55112053B;
        Sun,  6 Oct 2019 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383682;
        bh=0QVKQtbYTzc53uwo95bKg2rV7mwigxbBZrR2N+aprkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqHXmR1YqIcH4IkgjO/vLxCFkEMataewDto+HquupwTW5zKgYmzw6Wp//YuTnMlMb
         z0YGDrLn35Li01zTrMiQqsKTX6ZO0oIARPf73jSm0ivNkBD3HlW28VSwuXHd8K6vIr
         zayHemS5r0EVf652uyYDxZHlyZtP+l5qN8P07E2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Wang <kevin1.wang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 056/166] drm/amd/powerpaly: fix navi series custom peak level value error
Date:   Sun,  6 Oct 2019 19:20:22 +0200
Message-Id: <20191006171217.804235485@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Wang <kevin1.wang@amd.com>

[ Upstream commit 706feb26f890e1b8297b5d14975160de361edf4f ]

fix other navi asic set peak performance level error.
because the navi10_ppt.c will handle navi12 14 asic,
it will use navi10 peak value to set other asic, it is not correct.

after patch:
only navi10 use custom peak value, other asic will used default value.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index b81c7e715dc94..9aaf2deff6e94 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1627,6 +1627,10 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 static int navi10_set_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
 {
 	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->asic_type != CHIP_NAVI10)
+		return -EINVAL;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-- 
2.20.1



