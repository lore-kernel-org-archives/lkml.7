Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0596420409
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640547;
	bh=ALFhbbApSdf4l2WXg7oZiq2+bihV32/+wcURhNG/0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKlPNGFz70x0TC2aIVAIfWCz+hkAQdbA4KbixR4vemZN7QEoRki+lJltQXz93+YS3
	 g9pJNBl6yfaAQW+Ckn8gNnyBdPBKGJtMpQ21kKCtMG4TJZLGHODEkbY/VOofFbq+R2
	 fVxDXqk/Bm+4CDUj7RdEuHgEo8S4acnF9W1mfO3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfL2R3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbfL2R3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:29:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37BB207FD;
        Sun, 29 Dec 2019 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640540;
        bh=ALFhbbApSdf4l2WXg7oZiq2+bihV32/+wcURhNG/0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fhbd7vsRqjcPfS3QMvcL7x4DHL1nNzIf5O+dxbf+Pm55kXh0+Ee6P9d5NRfJIlcso
         PtFWOcBv+vKVY3QfStd4UqwTgw4NVM//op0JCo/fjGzOo7WYuAJkpfmKercj3KOr9c
         P67nhzGV40wspwkYp1SXq+RnphmA8Dz18sKMPL6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Allen Pais <allen.pais@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/219] libertas: fix a potential NULL pointer dereference
Date:   Sun, 29 Dec 2019 18:17:18 +0100
Message-Id: <20191229162513.921126199@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
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



