Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CECC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB17246A0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012137;
	bh=4lvf0WVJkiCaK/sGncCOHh8sp07BDq1hgg2ES55yXR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aD3TTJ5bG7iCU7exsxDDRTZDvTIqSpDAAs3y+NKd3ImxXZGZgycUHPBLh1Yu086+L
	 GGUasgUxycCEac3PHrIx55cP86+Rot2+DS20G6tlu+8D6I1Q68v6uQ1l2o0V/fsH7A
	 4bH5xDq5v0rRcMMgwaumFY2mGt/eN7KwFt7HE6t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLJVI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfLJVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F364E20652;
        Tue, 10 Dec 2019 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012126;
        bh=4lvf0WVJkiCaK/sGncCOHh8sp07BDq1hgg2ES55yXR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAxF2wFt/YxO4vXdFAvoCNe9hOFY5tvSAClWo3rkIVnqb47LpS/O/h6fvlJ/7PU5r
         PKl52tZfxXUhI2PgUrvCL8XSiDVt9aXnoZHV8oW6XWMfdMbZtcwSpCh9EZJqsEfbNx
         mpgRa485iIc3hGPw9iBCW0vT7iYwMPavjB4iogMM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josip Pavic <Josip.Pavic@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 096/350] drm/amd/display: wait for set pipe mcp command completion
Date:   Tue, 10 Dec 2019 16:03:21 -0500
Message-Id: <20191210210735.9077-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josip Pavic <Josip.Pavic@amd.com>

[ Upstream commit 15caeabc5787c15babad7ee444afe9c26df1c8b3 ]

[Why]
When the driver sends a pipe set command to the DMCU FW, it does not wait
for the command to complete. This can lead to unpredictable behavior if,
for example, the driver were to request a pipe disable to the FW via MCP,
then power down some hardware before the firmware has completed processing
the command.

[How]
Wait for the DMCU FW to finish processing set pipe commands

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 58bd131d5b484..7700a855d77ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -77,6 +77,9 @@ static bool dce_abm_set_pipe(struct abm *abm, uint32_t controller_id)
 	/* notifyDMCUMsg */
 	REG_UPDATE(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 1);
 
+	REG_WAIT(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, 0,
+			1, 80000);
+
 	return true;
 }
 
-- 
2.20.1

