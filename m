Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EDC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41357222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611727;
	bh=8Gh9QFWIcV8gouhNwtcnLmaTG574i/mtCXf99Tt1wrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g4+hrtCUFmSSbmQqJSNi7O+i9mHy0R8L6NK7q/s0lOFywAaYSFR/7DaDyhvkeHICj
	 QZHhMdaH9v3OsZyA/2IAITjcMi1DS3CA79wB8brMuYYdh2jh9s0L+CTuuBqxGkQ0bu
	 /z6AotGwFLn29nvNeck2QT+bM8U1Ywp41iIF2lz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfKMCWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfKMBxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:53:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA12222CD;
        Wed, 13 Nov 2019 01:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610015;
        bh=8Gh9QFWIcV8gouhNwtcnLmaTG574i/mtCXf99Tt1wrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4P6fxedszWsIDD8EyeS8KZy/1YujwT4JHV5+sWUMN9u5UQWaRgyvoU400Yg9AIu3
         Oda59DeRppznecPn1V3ye4HC4m3b8vqN0NgfkYBrDXmyxvQJk934VrAWOdHPt2Ofze
         C65lkAKLF86SPOz5+gKcPpNM3YE4SF699wFLjMlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/209] i2c: zx2967: use core to detect 'no zero length' quirk
Date:   Tue, 12 Nov 2019 20:48:55 -0500
Message-Id: <20191113015025.9685-119-sashal@kernel.org>
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

