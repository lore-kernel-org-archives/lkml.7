Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC3C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPUhDFW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfCZPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:21:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39738 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbfCZPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:21:51 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so20617550ita.4;
        Tue, 26 Mar 2019 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNDW/JmLRYmJUskWsM7sYQ9RMDYDxyLGR5SNcEkiM2c=;
        b=qPUhDFW0YWT2mMdOecOhI21kFtySIqtkIBHaIoP8KWwDixZPVv8MJNC7trbNDOvadr
         4kButM8JLmArS934E+vTO6e9MIBO5W7FuvMj763tnoz0MlE4fz097zlupCE8t02wnJds
         Fo8CJeeH8U1zMjhFpMcmpdqPRhmharIwW0J044O2JLrDnmgjEwzAjK/0NL6diRmObjNt
         9/wWubkKMCryYstz3Bej9XVRI71ilhOv4HcmhPtEk1p/T2+iEm4f72N6fEOqETA8V3kX
         4w3MSlq0E2cFDSfAE90SoyFE2fKWxDgZzXRcVu42M53EOU2oIfZ+M6kJBpqWqUqkHv2W
         L1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNDW/JmLRYmJUskWsM7sYQ9RMDYDxyLGR5SNcEkiM2c=;
        b=fAfD2+21SwyU14+d07/uumw1ZjN8mPTd0fpbscPz9RhjnwDzHx9Q9UAaGMczzwL8Iy
         CyaZ6ADyQTrKcoFCNxGoYyyGd1lBG2d1PUVAmdUKZfFntdiU5/qk0O1X3jqnCsjHqEXA
         T3bUhT6+FyrSEvWJohiC5Po/V/Weybm5mgdBgtcyW+IfYrMHP3tzc/p9PVZAFJplgHLQ
         JzvUScwhyWfJ2Gt5bKK/fqgMEYslU7cV7jj+f0yRr3x2mjK6RSYJcfziPpqH1wrLYQXw
         0BGSNS3WCos7qWr8dDNH7DRkONTBjhPIM5akRiECgxGC6j7zpDyvP9XoCUzwWJ/fWvh1
         ERCg==
X-Gm-Message-State: APjAAAUrJZP5ZNqmnIMzSK1sxNS8dtGoyppaObCel9iGKb4SVjtaWHst
        fo91GLqZNSaPcnpa47dkUZukozSgszo=
X-Google-Smtp-Source: APXvYqxv/AVGZZvi1LBae0NDcZFTGkKBKiesordnemv2ZMEH5LQiURhX4gW1dyCKrL53BV7hwDZP5Q==
X-Received: by 2002:a24:287:: with SMTP id 129mr667516itu.114.1553613710753;
        Tue, 26 Mar 2019 08:21:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id w14sm6861045iol.32.2019.03.26.08.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:21:50 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v4 2/2] staging: mt7621-mmc: Initialize completions a single time during probe
Date:   Tue, 26 Mar 2019 09:21:39 -0600
Message-Id: <20190326152139.18609-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326152139.18609-1-thirtythreeforty@gmail.com>
References: <20190326152139.18609-1-thirtythreeforty@gmail.com>
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
v2: rewrite of v1
v3: Remove BUG_ON() calls
v4: Indent style fixup

 drivers/staging/mt7621-mmc/sd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index e346167754bd..ed63bd3ba6cc 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -466,7 +466,11 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 	host->cmd     = cmd;
 	host->cmd_rsp = resp;
 
-	init_completion(&host->cmd_done);
+	// The completion should have been consumed by the previous command
+	// response handler, because the mmc requests should be serialized
+	if(completion_done(&host->cmd_done))
+		dev_err(mmc_dev(host->mmc),
+		        "previous command was not handled\n");
 
 	sdr_set_bits(host->base + MSDC_INTEN, wints);
 	sdc_send_cmd(rawcmd, cmd->arg);
@@ -488,7 +492,6 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 		    MSDC_INT_ACMD19_DONE;
 
 	BUG_ON(in_interrupt());
-	//init_completion(&host->cmd_done);
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
@@ -670,7 +673,13 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		//msdc_clr_fifo(host);  /* no need */
 
 		msdc_dma_on();  /* enable DMA mode first!! */
-		init_completion(&host->xfer_done);
+
+		// The completion should have been consumed by the previous
+		// xfer response handler, because the mmc requests should be
+		// serialized
+		if(completion_done(&host->cmd_done))
+			dev_err(mmc_dev(host->mmc),
+			        "previous transfer was not handled\n");
 
 		/* start the command first*/
 		if (msdc_command_start(host, cmd, CMD_TIMEOUT) != 0)
@@ -696,7 +705,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		/* for read, the data coming too fast, then CRC error
 		 *  start DMA no business with CRC.
 		 */
-		//init_completion(&host->xfer_done);
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
@@ -1687,6 +1695,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 	msdc_init_gpd_bd(host, &host->dma);
 
+	init_completion(&host->cmd_done);
+	init_completion(&host->xfer_done);
 	INIT_DELAYED_WORK(&host->card_delaywork, msdc_tasklet_card);
 	spin_lock_init(&host->lock);
 	msdc_init_hw(host);
-- 
2.21.0

