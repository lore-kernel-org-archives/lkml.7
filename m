Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D952089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfIMLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:16:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:29021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfIMLQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:16:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 04:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336865389"
Received: from rbaldyga-mobl2.ger.corp.intel.com (HELO vm.ger.corp.intel.com) ([10.249.130.185])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 04:16:15 -0700
From:   Robert Baldyga <robert.baldyga@intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     michal.rakowski@intel.com,
        Robert Baldyga <robert.baldyga@intel.com>
Subject: [PATCH 1/2] nvme: add API for sending admin commands by bdev
Date:   Fri, 13 Sep 2019 13:16:09 +0200
Message-Id: <20190913111610.9958-2-robert.baldyga@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913111610.9958-1-robert.baldyga@intel.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Rakowski <michal.rakowski@intel.com>

Add kernel API function for sending nvme admin commands.

Signed-off-by: Michal Rakowski <michal.rakowski@intel.com>
Signed-off-by: Robert Baldyga <robert.baldyga@intel.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/nvme.h     |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd6903..06f917f391c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -812,6 +812,29 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
+		struct nvme_command *c, void *buffer, unsigned int bufflen)
+{
+	struct nvme_ns *ns;
+	struct nvme_ctrl *ctrl;
+	int error;
+
+	if (!bdev && !c)
+		return -EINVAL;
+
+	ns = bdev->bd_disk->private_data;
+	ctrl = ns->ctrl;
+
+	error = nvme_submit_sync_cmd(ctrl->admin_q, c, buffer, bufflen);
+	if (error) {
+		dev_warn(ctrl->device, "Admin command failed (%d)\n", error);
+		return error;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(nvme_submit_admin_cmd_by_bdev);
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..6f26c5654514 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1392,4 +1392,7 @@ struct nvme_completion {
 #define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
+int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
+		struct nvme_command *c, void *buffer, unsigned int bufflen);
+
 #endif /* _LINUX_NVME_H */
-- 
2.17.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

