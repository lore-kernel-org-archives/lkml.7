Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF85C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907F520873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfGSM1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:27:32 -0400
Received: from shell.v3.sk ([90.176.6.54]:41313 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfGSM1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:27:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AEECC49112;
        Fri, 19 Jul 2019 14:27:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 34WDe8hZMmYk; Fri, 19 Jul 2019 14:27:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E31AE4911E;
        Fri, 19 Jul 2019 14:27:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Ji-UDjYCTN7; Fri, 19 Jul 2019 14:27:20 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CC7FA49112;
        Fri, 19 Jul 2019 14:27:19 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] spi: pxa2xx: Balance runtime PM enable/disable on error
Date:   Fri, 19 Jul 2019 14:27:13 +0200
Message-Id: <20190719122713.3444318-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't undo the PM initialization if we error out before we managed to
initialize it. The call to pm_runtime_disable() without being preceded
by pm_runtime_enable() would disturb the balance of the Force.

In practice, this happens if we fail to allocate any of the GPIOS ("cs",
"ready") due to -EPROBE_DEFER because we're getting probled before the
GPIO driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc7ab4b268802..22513caf20006 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1831,14 +1831,16 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 	status =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (status !=3D 0) {
 		dev_err(&pdev->dev, "problem registering spi controller\n");
-		goto out_error_clock_enabled;
+		goto out_error_pm_runtime_enabled;
 	}
=20
 	return status;
=20
-out_error_clock_enabled:
+out_error_pm_runtime_enabled:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
=20
 out_error_dma_irq_alloc:
--=20
2.21.0

