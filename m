Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F29120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498296;
	bh=k7CnPFN7GwwicI3kfUDsPK9j2FEwj2wKM5uIvLlDaIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4TIXdC1vG9qKmETI6xBYpM0/RkJu8+awaz5Hfyj3J68LhYzLx1MYZddxrWNQstxJ
	 //Rl6QQgr5X0wrUGD4Y7ahqr9+GWvidHZ8XhrXVmwx+H0soc4oxnZG0r7+yHMcQR7P
	 /SEBWMo6K39fdZAXnoAfiJGMH5jjtOc0QdLj1mlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfKKSvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfKKSv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:51:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E48204FD;
        Mon, 11 Nov 2019 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498288;
        bh=k7CnPFN7GwwicI3kfUDsPK9j2FEwj2wKM5uIvLlDaIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tp+ciXm8QF874S7wd10tGb7n2iEsljxo0ji533NtBOkUHUsHoJ7SLfvVSpXI4fpD4
         RITyLi8+QbO0AtMch6/cQ+I3buu0ChMD4iENtN35uBY5jpV1nOTbU9c9x4d60PtqcH
         GHFJHSj80F4Sxb+afZaySAV4tqwJs973X/SH0Dm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.3 078/193] can: dev: add missing of_node_put() after calling of_get_child_by_name()
Date:   Mon, 11 Nov 2019 19:27:40 +0100
Message-Id: <20191111181506.885222735@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit db9ee384f6f71f7c5296ce85b7c1a2a2527e7c72 upstream.

of_node_put() needs to be called when the device node which is got
from of_get_child_by_name() finished using.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -842,6 +842,7 @@ void of_can_transceiver(struct net_devic
 		return;
 
 	ret = of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
+	of_node_put(dn);
 	if ((ret && ret != -EINVAL) || (!ret && !priv->bitrate_max))
 		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
 }


