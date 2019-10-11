Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8CDECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E22D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfJKKjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:39:55 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:54935 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfJKKjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:39:55 -0400
X-QQ-mid: bizesmtp23t1570790374tpdxnqye
Received: from wuxy.com (unknown [183.62.170.245])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 11 Oct 2019 18:39:26 +0800 (CST)
X-QQ-SSF: 01400000008000O0LJ42000B0000000
X-QQ-FEAT: Ry58bBY793t716lSANFTk6Wsdz3DFhmBx5MtWyIw9iXy5dqK2GlSsJam03thk
        NLuom7gu8W0uFtD4eduHkHKoxiyrRez8O0Xc1wIg3dDpHmMViPotevwjOhE7srafBf6BxWO
        AKqQs8sxiX+Uj3OWdWh+OfKd8RlACnjDEyDEsGp7lUcCy620sQU52JQbZdcXpjnaniTVIjR
        6tfhON4xVCco7PmaPB41C5WKaSmpCx9FLzItSdOLAZZZVluWqVU9Ye2UCnxXqlpfg6PUhCb
        FSinZpzVo+P3p1ONByWVgoQCAa3p9flFMuuKMoikmQDxYy1eEIy3sSMYNcPnOtpoXnP5bXN
        nqBFMy4Xl4iGlZLH8c=
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dongchun.zhu@mediatek.corp-partner.google.com, tfiga@google.com,
        drinkcat@google.com, wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] media: ov5695: enable vsync pin output
Date:   Fri, 11 Oct 2019 18:39:02 +0800
Message-Id: <20191011103902.3145-1-wuxy@bitland.com.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuxy <wuxy@bitland.corp-partner.google.com>

For Kukui project, the ov5695 vsync signal needs to
be set to output,from ov5695 datasheet,the related
register control methods as follows:

0x3002 Bit[7] FISIN/VSYNC output enable
0x3010 Bit[7] enable FISIN/VSYNC as GPIO controlled by register
0x3008 Bit[7] register control FISIN/VSYNC output

TEST= boot to shell

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
---
 drivers/media/i2c/ov5695.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
index 34b7046d9702..71f0eae6037b 100644
--- a/drivers/media/i2c/ov5695.c
+++ b/drivers/media/i2c/ov5695.c
@@ -300,6 +300,9 @@ static const struct regval ov5695_global_regs[] = {
  * mipi_datarate per lane 840Mbps
  */
 static const struct regval ov5695_2592x1944_regs[] = {
+	{0x3002, 0x80},
+	{0x3008, 0x80},
+	{0x3010, 0x80},
 	{0x3501, 0x7e},
 	{0x366e, 0x18},
 	{0x3800, 0x00},
-- 
2.17.1



