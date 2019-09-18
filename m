Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D760C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286FF21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788196;
	bh=7HJG+tyke0aMUoyf9Jd+F8sWEbOTMi+IfHKsAHxKB3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AC1BHjAinZ4nDrvytfw36QhrSd+J14y6avWXIIQ2y2bz/+XcW9fjGgfXSkcKKKByc
	 5SdzwtdJHmoNgg7Wk7G/RVYC2ytxOZcCbOKjKtaLRneKivE9vqDUME2Fxix2qRxKe+
	 AD+lwLocYD3zm6IRvpjCby/qxYlN7WO/Tt2vpkvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfIRGZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfIRGZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:25:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58AF821924;
        Wed, 18 Sep 2019 06:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787919;
        bh=7HJG+tyke0aMUoyf9Jd+F8sWEbOTMi+IfHKsAHxKB3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NFQBDEmuYAFm3EByUGNC6mET7y5UKh3vxl+Z/qLAXVoWJMiPriOI6/qpPIjoi5TI
         jIgoIFwgiB0oyAfo6bgrsr6bzAO413mINL/SDyXFyx6IbW/aJtVTJJKF46AHS0v7/G
         NPe1UcSb0wmVywkCNZgc2zgbz/PflltHAK1DKZvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5.2 31/85] mmc: tmio: Fixup runtime PM management during remove
Date:   Wed, 18 Sep 2019 08:18:49 +0200
Message-Id: <20190918061235.139292345@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 87b5d602a1cc76169b8d81ec2c74c8d95d9350dc upstream.

Accessing the device when it may be runtime suspended is a bug, which is
the case in tmio_mmc_host_remove(). Let's fix the behaviour.

Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/tmio_mmc_core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1284,12 +1284,11 @@ void tmio_mmc_host_remove(struct tmio_mm
 	struct platform_device *pdev = host->pdev;
 	struct mmc_host *mmc = host->mmc;
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ)
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 
-	if (!host->native_hotplug)
-		pm_runtime_get_sync(&pdev->dev);
-
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
 	mmc_remove_host(mmc);
@@ -1298,6 +1297,8 @@ void tmio_mmc_host_remove(struct tmio_mm
 	tmio_mmc_release_dma(host);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (host->native_hotplug)
+		pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }


