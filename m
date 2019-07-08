Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F7C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CAE21738
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599806;
	bh=FhcM5VeW8ZZjsBlZDLj55rh8i7coumNg9yBxsPa8s8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrY9r7/JS3NkonOuUI1sCOOg6FQcia5oCRlziuF4NMjkzeKllNM2IPDMIoBPD8q1b
	 V9/+mCscQnd+Y9vKffaNZgW6r+uMQ+9FuVsZJYZflYk44EMWKjFeVc3+ZOIjiFBro9
	 hP3xRukzirvbVurkaGiAIzXu5H6r0L3rvQObdTL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbfGHPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389646AbfGHP3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:29:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D8821537;
        Mon,  8 Jul 2019 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599787;
        bh=FhcM5VeW8ZZjsBlZDLj55rh8i7coumNg9yBxsPa8s8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVeuvxX/E+6tAPINuE22Kj3wsSy4ZK5YZE11pDKwYKj5JRT9xRLY1s3lV37FFTOBR
         DgFnnTu6u5lpbBOUfdq4RVxZYejdbqie/D5ByOsWbjy1tnnXoTr5KQK66eASvID43g
         JchCBFMPXX2VCs79u4jj1NY/Q/GLkyX8EoVbeHXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 78/90] sc16is7xx: move label err_spi to correct section
Date:   Mon,  8 Jul 2019 17:13:45 +0200
Message-Id: <20190708150526.296761684@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e00164a0f000de893944981f41a568c981aca658 ]

err_spi is used when SERIAL_SC16IS7XX_SPI is enabled, so make
the label only available under SERIAL_SC16IS7XX_SPI option.
Otherwise, the below warning appears.

drivers/tty/serial/sc16is7xx.c:1523:1: warning: label ‘err_spi’ defined but not used [-Wunused-label]
 err_spi:
  ^~~~~~~

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 55b178c1bd65..372cc7ff228f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1494,10 +1494,12 @@ static int __init sc16is7xx_init(void)
 #endif
 	return ret;
 
+#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
 err_spi:
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
 	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
 #endif
+#endif
 err_i2c:
 	uart_unregister_driver(&sc16is7xx_uart);
 	return ret;
-- 
2.20.1



