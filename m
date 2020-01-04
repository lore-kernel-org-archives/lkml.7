Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB54AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385F2464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578148311;
	bh=PhuOWElhjKCnbCvNeqkHt29zzw3T/k3hSoEVnkgtwag=;
	h=From:To:Subject:Date:List-ID:From;
	b=oLht+/yVilnHrxV08VP49v9H0IkfZAQZ3IPtgdSk78q2otGWfPztk2xr27RUeye6n
	 vF1XcnI1S4kYEU5WfGLjr8bN66u7PtrjrG1LGpgrMby1oGi54IAvNlzu37v99duJ5W
	 g2pspdGmyurL7Ln+mP2ZKpdDHbSHJ91vh2WlBwQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgADObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgADObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:31:50 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762442464E;
        Sat,  4 Jan 2020 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578148309;
        bh=PhuOWElhjKCnbCvNeqkHt29zzw3T/k3hSoEVnkgtwag=;
        h=From:To:Subject:Date:From;
        b=0foXrUEYUpwnxpbMFQgIgxztXnRLF31WZUfDuoWdtFv+SknA5mrsAH5fLCuuAfncG
         pM+SDz1awKcF55xS0M/OD1cTG6nCGT8dx3309dRSiqA7KUSqh96v+9lrE7FEyklsjc
         fngjSNYsZa8CfjZuTv6I9rXxAFqtBlinue7fNz4A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: wan: sdla: Fix cast from pointer to integer of different size
Date:   Sat,  4 Jan 2020 15:31:43 +0100
Message-Id: <20200104143143.6380-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since net_device.mem_start is unsigned long, it should not be cast to
int right before casting to pointer.  This fixes warning (compile
testing on alpha architecture):

    drivers/net/wan/sdla.c: In function ‘sdla_transmit’:
    drivers/net/wan/sdla.c:711:13: warning:
        cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Only compile tested
---
 drivers/net/wan/sdla.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/sdla.c b/drivers/net/wan/sdla.c
index e2e679a01b65..77ccf3672ede 100644
--- a/drivers/net/wan/sdla.c
+++ b/drivers/net/wan/sdla.c
@@ -708,7 +708,7 @@ static netdev_tx_t sdla_transmit(struct sk_buff *skb,
 
 					spin_lock_irqsave(&sdla_lock, flags);
 					SDLA_WINDOW(dev, addr);
-					pbuf = (void *)(((int) dev->mem_start) + (addr & SDLA_ADDR_MASK));
+					pbuf = (void *)(dev->mem_start + (addr & SDLA_ADDR_MASK));
 					__sdla_write(dev, pbuf->buf_addr, skb->data, skb->len);
 					SDLA_WINDOW(dev, addr);
 					pbuf->opp_flag = 1;
-- 
2.17.1

