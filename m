Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B328C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F8A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334924;
	bh=xJAIW4ZZsYYo8sQDqgKDMkwjJG6EinVHEuX8kR+JgI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqNMcHZof04puSuUKtpo1s1mld0WJYk2nWURFYEgyBf1iUhf9Q88UaEwfNDdBEw4b
	 jY1ZUov5wBnkfDLwzl2qEmIZk4kRdgD8TPuxYBjX9f3jXdmywuMgbzDD8EQBLon8NN
	 8Otx3Zzz5er37lZsoR8gFS3bVP7MswlpN5Fas7v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfCKUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbfCKT5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85071214AF;
        Mon, 11 Mar 2019 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334223;
        bh=xJAIW4ZZsYYo8sQDqgKDMkwjJG6EinVHEuX8kR+JgI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrXiay2+srrJdvLOwDCVjw8vprQbdplVKOQPxIGlZRRKTLfwLbP6lOSqRJThvyKF0
         EurWzki1qkp3Ex+NIDew/0NiO6GWkvdKx6mC98SPCAAGnqhrqFjZED83WbVKBBV+uk
         weAOdkg0eKj6u9pDCpkjsgUBFy7amSE8QLI8WCHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 02/44] gpu: ipu-v3: Fix i.MX51 CSI control registers offset
Date:   Mon, 11 Mar 2019 15:56:18 -0400
Message-Id: <20190311195700.138462-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
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
index 474b00e19697..5b7cdbfe062f 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -898,8 +898,8 @@ static struct ipu_devtype ipu_type_imx51 = {
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

