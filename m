Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3844C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73982208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHPwjWHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfELPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42308 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfELPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:54:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so5436647pgg.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RSvBfwSgHPK+AwTlO+Q/ljV/lIxCORJ8Om4rSVjchY=;
        b=eHPwjWHKGNbQrIba+h0WS/NU55onEkPMWUh35HEfZlyS/noOAtj9X40j+2FM8SA8O1
         vtvjcwmtdDEJXtyeVnjxQPObPcVxhiNPtYMsBs1zZ9fzawVUs1zYrNkG36N9LmeONc7u
         KorTsfmcjRBko58i4IUT6I4+uSFAEvm0pV0yylA+/Ag3XLkEyqOpswczqjO1B72vBW1v
         Ui0Z+LDlOJu3w17/yxPIbAMWGxfilb08ZIaRBIBxCHHmxzlYXcXQp0gWvHD7UpnLASuQ
         KoG87UgwbtvQE/HNvnBTeJKyQmlYQhsC05yCzqfIPMRgPX72/a+gl18l33uEjftBi9i/
         3Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RSvBfwSgHPK+AwTlO+Q/ljV/lIxCORJ8Om4rSVjchY=;
        b=Olbkx4IGFhCF7o0OGjkZdFTiMQeOmBEp+JsRRt4nIOkA3NqfJ8Jh8+xb1fVNrCuG12
         YKFS1JTOln4vtu8eVnrE2irRIBDoDspLvVftp6LPdxbuHMJOZzqIL22ZyiT+JNnjHzMZ
         vv+Hl5lmYNYKM2M1PSwfs8lKynvq9cNdG1g12kdHvGEq+U+LpCl8qIuulVSwISZM1faj
         6IvBPh9G8z1343WX+uqs8odMEa3D7YIGuftcWsEx56rdpFhPnQteV31hjri1hsoW/7tz
         VXYDUaAsj9fHrTlgfvAx3543z4Z50A7E/X2FeAcs9kYLQWkPpm0ajsZoC1NMhg0F/6wI
         Lj3g==
X-Gm-Message-State: APjAAAVKnNgnQ28axugHxWyt5pbIhjwhvTbexVgxAeNgPtJ0KewplYLj
        bFjvQ2gW+SrpPq98ri93pCBnr5sm
X-Google-Smtp-Source: APXvYqyesTKSGfie/SmRn45k8KBFsF5TkJakltXKy2qHrDO7Hza+OLjhhLeIb5VkoOfUH37PL90hog==
X-Received: by 2002:a62:3381:: with SMTP id z123mr28901831pfz.42.1557676497115;
        Sun, 12 May 2019 08:54:57 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:918e:f7e4:1728:3f45])
        by smtp.gmail.com with ESMTPSA id v2sm4470058pgr.2.2019.05.12.08.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 08:54:56 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH v3 6/7] nvme-pci: trigger device coredump on command timeout
Date:   Mon, 13 May 2019 00:54:16 +0900
Message-Id: <1557676457-4195-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the nvme driver to trigger a device coredump when command
timeout occurs, and it helps diagnose and debug issues.

This can be tested with fail_io_timeout fault injection.

	# echo 1 > /sys/kernel/debug/fail_io_timeout/probability
	# echo 1 > /sys/kernel/debug/fail_io_timeout/times
	# echo 1 > /sys/block/nvme0n1/io-timeout-fail
	# dd if=/dev/nvme0n1 of=/dev/null

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- Don't try to get telemetry log when admin queue is not available

 drivers/nvme/host/pci.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3eebb98..6522592 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -87,12 +87,12 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
-static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
-static void __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
-static void __maybe_unused nvme_coredump_complete(struct nvme_dev *dev);
+static void nvme_coredump_init(struct nvme_dev *dev);
+static void nvme_coredump_logs(struct nvme_dev *dev);
+static void nvme_coredump_complete(struct nvme_dev *dev);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -1280,7 +1280,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
@@ -1309,7 +1309,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, shutdown);
+		nvme_dev_disable(dev, shutdown, true);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	default:
@@ -1325,7 +1325,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
@@ -2382,7 +2382,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump)
 {
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2407,6 +2407,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	if (dump)
+		nvme_coredump_init(dev);
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
@@ -2477,7 +2480,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
 
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
@@ -2499,7 +2502,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, false);
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
@@ -2536,6 +2539,9 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	nvme_coredump_logs(dev);
+	nvme_coredump_complete(dev);
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
 		if (!dev->ctrl.opal_dev)
 			dev->ctrl.opal_dev =
@@ -2598,6 +2604,7 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	nvme_coredump_complete(dev);
 	nvme_remove_dead_ctrl(dev, result);
 }
 
@@ -2788,7 +2795,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
@@ -2800,7 +2807,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 }
 
 /*
@@ -2817,14 +2824,14 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, true, false);
 		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
@@ -2841,7 +2848,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_disable(ndev, true);
+	nvme_dev_disable(ndev, true, false);
 	return 0;
 }
 
@@ -3313,7 +3320,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
-- 
2.7.4

