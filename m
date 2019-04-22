Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096CC21902
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962464;
	bh=R/HUFxUa0/fbEkv4X1z2uI3FmAhvsMpuPXyY+0GrpRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=loU4dOUG9DvwpXXpwG5NQUD8Vtm8gH++41W568v2vAb72ykkpRir/0RMAxN+niEOj
	 z5EH0Og6n957NBtAbmRrqBsvQGcV0Y88q/E9aZfMI5uKQIWn4M4UQUhqp7w97mLkYt
	 kzIzCKtd7E8a6TNcRayx+Nxa2vZ37gz5/41mSduI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfDVTrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbfDVTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1237E21904;
        Mon, 22 Apr 2019 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962457;
        bh=R/HUFxUa0/fbEkv4X1z2uI3FmAhvsMpuPXyY+0GrpRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+ZgULdV6UHHZUttGtpOF/+60ogAckel5nGJc7zWTnMjYn+dej7FDm1xPINlG65CJ
         6CHM3WEZncMadCGbC4kFYdNbnR01/EZbbRoP3ATjrEfJLKRiKt8BT6RDmZ73iey/oP
         5XRngQZV/mqxLL39UbjjArqBvLuj3CgwHKsBeDmE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/43] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date:   Mon, 22 Apr 2019 15:46:51 -0400
Message-Id: <20190422194727.12495-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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
index a79f18edf2bd..e48523da47ac 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1483,7 +1483,7 @@ static int __init sc16is7xx_init(void)
 	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
 #endif
 
@@ -1491,10 +1491,18 @@ static int __init sc16is7xx_init(void)
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

