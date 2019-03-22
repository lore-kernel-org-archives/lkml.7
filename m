Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FEC218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253686;
	bh=z3iwrOaU053s6NSTozFd7Da2hEqeZWuS1oZeG+QXA1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V53Xp0VJB1xLTGKRq7yDvTnssuhu0wVIOo7BCBRixUX42o+rg5rqARdfPypB0Vw3H
	 QFLL3seyBS0hNt5DAkz/kzwa9CZ1yz3Fu3Cp1swYGOD9DBdjIFrwTcSw0h/s00psCF
	 5wAyDkcnfIWOmh8C9zlF7In75oIO9XkLjOi5W/X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfCVLVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfCVLVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53950218A2;
        Fri, 22 Mar 2019 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253681;
        bh=z3iwrOaU053s6NSTozFd7Da2hEqeZWuS1oZeG+QXA1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPigH1pJdj9PkgRBLtPjTBNmhjGh0Tf/qczZm/BLwnsLvRc3CKNJq4dJ7fUbv8XU8
         rboNSkm+YBy7kPM1TetEOlh5U0hss9poZFoBjdcqJ/0g1nf5TXXfPQFHobnbr2JV/N
         t5TBQfZbMswOuEGLH7Og0+P8sa39YEgoR5wB8e4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kal Conley <kal.conley@dectris.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 021/134] net/packet: fix 4gb buffer limit due to overflow check
Date:   Fri, 22 Mar 2019 12:13:54 +0100
Message-Id: <20190322111211.399278611@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kal Conley <kal.conley@dectris.com>

[ Upstream commit fc62814d690cf62189854464f4bd07457d5e9e50 ]

When calculating rb->frames_per_block * req->tp_block_nr the result
can overflow. Check it for overflow without limiting the total buffer
size to UINT_MAX.

This change fixes support for packet ring buffers >= UINT_MAX.

Fixes: 8f8d28e4d6d8 ("net/packet: fix overflow in check for tp_frame_nr")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3894,7 +3894,7 @@ static int packet_set_ring(struct sock *
 		rb->frames_per_block = req->tp_block_size/req->tp_frame_size;
 		if (unlikely(rb->frames_per_block <= 0))
 			goto out;
-		if (unlikely(req->tp_block_size > UINT_MAX / req->tp_block_nr))
+		if (unlikely(rb->frames_per_block > UINT_MAX / req->tp_block_nr))
 			goto out;
 		if (unlikely((rb->frames_per_block * req->tp_block_nr) !=
 					req->tp_frame_nr))


