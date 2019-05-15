Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5220675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922380;
	bh=8cgPjWbl6HPAC1RR8pT7d4K1TnN/Zpzs6aXY9cSY86k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5HvMktemMeRFlzORIIleewnFgS30gMMMvYfc/nHIiKPxp1+KpNYQx/siwub3yFhc
	 JdtTeDhg4Q0dTJsXP+KkdC9JejfOr35kq+3nGt8fes2IyMzSxdpqkPgBwYr6SfnOjn
	 5sekXsB8Cq7gfUnwumqw6ue4BfxlPjCbivkT5uZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfEOMM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfEOLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:05:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C382084F;
        Wed, 15 May 2019 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918326;
        bh=8cgPjWbl6HPAC1RR8pT7d4K1TnN/Zpzs6aXY9cSY86k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgpIECQIRnLrX0IV7TCvaX3OpsjFv2nHtYd0ftKCtph/j1fOfOSB4+mDex9mevdG6
         CzutNmZ2xbm+yjGJTay1hOxX+ZRDYeHAOqDBZrRuz24M7zBeIeGdsytKYN1uy7rmVo
         SifwLR1IyYTPkDeYSn4N0r3ZBpg4cwcIsVvSv618=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.4 091/266] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date:   Wed, 15 May 2019 12:53:18 +0200
Message-Id: <20190515090725.525024750@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 17a22073d226..032f3c13b8c4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1448,7 +1448,7 @@ static int __init sc16is7xx_init(void)
 	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
 #endif
 
@@ -1456,10 +1456,18 @@ static int __init sc16is7xx_init(void)
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



