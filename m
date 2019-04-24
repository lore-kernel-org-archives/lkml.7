Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5CA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127157;
	bh=WqH3Tb9JDFC9HUhSYe7/idi5I1NCIbNyGnsnUSQ0G08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JMNIHnmE0ekrfSmn25TXletxxwFr9KL8FyClW2w/xxNUXOgT5PBqKtTMEisdaSSv3
	 FTos3kbBpbovpbYJbR5QKHbhe8rG0O8o9Z6BxY6toMsE8jwLOCfXTfZGHpXlH1pdtS
	 Lu3pqgxPg/wyL7TLaAVw1O/YT5ygnaJswTtIyIJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391367AbfDXRcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390781AbfDXRcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:33 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A532054F;
        Wed, 24 Apr 2019 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127153;
        bh=WqH3Tb9JDFC9HUhSYe7/idi5I1NCIbNyGnsnUSQ0G08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwgkqsb6U/54Pyji7iAtYP0uCdHPctov5+o232bPep55ZtU5wtS9a7qDQpAqqttOO
         nOd/l72f6OUL7xUOuZV8YJuReSXls2GWaEhnHNATtr4v4DTgl5VDkgADkxXME0tENS
         dZvjeYV6pw0CwL4xCqG2MobSynklg3eTVdJuNQkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 81/96] mmc: sdhci: Fix data command CRC error handling
Date:   Wed, 24 Apr 2019 19:10:26 +0200
Message-Id: <20190424170925.290549337@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4bf780996669280171c9cd58196512849b93434e ]

Existing data command CRC error handling is non-standard and does not work
with some Intel host controllers. Specifically, the assumption that the host
controller will continue operating normally after the error interrupt,
is not valid. Change the driver to handle the error in the same manner
as a data CRC error, taking care to ensure that the data line reset is
done for single or multi-block transfers, and it is done before
unmapping DMA.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 654051e00117..4bfaca33a477 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1078,8 +1078,7 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
 		 (mrq->sbc && mrq->sbc->error) ||
-		 (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
-				(mrq->data->stop && mrq->data->stop->error))) ||
+		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
 
@@ -1131,6 +1130,16 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	host->data = NULL;
 	host->data_cmd = NULL;
 
+	/*
+	 * The controller needs a reset of internal state machines upon error
+	 * conditions.
+	 */
+	if (data->error) {
+		if (!host->cmd || host->cmd == data_cmd)
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+	}
+
 	if ((host->flags & (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA)) ==
 	    (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA))
 		sdhci_adma_table_post(host, data);
@@ -1155,17 +1164,6 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	if (data->stop &&
 	    (data->error ||
 	     !data->mrq->sbc)) {
-
-		/*
-		 * The controller needs a reset of internal state machines
-		 * upon error conditions.
-		 */
-		if (data->error) {
-			if (!host->cmd || host->cmd == data_cmd)
-				sdhci_do_reset(host, SDHCI_RESET_CMD);
-			sdhci_do_reset(host, SDHCI_RESET_DATA);
-		}
-
 		/*
 		 * 'cap_cmd_during_tfr' request must not use the command line
 		 * after mmc_command_done() has been called. It is upper layer's
@@ -2642,7 +2640,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
+static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 {
 	if (!host->cmd) {
 		/*
@@ -2665,20 +2663,12 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		else
 			host->cmd->error = -EILSEQ;
 
-		/*
-		 * If this command initiates a data phase and a response
-		 * CRC error is signalled, the card can start transferring
-		 * data - the card may have received the command without
-		 * error.  We must not terminate the mmc_request early.
-		 *
-		 * If the card did not receive the command or returned an
-		 * error which prevented it sending data, the data phase
-		 * will time out.
-		 */
+		/* Treat data command CRC error the same as data CRC error */
 		if (host->cmd->data &&
 		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
 		     SDHCI_INT_CRC) {
 			host->cmd = NULL;
+			*intmask_p |= SDHCI_INT_DATA_CRC;
 			return;
 		}
 
@@ -2906,7 +2896,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
-			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK, &intmask);
 
 		if (intmask & SDHCI_INT_DATA_MASK)
 			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-- 
2.19.1



