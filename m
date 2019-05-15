Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE020578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921049;
	bh=TTSDQKNKsI+YnLpFlfOd/m8+9VodipYamSk6W3A3sAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wo8kaA6nqVB7ECkdV7UFyjWWXo5exz/NU0HyPgLQyDo1KBGVyJRG2MGZmxRsMkGRn
	 WEx+NYDb86FvTSg164ss0qB+d9vT4aH5h8wc7H7alyecYMWjM6x7htRnL4sa4aaQkN
	 uvIjuYbYdwuxLFJzKqtRLgwW4YXc04Nzd2A2LOiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfEOLur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbfEOLWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:22:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CCF2084F;
        Wed, 15 May 2019 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919325;
        bh=TTSDQKNKsI+YnLpFlfOd/m8+9VodipYamSk6W3A3sAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0Blw07xKw+epgI9fzrvcrbhHJTmAUh9ViVhC7TVwT6SGy57oh5N2VSBd7ro/c7oR
         L3t0RJBHcI+rO0m4YfCZgAOajYfLaNEPu7YJQOnDHobXJhiiCJ7GOfWvzllr/s77Sr
         batqmCj7dRxUcj0K4slT464NtZLxLbr4TjD4KDSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/113] vxge: fix return of a freed memblock on a failed dma mapping
Date:   Wed, 15 May 2019 12:55:22 +0200
Message-Id: <20190515090655.922886732@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0a2c34f18c94b596562bf3d019fceab998b8b584 ]

Currently if a pci dma mapping failure is detected a free'd
memblock address is returned rather than a NULL (that indicates
an error). Fix this by ensuring NULL is returned on this error case.

Addresses-Coverity: ("Use after free")
Fixes: 528f727279ae ("vxge: code cleanup and reorganization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index bf4302e45dcd9..28f7656647027 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -2365,6 +2365,7 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 				dma_object->addr))) {
 			vxge_os_dma_free(devh->pdev, memblock,
 				&dma_object->acc_handle);
+			memblock = NULL;
 			goto exit;
 		}
 
-- 
2.20.1



