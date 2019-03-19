Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8820700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV2UVY8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCSCVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45008 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfCSCUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:40 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so16348098iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoAoUBhwVx4N4wEzo2+IDUi88yK9qYcFIccdZUFurz0=;
        b=uV2UVY8kvEZBMsR1HIAyOvIo8y+2LfdH71sQaUAKWJvE28CRC1oXAROfy06mX+C11i
         mWzUP1RzGgC3T1R4NRq1OIWz69Rq2bQuUeo7caUkpm4Fu7A4uPbvp6ys5QYnb6+y/zkn
         KTv/g9YVO5TPNvX+cGoX5ym5nS5VnLJNNLatAJfJcE9FbdpCPT6B1ql+04TCEq9DVkwd
         7x/3Pc5buHFpLHf5GLv6m/jDLOCdRgyi0AOaGs9ExHsTRAhMbLHBrty2mQRWRFKX3DuL
         wa5yc+N0ts8xIIGHOoum9ctk7V0rRVQAw0d51puzTjbMgmAR1mlbWK9WcBcf0zdyXPM/
         eCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoAoUBhwVx4N4wEzo2+IDUi88yK9qYcFIccdZUFurz0=;
        b=acxB7Fm5M4MOcBgNjTJRWRK+5LAYkjelV52D8YdWz8oUIK+pPFsU128O9TbkuLdnwR
         yd4idGs9/KjpWd25NVAeCvAtWxKCcK8p533Re3oNz29FErTj7OQ5h/xW9ozpazLTJZsT
         487FcdPqSwuUC1fBO4dJHW5A6r4OUibhw/LYFAHrrSn1L4KHwNB7usYrgoqip9IbXqsJ
         rHsDV07t2GbxEvdB5YTrBBECohldEssoLed6KieUek+t6JvKMzjF32bRnGuqlk6bwnoC
         QJYKgKmVtu4zYgSKqJ9+iLgWmV85ShV8X/z9PzQnYBheT8idevXgzzpv33uUY7s0d7Ay
         IQ9Q==
X-Gm-Message-State: APjAAAWGvJvbHBrwWHSrVt8MLUhbZVWCxwoQ7JICT9TZ9QqmF7qxzpgb
        jJRkuEHib1q1YNGrCf6zpbO9GlfkGpw=
X-Google-Smtp-Source: APXvYqwYbGPXhGbN8eVaC2oSnAEBNcu8GM47V/WB27TGWqQkA+3F2gO6dwXbSvjB8wJ3yg8+HIBi3g==
X-Received: by 2002:a6b:640f:: with SMTP id t15mr39817iog.32.1552962039508;
        Mon, 18 Mar 2019 19:20:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:39 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 06/11] staging: mt7621-mmc: Initialize completions a single time during probe
Date:   Mon, 18 Mar 2019 20:20:07 -0600
Message-Id: <20190319022012.11051-7-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
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
single time.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 89fbc0a1dec7..c272aa780719 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -467,7 +467,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
 	host->cmd     = cmd;
 	host->cmd_rsp = resp;
 
-	init_completion(&host->cmd_done);
+	// The completion should have been consumed by the previous command
+	// response handler, because the mmc requests should be serialized
+	BUG_ON(completion_done(&host->cmd_done));
 
 	sdr_set_bits(host->base + MSDC_INTEN, wints);
 	sdc_send_cmd(rawcmd, cmd->arg);
@@ -489,7 +491,6 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 		    MSDC_INT_ACMD19_DONE;
 
 	BUG_ON(in_interrupt());
-	//init_completion(&host->cmd_done);
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
@@ -673,7 +674,10 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		//msdc_clr_fifo(host);  /* no need */
 
 		msdc_dma_on();  /* enable DMA mode first!! */
-		init_completion(&host->xfer_done);
+
+		// The completion should have been consumed by the previous xfer
+		// response handler, because the mmc requests should be serialized
+		BUG_ON(completion_done(&host->xfer_done));
 
 		/* start the command first*/
 		if (msdc_command_start(host, cmd, CMD_TIMEOUT) != 0)
@@ -692,7 +696,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		/* for read, the data coming too fast, then CRC error
 		 *  start DMA no business with CRC.
 		 */
-		//init_completion(&host->xfer_done);
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
@@ -1684,6 +1687,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 	msdc_init_gpd_bd(host, &host->dma);
 
+	init_completion(&host->cmd_done);
+	init_completion(&host->xfer_done);
 	INIT_DELAYED_WORK(&host->card_delaywork, msdc_tasklet_card);
 	spin_lock_init(&host->lock);
 	msdc_init_hw(host);
-- 
2.21.0

