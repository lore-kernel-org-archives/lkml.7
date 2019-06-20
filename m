Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E57C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1512084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054289;
	bh=DCfJvXUgoP1A8hfG9soHPyW+yo3f7SmIlNViB9KaVw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OcsiFmEhpZ5VmVYIHTFojyOt58B1GjoQpmpKTyqmhdNKPZ5YBXASjInQ6kWgiCb0g
	 JEbQIEMiB3DwnuS4/4D1YzufA74hzUe4HCB/hL/iUDemXIeT/JFvUbnUOdz4+gogaG
	 ZyRK4FmtF5Sb2xAywdVsUrHopiJeE+iPy5hSLcH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfFTSL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbfFTSLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:11:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383AE2082C;
        Thu, 20 Jun 2019 18:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054280;
        bh=DCfJvXUgoP1A8hfG9soHPyW+yo3f7SmIlNViB9KaVw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcQ3yXj4Qqqa5xNf3RvQnmogi7bNir7rJ5Qc1sNkfEtzNs6YIK7FVnML/tCX+r2p7
         bDIpQ5AYMrz3eFZXt89uJC5zkdY6NkRIkZK2HfMqLAY6l9GpyWt3j86DhR14mrsGS0
         r6j9CqPGaMLJ9nPf9wyWSnXYG6Br/IDkM6ajehKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/61] net: aquantia: tx clean budget logic error
Date:   Thu, 20 Jun 2019 19:57:30 +0200
Message-Id: <20190620174343.477478446@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 31bafc49a7736989e4c2d9f7280002c66536e590 ]

In case no other traffic happening on the ring, full tx cleanup
may not be completed. That may cause socket buffer to overflow
and tx traffic to stuck until next activity on the ring happens.

This is due to logic error in budget variable decrementor.
Variable is compared with zero, and then post decremented,
causing it to become MAX_INT. Solution is remove decrementor
from the `for` statement and rewrite it in a clear way.

Fixes: b647d3980948e ("net: aquantia: Add tx clean budget and valid budget handling logic")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 6f3312350cac..b3c7994d73eb 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -139,10 +139,10 @@ void aq_ring_queue_stop(struct aq_ring_s *ring)
 bool aq_ring_tx_clean(struct aq_ring_s *self)
 {
 	struct device *dev = aq_nic_get_dev(self->aq_nic);
-	unsigned int budget = AQ_CFG_TX_CLEAN_BUDGET;
+	unsigned int budget;
 
-	for (; self->sw_head != self->hw_head && budget--;
-		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
+	for (budget = AQ_CFG_TX_CLEAN_BUDGET;
+	     budget && self->sw_head != self->hw_head; budget--) {
 		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
 
 		if (likely(buff->is_mapped)) {
@@ -167,6 +167,7 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 
 		buff->pa = 0U;
 		buff->eop_index = 0xffffU;
+		self->sw_head = aq_ring_next_dx(self, self->sw_head);
 	}
 
 	return !!budget;
-- 
2.20.1



