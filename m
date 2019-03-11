Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BDCC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDDC2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334511;
	bh=PPH5aHjeLPaNp2dBcs6dctkKFI18u8eqr7r6E163Ye4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nJbVfQ+2Wram8IOsoYKgQ54q8SKgoIpn2Zf4VT2wTuPMb/Tsrm9Rgyb5LQzILhS3+
	 o90SjN4Bz+RM4Vxr4H+rVGHHCi4+vQcGTEh/Of9Tm2+vyB6ULmtMoeZEA+UHknQ3+a
	 HuyRMXNPc/GucsCJ7u+DQfcU0FlI6Q7hd8DiITD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfCKT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbfCKT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5C32087C;
        Mon, 11 Mar 2019 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334354;
        bh=PPH5aHjeLPaNp2dBcs6dctkKFI18u8eqr7r6E163Ye4=;
        h=From:To:Cc:Subject:Date:From;
        b=OMiYl1n40C8XYNJa0Bn2u/RmHTp+WA2vItyC3HTnmH7I1E4dVx68rBrFBJq198VSC
         xOZ2LGKt++dMUU44wnQVtYPva+HPsOWU3H7scYZuuMPzIkt37lCm4VbQUlXmsurOvF
         jVUQoNdSQjofQiW7uIezFnsDglLAGXLAiGzeqi1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 01/12] gpu: ipu-v3: Fix i.MX51 CSI control registers offset
Date:   Mon, 11 Mar 2019 15:59:01 -0400
Message-Id: <20190311195912.139410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shiyan <shc_work@mail.ru>

[ Upstream commit 2c0408dd0d8906b26fe8023889af7adf5e68b2c2 ]

The CSI0/CSI1 registers offset is at +0xe030000/+0xe038000 relative
to the control module registers on IPUv3EX.
This patch fixes wrong values for i.MX51 CSI0/CSI1.

Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 99c813a4ec1f..d41983f3ad3e 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -884,8 +884,8 @@ static struct ipu_devtype ipu_type_imx51 = {
 	.cpmem_ofs = 0x1f000000,
 	.srm_ofs = 0x1f040000,
 	.tpm_ofs = 0x1f060000,
-	.csi0_ofs = 0x1f030000,
-	.csi1_ofs = 0x1f038000,
+	.csi0_ofs = 0x1e030000,
+	.csi1_ofs = 0x1e038000,
 	.ic_ofs = 0x1e020000,
 	.disp0_ofs = 0x1e040000,
 	.disp1_ofs = 0x1e048000,
-- 
2.19.1

