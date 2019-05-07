Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B761CC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3D1208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daC1FLv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEGQ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:59:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38100 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfEGQ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:59:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id a59so8472563pla.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+izu/4NAQhuOqK71jybIxMy36M1jkAicxA/bCcXC8o=;
        b=daC1FLv2qV7ms0f53DCm1/ESSLNjYad3dx8z6Fn434ELLWYMBC20Hkv7lmiq7Ee1rw
         XXUSOqq0NSHXS+dhuIJCsdMpRnRt9mEZANysxRA9Lu1CQVN9vszHr7ZPGTTKEgo8ic00
         LeijExqB3ExTY1paGiidgFW3UcGWt9g+OeBSk4JkhRVGUppPNrIvzM4IJzgg4ffDBh4N
         wZt9wx4hAWD5fnxYyiJ0cIzifyQYSEOk6cNXfmXn0OczjiHpC5AAlsUxpctbMaNWiYQR
         RszKsujhBEtW8fzcO8tkFE87HA7PO8x6vulSDjxCh6Z69lGuQY86lumxgT2+yIemv1fR
         efYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+izu/4NAQhuOqK71jybIxMy36M1jkAicxA/bCcXC8o=;
        b=ZrwlbnsqzHRmGViKH4+pYaFbMkIPz/LaVbns5KMat/1KR0XFJNDTlEFxW9By2mhj/N
         gVq67mT4F+yCnJ9i428Yut2qkBFDmTsDeft0uiIl+R4s6fjRTqAljf6KFOjYh1Hj8Zy3
         ubHhXEO0QtFGEc2Z5tT845D51leS/e6VIaGAWxJKkKj83VXeaax2w9E8p2KVj8c+G04M
         gNIx6vFmZWH3GRLwTIfM0YvQBmstVeKQd7SCpoiEl62TZfj7SdBT7FOWU3qgJO0hejSq
         ehBs7xdGZiH57wD5AbvBL/7AxduP8Z4nWVokaYkYimalEOAYX6Nlxhyq9gpDXT7hkD68
         uRmg==
X-Gm-Message-State: APjAAAWczAp7DnP5gm3s6F5Sij37eeXkF6jZKdVGwGIrQhY0hCasjZhn
        vWZzycADfsdGBkMjTj70kas=
X-Google-Smtp-Source: APXvYqyg11zHHV0VT25um5kq05FEx9CIxdUeQSu1MM5NK+921+GDeWHyLR3vBtX8qBQVI9QuFfuYOg==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr40550818plk.41.1557248351802;
        Tue, 07 May 2019 09:59:11 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:59:10 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 7/7] nvme-pci: trigger device coredump on command timeout
Date:   Wed,  8 May 2019 01:58:34 +0900
Message-Id: <1557248314-4238-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
- Make coredump procedure into two phases (before resetting controller and
  after resetting as soon as admin queue is available).

 drivers/nvme/host/pci.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4684a86..4ff918f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -87,9 +87,12 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
+static int nvme_coredump_prologue(struct nvme_dev *dev);
+static void nvme_coredump_epilogue(struct nvme_dev *dev);
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -1289,7 +1292,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
@@ -1316,7 +1319,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	default:
@@ -1332,7 +1335,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
@@ -2399,7 +2402,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump)
 {
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2424,6 +2427,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	if (dump)
+		nvme_coredump_prologue(dev);
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
@@ -2491,7 +2497,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
 
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
@@ -2513,7 +2519,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, false);
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
@@ -2550,6 +2556,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	nvme_coredump_epilogue(dev);
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
 		if (!dev->ctrl.opal_dev)
 			dev->ctrl.opal_dev =
@@ -2612,6 +2620,7 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	nvme_coredump_epilogue(dev);
 	nvme_remove_dead_ctrl(dev, result);
 }
 
@@ -2802,7 +2811,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
@@ -2814,7 +2823,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 }
 
 /*
@@ -2831,14 +2840,14 @@ static void nvme_remove(struct pci_dev *pdev)
 
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
@@ -2855,7 +2864,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_disable(ndev, true);
+	nvme_dev_disable(ndev, true, false);
 	return 0;
 }
 
@@ -3307,7 +3316,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
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

