Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2914DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E414220873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YImKpzHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEOQss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:48:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44020 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfEOQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:48:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so137022plp.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hJ+5LXgO7LbFrdUEb9nUybskuecfmqVBDht734r15g=;
        b=YImKpzHc7T65qluqJf3imoyqOudg5R6a2hq2q7jjzcEp16f7XpDYEHGfuE6INwJELv
         5cHKv1Y6V6wW1y8wgo2QcDVkR/ENchy9NLT2MpxwX14UYDUPi1PtCt7hs3Z3k0BivnbX
         k+gUCxidN8IdpURB33RhHWrrczm9RIpCpIGyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hJ+5LXgO7LbFrdUEb9nUybskuecfmqVBDht734r15g=;
        b=S0QDhibEjSRe0KKEaaqzuN0q7nbo1C+fNeMIff8Nb6BV/pYvHQzgmm09ciOORiocCW
         FssZSaohdvvQ6MppWAnQT+vAYoFXbciTg86YveuyvUVYgG4Nk0Xn2ARvAfshEM3Pi+yx
         3mWT+7wVSZkIb97xw+PuMHQ4H3GCOOLGNuYz+4xdMOHi+dMXzpKe09rnFCPZgFnSmhah
         ZY+McG8jrNcUzvGfV178Hh5V1G+oUFT9TyluaoZChx6HucADd7uSYloqvK2CjNHetn0/
         ovH+69nygkSFFTHRHcjOqc19iep4kfqDAEpWiKmA04dVrAA6d7k1y+bG65EeBErYRScg
         d9/A==
X-Gm-Message-State: APjAAAXvGyDws9JgUIusx/e2sOUZr4Ai0PE8YNV8T/WKma7USrubK11I
        lc63J5TAmrnYVNEXNlpEToAQZw==
X-Google-Smtp-Source: APXvYqwQB60dYkFPWRqj56XAYyuufHY1SQN6r1/gXXylUvV5OTtJGR77jwPd97AqfjKd35m/yXLB/Q==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr9922437plb.240.1557938923373;
        Wed, 15 May 2019 09:48:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h16sm6914595pfj.114.2019.05.15.09.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:48:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v4 2/3] spi: Allow SPI devices to request the pumping thread be realtime
Date:   Wed, 15 May 2019 09:48:12 -0700
Message-Id: <20190515164814.258898-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190515164814.258898-1-dianders@chromium.org>
References: <20190515164814.258898-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only way to get the SPI pumping thread bumped up to
realtime priority is for the controller to request it.  However it may
be that the controller works fine with the normal priority but
communication to a particular SPI device on the bus needs realtime
priority.

Let's add a way for devices to request realtime priority when they set
themselves up.

NOTE: this will just affect the priority of transfers that end up on
the SPI core's pumping thread.  In many cases transfers happen in the
context of the caller so if you need realtime priority for all
transfers you should ensure the calling context is also realtime
priority.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4: None
Changes in v3:
- SPI core change now like patch v1 patch #2 (with name "rt").

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".

 drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8eb7460dd744..466984796dd9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1364,10 +1364,32 @@ static void spi_pump_messages(struct kthread_work *work)
 	__spi_pump_messages(ctlr, true);
 }
 
-static int spi_init_queue(struct spi_controller *ctlr)
+/**
+ * spi_set_thread_rt - set the controller to pump at realtime priority
+ * @ctlr: controller to boost priority of
+ *
+ * This can be called because the controller requested realtime priority
+ * (by setting the ->rt value before calling spi_register_controller()) or
+ * because a device on the bus said that its transfers needed realtime
+ * priority.
+ *
+ * NOTE: at the moment if any device on a bus says it needs realtime then
+ * the thread will be at realtime priority for all transfers on that
+ * controller.  If this eventually becomes a problem we may see if we can
+ * find a way to boost the priority only temporarily during relevant
+ * transfers.
+ */
+static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 
+	dev_info(&ctlr->dev,
+		"will run message pump with realtime priority\n");
+	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+}
+
+static int spi_init_queue(struct spi_controller *ctlr)
+{
 	ctlr->running = false;
 	ctlr->busy = false;
 
@@ -1387,11 +1409,8 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	 * request and the scheduling of the message pump thread. Without this
 	 * setting the message pump thread will remain at default priority.
 	 */
-	if (ctlr->rt) {
-		dev_info(&ctlr->dev,
-			"will run message pump with realtime priority\n");
-		sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
-	}
+	if (ctlr->rt)
+		spi_set_thread_rt(ctlr);
 
 	return 0;
 }
@@ -2982,6 +3001,11 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
+	if (spi->rt && !spi->controller->rt) {
+		spi->controller->rt = true;
+		spi_set_thread_rt(spi->controller);
+	}
+
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..15505c2485d6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -109,6 +109,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	This may be changed by the device's driver, or left at the
  *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
+ * @rt: Make the pump thread real time priority.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -143,6 +144,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
+	bool			rt;
 	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
-- 
2.21.0.1020.gf2820cf01a-goog

