Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3CB20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442869;
	bh=V4eMEYHwbofiKkxkA3V3kHxUOdCXyPa4yfpH7qHKo4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBtGdJ6kansVV5mddq2jaV3rTXgr6Ji+T1xw6MHTYuv/cm2MrP1tR+vlqzIzYz91X
	 1Io4w8PKVjoewmFmxZfpD5y+rheVujFB/PNJrSLP5Yea1GSedwwyGRAJzJWxMnuSaU
	 DMoyJviiZyMQmqz7QkicQ6MvBEYdQvrditblErbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392177AbfFMQVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfFMIjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:39:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3915A21473;
        Thu, 13 Jun 2019 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415142;
        bh=V4eMEYHwbofiKkxkA3V3kHxUOdCXyPa4yfpH7qHKo4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9N2OhU0rKvBjegUBgJV5XRECnwqkViCix8V41VwLr2h/sIuEvflSD+M52W/ZvG9a
         pjARg7vt5bGo54CjWdMmo6n8C/eaVr0jzRMRS0RBDzg5oWddAC7BcHqC9O9W7Myq+o
         1zWz9cdaSy90+XgACI87AAFbjWV8zmcLGiWk7QxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Daniel Gomez <dagmcr@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/118] mfd: tps65912-spi: Add missing of table registration
Date:   Thu, 13 Jun 2019 10:32:37 +0200
Message-Id: <20190613075644.732199440@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9e364e87ad7f2c636276c773d718cda29d62b741 ]

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          spi:tps65912

After this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          of:N*T*Cti,tps65912C*
alias:          of:N*T*Cti,tps65912
alias:          spi:tps65912

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65912-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 3bd75061f777..f78be039e463 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -27,6 +27,7 @@ static const struct of_device_id tps65912_spi_of_match_table[] = {
 	{ .compatible = "ti,tps65912", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tps65912_spi_of_match_table);
 
 static int tps65912_spi_probe(struct spi_device *spi)
 {
-- 
2.20.1



