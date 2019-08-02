Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45B920665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740410;
	bh=fB2WSUjkbYwB+oO+NgmUDtNNu/P8tsF/bgX8F9W6VyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqckrU4fbXljlgsC9O+2FNOSTNVD8Q3BsOHJu20AiiNaYkd0IkHjipy7KcgNuXcpC
	 LOR8X7c27lKsKy4J3SIZJYHrgQicj59IQGYm3MGMCfhOTYsLEzIgVVFxat5tuDvmCa
	 EYk2Ep0UhIAi9Ign6RX8inIr7jm9ut9Z4ALB80J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbfHBKGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389621AbfHBJah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C8321773;
        Fri,  2 Aug 2019 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738236;
        bh=fB2WSUjkbYwB+oO+NgmUDtNNu/P8tsF/bgX8F9W6VyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az642VA+QddIeKZ9nYU9ree+1YPewxY50rnt43iLM+03Zc7ob811/ExWNeN5ndvSz
         nfBRv4r0UBvge0qezXDqoj47w8AGVNkC84txGzTSdsPPOFKcfrj+xArktlazjaoOzc
         sHspKZbPYk/NbxubUX1gkE4NJVA+6Bor+0a/JTYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/158] s390/qdio: handle PENDING state for QEBSM devices
Date:   Fri,  2 Aug 2019 11:27:26 +0200
Message-Id: <20190802092208.701766096@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04310324c6f482921c071444833e70fe861b73d9 ]

When a CQ-enabled device uses QEBSM for SBAL state inspection,
get_buf_states() can return the PENDING state for an Output Queue.
get_outbound_buffer_frontier() isn't prepared for this, and any PENDING
buffer will permanently stall all further completion processing on this
Queue.

This isn't a concern for non-QEBSM devices, as get_buf_states() for such
devices will manually turn PENDING buffers into EMPTY ones.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/qdio_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index d64b401f3d05..8d7fc3b6ca63 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -752,6 +752,7 @@ static int get_outbound_buffer_frontier(struct qdio_q *q)
 
 	switch (state) {
 	case SLSB_P_OUTPUT_EMPTY:
+	case SLSB_P_OUTPUT_PENDING:
 		/* the adapter got it */
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr,
 			"out empty:%1d %02x", q->nr, count);
-- 
2.20.1



