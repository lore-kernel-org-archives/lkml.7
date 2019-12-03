Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F79C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A9207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412894;
	bh=HGoMbIUwGJLJFxfGybntghEW34hFVZUY+Ecadf8HQpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rLIJhg40XdDpe5muQLrH6dV5n8eB7EpVVAPrVCQbFJdE8jY/CImJidVekE1LmGd4n
	 k8/pV+cRdZv1LXso54LYGFpsmNw4qle3S2xGuwx6KK75wb+AQmDtVvDPDy3sFEjCIj
	 2vCLDONrd1cttmbsuPbqEmql0sxh/e8iOdmKqqrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfLCWld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfLCWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB516207DD;
        Tue,  3 Dec 2019 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412890;
        bh=HGoMbIUwGJLJFxfGybntghEW34hFVZUY+Ecadf8HQpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv0Wt+zieGkn2bNSvGGbNwyUWjH3LAI/u3yjgBgGVV5jxHHuHejae7BfOFmVmGa1z
         KdDLhuU0AfcWLrjR04QWvR5HW9N9nRrjrx1pg6BUEcVdfYNt3INck6r76qqwMkdy/k
         TO6vrC58XNa2eM6nybIWQ+xzGfnsOKDRkRyHW6fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 057/135] can: rx-offload: can_rx_offload_irq_offload_timestamp(): continue on error
Date:   Tue,  3 Dec 2019 23:34:57 +0100
Message-Id: <20191203213020.793997040@linuxfoundation.org>
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

From: Jeroen Hofstee <jhofstee@victronenergy.com>

[ Upstream commit c2a9f74c9d18acfdcabd3361adc7eac82c537a66 ]

In case of a resource shortage, i.e. the rx_offload queue will overflow
or a skb fails to be allocated (due to OOM),
can_rx_offload_offload_one() will call mailbox_read() to discard the
mailbox and return an ERR_PTR.

However can_rx_offload_irq_offload_timestamp() bails out in the error
case. In case of a resource shortage all mailboxes should be discarded,
to avoid an IRQ storm and give the system some time to recover.

Since can_rx_offload_irq_offload_timestamp() is typically called from a
while loop, all message will eventually be discarded. So let's continue
on error instead to discard them directly.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rx-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 3f5e040f0c712..2ea8676579a9c 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -216,7 +216,7 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 pen
 
 		skb = can_rx_offload_offload_one(offload, i);
 		if (IS_ERR_OR_NULL(skb))
-			break;
+			continue;
 
 		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
 	}
-- 
2.20.1



