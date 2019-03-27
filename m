Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CBFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqu6cu7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfC0BvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:51:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40151 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0BvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:51:06 -0400
Received: by mail-it1-f196.google.com with SMTP id y63so11894488itb.5;
        Tue, 26 Mar 2019 18:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmSbYUaITpcXSdME+U0+kal7ZNf0Gfb6hH7q8/011WE=;
        b=Nqu6cu7os2lFdqNtWLjjfqRWrdkEveSAjBmYSF4f6lE1STeKnk6bHJPWqMH6ZVIcKC
         hHsaCu+zSpg8Z49Pu7GD0dr09Pdr+2j3MQugkisGAUgHqhh+M6NXzbK0tT+M/2yjan7j
         NImC5b8MFxMUD65h2cStTmk0Q9/Fr/l4YExe4YfhfFyKgs4vD/AkFwrw0s7kQeCrQlDC
         44+oobfIx5Frp/dNZnLF4VeYC2SiTwsC+zaJnsAbCydQ8LcqG+tl5uhEu2y9+PzeuTuh
         pvhfQ7uLuclKj8eGaS0oy0r0Crt7lw1ROP7MtYSGJJrREzlXNxMdvFA4rp4lHc26W4Ae
         OsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmSbYUaITpcXSdME+U0+kal7ZNf0Gfb6hH7q8/011WE=;
        b=ASgIyl4bX5SyuSWaZn8j+KbW0oLn7gv3rosp7ijxRiIyij/85EzoO+Imb5MJJqTL5X
         z75I8J+XuWzEZkrjYZVKzztdr+KlEktNcWx2NPFvgrRT4YHLrg9neKZSQn2+28Lr3/cH
         rP7dn6tJYgrF5oxjv3f6r8ijsOsekjvcpTWqDra5RRyvfQpERZE75iIKXFTDUKgd2epf
         WZhMZyZpJ7+J7QqX1tiX3+GVyrusP0wrydNQ9pRzN4QTPpPrFJ2ll5A7YFGfUj5d2uAa
         PqZkq0wcpmldOvnBNO7gt+ubUBTjzm8UYio9qNSju5Np2KPX63SuAgtUWYvwhjTEoLaR
         +fkQ==
X-Gm-Message-State: APjAAAXuSgcEGmfZ4AtfNzU7YVGONRpiTiEDJVXg18R3UgPuWI+yatud
        mQqZN2pULkmHqXp1E7abvVU=
X-Google-Smtp-Source: APXvYqz3ZLa9NKsVhDoO3VoijH5bWgB/9RicRK1zHrwsVDNlVHJN8f8nsX+pF+RRNldhCLh8970Qhg==
X-Received: by 2002:a24:f68a:: with SMTP id u132mr1691036ith.45.1553651465975;
        Tue, 26 Mar 2019 18:51:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id e27sm4550040ioc.14.2019.03.26.18.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:51:05 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v5 2/2] staging: mt7621-mmc: Initialize completions a single time during probe
Date:   Tue, 26 Mar 2019 19:50:57 -0600
Message-Id: <20190327015057.9568-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327015057.9568-1-thirtythreeforty@gmail.com>
References: <20190327015057.9568-1-thirtythreeforty@gmail.com>
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
v5: *Correct* whitespace fixup

 drivers/staging/mt7621-mmc/sd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index e346167754bd..9a4b27562cd0 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -466,7 +466,11 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 	host->cmd     = cmd;
 	host->cmd_rsp = resp;
 
-	init_completion(&host->cmd_done);
+	// The completion should have been consumed by the previous command
+	// response handler, because the mmc requests should be serialized
+	if (completion_done(&host->cmd_done))
+		dev_err(mmc_dev(host->mmc),
+			"previous command was not handled\n");
 
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
+		if (completion_done(&host->cmd_done))
+			dev_err(mmc_dev(host->mmc),
+				"previous transfer was not handled\n");
 
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

