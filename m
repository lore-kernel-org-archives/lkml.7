Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC8C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0847920722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640577;
	bh=xqW5sDxWkLviDKdFz4/dQ7a6lxvpbNy8KtKJb64JuGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjB3Wuwcj4NdwJ/gc1p7MJklBbfaCwFh6FWzPv4+rnLNX+A7W8Nx1Ntl0w7+JlMrH
	 0wDaPemDTdNOKeJ74f3KkXD/8+KwcVga0rc2waTObNk9zGH9HbGa0/P9qsmeRFn/C8
	 QC9PT+tASun55Uay0uwK93unSFIfyLmw5hACUzyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfL2R3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfL2R3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:29:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B180420409;
        Sun, 29 Dec 2019 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640571;
        bh=xqW5sDxWkLviDKdFz4/dQ7a6lxvpbNy8KtKJb64JuGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09SQRPtpMOQa3wGEtjW5Yq5Nw7ulhBnFAuxnWHXQ/9eOr2mFD8r1dkk8R1razNTp/
         9mbs8j7XcuZmZIjUEA5ySdXikb7H+LV6HJKqrzXMNRMUvOapKysrg8RmE+WE1umjJu
         MTYJIJrSlKCXOSXAlSN2myISVfgtr+sKsESCbtbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 010/219] qede: Disable hardware gro when xdp prog is installed
Date:   Sun, 29 Dec 2019 18:16:52 +0100
Message-Id: <20191229162510.564163154@linuxfoundation.org>
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

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 4c8dc00503db24deaf0b89dddfa84b7cba7cd4ce ]

commit 18c602dee472 ("qede: Use NETIF_F_GRO_HW.") introduced
a regression in driver that when xdp program is installed on
qede device, device's aggregation feature (hardware GRO) is not
getting disabled, which is unexpected with xdp.

Fixes: 18c602dee472 ("qede: Use NETIF_F_GRO_HW.")
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1362,6 +1362,7 @@ static int qede_alloc_mem_rxq(struct qed
 		rxq->rx_buf_seg_size = roundup_pow_of_two(size);
 	} else {
 		rxq->rx_buf_seg_size = PAGE_SIZE;
+		edev->ndev->features &= ~NETIF_F_GRO_HW;
 	}
 
 	/* Allocate the parallel driver ring for Rx buffers */
@@ -1406,6 +1407,7 @@ static int qede_alloc_mem_rxq(struct qed
 		}
 	}
 
+	edev->gro_disable = !(edev->ndev->features & NETIF_F_GRO_HW);
 	if (!edev->gro_disable)
 		qede_set_tpa_param(rxq);
 err:
@@ -1606,8 +1608,6 @@ static void qede_init_fp(struct qede_dev
 		snprintf(fp->name, sizeof(fp->name), "%s-fp-%d",
 			 edev->ndev->name, queue_id);
 	}
-
-	edev->gro_disable = !(edev->ndev->features & NETIF_F_GRO_HW);
 }
 
 static int qede_set_real_num_queues(struct qede_dev *edev)


