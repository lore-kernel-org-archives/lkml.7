Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B07C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0748D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334478;
	bh=RGyObUWDBAVnl77l50LBH4poI955uHJJS/NZQf6BPvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wfnPnT/vtZzhhwcaZ2Chv3mQw5cXsHj1nEZECTvE79O7LP0EQmy2lTzIC5oxygtjI
	 mWEkcP4Xt9j8n+ttBeaRGgnjkyVM/LdmZ67/nW6ac/Ht0t5dnP1sMIJUH6XNqLyprs
	 XBCwBlZTCQTwNjLc2cgChsCVZqEcK4p/MdXJx/9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfCKUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfCKT7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DBA214D8;
        Mon, 11 Mar 2019 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334381;
        bh=RGyObUWDBAVnl77l50LBH4poI955uHJJS/NZQf6BPvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7oKJJftM+e9Eizhzg0LYXbPXcc8U8X1q4woeulXw/At3oSOoW9tSE8LDbuEuBvCs
         lFUuBvfoeQGRuANoIho80vJvj2NrZh7ZDb7sE/oT7lYlTouXYWeSSVKbl5OrJOGllP
         VovxvozMn1103Ha2RR2NwLeg3C98uKhWlS7+oAc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 2/8] gpu: ipu-v3: Fix CSI offsets for imx53
Date:   Mon, 11 Mar 2019 15:59:32 -0400
Message-Id: <20190311195938.139603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195938.139603-1-sashal@kernel.org>
References: <20190311195938.139603-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

[ Upstream commit bb867d219fda7fbaabea3314702474c4eac2b91d ]

The CSI offsets are wrong for both CSI0 and CSI1. They are at
physical address 0x1e030000 and 0x1e038000 respectively.

Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 0c51b1dde494..df295a0ce87d 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -762,8 +762,8 @@ static struct ipu_devtype ipu_type_imx53 = {
 	.cpmem_ofs = 0x07000000,
 	.srm_ofs = 0x07040000,
 	.tpm_ofs = 0x07060000,
-	.csi0_ofs = 0x07030000,
-	.csi1_ofs = 0x07038000,
+	.csi0_ofs = 0x06030000,
+	.csi1_ofs = 0x06038000,
 	.ic_ofs = 0x06020000,
 	.disp0_ofs = 0x06040000,
 	.disp1_ofs = 0x06048000,
-- 
2.19.1

