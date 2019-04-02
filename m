Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03CDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28952084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfnH+Wf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDBWpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:45:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34629 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDBWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:45:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so7100083pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfP6zObWAKgqAMuUmRaUQ8eIO1kmM7n1FGiJrLQFKhI=;
        b=JfnH+Wf/Jfiv3izQV6cl4/B+jff7FxI4EsdFMSszeHEGkQsAsQMR78jy+LwMcIcop2
         NhG9MSutxhIZpDLAr3SYEdOZzg+KTX7KgEc6SzG6hAyDs0du7jLslwkMyA8gj78A7/v9
         oV5LL0gpJIwmHG/nTN4X+ubsHYlV2hD/F3pbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfP6zObWAKgqAMuUmRaUQ8eIO1kmM7n1FGiJrLQFKhI=;
        b=dqHt8pgtG0U15DO+LY/f5IvdQhc9Svz0OmBctc+Tcs1/M5HlGxfDlX7WX7cRV1fEto
         Cg/di0imQR/wKH4xH6cvZR3MVqU/YW7HWwixES57ylpRqPflwxQ1vn1sGBZZ1mz3F2j0
         2d9A3+vQ4NdhcsqN0XbpX7Yb5dbEuWAUK2mJL6GrQpPuRD97gYtI03y7RzpxJyJhQ7QG
         fwT92VDSfLvSEHYCPOKrXufl1IZIOi05F4WdePszpwVBwlUeAiaSUwi83efTmIxE9DwC
         +z/NTXK+qoXT+BRLUEezmfomnmn+MtIPfpTy6LinK4rCRdTrsTR79PYGdtg9QBoddM+b
         PTEQ==
X-Gm-Message-State: APjAAAUbB55/+sKAI87azJI3ZFo6RaxIF3hDTOtoGh+f8BH+hyRIf62I
        63E95B7ecAvHn8E3yBhu96aL3w==
X-Google-Smtp-Source: APXvYqxSpKiHXJG7YJs/+Qmz19hl8YjdDlZPO3I3rJ3Hm6HtSVhb+iDPtyLcMFyhsk//XgCxZ8wgxQ==
X-Received: by 2002:a65:51c3:: with SMTP id i3mr68281999pgq.45.1554245113255;
        Tue, 02 Apr 2019 15:45:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c3sm21518351pfo.2.2019.04.02.15.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 15:45:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        sjg@chromium.org, briannorris@chromium.org, groeck@chromium.org,
        broonie@kernel.org, ryandcase@chromium.org, rspangler@chromium.org,
        mka@chromium.org, heiko@sntech.de,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_spi: Transfer messages at high priority
Date:   Tue,  2 Apr 2019 15:44:44 -0700
Message-Id: <20190402224445.64823-1-dianders@chromium.org>
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
we accomplish this is by creating a "WQ_HIGHPRI" workqueue and doing
the transfers there.

NOTE: this patch relies on the fact that the SPI framework attempts to
push the messages out on the calling context (which is the one that is
boosted to high priority).  As I understand from earlier (long ago)
discussions with Mark Brown this should be a fine assumption.  Even if
it isn't true sometimes this patch will still not make things worse.

[1] https://crbug.com/678675

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/platform/chrome/cros_ec_spi.c | 107 ++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index ffc38f9d4829..101f2deb7d3c 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -67,12 +67,30 @@
  *      is sent when we want to turn on CS at the start of a transaction.
  * @end_of_msg_delay: used to set the delay_usecs on the spi_transfer that
  *      is sent when we want to turn off CS at the end of a transaction.
+ * @high_pri_wq: We'll do our transfers here to reduce preemption problems.
  */
 struct cros_ec_spi {
 	struct spi_device *spi;
 	s64 last_transfer_ns;
 	unsigned int start_of_msg_delay;
 	unsigned int end_of_msg_delay;
+	struct workqueue_struct *high_pri_wq;
+};
+
+/**
+ * struct cros_ec_xfer_work_params - params for our high priority workers
+ *
+ * @work: The work_struct needed to queue work
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ * @ret: The return value of the function
+ */
+
+struct cros_ec_xfer_work_params {
+	struct work_struct work;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_command *ec_msg;
+	int ret;
 };
 
 static void debug_packet(struct device *dev, const char *name, u8 *ptr,
@@ -350,13 +368,13 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
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
@@ -493,13 +511,13 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
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
@@ -611,6 +629,54 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
+static void cros_ec_pkt_xfer_spi_work(struct work_struct *work)
+{
+	struct cros_ec_xfer_work_params *params;
+
+	params = container_of(work, struct cros_ec_xfer_work_params, work);
+	params->ret = do_cros_ec_pkt_xfer_spi(params->ec_dev, params->ec_msg);
+}
+
+static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
+{
+	struct cros_ec_spi *ec_spi = ec_dev->priv;
+	struct cros_ec_xfer_work_params params;
+
+	INIT_WORK(&params.work, cros_ec_pkt_xfer_spi_work);
+	params.ec_dev = ec_dev;
+	params.ec_msg = ec_msg;
+
+	queue_work(ec_spi->high_pri_wq, &params.work);
+	flush_workqueue(ec_spi->high_pri_wq);
+
+	return params.ret;
+}
+
+static void cros_ec_cmd_xfer_spi_work(struct work_struct *work)
+{
+	struct cros_ec_xfer_work_params *params;
+
+	params = container_of(work, struct cros_ec_xfer_work_params, work);
+	params->ret = do_cros_ec_cmd_xfer_spi(params->ec_dev, params->ec_msg);
+}
+
+static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
+				struct cros_ec_command *ec_msg)
+{
+	struct cros_ec_spi *ec_spi = ec_dev->priv;
+	struct cros_ec_xfer_work_params params;
+
+	INIT_WORK(&params.work, cros_ec_cmd_xfer_spi_work);
+	params.ec_dev = ec_dev;
+	params.ec_msg = ec_msg;
+
+	queue_work(ec_spi->high_pri_wq, &params.work);
+	flush_workqueue(ec_spi->high_pri_wq);
+
+	return params.ret;
+}
+
 static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
@@ -626,6 +692,31 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 		ec_spi->end_of_msg_delay = val;
 }
 
+static void cros_ec_spi_workqueue_release(struct device *dev, void *res)
+{
+	destroy_workqueue(*(struct workqueue_struct **)res);
+}
+
+static struct workqueue_struct *cros_ec_spi_workqueue_alloc(struct device *dev)
+{
+	struct workqueue_struct **ptr;
+
+	ptr = devres_alloc(cros_ec_spi_workqueue_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	*ptr = alloc_workqueue("cros_ec_spi", WQ_HIGHPRI, 1);
+	if (*ptr == NULL) {
+		devres_free(ptr);
+		return NULL;
+	}
+
+	devres_add(dev, ptr);
+
+	return *ptr;
+}
+
 static int cros_ec_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -664,6 +755,10 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	ec_spi->last_transfer_ns = ktime_get_ns();
 
+	ec_spi->high_pri_wq = cros_ec_spi_workqueue_alloc(dev);
+	if (!ec_spi->high_pri_wq)
+		return -ENOMEM;
+
 	err = cros_ec_register(ec_dev);
 	if (err) {
 		dev_err(dev, "cannot register EC\n");
-- 
2.21.0.392.gf8f6787159e-goog

