Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057A2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420777;
	bh=7uykPxA/I2LccFSMWbafqDlyn70uAtU8Wu+4C3s1Uj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUng8GMVm7nrLvnNbl6ZBbEc/rjAHmWEhGrVPt0H1xfBZw+jWcz8QctqEg0/TBybs
	 E2eXL8XSSoAtixfbybm+JsPSg+8GZhrFONbBhvOfvD31MjWSoyaXtwVqBsIrFGeHjp
	 7JprR8hFTTYpF1lyvwt6j5zU43vZ7uiQNjpb9fPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfKVLGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbfKVLGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:06:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5082075E;
        Fri, 22 Nov 2019 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420770;
        bh=7uykPxA/I2LccFSMWbafqDlyn70uAtU8Wu+4C3s1Uj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5G5EXlJY10mnQzQhAnsPuV68Fx+9lLlBG67GVwUSbPhxkbSELjkO/nQ3ZapzCLyS
         6RGCWSWrwN/5Eh82whn/YynJg7K61a9LYv7ciT1odIgtVI05Egj8BzaCbBWJOOyyx4
         6cy+7vcyWUgbCxFaqiEqz28Hy8oY7V7SCVxG2kCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 176/220] media: cx231xx: fix potential sign-extension overflow on large shift
Date:   Fri, 22 Nov 2019 11:29:01 +0100
Message-Id: <20191122100925.510342763@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



