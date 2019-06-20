Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D6FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702E2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054534;
	bh=NjJ/4uuqZnv3/Az8pb2ngp8cd+vyciN0pchqZBP0SbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DVjIiJu03Pr0jgRtVEfqOW4BV4xiLpFVPvtV5OyCtoEuLJnPpN96E9z3FiNL6xR/s
	 80gEjZP5sVephT0x+TlNcnYByxO+NVSc4xGQq0VoJ4o6P/A6dANhDQwFMDM5DBkxdX
	 yf2UVyPlvsGi3QpUTH6UEhgF81m/dm4mXuyEz8Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfFTSPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfFTSPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC64F2082C;
        Thu, 20 Jun 2019 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054530;
        bh=NjJ/4uuqZnv3/Az8pb2ngp8cd+vyciN0pchqZBP0SbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmJ3vv3M1kqL7R92W7/dKK/+wMxykgmYbotzCSq+gpFCjZ3DppQpfjywvHTMbd955
         4JH9UW6vg5m9EXXxua6NVcX44L6gzVfAtF8Cy/JncxqrjKdF4eZFHaz9vpBS+gyzAh
         y4gO6mRfhmG0H9WzbDGy7ljYBos+9qamrr5AxhXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 61/98] net: aquantia: tx clean budget logic error
Date:   Thu, 20 Jun 2019 19:57:28 +0200
Message-Id: <20190620174352.152564588@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
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
index e2ffb159cbe2..bf4aa7060f1a 100644
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



