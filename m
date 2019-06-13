Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E729C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5706520644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443052;
	bh=DlpwBleIIcKgtQxcyOW6pRFed/ZSrSTlvi5kY49x9ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3uLovJg3DXjgHTfbIVK50AsRk9yy2LcEtbrM3MB+FiKguUeQ5Pfwuwf69LHOrfCk
	 iKY4v5CsyZ6bMppc/xsUidltxZ68U3vG8E285jlvjNLdnUFjIzT02nJXPTsjYFVkbl
	 RlfPoZs6QqL1Cl2wXm1OAMh8fIGl2Z7xFA5OAjIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbfFMQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731005AbfFMIh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8602064A;
        Thu, 13 Jun 2019 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415045;
        bh=DlpwBleIIcKgtQxcyOW6pRFed/ZSrSTlvi5kY49x9ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLgl+wpGfNnNGnFOoZDWo9+0SexIUGeEaffwjbZLflb53nMIFTzE6CsezFMN2x8j/
         GYGAntXiEUn0yhNLdd8ztPiuZFIw0+F4ecavLjqBMiu5PTnwh5UQCyt+PusqC/teg+
         l6ZsF6PW+0rwcfltHfQSz8+lqXGSX4D1/BOdvCsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/81] nvme-pci: unquiesce admin queue on shutdown
Date:   Thu, 13 Jun 2019 10:33:23 +0200
Message-Id: <20190613075652.298674865@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8e9e9b7646ebe1c5066ddc420d7630876277eb4 ]

Just like IO queues, the admin queue also will not be restarted after a
controller shutdown. Unquiesce this queue so that we do not block
request dispatch on a permanently disabled controller.

Reported-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06355ca832db..cd11cced3678 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2105,8 +2105,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * must flush all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
-	if (shutdown)
+	if (shutdown) {
 		nvme_start_queues(&dev->ctrl);
+		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+			blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
2.20.1



