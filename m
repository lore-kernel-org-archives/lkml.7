Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD26C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5886D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414672;
	bh=VbReP7Qkbf3t3xJNhOIE20IUIgjrJJkVWaMD9BCNTDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVLJTTZltJaRU27IljMLlhhAQNY87UdgsxJvk2KgsOrQguo+JzGKUyYYpJLqAILhc
	 /NYBeWOE4M8FH73p3lEp+ED6JSrttBj9zRZ5TNc4IK7i+yHR9iM/JFh/J5ylTTqiUq
	 zM5h9dc1cc5KS2yjdf5PnGNynmLeloAKmmxe1xLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfLCWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfLCWlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68B82084B;
        Tue,  3 Dec 2019 22:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412885;
        bh=VbReP7Qkbf3t3xJNhOIE20IUIgjrJJkVWaMD9BCNTDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQDNCXplqanrNyczn6msiZuQdwNfI2L57OyRPSpAVD7ZJ2lDVXmmVYynf2R4Qm/Sd
         0uOwTsS+HE3nT/c6vRzfP70wPEJjEONE7d1b8sMP7dIt9V4h6xcXotw0894WTWOelX
         LMNBeqsJVOi7gH4zO40B4SHpgnxVT9tWw998MXrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 055/135] can: rx-offload: can_rx_offload_offload_one(): increment rx_fifo_errors on queue overflow or OOM
Date:   Tue,  3 Dec 2019 23:34:55 +0100
Message-Id: <20191203213020.458989998@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 4e9016bee3bf0c24963097edace034ff205b565c ]

If the rx-offload skb_queue is full or the skb allocation fails (due to OOM),
the mailbox contents is discarded.

This patch adds the incrementing of the rx_fifo_errors statistics counter.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rx-offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index bdc27481b57f9..e224530a06300 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -125,8 +125,10 @@ static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload
 
 		ret = offload->mailbox_read(offload, &cf_overflow,
 					    &timestamp, n);
-		if (ret)
+		if (ret) {
 			offload->dev->stats.rx_dropped++;
+			offload->dev->stats.rx_fifo_errors++;
+		}
 
 		return NULL;
 	}
-- 
2.20.1



