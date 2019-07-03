Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C4C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4832187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGCXDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:03:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44168 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCXDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:03:40 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hioHq-0005uT-Bd; Wed, 03 Jul 2019 17:03:40 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hioHp-0005yG-7Y; Wed, 03 Jul 2019 17:03:37 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  3 Jul 2019 17:03:04 -0600
Message-Id: <20190703230304.22905-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703230304.22905-1-logang@deltatee.com>
References: <20190703230304.22905-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 2/2] nvmet-loop: Flush nvme_delete_wq when removing the port
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling nvme_loop_delete_ctrl(), the controllers will not
yet be deleted because nvme_delete_ctrl() only schedules work
to do the delete.

This means a race can occur if a port is removed but there
are still active controllers trying to access that memory.

To fix this, flush the nvme_delete_wq before returning from
nvme_loop_remove_port() so that any controllers that might
be in the process of being deleted won't access a freed port.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/loop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9e211ad6bdd3..da9cd07461fb 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -654,6 +654,14 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
 	mutex_lock(&nvme_loop_ports_mutex);
 	list_del_init(&port->entry);
 	mutex_unlock(&nvme_loop_ports_mutex);
+
+	/*
+	 * Ensure any ctrls that are in the process of being
+	 * deleted are in fact deleted before we return
+	 * and free the port. This is to prevent active
+	 * ctrls from using a port after it's freed.
+	 */
+	flush_workqueue(nvme_delete_wq);
 }
 
 static const struct nvmet_fabrics_ops nvme_loop_ops = {
-- 
2.20.1

