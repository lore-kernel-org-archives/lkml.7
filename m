Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C7522BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033261;
	bh=HVHYAs4JnrwG5NegSRAus12ZMc46mWLCWSvnS4Pd7pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjLMwRDaM/dtkt+AAMD2BJiGKKg3QriNfAyTpZ1RQ1kiOX2VFwguG/AYB1YWOSElo
	 dO//jQ1Hl/h+MhwCLcIB/yFSOqN5mqCdPg5G8eG1DJg25J1NmYMe3GsyZX70/1L//Q
	 5TkX8qQvNW7fYTgQVXkyw3Am6QxqazUjzPE93HCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390763AbfGYFk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390734AbfGYFk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:40:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC8822C7D;
        Thu, 25 Jul 2019 05:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033255;
        bh=HVHYAs4JnrwG5NegSRAus12ZMc46mWLCWSvnS4Pd7pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkkhXw99652MoxuTIu3IOQBkCwskVj66j4BLsBMDtRM5Vo25TxxKC5FXrficu5y1F
         nKVl/k9m8BaFHZkhE/IV7bN1+uQIyqP0bM1/9KpLSmt0Oe5qYh1uulms7NOomGCfyI
         taCs78pbx2nJ155YRyqZxClx4DNNpif8HJYh0jaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 146/271] Bluetooth: hci_bcsp: Fix memory leak in rx_skb
Date:   Wed, 24 Jul 2019 21:20:15 +0200
Message-Id: <20190724191707.703875330@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4ce9146e0370fcd573f0372d9b4e5a211112567c ]

Syzkaller found that it is possible to provoke a memory leak by
never freeing rx_skb in struct bcsp_struct.

Fix by freeing in bcsp_close()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 1a7f0c82fb36..66fe1e6dc631 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -759,6 +759,11 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
 
+	if (bcsp->rx_skb) {
+		kfree_skb(bcsp->rx_skb);
+		bcsp->rx_skb = NULL;
+	}
+
 	kfree(bcsp);
 	return 0;
 }
-- 
2.20.1



