Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEEDC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791A2168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994585;
	bh=A/TXVE+yqDvwjI8X4c4af99X4EHTJU5S6bLnXy6bNEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBDVopwt6xpyFiiSeFIFCfCCufcfXORV3MTKJ4F8V1MTM/fJI+ATA9PhG8JBC69UW
	 XIvKjbh+IfSbAjGJd3KYmazjnd/sAyTUnCZdVWDruuYyYCQIBxGI8toj6IbRxzsc84
	 hRM4FgarVYUIjfzZzrjO0sz6Mn27hTfoAqaBivLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfFHLto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbfFHLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:49:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98DD021537;
        Sat,  8 Jun 2019 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994540;
        bh=A/TXVE+yqDvwjI8X4c4af99X4EHTJU5S6bLnXy6bNEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1jxq9/e8QnZXM/Skgu2eBkFjXazIILYwQMrFjyuNdf1O0SGoF5T9nc4gr9xglbmO
         lUtaBbHFsz5WS7mkDXfkel0+vsxZQcBIki1aTOmYTc2OmnwUz3CtXyLjgNMwgNvSgz
         t7ly2OklAB5ETOobYs3vclzcMOoBOGFMsQcTGglo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/13] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date:   Sat,  8 Jun 2019 07:48:39 -0400
Message-Id: <20190608114847.9973-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114847.9973-1-sashal@kernel.org>
References: <20190608114847.9973-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

[ Upstream commit a0692f0eef91354b62c2b4c94954536536be5425 ]

If I2C_M_RECV_LEN check failed, msgs[i].buf allocated by memdup_user
will not be freed. Pump index up so it will be freed.

Fixes: 838bfa6049fb ("i2c-dev: Add support for I2C_M_RECV_LEN")
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 57e3790c87b1..e56b774e7cf9 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -295,6 +295,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			    rdwr_pa[i].buf[0] < 1 ||
 			    rdwr_pa[i].len < rdwr_pa[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
+				i++;
 				res = -EINVAL;
 				break;
 			}
-- 
2.20.1

