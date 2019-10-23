Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD06CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E0121A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436574AbfJWQgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:36:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48572 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407307AbfJWQgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:36:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc4-0006Vt-8H; Wed, 23 Oct 2019 10:36:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc2-00016Y-La; Wed, 23 Oct 2019 10:35:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 23 Oct 2019 10:35:40 -0600
Message-Id: <20191023163545.4193-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/7] nvmet-tcp: Don't set the request's data_len
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not apprporiate for the transports to set the data_len
field of the request which is only used by the core.

In this case, just use a variable on the stack to store the
length of the sgl for comparison.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/tcp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 1e2d92f818ad..3378480c49f6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -813,13 +813,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
+	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
 	int ret;
 
-	/* recover the expected data transfer length */
-	req->data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
-
 	if (!nvme_is_write(cmd->req.cmd) ||
-	    req->data_len > cmd->req.port->inline_data_size) {
+	    data_len > cmd->req.port->inline_data_size) {
 		nvmet_prepare_receive_pdu(queue);
 		return;
 	}
-- 
2.20.1

