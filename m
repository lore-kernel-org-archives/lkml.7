Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF7C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B071920651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfGLWmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:42:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58840 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfGLWmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:42:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm4F5-00030h-4I; Fri, 12 Jul 2019 16:42:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm4F3-0005kX-9Q; Fri, 12 Jul 2019 16:42:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Fri, 12 Jul 2019 16:42:07 -0600
Message-Id: <20190712224207.22061-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, logang@deltatee.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvmet-file: fix nvmet_file_flush() always returning an error
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

errno_to_nvme_status() doesn't take into account the case
when errno=0, all other use cases only call it if there is actually
an error.

Presently, nvmet_file_flush() always returns a call to
errno_to_nvme_status() so, even if it is successful, it will
return NVME_SC_INTERNAL.

This bug was found while trying to get the existing blktests to pass.

Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..fec17c66b8cd 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -261,7 +261,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	int ret;
+
+	ret = vfs_fsync(req->ns->file, 1);
+	if (ret)
+		return errno_to_nvme_status(req, ret);
+
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
-- 
2.20.1

