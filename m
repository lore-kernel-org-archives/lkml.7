Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D699C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF182081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810539;
	bh=vLXS432av09FdBWmbsEExAd5hI/MoCFe43TN5MeqgbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BDz2ulYnhPrPObx8ttF9vb4Ri00Z/KVVwHRsmbXxF1kKrbTKNHvdGEJjLZMMG/tPh
	 yd22YdUwcfqgkNCw0QpSgRI4kV/8dQ6AKQWOpEH67PEvEUV3GuSJvZVdhaIsw2eL+M
	 cltD19yirqOPCfsSOolMrZTv1jxo3kt2ys/fGe90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEBPWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfEBPWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:22:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D361D214DA;
        Thu,  2 May 2019 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810535;
        bh=vLXS432av09FdBWmbsEExAd5hI/MoCFe43TN5MeqgbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8ukNH+kT0baf64Ynj5yTIrqOp5vVQ2K215TumBS2nWxoFwYoCVMU4+laY5X1DYud
         hCsaq5hcBFSfbRePuu9A/3VKInnSgIoJj37tHU2gx0V5tomvh6qS/NxVpbRk6rzY0a
         uI1u+rd7PB5I4ARPjR8bTYcQEVX2lTiaUvspxoVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.9 09/32] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date:   Thu,  2 May 2019 17:20:55 +0200
Message-Id: <20190502143318.010452403@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
References: <20190502143314.649935114@linuxfoundation.org>
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
index ea6b62cece88..82451bb6622b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1482,7 +1482,7 @@ static int __init sc16is7xx_init(void)
 	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
 #endif
 
@@ -1490,10 +1490,18 @@ static int __init sc16is7xx_init(void)
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



