Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5820C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73121849
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998604;
	bh=KB3ZG5huoXCKhZ5Eb8uLJzGK/TcrLdJqQfV8jXWk1kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6u2CaXRpN2t19FV7I4ePnfdMfCHl9KnAExT8QeYYjgnN0jWOE2Gxd+WHvkXTHIbx
	 NYGQdsKGQdUTc6Mj+4XgYS8T3mYbOxyI/nbvkRmGXNPrSmzrgHLps6K/veE5Zjy362
	 omBtSZ02rtsGLvCm+hz+Y+rR/Tt9jK8ku6pGtTpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405703AbfGXUDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392242AbfGXUDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23443214AF;
        Wed, 24 Jul 2019 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998599;
        bh=KB3ZG5huoXCKhZ5Eb8uLJzGK/TcrLdJqQfV8jXWk1kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEZ9E5aHCNdnsvw48/pLq24U5Iv8D7vXx4kiih5HvaOERUNr//iVVOtLRhoBt450r
         KF4BbElHoZmAnGZV9xw5i02h6gAgPvFAqAHu5PMDd9ORJaPUmjLpJPzTN9Ho8mkTP9
         ljbLIF2+zL98QGJ3KD0O46pk+YdfpEbH1e3r4OYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/271] s390/qdio: handle PENDING state for QEBSM devices
Date:   Wed, 24 Jul 2019 21:18:39 +0200
Message-Id: <20190724191659.430993680@linuxfoundation.org>
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
index 9c7d9da42ba0..4ac4a73037f5 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -749,6 +749,7 @@ static int get_outbound_buffer_frontier(struct qdio_q *q)
 
 	switch (state) {
 	case SLSB_P_OUTPUT_EMPTY:
+	case SLSB_P_OUTPUT_PENDING:
 		/* the adapter got it */
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr,
 			"out empty:%1d %02x", q->nr, count);
-- 
2.20.1



