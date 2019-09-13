Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022C5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1659208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfIMLQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:16:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:29021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfIMLQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:16:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 04:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336865395"
Received: from rbaldyga-mobl2.ger.corp.intel.com (HELO vm.ger.corp.intel.com) ([10.249.130.185])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 04:16:17 -0700
From:   Robert Baldyga <robert.baldyga@intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     michal.rakowski@intel.com,
        Robert Baldyga <robert.baldyga@intel.com>
Subject: [PATCH 2/2] nvme: add API for getting nsid by bdev
Date:   Fri, 13 Sep 2019 13:16:10 +0200
Message-Id: <20190913111610.9958-3-robert.baldyga@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913111610.9958-1-robert.baldyga@intel.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel API function for getting nvme namespace id.

Signed-off-by: Robert Baldyga <robert.baldyga@intel.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 include/linux/nvme.h     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 06f917f391c4..35d121cd2378 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -812,6 +812,20 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+int nvme_get_nsid_by_bdev(struct block_device *bdev, unsigned int *nsid)
+{
+	struct nvme_ns *ns;
+
+	if (!bdev && !nsid)
+		return -EINVAL;
+
+	ns = bdev->bd_disk->private_data;
+	*nsid = ns->head->ns_id;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_nsid_by_bdev);
+
 int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
 		struct nvme_command *c, void *buffer, unsigned int bufflen)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6f26c5654514..c54e210ad271 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1392,6 +1392,8 @@ struct nvme_completion {
 #define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
+int nvme_get_nsid_by_bdev(struct block_device *bdev, unsigned int *nsid);
+
 int nvme_submit_admin_cmd_by_bdev(struct block_device *bdev,
 		struct nvme_command *c, void *buffer, unsigned int bufflen);
 
-- 
2.17.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

