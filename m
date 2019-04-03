Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F651C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B9206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nptR/xqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDCQFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:05:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37600 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:05:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so5318575ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbjqSHlZ2wbx9HQimXULlr/s1ruMzMM8ppUD2dTNmBQ=;
        b=nptR/xqATtTKl9whD8mVR9Lt4UCm2+x2deayiMDiJaTAHJW9Q5iSNsBErGkG0LGVU5
         x4qPQubTAv+gFtGRJI5cKT0uQ9e+pTswD8PIcW97oONUh1K7BzfgfbT4/SWrBt2QkdWC
         +hVDgU4Tn4qmPtZRcRPCafywS3abTgTtpUTz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbjqSHlZ2wbx9HQimXULlr/s1ruMzMM8ppUD2dTNmBQ=;
        b=nx4u25uZEWVbvOmNFBtJj5iYtNvkNAHXarRKDio8Z3Q82b8gTG264Afp+HrFg+ieWh
         ifAveSNbli3CxcPiG28YIAFruIPszF392+2B1AeDGHihypiRPdM+ThMcM3vxMB/nj/t7
         kH9+dMZOGpLt+XgkUaOZv29Mh+XzEVMMwobos/TwO/JEZIHGuhMUTOsZI1ctIi1RtJHw
         NHEAMGN4PERbDw+jtk8260U3UA57P9nFqztaCKfdIfJGWwnk2ou6F1xaV/wTo5iL60VJ
         MCDoi6LufVyiExZwiic8Fhi1edFB8PUlxO1k0DarPLu/fFuIp+NESMtnA+jdi52d4ydC
         M2XQ==
X-Gm-Message-State: APjAAAW20wcaCjh47kMz2b1C1lKhPUCTSK4tRANaY2DrnYH87uLNAZuO
        IbvR6KKGaY1r9IRp+14TFLFqxQ==
X-Google-Smtp-Source: APXvYqz7QHbSG8Gc7KTb6iG+XzRKA1AXjWJqTXtz3l4vd/Ho0Py+W4PB1iBC9mqq/1/SWa5RBEwNBg==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr754968plf.35.1554307538352;
        Wed, 03 Apr 2019 09:05:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id l5sm32658953pfi.97.2019.04.03.09.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 09:05:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        sjg@chromium.org, briannorris@chromium.org, groeck@chromium.org,
        broonie@kernel.org, ryandcase@chromium.org, rspangler@chromium.org,
        mka@chromium.org, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at high priority
Date:   Wed,  3 Apr 2019 09:05:26 -0700
Message-Id: <20190403160526.257088-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software running on the Chrome OS Embedded Controller (cros_ec)
handles SPI transfers in a bit of a wonky way.  Specifically if the EC
sees too long of a delay in a SPI transfer it will give up and the
transfer will be counted as failed.  Unfortunately the timeout is
fairly short, though the actual number may be different for different
EC codebases.

We can end up tripping the timeout pretty easily if we happen to
preempt the task running the SPI transfer and don't get back to it for
a little while.

Historically this hasn't been a _huge_ deal because:
1. On old devices Chrome OS used to run PREEMPT_VOLUNTARY.  That meant
   we were pretty unlikely to take a big break from the transfer.
2. On recent devices we had faster / more processors.
3. Recent devices didn't use "cros-ec-spi-pre-delay".  Using that
   delay makes us more likely to trip this use case.
4. For whatever reasons (I didn't dig) old kernels seem to be less
   likely to trip this.
5. For the most part it's kinda OK if a few transfers to the EC fail.
   Mostly we're just polling the battery or doing some other task
   where we'll try again.

Even with the above things, this issue has reared its ugly head
periodically.  We could solve this in a nice way by adding reliable
retries to the EC protocol [1] or by re-designing the code in the EC
codebase to allow it to wait longer, but that code doesn't ever seem
to get changed.  ...and even if it did, it wouldn't help old devices.

It's now time to finally take a crack at making this a little better.
This patch isn't guaranteed to make every cros_ec SPI transfer
perfect, but it should improve things by a few orders of magnitude.
Specifically you can try this on a rk3288-veyron Chromebook (which is
slower and also _does_ need "cros-ec-spi-pre-delay"):
  md5sum /dev/zero &
  md5sum /dev/zero &
  md5sum /dev/zero &
  md5sum /dev/zero &
  while true; do
    cat /sys/class/power_supply/sbs-20-000b/charge_now > /dev/null;
  done
...before this patch you'll see boatloads of errors.  After this patch I
don't see any in the testing I did.

The way this patch works is by effectively boosting the priority of
the cros_ec transfers.  As far as I know there is no simple way to
just boost the priority of the current process temporarily so the way
we accomplish this is by queuing the work on the system_highpri_wq.

NOTE: this patch relies on the fact that the SPI framework attempts to
push the messages out on the calling context (which is the one that is
boosted to high priority).  As I understand from earlier (long ago)
discussions with Mark Brown this should be a fine assumption.  Even if
it isn't true sometimes this patch will still not make things worse.

[1] https://crbug.com/678675

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use system_highpri_wq + completion (Matthias)
- Avoid duplication by using a function pointer (Matthias)

 drivers/platform/chrome/cros_ec_spi.c | 83 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index ffc38f9d4829..8aaea5d93c4f 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -75,6 +75,29 @@ struct cros_ec_spi {
 	unsigned int end_of_msg_delay;
 };
 
+typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
+				  struct cros_ec_command *ec_msg);
+
+/**
+ * struct cros_ec_xfer_work_params - params for our high priority workers
+ *
+ * @work: The work_struct needed to queue work
+ * @fn: The function to use to transfer
+ * @completion: Will be signaled when function is done
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ * @ret: The return value of the function
+ */
+
+struct cros_ec_xfer_work_params {
+	struct work_struct work;
+	cros_ec_xfer_fn_t fn;
+	struct completion completion;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_command *ec_msg;
+	int ret;
+};
+
 static void debug_packet(struct device *dev, const char *name, u8 *ptr,
 			 int len)
 {
@@ -350,13 +373,13 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 }
 
 /**
- * cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
+ * do_cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
  *
  * @ec_dev: ChromeOS EC device
  * @ec_msg: Message to transfer
  */
-static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
-				struct cros_ec_command *ec_msg)
+static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
+				   struct cros_ec_command *ec_msg)
 {
 	struct ec_host_response *response;
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
@@ -493,13 +516,13 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 }
 
 /**
- * cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
+ * do_cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
  *
  * @ec_dev: ChromeOS EC device
  * @ec_msg: Message to transfer
  */
-static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
-				struct cros_ec_command *ec_msg)
+static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
+				   struct cros_ec_command *ec_msg)
 {
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
 	struct spi_transfer trans;
@@ -611,6 +634,54 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+static void cros_ec_xfer_high_pri_work(struct work_struct *work)
+{
+	struct cros_ec_xfer_work_params *params;
+
+	params = container_of(work, struct cros_ec_xfer_work_params, work);
+	params->ret = params->fn(params->ec_dev, params->ec_msg);
+	complete(&params->completion);
+}
+
+static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
+				 struct cros_ec_command *ec_msg,
+				 cros_ec_xfer_fn_t fn)
+{
+	struct cros_ec_xfer_work_params params;
+
+	INIT_WORK(&params.work, cros_ec_xfer_high_pri_work);
+	params.ec_dev = ec_dev;
+	params.ec_msg = ec_msg;
+	params.fn = fn;
+	init_completion(&params.completion);
+
+	/*
+	 * This looks a bit ridiculous.  Why do the work on a
+	 * different thread if we're just going to block waiting for
+	 * the thread to finish?  The key here is that the thread is
+	 * running at high priority but the calling context might not
+	 * be.  We need to be at high priority to avoid getting
+	 * context switched out for too long and the EC giving up on
+	 * the transfer.
+	 */
+	queue_work(system_highpri_wq, &params.work);
+	wait_for_completion(&params.completion);
+
+	return params.ret;
+}
+
+static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
+{
+	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_pkt_xfer_spi);
+}
+
+static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
+{
+	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
+}
+
 static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-- 
2.21.0.392.gf8f6787159e-goog

