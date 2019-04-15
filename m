Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB6C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE12073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355864;
	bh=TyvOB/myiN6y87ukWB6Js+umNIu4cPnYaG6mXpQRAAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQX1MU+DkKMKVXtL3hlYIW5XUpr1fiRGtke64ZXh6jKEatWMI1ddI2/WBUEfh8f9z
	 5PQE+6iJPRAnvfBvTHfnplqUbdJnpqNpAwF7FIAMVRbQ+pQ4AwG/hruVJuspqscBUs
	 5U0k6abypzmAu9RnNCaCUYVokolpV3Cdi6MUtq3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfDOTRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731338AbfDOTMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B87F218A1;
        Mon, 15 Apr 2019 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355525;
        bh=TyvOB/myiN6y87ukWB6Js+umNIu4cPnYaG6mXpQRAAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9TWydRk+Jxr8rPe6r6g/RnSiwDbeSd5EgZ4vjH5e3z2nqmL7KOPkz5pdA5NoZMGT
         QBOaQaazLMMY9UUlB2LrPNOSorCWZnn4pgRKjqe14uXJVtmh082KoeRK9L5IppVCAh
         bhC9ezXUsYfODT/hdfwmJoCkv4TuQOEL9NGipQT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 060/117] mmc: alcor: dont write data before command has completed
Date:   Mon, 15 Apr 2019 21:00:30 +0200
Message-Id: <20190415183747.982218804@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

commit 157c99c5a2956a9ab1ae12de0136a2d8a1b1a307 upstream.

The alcor driver is setting up data transfer and submitting the associated
MMC command at the same time. While this works most of the time, it
occasionally causes problems upon write.

In the working case, after setting up the data transfer and submitting
the MMC command, an interrupt comes in a moment later with CMD_END and
WRITE_BUF_RDY bits set. The data transfer then happens without problem.

However, on occasion, the interrupt that arrives at that point only
has WRITE_BUF_RDY set. The hardware notifies that it's ready to write
data, but the associated MMC command is still running. Regardless, the
driver was proceeding to write data immediately, and that would then cause
another interrupt indicating data CRC error, and the write would fail.

Additionally, the transfer setup function alcor_trigger_data_transfer()
was being called 3 times for each write operation, which was confusing
and may be contributing to this issue.

Solve this by tweaking the driver behaviour to follow the sequence observed
in the original ampe_stor vendor driver:
 1. When starting request handling, write 0 to DATA_XFER_CTRL
 2. Submit the command
 3. Wait for CMD_END interrupt and then trigger data transfer
 4. For the PIO case, trigger the next step of the data transfer only
    upon the following DATA_END interrupt, which occurs after the block has
    been written.

I confirmed that the read path still works (DMA & PIO) and also now
presents more consistency with the operations performed by ampe_stor.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Fixes: c5413ad815a6 ("mmc: add new Alcor Micro Cardreader SD/MMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/alcor.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -48,7 +48,6 @@ struct alcor_sdmmc_host {
 	struct mmc_command *cmd;
 	struct mmc_data *data;
 	unsigned int dma_on:1;
-	unsigned int early_data:1;
 
 	struct mutex cmd_mutex;
 
@@ -144,8 +143,7 @@ static void alcor_data_set_dma(struct al
 	host->sg_count--;
 }
 
-static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host,
-					bool early)
+static void alcor_trigger_data_transfer(struct alcor_sdmmc_host *host)
 {
 	struct alcor_pci_priv *priv = host->alcor_pci;
 	struct mmc_data *data = host->data;
@@ -155,13 +153,6 @@ static void alcor_trigger_data_transfer(
 		ctrl |= AU6601_DATA_WRITE;
 
 	if (data->host_cookie == COOKIE_MAPPED) {
-		if (host->early_data) {
-			host->early_data = false;
-			return;
-		}
-
-		host->early_data = early;
-
 		alcor_data_set_dma(host);
 		ctrl |= AU6601_DATA_DMA_MODE;
 		host->dma_on = 1;
@@ -231,6 +222,7 @@ static void alcor_prepare_sg_miter(struc
 static void alcor_prepare_data(struct alcor_sdmmc_host *host,
 			       struct mmc_command *cmd)
 {
+	struct alcor_pci_priv *priv = host->alcor_pci;
 	struct mmc_data *data = cmd->data;
 
 	if (!data)
@@ -248,7 +240,7 @@ static void alcor_prepare_data(struct al
 	if (data->host_cookie != COOKIE_MAPPED)
 		alcor_prepare_sg_miter(host);
 
-	alcor_trigger_data_transfer(host, true);
+	alcor_write8(priv, 0, AU6601_DATA_XFER_CTRL);
 }
 
 static void alcor_send_cmd(struct alcor_sdmmc_host *host,
@@ -435,7 +427,7 @@ static int alcor_cmd_irq_done(struct alc
 	if (!host->data)
 		return false;
 
-	alcor_trigger_data_transfer(host, false);
+	alcor_trigger_data_transfer(host);
 	host->cmd = NULL;
 	return true;
 }
@@ -456,7 +448,7 @@ static void alcor_cmd_irq_thread(struct
 	if (!host->data)
 		alcor_request_complete(host, 1);
 	else
-		alcor_trigger_data_transfer(host, false);
+		alcor_trigger_data_transfer(host);
 	host->cmd = NULL;
 }
 
@@ -487,15 +479,9 @@ static int alcor_data_irq_done(struct al
 		break;
 	case AU6601_INT_READ_BUF_RDY:
 		alcor_trf_block_pio(host, true);
-		if (!host->blocks)
-			break;
-		alcor_trigger_data_transfer(host, false);
 		return 1;
 	case AU6601_INT_WRITE_BUF_RDY:
 		alcor_trf_block_pio(host, false);
-		if (!host->blocks)
-			break;
-		alcor_trigger_data_transfer(host, false);
 		return 1;
 	case AU6601_INT_DMA_END:
 		if (!host->sg_count)
@@ -508,8 +494,14 @@ static int alcor_data_irq_done(struct al
 		break;
 	}
 
-	if (intmask & AU6601_INT_DATA_END)
-		return 0;
+	if (intmask & AU6601_INT_DATA_END) {
+		if (!host->dma_on && host->blocks) {
+			alcor_trigger_data_transfer(host);
+			return 1;
+		} else {
+			return 0;
+		}
+	}
 
 	return 1;
 }


