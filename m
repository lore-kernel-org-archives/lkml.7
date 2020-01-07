Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1861DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65BF2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432500;
	bh=qXkXWon+vpJ0+yvohpa9KFWplyMU9gRUZh3Nw3PpWAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qc/SSXBernYed1YVvhXBxfjUqsWegimzizdGZT12duKqB6/xgrTHFb+0Vmi+/16eb
	 fklHrF/IFm/G0U8ldxNrQ0R9aRgVT9Uu8dQl9Z9Ws9Ax6YSMx2EswxtoI1o77slw96
	 606C4v9O5dCH1QJ9XtOjp8QCNwQ6sw2x18wkHZEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgAGU4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgAGU4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:56:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F6524677;
        Tue,  7 Jan 2020 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430603;
        bh=qXkXWon+vpJ0+yvohpa9KFWplyMU9gRUZh3Nw3PpWAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ua7+nq5MfKKHabLF0RG7slyAjX5K1Tme9RTbdhTtwb+mth6QDkVoyNH8Jx6bpXAfC
         rAXwApAXuWuLqZETibG/R0aFF8Stq51YjzRSkuX8i3BtojmLDddXqI0Zmvrpk0bbQM
         NDo/sRDHch49fLmcwLwGlDsat5n1rvvujgZz2k8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/191] nvme/pci: Fix read queue count
Date:   Tue,  7 Jan 2020 21:52:13 +0100
Message-Id: <20200107205333.718077864@linuxfoundation.org>
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

[ Upstream commit 7e4c6b9a5d22485acf009b3c3510a370f096dd54 ]

If nvme.write_queues equals the number of CPUs, the driver had decreased
the number of interrupts available such that there could only be one read
queue even if the controller could support more. Remove the interrupt
count reduction in this case. The driver wouldn't request more IRQs than
it wants queues anyway.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 29d7427c2b19..14d513087a14 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2060,7 +2060,6 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.priv		= dev,
 	};
 	unsigned int irq_queues, this_p_queues;
-	unsigned int nr_cpus = num_possible_cpus();
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one IO
@@ -2071,10 +2070,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		this_p_queues = nr_io_queues - 1;
 		irq_queues = 1;
 	} else {
-		if (nr_cpus < nr_io_queues - this_p_queues)
-			irq_queues = nr_cpus + 1;
-		else
-			irq_queues = nr_io_queues - this_p_queues + 1;
+		irq_queues = nr_io_queues - this_p_queues + 1;
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-- 
2.20.1



