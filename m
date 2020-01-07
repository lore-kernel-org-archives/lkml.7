Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB76C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432437;
	bh=ETqOKsaKnFh8ubRIRwtRQ7OHO76XvlruOB9IQrzWWYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dz/F5T/V9sebxmWX6AL07JkNIoE6cKgUYL+g5UhWGLuNJdWDFvmjYGgFek39JJI8n
	 yI6bMIzqCUN95BY86e8Qhi9vce4FaMUKvabXq8xVxGlYCzJEHtv1MGi3DvaFSpfsX9
	 CixLc+eJSpiV+nixiBtTtUcj+P4DzHjTzOHQu/M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgAGU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgAGU55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF672187F;
        Tue,  7 Jan 2020 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430676;
        bh=ETqOKsaKnFh8ubRIRwtRQ7OHO76XvlruOB9IQrzWWYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPtrqoJBm2ccKK0Quey9JR/FaUgA2q6Ls4YTNcuHnhHzpmmuh93qPGKJ1KB3abE7y
         S0W3NDXuLifQVqkybVxtUP1M+QDrqb3wWmCRX0EekrDTiKGtoaS79HeuUcX030/bm4
         wDXxcy+k3sPwKKI4+o5YM3ZJhe08imTIhywpJ4HU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 012/191] nvme/pci: Fix write and poll queue types
Date:   Tue,  7 Jan 2020 21:52:12 +0100
Message-Id: <20200107205333.665301104@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 3f68baf706ec68c4120867c25bc439c845fe3e17 ]

The number of poll or write queues should never be negative. Use unsigned
types so that it's not possible to break have the driver not allocate
any queues.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 869f462e6b6e..29d7427c2b19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,14 +68,14 @@ static int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
-static int write_queues;
-module_param(write_queues, int, 0644);
+static unsigned int write_queues;
+module_param(write_queues, uint, 0644);
 MODULE_PARM_DESC(write_queues,
 	"Number of queues to use for writes. If not set, reads and writes "
 	"will share a queue set.");
 
-static int poll_queues;
-module_param(poll_queues, int, 0644);
+static unsigned int poll_queues;
+module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
 struct nvme_dev;
-- 
2.20.1



