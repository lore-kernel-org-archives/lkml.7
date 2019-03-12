Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6442147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413404;
	bh=drPhLWY8XODTa1u9ahcQ1ouw7yyabgEGkJ8EXc9enns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uoapYvf4D5NkypSxi9UFYpfcQY1vkeYvnqAtRrTtmL5A7t+4Q+7xFKrtUTggkDZKu
	 E1e7poTVZT7SwbsTq3YsLsTiCWjHkzV/Bq2b/yqnz371kcjEb7dbE4dv87OOuTq5LY
	 vMwoCA9i+Uxb0DBOAH6iWthu6UsoHsANHF22iMWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfCLRNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbfCLRNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:20 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B338C2173C;
        Tue, 12 Mar 2019 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410799;
        bh=drPhLWY8XODTa1u9ahcQ1ouw7yyabgEGkJ8EXc9enns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smbBQP1oQlqvsvL9HzLuit2/2StCpodBof41YSRN0U4EuiGvb5HmBI7Jr1QCAKMud
         okEniJQQnTcls5EzH9W9mhQWNN5SybqgbLUYb7Uue1VI6MG2JZL4IOapCONoj0zDd0
         FR9T/euDGwU89HcNW67VbJhWQQwzz2aTcHmEkYG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 146/171] nvme-pci: add missing unlock for reset error
Date:   Tue, 12 Mar 2019 10:08:46 -0700
Message-Id: <20190312170400.169268829@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4726bcf30fad37cc555cd9dcd6c73f2b2668c879 ]

The reset work holds a mutex to prevent races with removal modifying the
same resources, but was unlocking only on success. Unlock on failure
too.

Fixes: 5c959d73dba64 ("nvme-pci: fix rapid add remove sequence")
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 439b9f4eb246..5c58e0ffa3ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2283,15 +2283,15 @@ static void nvme_reset_work(struct work_struct *work)
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
-		goto out;
+		goto out_unlock;
 
 	/*
 	 * Limit the max command size to prevent iod->sg allocations going
@@ -2374,6 +2374,8 @@ static void nvme_reset_work(struct work_struct *work)
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
+ out_unlock:
+	mutex_unlock(&dev->shutdown_lock);
  out:
 	nvme_remove_dead_ctrl(dev, result);
 }
-- 
2.19.1



