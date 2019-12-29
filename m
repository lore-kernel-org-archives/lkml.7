Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A9CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F392253D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640128;
	bh=ALFhbbApSdf4l2WXg7oZiq2+bihV32/+wcURhNG/0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nl5aA4Ee21B90WZ0tMGBULOBj8Mt+fersOxIbXDGe/OTFw/Ogd7tCrU9tLz4+0rYu
	 dh21mkA+euWejUs6kzGG7Mufweia8JmTZ4yRKNb5QB53PSmV3yt8U8L5Edca5ds/qB
	 wsYcrUQN6bvAH41hYLECjizeAjH0V1xFKqhqXm7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfL2RWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfL2RWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:22:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A7820CC7;
        Sun, 29 Dec 2019 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640122;
        bh=ALFhbbApSdf4l2WXg7oZiq2+bihV32/+wcURhNG/0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2saSYvQCmZ2HffOeRtFDC/7d9o3OvdVCsQnapDJ4by4EBxyAvX/q9TXrsb/wNrSsV
         Vs4ErSq15D+KgMWxVD35lDQNExxLq0n9BXlVQq6eS+cIz5VedZri5UyaSWEU36pysn
         wYNYm7WBNDYjsgRrDtiglk+5SX7hydVuUqIA3GfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Allen Pais <allen.pais@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/161] libertas: fix a potential NULL pointer dereference
Date:   Sun, 29 Dec 2019 18:17:55 +0100
Message-Id: <20191229162406.262885647@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>

[ Upstream commit 7da413a18583baaf35dd4a8eb414fa410367d7f2 ]

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index 39bf85d0ade0..c7f8a29d2606 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -1183,6 +1183,10 @@ static int if_sdio_probe(struct sdio_func *func,
 
 	spin_lock_init(&card->lock);
 	card->workqueue = alloc_workqueue("libertas_sdio", WQ_MEM_RECLAIM, 0);
+	if (unlikely(!card->workqueue)) {
+		ret = -ENOMEM;
+		goto err_queue;
+	}
 	INIT_WORK(&card->packet_worker, if_sdio_host_to_card_worker);
 	init_waitqueue_head(&card->pwron_waitq);
 
@@ -1234,6 +1238,7 @@ err_activate_card:
 	lbs_remove_card(priv);
 free:
 	destroy_workqueue(card->workqueue);
+err_queue:
 	while (card->packets) {
 		packet = card->packets;
 		card->packets = card->packets->next;
-- 
2.20.1



