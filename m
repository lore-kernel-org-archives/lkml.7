Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F3CC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBE20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122625;
	bh=9SO459Tx95hQLcr6M3fZdhK5p3dMn/Dz2ldcdyi20Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QadxOYk1HoYcfL2xWH5M0VEC/ASG1ZlRF2bkv85+fBcwbBdFb1S02C/qkpeYErJ9p
	 oTQjon6n88cqHNuzlWBXl44HfXCUwnOQSz5Jt1pqxJXekJn0ZGj2juwGO7orqKQ0f1
	 8CRSJ2Cq+F5ugKknKrNInapsUGvKwWmtOgQaIAiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391982AbfJCQdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390880AbfJCQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:33:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D34320830;
        Thu,  3 Oct 2019 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120389;
        bh=9SO459Tx95hQLcr6M3fZdhK5p3dMn/Dz2ldcdyi20Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b63VNdnBZNldewZPfA5xPVQritekO/WHznHhudjwoj+yFSL1C/bRUKsaMp2IxYtn/
         WY7bXCMJrdI5kJ4aILK0XlE1K4t+KTf0wofFWdtw5IMpWkSVPRjH3Z1wcOf6vbnqpk
         B+0PhK4+ujnB4nnJ0/plB8HctGSPqcCStG0dYBhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jinyu Qi <jinyuqi@huawei.com>, Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 166/313] iommu/iova: Avoid false sharing on fq_timer_on
Date:   Thu,  3 Oct 2019 17:52:24 +0200
Message-Id: <20191003154549.324600329@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0d87308cca2c124f9bce02383f1d9632c9be89c4 ]

In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
in queue_iova() was causing a performance loss and moved critical fields
so that the false sharing would not impact them.

However, avoiding the false sharing in the first place seems easy.
We should attempt the atomic_cmpxchg() no more than 100 times
per second. Adding an atomic_read() will keep the cache
line mostly shared.

This false sharing came with commit 9a005a800ae8
("iommu/iova: Add flush timer").

Signed-off-by: Eric Dumazet <edumazet@google.com>
Fixes: 9a005a800ae8 ('iommu/iova: Add flush timer')
Cc: Jinyu Qi <jinyuqi@huawei.com>
Cc: Joerg Roedel <jroedel@suse.de>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 3e1a8a6755723..41c605b0058f9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
 
 	spin_unlock_irqrestore(&fq->lock, flags);
 
-	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
+	/* Avoid false sharing as much as possible. */
+	if (!atomic_read(&iovad->fq_timer_on) &&
+	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
 		mod_timer(&iovad->fq_timer,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
-- 
2.20.1



