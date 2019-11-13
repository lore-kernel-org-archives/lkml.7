Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C510C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF76722470
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610110;
	bh=7uykPxA/I2LccFSMWbafqDlyn70uAtU8Wu+4C3s1Uj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yj+OSUgsRyWLDbrQ6ieKUF7/G5pxbcJcaQ/w+TZAbgahb5Xp6dD3LWEs06TPB9ym1
	 O/lKliu6OZkC4pT5iRAIOJJyujWXIejoStjtdDAeaEvqQka2MbxZrdzDCuB9bihl5v
	 Voqwr3OFeUX/Z0LrxGmlhp1gPVCXFzvBuij0X7/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfKMBzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfKMBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77FB22469;
        Wed, 13 Nov 2019 01:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610107;
        bh=7uykPxA/I2LccFSMWbafqDlyn70uAtU8Wu+4C3s1Uj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJdceq92Ln+CaOTub+WuHZKl2PhW37kbHrrGyxaJym+ZDvfShFm2QW4ShmQYSjdup
         lHj7CjjOghxt9GSBOKWJBnZzZzaMpD2CWqqS23aNZ9/7C0zgkCz1S/e+3dBEleXsmB
         jiBX9/IwToVeUa/7hGBJOiWWn05AUdpibs95lR78=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 165/209] media: cx231xx: fix potential sign-extension overflow on large shift
Date:   Tue, 12 Nov 2019 20:49:41 -0500
Message-Id: <20191113015025.9685-165-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 32ae592036d7aeaabcccb2b1715373a68639a768 ]

Shifting the u8 value[3] by an int can lead to sign-extension
overflow. For example, if value[3] is 0xff and the shift is 24 then it
is promoted to int and then the top bit is sign-extended so that all
upper 32 bits are set.  Fix this by casting value[3] to a u32 before
the shift.

Detected by CoverityScan, CID#1016522 ("Unintended sign extension")

Fixes: e0d3bafd0258 ("V4L/DVB (10954): Add cx231xx USB driver")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/cx231xx/cx231xx-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index f7fcd733a2ca8..963739fa86718 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -1389,7 +1389,7 @@ int cx231xx_g_register(struct file *file, void *priv,
 		ret = cx231xx_read_ctrl_reg(dev, VRT_GET_REGISTER,
 				(u16)reg->reg, value, 4);
 		reg->val = value[0] | value[1] << 8 |
-			value[2] << 16 | value[3] << 24;
+			value[2] << 16 | (u32)value[3] << 24;
 		reg->size = 4;
 		break;
 	case 1:	/* AFE - read byte */
-- 
2.20.1

