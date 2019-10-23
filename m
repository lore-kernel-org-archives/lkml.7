Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47120650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407293AbfJWQf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:35:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48544 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733188AbfJWQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:35:58 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc4-0006Vw-8G; Wed, 23 Oct 2019 10:35:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc2-00016h-UV; Wed, 23 Oct 2019 10:35:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 23 Oct 2019 10:35:43 -0600
Message-Id: <20191023163545.4193-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 5/7] nvmet: Introduce nvmet_dsm_len() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the nvmet_rw_len helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[logang@deltatee.com: separated out of a larger draft patch from hch]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/io-cmd-file.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..7481556da6e6 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -379,8 +379,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_file_execute_dsm;
-		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
-			sizeof(struct nvme_dsm_range);
+		req->data_len = nvmet_dsm_len(req);
 		return 0;
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c51f8dd01dc4..6ccf2d098d9f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -495,6 +495,12 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
+static inline u32 nvmet_dsm_len(struct nvmet_req *req)
+{
+	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
+		sizeof(struct nvme_dsm_range);
+}
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 
 /* Convert a 32-bit number to a 16-bit 0's based number */
-- 
2.20.1

