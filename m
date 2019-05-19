Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA0EC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E120578
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFPKUQZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfESRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:34:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfESRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:34:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so6038723pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=clJHY7KyFyDcM9FkV4yHc3Tj8r0uZgSu3tfBFo7C+aY=;
        b=KFPKUQZNtyglYSGyldyc0U0Pa14GqiTJrcbRXwVIjV6nQ8+y8qkBgdJCSBimIjltfq
         k5ra/g8y5IHzwWhPqMQlcFCiCjIVeRs3oxboogMipNXB0prlMqY7hI1UQmcUm7cOMC3g
         p6oL2Igq4PjUDdNsej1qxElqZJMSzEMtcE0GHHGGL2ih2xhxEUTOXlYWoFWW40fG+SAC
         Zs9BplhcuHu0kvEScraT+01B2ZG07BEkulX5LMU8neCXQXzzQ0B/wP0hVWltMmdhLue8
         7KhkM3OtmlBe4R5hi6GnTJeIDH2PMDivRXnZPpkV3fxQ+8z9Pox1I7Op9PWe2YSg62Tu
         52QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clJHY7KyFyDcM9FkV4yHc3Tj8r0uZgSu3tfBFo7C+aY=;
        b=Dw4yijgPE2Q+jHC5Up1DRzSHWneu0Z8BUXZVGQH6IWd/WV9E9egVo0Xn76h1ZC6Lgb
         Ce2xfMmGQs9ajvsvBN05Lpjzm6oOi1RZVfsYf9CxZJHYdnx0m2pkQaAsnKf0E94vCGAW
         rT0FIcF5kSkS2i1VmTTYWiXEwwYShBaHSffLE2gAI0DZwL2ut2pK3EqbV3iuTc4VP5Na
         SSF1BpqSEyFusH9bWNQxNx2p4N5uIMOHc3DbHX1H8hjpvOBAHuCxJM0KYwnWSxPL0h3x
         LDenRr8sw6cKSNJe9fLRw6cOluyWfDDG0jkYO8WzqodGddjhfwoCMunEZ8cm4pBJ9c8Q
         FPVw==
X-Gm-Message-State: APjAAAWMdPWC9xJf0VmfgbUI8KpnRkd38rt7ySk9ny086CaRrg7yvspC
        0/bw8dThr3aQ+Vd92iyoyZElQ92L
X-Google-Smtp-Source: APXvYqyDwgvW1xe02eBXhVjmNxyvJppF3skscKoM538q4GCNdvOPLkS7NGAZ4/Wz20SfFSzUTKwVvQ==
X-Received: by 2002:aa7:8b57:: with SMTP id i23mr54011253pfd.54.1558278452344;
        Sun, 19 May 2019 08:07:32 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:5085:bb4a:e3a8:fc9d])
        by smtp.gmail.com with ESMTPSA id g17sm2441105pfb.56.2019.05.19.08.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 08:07:31 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 6/7] nvme-pci: trigger device coredump on command timeout
Date:   Mon, 20 May 2019 00:06:57 +0900
Message-Id: <1558278418-5702-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
References: <1558278418-5702-1-git-send-email-akinobu.mita@gmail.com>
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- Abandon the reset if nvme_coredump_logs() returns error code

 drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8a29c52..6436e72 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -87,12 +87,12 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
-static void __maybe_unused nvme_coredump_init(struct nvme_dev *dev);
-static int __maybe_unused nvme_coredump_logs(struct nvme_dev *dev);
-static void __maybe_unused nvme_coredump_complete(struct nvme_dev *dev);
+static void nvme_coredump_init(struct nvme_dev *dev);
+static int nvme_coredump_logs(struct nvme_dev *dev);
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
@@ -1310,7 +1310,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, shutdown);
+		nvme_dev_disable(dev, shutdown, true);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	default:
@@ -1326,7 +1326,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
@@ -2536,6 +2539,11 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	result = nvme_coredump_logs(dev);
+	if (result)
+		goto out;
+	nvme_coredump_complete(dev);
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
 		if (!dev->ctrl.opal_dev)
 			dev->ctrl.opal_dev =
@@ -2598,6 +2606,7 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	nvme_coredump_complete(dev);
 	nvme_remove_dead_ctrl(dev, result);
 }
 
@@ -2788,7 +2797,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
@@ -2800,7 +2809,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 }
 
 /*
@@ -2817,14 +2826,14 @@ static void nvme_remove(struct pci_dev *pdev)
 
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
@@ -2841,7 +2850,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_disable(ndev, true);
+	nvme_dev_disable(ndev, true, false);
 	return 0;
 }
 
@@ -3290,7 +3299,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
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

