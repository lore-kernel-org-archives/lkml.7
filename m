Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D867C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5E82064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334901;
	bh=sDvHS/1dTtexsX4npEmyGH8qV1SFth8DCGf/8hb5LOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eYDTdJDym1YYyiJE4Wq2PehrlWBWbtEiMbNc1llZHPobIgNf4iLEb7mkfObm6t85w
	 j48rHz0fKf7tYsKzIRe4847xwexvzw3nI9mLOP4Ppczfgi424O+URvRnjCUSYfEVlr
	 tDNvGUlysdB+7R8Rwde/iq000acc3gXKEUHfDBZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfCKT5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfCKT5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EE8214AE;
        Mon, 11 Mar 2019 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334225;
        bh=sDvHS/1dTtexsX4npEmyGH8qV1SFth8DCGf/8hb5LOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gar2vVVPSPJ3WHOHIIWsml7Hi10RHr349961jk/C3Rp81FhPXcgAs7DfLvnPng5gR
         h1VfuuZC48e7xbMTBZWoAmOxsZUZCRTEjfGQELyhwWr+vbJBLZLx+LFucSmFFw9QD1
         uGHE73zLGQqKswWl3MgXwqqZAnFjiPDI+gVnqSok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 04/44] gpu: ipu-v3: Fix CSI offsets for imx53
Date:   Mon, 11 Mar 2019 15:56:20 -0400
Message-Id: <20190311195700.138462-4-sashal@kernel.org>
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
index 5b7cdbfe062f..0a7d4395d427 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -914,8 +914,8 @@ static struct ipu_devtype ipu_type_imx53 = {
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

