Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A59C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164CE207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420514;
	bh=8Gh9QFWIcV8gouhNwtcnLmaTG574i/mtCXf99Tt1wrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppCUtSbvZ9C7mfjMs/ewj/1XrgYpw3rUB5aDnSvdYuoMpOGiDjgD62wS+LyZo6kTF
	 USDof2K/7JwtVPMciM8fUxdTSqPFHs/dDuizpye6VPed59TlhxRFlV9kX/Dg1GpCXU
	 R2vG/Eiw38whlRgd6EdarQfeZXAn6dM0Ixcq9Zok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfKVLBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbfKVLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2952120721;
        Fri, 22 Nov 2019 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420504;
        bh=8Gh9QFWIcV8gouhNwtcnLmaTG574i/mtCXf99Tt1wrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMmvvVmZBP7KtgT7bMcF25ev6TvIOYa0IZ4OWqJ2luZUOM0evYTiCZOxJTZBa5lzz
         Y1w0CEG7Yy2MssiqbQ64jAM5vi9n9eb1JOWE3DF6D9Zs6hWGsccs6GYMlbb99Bc8fC
         okEsRI5Hnu4HM3wLn+spAZ2Kd7aasYJb2Iv0kzWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/220] i2c: zx2967: use core to detect no zero length quirk
Date:   Fri, 22 Nov 2019 11:28:15 +0100
Message-Id: <20191122100922.174976206@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit e2115ace4196bcd2126446fb874bcfc90cba79be ]

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index 48281c1b30c6d..b8f9e020d80e6 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -281,9 +281,6 @@ static int zx2967_i2c_xfer_msg(struct zx2967_i2c *i2c,
 	int ret;
 	int i;
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	zx2967_i2c_flush_fifos(i2c);
 
 	i2c->cur_trans = msg->buf;
@@ -498,6 +495,10 @@ static const struct i2c_algorithm zx2967_i2c_algo = {
 	.functionality = zx2967_i2c_func,
 };
 
+static const struct i2c_adapter_quirks zx2967_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct of_device_id zx2967_i2c_of_match[] = {
 	{ .compatible = "zte,zx296718-i2c", },
 	{ },
@@ -568,6 +569,7 @@ static int zx2967_i2c_probe(struct platform_device *pdev)
 	strlcpy(i2c->adap.name, "zx2967 i2c adapter",
 		sizeof(i2c->adap.name));
 	i2c->adap.algo = &zx2967_i2c_algo;
+	i2c->adap.quirks = &zx2967_i2c_quirks;
 	i2c->adap.nr = pdev->id;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
-- 
2.20.1



