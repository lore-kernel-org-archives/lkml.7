Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01BCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B517C206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892949;
	bh=pyrg+z/7eKmpFw42kpMU9376OOflt9hc68pQE0WBeIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRSpdw8Vpk184+XSjWpx3SzeD6z7wt/ZjU7x5YSMwZ+m9pZRh72BtlV7ozRbr6kE0
	 GIgUTnm3stXaBsnfLUN8K/gLs8zHDbyEtquaWU87Qdd7Ijy+db4hn2lgPvmJlmKWdf
	 jLr9ugGR2eRShZYN79mZnvuOn9e+GnXw0pBI/8oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfH0IC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbfH0ICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:02:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF2020828;
        Tue, 27 Aug 2019 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892929;
        bh=pyrg+z/7eKmpFw42kpMU9376OOflt9hc68pQE0WBeIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHVMloqXoPzx4dgz68BMFfa9oNK8S3A0oI9BEls452rtrd6SeFfST5TCjD50J4FB/
         tSr+WuZmHekJrDpt3rAuKF61bGNPCKds9wplDMZIBAkalc6CQSIzVU2ozD8GIZN4e0
         ewTLkPkwfTFHbkIYJeGVB+nP7ZhkPXgbJy8ISNv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 020/162] spi: pxa2xx: Balance runtime PM enable/disable on error
Date:   Tue, 27 Aug 2019 09:49:08 +0200
Message-Id: <20190827072739.027638612@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1274204542f683e1d8491ebe9cc86284d5a8ebcc ]

Don't undo the PM initialization if we error out before we managed to
initialize it. The call to pm_runtime_disable() without being preceded
by pm_runtime_enable() would disturb the balance of the Force.

In practice, this happens if we fail to allocate any of the GPIOS ("cs",
"ready") due to -EPROBE_DEFER because we're getting probled before the
GPIO driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://lore.kernel.org/r/20190719122713.3444318-1-lkundrak@v3.sk
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index af3f37ba82c83..c1af8887d9186 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1817,14 +1817,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	status = devm_spi_register_controller(&pdev->dev, controller);
 	if (status != 0) {
 		dev_err(&pdev->dev, "problem registering spi controller\n");
-		goto out_error_clock_enabled;
+		goto out_error_pm_runtime_enabled;
 	}
 
 	return status;
 
-out_error_clock_enabled:
+out_error_pm_runtime_enabled:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
 
 out_error_dma_irq_alloc:
-- 
2.20.1



