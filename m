Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B654C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6195B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPak1zDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfEJWfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:35:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35248 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfEJWfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:35:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so3662140pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaD6p9yeCboFRN1O4f3agFfdrFqU2J5sjBMDQWDo2g0=;
        b=oPak1zDG4jOI/uCaxLX8GHqaGMSoiTU8gNv/Dn7HQtIJUcJqpsrpss2JiplUy66611
         ublJS8OvyIhozjVuBWqpFT1OKbcYlS1+capXhghyJ5pjoxiKxdTRkFC+9mJIuVevuS+d
         Gp9v4NqLOyhGTqEqJgHr3umOhrqhTmwnwf91w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaD6p9yeCboFRN1O4f3agFfdrFqU2J5sjBMDQWDo2g0=;
        b=ldFL+4oRNjHkQ4KDyOEh31X9I643jMNUVFaepUsK6ehjlwgDmPTsXIOU+x0xbCjTKH
         fb2DK1VupULA8wf4wS6irbh1a+w26JICxVo623lCmo/c3+eCFf8IbEl/JbXjJoD8P40J
         vGKghs34DKg58BoncMgESBH9sdwG+uPYuTsO3X2Muz3EN0dcZmOS8oaIRv9ldSttSohS
         QHruBOCI6MgIY3tPVCVqtaXH75kQh4lbQstABU4FTcvACOW6F5lL3aO77ZfvYLdODSm2
         sB/QxMmstP/8ZG2Yss830pla12l2FiTouYajgWfBChlg1vGNEiThFRNT1xuIHQl2dR6/
         4naQ==
X-Gm-Message-State: APjAAAW/d027zhY7Az34ssO9nYdSMcuD7p4DMZ7jFRtiYZocTtCJtbom
        uXDMAOm2Cm4V5DcwYJYOWbQKTQ==
X-Google-Smtp-Source: APXvYqzfM5/LmGIWWgBYDTcbycKUOiDEKbIXg5w7z1nWzDfcvuqgnSrkZZgBnWXxW3V3WNmk2pnBdg==
X-Received: by 2002:aa7:8b8b:: with SMTP id r11mr17507706pfd.130.1557527715309;
        Fri, 10 May 2019 15:35:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j6sm7689393pfe.107.2019.05.10.15.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:35:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer messages at high priority"
Date:   Fri, 10 May 2019 15:34:37 -0700
Message-Id: <20190510223437.84368-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510223437.84368-1-dianders@chromium.org>
References: <20190510223437.84368-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 37a186225a0c020516bafad2727fdcdfc039a1e4.

We have a better solution in the patch ("platform/chrome: cros_ec_spi:
Set ourselves as timing sensitive").  Let's revert the uglier and less
reliable solution.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/platform/chrome/cros_ec_spi.c | 80 ++-------------------------
 1 file changed, 6 insertions(+), 74 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 757a115502ec..70ff1ad09012 100644
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

