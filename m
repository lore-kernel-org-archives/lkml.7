Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195F4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C4020848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413184;
	bh=v4pJDpuQCdRigiPbfE1gK/XbbYX/s8SxGZqFRVeCkUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+2DIMAMF2qJGnrl1YZh8sQ/CT+ybDuqrMk7hHD3ypfsrMM4622zc9QaW/TvkIqJZ
	 ipEOBST+xPVo1uH71n/LWa9gvOoXQNL42IwDWSQlGWwz6GyYFDwHbeUC539ElmxsNq
	 X9bEFXCC6dLZA08VZhPDm9gaUz+W4nGuQx1CAtKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfLCWqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfLCWqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:46:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2826520803;
        Tue,  3 Dec 2019 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413177;
        bh=v4pJDpuQCdRigiPbfE1gK/XbbYX/s8SxGZqFRVeCkUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjlwmiPRnOD8Jg57WxkSjr01WZRAeoK4OARxVSTpdc8YK9yRpwjRDCsFc6PbO9iYW
         ymu7KLeZxDLPiA8yO2uccUmyhtvvjN/DIPkkgmOyauR00ud0SCBkLQ7Hi4M6d4LsVC
         KklT20mkGShfdtFE1OeHGFzTK7G963/wAemNuZwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/321] can: rx-offload: can_rx_offload_queue_tail(): fix error handling, avoid skb mem leak
Date:   Tue,  3 Dec 2019 23:31:34 +0100
Message-Id: <20191203223428.582102977@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 6caf8a6d6586d44fd72f4aa1021d14aa82affafb ]

If the rx-offload skb_queue is full can_rx_offload_queue_tail() will not
queue the skb and return with an error.

This patch frees the skb in case of a full queue, which brings
can_rx_offload_queue_tail() in line with the
can_rx_offload_queue_sorted() function, which has been adjusted in the
previous patch.

The return value is adjusted to -ENOBUFS to better reflect the actual
problem.

The device stats handling is left to the caller.

Fixes: d254586c3453 ("can: rx-offload: Add support for HW fifo based irq offloading")
Reported-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rx-offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 6cf0d0bc1e8d6..a90005eac8b17 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -261,8 +261,10 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb)
 {
 	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max)
-		return -ENOMEM;
+	    offload->skb_queue_len_max) {
+		kfree_skb(skb);
+		return -ENOBUFS;
+	}
 
 	skb_queue_tail(&offload->skb_queue, skb);
 	can_rx_offload_schedule(offload);
-- 
2.20.1



