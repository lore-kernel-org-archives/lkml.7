Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B179207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641842;
	bh=jdNtSF3EYMlYf03kSIiNuT+bTGIm2CtTN/3ghGpQl1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=byL1MU2lp1RJHvVZOJ7uLy1cHP2r/The2QvASCuJ9BKhDQAvraA6bRG7ntpdzVwSB
	 V3josJuCBNy7G/t7WkfVO8lsXe3/l3FQAPBmSwQyMu1UwTp8Ib3nBTZCEBxqC8oJgc
	 qQovNbb8IDeTIJIclp4b/rRAHpKrbc/E8svj6+os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfL2Rul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfL2Rui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:50:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFADA208C4;
        Sun, 29 Dec 2019 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641838;
        bh=jdNtSF3EYMlYf03kSIiNuT+bTGIm2CtTN/3ghGpQl1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4BZDb39nUDjljQwtwWO26WdfMiHB1+NBgBIuG0YrDEFNDeEqNkZtK+rOoCQ7hIwG
         U61x3C6DSAHg1gb43JGzH9wM3aFM/rfpr+9u8oDYdb/1vPvkAYRdBxaUXQVhrL0Pbz
         JcSpbzs7Txd7RFE+d1oiIXfpZuZb6AAUkd47HdRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 230/434] nvme: introduce "Command Aborted By host" status code
Date:   Sun, 29 Dec 2019 18:24:43 +0100
Message-Id: <20191229172717.146191150@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit 2dc3947b53f573e8a75ea9cbec5588df88ca502e ]

Fix the status code of canceled requests initiated by the host according
to TP4028 (Status Code 0x371):
"Command Aborted By host: The command was aborted as a result of host
action (e.g., the host disconnected the Fabric connection)."

Also in a multipath environment, unless otherwise specified, errors of
this type (path related) should be retried using a different path, if
one is available.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 1 +
 include/linux/nvme.h          | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af3212aec871..b4e1e4379f1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -313,7 +313,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	if (blk_mq_request_completed(req))
 		return true;
 
-	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	blk_mq_complete_request(req);
 	return true;
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e0f064dcbd02..132ade51ee87 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -95,6 +95,7 @@ void nvme_failover_req(struct request *req)
 		}
 		break;
 	case NVME_SC_HOST_PATH_ERROR:
+	case NVME_SC_HOST_ABORTED_CMD:
 		/*
 		 * Temporary transport disruption in talking to the controller.
 		 * Try to send on a new path.
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f61d6906e59d..a260cd754f28 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1368,6 +1368,7 @@ enum {
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
+	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
 	NVME_SC_CRD			= 0x1800,
 	NVME_SC_DNR			= 0x4000,
-- 
2.20.1



