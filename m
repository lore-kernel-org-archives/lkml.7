Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A265C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59161218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RheJ2U75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCTWoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:44:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52166 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfCTWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:43:59 -0400
Received: by mail-it1-f194.google.com with SMTP id e24so1547553itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPh/urz4hZLHR0zNevi1GPYrSYGBm6GIoDjMF3aQxys=;
        b=RheJ2U75xwvBcWHNZL4cVJOw7ZkSIbK3FBQjYF6Mb2bqvvjIK9cWGV0v+hTjF/fXCz
         4pHybdWPWUVFI1D4xZ5GXHyE+Vi6AH+nkmnZ+5+eMwj5K/o+gGkMlrR0iCJHmJd5kWzf
         aRo5JoSyx4oTpB0v5QvaOYsfYsQMCkXRYJdFOur6R0fAn7cJ3Jdp1PIK881C2VFK6EWq
         N2woc9Fi4lgRmGSV1Ir3abXBqGxGHOK4ul9ePIL7jqGEbPwCLkyUqTN5xt1dPazH7BIB
         OSH+Zb0HTkU4L4QF5obtejQdhyNdxAE7OcJjSUzCOy1QmoRTMEOta+psRY9eTlkkctro
         BQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPh/urz4hZLHR0zNevi1GPYrSYGBm6GIoDjMF3aQxys=;
        b=Qwz5tlabNtTBB5OMaKUt1HRZjLBMc1DNfMlZ0kCm4kLaANYkkMLUdqsQwhLWQnewxP
         1g8OxyUkghqjMkQoAqXbBkIiJl/+Jr5bqixFWrTNqJKsbtgT5gF4lZBaZ1TRwr/9wflp
         jxb5x97KDCV0JJgbyN9VxoE1uWfhZfGeIIq3dQ4ADczZnSrfebxvAoW91MdlURoWZSSM
         rpLuJV1MBszJ6OluZG3RpZl4NctMG03hgYzt2Fooi7VxjvM+ODcjfy7swcWR9P620Llz
         3TcTYKtxPOwhxrxqLwAH0KFQ/wpEkH/9MAu/JNr1CwPjBIMzRi9cftS7H+E9cTZ+uyEx
         X+Jg==
X-Gm-Message-State: APjAAAVK9QTlqKn05ifpx7pjIVbJCFX+DhkvXFiledfjzJUYUFwS3MCf
        z2Kj2AMiGvIlOB4CQumRs3w=
X-Google-Smtp-Source: APXvYqzPfmBbt6VSnYliO0s9TR2cK+yu7I0DcpB5Ge8r0LeP5uHI68bdeFyVV1JnZYyWr6+DYteSUQ==
X-Received: by 2002:a02:c007:: with SMTP id y7mr497825jai.1.1553121838810;
        Wed, 20 Mar 2019 15:43:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id 139sm1805554itk.28.2019.03.20.15.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:43:58 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v3 2/3] staging: mt7621-mmc: Initialize completions a single time during probe
Date:   Wed, 20 Mar 2019 16:42:04 -0600
Message-Id: <20190320224204.10243-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320224204.10243-1-thirtythreeforty@gmail.com>
References: <20190320224204.10243-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module was initializing completions whenever it was going to wait on
them, and not when the completion was allocated.  This is incorrect
according to the completion docs:

    Calling init_completion() on the same completion object twice is
    most likely a bug [...]

Re-initialization is also unnecessary because the module never uses
complete_all().  Fix this by only ever initializing the completion a
single time, and log if the completions are not consumed as intended
(this is not a fatal problem, but should not go unnoticed).

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v2: Rebased v1
v3: Removed BUG_ON() calls, and politely log; this failure won't kill us

 drivers/staging/mt7621-mmc/sd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index ff01872ab972..139533606863 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -466,7 +466,10 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 	host->cmd     = cmd;
 	host->cmd_rsp = resp;
 
-	init_completion(&host->cmd_done);
+	// The completion should have been consumed by the previous command
+	// response handler, because the mmc requests should be serialized
+	if(completion_done(&host->cmd_done))
+		dev_err(mmc_dev(host->mmc), "previous command was not handled\n");
 
 	sdr_set_bits(host->base + MSDC_INTEN, wints);
 	sdc_send_cmd(rawcmd, cmd->arg);
@@ -488,7 +491,6 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 		    MSDC_INT_ACMD19_DONE;
 
 	BUG_ON(in_interrupt());
-	//init_completion(&host->cmd_done);
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
@@ -672,7 +674,11 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		//msdc_clr_fifo(host);  /* no need */
 
 		msdc_dma_on();  /* enable DMA mode first!! */
-		init_completion(&host->xfer_done);
+
+		// The completion should have been consumed by the previous xfer
+		// response handler, because the mmc requests should be serialized
+		if(completion_done(&host->cmd_done))
+			dev_err(mmc_dev(host->mmc), "previous transfer was not handled\n");
 
 		/* start the command first*/
 		if (msdc_command_start(host, cmd, CMD_TIMEOUT) != 0)
@@ -691,7 +697,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		/* for read, the data coming too fast, then CRC error
 		 *  start DMA no business with CRC.
 		 */
-		//init_completion(&host->xfer_done);
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
@@ -1682,6 +1687,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 	msdc_init_gpd_bd(host, &host->dma);
 
+	init_completion(&host->cmd_done);
+	init_completion(&host->xfer_done);
 	INIT_DELAYED_WORK(&host->card_delaywork, msdc_tasklet_card);
 	spin_lock_init(&host->lock);
 	msdc_init_hw(host);
-- 
2.21.0

