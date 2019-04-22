Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA03B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963435;
	bh=BmdhfD4EjSXJXQHlLjr8SqPmfjbDBjGXJ1txgd+5bO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYu32Ol6DKsBwsWTZxqO3p1Pz5Jum1pnWGI7K2jeWZSTMtNTZiSkdMiTINuG6XR/P
	 OMx5a2nIDnz4pnGcV4hi2BW5nheIofhhBIZ2kimi4kag0IW0U+pNLUFYab5mfvgPLH
	 MM5gYV7p0BmXaBA2lcVe65VaZjS/DMLGn8ygauzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfDVUDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbfDVTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9B5218FC;
        Mon, 22 Apr 2019 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962347;
        bh=BmdhfD4EjSXJXQHlLjr8SqPmfjbDBjGXJ1txgd+5bO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYjE/sc09YDsCPnZ8ihmrl1fJ8su9b8V3ER4lR4ITyvNrdWqmtFAZDlxO+VulW+Ys
         2bJS68pTxrSjPGPv3y4ch0oT2R9v0MojpMlgdF2kJazzZHMzSXF9H5Ojo4AVb98d5d
         lWn3aEqYcNyaELFJCQvZR4HjHjhFUZjPkO+EAlZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/68] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date:   Mon, 22 Apr 2019 15:44:24 -0400
Message-Id: <20190422194516.11634-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit ac0cdb3d990108df795b676cd0d0e65ac34b2273 ]

Add the missing uart_unregister_driver() and i2c_del_driver() before return
from sc16is7xx_init() in the error handling case.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 47b41159a8bc..55b178c1bd65 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1481,7 +1481,7 @@ static int __init sc16is7xx_init(void)
 	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
 #endif
 
@@ -1489,10 +1489,18 @@ static int __init sc16is7xx_init(void)
 	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
-		return ret;
+		goto err_spi;
 	}
 #endif
 	return ret;
+
+err_spi:
+#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
+	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
+#endif
+err_i2c:
+	uart_unregister_driver(&sc16is7xx_uart);
+	return ret;
 }
 module_init(sc16is7xx_init);
 
-- 
2.19.1

