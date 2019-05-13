Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE7AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FFE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCGz4J8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEMUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:21:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33076 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEMUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:20:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so7036833plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnf9X1JzNr0p/o4q+Qg8KxiBFNUwbq0BM3Xh4UH0r7k=;
        b=bCGz4J8ppGdokDgODI+0By4RzdTs4uc+h8HuDat4mmDuu17yR0T+GnYtO3lDNPy82H
         wEif10+dwhAiTiS7e82OhpE1ddg4BGq+ixxRvPKhAClYImqsqNDhtVsrN1xXa2wUKad+
         osLIDfAY+jE4KhX0I++jdUsrXi50hLxQ1ZsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnf9X1JzNr0p/o4q+Qg8KxiBFNUwbq0BM3Xh4UH0r7k=;
        b=R0OaInOqhmndayBmhLrVB7Nhxbg+T5rlSonEa80Fq10LOX2iwRghKOip3U8cHWG7Tx
         +vdLAoqFWL96Jwvc54NHpMWyvCUn7+PgYYu/3VJ0bNSTOiyD8tfFArPBvbFiP1heFDCx
         WUSmc8Nlv3VWcdHvkkOw6KLJ9iJQuYIHyMQnIUlLTfZW5ku6VpcGCTeGcmyxyazpwu5a
         po+RDB/oBX8YQ1V2P3UHCMAaSRhu67hLF3C1Vxj46UeZadTMysDS8+p1x5OnP73QnUYR
         QISAZA/ZviNDz7esC3P9rVmJVQ73X88ba9uCaoqmUa3CI3vqFEKPW5AtY6JBVtJjaD5e
         TKlQ==
X-Gm-Message-State: APjAAAWmLhUeqVjLoaDlC9okr4Gaw8eASIgebYaLSX/Xd2epvhIrU2o2
        1X5TPcKRl4GlCfXVjBIvsxWKJQ==
X-Google-Smtp-Source: APXvYqy5wGuT5CZ/TaXPeEZeoV8ZznOBT7/f/8i18U3AePnUU+33PWms/FxG3zRylr0ySkmVt8Ra/Q==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr33923439plt.81.1557778856650;
        Mon, 13 May 2019 13:20:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s198sm26356597pfs.34.2019.05.13.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:20:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Revert "platform/chrome: cros_ec_spi: Transfer messages at high priority"
Date:   Mon, 13 May 2019 13:18:25 -0700
Message-Id: <20190513201825.166969-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190513201825.166969-1-dianders@chromium.org>
References: <20190513201825.166969-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 37a186225a0c020516bafad2727fdcdfc039a1e4.

We have a better solution in the patch ("platform/chrome: cros_ec_spi:
Force transfers to realtime priority").  Let's revert the uglier and
less reliable solution.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v2: None

 drivers/platform/chrome/cros_ec_spi.c | 80 ++-------------------------
 1 file changed, 6 insertions(+), 74 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index a2959365a870..7adaf534eb8b 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -75,27 +75,6 @@ struct cros_ec_spi {
 	unsigned int end_of_msg_delay;
 };
 
-typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
-				  struct cros_ec_command *ec_msg);
-
-/**
- * struct cros_ec_xfer_work_params - params for our high priority workers
- *
- * @work: The work_struct needed to queue work
- * @fn: The function to use to transfer
- * @ec_dev: ChromeOS EC device
- * @ec_msg: Message to transfer
- * @ret: The return value of the function
- */
-
-struct cros_ec_xfer_work_params {
-	struct work_struct work;
-	cros_ec_xfer_fn_t fn;
-	struct cros_ec_device *ec_dev;
-	struct cros_ec_command *ec_msg;
-	int ret;
-};
-
 static void debug_packet(struct device *dev, const char *name, u8 *ptr,
 			 int len)
 {
@@ -371,13 +350,13 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 }
 
 /**
- * do_cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
+ * cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
  *
  * @ec_dev: ChromeOS EC device
  * @ec_msg: Message to transfer
  */
-static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
-				   struct cros_ec_command *ec_msg)
+static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
 {
 	struct ec_host_response *response;
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
@@ -514,13 +493,13 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 }
 
 /**
- * do_cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
+ * cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
  *
  * @ec_dev: ChromeOS EC device
  * @ec_msg: Message to transfer
  */
-static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
-				   struct cros_ec_command *ec_msg)
+static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
 {
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
 	struct spi_transfer trans;
@@ -632,53 +611,6 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
-static void cros_ec_xfer_high_pri_work(struct work_struct *work)
-{
-	struct cros_ec_xfer_work_params *params;
-
-	params = container_of(work, struct cros_ec_xfer_work_params, work);
-	params->ret = params->fn(params->ec_dev, params->ec_msg);
-}
-
-static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
-				 struct cros_ec_command *ec_msg,
-				 cros_ec_xfer_fn_t fn)
-{
-	struct cros_ec_xfer_work_params params;
-
-	INIT_WORK_ONSTACK(&params.work, cros_ec_xfer_high_pri_work);
-	params.ec_dev = ec_dev;
-	params.ec_msg = ec_msg;
-	params.fn = fn;
-
-	/*
-	 * This looks a bit ridiculous.  Why do the work on a
-	 * different thread if we're just going to block waiting for
-	 * the thread to finish?  The key here is that the thread is
-	 * running at high priority but the calling context might not
-	 * be.  We need to be at high priority to avoid getting
-	 * context switched out for too long and the EC giving up on
-	 * the transfer.
-	 */
-	queue_work(system_highpri_wq, &params.work);
-	flush_work(&params.work);
-	destroy_work_on_stack(&params.work);
-
-	return params.ret;
-}
-
-static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
-				struct cros_ec_command *ec_msg)
-{
-	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_pkt_xfer_spi);
-}
-
-static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
-				struct cros_ec_command *ec_msg)
-{
-	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
-}
-
 static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-- 
2.21.0.1020.gf2820cf01a-goog

