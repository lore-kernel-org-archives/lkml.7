Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF5C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F021823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921517;
	bh=bPTlPH2rYRCi56/K0e6IaVB93IuksRjPjxYZGiewy/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VvBoBwFyIujELQeMbs+b1IglEFzmNH8as+MBpQOFUC4gOfPUqjwm5fufK4QNPdJp6
	 q4fzU9HMM6e2VpKdrUr+aiGPFa7QfUJlnjLx536e9/O2V3VTgaMunK91LLjjvAZyZp
	 GYTGcxJm4pJeY1QHh0mgd63tYNQIPAW99su+p8wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKPQZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfKPPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:10 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F89207FA;
        Sat, 16 Nov 2019 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918929;
        bh=bPTlPH2rYRCi56/K0e6IaVB93IuksRjPjxYZGiewy/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHe3//EQ/1SNGxor22kzmam5vcOebnSrY53VSA3jDRG98+BywzvSxuexnX2ehur45
         2FGbvA493+wfDfcxBmP8jbjqWPrxN8n4EKZa1M8iSGbjtbLl4/qptficvKyzAkdL5P
         nz+z0hJtmJBogyWb1sVtBG+kkILnkkotpOS/0BFY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 056/237] nvmet: avoid integer overflow in the discard code
Date:   Sat, 16 Nov 2019 10:38:11 -0500
Message-Id: <20191116154113.7417-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 8eacd1bd21d6913ec27e6120e9a8733352e191d3 ]

Although I'm not sure whether it is a good idea to support large discard
commands, I think integer overflow for discard ranges larger than 4 GB
should be avoided. This patch avoids that smatch reports the following:

drivers/nvme/target/io-cmd-file.c:249:1 nvmet_file_execute_discard() warn: should '((range.nlb)) << req->ns->blksize_shift' be a 64 bit type?

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 81a9dc5290a87..39d972e2595f0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -246,7 +246,8 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
+		len = le32_to_cpu(range.nlb);
+		len <<= req->ns->blksize_shift;
 		if (offset + len > req->ns->size) {
 			ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
 			break;
-- 
2.20.1

