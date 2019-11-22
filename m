Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A020718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420932;
	bh=ZMIpm2eGoF1gz+prN8Rj5RSMJQK+YlymFSmMKKZXimg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFrB59I4QhGOobSptYKU59xAHkgrLFO6/rXnp1PlE4pHTl8iCkwZJJCHV6/7t1pWc
	 Kztr55krbf/3NDmdBBr+crxdOlMEUN1BmUa2ycm65pAUqrcnPxWywlUM0V9CGs5uyL
	 hMrQU6NbsfZ0unZKr754O2WBh8lpRh4UlrCw5PdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfKVLD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfKVLDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DAE20659;
        Fri, 22 Nov 2019 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420631;
        bh=ZMIpm2eGoF1gz+prN8Rj5RSMJQK+YlymFSmMKKZXimg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13cCQ1LGZ7LY0Cyt0xRFlQt/7c/1wYZCbkk6ptBpNFDn32IvuDHY9Im55TuIIGFqj
         Eoeh05ohFYg28skBf/73UwTM84XoWzlpzSEFg86UDhawDC/IPrmN5Ltagq3GYqpxQ9
         5NsntdDmO51v6Ve4ha1PoR8MzHi7z07R1q8hZF4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/220] i2c: tegra: use core to detect no zero length quirk
Date:   Fri, 22 Nov 2019 11:28:14 +0100
Message-Id: <20191122100922.101651124@linuxfoundation.org>
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

[ Upstream commit c96c0f2683804b710531e7b754dcd02b5ded6d4a ]

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index ef13b6ce9d8de..47d196c026ba6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -684,9 +684,6 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	i2c_dev->msg_buf = msg->buf;
 	i2c_dev->msg_buf_remaining = msg->len;
 	i2c_dev->msg_err = I2C_ERR_NONE;
@@ -831,6 +828,7 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 
 /* payload size is only 12 bit */
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
 	.max_read_len = 4096,
 	.max_write_len = 4096 - 12,
 };
-- 
2.20.1



